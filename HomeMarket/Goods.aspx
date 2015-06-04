<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Goods.aspx.cs" Inherits="HomeMarket.Goods" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <nav>
        <ol class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li><a href="/Categories">Categories</a></li>
            <li class="active"><%: sCategoryName %></li>
        </ol>
    </nav>
    <asp:Repeater runat="server" ID="rptGoods">
        <HeaderTemplate>
            <div class="container">
                <div class='row js-masonry' data-masonry-options='{ "columnWidth": ".col-lg-3", "itemSelector": ".col-lg-3", "percentPosition" : true}'>
                    <%if (iCategoryID != 0)
                      { %>
                    <asp:LoginView ID="AdminOptionsView" runat="server" ViewStateMode="Disabled">
                        <RoleGroups>
                            <asp:RoleGroup Roles='admins'>
                                <ContentTemplate>
                                    <div class='col-xs-12 col-sm-4 col-md-3 col-lg-3'>
                                        <p>
                                            <button type='button' class='btn btn-warning btn-lg btn-block' data-toggle='modal' data-target='#addGoodModal' data-id='-1'>Add item</button>
                                        </p>
                                    </div>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
                    <% } %>
        </HeaderTemplate>
        <ItemTemplate>
            <div class='col-xs-12 col-sm-4 col-md-3 col-lg-3'>
                <div class='thumbnail'>
                    <img src='data:image/png;base64,<%# Eval("Picture") %>' style='border: 1px solid #E6E6E6' />
                    <div class='caption'>
                        <h4><%# Eval("Name")%></h4>
                        <h5>Price: $<%# Eval("Price") %></h5>
                        <h5>Available: <%# Eval("Available")!=null && int.Parse(Eval("Available").ToString()) > 0 ? Eval("Available") : "" %>
                            <asp:LoginView runat="server" ViewStateMode="Disabled">
                                <LoggedInTemplate>
                                    <button type='button'
                                        class='btn btn-xs <%# Eval("Available")!=null && int.Parse(Eval("Available").ToString()) > 0 ? "btn-success" : "btn-default' disabled='disabled'" %>'
                                        data-id='<%#Eval("ID")%>'>
                                        <%# Eval("Available")!=null && int.Parse(Eval("Available").ToString()) > 0 ? "Add to cart" : "Not available" %>
                                    </button>
                                </LoggedInTemplate>
                            </asp:LoginView>
                        </h5>
                        <p><%# Eval("Description") %></p>
                        <asp:LoginView ID="AdminOptionsView" runat="server" ViewStateMode="Disabled">
                            <RoleGroups>
                                <asp:RoleGroup Roles='admins'>
                                    <ContentTemplate>
                                        <div class=""></div>
                                        <button type='button' class='btn btn-default btn-sm' data-toggle='modal' data-target='#editGoodModal' data-id='<%#Eval("ID")%>'>Edit</button>
                                        <button type='button' class='btn btn-danger btn-sm' data-toggle='modal' data-target='#deleteGoodModal' data-id='<%#Eval("ID")%>'>Delete</button>

                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" disabled <%# Eval("isVisible").Equals(true)? "checked" : ""%>>
                                                Visible?
                                            </label>
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
            </div> <%--container--%>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <%--Admin modals--%>

    <asp:LoginView ID="AdminOptionsView" runat="server" ViewStateMode="Disabled">
        <RoleGroups>
            <asp:RoleGroup Roles='admins'>
                <ContentTemplate>

                    <!-- Add Good Modal -->
                    <div class="modal fade" id="addGoodModal" tabindex="-1" role="dialog" aria-labelledby="addGoodModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="addGoodModalLabel">Add Item</h4>
                                </div>
                                <div class="modal-body">
                                    <div class='thumbnail'>
                                        <%
                                            var good = GetGoodByID(0);
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

                    <!-- Edit Category Modal -->
                    <div class="modal fade" id="editGoodModal" tabindex="-1" role="dialog" aria-labelledby="editGoodModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="editGoodModalLabel">Edit Item</h4>
                                </div>
                                <div class="modal-body">
                                    <div class='thumbnail'>
                                        <%
                                            good = GetGoodByID(1);
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
                                    <h4 class="modal-title" id="deleteGoodModalLabel">Delete Item?</h4>
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

    <script src="/Scripts/masonry.pkgd.min.js"></script>
</asp:Content>
