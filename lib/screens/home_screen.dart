import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'wallet_screen.dart';
import 'wallet_creation_options_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;
  bool walletCreated = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/intro.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      }).catchError((error) {
        print('Error initializing video: $error');
      });

    // Check wallet creation status on init
    _checkWalletStatus();
  }

  Future<void> _checkWalletStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      walletCreated = prefs.getBool('walletCreated') ?? false;
    });
  }

  Future<void> _setWalletCreatedStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('walletCreated', status);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controller.value.isInitialized
                  ? SizedBox(
                      width: 150,
                      height: 150,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(height: 20),
              if (!walletCreated) ...[
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const WalletCreationOptionsScreen(),
                      ),
                    );
                    await _setWalletCreatedStatus(true);
                    setState(() {
                      walletCreated = true;
                    });
                  },
                  child: const Text(
                    'Create a new wallet',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    print('Import an existing wallet button pressed');
                  },
                  child: const Text(
                    'Import an existing wallet',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: walletCreated
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(Icons.account_balance_wallet),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WalletScreen()),
                );
              },
            )
          : null,
    );
  }
}
