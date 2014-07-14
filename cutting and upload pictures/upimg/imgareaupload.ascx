<%@ Control Language="C#" AutoEventWireup="true" CodeFile="imgareaupload.ascx.cs"
    Inherits="UserControl.imgareaupload" %>
<script type="text/javascript">
    $(function () {
        $("img[id*='_Image1']").imgAreaSelect({ aspectRatio: $("input[id*='_hdAspectRatio']").val(), maxWidth: $("input[id*='_hdMaxWidth']").val(), maxHeight: $("input[id*='_hdMaxHeight']").val(), minWidth: $("input[id*='_hdMinWidth']").val(), minHeight: $("input[id*='_hdMinHeight']").val(), onSelectEnd: updateCoords });
    });
    function updateCoords(img, c) {
        $("input[id*='_txtX']").val(c.x1);
        $("input[id*='_txtY']").val(c.y1);
        $("input[id*='_txtX2']").val(c.x2);
        $("input[id*='_txtY2']").val(c.y2);
    }
    function JianQie() {
        var txtX = $("input[id*=_txtX]").val();
        var txtY = $("input[id*=_txtY]").val();
        var txtX2 = $("input[id*=_txtX2]").val();
        var txtY2 = $("input[id*=_txtY2]").val();
        var Directory = $("input[id*=_hdDirectory]").val();
        var FileName = $("input[id*=_hdFileName]").val();
        $.getJSON("upimg.ashx?time=" + Math.random(), { action: "Draw", txtX: txtX, txtY: txtY, txtX2: txtX2, txtY2: txtY2, Directory: Directory, FileName: FileName }, function (data) {
            if (data.State == "0")
                alert(data.Str);
            else
                $("img[id*='_Image2']").attr("src", data.Str);
        });
    }
    function FileUpload() {
        var HW = $("input[id*=_hdHW]").val();
        var ImgW = $("input[id*=_hdImgW]").val();
        var ImgH = $("input[id*=_hdImgH]").val();
        $.ajaxFileUpload
		({
		    url: "upimg.ashx?time=" + Math.random() + "&Directory=" + $("input[id*='_hdDirectory']").val() + "&FileName=" + $("input[id*='_hdFileName']").val() + "&action=upload&HW="+HW+"&ImgW="+ImgW+"&ImgH="+ImgH,
		    secureuri: false,
		    fileElementId: 'Pic',
		    dataType: 'json',
		    success: function (data) {
		        $("img[id*='_Image1']").attr("src", data.Str);
		        $("input[id*=btnSave]").removeAttr("disabled");
             }
		})
        return false;
    }
    //父页面调用
    function setFileName(filename) {
        //将剪切按钮设置为禁用
        $("input[id*=btnSave]").attr("disabled", "disabled");
        $("input[id*=_hdFileName]").val(filename);
    }
    function getUrl() {
        return $("img[id*='_Image2']").attr("src");
    }
</script>
<asp:HiddenField ID="hdHW" runat="server" />
<asp:HiddenField ID="hdImgW" runat="server" />
<asp:HiddenField ID="hdImgH" runat="server" />
<asp:HiddenField ID="hdFileName" runat="server" />
<asp:HiddenField ID="hdDirectory" runat="server" />
<asp:HiddenField ID="hdMaxWidth" runat="server" />
<asp:HiddenField ID="hdMaxHeight" runat="server" />
<asp:HiddenField ID="hdMinWidth" runat="server" />
<asp:HiddenField ID="hdMinHeight" runat="server" />
<asp:HiddenField ID="hdAspectRatio" Value="4:3" runat="server" />
<asp:TextBox ID="txtX" Style="display: none" runat="server" Width="50px"></asp:TextBox>
<asp:TextBox ID="txtY" Style="display: none" runat="server" Width="50px"></asp:TextBox>
<asp:TextBox ID="txtX2" Style="display: none" runat="server" Width="50px"></asp:TextBox>
<asp:TextBox ID="txtY2" Style="display: none" runat="server" Width="50px"></asp:TextBox>
<table cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td valign="top">
            <input id="btnSave" type="button" value="剪裁" onclick="JianQie();" />
            <input id="Pic" name="Pic" type="file" onchange="FileUpload();" /><br />
            <asp:Image ID="Image1" runat="server" ImageUrl="../file/white.jpg" />
        </td>
        <td>
            <asp:Image ID="Image2" runat="server" ImageUrl="../file/white.jpg" />
        </td>
    </tr>
</table>
