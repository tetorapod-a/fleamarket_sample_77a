$(function(){
    function buildChildHTML(child){
      var html =`<a class="child_category" id="${child.id}" 
                  href="/categories/${child.id}">${child.name}</a>`;
      return html;
    }
    $(".lists-left__first").hover(
      function(){
        $(".category").fadeIn();
      },
      function(){
        $(".category").fadeOut();
      });
    $(".parent_category").on("mouseover", function() {
      var id = this.id
      $(".now-selected-red").removeClass("now-selected-red")
      $('#' + id).addClass("now-selected-red");
      $(".child_category").remove();
      $(".grand_child_category").remove();
      $.ajax({
        type: 'GET',
        url: '/categories/new',//とりあえずここではnewアクションに飛ばす。
        data: {parent_id: id},
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {
          var html = buildChildHTML(child);
          $(".children_list").append(html);
        })
      });
    });
  
    function buildGrandChildHTML(child){
      var html =`<a class="grand_child_category" id="${child.id}"
                  href="/categories/${child.id}">${child.name}</a>`;
      return html;
    }
  
    $(document).on("mouseover", ".child_category", function () {
      var id = this.id
      $(".now-selected-gray").removeClass("now-selected-gray");
      $('#' + id).addClass("now-selected-gray");
      $.ajax({
        type: 'GET',
        url: '/categories/new',
        data: {parent_id: id},
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {
          var html = buildGrandChildHTML(child);
          $(".grand_children_list").append(html);
        })
        $(document).on("mouseover", ".child_category", function () {
          $(".grand_child_category").remove();
        });
      });
    });
      
    $(document).on("mouseover", ".grand_child_category", function () {
      var id = this.id
      $(".now-selected-last").removeClass("now-selected-last");
      $('#' + id).addClass("now-selected-last");
    });

    $(".sold__btn").on("click", function() {
      $(".items-box_photo__sold").parent().parent().toggleClass("urikire");
      $(".fa-check").toggleClass("hidden");
    });

  });