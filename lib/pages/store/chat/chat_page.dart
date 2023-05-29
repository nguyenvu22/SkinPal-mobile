import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/pages/store/chat/chat_controller.dart';

class ChatPage extends StatefulWidget {
  ChatController con = Get.put(ChatController());

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();

  // auto scroll down after texting a new message
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scheduleScrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.coreColor,
        body: Column(
          children: [
            SizedBox(
              height: h * 0.04,
            ),
            Expanded(
              child: _topSection(),
            ),
            _chatSection(w, h),
          ],
        ),
      ),
    );
  }

  Widget _topSection() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 40),
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 3,
                      color: Colors.white,
                    ),
                  ),
                  child: Image.asset(
                    "assets/icons/icon_bot.png",
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "Bot Chat",
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _chatSection(w, h) {
    _scheduleScrollToBottom();
    return Container(
      width: double.infinity,
      height: h * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(w * 0.1),
          topRight: Radius.circular(w * 0.1),
        ),
      ),
      child: Column(
        children: [
          Obx(
            () => Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: w * 0.1,
                  horizontal: w * 0.1,
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.con.messages.length,
                  itemBuilder: (_, index) {
                    return _chatMessage(w, h, widget.con.messages[index]);
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                width: 1.5,
                color: Colors.black12,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.con.textController,
                    onSubmitted: (value) {
                      widget.con.sendMessage();
                      _scheduleScrollToBottom();
                    },
                    style: GoogleFonts.robotoSlab(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Type Message",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Divider(
                    thickness: 1.5,
                    height: 20,
                    color: Colors.red,
                  ),
                ),
                Bounce(
                  duration: const Duration(milliseconds: 200),
                  onPressed: () {
                    widget.con.sendMessage();
                    // _scheduleScrollToBottom();
                  },
                  child: const FaIcon(FontAwesomeIcons.solidPaperPlane),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatMessage(w, h, message) {
    return Row(
      mainAxisAlignment:
          message['isUser'] ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // Helping flexible width and max-width
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: w * 0.6,
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFF8933).withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message['message'],
              style: GoogleFonts.robotoSlab(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        
      ],
    );
  }
}
