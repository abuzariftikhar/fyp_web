import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_web/homebloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController ipController;
  TextEditingController controlPortController;
  TextEditingController streamPortController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ipController = TextEditingController();
    controlPortController = TextEditingController();
    streamPortController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(builder: (context, HomeBloc homeBloc, w) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.settings),
                          color: Colors.black,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      backgroundColor: Colors.grey.shade100,
                                      elevation: 5,
                                      scrollable: true,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Consumer(builder:
                                              (context, HomeBloc homeBloc, w) {
                                            return Form(
                                              key: _formKey,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.all(20),
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 20,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.1),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Icon(
                                                        CupertinoIcons
                                                            .settings_solid,
                                                        color: Colors.black,
                                                        size: 44,
                                                      ),
                                                    ),
                                                    Text(
                                                        'Configure ip & and port numbers for RaspberryPi streaming and control server.'),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (!(value.contains(
                                                                '.') &&
                                                            value.contains(
                                                                '.') &&
                                                            value.contains(
                                                                '.'))) {
                                                          return 'Invalid ip address';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              'RaspberryPi ip',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5))),
                                                      controller: ipController,
                                                      onSaved: (s) {
                                                        homeBloc.raspberryPiIP =
                                                            ipController.text;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    TextFormField(
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.length < 4 ||
                                                            value.length > 6) {
                                                          return 'Invalid port no';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              'RaspberryPi port no',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5))),
                                                      controller:
                                                          controlPortController,
                                                      onSaved: (s) {
                                                        homeBloc.raspberryPiPort =
                                                            controlPortController
                                                                .text;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    TextFormField(
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.length < 4 ||
                                                            value.length > 6) {
                                                          return 'Invalid port no';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              'Streaming port no',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5))),
                                                      controller:
                                                          streamPortController,
                                                      onSaved: (s) {
                                                        homeBloc.raspberryPiPort =
                                                            streamPortController
                                                                .text;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          color: Colors.cyan,
                                          child: Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();
                                              Navigator.of(context).pop();
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                      backgroundColor:
                                                          Colors.blueGrey,
                                                      content: Text(
                                                          'Changes saved successfully')));
                                            } else
                                              return;
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                    backgroundColor:
                                                        Colors.blueGrey,
                                                    content: Text(
                                                        'No changes were made.')));
                                          },
                                        )
                                      ],
                                    ));
                          }),
                      NavTab(),
                    ],
                  ),
                ),
                homeBloc.index == 0 ? Tab1() : Tab2(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class NavTabItem extends StatefulWidget {
  final String title;
  final int index;

  NavTabItem({@required this.index, @required this.title});
  @override
  _NavTabItemState createState() => _NavTabItemState();
}

class _NavTabItemState extends State<NavTabItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeBloc homeBloc, w) {
        return GestureDetector(
          onTap: () {
            homeBloc.index = widget.index;
            homeBloc.update();
          },
          child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 400),
                  style: TextStyle(
                      color: widget.index == homeBloc.index
                          ? Colors.blue
                          : Colors.grey.shade700),
                  child: Text(
                    widget.title,
                  ),
                ),
              )),
        );
      },
    );
  }
}

class NavTab extends StatefulWidget {
  _NavTabState createState() => _NavTabState();
}

class _NavTabState extends State<NavTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeBloc homeBloc, w) {
        return Align(
          alignment: Alignment.topCenter,
          child: Transform.scale(
            scale: 0.8,
            child: Container(
              height: 70,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffe8e8e8)),
              child: Stack(
                children: [
                  AnimatedAlign(
                    curve: Curves.ease,
                    alignment: homeBloc.index == 0
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    duration: Duration(milliseconds: 400),
                    child: AnimatedContainer(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 54,
                      width: homeBloc.index == 0 ? 110 : 160,
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NavTabItem(index: 0, title: 'Controlling'),
                        NavTabItem(index: 1, title: 'Video Surveillance'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HomeBloc homeBloc, widget) {
      return Column(
        children: [
          PirStatusWidget(),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Show live video stream',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CupertinoSwitch(
                      value: homeBloc.videoStream,
                      onChanged: (w) {
                        homeBloc.videoStream = !homeBloc.videoStream;
                        homeBloc.update();
                      })
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                      margin: EdgeInsets.only(
                          bottom: homeBloc.videoStream
                              ? MediaQuery.of(context).size.width * 0.7
                              : 20),
                      height: MediaQuery.of(context).size.width * 0.6,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: StreamingPlayerWidget()),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    height: MediaQuery.of(context).size.width * 0.6,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25)),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DirectionButton(angle: 0, direction: 'Forward'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DirectionButton(angle: 3, direction: 'Left'),
                                Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.black,
                                ),
                                DirectionButton(angle: 1, direction: 'Right'),
                              ],
                            ),
                            DirectionButton(angle: 2, direction: 'Reverse'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class Tab2 extends StatefulWidget {
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HomeBloc homeBloc, w) {
      return Container();
    });
  }
}

class DirectionButton extends StatefulWidget {
  final int angle;
  final String direction;
  DirectionButton({@required this.angle, @required this.direction});
  @override
  _DirectionButtonState createState() => _DirectionButtonState();
}

class _DirectionButtonState extends State<DirectionButton> {
  bool newStatus = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HomeBloc homeBloc, w) {
      return Listener(
        onPointerDown: (detils) {
          setState(() {
            newStatus = true;
          });
          var client = http.Client();
          try {
            var url =
                'http://${homeBloc.raspberryPiIP}:${homeBloc.raspberryPiPort}/${widget.direction}';

            client.post(url,
                body: json.encode({'status': newStatus}),
                headers: {'Content-type': 'application/json'}).then((response) {
              print('status: ${newStatus.toString()}');
            });
          } finally {
            client.close();
          }
        },
        onPointerUp: (details) {
          setState(() {
            newStatus = false;
          });
          var client = http.Client();
          try {
            var url =
                'http://${homeBloc.raspberryPiIP}:${homeBloc.raspberryPiPort}/Stop';

            client.post(url,
                body: json.encode({'status': newStatus}),
                headers: {'Content-type': 'application/json'}).then((response) {
              print('status: ${newStatus.toString()}');
            });
          } finally {
            client.close();
          }
        },
        child: RotatedBox(
          quarterTurns: widget.angle,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 60,
            width: 50,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1))
              ],
              color: newStatus ? Colors.grey.shade700 : Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: newStatus
                      ? Colors.lightGreenAccent
                      : Colors.grey.shade700,
                )),
          ),
        ),
      );
    });
  }
}

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  TextEditingController ipController;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    CupertinoIcons.loop_thick,
                    color: Colors.black,
                    size: 44,
                  ),
                ),
                Text('RaspberryPi Surveillance App'),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (!(value == 'admin')) {
                      return 'Incorrect username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  controller: ipController,
                  onSaved: (s) {},
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (!(value == 'admin123')) {
                      return 'Incorrect password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Passowrd',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  controller: ipController,
                  onSaved: (s) {},
                ),
                SizedBox(
                  height: 15,
                ),
                CupertinoButton(
                  color: Colors.cyan,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return IPConfigPage();
                      }));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IPConfigPage extends StatefulWidget {
  @override
  _IPConfigPageState createState() => _IPConfigPageState();
}

class _IPConfigPageState extends State<IPConfigPage> {
  TextEditingController ipController;
  TextEditingController controlPortController;
  TextEditingController streamPortController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ipController = TextEditingController();
    controlPortController = TextEditingController();
    streamPortController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, HomeBloc homeBloc, w) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      CupertinoIcons.loop_thick,
                      color: Colors.black,
                      size: 44,
                    ),
                  ),
                  Text(
                      'Configure ip & and port numbers for RaspberryPi streaming and control server.'),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (!(value.contains('.') &&
                          value.contains('.') &&
                          value.contains('.'))) {
                        return 'Invalid ip address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'RaspberryPi ip',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    controller: ipController,
                    onSaved: (s) {
                      homeBloc.raspberryPiIP = ipController.text;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.length < 4 || value.length > 6) {
                        return 'Invalid port no';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'RaspberryPi port no',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    controller: controlPortController,
                    onSaved: (s) {
                      homeBloc.raspberryPiPort = controlPortController.text;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.length < 4 || value.length > 6) {
                        return 'Invalid port no';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Streaming port no',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    controller: streamPortController,
                    onSaved: (s) {
                      homeBloc.raspberryPiPort = streamPortController.text;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CupertinoButton(
                    color: Colors.cyan,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        homeBloc.update();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Done'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class StreamingPlayerWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isRunning = useState(true);
    return Consumer(builder: (context, HomeBloc homeBloc, w) {
      return Expanded(
        child: Center(
          child: Mjpeg(
            isLive: isRunning.value,
            stream:
                'http://${homeBloc.raspberryPiIP}:${homeBloc.raspberryPiPort}/stream.mjpg',
          ),
        ),
      );
    });
  }
}

class PirStatusWidget extends StatefulWidget {
  @override
  _PirStatusWidgetState createState() => _PirStatusWidgetState();
}

class _PirStatusWidgetState extends State<PirStatusWidget> {
  String body = '';
  bool newStatus = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HomeBloc homeBloc, w) {
      return GestureDetector(
        onTap: () {
          var client = http.Client();
          try {
            var url =
                'http://${homeBloc.raspberryPiIP}:${homeBloc.raspberryPiPort}/ReadPIR';

            client.post(url,
                body: json.encode({'status': newStatus}),
                headers: {'Content-type': 'application/json'}).then((response) {
              body = response.body;
              print(body);
            });
          } finally {
            client.close();
          }
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
              color:
                  body == 'good' ? Colors.red.shade100 : Colors.green.shade100,
              borderRadius: BorderRadius.circular(10)),
          height: 60,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Status: '),
              Text(body == 'good' ? 'Intruder Present.' : 'All Clear.'),
            ],
          ),
        ),
      );
    });
  }
}
