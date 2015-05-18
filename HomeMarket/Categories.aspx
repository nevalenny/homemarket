<%@ Page Title="Categories" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="HomeMarket.Categories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
        <div>
            <%
                foreach (HomeMarket.Models.category category in GetCategories())
                {
                    Response.Write(String.Format(@"
                        <div class='row'>
                          <div class='col-sm-2 col-md-2'>
                            <div class='thumbnail'>
                              <img src='data:image/png;base64,{2}' style='border:1px solid #E6E6E6'/>
                              <div class='caption'>
                                <h3>{0}</h3>
                                <p>{1}</p>
                                <p><button type='button' class='btn btn-primary btn-lg' data-toggle='modal' data-target='#editCategoryModal' data-id='{3}'>Edit Category</button></p>
                              </div>
                            </div>
                          </div>
                        </div>",
                        category.Name, category.Description, category.Picture, category.ID));
                }
            %>
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
                        if(category.ID==1) Response.Write(String.Format(@"<img src='data:image/png;base64,{2}' style='border:1px solid #E6E6E6'/>
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
