using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Common;
using WpfApp1.Model;
using System.Windows;

namespace WpfApp1.DbAccess
{
    internal class DbUser : DbAccessor<User>
    {
        protected DbConnection _conn;
        public DbUser(DbConnection conn) : base(conn)
        {
            _conn = conn;
        }

        public override void Create(User user)
        {
            using(var cmd = _conn.CreateCommand())
            {
                cmd.CommandText = $"INSERT INTO user (uname, email, pnumber, password, review, postalcode, city, streetHnum)" +
                                  $"VALUES ({user.Name}, {user.Phone}, {user.Password}, {user.Review}, {user.PostalCode}, {user.City}, {user.streetHnum});";
                if (cmd.ExecuteNonQuery() == 1) { MessageBox.Show("Sikeres adatbevitel"); }
            }
        } 
        
        public override User? Read(int id)
        {
            User? user = new User();
            using (var cmd = _conn.CreateCommand())
            {
                cmd.CommandText = $"SELECT uname, email, pnumber, review, postalcode, city, streetHnum FROM user WHERE uid={id};";
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        user = new User
                        {
                            Id = id,
                            Name = reader.GetString(1),
                            Email = reader.GetString(2),
                            Phone = reader.GetInt32(3),
                            Review = reader.GetFloat(4),
                            PostalCode = reader.GetInt32(5),
                            City = reader.GetString(6),
                            streetHnum = reader.GetString(7)
                        };
                    }
                }
            }

            return user;
        }

        public override IEnumerable<User> ReadAll()
        {
            List<User> result = new List<User>();
            using (var cmd = _conn.CreateCommand())
            {
                cmd.CommandText = "SELECT uid, uname, email, pnumber, password, review, postalcode, city, streetHnum FROM user;";
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        result.Add(new User
                        {
                            Id = reader.GetInt32(0),
                            Name = reader.GetString(1),
                            Email = reader.GetString(2),
                            Phone = reader.GetInt32(3),
                            Password = reader.GetString(4),
                            Review = reader.GetFloat(5),
                            PostalCode = reader.GetInt32(6),
                            City = reader.GetString(7),
                            streetHnum = reader.GetString(8)
                        });
                    }
                }
            }
            return result;
        }

        public override User Update(int id, User user)
        {
            using (var cmd = _conn.CreateCommand())
            {
                cmd.CommandText = $"UPDATE user " +
                                  $"SET uname={user.Name}, email={user.Email}, pnumber={user.Phone}, password={user.Password}, review={user.Review}, " +
                                  $"postalcode={user.PostalCode}, city={user.City}, streetHnum={user.streetHnum} " +
                                  $"WHERE uid={id};";
                if (cmd.ExecuteNonQuery() == 1) { MessageBox.Show("Sikeres adatfrissítés"); }
            }

            return Read(id);
        }

        public override bool Delete(int id)
        {
            User? user = Read(id);
            using (var cmd = _conn.CreateCommand())
            {
                cmd.CommandText = $"DELETE FROM user WHERE uid={id};";
                return (cmd.ExecuteNonQuery() == 1);
            }
        }
    }
}
