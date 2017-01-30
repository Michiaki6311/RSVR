window.onload = function() {
  setCalendar();
};

// カレンダー生成（引数は前月や翌月移動に備えてのもの）
function setCalendar(yy, mm) {
  var yy, mm;
  // yy,mmが未定義なら（つまり一番最初にページを開いたときに）そのときの年月を変数yy,mmに付与する
  if (!yy && !mm) {
    var yy = new Date().getFullYear();
    var mm = new Date().getMonth();
    mm = mm + 1;
  }
  var zdate = new Date(yy,mm-1,0); // 前月末
  var tdate = new Date(yy,mm,0); // 当月末
  var zedd = zdate.getDate(); // 前月末日
  var zedy = zdate.getDay(); // 前月末曜日
  var tedd = tdate.getDate(); // 当月末日
  var tedy = tdate.getDay(); // 当月末曜日

  // カレンダーに埋める数字を配列daysに格納する（5行で済めば35要素、6行なら42要素）
  var days = [];

  // 前月末が土曜日以外（日曜日から0,1,2・・・土曜日が6）
  if (zedy != 6) {
    // 前月最終日曜日から月末曜日までの日付（for逆回しに注意）
    for (var i=zedy; i>=0; i--) {
      days[zedy-i] = (zedd - i);
    }
    // 当月日付
    for (var i=1; i<=tedd; i++) {
      days[zedy+i] = i;
    }
    // 当月末が35番目までに終了
    if ((zedy + tedd) <= 34) {
      // 翌月日付
      for (var i=1; i<=34-(zedy+tedd); i++) {
        days[zedy+tedd+i] = i;
      }
      // 当月末が35番目を超えて終了
    } else if((zedy + tedd) > 34) {
      // 翌月日付
      for (var i=1; i<42-zedy-tedd; i++) {
        days[zedy+tedd+i] = i;
      }
    }

    // 前月末が土曜日（何月であろうと5行で足りる）
  } else if(zedy == 6) {
    // 当月日付
    for (var i=1; i<=tedd; i++) {
      days[i-1] = i;
    }
    // 翌月日付
    for (var i=0; i<35-tedd; i++) {
      days[tedd+i] = i + 1;
    }
  }

  // DOM生成（いよいよ描画）
  var out = "<table class='table table-bordered'>";

  out += "<caption>";
  // 今月へ戻るリンク
  out += "<a href='javascript:void(0)' onclick='setCalendar();'>今月 </a>";
  // 前月へ移動リンク
  out += "<a href='javascript:void(0)' yy='"+yy+"' mm='"+mm+"' onclick='backmm(this);'>\<\< </a>";
  // 翌月へ移動リンク
  out += "<a href='javascript:void(0)' yy='"+yy+"' mm='"+mm+"' onclick='nextmm(this);'>\>\></a>";
  out += yy+'年'+mm+'月';
  out += "</caption>";

  // 曜日の表示（土日のみにクラスを付ける)
  var youbi = ["日", "月", "火", "水", "木", "金", "土"];
  out += "<tr class='calendarHd'>";
  for (var i in youbi) {
    if (i==0){
      out += "<td class='sun'>"+youbi[i]+"</td>";
  }else if (i==6){
    out += "<td class='sat'>"+youbi[i]+"</td>";
  }else
    out += "<td>"+youbi[i]+"</td>";
  }

  // ここからさきほど作った配列daysの中身を展開していく

  // 行数を計算する
  var nowYear = new Date().getFullYear();
  var nowMonth = new Date().getMonth()+1;
  var today = new Date().getDate();
  var row = days.length/7;
  // 行数分だけ回す
  for (var i=1; i<=row; i++) {
    out += "<tr>";
    // うまく説明できないが行の変動に対応できるように何とかして回す
    // 土日と今日の日付にはクラスを付け、cssで色をつける
    for (var j=7*i-6; j<=7*i; j++) {
      if(days[j-1] == today && mm == nowMonth && yy == nowYear){
      out += "<td class='tdlink today' row='"+i+"' yy='"+yy+"' mm='"+mm+"' dd='"+days[j-1]+"' onclick='show(this);return false;'>"+days[j-1]+"</td>";
      }else if((j-1)%7==0){
      out += "<td class='tdlink sun' row='"+i+"' yy='"+yy+"' mm='"+mm+"' dd='"+days[j-1]+"' onclick='show(this);return false;'>"+days[j-1]+"</td>";
      }else if(j%7==0){
      out += "<td class='tdlink sat' row='"+i+"' yy='"+yy+"' mm='"+mm+"' dd='"+days[j-1]+"' onclick='show(this);return false;'>"+days[j-1]+"</td>";
      }else
      // あとでいろいろいじれるように属性やイベントを混ぜておく
      out += "<td class='tdlink' row='"+i+"' yy='"+yy+"' mm='"+mm+"' dd='"+days[j-1]+"' onclick='show(this);return false;'>"+days[j-1]+"</td>";
    }
    out += "</tr>";
  }
  out += "</table>";

  // 最後にhtmlへどかっと渡す
  document.getElementById("result").innerHTML = out;
}

// 前月へ移動（年度をまたぐときはyyを調整する必要がある点に留意）
function backmm(e) {
  var yy = e.getAttribute('yy');
  var mm = e.getAttribute('mm');
  if (mm != 1) {
    mm = mm-1;
  } else if (mm == 1) {
    mm = 12;
    yy = yy - 1;
  }
  setCalendar(yy, mm);
}

// 翌月へ移動
function nextmm(e) {
  var yy = e.getAttribute('yy');
  var mm = e.getAttribute('mm');
  if (mm != 12) {
    mm = parseInt(mm) + 1; // mm-(-1)でも同じだがparseIntを使ってみた
  } else if (mm == 12) {
    mm = 1;
    yy = parseInt(yy) + 1;
  }
  setCalendar(yy, mm);
}

// 日付をクリックしたときに日付をアラートさせる（年と月の拾い方、年またぎに注意）
function show(e) {
  var row = e.getAttribute('row');
  var yy = e.getAttribute('yy');
  var mm = e.getAttribute('mm');
  var dd = e.getAttribute('dd');
  // クリック対象が1行目かつ前月の日付  
  if (row == 1 && dd > 7) {
    if (mm != 1) {
      mm = mm -1;
    } else if (mm == 1) {
      yy = yy - 1;
      mm = 12;
    }
  }
  // クリック対象が最終行かつ翌月の日付
  if ((row == 5 || row == 6) && dd < 7) {
    if (mm != 12) {
      mm = parseInt(mm) + 1;
    } else if (mm == 12) {
      yy = parseInt(yy) + 1;
      mm = 1;
    }
  }
  // とりあえず叫ぶ
  alert(yy+'/'+mm+'/'+dd);
}
