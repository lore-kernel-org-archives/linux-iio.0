Return-Path: <SRS0=6Ed5=4Q=gmail.com=gizero@kernel.org>
MIME-Version: 1.0
In-Reply-To: <56632BE7.2050000@kernel.org>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info> <1446118467-26453-5-git-send-email-nicola@corna.info>
 <56349644.2060308@kernel.org> <20151130173324.GG9554@katana> <56632BE7.2050000@kernel.org>
From: Andrea Galbusera <gizero@gmail.com>
Date: Wed, 10 May 2017 16:46:09 +0200
Message-ID: <CAC+thW1ZL_vOLcQ87rbGk7OJfB+T=tGeEDUiLEVsu2jpbM0rrA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] iio: humidity: si7020: add No Hold read mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Nicola Corna <nicola@corna.info>,
	Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Content-Type: multipart/alternative; boundary=94eb2c063dc4e05388054f2c89a2
List-ID: <linux-iio@vger.kernel.org>

--94eb2c063dc4e05388054f2c89a2
Content-Type: text/plain; charset=UTF-8

Hi!

On Sat, Dec 5, 2015 at 7:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 30/11/15 17:33, Wolfram Sang wrote:
> > On Sat, Oct 31, 2015 at 10:21:56AM +0000, Jonathan Cameron wrote:
> >> On 29/10/15 11:34, Nicola Corna wrote:
> >>> The Si7013/20/21 modules support 2 read modes:
> >>>  * Hold mode (blocking), where the device stretches the clock until
> the end
> >>> of the measurement
> >>>  * No Hold mode (non-blocking), where the device replies NACK for
> every I2C
> >>> call during the measurement
> >>> Here the No Hold mode is implemented, selectable with the blocking_io
> >>> variable within si7020_platform_data. The default mode is Hold, unless
> the
> >>> adapter does not support clock stretching, in which case the No Hold
> mode
> >>> is used.
> >>>
> >>> Signed-off-by: Nicola Corna <nicola@corna.info>
> >> I'm fine with this.  The dependency below should I think show up in the
> >> coming merge window, so this lot might as well go via Wolfram.
> >>
> >> Acked-by: Jonathan Cameron <jic23@kernel.org>
> >
> > Not sure, will think about it...
> >
> Nicola,
>
> If Wolfram doesn't pick this up, please ping me after the next merge
> window.
> Whilst I'll still have it in my queue, it'll be so long ago by then I'll
> probably
> miss it!
>
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Resurrecting this almost two years old thread because I just found myself
in the situation of using Si7020 with an I2C adapter with broken clock
stretching (probably the same that originated this work). Well, AFAIKT it
seems that this already ack-ed patchset never landed in mainline, probably
due to unlucky timing with merging windows. Didn't try the original patches
myself yet, but going to do it soon... Just wanted to ping people who may
already have an updated version at hand...

Regards

P.S: sorry for unintentional double posting of HTML emails... :-(

--94eb2c063dc4e05388054f2c89a2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">Hi!<=
br></div><div class=3D"gmail_quote"><br>On Sat, Dec 5, 2015 at 7:24 PM, Jon=
athan Cameron <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@kernel.org" tar=
get=3D"_blank">jic23@kernel.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div class=3D"gmail-HOEnZb"><div class=3D"=
gmail-h5">On 30/11/15 17:33, Wolfram Sang wrote:<br>
&gt; On Sat, Oct 31, 2015 at 10:21:56AM +0000, Jonathan Cameron wrote:<br>
&gt;&gt; On 29/10/15 11:34, Nicola Corna wrote:<br>
&gt;&gt;&gt; The Si7013/20/21 modules support 2 read modes:<br>
&gt;&gt;&gt;=C2=A0 * Hold mode (blocking), where the device stretches the c=
lock until the end<br>
&gt;&gt;&gt; of the measurement<br>
&gt;&gt;&gt;=C2=A0 * No Hold mode (non-blocking), where the device replies =
NACK for every I2C<br>
&gt;&gt;&gt; call during the measurement<br>
&gt;&gt;&gt; Here the No Hold mode is implemented, selectable with the bloc=
king_io<br>
&gt;&gt;&gt; variable within si7020_platform_data. The default mode is Hold=
, unless the<br>
&gt;&gt;&gt; adapter does not support clock stretching, in which case the N=
o Hold mode<br>
&gt;&gt;&gt; is used.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Nicola Corna &lt;<a href=3D"mailto:nicola@corna=
.info">nicola@corna.info</a>&gt;<br>
&gt;&gt; I&#39;m fine with this.=C2=A0 The dependency below should I think =
show up in the<br>
&gt;&gt; coming merge window, so this lot might as well go via Wolfram.<br>
&gt;&gt;<br>
&gt;&gt; Acked-by: Jonathan Cameron &lt;<a href=3D"mailto:jic23@kernel.org"=
>jic23@kernel.org</a>&gt;<br>
&gt;<br>
&gt; Not sure, will think about it...<br>
&gt;<br>
</div></div>Nicola,<br>
<br>
If Wolfram doesn&#39;t pick this up, please ping me after the next merge wi=
ndow.<br>
Whilst I&#39;ll still have it in my queue, it&#39;ll be so long ago by then=
 I&#39;ll probably<br>
miss it!<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
Jonathan<br>
</font></span><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<wbr>m=
ajordomo-info.html</a></div></div></blockquote><div><br><div>Resurrecting t=
his almost two years old thread because I just found myself in the situatio=
n of using <span class=3D"gmail-il">Si7020</span>
 with an I2C adapter with broken clock stretching (probably the same=20
that originated this work). Well, AFAIKT it seems that this already=20
ack-ed patchset never landed in mainline, probably due to unlucky timing
 with merging windows. Didn&#39;t try the original patches myself yet, but=
=20
going to do it soon... Just wanted to ping people who may already have=20
an updated version at hand...<br><br></div>Regards<br><br></div><div>P.S: s=
orry for unintentional double posting of HTML emails... :-(<br></div></div>=
</div></div>

--94eb2c063dc4e05388054f2c89a2--
