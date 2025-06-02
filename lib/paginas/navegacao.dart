import 'package:flutter/material.dart';

class ItemMenu {
  final String titulo;
  final IconData icone;
  final Widget destino;

  ItemMenu({
    required this.titulo,
    required this.icone,
    required this.destino,
  });
}

class NavegacaoDrawer extends StatelessWidget {
  final List<ItemMenu> itensMenu;

  NavegacaoDrawer({required this.itensMenu});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                'Menu Principal',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ...itensMenu.map((item) {
            return ListTile(
              leading: Icon(item.icone),
              title: Text(item.titulo),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => item.destino),
                );
              },
            );
          }).toList()
        ],
      ),
    );
  }
}
