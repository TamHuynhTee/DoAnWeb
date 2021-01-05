var block = function (username) {
    alert(username);
    //$.ajax({
    //    url: "/Account/Block",
    //    dataType: "JSON",
    //    type: "POST",
    //    data: { username: username },
    //    success: function (response) {
    //        if (response.state == true) {
    //            $('#block-' + username).css('background-color', 'red');
    //            $('#block-' + username).text('Khóa');
    //        } else {
    //            $('#block-' + username).css('background-color', 'green');
    //            $('#block-' + username).text('Đang dùng');
    //        }
    //    },
    //    error: function () {
    //        alert('Xảy ra lỗi khi kích hoạt/khóa tài khoản');
    //    }
    //})
}