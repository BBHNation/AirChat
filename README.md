# AirChat   (Multipeer Connectivity)
An iOS APP using blue tooth to chat and share documents


##features
####主要功能前提都在于主干网络切断的时候使用（通过蓝牙和WLAN实现）
- 名片展示，浏览与添加
- 传输文件（图片，视频，本地联系人）
- 聊天（1对1，多人聊天）

##使用的API模块有

- 通过Photos来获取本机图片与视频
- 通过Contact来获取本机联系人
- 通过KVO模式来加载数据
- 通过MultipeerConnectivity来分享和近距离沟通
