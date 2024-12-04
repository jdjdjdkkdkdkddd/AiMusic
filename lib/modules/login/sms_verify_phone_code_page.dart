import 'package:ai_music/themes/theme_color.dart';
import 'package:ai_music/widgets/common_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/status_bar_playce_holder.dart';

class SmsVerifyPhoneCodePage extends StatelessWidget {
  const SmsVerifyPhoneCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatusBarPlaceHolder(),
          _buildActionBar(context),
          const SizedBox(
            height: 40,
          ),
          Text(
            "输入验证码",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "验证码已经发送到+86 xxx",
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white.withAlpha(90)),
          ),
          const SizedBox(
            height: 40,
          ),
          _buildInputCodeWidget(),
          const SizedBox(
            height: 60,
          ),
          _buildLoginButton(context),
        ],
      ),
    );
  }

  _buildActionBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  _buildInputCodeWidget() {
    // 创建4个验证码输入框的控制器
    final List<TextEditingController> controllers = List.generate(
      4,
      (index) => TextEditingController(),
    );

    // 创建4个FocusNode用于控制焦点
    final List<FocusNode> focusNodes = List.generate(
      4,
      (index) => FocusNode(),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        4,
        (index) => SizedBox(
          width: 60,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: "", // 隐藏字符计数器
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                // 当输入一个字符时,自动跳转到下一个输入框
                if (index < 3) {
                  focusNodes[index].unfocus();
                  focusNodes[index + 1].requestFocus();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  _buildLoginButton(BuildContext context) {
    return CommonButton(
      text: '登陆',
      onPressed: () {
        // // 获取所有输入框的验证码并拼接
        // final code = controllers.map((c) => c.text).join();

        // // 发送验证码验证请求
        // final response = await DioUtils.get(
        //   path: '/captcha/verify?phone=$phone&captcha=$code'
        // );

        // if (response != null && response['code'] == 200) {
        //   // 验证成功,返回首页
        //   RouteHelper.popUntil(context, AppRoutes.home);
        // } else {
        //   // 验证失败,显示错误提示
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text('验证失败: ${response?['message'] ?? '未知错误'}'),
        //     ),
        //   );
        // }
      },
    );
  }
}
