<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Checkout.aspx.cs" Inherits="HomeMarket.Checkout" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Repeater runat="server"
        ID="rp_order">
        <HeaderTemplate>
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Qty</th>
                            </tr>
                        </thead>
                        <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <th><%# rp_order.Items.Count + 1 %></th>
                <th><%# Eval("Good.Name") %></th>
                <th>$<%# Eval("Good.Price") %></th>
                <th><%# Eval("Quantity") %></th>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody>
                                            <tfoot>
                                                <tr class="success">
                                                    <th></th>
                                                    <th>Total</th>
                                                    <th>$<%# dTotalSum %></th>
                                                    <th><%# iTotalCount %></th>
                                                </tr>
                                            </tfoot>
            </table>     
                                            </div>
                                            </div>                                               
        </FooterTemplate>
    </asp:Repeater>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
</asp:Content>
