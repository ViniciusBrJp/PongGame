int s;

int x;
int y; //球の中心
int dx;
int dy;//球の速度

int px;
int py; //プレイヤーの位置
int dpy; //プレイヤーの速さ

int ex;
int ey; //敵の位置
int dey; //敵の速度

int myP = 0;
int eneP = 0;

void setup() {
    size(960,540);
    rectMode(CENTER);
    colorMode(HSB,360,100,100);
    textAlign(CENTER);
    background(0,0,0);

    s = 0;

    x = width/2;
    y = height/2;
    dx = 7;
    dy = 0;
    px = width-width/30;
    py = height/2;
    dpy = 4;
    ex = width/30;
    ey = height/2;
    dey = 4;


    fill(0,0,100);
    ellipse(x,y,20,20);
    rect(px,py,4,80);
    rect(ex,ey,4,80);
}


void draw() {
    if (keyPressed) {
        if(key == ENTER) {
            s = 1;
        }
    }
    if (s == 1) {
        gameStart();
        fill(0,0,100);
        text(myP,width-width/10,height/2-200);
        text(eneP,width/10,height/2-200);
    } else {
        textSize(50);
        text("Press Enter to Start", width/2, height/2-50);
    }
    
}

void gameStart() {
    background(0,0,0);
    noStroke();
    fill(0,0,100);
    ellipse(x,y,20,20);
    fill(0,0,100);
    rect(px,py,4,80);
    rect(ex,ey,4,80);
    constrain(py,40,height - 40);
    constrain(ey,0,height);
    constrain(dy,0,10);
    playermove();
    enemymove();
    playerTouch();
    enemyTouch();
    x += dx;
    y += dy;
    if (y + 10 > height || y - 10 < 0) {
        dy = -dy;
    }
    gameOver();
}

void playermove() { //プレイヤーの動き
    if (keyPressed) {
        switch(keyCode) {
            case UP : py -= dpy ; break;
            case DOWN : py += dpy ; break;
        }
    }
}

void enemymove() {  //敵の動き
    if ( ey > y ) {
        ey -= dey;
    } else if (ey < y) {
        ey += dey;
    } else {
        ey = ey;
    }
}

void playerTouch() { //プレイヤーに当たる
    if (x + 10 > px - 2) {
    if (x + 10 < px + 5) {
        if (y - 5 < py + 40) { //当たる位置によるボールのｙ軸の変化
            if (y > py + 35) { //端ほどｙ速度が増加
                dx = -dx;
                if(dy >= 0) { //ボールのｙ速度による場合分け
                    dy += 3;
                }else if(dy < 0) {
                    dy -= 3;
                }
            } else if (y > py + 20) {
                dx = -dx;
                if(dy >= 0) {
                    dy += 2;
                }else if(dy < 0) {
                    dy -= 2;
                }
            } else if (y > py - 20) {
                dx = -dx;
            } else if (y > py -35) {
                dx = -dx;
                if(dy > 0) {
                    dy += 2;
                }else if(dy <= 0) {
                    dy -= 2;
                }
            } else
            if (y + 5 > py - 40) {
                dx = -dx;
                if(dy > 0) {
                    dy += 3;
                }else if(dy <= 0) {
                    dy -= 3;
                }
            }
        } 

    }
    } 
    
}

void enemyTouch() { //敵にあたる
    if (x - 10 < ex + 2) {
    if (x - 10 > ex - 5) {
        if (y  < ey + 40) {
            if (y > ey + 35) { //当たる位置によるボールのｙ軸の変化
                dx = -dx;
                dy += 3;
            } else
            if (y > ey + 20) {
                dx = -dx;
                dy += 2;
            } else
            if (y > ey - 20) {
                dx = -dx;
            } else
            if (y > ey -35) {
                dx = -dx;
                dy -= 2;
            } else
            if (y > ey - 40) {
                dx = -dx;
                dy -= 3;
            }
        } 
    }
    } 
}

void gameOver() { //終了
    if (x - 40 > width) {
        if(eneP < 2) {
            eneP += 1;
            s = 0;
            x = width / 2;
            y = height / 2;
            setup();
            draw();
        }else if(eneP == 2) {
            background(0,0,0);
            fill(0,100,100);
            textSize(50);
            text("You Lose",width/2,height/2);
            text("Press CTRL to Play Again",width/2,height/2 + 50);
            if (keyPressed) {
                if(keyCode == CONTROL) {
                    background(0,0,0);
                    s = 0;
                    x = width / 2;
                    y = height / 2;
                    myP = 0;
                    eneP = 0;
                    setup();
                    draw();
                }
            }
        }
    } else if (x + 40 < 0){
        if(myP < 2) {
            myP += 1;
            s = 0;
            x = width / 2;
            y = height / 2;
            setup();
            draw();
        }else if(myP == 2) {
            background(0,0,0);
            fill(0,100,100);
            textSize(50);
            text("You Won",width/2,height/2);
            text("Press CTRL to Play Again",width/2,height/2 + 50);
            if (keyPressed) {
                if(keyCode == CONTROL) {
                   background(0,0,0);
                    s = 0;
                    myP = 0;
                    eneP = 0;
                    x = width / 2;
                    y = height / 2;
                    setup();
                    draw();
                }
            }
        }
        }
}
    



