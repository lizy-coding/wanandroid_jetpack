# Module: Login (登录模块)
> Date: 2024-12-24 | Status: Done

## Anchors
| File | Description |
|------|-------------|
| `ui/login/LoginActivity.kt` | 登录界面，表单验证，协议弹窗 |
| `ui/login/LoginViewModel.kt` | 登录状态管理，API调用 |
| `ui/login/LoginRepository.kt` | 数据层封装 |
| `ui/login/AgreementDialog.kt` | 服务协议弹窗 (BottomSheet) |
| `res/layout/activity_login.xml` | 登录布局 |

## Key Concepts

### 1. 表单验证 (form_validation)
- `attemptLogin()` 实现空值校验
- 使用 `EditText.error` 显示错误提示
- `focusView.requestFocus()` 聚焦错误字段

### 2. MVVM 数据流
```
LoginActivity.doLogin()
    ↓
LoginViewModel.login()
    ↓
LoginRepository.login()
    ↓
Api.login() [Retrofit]
    ↓
LiveData<Boolean> → observe() → 跳转/提示
```

### 3. 协议弹窗 (AgreementDialog)
- 继承 `BaseBottomSheetDialog`
- 使用 `SpannableStringBuilder` 实现可点击文本
- 回调模式: `clickListener: (String) -> Unit`

### 4. 沉浸式状态栏
- `ImmersionBar.with(this).fitsSystemWindows(true).transparentStatusBar()`

### 5. 防重复点击
- `setOnclickNoRepeat {}` 扩展函数

## Interview Focus

| Category | Topics |
|----------|--------|
| Fundamentals | input_validation, EditText.error, SpannableString, ClickableSpan |
| Architecture | MVVM, LiveData封装(_loginState vs loginState), Repository模式 |
| Performance | 防抖点击, 键盘关闭时机, Loading状态管理 |
| Pitfalls | 协议未勾选拦截, 登录失效code(-1001), Activity泄漏 |

## Code Highlights

**LiveData 封装模式** (`LoginViewModel.kt:16-17`):
```kotlin
private val _loginState = MutableLiveData<Boolean>()
val loginState: LiveData<Boolean> = _loginState
```

**表单验证** (`LoginActivity.kt:65-91`):
```kotlin
private fun attemptLogin() {
    var cancel = false
    var focusView: View? = null

    if (password.isEmpty()) {
        mBinding.etPassword.error = "密码不能为空"
        focusView = mBinding.etPassword
        cancel = true
    }
    // ...
    if (cancel) focusView?.requestFocus()
    else doLogin(username, password)
}
```

**协议弹窗回调** (`LoginActivity.kt:48-58`):
```kotlin
AgreementDialog(getAgreementTip()) { btn ->
    when (btn) {
        AgreementDialog.AGREE -> {
            mBinding.cbServiceAgreement.isChecked = true
            attemptLogin()
        }
        AgreementDialog.NOT_AGREE -> {
            ToastUtil.show("同意服务协议与隐私政策后才能登录哦")
        }
    }
}.show(supportFragmentManager, "AgreementDialog")
```

## Hands-on Tasks

1. **添加密码强度校验**: 在 `attemptLogin()` 中增加密码长度/复杂度验证
2. **实现记住密码**: 使用 `SpUtil` 存储用户名，下次自动填充
3. **添加登录Loading动画**: 替换 `YUtils.showLoading()` 为 MaterialButton loading 状态
4. **单元测试**: 为 `LoginViewModel.login()` 编写 Mock 测试

## Follow-up

1. 登录成功后 Cookie 如何持久化？(→ data 模块)
2. 注册模块与登录模块的代码复用情况？
3. 如何实现生物识别登录？

---
## Learning Notes
<!-- Add your notes here -->
