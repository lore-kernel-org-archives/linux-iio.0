Return-Path: <axel.lin@ingics.com>
MIME-Version: 1.0
In-Reply-To: <508E3833.50003@metafoo.de>
References: <1351425686.12461.1.camel@phoenix>
	<508E3833.50003@metafoo.de>
Date: Mon, 29 Oct 2012 16:09:08 +0800
Message-ID: <CAFRkauCY_Sw_j7Yr4saTG5jmcc1gB34C8o1maRDU=o7qoVZ1pQ@mail.gmail.com>
Subject: Re: iio: at91_adc.c build error
From: Axel Lin <axel.lin@ingics.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=0016368e1e1808a5ba04cd2e2f58
List-ID: <linux-iio@vger.kernel.org>

--0016368e1e1808a5ba04cd2e2f58
Content-Type: text/plain; charset=ISO-8859-1

2012/10/29 Lars-Peter Clausen <lars@metafoo.de>

> On 10/28/2012 01:01 PM, Axel Lin wrote:
> > hi Lars-Peter,
> >
> > Seems there is no devm_kcalloc API available at this moment (in
> linux-next tree).
> >
> > I got below build error:
> > drivers/iio/adc/at91_adc.c: In function 'at91_adc_channel_init':
> > drivers/iio/adc/at91_adc.c:126: error: implicit declaration of function
> 'devm_kcalloc'
> > drivers/iio/adc/at91_adc.c:127: warning: assignment makes pointer from
> integer without a cast
> > drivers/iio/adc/at91_adc.c: In function 'at91_adc_trigger_init':
> > drivers/iio/adc/at91_adc.c:272: warning: assignment makes pointer from
> integer without a cast
> > drivers/iio/adc/at91_adc.c: In function 'at91_adc_probe_dt':
> > drivers/iio/adc/at91_adc.c:455: warning: assignment makes pointer from
> integer without a cast
> > make[3]: *** [drivers/iio/adc/at91_adc.o] Error 1
> > make[2]: *** [drivers/iio/adc] Error 2
> > make[1]: *** [drivers/iio] Error 2
> > make: *** [drivers] Error 2
>
> Ok, now I feel stupid...
>
> Do you want to sent a revert or should I do it?
>
Ok. I'll send a revert patch right away.

Axel

--0016368e1e1808a5ba04cd2e2f58
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/10/29 Lars-Peter Clausen <span dir=
=3D"ltr">&lt;<a href=3D"mailto:lars@metafoo.de" target=3D"_blank">lars@meta=
foo.de</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On 10/28/2012 01:01 PM, Axel Lin wr=
ote:<br>
&gt; hi Lars-Peter,<br>
&gt;<br>
&gt; Seems there is no devm_kcalloc API available at this moment (in linux-=
next tree).<br>
&gt;<br>
&gt; I got below build error:<br>
&gt; drivers/iio/adc/at91_adc.c: In function &#39;at91_adc_channel_init&#39=
;:<br>
&gt; drivers/iio/adc/at91_adc.c:126: error: implicit declaration of functio=
n &#39;devm_kcalloc&#39;<br>
&gt; drivers/iio/adc/at91_adc.c:127: warning: assignment makes pointer from=
 integer without a cast<br>
&gt; drivers/iio/adc/at91_adc.c: In function &#39;at91_adc_trigger_init&#39=
;:<br>
&gt; drivers/iio/adc/at91_adc.c:272: warning: assignment makes pointer from=
 integer without a cast<br>
&gt; drivers/iio/adc/at91_adc.c: In function &#39;at91_adc_probe_dt&#39;:<b=
r>
&gt; drivers/iio/adc/at91_adc.c:455: warning: assignment makes pointer from=
 integer without a cast<br>
&gt; make[3]: *** [drivers/iio/adc/at91_adc.o] Error 1<br>
&gt; make[2]: *** [drivers/iio/adc] Error 2<br>
&gt; make[1]: *** [drivers/iio] Error 2<br>
&gt; make: *** [drivers] Error 2<br>
<br>
</div></div>Ok, now I feel stupid...<br>
<br>
Do you want to sent a revert or should I do it?<br></blockquote><div>Ok. I&=
#39;ll send a revert patch right away.<br>=A0<br>Axel<br></div></div><br>

--0016368e1e1808a5ba04cd2e2f58--
