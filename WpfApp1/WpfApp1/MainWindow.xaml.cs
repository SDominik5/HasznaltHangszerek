using MySql.Data.MySqlClient;
using Org.BouncyCastle.Asn1.Cmp;
using Org.BouncyCastle.Crypto.Tls;
using ScottPlot;
using ScottPlot.WPF;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using WpfApp1.DbAccess;
using WpfApp1.Model;

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        const string _conn = "server=localhost;port=3306;uid=root;pwd=;database=hasznalthangszerek";
        List<object> users = new List<object>();
        List<object> orders = new List<object>();
        List<object> instruments = new List<object>();

        public MainWindow()
        {
            InitializeComponent();
            Loaded += MyWindowLoaded;
        }

        private void MyWindowLoaded(object sender, RoutedEventArgs e)
        {
            using (var conn = new MySqlConnection(_conn))
            {
                conn.Open();

                foreach (var user in new DbUser(conn).ReadAll())
                {
                    users.Add(user);
                }

                foreach (var order in new DbOrderInfo(conn).ReadAll())
                {
                    orders.Add(order);
                }
                foreach (var instrument in new DbInstrument(conn).ReadAll())
                {
                    instruments.Add(instrument);
                }
            }
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void btnMinimize_Click(object sender, RoutedEventArgs e)
        {
            this.WindowState = WindowState.Minimized;
        }

        private void LBIUsers_Selected(object sender, RoutedEventArgs e)
        {
            Refresh();
            ListBoxCreate(users);
        }

        private void LBIOrders_Selected(object sender, RoutedEventArgs e)
        {
            Refresh();
            ListBoxCreate(orders);
        }

        private void LBIStatistics_Selected(object sender, RoutedEventArgs e)
        {
            Refresh();

            Grid ChartField = new Grid();
            Grid.SetColumnSpan(ChartField, 2);
            Body.Children.Add(ChartField);

            WpfPlot wpfplot = new WpfPlot();
            Plot plot = wpfplot.Plot;


            double[] values = StatisticsByMonth().Select(x=>x.Value).ToArray();
            plot.Add.Bars(values);
            plot.Axes.Margins(bottom: 0);

            Tick[] ticks =
                    {
                        new(0, "Január"),
                        new(1, "Február"),
                        new(2, "Március"),
                        new(3, "Április"),
                        new(4, "Május"),
                        new(5, "Június"),
                        new(6, "Július"),
                        new(7, "Augusztus"),
                        new(8, "Szeptember"),
                        new(9, "Október"),
                        new(10, "November"),
                        new(11, "December")
                    };

            plot.Axes.Bottom.TickGenerator = new ScottPlot.TickGenerators.NumericManual(ticks);
            plot.Axes.Bottom.TickLabelStyle.Rotation = 45;
            plot.Axes.Bottom.TickLabelStyle.Alignment = Alignment.MiddleLeft;

            float largestLabelWidth = 0;
            using Paint paint = Paint.NewDisposablePaint();
            foreach (Tick tick in ticks)
            {
                PixelSize size = plot.Axes.Bottom.TickLabelStyle.Measure(tick.Label, paint).Size;
                largestLabelWidth = Math.Max(largestLabelWidth, size.Width);
            }

            plot.Axes.Bottom.MinimumSize = largestLabelWidth;
            plot.Axes.Right.MinimumSize = largestLabelWidth;

            ChartField.Children.Add(wpfplot);
        }

        private void ListBoxCreate(List<object> listtype)
        {
            ListBox listbox = new ListBox();
            listbox.ItemsSource = listtype;

            Body.Children.Add(listbox);
        }

        private void Refresh()
        {
            Body.Children.Clear();
        }

        public Dictionary<string, double> StatisticsByMonth()
        {
            Dictionary<string, double> results = new Dictionary<string, double>()
            {
                {"January", 0},
                {"Feburary", 0 },
                {"March", 0 },
                {"April", 0 },
                {"May", 0 },
                {"June", 0},
                {"July", 0},
                {"August", 0},
                {"September", 0 },
                {"October", 0},
                {"November", 0},
                {"December", 0}
            };
            Dictionary<string, double> readData = new Dictionary<string, double>();

            using (var conn = new MySqlConnection(_conn))
            {
                conn.Open();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"SELECT MONTHNAME(dateOfPurchase) as months, Count(*) FROM orderinfo GROUP BY months ORDER BY month(dateOfPurchase);";
                    using (var reader = cmd.ExecuteReader())
                    {
                        while(reader.Read())
                        {
                            readData.Add(reader.GetString(0), reader.GetInt32(1));
                        }
                    }
                }
            }

            foreach(var rky in results)
            {
                foreach (var rDky in readData)
                {
                    if (rky.Key == rDky.Key)
                    {
                        results[rky.Key] = rDky.Value;
                    }
                }
            }
            return results;
        }
    }
}