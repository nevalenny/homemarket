<%@ Page Title="Categories" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="HomeMarket.Categories" %>

<%
    var HomeMarket.Models.category categories = GetCategories();

%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <ol class="breadcrumb">
        <li><a href="/">Home</a></li>
        <li class="active">Categories</li>
    </ol>

    <div class="container-fluid">
        <asp:Repeater ID="categories" runat="server">
            <HeaderTemplate>
                <div class='row'>
            </HeaderTemplate>
            <ItemTemplate>
                <div class='col-xs-12 col-sm-6 col-md-3 col-lg-3'>
                    <div class='thumbnail'>
                        <a href='/Categories/<%#Container.DataItem("ID")%>'>
                            <img src='data:image/png;base64,<%#Container.DataItem("Picture")%>' style='border: 1px solid #E6E6E6' /></a>
                        <div class='caption'>
                            <a href='/Categories/<%#Container.DataItem("ID")%>'>
                                <h3><%#Container.DataItem("Name")%></h3>
                            </a>
                            <a href='/Categories/<%#Container.DataItem("ID")%>'>
                                <p><%#Container.DataItem("Description")%></p>
                            </a>
                            <rolegroups>
                                <asp:RoleGroup Roles='admin'>
                                    <p>
                                        <button type='button' class='btn btn-default btn-sm' data-toggle='modal' data-target='#editCategoryModal' data-id='<%#Container.DataItem("ID")%>'>Edit Category</button></p>
                                </asp:RoleGroup>
                                </rolegroups>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>  <%--row--%>
            </FooterTemplate>
        </asp:Repeater>
        <div class='row'>
            <%
                            //                foreach (HomeMarket.Models.category category in GetCategories())
                            //                {
                            //                    Response.Write(String.Format(@"
                            //                          <div class='col-xs-12 col-sm-6 col-md-3 col-lg-3'>
                            //                            <div class='thumbnail'>
                            //                              <a href='/Categories/{3}'><img src='data:image/png;base64,{2}' style='border:1px solid #E6E6E6' /></a>
                            //                              <div class='caption'>
                            //                                <a href='/Categories/{3}'><h3>{0}</h3></a>
                            //                                <a href='/Categories/{3}'><p>{1}</p></a>
                            //                                <asp:RoleGroup Roles='admin'>
                            //                                    <p><button type='button' class='btn btn-default btn-sm' data-toggle='modal' data-target='#editCategoryModal' data-id='{3}'>Edit Category</button></p>
                            //                                </asp:RoleGroup>
                            //                              </div>
                            //                            </div>
                            //                        </div>",
                            //                        category.Name, category.Description, category.Picture, category.ID));
                            //                }
            %>
        </div>
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
                            foreach (HomeMarket.Models.category category in GetCategories())
                            {
                                //TODO - implement loading appropriate category data
                                if (category.ID == 1) Response.Write(String.Format(@"<img src='data:image/png;base64,{2}' style='border:1px solid #E6E6E6'/>
                              <div class='caption'>
                                <h3>{0}</h3>
                                <p>{1}</p>
                              </div>
                            </div>",
                                   category.Name, category.Description, category.Picture, category.ID));
                            }  
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
