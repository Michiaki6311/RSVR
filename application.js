$(function() {
    //一定時間後に処理を行う（0.8秒後）
    setTimeout(function() {
      //idが"notice"のdiv要素をゆっくりとフェードアウト
      $('#notice').fadeOut("slow");
      }, 800);
    });
