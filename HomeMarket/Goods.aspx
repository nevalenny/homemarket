<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Goods.aspx.cs" Inherits="HomeMarket.Goods" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <ol class="breadcrumb">
        <li><a href="/">Home</a></li>
        <li><a href="/Categories">Categories</a></li>
        <li class="active"><%: sCategoryName %></li>
    </ol>

    <div class="container-fluid">
        <asp:Repeater runat="server" ID="rptGoods">
            <HeaderTemplate>
                <div class='row'>
            </HeaderTemplate>
            <ItemTemplate>
                <div class='col-xs-6 col-sm-4 col-md-3 col-lg-3'>
                    <div class='thumbnail'>
                        <a href='/Categories/<%# Eval("ID") %>'>
                            <img src='data:image/png;base64,<%# Eval("Picture") %>' style='border: 1px solid #E6E6E6' />
                        </a>
                        <div class='caption'>
                            <a href='/Categories/<%# Eval("ID") %>'>
                                <h3><%# Eval("Name")%></h3>
                            </a>
                            <a href='/Categories/<%# Eval("ID") %>'>
                                <p><%# Eval("Description") %></p>
                            </a>
                            <asp:LoginView ID="AdminOptionsView" runat="server" ViewStateMode="Disabled">
                                <RoleGroups>
                                    <asp:RoleGroup Roles='admins'>
                                        <ContentTemplate>
                                            <p>
                                                <button type='button' class='btn btn-default btn-sm' data-toggle='modal' data-target='#editGoodModal' data-id='<%#Eval("ID")%>'>Edit</button>
                                                <button type='button' class='btn btn-danger btn-sm' data-toggle='modal' data-target='#deleteGoodModal' data-id='<%#Eval("ID")%>'>Delete</button>
                                            </p>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" disabled <%# Eval("isVisible").Equals(true)? "checked" : ""%>> Visible? </label>
                                            </div>
                                        </ContentTemplate>
                                    </asp:RoleGroup>
                                </RoleGroups>
                            </asp:LoginView>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>  <%--row--%>
            </FooterTemplate>
        </asp:Repeater>
    </div>


        <%--Admin modals--%>

    <asp:LoginView ID="AdminOptionsView" runat="server" ViewStateMode="Disabled">
        <RoleGroups>
            <asp:RoleGroup Roles='admins'>
                <ContentTemplate>


                    <!-- Edit Category Modal -->
                    <div class="modal fade" id="editGoodModal" tabindex="-1" role="dialog" aria-labelledby="editGoodModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="editGoodModalLabel">Edit Good</h4>
                                </div>
                                <div class="modal-body">
                                    <div class='thumbnail'>
                                        <%
                                            var good = GetGoodByID(1);
                                            Response.Write(String.Format(@"<img src='data:image/png;base64,{2}' style='border:1px solid #E6E6E6'/>
                              <div class='caption'>
                                <h3>{0}</h3>
                                <p>{1}</p>
                              </div>
                            </div>",
                                                 good.Name, good.Description, good.Picture, good.ID));
                                        %>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary">Save changes</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Category Modal -->
                    <div class="modal fade" id="deleteGoodModal" tabindex="-1" role="dialog" aria-labelledby="deleteGoodModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="deleteGoodModalLabel">Delete Good?</h4>
                                </div>
                                <div class="modal-body">
                                    <div class='thumbnail'>
                                        <%
                                            good = GetGoodByID(5);
                                            Response.Write(String.Format(@"<img src='data:image/png;base64,{2}' style='border:1px solid #E6E6E6'/>
                              <div class='caption'>
                                <h3>{0}</h3>
                                <p>{1}</p>
                              </div>
                            </div>",
                                                 good.Name, good.Description, good.Picture, good.ID));
                                        %>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                        <button type="button" class="btn btn-danger">Delete</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>

</asp:Content>
