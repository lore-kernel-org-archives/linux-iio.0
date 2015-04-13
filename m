Return-Path: <imsaurabhrawat@gmail.com>
MIME-Version: 1.0
In-Reply-To: <B74F5E0D-FE1C-422F-9D2E-985137E684E7@jic23.retrosnub.co.uk>
References: <CALwa49vRGN_VaJ147PVF8Cf+8vnBotWVh7hmxLj=jaAba5QTTw@mail.gmail.com>
 <5526BD63.3080509@kernel.org> <CALwa49st7A1zSdCmy8Sq8KgAMXiGJySdpoxALTUNEubgvXqyWg@mail.gmail.com>
 <9B863FBE-8332-47EB-8E6C-C8943EF5D185@kernel.org> <CALwa49us7JVeYYga7fJxMx0=EbyLMuaAASGhU8=9AWYV2u96uQ@mail.gmail.com>
 <B74F5E0D-FE1C-422F-9D2E-985137E684E7@jic23.retrosnub.co.uk>
From: "s.rawat" <imsaurabhrawat@gmail.com>
Date: Mon, 13 Apr 2015 15:19:09 +0530
Message-ID: <CALwa49vgNAY3zGPnUZ+dnB0i_RrD_q99UuONvxObLaT3a+yu1Q@mail.gmail.com>
Subject: Re: Regarding generic_buffer.c Application for Android
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: multipart/alternative; boundary=f46d04428084c821ea0513980781
List-ID: <linux-iio@vger.kernel.org>

--f46d04428084c821ea0513980781
Content-Type: text/plain; charset=UTF-8

On Mon, Apr 13, 2015 at 11:56 AM, Jonathan Cameron <
jic23@jic23.retrosnub.co.uk> wrote:

> Here equivalent is probably to close and reopen the directory.
>
+closedir(dp)
+dp = opendir(scan_el_dir);

This seems to work fine.But sometimes polling accel throws error : failed
to open /dev/iio:device0 .

--f46d04428084c821ea0513980781
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Apr 13, 2015 at 11:56 AM, Jonathan Cameron <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:jic23@jic23.retrosnub.co.uk" target=3D"_blank">jic23@jic23.=
retrosnub.co.uk</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:r=
gb(204,204,204);border-left-style:solid;padding-left:1ex"><div id=3D":3j4" =
class=3D"" style=3D"overflow:hidden">Here equivalent is probably to close a=
nd reopen the directory.<div class=3D""><div id=3D":3m2" class=3D"" tabinde=
x=3D"0"></div></div></div></blockquote></div><div class=3D"gmail_extra"><di=
v class=3D"gmail_extra" style=3D"font-size:13px">+closedir(dp)</div><div cl=
ass=3D"gmail_extra" style=3D"font-size:13px">+dp =3D opendir(scan_el_dir);<=
/div></div><br>This seems to work fine.But sometimes polling accel throws e=
rror : failed to open /dev/iio:device0 .</div></div>

--f46d04428084c821ea0513980781--
