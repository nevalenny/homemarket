<%@ Page Title="Categories" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="HomeMarket.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <ol class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li class="active">Categories</li>
        </ol>
        <asp:Repeater runat="server" ID="rptCategories">
            <HeaderTemplate>
                <div class='row js-masonry' data-masonry-options='{ "columnWidth": ".col-lg-3", "itemSelector": ".col-lg-3", "percentPosition" : true}'>
            </HeaderTemplate>
            <ItemTemplate>
                <div class='col-xs-12 col-sm-4 col-md-3 col-lg-3'>
                    <div class='thumbnail'>
                        <a href='/Goods/<%# Eval("ID") %>'>
                            <img src='data:image/png;base64,<%# Eval("Picture") %>' style='border: 1px solid #E6E6E6' />
                        </a>
                        <div class='caption'>
                            <a href='/Goods/<%# Eval("ID") %>'>
                                <h3><%# Eval("Name")%></h3>
                            </a>
                            <a href='/Goods/<%# Eval("ID") %>'>
                                <p><%# Eval("Description") %></p>
                            </a>
                            <asp:LoginView ID="AdminOptionsView" runat="server" ViewStateMode="Disabled">
                                <RoleGroups>
                                    <asp:RoleGroup Roles='admins'>
                                        <ContentTemplate>
                                            <button type='button' class='btn btn-default btn-sm' data-toggle='modal' data-target='#editCategoryModal' data-id='<%#Eval("ID")%>'>Edit</button>
                                            <button type='button' class='btn btn-danger btn-sm' data-toggle='modal' data-target='#deleteCategoryModal' data-id='<%#Eval("ID")%>'>Delete</button>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" disabled <%# Eval("isVisible").Equals(true)? "checked" : ""%>>Visible?</label>
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


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <%--Admin modals--%>

    <asp:LoginView ID="AdminOptionsView" runat="server" ViewStateMode="Disabled">
        <RoleGroups>
            <asp:RoleGroup Roles='admins'>
                <ContentTemplate>


                    <!-- Edit Category Modal -->
                    <div class="modal fade" id="editCategoryModal" tabindex="-1" role="dialog" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="editCategoryModalLabel">Edit Category</h4>
                                </div>
                                <div class="modal-body">
                                    <div class='thumbnail'>
                                        <%
                                            var category = GetCategorieById(5);
                                            Response.Write(String.Format(@"<img src='data:image/png;base64,{2}' style='border:1px solid #E6E6E6'/>
                              <div class='caption'>
                                <h3>{0}</h3>
                                <p>{1}</p>
                              </div>
                            </div>",
                                                 category.Name, category.Description, category.Picture, category.ID));
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
                    <div class="modal fade" id="deleteCategoryModal" tabindex="-1" role="dialog" aria-labelledby="deleteCategoryModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="deleteCategoryModalLabel">Delete Category?</h4>
                                </div>
                                <div class="modal-body">
                                    <div class='thumbnail'>
                                        <%
                                            category = GetCategorieById(5);
                                            Response.Write(String.Format(@"<img src='data:image/png;base64,{2}' style='border:1px solid #E6E6E6'/>
                              <div class='caption'>
                                <h3>{0}</h3>
                                <p>{1}</p>
                              </div>
                            </div>",
                                                 category.Name, category.Description, category.Picture, category.ID));
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