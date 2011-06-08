Return-Path: <anish198519851985@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20110607160206.6cb3168d@endymion.delvare>
References: <1307450354.1516.23.camel@anish-desktop>
	<4DEE20E7.4020008@cam.ac.uk>
	<20110607134135.GD15795@trinity.fluff.org>
	<20110607160206.6cb3168d@endymion.delvare>
Date: Wed, 8 Jun 2011 10:41:20 +0530
Message-ID: <BANLkTim5-ZKXtDkSQyHAJ9-iKtOPsJ917A@mail.gmail.com>
Subject: Re: [PATCH] staging iio: Replace kmalloc with local variable
From: anish singh <anish198519851985@gmail.com>
To: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>
Cc: Ben Dooks <ben-i2c@fluff.org>, gregkh@suse.de, manuel.stahl@iis.fraunhofer.de,
	lucas.demarchi@profusion.mobi, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: multipart/alternative; boundary=0016e6d9772afe92c804a52c5d36
List-ID: <linux-iio@vger.kernel.org>

--0016e6d9772afe92c804a52c5d36
Content-Type: text/plain; charset=UTF-8

On Tue, Jun 7, 2011 at 7:32 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Tue, 7 Jun 2011 14:41:35 +0100, Ben Dooks wrote:
> > On Tue, Jun 07, 2011 at 02:00:23PM +0100, Jonathan Cameron wrote:
> > > On 06/07/11 13:39, anish wrote:
> > > > From: anish kumar <anish198519851985@gmail.com>
> > > >
> > > > replaced kmalloc with local variable as I2C(in this case) doesn't
> require
> > > > kmalloc memory it can do with stack memory.
> > > I've cc'd linux-i2c just to check I'm right about the whole i2c doesn't
> need
> > > dma safe buffers bit...
> >
> > No, it is down to the i2c driver, and from recollection dma from stack is
> > not recommended, due to things like cache line alignment. Please do not
> > do this.
>
> To be clearer, it is down to the i2c BUS (adapter) driver, NOT the i2c
> device driver. So the patch is correct.
>
I think i can take Jean ack on this?If yes then Joanthan kindly apply
this patch and i think you didn't lead me in wrong way as whatever
said by you is corroborated by jean also i.e. it is I2C bus driver
responsiblity
to care about DMA.

>
> Keep in mind that not all I2C/SMBus controllers care about DMA. In fact,
> most don't (at least in the set I am maintaining - might be different
> an embedded.) So calling kmalloc for every transfer in every I2C device
> driver "just in case" is very much counterproductive.
>
> And, if a controller does DMA and needs well-aligned, dynamically
> allocated buffer, its driver would hopefully allocate the buffer ONCE
> and keep it around, rather than reallocating it for every transfer.
>
> --
> Jean Delvare
>

--0016e6d9772afe92c804a52c5d36
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Tue, Jun 7, 2011 at 7:32 PM, Jean Delvare <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org=
</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div class=3D"im">On Tue, 7 Jun 2011 14:41:35 +0100, Ben Dooks wrote:<br>&g=
t; On Tue, Jun 07, 2011 at 02:00:23PM +0100, Jonathan Cameron wrote:<br>&gt=
; &gt; On 06/07/11 13:39, anish wrote:<br>&gt; &gt; &gt; From: anish kumar =
&lt;<a href=3D"mailto:anish198519851985@gmail.com">anish198519851985@gmail.=
com</a>&gt;<br>
&gt; &gt; &gt;<br>&gt; &gt; &gt; replaced kmalloc with local variable as I2=
C(in this case) doesn&#39;t require<br>&gt; &gt; &gt; kmalloc memory it can=
 do with stack memory.<br>&gt; &gt; I&#39;ve cc&#39;d linux-i2c just to che=
ck I&#39;m right about the whole i2c doesn&#39;t need<br>
&gt; &gt; dma safe buffers bit...<br>&gt;<br>&gt; No, it is down to the i2c=
 driver, and from recollection dma from stack is<br>&gt; not recommended, d=
ue to things like cache line alignment. Please do not<br>&gt; do this.<br>
<br></div>To be clearer, it is down to the i2c BUS (adapter) driver, NOT th=
e i2c<br>device driver. So the patch is correct.<br></blockquote>
<div>I=C2=A0think i can take Jean=C2=A0ack on this?If yes then Joanthan kin=
dly apply</div>
<div>this patch and i think you didn&#39;t lead me in wrong way as whatever=
</div>
<div>said by you is corroborated=C2=A0by jean also i.e. it is I2C bus drive=
r responsiblity</div>
<div>to care about DMA.</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote"><br>Keep in mind that not all I2=
C/SMBus controllers care about DMA. In fact,<br>most don&#39;t (at least in=
 the set I am maintaining - might be different<br>
an embedded.) So calling kmalloc for every transfer in every I2C device<br>=
driver &quot;just in case&quot; is very much counterproductive.<br><br>And,=
 if a controller does DMA and needs well-aligned, dynamically<br>allocated =
buffer, its driver would hopefully allocate the buffer ONCE<br>
and keep it around, rather than reallocating it for every transfer.<br><br>=
--<br><font color=3D"#888888">Jean Delvare<br></font></blockquote></div><br=
>

--0016e6d9772afe92c804a52c5d36--
