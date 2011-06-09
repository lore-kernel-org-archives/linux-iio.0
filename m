Return-Path: <anish198519851985@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20110609102948.7a3f8d57@endymion.delvare>
References: <1307450354.1516.23.camel@anish-desktop>
	<4DEE20E7.4020008@cam.ac.uk>
	<20110607134135.GD15795@trinity.fluff.org>
	<20110607160206.6cb3168d@endymion.delvare>
	<BANLkTim5-ZKXtDkSQyHAJ9-iKtOPsJ917A@mail.gmail.com>
	<BANLkTi=e0A2G-d+t4VF5V0gj+eNoh3KRnQ@mail.gmail.com>
	<20110609102948.7a3f8d57@endymion.delvare>
Date: Thu, 9 Jun 2011 14:04:16 +0530
Message-ID: <BANLkTimq_5rmB+UkaxZwrOtV-ZF3+fEOgQ@mail.gmail.com>
Subject: Re: [PATCH] staging iio: Replace kmalloc with local variable
From: anish singh <anish198519851985@gmail.com>
To: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>
Cc: Ben Dooks <ben-i2c@fluff.org>, gregkh@suse.de, manuel.stahl@iis.fraunhofer.de,
	lucas.demarchi@profusion.mobi, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: multipart/alternative; boundary=0015175dda028d195804a5435166
List-ID: <linux-iio@vger.kernel.org>

--0015175dda028d195804a5435166
Content-Type: text/plain; charset=UTF-8

On Thu, Jun 9, 2011 at 1:59 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Thu, 9 Jun 2011 13:53:09 +0530, anish singh wrote:
> > On Wed, Jun 8, 2011 at 10:41 AM, anish singh <
> anish198519851985@gmail.com>wrote:
> > >  On Tue, Jun 7, 2011 at 7:32 PM, Jean Delvare <khali@linux-fr.org>
> wrote:
> > >> To be clearer, it is down to the i2c BUS (adapter) driver, NOT the i2c
> > >> device driver. So the patch is correct.
> > >>
> > > I think i can take Jean ack on this?If yes then Joanthan kindly apply
> > > this patch and i think you didn't lead me in wrong way as whatever
> > > said by you is corroborated by jean also i.e. it is I2C bus driver
> > > responsiblity
> > > to care about DMA.
> > >
> > Sorry to ping you again.Can i take your ack on this?
>
> Yes of course.
>
> Acked-by: Jean Delvare <khali@linux-fr.org>
>
Thanks a ton.Jonathan kindly apply it now :)

>
> --
> Jean Delvare
>

--0015175dda028d195804a5435166
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Thu, Jun 9, 2011 at 1:59 PM, Jean Delvare <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org=
</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div class=3D"im">On Thu, 9 Jun 2011 13:53:09 +0530, anish singh wrote:<br>=
&gt; On Wed, Jun 8, 2011 at 10:41 AM, anish singh &lt;<a href=3D"mailto:ani=
sh198519851985@gmail.com">anish198519851985@gmail.com</a>&gt;wrote:<br>&gt;=
 &gt; =C2=A0On Tue, Jun 7, 2011 at 7:32 PM, Jean Delvare &lt;<a href=3D"mai=
lto:khali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
</div>
<div class=3D"im">&gt; &gt;&gt; To be clearer, it is down to the i2c BUS (a=
dapter) driver, NOT the i2c<br>&gt; &gt;&gt; device driver. So the patch is=
 correct.<br>&gt; &gt;&gt;<br>&gt; &gt; I think i can take Jean ack on this=
?If yes then Joanthan kindly apply<br>
&gt; &gt; this patch and i think you didn&#39;t lead me in wrong way as wha=
tever<br>&gt; &gt; said by you is corroborated by jean also i.e. it is I2C =
bus driver<br>&gt; &gt; responsiblity<br>&gt; &gt; to care about DMA.<br>
&gt; &gt;<br>&gt; Sorry to ping you again.Can i take your ack on this?<br><=
br></div>Yes of course.<br><br>Acked-by: Jean Delvare &lt;<a href=3D"mailto=
:khali@linux-fr.org">khali@linux-fr.org</a>&gt;<br></blockquote>
<div>Thanks a ton.Jonathan kindly apply it now :)</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote"><br>--<br><font color=3D"#888888=
">Jean Delvare<br></font></blockquote></div><br>

--0015175dda028d195804a5435166--
