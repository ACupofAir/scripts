import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../pages/zhishe/home.vue'
import College from "@/pages/zhishe/college";
import Campus from "@/pages/zhishe/campus";
import Comment from "@/pages/zhishe/comment";
import AdminHome from "@/pages/admin/adminHome";
import AdminList from "@/pages/admin/adminList";
import AdminLogin from "@/pages/admin/adminLogin";
import Check from "@/pages/admin/check";
import CollegeManage from "@/pages/admin/collegeManage";
import Log from "@/pages/admin/adminLog";
import Welcome from "@/pages/zhishe/welcome";
import ComDetails from "@/components/comDetails";
import AdminMain from "@/pages/admin/adminMain";
import About from "@/pages/zhishe/about";

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        name: 'Welcome',
        component: Welcome
    },
    {
        path: '/adminHome',
        name: 'AdminHome',
        component: AdminHome,
        children: [
            {
                path: '/adminList',
                name: 'AdminList',
                component: AdminList
            },
            {
                path: '/check',
                name: 'Check',
                component: Check
            },
            {
                path: '/collegeManage/',
                name: 'CollegeManage',
                component: CollegeManage
            },
            {
                path: '/log',
                name: 'Log',
                component: Log
            },
            {
                path: '/adminMain',
                name: 'AdminMain',
                component: AdminMain,
            },
        ]

    },

    {
        path: '/adminLogin',
        name: 'AdminLogin',
        component: AdminLogin
    },
    {
        path: '/comDetails',
        name: 'ComDetails',
        component: ComDetails
    },

    {
        path: '/home',
        name: 'Home',
        component: Home,
        children: [
            {
                path: '/college/:collegeName',
                name: 'College',
                component: College,
            },
            {
                path: '/campus/:campusName',
                name: 'Campus',
                component: Campus
            },
            {
                path: '/comment',
                name: 'Comment',
                component: Comment
            },
            {
                path: '/about',
                name: 'About',
                component: About
            }

        ]
    }
]

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
})

export default router
