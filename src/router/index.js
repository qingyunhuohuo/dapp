import Vue from 'vue'
import Router from 'vue-router'

import MainPage from '@/components/MainPage/MainPage'
import Donate from '@/components/Donate/Donate'
import SetUp from '@/components/SetUp/SetUp'
import Cancel from '@/components/Cancel/Cancel'
import Drawback from '@/components/Drawback/Drawback'
import Withdraw from '@/components/Withdraw/Withdraw'
import Detail from '@/components/Detail/Detail'
import Blacklist from '@/components/Blacklist/Blacklist'
import AddGoodUser from '@/components/Blacklist/AddGoodUser'
import DeltetGoodUser from '@/components/Blacklist/DeltetGoodUser'
import AddBadUser from '@/components/Blacklist/AddBadUser'
import DeltetBadUser from '@/components/Blacklist/DeltetBadUser'

Vue.use(Router)

var router = new Router({
  routes: [
    {
      path: '/',
      name: 'MainPage',
      component: MainPage
    },
    {
      path: '/Donate',
      name: 'Donate',
      component: Donate
    },
    {
      path: '/SetUp',
      name: 'SetUp',
      component: SetUp
    },
    {
      path: '/Cancel',
      name: 'Cancel',
      component: Cancel
    },
    {
      path: '/Drawback',
      name: 'Drawback',
      component: Drawback
    },
    {
      path: '/Withdraw',
      name: 'Withdraw',
      component: Withdraw
    },
    {
      path: '/Detail',
      name: 'Detail',
      component: Detail
    },
    {
      path: '/Blacklist',
      name: 'Blacklist',
      component: Blacklist
    },
    {
      path: '/AddGoodUser',
      name: 'AddGoodUser',
      component: AddGoodUser
    },
    {
      path: '/DeltetGoodUser',
      name: 'DeltetGoodUser',
      component: DeltetGoodUser
    },
    {
      path: '/AddBadUser',
      name: 'AddBadUser',
      component: AddBadUser
    },
    {
      path: '/DeltetBadUser',
      name: 'DeltetBadUser',
      component: DeltetBadUser
    },
  ]
})

export default router