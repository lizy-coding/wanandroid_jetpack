package com.yechaoa.wanandroid_jetpack.ui.main

import android.content.Intent
import androidx.appcompat.app.ActionBarDrawerToggle
import androidx.appcompat.app.AlertDialog
import androidx.core.view.GravityCompat
import androidx.viewpager.widget.ViewPager
import com.yechaoa.wanandroid_jetpack.R
import com.yechaoa.wanandroid_jetpack.base.BaseActivity
import com.yechaoa.wanandroid_jetpack.common.MyConfig
import com.yechaoa.wanandroid_jetpack.databinding.ActivityMainBinding
import com.yechaoa.wanandroid_jetpack.databinding.AppBarMainBinding
import com.yechaoa.wanandroid_jetpack.databinding.ContentMainBinding
import com.yechaoa.wanandroid_jetpack.ui.about.AboutActivity
import com.yechaoa.wanandroid_jetpack.ui.adapter.CommonViewPagerAdapter
import com.yechaoa.wanandroid_jetpack.ui.collect.CollectActivity
import com.yechaoa.wanandroid_jetpack.ui.login.LoginActivity
import com.yechaoa.wanandroid_jetpack.ui.main.home.HomeFragment
import com.yechaoa.wanandroid_jetpack.ui.main.navi.NaviFragment
import com.yechaoa.wanandroid_jetpack.ui.main.pro.ProjectFragment
import com.yechaoa.wanandroid_jetpack.ui.main.tree.TreeFragment
import com.yechaoa.wanandroid_jetpack.ui.search.SearchActivity
import com.yechaoa.yutilskt.ActivityUtil
import com.yechaoa.yutilskt.ShareUtil
import com.yechaoa.yutilskt.SpUtil
import com.yechaoa.yutilskt.ToastUtil
import androidx.core.view.get
import androidx.activity.OnBackPressedCallback


class MainActivity : BaseActivity<ActivityMainBinding>(ActivityMainBinding::inflate) {

    private lateinit var mAppBarMainBinding: AppBarMainBinding
    private lateinit var mContentMainBinding: ContentMainBinding

    override fun initialize() {
        super.initialize()
        //include 写法
        mAppBarMainBinding = mBinding.appBarMain
        mContentMainBinding = mBinding.appBarMain.contentMain

        mAppBarMainBinding.toolbar.title = resources.getString(R.string.title_home)

        initActionBarDrawer()

        initFragments()
        
        setupBackPressedCallback()
    }

    /**
     * Drawer关联Toolbar
     */
    private fun initActionBarDrawer() {
        val toggle = ActionBarDrawerToggle(
            this,
            mBinding.drawerLayout,
            mAppBarMainBinding.toolbar,
            R.string.navigation_drawer_open,
            R.string.navigation_drawer_close
        )
        mBinding.drawerLayout.addDrawerListener(toggle)
        toggle.syncState()
    }

    /**
     * 初始化Fragment
     */
    private fun initFragments() {
        val viewPagerAdapter = CommonViewPagerAdapter(supportFragmentManager).apply {
            addFragment(HomeFragment())
            addFragment(TreeFragment())
            addFragment(NaviFragment())
            addFragment(ProjectFragment())
        }
        mAppBarMainBinding.contentMain.viewPager.offscreenPageLimit = 1
        mAppBarMainBinding.contentMain.viewPager.adapter = viewPagerAdapter
    }

    override fun onResume() {
        super.onResume()
        initListener()
    }

    private fun initListener() {
        /**
         * 侧边栏点击事件
         */
        mBinding.navView.setNavigationItemSelectedListener {
            // Handle navigation view item clicks here.
            when (it.itemId) {
                R.id.nav_collect -> {
                    startActivity(Intent(this, CollectActivity::class.java))
                }
                R.id.nav_share -> {
                    ShareUtil.shareText(getString(R.string.wanandroid), getString(R.string.github))
                }
                R.id.nav_about -> {
                    startActivity(Intent(this, AboutActivity::class.java))
                }
                R.id.nav_logout -> {
                    AlertDialog.Builder(this@MainActivity).apply {
                        setTitle("提示")
                        setMessage("确定退出？")
                        setPositiveButton("确定") { _, _ ->
                            SpUtil.setBoolean(MyConfig.IS_LOGIN, false)
                            SpUtil.removeByKey(MyConfig.COOKIE)
                            startActivity(Intent(this@MainActivity, LoginActivity::class.java))
                            finish()
                        }
                        setNegativeButton("取消", null)
                        create()
                        show()
                    }
                }
            }

            //关闭侧边栏
            mBinding.drawerLayout.closeDrawer(GravityCompat.START)

            true
        }

        /**
         * view_pager 滑动监听
         */
        mAppBarMainBinding.contentMain.viewPager.addOnPageChangeListener(object : ViewPager.OnPageChangeListener {
            override fun onPageScrollStateChanged(state: Int) {}

            override fun onPageScrolled(position: Int, positionOffset: Float, positionOffsetPixels: Int) {}

            override fun onPageSelected(position: Int) {
                mAppBarMainBinding.contentMain.bottomNavigation.menu[position].isChecked = true
                mAppBarMainBinding.toolbar.title = resources.getString(
                    when (position) {
                        MainTab.HOME.position -> MainTab.HOME.titleResId
                        MainTab.TREE.position -> MainTab.TREE.titleResId
                        MainTab.NAVI.position -> MainTab.NAVI.titleResId
                        else -> MainTab.PROJECT.titleResId
                    }
                )
            }
        })

        /**
         * bottom_navigation 点击事件
         */
        mAppBarMainBinding.contentMain.bottomNavigation.setOnItemSelectedListener {
            when (it.itemId) {
                R.id.navigation_home -> {
                    mAppBarMainBinding.contentMain.viewPager.currentItem = MainTab.HOME.position
                    return@setOnItemSelectedListener true
                }
                R.id.navigation_tree -> {
                    mAppBarMainBinding.contentMain.viewPager.currentItem = MainTab.TREE.position
                    return@setOnItemSelectedListener true
                }
                R.id.navigation_navi -> {
                    mAppBarMainBinding.contentMain.viewPager.currentItem = MainTab.NAVI.position
                    return@setOnItemSelectedListener true
                }
                R.id.navigation_project -> {
                    mAppBarMainBinding.contentMain.viewPager.currentItem = MainTab.PROJECT.position
                    return@setOnItemSelectedListener true
                }
            }
            false
        }

        /**
         * toolbar菜单事件
         */
        mAppBarMainBinding.toolbar.setOnMenuItemClickListener {
            when (it.itemId) {
                R.id.action_search -> {
                    startActivity(Intent(this, SearchActivity::class.java))
                }
                R.id.action_settings -> {
                    ToastUtil.show("设置")
                }
            }
            return@setOnMenuItemClickListener true
        }
    }

    private var mExitTime: Long = 0 // 保存用户按返回键的时间

    /**
     * 拦截返回事件，自处理
     */
    private fun setupBackPressedCallback() {
        val callback = object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                if (mBinding.drawerLayout.isDrawerOpen(GravityCompat.START)) {
                    mBinding.drawerLayout.closeDrawer(GravityCompat.START)
                } else {
                    if ((System.currentTimeMillis() - mExitTime) > 2000) {
                        ToastUtil.show("再按一次退出" + resources.getString(R.string.wanandroid))
                        mExitTime = System.currentTimeMillis()
                    } else {
                        ActivityUtil.closeAllActivity()
                    }
                }
            }
        }
        onBackPressedDispatcher.addCallback(this, callback)
    }

    @Suppress("OVERRIDE_DEPRECATION")
    override fun onBackPressed() {
        super.onBackPressed()
    }
}

//底部导航栏
enum class MainTab(val position: Int, val titleResId: Int) {
    HOME(0, R.string.title_home),
    TREE(1, R.string.title_tree),
    NAVI(2, R.string.title_navi),
    PROJECT(3, R.string.title_project)
}
