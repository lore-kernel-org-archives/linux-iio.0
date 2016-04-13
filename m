Return-Path: <capellamicro@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1460384362.2370.0.camel@hadess.net>
References: <1460381347-26873-1-git-send-email-hadess@hadess.net>
	<1460384362.2370.0.camel@hadess.net>
Date: Wed, 13 Apr 2016 11:44:03 -0700
Message-ID: <CAHvdCWhHzsuRZ0Kj9BbOSBoCQswR-=vrQErDG9J57yDaE30+2A@mail.gmail.com>
Subject: Re: [PATCH] iio: add Capella CM3218 ambient light sensor driver.
From: "K. T." <capellamicro@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-iio@vger.kernel.org, Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: multipart/alternative; boundary=047d7b5d83fd67177a053062292f
List-ID: <linux-iio@vger.kernel.org>

--047d7b5d83fd67177a053062292f
Content-Type: text/plain; charset=UTF-8

Hi Bastien,

What do you mean "doesn't survive"?  Can you read the sensor data or data
is not change?  I use Shuttle XPC desktop to test sensor driver.  In my
environment, suspend/resume works.  But, hibernate/resume may cause sensor
won't update issue.  Let me know more detail about your issue and I will
update driver.

Thanks.

Kevin Tsai
04/13/16

On Mon, Apr 11, 2016 at 7:19 AM, Bastien Nocera <hadess@hadess.net> wrote:

> On Mon, 2016-04-11 at 15:29 +0200, Bastien Nocera wrote:
> > From: Kevin Tsai <ktsai@capellamicro.com>
> >
> > Add Capella Microsystem CM3218 Ambient Light Sensor IIO driver.
> > This driver will convert raw data to lux value under open-air
> > condition, accessing the device via I2C.
> >
> > More information is available at:
> > http://www.capellamicro.com.tw/EN/product_c.php?id=52&mode=14&search=
> >
> > The driver was tested on the second generation Lenovo X1 Carbon
> > (20A7).
>
> Not tested well enough it seems, as the sensor doesn't survive and
> suspend/resume cycle.
>
> Cheers
>

--047d7b5d83fd67177a053062292f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Bastien,<div><br></div><div>What do you mean &quot;does=
n&#39;t survive&quot;?=C2=A0 Can you read the sensor data or data is not ch=
ange?=C2=A0 I use Shuttle XPC desktop to test sensor driver.=C2=A0 In my en=
vironment, suspend/resume works.=C2=A0 But, hibernate/resume may cause sens=
or won&#39;t update issue.=C2=A0 Let me know more detail about your issue a=
nd I will update driver.</div><div><br></div><div>Thanks.</div><div><br></d=
iv><div>Kevin Tsai<br></div><div>04/13/16</div></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Apr 11, 2016 at 7:19 AM, Bastie=
n Nocera <span dir=3D"ltr">&lt;<a href=3D"mailto:hadess@hadess.net" target=
=3D"_blank">hadess@hadess.net</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><span class=3D"">On Mon, 2016-04-11 at 15:29 +0200, Bastien Noce=
ra wrote:<br>
&gt; From: Kevin Tsai &lt;<a href=3D"mailto:ktsai@capellamicro.com">ktsai@c=
apellamicro.com</a>&gt;<br>
&gt;<br>
&gt; Add Capella Microsystem CM3218 Ambient Light Sensor IIO driver.<br>
&gt; This driver will convert raw data to lux value under open-air<br>
&gt; condition, accessing the device via I2C.<br>
&gt;<br>
&gt; More information is available at:<br>
&gt; <a href=3D"http://www.capellamicro.com.tw/EN/product_c.php?id=3D52&amp=
;mode=3D14&amp;search=3D" rel=3D"noreferrer" target=3D"_blank">http://www.c=
apellamicro.com.tw/EN/product_c.php?id=3D52&amp;mode=3D14&amp;search=3D</a>=
<br>
&gt;<br>
&gt; The driver was tested on the second generation Lenovo X1 Carbon<br>
&gt; (20A7).<br>
<br>
</span>Not tested well enough it seems, as the sensor doesn&#39;t survive a=
nd<br>
suspend/resume cycle.<br>
<br>
Cheers<br>
</blockquote></div><br></div>

--047d7b5d83fd67177a053062292f--
