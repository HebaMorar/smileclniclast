using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmileClinic
{
    public partial class Appointment : Page
    {
        protected DateTime SelectedDate
        {
            get { return ViewState["SelectedDate"] != null ? (DateTime)ViewState["SelectedDate"] : DateTime.MinValue; }
            set { ViewState["SelectedDate"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadMonths();
                BindAppointments();
            }
        }

        protected void ddlDoctor_SelectedIndexChanged(object sender, EventArgs e)
        {
            SelectedDate = DateTime.MinValue;
            rptDays.DataSource = null;
            rptDays.DataBind();
            ddlTime.Items.Clear();

            Show("Please select a month and day for the new doctor.", "orange");
        }

        private void LoadMonths()
        {
            List<dynamic> months = new List<dynamic>();
            DateTime now = DateTime.Today;

            for (int i = 0; i < 3; i++)
            {
                var m = now.AddMonths(i);
                months.Add(new
                {
                    MonthName = m.ToString("MMMM yyyy"),
                    MonthValue = m.ToString("yyyy-MM-01")
                });
            }

            rptMonths.DataSource = months;
            rptMonths.DataBind();
        }

        protected void rptMonths_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (string.IsNullOrEmpty(ddlDoctor.SelectedValue))
            {
                Show("⚠️ Please select a doctor first before choosing a month.", "orange");
                return;
            }

            DateTime month = DateTime.Parse(e.CommandArgument.ToString());
            LoadDays(month);
        }

        private void LoadDays(DateTime month)
        {
            List<dynamic> days = new List<dynamic>();
            int count = DateTime.DaysInMonth(month.Year, month.Month);

            for (int i = 1; i <= count; i++)
            {
                DateTime fullDate = new DateTime(month.Year, month.Month, i);

                if (fullDate < DateTime.Today) continue;

                days.Add(new
                {
                    Day = i,
                    FullDate = fullDate.ToString("yyyy-MM-dd")
                });
            }

            rptDays.DataSource = days;
            rptDays.DataBind();
            ddlTime.Items.Clear();
        }

        protected void rptDays_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            SelectedDate = DateTime.Parse(e.CommandArgument.ToString());
            LoadTimes(SelectedDate);
        }

        private void LoadTimes(DateTime date)
        {
            ddlTime.Items.Clear();

            if (string.IsNullOrEmpty(ddlDoctor.SelectedValue))
            {
                Show("Please select a doctor first", "orange");
                return;
            }

            List<string> booked = new List<string>();
            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"
                    SELECT Time 
                    FROM Appointments 
                    WHERE Date=@Date AND Doctor=@Doctor AND Status != 'Cancelled'", con);

                cmd.Parameters.Add("@Date", SqlDbType.Date).Value = date.Date;
                cmd.Parameters.AddWithValue("@Doctor", ddlDoctor.SelectedValue);

                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        booked.Add(r["Time"].ToString().Trim());
                    }
                }
            }

            DateTime start = date.Date.AddHours(9);
            DateTime end = date.Date.AddHours(17);

            while (start <= end)
            {
                string timeValue = start.ToString("HH:mm");

                if (date.Date == DateTime.Today && start.TimeOfDay <= DateTime.Now.TimeOfDay)
                {
                    start = start.AddMinutes(30);
                    continue;
                }

                if (!booked.Contains(timeValue))
                {
                    ddlTime.Items.Add(new ListItem(start.ToString("hh:mm tt"), timeValue));
                }

                start = start.AddMinutes(30);
            }

            if (ddlTime.Items.Count == 0)
            {
                Show("No available time slots for this day.", "orange");
            }
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            int userId = (int)Session["UserId"];

            if (string.IsNullOrEmpty(txtPhone.Text) ||
                string.IsNullOrEmpty(ddlDoctor.SelectedValue) ||
                SelectedDate == DateTime.MinValue ||
                string.IsNullOrEmpty(ddlTime.SelectedValue))
            {
                Show("⚠️ Please fill all fields and select a date/time.", "orange");
                return;
            }

            string phone = txtPhone.Text.Trim();
            string doctor = ddlDoctor.SelectedValue;
            string timeValue = ddlTime.SelectedValue;
            string timeText = ddlTime.SelectedItem.Text;
            string email = "";

            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // ===== جلب إيميل المستخدم من قاعدة البيانات =====
                SqlCommand cmdEmail = new SqlCommand("SELECT Email FROM Users WHERE Id=@Id", con);
                cmdEmail.Parameters.AddWithValue("@Id", userId);
                var res = cmdEmail.ExecuteScalar();
                if (res != null) email = res.ToString().Trim();

                // ===== فحص عدد الحجوزات النشطة =====
                SqlCommand cmdCount = new SqlCommand(@"
                    SELECT COUNT(*) 
                    FROM Appointments 
                    WHERE UserId=@UserId AND Status NOT IN ('Cancelled', 'Completed')", con);

                cmdCount.Parameters.AddWithValue("@UserId", userId);
                int count = (int)cmdCount.ExecuteScalar();

                if (count >= 2)
                {
                    Show("❌ You can only book a maximum of 2 active appointments.", "red");
                    return;
                }

                // ===== فحص إذا كان الموعد محجوزاً مسبقاً للعيادة =====
                SqlCommand cmdCheck = new SqlCommand(@"
                    SELECT COUNT(*) 
                    FROM Appointments
                    WHERE Doctor=@Doctor AND Date=@Date AND Time=@Time AND Status != 'Cancelled'", con);

                cmdCheck.Parameters.AddWithValue("@Doctor", doctor);
                cmdCheck.Parameters.Add("@Date", SqlDbType.Date).Value = SelectedDate.Date;
                cmdCheck.Parameters.AddWithValue("@Time", timeValue);

                int exists = (int)cmdCheck.ExecuteScalar();
                if (exists > 0)
                {
                    Show("❌ هذا الموعد محجوز مسبقًا، يرجى اختيار وقت آخر.", "red");
                    return;
                }

                // ===== إدخال الموعد الجديد للـ Database =====
                SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO Appointments
                    (UserId, Doctor, Phone, Date, Time, Status)
                    VALUES (@UserId,@Doctor,@Phone,@Date,@Time,'Pending')", con);

                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@Doctor", doctor);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.Add("@Date", SqlDbType.Date).Value = SelectedDate.Date;
                cmd.Parameters.AddWithValue("@Time", timeValue);

                cmd.ExecuteNonQuery();
            }

            Show("🎉 Appointment booked successfully!", "green");
            BindAppointments();
            LoadTimes(SelectedDate);

            // تشغيل كود الـ EmailJS تلقائياً لإرسال تفاصيل الموعد للمريض
            string formattedDate = SelectedDate.ToString("dd/MM/yyyy");

            // تعديل Console.log لتصبح بحرف صغير c لكي يفسرها المتصفح بنجاح دون أخطاء
            string script = $@"
                setTimeout(function() {{
                    var ejs = window.emailjs || window['emailjs'];
                    if (typeof ejs !== 'undefined') {{
                        ejs.send('service_mh2u5pb', 'template_dwrfwas', {{
                            to_email: '{email}',
                            phone: '{phone}',
                            doctor: '{doctor}',
                            date: '{formattedDate}',
                            time: '{timeText}'
                        }}).then(function(res) {{
                            console.log('Email sent successfully!', res.status);
                        }}).catch(function(err) {{
                            console.log('Email delivery failed:', err);
                        }});
                    }}
                }}, 600);";

            ScriptManager.RegisterStartupScript(this, GetType(), "emailjs_booking", script, true);
        }

        private void BindAppointments()
        {
            int userId = (int)Session["UserId"];
            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT Id, Doctor, Date, Time, Status
                    FROM Appointments
                    WHERE UserId=@UserId
                    ORDER BY Date DESC, Time DESC", con);

                cmd.Parameters.AddWithValue("@UserId", userId);
                DataTable dt = new DataTable();
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    dt.Load(dr);
                }

                gvAppointments.DataSource = dt;
                gvAppointments.DataBind();
            }
        }

        protected void gvAppointments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CancelAppointment")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                int userId = (int)Session["UserId"];
                string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    SqlCommand cmdCheckDate = new SqlCommand("SELECT Date FROM Appointments WHERE Id=@Id", con);
                    cmdCheckDate.Parameters.AddWithValue("@Id", id);
                    var dateRes = cmdCheckDate.ExecuteScalar();

                    if (dateRes != null)
                    {
                        DateTime appointmentDate = Convert.ToDateTime(dateRes).Date;

                        if (appointmentDate <= DateTime.Today)
                        {
                            Show("❌ لا يمكنك إلغاء الموعد في نفس يوم الحجز أو بعده، يرجى التواصل مع العيادة هاتفياً.", "red");
                            return;
                        }
                    }

                    SqlCommand updateStatus = new SqlCommand(@"
                        UPDATE Appointments
                        SET Status = 'Cancelled'
                        WHERE Id=@Id AND UserId=@UserId", con);

                    updateStatus.Parameters.AddWithValue("@Id", id);
                    updateStatus.Parameters.AddWithValue("@UserId", userId);

                    updateStatus.ExecuteNonQuery();
                }

                Show("🗑️ Appointment cancelled successfully.", "orange");
                BindAppointments();

                if (SelectedDate != DateTime.MinValue)
                    LoadTimes(SelectedDate);
            }
        }

        private void Show(string msg, string statusColor)
        {
            lblMsg.Text = msg;
            lblMsg.Visible = true;

            if (statusColor == "green")
            {
                lblMsg.BackColor = System.Drawing.Color.FromName("rgba(74, 222, 128, 0.2)");
                lblMsg.ForeColor = System.Drawing.Color.FromName("#4ade80");
            }
            else if (statusColor == "red")
            {
                lblMsg.BackColor = System.Drawing.Color.FromName("rgba(248, 113, 113, 0.2)");
                lblMsg.ForeColor = System.Drawing.Color.FromName("#f87171");
            }
            else
            {
                lblMsg.BackColor = System.Drawing.Color.FromName("rgba(251, 191, 36, 0.2)");
                lblMsg.ForeColor = System.Drawing.Color.FromName("#fbbf24");
            }
        }
    }
}