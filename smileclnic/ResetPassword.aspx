<%@ Page Title="Reset Password"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="ResetPassword.aspx.cs"
    Inherits="SmileClinic.ResetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="style/Login-SignupStyle.css" rel="stylesheet" />
    
    <div class="auth-page">
        <div class="auth-card">
            <div class="Form-header">
                <img src="img/logo.png" alt="SmileCare Logo" />
                <h2>Reset Password</h2>
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="message" />

            <asp:TextBox ID="txtEmail" runat="server" CssClass="inputBox auth-input" TextMode="Email" placeholder="Email" />
            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="inputBox auth-input" TextMode="Password" placeholder="New Password" />
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="inputBox auth-input" TextMode="Password" placeholder="Confirm Password" />

            <asp:Button ID="btnResetPassword" runat="server"
                Text="Reset Password"
                CssClass="btn btn-primary auth-btn"
                OnClick="btnResetPassword_Click" />
        </div>
    </div>
</asp:Content>