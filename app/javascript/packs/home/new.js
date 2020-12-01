(function($) {

  /** インジケータ表示範囲を管理するコントローラ */
  var indicatorController = {
 
   __name: 'SendInfosController',
 
   /** インジケータ表示ボタン押下イベント */
   '#indicator click': function(){
 
    //インジケータ表示
    var indicator = this.indicator({
     message: 'block'
    }).show();
 
    setTimeout(function() {
 
     //インジケータ除去
     indicator.hide();
 
    }, 800);
   }
  };
  $(function(){ h5.core.controller('#container', indicatorController)});
 })(jQuery);