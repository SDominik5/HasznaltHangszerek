using Org.BouncyCastle.Crypto.Tls;
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
using MySql.Data.MySqlClient;
using System.Data;
using System.Data.Common;
using WpfApp1.Model;
using WpfApp1.DbAccess;
using ScottPlot;

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        const string _conn = "server=localhost;port=3306;uid=root;pwd=;database=hasznalthangszerek";
        List<object> users = new List<object>();
        List<object> orderds = new List<object>();

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
                    orderds.Add(order);
                }
            }

            Loaded += (s, e) =>
            {
                double[] dataX = { 1, 2, 3, 4, 5 };
                double[] dataY = { 1, 4, 9, 16, 25 };
                Chart.Plot.Add.Scatter(dataX, dataY);
                Chart.Refresh();
            };


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
            ListBoxCreate(orderds);
        }

        private void LBIStatistics_Selected(object sender, RoutedEventArgs e)
        {
            Refresh();

            

        }

        private void ListBoxCreate(List<object> listtype)
        {
            ListBox listbox = new ListBox();
            listbox.ItemsSource =listtype;
            
            Body.Children.Add(listbox);
        }

        private void Refresh()
        {
            Body.Children.Clear();
        }
    }
}