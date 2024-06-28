! function() {
    var t = sessionStorage.getItem("__MINTON_CONFIG__"),
        e = document.getElementsByTagName("html")[0],
        i = {
            theme: "light",
            layout: {
                position: "fixed",
                width: "fluid"
            },
            topbar: {
                color: "dark"
            },
            menu: {
                color: "light"
            },
            sidebar: {
                size: "default",
                user: !1
            }
        };
    this.html = document.getElementsByTagName("html")[0], config = Object.assign(JSON.parse(JSON.stringify(i)), {});
    var o = this.html.getAttribute("data-bs-theme");
    config.theme = null !== o ? o : i.theme;
    var a = this.html.getAttribute("data-layout-position");
    config.layout.position = null != a ? a : i.layout.position;
    var r = this.html.getAttribute("data-layout-width");
    config.layout.width = null != r ? r : i.layout.width;
    var s = this.html.getAttribute("data-topbar-color");
    config.topbar.color = null != s ? s : i.topbar.color;
    var n = this.html.getAttribute("data-sidebar-size");
    config.sidebar.size = null !== n ? n : i.sidebar.size;
    var l = this.html.getAttribute("data-sidebar-user");
    config.sidebar.user = null !== l || i.sidebar.user;
    var u = this.html.getAttribute("data-menu-color");
    config.menu.color = null !== u ? u : i.menu.color, window.defaultConfig = JSON.parse(JSON.stringify(config)), null !== t && (config = JSON.parse(t)), window.config = config, config && (e.setAttribute("data-bs-theme", config.theme), e.setAttribute("data-topbar-color", "dark"), e.setAttribute("data-menu-color", config.menu.color), e.setAttribute("data-sidebar-size", config.sidebar.size), e.setAttribute("data-layout-width", config.layout.width), e.setAttribute("data-layout-position", config.layout.position), config.sidebar.user && "true" === config.sidebar.user.toString() ? e.setAttribute("data-sidebar-user", !0) : e.removeAttribute("data-sidebar-user")), window.innerWidth <= 991.98 ? e.setAttribute("data-sidebar-size", "full") : 991.98 <= window.innerWidth && window.innerWidth <= 1140 && "full" !== self.config.sidebar.size && e.setAttribute("data-sidebar-size", "condensed"), document.getElementById("app-stylesheet").href.includes("rtl.min.css") && (document.getElementsByTagName("html")[0].dir = "rtl")
}();