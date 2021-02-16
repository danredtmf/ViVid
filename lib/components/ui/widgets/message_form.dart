import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  final ValueChanged<String> onSubmit;

  MessageForm({Key key, this.onSubmit}) : super(key: key);

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final _controller = TextEditingController();

  String _message;

  void _onPressed() {
    widget.onSubmit(_message);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              maxLength: 500,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                hintText: 'Сообщение...',
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none
                ),
                contentPadding: const EdgeInsets.all(10)
              ),
              minLines: 1,
              maxLines: 10,
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
          ),
          SizedBox(width: 5),
          Container(
            margin: EdgeInsets.only(bottom: 22),
            child: RawMaterialButton(
              onPressed: _message == null || _message.isEmpty ? null : _onPressed,
              fillColor: _message == null || _message.isEmpty 
                ? Colors.blueGrey 
                : Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}