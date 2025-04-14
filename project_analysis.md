# 结构

## 模块拆分

```text
app/src/main/java/com/yechaoa/wanandroid_jetpack/
├── base                  // 基础框架层
│   ├── BaseActivity      // Activity基类
│   ├── BaseFragment      // Fragment基类
│   ├── BaseRepository    // 数据仓库基类
│   ├── BaseViewModel     // ViewModel基类
│   └── BaseVmActivity    // 带ViewModel的Activity基类
│   └── BaseVmFragment    // 带ViewModel的Fragment基类
├── common                // 公共配置
│   └── MyConfig          // 全局配置常量
├── data                  // 数据层
│   ├── bean              // 数据模型
│   │   ├── Article       // 文章实体
│   │   ├── Navi          // 导航实体
│   │   └── ...
│   ├── http              // 网络请求
│   │   ├── ApiException  // 自定义API异常
│   │   └── ApiService    // 接口服务定义
├── ui                    // 界面层
│   ├── about             // 关于页面
│   ├── adapter           // 适配器
│   │   └── CommonViewPagerAdapter  // 通用ViewPager适配器
│   ├── collect           // 收藏功能
│   ├── detail            // 详情页
│   ├── login             // 登录模块
│   │   ├── LoginActivity     // 登录界面
│   │   ├── LoginRepository   // 登录数据仓库
│   │   ├── LoginViewModel    // 登录视图模型
│   │   └── AgreementDialog   // 协议对话框
│   ├── main              // 主界面
│   │   ├── MainActivity      // 主界面Activity
│   │   ├── home              // 首页模块
│   │   ├── navi              // 导航模块
│   │   │   ├── NaviFragment      // 导航Fragment
│   │   │   ├── NaviRepository    // 导航数据仓库
│   │   │   └── NaviViewModel     // 导航视图模型
│   │   ├── pro               // 项目模块
│   │   └── tree              // 体系模块
│   ├── register          // 注册模块
│   └── search            // 搜索模块
└── util                  // 工具类
    ├── setOnclickNoRepeat  // 防重复点击
    └── randomColor         // 随机颜色工具
```

## 整体结构特性

- 模块化设计

生命周期安全：利用Jetpack组件，实现生命周期安全的数据加载和UI更新
代码解耦：清晰的职责划分，降低模块间耦合度
扩展性好：基于接口和抽象类的设计，便于功能扩展
性能优化：

- ViewPager懒加载策略

- RecyclerView高效复用机制

- 分页加载减轻内存压力

  

用户体验：

- 流畅的列表滚动

- 响应式UI更新

- 友好的加载状态和错误处理

  

该项目遵循了Android现代开发的最佳实践，采用MVVM架构和Jetpack组件，实现了一个结构清晰、易于维护的WanAndroid客户端应用。通过合理的分层设计和状态管理，提供了良好的用户体验和开发体验。





# 功能模块





## 登录后首页加载

```mermaid
sequenceDiagram
    participant User
    participant LoginActivity
    participant MainActivity
    participant HomeFragment
    participant ViewModel
    participant Repository
    participant API

    User->>LoginActivity: 输入账号密码点击登录
    LoginActivity->>ViewModel: 调用login()方法
    ViewModel->>Repository: 发起登录请求
    Repository->>API: 网络请求
    API-->>Repository: 返回登录结果
    Repository-->>ViewModel: 处理返回数据
    ViewModel-->>LoginActivity: 更新loginState LiveData
    
    Note over LoginActivity: observe监听到loginState变为true
    
    LoginActivity->>MainActivity: 跳转到主页
    MainActivity->>HomeFragment: 加载首页Fragment
    HomeFragment->>ViewModel: 初始化HomeViewModel
    HomeFragment->>ViewModel: 调用initData()请求数据
    ViewModel->>Repository: 获取首页文章列表
    Repository->>API: 网络请求
    API-->>Repository: 返回文章数据
    Repository-->>ViewModel: 解析数据
    ViewModel-->>HomeFragment: 更新articleList LiveData
    
    Note over HomeFragment: observe监听到articleList更新
    
    HomeFragment->>HomeFragment: 更新RecyclerView显示
    
    User->>HomeFragment: 滚动列表
    HomeFragment->>ViewModel: 检测滚动到底部,请求下一页
    ViewModel->>Repository: 获取下一页数据
    Repository->>API: 分页请求
    API-->>Repository: 返回新数据
    Repository-->>ViewModel: 解析新数据
    ViewModel-->>HomeFragment: 更新articleList LiveData
    HomeFragment->>HomeFragment: 在列表底部追加新数据
```

