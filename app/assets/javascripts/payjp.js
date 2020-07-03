document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) { 
      Payjp.setPublicKey("pk_test_b7c98adda92d57a20c5be173"); 
      let btn = document.getElementById("token_submit"); 
      btn.addEventListener("click", e => { 
        e.preventDefault(); 
        
        let card = {
          number: $('#card_number').val(),
          cvc: $('#cvc').val(),
          exp_month: $('#exp_month').val(),
          exp_year: $('#exp_year').val(),
        }; 
        Payjp.createToken(card, (status, response) => {
          if (status === 200) { 
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); 
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            ); 
            document.inputForm.submit();
          } else {
            alert("カード情報が正しくありません。"); 
          }
        });
      });
    }
  },
  false
);