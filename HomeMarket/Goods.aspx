<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Goods.aspx.cs" Inherits="HomeMarket.Goods" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class='col-xs-8 col-sm-8 col-md-8 col-lg-8'>
            <ol class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li><a href="/Categories">Categories</a></li>
                <li class="active"><%: sCategoryName %></li>
            </ol>
        </div>
        <div class='col-xs-4 col-sm-4 col-md-4 col-lg-4'>
            <div class="input-group">
                <span class="input-group-addon"></span>
                <input id="search" type="text" class="form-control" placeholder="Search...">
            </div>
        </div>
    </div>

    <nav>
    </nav>
    <asp:Repeater runat="server" ID="rpt_goods" OnItemCommand="rpt_goods_ItemCommand">
        <HeaderTemplate>
            <div class="container">
                <div class='row js-masonry' data-masonry-options='{ "columnWidth": ".col-lg-3", "itemSelector": ".col-lg-3", "percentPosition" : true}'>
                    <%-- Hide add button for empty/wrong Category --%>
                    <%if (iCategoryID != 0)
                      { %>
                    <asp:LoginView ID="AdminOptionsView" runat="server">
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
            <div class='col-xs-12 col-sm-4 col-md-3 col-lg-3 searchable'>
                <div class='thumbnail'>
                    <img src='<%# Eval("Picture") %>' style='width: 108px; height: 108px; border: 1px solid #E6E6E6' />
                    <div class='caption'>
                        <h4><%# Eval("Name")%></h4>
                        <h5>Price: $<%# Eval("Price") %></h5>
                        <h5>Available: <%# Eval("Available")!=null && int.Parse(Eval("Available").ToString()) > 0 ? Eval("Available") : "" %>
                            <asp:LoginView runat="server" ID="lv_loggedin_buttons">
                                <LoggedInTemplate>
                                    <asp:Button runat="server"
                                        id="btn_add_to_cart"
                                        type='button'
                                        OnInit="btn_async_Init"                                        
                                        CommandName="AddGoodToCart"
                                        CommandArgument='<%# Eval("ID") %>'
                                        AutoPostBack="false" 
                                        CssClass='<%# (Eval("Available")!=null && int.Parse(Eval("Available").ToString()) > 0) ? "btn btn-xs btn-success" : "btn btn-xs btn-default disabled" %>'                              
                                        Text='<%# (Eval("Available")!=null && int.Parse(Eval("Available").ToString()) > 0) ? "Add to cart" : "Not available" %>' />
                                </LoggedInTemplate>
                            </asp:LoginView>
                        </h5>
                        <p><%# Eval("Description") %></p>
                        <asp:LoginView ID="lv_admin_options2" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles='admins'>
                                    <ContentTemplate>
                                        <asp:Button runat="server" 
                                            ID="btn_edit_good"
                                            OnInit="btn_async_Init"
                                            CommandName="EditGood"
                                            CommandArgument='<%# Eval("ID") %>'
                                            AutoPostBack="false"
                                            Text="Edit"
                                            type='button'
                                            class='btn btn-default btn-sm'
                                            data-toggle='modal'
                                            data-target='#editGoodModal' />
                                        <asp:Button runat="server" 
                                            ID="btn_delete_good"
                                            OnInit="btn_async_Init"
                                            CommandName="DeleteGood"
                                            CommandArgument='<%# Eval("ID") %>'
                                            AutoPostBack="false"
                                            Text="Delete"
                                            type='button'
                                            class='btn btn-danger btn-sm'
                                            data-toggle='modal'
                                            data-target='#deleteGoodModal' />

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

    <%--Admin modals--%>
    <asp:LoginView ID="lv_modals" runat="server">
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
                                    <asp:UpdatePanel ID="up_add_good" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <div class="form-horizontal">
                                                <%-- Picture --%>
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <div class='thumbnail'>
                                                            <img src='<%= s_img_empty %>' style='width: 108px; height: 108px; border: 1px solid #E6E6E6' />
                                                        </div>
                                                    </div>
                                                </div>

                                                <%-- Name --%>
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <asp:TextBox runat="server"
                                                            ID="tb_add_good_name"
                                                            CssClass="form-control" type="text" MaxLength="100" required="" placeholder="Item Name" />
                                                        <span class="help-block with-errors">up to 100 letters</span>
                                                    </div>
                                                </div>

                                                <%-- Description --%>
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <asp:TextBox runat="server"
                                                            ID="tb_add_good_description"
                                                            Text="" TextMode="multiline" Rows="3" placeholder="Item Description" type="text" pattern="/^.{0,200}$/" CssClass="form-control" />
                                                        <span class="help-block with-errors">up to 200 letters</span>
                                                    </div>
                                                </div>

                                                <%-- Price --%>
                                                <div class="form-group">
                                                    <asp:Label runat="server" AssociatedControlID="tb_add_good_price" Text="Price" CssClass="col-md-2"/>
                                                    <div class="col-md-10">
                                                        <asp:TextBox runat="server"
                                                            ID="tb_add_good_price"
                                                            CssClass="form-control" placeholder="1,99" type="text" pattern="^\d{0,10}(\,\d{1,2})?$" required="" />
                                                        <div class="help-block with-errors"></div>
                                                    </div>
                                                </div>

                                                <%-- Available --%>
                                                <div class="form-group">
                                                    <asp:Label runat="server" AssociatedControlID="tb_add_good_available" Text="Available" CssClass="col-md-2"/>
                                                    <div class="col-md-10">
                                                        <asp:TextBox runat="server" ID="tb_add_good_available" CssClass="form-control" placeholder="1 unit" type="number" min="0" max="1000000" required="" />
                                                        <div class="help-block with-errors"></div>
                                                    </div>
                                                </div>

                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" type="button" class="btn btn-default" data-dismiss="modal" Text="Close" />
                                    <asp:Button runat="server" ID="btn_add_good" OnInit="btn_sync_Init" OnClick="btn_add_good_Click" type="submit" class="btn btn-primary" Text="Save changes" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Edit Good Modal -->
                    <div class="modal fade" id="editGoodModal" tabindex="-1" role="dialog" aria-labelledby="editGoodModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="editGoodModalLabel">Edit Item</h4>
                                </div>
                                <div class="modal-body">
                                    <asp:UpdatePanel ID="up_edit_good" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <div class="form-horizontal">
                                                <%-- Picture --%>
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <div class="thumbnail" id="dz_edit_good">
                                                            <asp:Image
                                                                ID='img_edit_good'
                                                                ImageUrl="<%# s_img_loading %>"
                                                                Style='width: 108px; height: 108px; border: 1px solid #E6E6E6'
                                                                runat="server" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <%-- Name --%>
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <asp:TextBox runat="server"
                                                            ID="tb_edit_good_name"
                                                            Text="" placeholder="Item Name" MaxLength="100" required="" type="text" CssClass="form-control" Enabled="false" />
                                                        <span class="help-block with-errors">up to 100 letters</span>
                                                    </div>
                                                </div>

                                                <%-- Description --%>
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <asp:TextBox runat="server"
                                                            ID="tb_edit_good_description"
                                                            type="text" Text="Loading.." placeholder="Item Description" TextMode="multiline" Rows="4" MaxLength="200" Style="resize: none;" CssClass="form-control" Enabled="false" />
                                                        <span class="help-block with-errors">up to 200 letters</span>
                                                    </div>
                                                </div>

                                                <%-- Price --%>
                                                <div class="form-group">
                                                    <asp:Label runat="server" AssociatedControlID="tb_edit_good_price" Text="Price" CssClass="col-md-2"/>
                                                    <div class="col-md-10">
                                                        <asp:TextBox runat="server"
                                                            ID="tb_edit_good_price"
                                                            CssClass="form-control" placeholder="1,99" type="text" pattern="^\d{0,10}(\,\d{1,2})?$" required="" />
                                                        <div class="help-block with-errors"></div>
                                                    </div>
                                                </div>

                                                <%-- Available --%>
                                                <div class="form-group">
                                                    <asp:Label runat="server" AssociatedControlID="tb_edit_good_available" Text="Available" CssClass="col-md-2"/>
                                                    <div class="col-md-10">
                                                        <asp:TextBox runat="server" 
                                                            ID="tb_edit_good_available"
                                                            CssClass="form-control" placeholder="1" type="number" min="0" max="1000000" required="" />
                                                        <div class="help-block with-errors"></div>
                                                    </div>
                                                </div>

                                                <%-- Is Visible --%>
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <asp:CheckBox runat="server" Checked="true"
                                                            ID="cb_edit_good_isvisible"
                                                            Enabled="false" Text="Visible?" />
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
                                        Enabled="true" CommandName="SaveGood" AutoPostBack="true" OnInit="btn_sync_Init" OnClick="btn_edit_save_Click"
                                        type="submit" class="btn btn-primary"
                                        Text="Save changes" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Good Modal -->
                    <div class="modal fade" id="deleteGoodModal" tabindex="-1" role="dialog" aria-labelledby="deleteGoodModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="deleteGoodModalLabel">Delete Item?</h4>
                                </div>
                                <div class="modal-body">
                                    <asp:UpdatePanel ID="up_delete_good" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>

                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <div class="col-md-12">
                                                        <div class='thumbnail'>
                                                            <asp:Image
                                                                ID='img_delete_good'
                                                                ImageUrl="<%# s_img_loading %>"
                                                                Style='width: 108px; height: 108px; border: 1px solid #E6E6E6'
                                                                runat="server" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label runat="server" ID="lb_delete_good_name" CssClass="col-md-8" Text="Loading.." />
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label runat="server" ID="lb_delete_good_description" CssClass="col-md-8" Text="Loading.." />
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" ID="btn_delete_close" type="button" class="btn btn-default" data-dismiss="modal" Text="Cancel" />
                                    <asp:Button runat="server" OnInit="btn_sync_Init" OnClick="btn_delete_save_Click" ID="btn_delete_save" type="submit" class="btn btn-danger" Text="Delete" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>
    
    <asp:SqlDataSource runat="server" ID="sds_goods" ConnectionString='<%$ ConnectionStrings:MarketContext %>'
        DeleteCommand="UPDATE [Goods] SET [isDeleted] = 'true' WHERE [ID] = @ID"
        InsertCommand="INSERT INTO [Goods] ([Name], [Description], [Picture], [Price], [Available], [CategoryID]) VALUES (@Name, @Description, @Picture, @Price, @Available, @CategoryID)"
        SelectCommand="SELECT [ID], [Name], [Description], [Picture], [isVisible], [Price], [Available] FROM [Goods] WHERE [isDeleted] = 'false' AND [isVisible] = 'true' AND [CategoryID] = @CategoryID ORDER BY [Name] ASC"
        UpdateCommand="UPDATE [Goods] SET [Name] = @Name, [Description] = @Description, [Picture] = @Picture, [isVisible] = @isVisible, [Price] = @Price, [Available] = @Available WHERE [ID] = @ID"
        CancelSelectOnNullParameter="false">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Picture" Type="String" />
            <asp:Parameter Name="Price" Type="Decimal" />
            <asp:Parameter Name="Available" Type="Int32" />
            <asp:Parameter Name="CategoryID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="CategoryID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Picture" Type="String" />
            <asp:Parameter Name="isVisible" Type="Boolean" />
            <asp:Parameter Name="Price" Type="Decimal" />
            <asp:Parameter Name="Available" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script src="/Scripts/masonry.pkgd.min.js"></script>
    <script src="/Scripts/validator.js"></script>


    <%-- some client-side magics --%>
    <script type="text/javascript">
        var $grid = $('.js-masonry').masonry();

        $().ready(function () {
            // clean dialogs on close
            var img_empty = '<%: s_img_empty %>';
            var img_loading = '<%: s_img_loading %>';

            $('#addGoodModal').on('shown.bs.modal', function () {
                $('#ctl01').removeAttr('novalidate');

                $("#MainContent_lv_modals_tb_add_good_name").attr('required', '');
                $("#MainContent_lv_modals_tb_add_good_price").attr('required', '');
                $("#MainContent_lv_modals_tb_add_good_available").attr('required', '');

                $("#MainContent_lv_modals_tb_edit_good_name").removeAttr('required');
                $("#MainContent_lv_modals_tb_edit_good_price").removeAttr('required');
                $("#MainContent_lv_modals_tb_edit_good_available").removeAttr('required');

                $('#addGoodModal').validator();
            })

            $('#addGoodModal').on('hidden.bs.modal', function () {
                $('#ctl01').attr('novalidate', '');
                $("#MainContent_lv_modals_img_add_good").attr('src', img_empty);
                $("#MainContent_lv_modals_tb_add_good_name").attr('value', '');
                $("#MainContent_lv_modals_tb_add_good_description").attr('value', '');
                $("#MainContent_lv_modals_tb_add_good_price").attr('value', '');
                $("#MainContent_lv_modals_tb_add_good_available").attr('value', '');
            })

            $('#editGoodModal').on('shown.bs.modal', function () {
                $('#ctl01').removeAttr('novalidate');

                $("#MainContent_lv_modals_tb_add_good_name").removeAttr('required');
                $("#MainContent_lv_modals_tb_add_good_price").removeAttr('required');
                $("#MainContent_lv_modals_tb_add_good_available").removeAttr('required');

                $("#MainContent_lv_modals_tb_edit_good_name").attr('required', '');
                $("#MainContent_lv_modals_tb_edit_good_price").attr('required', '');
                $("#MainContent_lv_modals_tb_edit_good_available").attr('required', '');

                $('#editGoodModal').validator();
            })

            $('#editGoodModal').on('hidden.bs.modal', function () {
                $('#ctl01').attr('novalidate', '');
                $("#MainContent_lv_modals_img_edit_good").attr('src', img_loading);
                $("#MainContent_lv_modals_tb_edit_good_name").attr('value', '');
                $("#MainContent_lv_modals_tb_edit_good_name").prop('disabled', 'true');
                $("#MainContent_lv_modals_tb_edit_good_description").attr('value', 'Loading..');
                $("#MainContent_lv_modals_tb_edit_good_description").prop('disabled', 'true');
                $("#MainContent_lv_modals_tb_edit_good_price").attr('value', '');
                $("#MainContent_lv_modals_tb_edit_good_price").prop('disabled', 'true');
                $("#MainContent_lv_modals_tb_edit_good_available").attr('value', '');
                $("#MainContent_lv_modals_tb_edit_good_available").prop('disabled', 'true');
                $("#MainContent_lv_modals_cb_edit_good_isvisible").prop('disabled', 'true');
            })

            $('#deleteGoodModal').on('shown.bs.modal', function () {
                $('#ctl01').removeAttr('novalidate');

                $("#MainContent_lv_modals_tb_add_good_name").removeAttr('required');
                $("#MainContent_lv_modals_tb_add_good_price").removeAttr('required');
                $("#MainContent_lv_modals_tb_add_good_available").removeAttr('required');
                $("#MainContent_lv_modals_tb_edit_good_name").removeAttr('required');
                $("#MainContent_lv_modals_tb_edit_good_price").removeAttr('required');
                $("#MainContent_lv_modals_tb_edit_good_available").removeAttr('required');

                $('#deleteGoodModal').validator();
            })

            $('#deleteGoodModal').on('hidden.bs.modal', function () {
                $('#ctl01').attr('novalidate', '');
                $("#MainContent_lv_modals_img_delete_good").attr('src', img_loading);
                $("#MainContent_lv_modals_lb_delete_good_name").text('Loading..');
                $("#MainContent_lv_modals_lb_delete_good_description").text('Loading..');

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
