<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs"
    Inherits="SmileClinic.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Google Fonts & Font Awesome -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <link rel="stylesheet" href="../Style/admindashboard.css" />
  
    <a href="indexHome.aspx" class="home-fixed-btn" title="Back to Home">
    <i class="fas fa-home"></i> 
</a>
    <div class="dashboard-wrapper">

        <!-- ===== HEADER ===== -->
        <div class="dashboard-header">
            <i class="fas fa-chart-pie"></i>
            <h1 class="dashboard-title">
                Admin Dashboard
                <small><i class="fas fa-shield-alt" style="margin-right: 4px;"></i> Secure Management Panel</small>
            </h1>
        </div>

        <!-- ===== رسالة التنبيه (نفس المعرف) ===== -->
        <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert" ClientIDMode="Static" />

        <!-- ===== TABS ===== -->
        <div class="tab-bar">
            <button class="tab-btn" onclick="showTab('users', this)">
                <i class="fas fa-users"></i> Users
            </button>
            <button class="tab-btn" onclick="showTab('messages', this)">
                <i class="fas fa-envelope"></i> Messages
            </button>
            <button class="tab-btn" onclick="showTab('pharmacy', this)">
                <i class="fas fa-prescription-bottle"></i> Pharmacy
            </button>
        </div>

        <!-- ===== USERS TAB ===== -->
        <div id="users" class="tab-content">
            <h3><i class="fas fa-users-cog"></i> All Users</h3>
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="false" CssClass="dash-grid">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                </Columns>
            </asp:GridView>
        </div>

        <!-- ===== MESSAGES TAB ===== -->
        <div id="messages" class="tab-content">
            <h3><i class="fas fa-inbox"></i> Contact Messages</h3>
            <asp:GridView ID="gvMessages" runat="server" AutoGenerateColumns="false" CssClass="dash-grid">
                <Columns>
                    <asp:BoundField DataField="Fullname" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Message" HeaderText="Message" />
                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" />
                </Columns>
            </asp:GridView>
        </div>

        <!-- ===== PHARMACY TAB ===== -->
        <div id="pharmacy" class="tab-content">
            <h3><i class="fas fa-plus-circle"></i> Add Prescription</h3>
            <div class="pharmacy-form">
                <label for="ddlAppointments">Select Appointment:</label>
                <asp:DropDownList ID="ddlAppointments" runat="server" CssClass="form-control" />

                <label for="txtMedName">Medication Name:</label>
                <asp:TextBox ID="txtMedName" runat="server" CssClass="form-control" Placeholder="e.g. Amoxicillin 500mg" />

                <label for="txtDosage">Dosage Instructions:</label>
                <asp:TextBox ID="txtDosage" runat="server" CssClass="form-control" Placeholder="e.g. Twice daily after meals" />

                <asp:Button ID="btnAddPrescription" runat="server" Text="Add Prescription"
                    CssClass="btn-primary" OnClick="btnAddPrescription_Click" />
            </div>

            <h3 style="margin-top: 2rem; font-weight: 700; color: var(--primary-dark);">
                <i class="fas fa-list-ul" style="color: var(--primary); margin-right: 0.5rem;"></i>
                All Prescriptions
            </h3>
            <asp:GridView ID="gvPrescriptions" runat="server" AutoGenerateColumns="false"
                CssClass="dash-grid" OnRowCommand="gvPrescriptions_RowCommand" DataKeyNames="Id">
                <Columns>
                    <asp:BoundField DataField="PatientName" HeaderText="Patient" />
                    <asp:BoundField DataField="Doctor" HeaderText="Doctor" />
                    <asp:BoundField DataField="MedicationName" HeaderText="Medication" />
                    <asp:BoundField DataField="Dosage" HeaderText="Dosage" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# Eval("IsDispensed").ToString() == "True" ? "status-confirmed" : "status-pending" %>'>
                                <%# Eval("IsDispensed").ToString() == "True" ? "Dispensed" : "Pending" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Dispense" CommandArgument='<%# Eval("Id") %>'
                                CssClass="btn-confirm" Text="✔ Mark Dispensed"
                                Visible='<%# !(bool)Eval("IsDispensed") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

    </div>

    <!-- ===== JAVASCRIPT (نفس الكود مع تحسينات طفيفة) ===== -->
    <script>
// @ts-nocheck
function showTab(name, btn) {
    if (!name || !btn) return;

    document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active-tab'));
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));

    const content = document.getElementById(name);
    if (content) {
        content.classList.add('active-tab');
    }

    btn.classList.add('active');
    localStorage.setItem('activeTab', name);
}

window.onload = function () {
    var savedTab = localStorage.getItem('activeTab');
    if (savedTab) {
        var content = document.getElementById(savedTab);
        var btns = document.querySelectorAll('.tab-btn');

        document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active-tab'));
        btns.forEach(b => b.classList.remove('active'));

        if (content) content.classList.add('active-tab');

        btns.forEach(function (b) {
            var onclickAttr = b.getAttribute('onclick');
            if (onclickAttr && savedTab && onclickAttr.includes(String(savedTab))) {
                b.classList.add('active');
            }
        });
    }

    var msg = document.getElementById('lblMsg');
    if (msg && msg.innerText && msg.innerText.trim() !== '') {
        msg.style.display = 'block';
        setTimeout(function () {
            if (msg) msg.style.display = 'none';
        }, 4000);
    }
};
</script>

</asp:Content>