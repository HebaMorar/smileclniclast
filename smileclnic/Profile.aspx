<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="SmileClinic.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- استدعاء ملف التنسيق الخاص بالبروفايل -->
    <link href="../Style/profile.css" rel="stylesheet" />

    <main class="profile-page">
        
        <!-- HEADER -->
        <section class="profile-header">
            <h2>Welcome, <asp:Label ID="lblUserName" runat="server"/></h2>
            <p>Manage your account information.</p>
            <div class="profile-actions">
                <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnSave_Click" Visible="false" />
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline" OnClick="btnLogout_Click" />
            </div>
        </section>

        <!-- USER INFORMATION -->
        <section class="profile-card">
            <div class="card-title">
                <h3>User Information</h3>
                <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="edit-btn" OnClick="btnEdit_Click"/>
            </div>
            
            <div class="profile-form">
                <div class="input-box">
                    <label>Full Name</label>
                    <asp:Label ID="lblName" runat="server" CssClass="profile-label-value"/>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Visible="false"/>
                </div>

                <div class="input-box">
                    <label>Email Address</label>
                    <asp:Label ID="lblEmail" runat="server" CssClass="profile-label-value"/>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Visible="false"/>
                </div>

                <div class="input-box">
                    <label>Phone Number</label>
                    <asp:Label ID="lblPhone" runat="server" CssClass="profile-label-value"/>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Visible="false"/>
                </div>
            </div>
        </section>

        <!-- PRESCRIPTIONS -->
        <section class="profile-card">
            <h3>My Prescriptions</h3>
            <asp:GridView ID="gvPrescriptions" runat="server" AutoGenerateColumns="false" CssClass="dash-grid" GridLines="None" EmptyDataText="No prescriptions yet.">
                <Columns>
                    <asp:BoundField DataField="Doctor" HeaderText="Doctor"/>
                    <asp:BoundField DataField="MedicationName" HeaderText="Medication"/>
                    <asp:BoundField DataField="Dosage" HeaderText="Dosage"/>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <!-- دمج كلاسات الـ Status الثابتة لتلوين الحالة ديناميكياً داخل الجدول -->
                            <span class='<%# (bool)Eval("IsDispensed") ? "status-confirmed" : "status-pending" %>'>
                                <%# (bool)Eval("IsDispensed") ? "Dispensed" : "Pending" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </section>

        <!-- TREATMENT PLAN -->
        <section class="profile-card">
            <h3>Treatment Plan</h3>
            <asp:GridView ID="gvTreatmentPlans" runat="server" AutoGenerateColumns="false" CssClass="dash-grid" GridLines="None" EmptyDataText="No treatment plans yet.">
                <Columns>
                    <asp:BoundField DataField="Doctor" HeaderText="Doctor"/>
                    <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis"/>
                    <asp:BoundField DataField="TreatmentSteps" HeaderText="Treatment Steps"/>
                    <asp:BoundField DataField="SessionsCount" HeaderText="Sessions"/>
                    <asp:BoundField DataField="EstimatedCost" HeaderText="Estimated Cost" DataFormatString="{0:C}"/>
                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}"/>
                </Columns>
            </asp:GridView>
        </section>

    </main>
</asp:Content>