<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="HomeMarket.Statistics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Order tracking statistics</h4>
        <asp:Repeater runat="server"
        ID="rp_orders" OnItemDataBound="rp_orders_ItemDataBound">
        <HeaderTemplate>
            <div class="row">                
                <div class="col-md-12">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>#ID</th>
                                <th>Date</th>
                                <th>User</th>
                                <th>Item name</th>
                                <th>Qty</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <th><%# Eval("ID") %></th>
                <th><%# Eval("Date") %></th>
                <th><%# Eval("UserName") %></th>
                <th><%# Eval("ItemName") %></th>
                <th><%# Eval("Amount") %></th>
                <th>$<%# Eval("Price") %></th>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody>
                                            <tfoot>
                                                <tr class="success">
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th>Total</th>
                                                    <th><%# iTotalCount %></th>
                                                    <th>$<%# dTotalSum %></th>
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
