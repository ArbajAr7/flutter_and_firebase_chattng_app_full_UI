import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_amo/presentation/bloc/communication/communication_cubit.dart';
class SingleCommunicationPage extends StatefulWidget {
  final String senderUID;
  final String recipientUID;
  final String senderName;
  final String recipientName;
  final String recipientPhoneNumber;
  final String senderPhoneNumber;

  const SingleCommunicationPage(
      {Key key,
      this.senderUID,
      this.recipientUID,
      this.senderName,
      this.recipientName,
      this.recipientPhoneNumber,
      this.senderPhoneNumber})
      : super(key: key);

  @override
  _SingleCommunicationPageState createState() =>
      _SingleCommunicationPageState();
}

class _SingleCommunicationPageState extends State<SingleCommunicationPage> {

  @override
  void initState() {
    BlocProvider.of<CommunicationCubit>(context).getMessages(
      senderId: widget.senderUID,
      recipientId: widget.recipientUID,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        automaticallyImplyLeading: false,
        actions: [
          Icon(Icons.videocam),
          SizedBox(width: 10),
          Icon(Icons.call),
          SizedBox(width: 10),
          Icon(Icons.more_vert),
        ],
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 28),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 22,
                  )),
              Container(
                height: 40,
                width: 40,
                child: Image.asset('assets/profile_default.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${widget.recipientName}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
      body: BlocBuilder<CommunicationCubit,CommunicationState>(
        builder: (_,communicationState){
          if(communicationState is CommunicationLoaded){
            return _bodywidget(communicationState);
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  Widget _bodywidget(CommunicationLoaded communicationState) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Image.asset("assets/background_wallpaper.png",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
