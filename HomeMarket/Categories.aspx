<%@ Page Title="Categories" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="HomeMarket.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <ol class="breadcrumb">
        <li><a href="/">Home</a></li>
        <li class="active">Categories</li>
    </ol>

    <div class="container-fluid">
        <asp:Repeater runat="server" ID="rptCategories">
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
                            <asp:LoginView id="AdminOptionsView" runat="server" ViewStateMode="Disabled">
                                <RoleGroups>
                                    <asp:RoleGroup Roles='admins'>
                                        <ContentTemplate>
                                            <p>
                                                <button type='button' class='btn btn-default btn-sm' data-toggle='modal' data-target='#editCategoryModal' data-id='<%#Eval("ID")%>'>Edit Category</button>
                                            </p>
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
                            var category=GetCategorieById(5);
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

</asp:Content>
