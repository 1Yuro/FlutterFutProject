import 'package:flutter/material.dart';
import 'package:zipzip/pages/fullscreen.dart';
import 'package:zipzip/pages/ligtable.dart';
import 'package:zipzip/services/ApiServices.dart';
import 'package:video_player/video_player.dart';

class mainPage extends StatefulWidget {
  final String eposta;
  mainPage({required this.eposta});

  @override
  mainPageState createState() => mainPageState();
}

class mainPageState extends State<mainPage> {
  String kullaniciAdi = '';
  late VideoPlayerController _videoPlayerController;
  bool _isPlaying = false;
  bool _isMuted = false;
  bool fullscreen = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
        'assets/videoplayback.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.pause();
      });
    _fetchKullaniciAdi();
  }

  Future<void> _fetchKullaniciAdi() async {
    String adi = await ApiServices.EpostaEsitle(widget.eposta);
    setState(() {
      kullaniciAdi = adi;
    });
    //Kullanici girişi başarılı yaptığında bu ekran açılır.
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.green,
        title: const Text('Giriş Başarılı!',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
        content: Text('\n \n Hoşgeldin \n\n $kullaniciAdi',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tamam',style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },
  );
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futbol Uygulaması',
      home: Scaffold(
        body: _buildPage(), 
        bottomNavigationBar: _buildBottomNavigationBar(), 
      ),
    );
  }

  Widget _buildPage() {
    if (_selectedPageIndex == 1) {
      return oynat();
    } else if (_selectedPageIndex == 2) {
      return ligler();
    } else if (_selectedPageIndex == 3) {
      return ayarlar();
    } else {
      return anasayfa();
    }
  }

  int _selectedPageIndex = 0;

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(255, 23, 83, 25),
      currentIndex: _selectedPageIndex,
      onTap: (int index) {
        setState(() {
          _selectedPageIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.newspaper),
          label: 'Anasayfa',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.play_circle),
          label: 'Oynat',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.leaderboard),
          label: 'Lig',
          backgroundColor: Colors.green,),
        BottomNavigationBarItem(
          icon: new Icon(Icons.settings),
          label: 'Ayarlar',
          backgroundColor: Colors.green,
        ),

      ],
    );
  }

  Widget ayarlar() {
  return Container(
    color: Colors.green[800],
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ayarlar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
        InkWell(
          onTap: () {},
          child: ListTile(
            iconColor: Color.fromARGB(255, 108, 173, 110),
            textColor: Colors.white,
            leading: Icon(Icons.music_note),
            title: Text('Ses Ayarı'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            iconColor: Color.fromARGB(255, 108, 173, 110),
            textColor: Colors.white,
            leading: Icon(Icons.person),
            title: Text('Hesap Ayarı'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            iconColor: Color.fromARGB(255, 108, 173, 110),
            textColor: Colors.white,
            leading: Icon(Icons.image),
            title: Text('Görüntü Ayarı'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    ),
  );
}

  Widget oynat() {
    double aspectRatio = _videoPlayerController.value.aspectRatio;
      return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: aspectRatio,
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(),
        ),
        Positioned(
          bottom: -5,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.green[800],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [                
                IconButton(
                icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                color: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isMuted = !_isMuted;
                      if (_isMuted) {
                        _videoPlayerController.setVolume(0);
                      } else {
                        _videoPlayerController.setVolume(1);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                      if (_isPlaying) {
                        _videoPlayerController.play();
                      } else {
                        _videoPlayerController.pause();
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.fullscreen),
                  color: Colors.white,
                  onPressed: () {                  
                    Navigator.of(context).push
                    (
                      MaterialPageRoute(builder: (context) => FullScreenPlayer(videoPlayerController: _videoPlayerController)),
                    );                   
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget anasayfa() {
    return ListView.builder(
    itemCount: 21,
    itemBuilder: (context, index) {
    return ListTile(
    leading: Icon(Icons.sports_soccer, color: Color.fromARGB(255, 108, 173, 110)),
    title: Text('Futbol Haberi $index', style: TextStyle(color: Colors.white)),
    tileColor: Colors.green[800],
        ) ;
      },
    );
    
  }
  
  Widget ligler() {
  return Container(
    color: Colors.green[800],
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ScoreTable();
              }),
            );
          },
          style: ElevatedButton.styleFrom(primary: Colors.green[900],),
          child: Text('Çalışan Lige git'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          child: Text('Y Ligine git'),
          style: ElevatedButton.styleFrom(primary: Colors.green[900],),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          child: Text('Z Ligine git'),
          style: ElevatedButton.styleFrom(primary: Colors.green[900],),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          child: Text('M Ligine git'),
          style: ElevatedButton.styleFrom(primary: Colors.green[900],),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          child: Text('K Ligine git'),
          style: ElevatedButton.styleFrom(primary: Colors.green[900],),
        ),
      ],
    ),
  );
}
}
