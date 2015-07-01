<%@ Page Title="Categories" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Categories.aspx.cs" Inherits="HomeMarket.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server" />

    <div class="row">
        <div class='col-xs-8 col-sm-8 col-md-8 col-lg-8'>
            <ol class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li class="active">Categories</li>
            </ol>
        </div>
        <div class='col-xs-4 col-sm-4 col-md-4 col-lg-4'>
            <div class="input-group">
                <span class="input-group-addon"></span>
                <input id="search" type="text" class="form-control" placeholder="Search...">
            </div>
        </div>
    </div>

    <asp:Repeater runat="server" ID="rpt_categories" OnItemCommand="rpt_categories_ItemCommand">
        <HeaderTemplate>
            <div class="container">
                <div class='row js-masonry' data-masonry-options='{ "columnWidth": ".col-lg-3", "itemSelector": ".col-lg-3", "percentPosition" : true}'>
                    <asp:LoginView ID="lv_admin_options1" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles='admins'>
                                <ContentTemplate>
                                    <div class='col-xs-12 col-sm-4 col-md-3 col-lg-3'>
                                        <p>
                                            <asp:Button ID="btn_add"
                                                runat="server"
                                                AutoPostBack="false"
                                                OnInit="btn_add_Init"
                                                type='button'
                                                class='btn btn-warning btn-lg btn-block'
                                                data-toggle='modal'
                                                data-target='#addCategoryModal'
                                                Text="Add category" />
                                        </p>
                                    </div>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
        </HeaderTemplate>
        <ItemTemplate>
            <div class='col-xs-12 col-sm-4 col-md-3 col-lg-3 searchable'>
                <div class='thumbnail'>
                    <a href='/Goods/<%# Eval("ID") %>'>
                        <img src='<%# Eval("Picture") %>' style='width: 108px; height: 108px; border: 1px solid #E6E6E6' />
                    </a>
                    <div class='caption'>
                        <a href='/Goods/<%# Eval("ID") %>'>
                            <h3><%# Eval("Name")%></h3>
                        </a>
                        <p><%# Eval("Description") %></p>
                        <asp:LoginView ID="lv_admin_options2" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles='admins'>
                                    <ContentTemplate>
                                            <asp:Button ID="btn_edit_category"
                                                OnInit="btn_edit_category_Init"
                                                CommandName="EditCategory"
                                                CommandArgument='<%# Eval("ID") %>'
                                                AutoPostBack="false"
                                                Text="Edit"
                                                type='button'
                                                class='btn btn-default btn-sm'
                                                data-toggle='modal'
                                                data-target='#editCategoryModal'
                                                runat="server" />
                                            <asp:Button ID="btn_delete_category"
                                                OnInit="btn_delete_category_Init"
                                                CommandName="DeleteCategory"
                                                CommandArgument='<%# Eval("ID") %>'
                                                AutoPostBack="false"
                                                Text="Delete"
                                                type='button'
                                                class='btn btn-danger btn-sm'
                                                data-toggle='modal'
                                                data-target='#deleteCategoryModal'
                                                runat="server" />
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" disabled <%# Eval("isVisible").Equals(true)? "checked" : ""%>>Show?</label>
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
                </div>  <%--container--%>
        </FooterTemplate>
    </asp:Repeater>



    <%--Admin modals--%>
    <asp:LoginView ID="lv_modals" runat="server">
        <RoleGroups>
            <asp:RoleGroup Roles='admins'>
                <ContentTemplate>
                    <!-- Add Category Modal -->
                    <div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="addCategoryModalLabel">Add Category</h4>
                                </div>
                                <div class="modal-body">
                                    <asp:UpdatePanel ID="up_add_category" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <div class='thumbnail'>
                                                            <img src='<%= s_img_empty %>' style='width: 108px; height: 108px; border: 1px solid #E6E6E6' />
                                                            <div class='caption'>Select image</div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label runat="server" AssociatedControlID="tb_add_category_name" CssClass="col-md-4 control-label">Category Name</asp:Label>
                                                    <div class="col-md-8">
                                                        <asp:TextBox runat="server" ID="tb_add_category_name" CssClass="form-control" />
                                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tb_add_category_name" CssClass="text-danger" ErrorMessage="The category name field is required." />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label runat="server"
                                                        AssociatedControlID="tb_add_category_description"
                                                        CssClass="col-md-4 control-label">Category Description</asp:Label>
                                                    <div class="col-md-8">
                                                        <asp:TextBox runat="server"
                                                            Text=""
                                                            ID="tb_add_category_description"
                                                            CssClass="form-control" />
                                                    </div>
                                                </div>

                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" type="button" class="btn btn-default" data-dismiss="modal" Text="Close" />
                                    <asp:Button runat="server" ID="btn_add_category" OnInit="btn_add_category_Init" OnClick="btn_add_category_Click" type="submit" class="btn btn-primary" Text="Save changes" />
                                </div>
                            </div>
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
                                    <asp:UpdatePanel ID="up_edit_category" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>

                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <div class="thumbnail" id="dz_edit_category">
                                                            <asp:Image
                                                                ID='img_edit_category'
                                                                ImageUrl="<%# s_img_loading %>"
                                                                Style='width: 108px; height: 108px; border: 1px solid #E6E6E6'
                                                                runat="server" />
                                                            <div class="caption">Drop image file here or click to browse.</div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label runat="server" AssociatedControlID="tb_edit_category_name" CssClass="col-md-4 control-label">Category Name</asp:Label>
                                                    <div class="col-md-8">
                                                        <asp:TextBox runat="server"
                                                            Text="Loading.."
                                                            ID="tb_edit_category_name"
                                                            CssClass="form-control" Enabled="false" />
                                                        <asp:RequiredFieldValidator runat="server"
                                                            ControlToValidate="tb_edit_category_name"
                                                            CssClass="text-danger"
                                                            ErrorMessage="The category name field is required." />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label runat="server"
                                                        AssociatedControlID="tb_edit_category_description"
                                                        CssClass="col-md-4 control-label">Category Description</asp:Label>
                                                    <div class="col-md-8">
                                                        <asp:TextBox runat="server"
                                                            Text="Loading.."
                                                            TextMode="multiline"
                                                            Rows="4"
                                                            ID="tb_edit_category_description"
                                                            Style="resize: none;"
                                                            CssClass="form-control" Enabled="false" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label runat="server"
                                                        AssociatedControlID="cb_edit_category_isvisible"
                                                        CssClass="col-md-4 control-label">Is Visible?</asp:Label>
                                                    <div class="col-md-8">
                                                        <asp:CheckBox runat="server" Checked="true"
                                                            ID="cb_edit_category_isvisible"
                                                            Enabled="false" />
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server"
                                        ID="btn_edit_close"
                                        type="button" class="btn btn-default" data-dismiss="modal"
                                        Text="Close" />
                                    <asp:Button runat="server"
                                        ID="btn_edit_save"
                                        Enabled="true"
                                        CommandName="SaveCategory"
                                        AutoPostBack="true"
                                        OnInit="btn_edit_save_Init"
                                        OnClick="btn_edit_save_Click"
                                        type="submit" class="btn btn-primary"
                                        Text="Save changes" />
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
                                    <asp:UpdatePanel ID="up_delete_category" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>

                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <div class='thumbnail'>
                                                            <asp:Image
                                                                ID='img_delete_category'
                                                                ImageUrl="<%# s_img_loading %>"
                                                                Style='width: 108px; height: 108px; border: 1px solid #E6E6E6'
                                                                runat="server" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label runat="server" ID="lb_delete_category_name" CssClass="col-md-8" Text="Loading.." />
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label runat="server" ID="lb_delete_category_description" CssClass="col-md-8" Text="Loading.." />
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" ID="btn_delete_close" type="button" class="btn btn-default" data-dismiss="modal" Text="Cancel" />
                                    <asp:Button runat="server" OnInit="btn_delete_save_Init" OnClick="btn_delete_save_Click" ID="btn_delete_save" type="submit" class="btn btn-danger" Text="Delete" />
                                </div>
                            </div>
                        </div>
                    </div>




                </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>

    <asp:SqlDataSource runat="server" ID="sds_categories" ConnectionString='<%$ ConnectionStrings:MarketContext %>'
        DeleteCommand="UPDATE [categories] SET [isDeleted] = 'true' WHERE [ID] = @ID"
        InsertCommand="INSERT INTO [categories] ([Name], [Description], [Picture]) VALUES (@Name, @Description, @Picture)"
        SelectCommand="SELECT [ID], [Name], [Description], [Picture], [isVisible] FROM [categories] WHERE [isDeleted] = 'false' AND [isVisible] = 'true' ORDER BY [Name] ASC"
        UpdateCommand="UPDATE [categories] SET [Name] = @Name, [Description] = @Description, [Picture] = @Picture, [isVisible] = @isVisible WHERE [ID] = @ID"
        CancelSelectOnNullParameter="false">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Picture" Type="String" />
        </InsertParameters>
        <SelectParameters>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Picture" Type="String" />
            <asp:Parameter Name="isVisible" Type="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">

    <script src="/Scripts/masonry.pkgd.min.js"></script>

    <%-- some client-side magics --%>
    <script type="text/javascript">
        var $grid = $('.js-masonry').masonry();

        $().ready(function () {
            //setup dropzone

            $("div#dz_edit_category").dropzone({ url: "/Categories" });

            // clean dialogs on close
            var img_empty = '<%: s_img_empty %>';
            var img_loading = '<%: s_img_loading %>';

            $('#addCategoryModal').on('hidden.bs.modal', function () {
                $('[ID="MainContent_lv_modals_img_add_category"]').attr('src', img_empty);
                $('[ID="MainContent_lv_modals_tb_add_category_name"]').attr('value', '');
                $('[ID="MainContent_lv_modals_tb_add_category_description"]').attr('value', '');
            })

            $('#editCategoryModal').on('hidden.bs.modal', function () {
                $('[ID="MainContent_lv_modals_img_edit_category"]').attr('src', img_loading);
                $('[ID="MainContent_lv_modals_tb_edit_category_name"]').attr('value', 'Loading..');
                $('[ID="MainContent_lv_modals_tb_edit_category_name"]').prop('disabled', 'true');
                $('[ID="MainContent_lv_modals_tb_edit_category_description"]').attr('value', 'Loading..');
                $('[ID="MainContent_lv_modals_tb_edit_category_description"]').prop('disabled', 'true');
                $('[ID="MainContent_lv_modals_cb_edit_category_isvisible"]').prop('disabled', 'true');
            })

            $('#deleteCategoryModal').on('hidden.bs.modal', function () {
                $('[ID="MainContent_lv_modals_img_delete_category"]').attr('src', img_loading);
                $("#MainContent_lv_modals_lb_delete_category_name").text('Loading..');
                $("#MainContent_lv_modals_lb_delete_category_description").text('Loading..');

            })

        })

        // filter search
        $('#search').keyup(function () {

            var rex = new RegExp($(this).val(), 'i');
            $('.searchable').hide();
            $('.searchable').filter(function () {
                return rex.test($(this).text());
            }).show();

            $grid.masonry();

        })
    </script>

</asp:Content>
