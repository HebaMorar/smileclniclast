using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace SmileClinic
{
    public partial class Signup : System.Web.UI.Page
    {
        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string confirm = txtConfirmPassword.Text.Trim();

            if (pass != confirm)
            {
                lblMessage.Text = "Passwords do not match";
                return;
            }

            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // check email
                SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email=@Email", con);
                check.Parameters.AddWithValue("@Email", email);

                if ((int)check.ExecuteScalar() > 0)
                {
                    lblMessage.Text = "Email already exists";
                    return;
                }

                // hash password
                string hashed = Hash(pass);

                // insert
                SqlCommand insert = new SqlCommand(
                    "INSERT INTO Users (Name, Email, Password) VALUES (@Name,@Email,@Password)", con);

                insert.Parameters.AddWithValue("@Name", name);
                insert.Parameters.AddWithValue("@Email", email);
                insert.Parameters.AddWithValue("@Password", hashed);

                insert.ExecuteNonQuery();

                Response.Redirect("Login.aspx");
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