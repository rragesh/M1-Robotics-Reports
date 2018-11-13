/********************************************************************************
** Form generated from reading UI file 'player.ui'
**
** Created by: Qt User Interface Compiler version 5.5.1
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_PLAYER_H
#define UI_PLAYER_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QToolBar>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_player
{
public:
    QMenuBar *menuBar;
    QToolBar *mainToolBar;
    QWidget *centralWidget;
    QStatusBar *statusBar;

    void setupUi(QMainWindow *player)
    {
        if (player->objectName().isEmpty())
            player->setObjectName(QStringLiteral("player"));
        player->resize(400, 300);
        menuBar = new QMenuBar(player);
        menuBar->setObjectName(QStringLiteral("menuBar"));
        player->setMenuBar(menuBar);
        mainToolBar = new QToolBar(player);
        mainToolBar->setObjectName(QStringLiteral("mainToolBar"));
        player->addToolBar(mainToolBar);
        centralWidget = new QWidget(player);
        centralWidget->setObjectName(QStringLiteral("centralWidget"));
        player->setCentralWidget(centralWidget);
        statusBar = new QStatusBar(player);
        statusBar->setObjectName(QStringLiteral("statusBar"));
        player->setStatusBar(statusBar);

        retranslateUi(player);

        QMetaObject::connectSlotsByName(player);
    } // setupUi

    void retranslateUi(QMainWindow *player)
    {
        player->setWindowTitle(QApplication::translate("player", "player", 0));
    } // retranslateUi

};

namespace Ui {
    class player: public Ui_player {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_PLAYER_H
