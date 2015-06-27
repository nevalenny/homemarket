<%@ Page Title="Categories" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Categories.aspx.cs" Inherits="HomeMarket.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <ol class="breadcrumb">
        <li><a href="/">Home</a></li>
        <li class="active">Categories</li>
    </ol>

    <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server" />
    <asp:Repeater runat="server" ID="rpt_categories" OnItemDataBound="rpt_categories_ItemDataBound">
        <HeaderTemplate>
            <div class="container">
                <div class='row js-masonry' data-masonry-options='{ "columnWidth": ".col-lg-3", "itemSelector": ".col-lg-3", "percentPosition" : true}'>
                    <asp:LoginView ID="lv_admin_options1" runat="server" ViewStateMode="Disabled">
                        <RoleGroups>
                            <asp:RoleGroup Roles='admins'>
                                <ContentTemplate>
                                    <div class='col-xs-12 col-sm-4 col-md-3 col-lg-3'>
                                        <p>
                                            <asp:Button ID="btn_add_category"
                                                runat="server"
                                                AutoPostBack="false"
                                                OnClick="btn_add_category_Click"
                                                OnInit="btn_add_category_Init"
                                                type='button'
                                                class='btn btn-warning btn-lg btn-block'
                                                data-toggle='modal'
                                                data-target='#addCategoryModal'
                                                data-id='-1'
                                                Text="Add category" />
                                        </p>
                                    </div>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
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
                        <asp:LoginView ID="lv_admin_options2" runat="server" ViewStateMode="Disabled">
                            <RoleGroups>
                                <asp:RoleGroup Roles='admins'>
                                    <ContentTemplate>
                                        <asp:Button ID="btn_edit_category" 
                                            runat="server"
                                            OnClick="btn_edit_category_Click"
                                            OnInit="btn_edit_category_Init"
                                            CommandName="EditCategory"
                                            AutoPostBack="false"
                                            Text="Edit"
                                            type='button'
                                            class='btn btn-default btn-sm'
                                            data-toggle='modal'
                                            data-target='#editCategoryModal'/>
                                        <asp:Button ID="btn_delete_category"
                                            OnClick="btn_delete_category_Click"
                                            runat="server"
                                            AutoPostBack="false"
                                            Text="Delete"
                                            type='button'
                                            class='btn btn-danger btn-sm'
                                            data-toggle='modal'
                                            data-target='#deleteCategoryModal'
                                            data-id='<%#Eval("ID")%>' />
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
                </div>  <%--container--%>
        </FooterTemplate>
    </asp:Repeater>



    <%--Admin modals--%>
    <asp:LoginView ID="lv_modals" runat="server" ViewStateMode="Disabled">
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
                                                            <img src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGwAAABsCAAAAACqDQgRAAAACXBIWXMAAAsTAAALEwEAmpwYAAADGGlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjaY2BgnuDo4uTKJMDAUFBUUuQe5BgZERmlwH6egY2BmYGBgYGBITG5uMAxIMCHgYGBIS8/L5UBFTAyMHy7xsDIwMDAcFnX0cXJlYE0wJpcUFTCwMBwgIGBwSgltTiZgYHhCwMDQ3p5SUEJAwNjDAMDg0hSdkEJAwNjAQMDg0h2SJAzAwNjCwMDE09JakUJAwMDg3N+QWVRZnpGiYKhpaWlgmNKflKqQnBlcUlqbrGCZ15yflFBflFiSWoKAwMD1A4GBgYGXpf8EgX3xMw8BSMDVQYqg4jIKAUICxE+CDEESC4tKoMHJQODAIMCgwGDA0MAQyJDPcMChqMMbxjFGV0YSxlXMN5jEmMKYprAdIFZmDmSeSHzGxZLlg6WW6x6rK2s99gs2aaxfWMPZ9/NocTRxfGFM5HzApcj1xZuTe4FPFI8U3mFeCfxCfNN45fhXyygI7BD0FXwilCq0A/hXhEVkb2i4aJfxCaJG4lfkaiQlJM8JpUvLS19QqZMVl32llyfvIv8H4WtioVKekpvldeqFKiaqP5UO6jepRGqqaT5QeuA9iSdVF0rPUG9V/pHDBYY1hrFGNuayJsym740u2C+02KJ5QSrOutcmzjbQDtXe2sHY0cdJzVnJRcFV3k3BXdlD3VPXS8Tbxsfd99gvwT//ID6wIlBS4N3hVwMfRnOFCEXaRUVEV0RMzN2T9yDBLZE3aSw5IaUNak30zkyLDIzs+ZmX8xlz7PPryjYVPiuWLskq3RV2ZsK/cqSql01jLVedVPrHzbqNdU0n22VaytsP9op3VXUfbpXta+x/+5Em0mzJ/+dGj/t8AyNmf2zvs9JmHt6vvmCpYtEFrcu+bYsc/m9lSGrTq9xWbtvveWGbZtMNm/ZarJt+w6rnft3u+45uy9s/4ODOYd+Hmk/Jn58xUnrU+fOJJ/9dX7SRe1LR68kXv13fc5Nm1t379TfU75/4mHeY7En+59lvhB5efB1/lv5dxc+NH0y/fzq64Lv4T8Ffp360/rP8f9/AA0ADzT6lvFdAAA7yWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS41LWMwMjEgNzkuMTU0OTExLCAyMDEzLzEwLzI5LTExOjQ3OjE2ICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgKFdpbmRvd3MpPC94bXA6Q3JlYXRvclRvb2w+CiAgICAgICAgIDx4bXA6Q3JlYXRlRGF0ZT4yMDE1LTA2LTA4VDEyOjUwOjQ4KzAzOjAwPC94bXA6Q3JlYXRlRGF0ZT4KICAgICAgICAgPHhtcDpNb2RpZnlEYXRlPjIwMTUtMDYtMDhUMTI6NTU6MTgrMDM6MDA8L3htcDpNb2RpZnlEYXRlPgogICAgICAgICA8eG1wOk1ldGFkYXRhRGF0ZT4yMDE1LTA2LTA4VDEyOjU1OjE4KzAzOjAwPC94bXA6TWV0YWRhdGFEYXRlPgogICAgICAgICA8ZGM6Zm9ybWF0PmltYWdlL3BuZzwvZGM6Zm9ybWF0PgogICAgICAgICA8cGhvdG9zaG9wOkNvbG9yTW9kZT4xPC9waG90b3Nob3A6Q29sb3JNb2RlPgogICAgICAgICA8cGhvdG9zaG9wOklDQ1Byb2ZpbGU+RG90IEdhaW4gMjAlPC9waG90b3Nob3A6SUNDUHJvZmlsZT4KICAgICAgICAgPHhtcE1NOkluc3RhbmNlSUQ+eG1wLmlpZDplNzlhOWU2ZC1mNDk1LWY1NGEtYmUyYi1iZTIyNzk4NDkwNWU8L3htcE1NOkluc3RhbmNlSUQ+CiAgICAgICAgIDx4bXBNTTpEb2N1bWVudElEPnhtcC5kaWQ6NjNkZWI5MmItMDU0Yy0wMDQ2LTk5NzQtZmRiMzFjODQ3NGIxPC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6NjNkZWI5MmItMDU0Yy0wMDQ2LTk5NzQtZmRiMzFjODQ3NGIxPC94bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y3JlYXRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOjYzZGViOTJiLTA1NGMtMDA0Ni05OTc0LWZkYjMxYzg0NzRiMTwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNS0wNi0wOFQxMjo1MDo0OCswMzowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6NDk5Zjc4OTgtOTlmZC1jYTQ2LWI4NDgtMjAwYTY2M2FlN2UwPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE1LTA2LTA4VDEyOjUzOjQ2KzAzOjAwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICAgICA8c3RFdnQ6Y2hhbmdlZD4vPC9zdEV2dDpjaGFuZ2VkPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDplNzlhOWU2ZC1mNDk1LWY1NGEtYmUyYi1iZTIyNzk4NDkwNWU8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTUtMDYtMDhUMTI6NTU6MTgrMDM6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjEwODwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj4xMDg8L2V4aWY6UGl4ZWxZRGltZW5zaW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgwEIXIAAAAgY0hSTQAAeiUAAICDAAD5/wAAgOkA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' style='width: 108px; height: 108px; border: 1px solid #E6E6E6' />
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
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Save changes</button>
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
                                                        <div class='thumbnail'>
                                                            <asp:Image 
                                                                ID='img_edit_category' 
                                                                ImageUrl='data:image/png;base64,' 
                                                                Style='width: 108px; height: 108px; border: 1px solid #E6E6E6'
                                                                runat="server"/>
                                                            <div class='caption'>Select image</div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label runat="server" AssociatedControlID="tb_edit_category_name" CssClass="col-md-4 control-label">Category Name</asp:Label>
                                                    <div class="col-md-8">
                                                        <asp:TextBox runat="server"
                                                            Text=" "
                                                            ID="tb_edit_category_name"
                                                            CssClass="form-control" />
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
                                                            Text=""
                                                            ID="tb_edit_category_description"
                                                            CssClass="form-control" />
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Save changes</button>
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
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-danger">Delete</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>




                </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>


    <asp:SqlDataSource runat="server" ID="sds_categories" ConnectionString='<%$ ConnectionStrings:MarketContext %>'
        DeleteCommand="UPDATE [categories] SET [isDeleted] = 'True' WHERE [ID] = @ID"
        InsertCommand="INSERT INTO [categories] ([Name], [Description], [Picture]) VALUES (@Name, @Description, @Picture)"
        SelectCommand="SELECT * FROM [categories] WHERE [isDeleted] = 'False', ([Name] LIKE '%'+ @SearchTerm +'%')"
        UpdateCommand="UPDATE [categories] SET [Name] = @Name, [Description] = @Description, [Picture] = @Picture, [isVisible] = @isVisible WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="isDeleted" Type="Boolean" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Picture" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="SearchTerm" Type="String" />
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

</asp:Content>
