Return-Path: <ktsai@capellamicro.com>
Message-ID: <2491411A39C64F138396EE9BC26AF60E@GustyD430>
From: "Kevin Tsai" <ktsai@capellamicro.com>
To: "Shubhrajyoti Datta" <omaplinuxkernel@gmail.com>
Cc: "Jonathan Cameron" <jic23@cam.ac.uk>,
  "Grant Likely" <grant.likely@linaro.org>,
  "Rob Herring" <rob.herring@calxeda.com>,
  "Peter Meerwald" <pmeerw@pmeerw.net>,
  "Alexander Holler" <holler@ahsoftware.de>,
  "srinivas pandruvada" <srinivas.pandruvada@intel.com>,
  "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
  <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1375813453-2290-1-git-send-email-ktsai@capellamicro.com> <CAM=Q2cto2Wp2e74ttVNeQ1nnJYAJ5A6=nZYuAT7_aaqS7xm3+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Added Capella CM3218 Ambient Light Sensor IIO driver.
Date: Wed, 7 Aug 2013 10:29:12 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000D_01CE9358.F5BF4080"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_000D_01CE9358.F5BF4080
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi sir,

This sensor doesn't have power on reset. It's necessary to re-initialize =
device after resume power.

Thanks.

Kevin Tsai
08/06/13
  ----- Original Message -----=20
  From: Shubhrajyoti Datta=20
  To: Kevin Tsai=20
  Cc: Jonathan Cameron ; Grant Likely ; Rob Herring ; Peter Meerwald ; =
Alexander Holler ; srinivas pandruvada ; Linux Kernel Mailing List ; =
linux-iio@vger.kernel.org ; devicetree@vger.kernel.org=20
  Sent: Tuesday, August 06, 2013 23:31
  Subject: Re: [PATCH 1/1] Added Capella CM3218 Ambient Light Sensor IIO =
driver.




  <snip>

    +       chip->suspended =3D true;
    +
    +       mutex_unlock(&chip->lock);
    +       return 0;
    +}
    +
    +static int cm3218_resume(struct device *dev)
    +{
    +       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
    +       struct cm3218_chip *chip =3D iio_priv(indio_dev);
    +       struct i2c_client *client =3D chip->client;
    +       int err;
    +
    +       mutex_lock(&chip->lock);
    +
    +       err =3D cm3218_chip_init(client);

  We do a reinit every time is there a way to know if the context was =
lost?
  =20

    +       if (!err)
    +               chip->suspended =3D false;
    +
    +       mutex_unlock(&chip->lock);
    +       return err;
    +}
    +

    --
    1.8.3.1

    --
    To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html



------=_NextPart_000_000D_01CE9358.F5BF4080
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.6001.18702">
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2 face=3DArial>Hi sir,</FONT></DIV>
<DIV><FONT size=3D2 face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>This sensor doesn't have power on =
reset. It's=20
necessary to re-initialize device after resume power.</FONT></DIV>
<DIV><FONT size=3D2 face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>Thanks.</FONT></DIV>
<DIV><FONT size=3D2 face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>Kevin Tsai</FONT></DIV>
<DIV><FONT size=3D2 face=3DArial>08/06/13</FONT></DIV>
<BLOCKQUOTE=20
style=3D"BORDER-LEFT: #000000 2px solid; PADDING-LEFT: 5px; =
PADDING-RIGHT: 0px; MARGIN-LEFT: 5px; MARGIN-RIGHT: 0px"=20
dir=3Dltr>
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"FONT: 10pt arial; BACKGROUND: #e4e4e4; font-color: =
black"><B>From:</B>=20
  <A title=3Domaplinuxkernel@gmail.com=20
  href=3D"mailto:omaplinuxkernel@gmail.com">Shubhrajyoti Datta</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dktsai@capellamicro.com=20
  href=3D"mailto:ktsai@capellamicro.com">Kevin Tsai</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Cc:</B> <A title=3Djic23@cam.ac.uk=20
  href=3D"mailto:jic23@cam.ac.uk">Jonathan Cameron</A> ; <A=20
  title=3Dgrant.likely@linaro.org =
href=3D"mailto:grant.likely@linaro.org">Grant=20
  Likely</A> ; <A title=3Drob.herring@calxeda.com=20
  href=3D"mailto:rob.herring@calxeda.com">Rob Herring</A> ; <A=20
  title=3Dpmeerw@pmeerw.net href=3D"mailto:pmeerw@pmeerw.net">Peter =
Meerwald</A> ;=20
  <A title=3Dholler@ahsoftware.de =
href=3D"mailto:holler@ahsoftware.de">Alexander=20
  Holler</A> ; <A title=3Dsrinivas.pandruvada@intel.com=20
  href=3D"mailto:srinivas.pandruvada@intel.com">srinivas pandruvada</A> =
; <A=20
  title=3Dlinux-kernel@vger.kernel.org=20
  href=3D"mailto:linux-kernel@vger.kernel.org">Linux Kernel Mailing =
List</A> ; <A=20
  title=3Dlinux-iio@vger.kernel.org=20
  =
href=3D"mailto:linux-iio@vger.kernel.org">linux-iio@vger.kernel.org</A> =
; <A=20
  title=3Ddevicetree@vger.kernel.org=20
  =
href=3D"mailto:devicetree@vger.kernel.org">devicetree@vger.kernel.org</A>=
 </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Tuesday, August 06, 2013=20
23:31</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: [PATCH 1/1] Added =
Capella=20
  CM3218 Ambient Light Sensor IIO driver.</DIV>
  <DIV><BR></DIV>
  <DIV dir=3Dltr><BR>
  <DIV class=3Dgmail_extra>
  <DIV class=3Dgmail_quote>&lt;snip&gt;<BR></DIV>
  <DIV class=3Dgmail_quote>
  <BLOCKQUOTE=20
  style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex; =
PADDING-LEFT: 1ex"=20
  class=3Dgmail_quote>+ &nbsp; &nbsp; &nbsp; chip-&gt;suspended =3D=20
    true;<BR>+<BR>+ &nbsp; &nbsp; &nbsp; =
mutex_unlock(&amp;chip-&gt;lock);<BR>+=20
    &nbsp; &nbsp; &nbsp; return 0;<BR>+}<BR>+<BR>+static int=20
    cm3218_resume(struct device *dev)<BR>+{<BR>+ &nbsp; &nbsp; &nbsp; =
struct=20
    iio_dev *indio_dev =3D dev_get_drvdata(dev);<BR>+ &nbsp; &nbsp; =
&nbsp; struct=20
    cm3218_chip *chip =3D iio_priv(indio_dev);<BR>+ &nbsp; &nbsp; &nbsp; =
struct=20
    i2c_client *client =3D chip-&gt;client;<BR>+ &nbsp; &nbsp; &nbsp; =
int=20
    err;<BR>+<BR>+ &nbsp; &nbsp; &nbsp;=20
    mutex_lock(&amp;chip-&gt;lock);<BR>+<BR>+ &nbsp; &nbsp; &nbsp; err =
=3D=20
    cm3218_chip_init(client);<BR></BLOCKQUOTE>
  <DIV>We do a reinit every time is there a way to know if the context =
was=20
  lost?<BR>&nbsp;<BR></DIV>
  <BLOCKQUOTE=20
  style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex; =
PADDING-LEFT: 1ex"=20
  class=3Dgmail_quote>+ &nbsp; &nbsp; &nbsp; if (!err)<BR>+ &nbsp; =
&nbsp; &nbsp;=20
    &nbsp; &nbsp; &nbsp; &nbsp; chip-&gt;suspended =3D false;<BR>+<BR>+ =
&nbsp;=20
    &nbsp; &nbsp; mutex_unlock(&amp;chip-&gt;lock);<BR>+ &nbsp; &nbsp; =
&nbsp;=20
    return err;<BR>+}<BR>+<BR><BR><SPAN class=3DHOEnZb><FONT=20
    color=3D#888888>--<BR>1.8.3.1<BR><BR>--<BR>To unsubscribe from this =
list: send=20
    the line "unsubscribe linux-iio" in<BR>the body of a message to <A=20
    =
href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</A><B=
R>More=20
    majordomo info at &nbsp;<A =
href=3D"http://vger.kernel.org/majordomo-info.html"=20
    =
target=3D_blank>http://vger.kernel.org/majordomo-info.html</A><BR></FONT>=
</SPAN></BLOCKQUOTE></DIV><BR></DIV></DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_000D_01CE9358.F5BF4080--
