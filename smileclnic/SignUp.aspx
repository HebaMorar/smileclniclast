<%@ Page Title="Signup"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Signup.aspx.cs"
    Inherits="SmileClinic.Signup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="style/Login-SignupStyle.css" rel="stylesheet" />
    
    <!-- تم إضافة الكلاس auth-page كحاوية كبرى للتوسيط والعزل -->
    <div class="auth-page">
        <div class="auth-card">
            <div class="Form-header">
                <img src="img/logo.png" alt="SmileCare Logo" />
                <h2>Sign Up</h2>
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="message" />

            <asp:TextBox ID="txtName" runat="server" CssClass="inputBox auth-input" placeholder="Name" />
            <asp:TextBox ID="txtEmail" runat="server" CssClass="inputBox auth-input" TextMode="Email" placeholder="Email" />
            <asp:TextBox ID="txtPassword" runat="server" CssClass="inputBox auth-input" TextMode="Password" placeholder="Password" />
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="inputBox auth-input" TextMode="Password" placeholder="Confirm Password" />
            
            <asp:Button ID="btnSignup" runat="server"
                Text="Sign Up"
                CssClass="btn btn-primary auth-btn"
                OnClick="btnSignup_Click" />
        </div>
    </div>
</asp:Content>