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

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        const string _conn = "server=localhost;port=3307;uid=root;pwd=;database=hasznalthangszerek";

        public MainWindow()
        {
            InitializeComponent();
            //Loaded += MyWindowLoaded;
        }

/*       private void MyWindowLoaded(object sender, RoutedEventArgs e)
        {
            using(var conn = new MySqlConnection(_conn))
            {
                conn.Open();
                List<User> users = new List<User>();
                foreach (var user in new DbUser(conn).ReadAll())
                {
                    users.Add(user);
                }

            }
        }*/

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
        private void btnMinimize_Click(object sender, RoutedEventArgs e)
        {
            this.WindowState = WindowState.Minimized;
        }
    }
}