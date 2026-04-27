<%
    String active = request.getParameter("active");
    if (active == null) {
        active = "";
    }

    String activeClass = "flex items-center gap-3 bg-blue-600 text-white rounded-xl px-4 py-3 font-semibold shadow-sm";
    String inactiveClass = "flex items-center gap-3 text-slate-300 hover:text-white hover:bg-white/10 rounded-xl px-4 py-3 transition-all duration-200";
%>

<aside class="h-screen w-60 fixed left-0 top-0 bg-[#082B4C] flex flex-col px-4 py-6 z-50">

    <div class="mb-8">
        <div class="flex items-center gap-3">
            <div class="w-11 h-11 rounded-xl bg-white flex items-center justify-center shadow-sm">
                <img src="${pageContext.request.contextPath}/assets/images/Logo_Rasmi_UMT.png"
                     alt="Redox RX Logo"
                     class="w-8 h-8 object-contain">
            </div>

            <div>
                <h1 class="text-white text-lg font-bold leading-tight">Redox RX</h1>
                <p class="text-blue-200 text-xs leading-tight">Inventory System</p>
            </div>
        </div>
    </div>

    <nav class="flex-1 space-y-2">

        <a class="<%= "product".equals(active) ? activeClass : inactiveClass%>"
           href="${pageContext.request.contextPath}/ProductController?action=list">
            <span class="material-symbols-outlined text-[21px]">inventory_2</span>
            <span class="text-sm">Manage Products</span>
        </a>

        <a class="<%= "alert".equals(active) ? activeClass : inactiveClass%>"
           href="${pageContext.request.contextPath}/ProductController?action=list&lowStock=true">
            <span class="material-symbols-outlined text-[21px]">warning</span>
            <span class="text-sm">Low Stock Status</span>
        </a>

    </nav>

    <div class="pt-5 border-t border-white/10">
        <a href="${pageContext.request.contextPath}/LogoutController"
           class="flex items-center gap-3 text-red-300 hover:text-white hover:bg-red-500/20 rounded-xl px-4 py-3 transition-all">
            <span class="material-symbols-outlined text-[21px]">logout</span>
            <span class="text-sm font-medium">Logout</span>
        </a>
    </div>

</aside>