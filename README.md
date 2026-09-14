# Win11Debloat 简体中文汉化版

> **上游项目**：[Raphire/Win11Debloat](https://github.com/Raphire/Win11Debloat)（原作者 Raphire，MIT 协议）
> 本仓库在上游基础上进行了完整的简体中文汉化，遵循 MIT 协议保留原作者版权（见 [LICENSE](LICENSE)）。
> 上游文档与问题反馈：[官方 Wiki](https://github.com/Raphire/Win11Debloat/wiki) · [原版 Issues](https://github.com/Raphire/Win11Debloat/issues)

---

## 这是什么

Win11Debloat 是一个轻量、易用的 PowerShell 脚本工具，无需安装，用于快速精简和自定义 Windows 体验：移除预装应用、禁用遥测、清理侵入性界面元素等，免去在系统设置里逐项手动操作的麻烦。它同时提供强大的命令行接口、Windows 审计模式（Sysprep）支持，以及面向其他用户配置文件的更改能力。

> [!WARNING]
> 本工具尽可能避免破坏系统功能，但请自行承担使用风险。如遇问题可向上游报告。

## 主要功能

- **应用移除**：移除 141 种常见预装应用（Bing 系列、Xbox、Cortana、Teams、OEM 厂商软件等），支持 WinGet 与 Appx 双通道，移除后可校验
- **隐私与建议内容**：禁用遥测、诊断数据、活动历史、应用启动跟踪、定向广告、各种提示与建议内容
- **AI 功能**：禁用并移除 Microsoft Copilot、Windows Recall、Click To Do，阻止 AI 服务自启，禁用 Edge/画图/记事本中的 AI 功能
- **系统**：禁用拖动托盘、恢复 Win10 经典右键菜单、关闭鼠标加速、禁用粘滞键快捷键、禁用存储感知、快速启动、BitLocker 自动加密、现代待机联网
- **Windows 更新**：阻止抢先获取更新、登录状态下阻止更新后自动重启、禁用传递优化、阻止自动安装设备配套应用
- **外观**：深色模式、禁用透明效果与动画、管理 Windows 聚焦桌面背景
- **开始菜单与搜索**：清除/替换固定应用、隐藏推荐区域、自定义“所有应用”视图、禁用手机连接集成、禁用 Bing 网页搜索与商店应用建议
- **任务栏**：对齐方式、搜索样式、合并按钮、多显示器行为、小组件、结束任务选项、上次活动点击
- **文件资源管理器**：默认打开位置、显示扩展名/隐藏文件、隐藏导航窗格各区域、驱动器号位置、常用文件夹
- **多任务**：窗口贴靠、贴靠助手、Alt+Tab 标签页显示数量
- **可选功能**：启用 Windows 沙盒、适用于 Linux 的 Windows 子系统（WSL）
- **其他**：Xbox 游戏栏集成与录制、Brave 浏览器冗余功能

## 使用方法

> [!IMPORTANT]
> 必须使用 **Windows PowerShell 5.1**（powershell.exe）运行，不支持 PowerShell 7；需要管理员权限。

**方式一：双击启动**
双击仓库中的 `Run.bat`，接受 UAC 提权提示即可。

**方式二：PowerShell 手动运行（推荐）**
```powershell
cd C:\你的路径\Win11Debloat
Set-ExecutionPolicy Bypass -Scope Process -Force
.\Win11Debloat.ps1
```

**方式三：带参数运行**
```powershell
# 强制使用中文界面（中文系统下自动生效，无需此参数）
.\Win11Debloat.ps1 -Language zh-CN

# 静默应用默认推荐设置
.\Win11Debloat.ps1 -RunDefaults -Silent

# 预演模式，不改动系统
.\Win11Debloat.ps1 -WhatIf
```

完整参数列表见上游 Wiki 的 [Command-line Interface](https://github.com/Raphire/Win11Debloat/wiki/Command%E2%80%90line-Interface) 页面。

## 本仓库的汉化内容

| 层 | 覆盖范围 | 实现方式 |
|---|---|---|
| 语言包 | GUI 全部界面文案（322 键）、103 个功能描述、12 个分类、10 个选项分组 | 新增 `Config/Languages/zh-CN/`，零侵入 |
| 应用目录 | 141 个应用的名称与描述、2 个预设名 | 新增 `AppDetails.json` 覆盖表 + 3 处 FileIO 机制扩展 |
| 代码层 | CLI 菜单、启动界面、进度/日志/错误消息等约 200 处 | 直接汉化约 44 个 `.ps1` |

中文系统（UI 文化为 `zh-CN`）下**自动生效**；任何缺失的翻译键自动回退英文，界面不会崩溃。语言机制与上游完全兼容。

详细的实现机制、文件清单、编码注意事项与维护指南见 **[汉化说明](汉化说明.md)**。

## 汉化维护要点（速览）

1. **编码**：所有含中文的 `.ps1` 必须保存为 **UTF-8 with BOM**，否则 PowerShell 5.1 按 GBK 解析会报语法错误（详见汉化说明第五节）
2. **翻译完整性**：可用项目自带的 `Test-LanguageKeyCoverage -LanguageCode 'zh-CN'` 对比缺失键
3. **上游同步**：语言包为纯增量文件，易于合并；代码层中文文案与上游更新可能冲突

## 运行产物（不入库）

运行会在本地生成 `Logs/`（日志）、`Backups/`（注册表备份）、`Config/LastUsedSettings.json`（上次设置），均已被 `.gitignore` 排除，不会上传。

## 许可证

本项目遵循 [MIT 许可证](LICENSE)，原版权归 [Raphire](https://github.com/Raphire) 所有。汉化修改部分同样以 MIT 协议发布。
