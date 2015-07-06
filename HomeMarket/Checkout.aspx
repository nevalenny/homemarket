<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Checkout.aspx.cs" Inherits="HomeMarket.Checkout" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Repeater runat="server"
        ID="rp_order">
        <HeaderTemplate>
            <div class="row">
                <div class="col-md-8">
                    <h4>Your order was:</h4>
                </div>
                <div class="col-md-12">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Qty<div class="danger"><%# isItemsRemoved?"*":"" %></div></th>
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
            <h5><div class="danger"><%# isItemsRemoved?"* some items were removed - not enough stock":"" %></div></h5>                                          
        </FooterTemplate>
    </asp:Repeater>
    <asp:Repeater runat="server"
        ID="rp_receipt">
        <HeaderTemplate>
            <hr />
            <%# !isNotEnoughMoney?
                "<div class='btn btn-success'>Your order was successful!</div><p>Thanks for shopping at <strong>HomeMarket</strong></p>":
                "<div class='btn btn-danger'>Your order was not successful!</div><p>Please check your wallet balance!</p>" %>
        </HeaderTemplate>
        <ItemTemplate>
               <h5>Order #<%# rp_receipt.Items.Count + 1 %> - tracking number: <%# Eval("OrderID") %></h5>

        </ItemTemplate>
        <FooterTemplate>
            <h5>Save those order numbers to track your order, or <asp:Button runat="server" Text="Print" CssClass="btn btn-primary" OnClientClick="print()"/></h5>
        </FooterTemplate>
    </asp:Repeater>
            <h4><a href="Categories">Continue shopping</a></h4>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
</asp:Content>
