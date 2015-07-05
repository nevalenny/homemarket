<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="HomeMarket.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <nav>
        <ol class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li class="active">Manage account</li>
        </ol>
    </nav>

    <div class="form-horizontal">
        <div class="form-group">
            <div class="col-md-4">
                <asp:Label runat="server"
                    ID="lb_user_name"
                    CssClass="form-control">Your login is <strong><%# User.Identity.Name %></strong>.</asp:Label>
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-4">
                <asp:Label runat="server"
                    ID="lb_name"
                    CssClass="form-control">Your name is <strong><%# repository.User.Name %></strong>.</asp:Label>
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-4">
                <asp:Label runat="server"
                    ID="lb_balance"
                    CssClass="form-control">Your wallet balance is <strong><%# repository.User.WalletBalance.ToString() %></strong>.</asp:Label>
            </div>
        </div>
    </div>


    <section id="passwordForm">
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="message-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>


        <asp:PlaceHolder runat="server" ID="setPassword" Visible="false">
            <p>
                You do not have a local password for this site. Add a local
                password so you can log in without an external login.
            </p>
            <fieldset>
                <legend>Set Password Form</legend>
                <ol>
                    <li>
                        <asp:Label runat="server" AssociatedControlID="password">Password</asp:Label>
                        <asp:TextBox runat="server" ID="password" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="password"
                            CssClass="field-validation-error" ErrorMessage="The password field is required."
                            Display="Dynamic" ValidationGroup="SetPassword" />

                        <asp:ModelErrorMessage runat="server" ModelStateKey="NewPassword" AssociatedControlID="password"
                            CssClass="field-validation-error" SetFocusOnError="true" />

                    </li>
                    <li>
                        <asp:Label runat="server" AssociatedControlID="confirmPassword">Confirm password</asp:Label>
                        <asp:TextBox runat="server" ID="confirmPassword" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="confirmPassword"
                            CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The confirm password field is required."
                            ValidationGroup="SetPassword" />
                        <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="confirmPassword"
                            CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The password and confirmation password do not match."
                            ValidationGroup="SetPassword" />
                    </li>
                </ol>
                <asp:Button runat="server" Text="Set Password" ValidationGroup="SetPassword" OnClick="setPassword_Click" />
            </fieldset>
        </asp:PlaceHolder>

        <asp:PlaceHolder runat="server" ID="changePassword" Visible="false">
            <asp:ChangePassword runat="server" CancelDestinationPageUrl="~/Categories" RenderOuterTable="false" SuccessPageUrl="Manage?m=ChangeSuccess">
                <ChangePasswordTemplate>
                    <p class="validation-summary-errors">
                        <asp:Literal runat="server" ID="FailureText" />
                    </p>
                    <div class="form-horizontal">
                        <div class="form-group">
                            <div class="col-md-4">
                                <asp:TextBox runat="server"
                                    ID="CurrentPassword"
                                    CssClass="passwordEntry form-control" TextMode="Password" placeholder="Current password" required="" />
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-4">
                                <asp:TextBox runat="server"
                                    ID="NewPassword"
                                    type="password" data-minlength="6" CssClass="passwordEntry form-control" TextMode="Password" placeholder="New password" required="" />
                                <span class="help-block with-errors">Minimum of 6 chars</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-4">
                                <asp:TextBox runat="server"
                                    ID="ConfirmNewPassword"
                                    data-match="#NewPassword" data-match-error="Whoops, these don't match" CssClass="passwordEntry form-control" TextMode="Password" placeholder="Confirm password" required="" />
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-10">
                                <asp:Button runat="server" type="submit" CommandName="SaveChanges" Text="Change Password" ValidationGroup="ChangePassword" CssClass="btn btn-primary" />
                            </div>
                        </div>
                    </div>
                </ChangePasswordTemplate>
            </asp:ChangePassword>
        </asp:PlaceHolder>
    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script src="/Scripts/validator.js"></script>
    <script type="text/javascript">
        $().ready(function () {
            $('#ctl01').removeAttr('novalidate');
            $('#passwordForm').validator();
        })
    </script>
</asp:Content>
