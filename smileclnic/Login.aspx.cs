using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace SmileClinic
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please fill all fields";
                return;
            }

            string hashedPassword = Hash(password);

            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT Id, Name 
                                 FROM Users 
                                 WHERE Email = @Email AND Password = @Password";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = email;
                    cmd.Parameters.Add("@Password", SqlDbType.NVarChar).Value = hashedPassword;

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            Session["UserId"] = dr["Id"];
                            Session["UserName"] = dr["Name"].ToString();

                            Response.Redirect("Profile.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "Invalid email or password";
                        }
                    }
                }
            }
        }

        private string Hash(string input)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(input));

                StringBuilder sb = new StringBuilder();

                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));

                return sb.ToString();
            }
        }
    }
}