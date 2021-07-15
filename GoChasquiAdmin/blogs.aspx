<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="blogs.aspx.cs" Inherits="GoChasquiAdmin.blogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	 <asp:ObjectDataSource ID="odsBlogs" runat="server" TypeName="GoChasquiAdmin.Clases.Blogs" SelectMethod="lista_blog_todos">
        <SelectParameters>
			<asp:Parameter Name="Id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
  
		<!-- begin container -->
		<div class="container">
    <!-- begin #page-title -->
	<div id="page-title" class="page-title has-bg">
		<div class="bg-cover" data-paroller="true" data-paroller-factor="0.5" style="background: url(/assets/img/gochasqui/fondo_menus.jpg) center 0px / cover no-repeat"></div>
		<div class="container">
			<h1>Blog oficial Pa Llevar</h1>
			<p>Compartiendo tus inquietudes</p>
		</div>
	</div>
	<!-- end #page-title -->
	
<div id="content" class="content">
		<!-- begin container -->
		<div class="container">
			<!-- begin row -->
			<div class="row row-space-30">
				<!-- begin col-9 -->
				<div class="col-md-9">
					<!-- begin post-list -->
					<div class="post-list post-grid post-grid-2">
				 <asp:Repeater ID="Repeater1" DataSourceID="odsBlogs" runat="server">
                     <ItemTemplate>
							<div class="post-li">
								<!-- begin post-content -->
								<div class="post-content">
									<!-- begin post-image -->
									<div class="post-image">
										<a href="post_detail.html">
											<asp:Image runat="server" Width="200" ImageUrl='<%# string.Concat ("Img_blog/",Eval("id_blog"),"/", Eval("url_foto")) %>'></asp:Image>
										</a>
									</div>
									<!-- end post-image -->
									<!-- begin post-info -->
									<div class="post-info">
										<h4 class="post-title">
											<a href="post_detail.html"><%# Eval("titulo") %></a>
										</h4>
										<div class="post-by">
											Posteado Por <a href="#">admin</a> <span class="divider">|</span> <%# Eval("fecha_publicacion") %>
										</div>
										<div class="post-desc">
											<%# Eval("descripcion") %>
										</div>
										<div class="read-btn-container">
											<a href="post_detail.html">Read More <i class="fa fa-angle-double-right"></i></a>
										</div>
									</div>
									<!-- end post-info -->
								</div>
								<!-- end post-content -->
							</div>
						 </ItemTemplate>
					 </asp:Repeater>
				
				
			<!-- end post-list -->
		</div>
		<!-- end container -->
	</div>
	<!-- end #content -->
	</div>
</div>
	</div></div>
</asp:Content>
