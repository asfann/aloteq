import 'package:aloteq/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:aloteq/services/http_service.dart';

class CryptoScreen extends StatefulWidget {
  //
  CryptoScreen() : super();

  @override
  _CryptoScreenState createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cryptos'),
      ),
      body: Column(
        children: [
          buildSearch(),
          Expanded(child:FutureBuilder<List<Crypto>>(
            future: Httpservice().getCryptos(),
            builder: (context,snapshot){
    if(snapshot.hasError){
    return const Center(
    child: Text('An error has occured!'),
    );
    }else if (snapshot.hasData) {
          return CryptoList(cryptos: snapshot.data!);
    }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
    }

            }
          ),
          )],
      )
    );


  }

}
class CryptoList extends StatelessWidget {

  const CryptoList({Key? key, required this.cryptos}) : super(key: key);

  final List<Crypto> cryptos;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ), itemCount: cryptos.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text("${cryptos[index].data[index].name}"),
      );
    });

  }
  }

Widget buildSearch() => SearchWidget(
  text: query,
  hintText: 'Enter Crypto',
  onChanged: searchCurrency,
);


