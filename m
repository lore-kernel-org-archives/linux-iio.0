Return-Path: <anish198519851985@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4DF0A48B.6040802@cam.ac.uk>
References: <1307450354.1516.23.camel@anish-desktop>
	<4DEE20E7.4020008@cam.ac.uk>
	<20110607134135.GD15795@trinity.fluff.org>
	<20110607160206.6cb3168d@endymion.delvare>
	<BANLkTim5-ZKXtDkSQyHAJ9-iKtOPsJ917A@mail.gmail.com>
	<BANLkTi=e0A2G-d+t4VF5V0gj+eNoh3KRnQ@mail.gmail.com>
	<20110609102948.7a3f8d57@endymion.delvare>
	<BANLkTimq_5rmB+UkaxZwrOtV-ZF3+fEOgQ@mail.gmail.com>
	<4DF088E5.5000408@cam.ac.uk>
	<4DF0A48B.6040802@cam.ac.uk>
Date: Thu, 9 Jun 2011 23:29:15 +0900
Message-ID: <BANLkTik4Tfd73iKcDsXK-sfy6_ADVX4oYA@mail.gmail.com>
Subject: Re: [PATCH] staging iio: Replace kmalloc with local variable
From: anish singh <anish198519851985@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-i2c@fluff.org>, gregkh@suse.de,
	manuel.stahl@iis.fraunhofer.de, lucas.demarchi@profusion.mobi,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: multipart/alternative; boundary=0015175dda021e252704a54847c7
List-ID: <linux-iio@vger.kernel.org>

--0015175dda021e252704a54847c7
Content-Type: text/plain; charset=UTF-8

On Thu, Jun 9, 2011 at 7:46 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:

>  On 06/09/11 09:48, Jonathan Cameron wrote:
> > On 06/09/11 09:34, anish singh wrote:
> >>
> >>
> >> On Thu, Jun 9, 2011 at 1:59 PM, Jean Delvare <khali@linux-fr.org<mailto:
> khali@linux-fr.org>> wrote:
> >>
> >>     On Thu, 9 Jun 2011 13:53:09 +0530, anish singh wrote:
> >>     > On Wed, Jun 8, 2011 at 10:41 AM, anish singh <
> anish198519851985@gmail.com <mailto:anish198519851985@gmail.com>>wrote:
> >>     > >  On Tue, Jun 7, 2011 at 7:32 PM, Jean Delvare <
> khali@linux-fr.org <mailto:khali@linux-fr.org>> wrote:
> >>     > >> To be clearer, it is down to the i2c BUS (adapter) driver, NOT
> the i2c
> >>     > >> device driver. So the patch is correct.
> >>     > >>
> >>     > > I think i can take Jean ack on this?If yes then Joanthan kindly
> apply
> >>     > > this patch and i think you didn't lead me in wrong way as
> whatever
> >>     > > said by you is corroborated by jean also i.e. it is I2C bus
> driver
> >>     > > responsiblity
> >>     > > to care about DMA.
> >>     > >
> >>     > Sorry to ping you again.Can i take your ack on this?
> >>
> >>     Yes of course.
> >>
> >>     Acked-by: Jean Delvare <khali@linux-fr.org <mailto:
> khali@linux-fr.org>>
> >>
> >> Thanks a ton.Jonathan kindly apply it now :)
> > Greg, I'll send this one on to you with the set I currently have out for
> review.
> >
> Doh, after all this, I just tried to apply this to find the code in
> question has already
> gone.  Anish, what tree are you working against?

I am using linux-next.Is it not the right tree for staging?

> Looks like I did an equivalent clean up
> (with a load of others) back in May then forgot about it.
>
> Sorry all. I should have actually have checked it was still relevant rather
> than reviewing
> purely on basis of content of patch...
>
> Jonathan
>

--0015175dda021e252704a54847c7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Thu, Jun 9, 2011 at 7:46 PM, Jonathan Cameron=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@cam.ac.uk">jic23@cam.ac.uk</=
a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div>
<div></div>
<div class=3D"h5">On 06/09/11 09:48, Jonathan Cameron wrote:<br>&gt; On 06/=
09/11 09:34, anish singh wrote:<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; On Thu,=
 Jun 9, 2011 at 1:59 PM, Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.=
org">khali@linux-fr.org</a> &lt;mailto:<a href=3D"mailto:khali@linux-fr.org=
">khali@linux-fr.org</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>&gt;&gt; =C2=A0 =C2=A0 On Thu, 9 Jun 2011 13:53:09 +0530, anish=
 singh wrote:<br>&gt;&gt; =C2=A0 =C2=A0 &gt; On Wed, Jun 8, 2011 at 10:41 A=
M, anish singh &lt;<a href=3D"mailto:anish198519851985@gmail.com">anish1985=
19851985@gmail.com</a> &lt;mailto:<a href=3D"mailto:anish198519851985@gmail=
.com">anish198519851985@gmail.com</a>&gt;&gt;wrote:<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; &gt; =C2=A0On Tue, Jun 7, 2011 at 7:32 PM, Jean=
 Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a> &=
lt;mailto:<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;&=
gt; wrote:<br>&gt;&gt; =C2=A0 =C2=A0 &gt; &gt;&gt; To be clearer, it is dow=
n to the i2c BUS (adapter) driver, NOT the i2c<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; &gt;&gt; device driver. So the patch is correct=
.<br>&gt;&gt; =C2=A0 =C2=A0 &gt; &gt;&gt;<br>&gt;&gt; =C2=A0 =C2=A0 &gt; &g=
t; I think i can take Jean ack on this?If yes then Joanthan kindly apply<br=
>&gt;&gt; =C2=A0 =C2=A0 &gt; &gt; this patch and i think you didn&#39;t lea=
d me in wrong way as whatever<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; &gt; said by you is corroborated by jean also i=
.e. it is I2C bus driver<br>&gt;&gt; =C2=A0 =C2=A0 &gt; &gt; responsiblity<=
br>&gt;&gt; =C2=A0 =C2=A0 &gt; &gt; to care about DMA.<br>&gt;&gt; =C2=A0 =
=C2=A0 &gt; &gt;<br>&gt;&gt; =C2=A0 =C2=A0 &gt; Sorry to ping you again.Can=
 i take your ack on this?<br>
&gt;&gt;<br>&gt;&gt; =C2=A0 =C2=A0 Yes of course.<br>&gt;&gt;<br>&gt;&gt; =
=C2=A0 =C2=A0 Acked-by: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.o=
rg">khali@linux-fr.org</a> &lt;mailto:<a href=3D"mailto:khali@linux-fr.org"=
>khali@linux-fr.org</a>&gt;&gt;<br>
&gt;&gt;<br>&gt;&gt; Thanks a ton.Jonathan kindly apply it now :)<br>&gt; G=
reg, I&#39;ll send this one on to you with the set I currently have out for=
 review.<br>&gt;<br></div></div>Doh, after all this, I just tried to apply =
this to find the code in question has already<br>
gone. =C2=A0Anish, what tree are you working against?</blockquote>
<div>I am using linux-next.Is it not the right tree for staging?</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">Looks like I did an equivalent c=
lean up<br>(with a load of others) back in May then forgot about it.<br><br=
>
Sorry all. I should have actually have checked it was still relevant rather=
 than reviewing<br>purely on basis of content of patch...<br><font color=3D=
"#888888"><br>Jonathan<br></font></blockquote></div><br>

--0015175dda021e252704a54847c7--
