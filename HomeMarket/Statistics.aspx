<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="HomeMarket.Statistics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class='col-xs-8 col-sm-8 col-md-8 col-lg-8'>
            <ol class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li class="active">Statistics</li>
            </ol>
        </div>
        <div class='col-xs-4 col-sm-4 col-md-4 col-lg-4'>
            <div class="input-group">
                <span class="input-group-addon"></span>
                <input id="search" type="text" class="form-control" placeholder="Search...">
            </div>
        </div>
    </div>
    <h4>Order tracking statistics</h4>
        <asp:Repeater runat="server"
        ID="rp_orders">
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
            <tr class="searchable">
                <th><%# Eval("ID") %></th>
                <th><%# Eval("Date") %></th>
                <th><%# Eval("UserName") %></th>
                <th><%# Eval("ItemName") %></th>
                <th class="o_amount"><%# Eval("Amount") %></th>
                <th class="o_price">$<%# Eval("Price") %></th>
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
                                                    <th class="t_amount"></th>
                                                    <th class="t_price"></th>
                                                </tr>
                                            </tfoot>
            </table>     
                                            </div>
                                            </div>                                               
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">

        <%-- some client-side magics --%>
    <script type="text/javascript">
        // filter search
        $().ready(function () {
            CalcTotals();
        })

        $('#search').keyup(function () {

            var rex = new RegExp($(this).val(), 'i');
            $('.searchable').hide();
            $('.searchable').filter(function () {
                return rex.test($(this).text());
            }).show();
            CalcTotals();
        })

        function CalcTotals() {
            var total_amount = 0;
            var total_price = 0;

            $('.o_amount:visible').each(function () {
                total_amount += parseFloat($(this).text());
            });
            $('.t_amount').text(total_amount);

            $('.o_price:visible').each(function () {
                total_price += parseFloat($(this).text().replace('$','').replace(',','.'));
            });
            $('.t_price').text(('$'+total_price.toFixed(2)).replace('.',','));
        }
    </script>
</asp:Content>
