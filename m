Return-Path: <anish198519851985@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4DF0DDDA.40105@cam.ac.uk>
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
	<BANLkTik4Tfd73iKcDsXK-sfy6_ADVX4oYA@mail.gmail.com>
	<4DF0DDDA.40105@cam.ac.uk>
Date: Fri, 10 Jun 2011 00:03:44 +0900
Message-ID: <BANLkTim-=cOQoNiOaHFGGjvsENFwBcwWiA@mail.gmail.com>
Subject: Re: [PATCH] staging iio: Replace kmalloc with local variable
From: anish singh <anish198519851985@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-i2c@fluff.org>, gregkh@suse.de,
	manuel.stahl@iis.fraunhofer.de, lucas.demarchi@profusion.mobi,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: multipart/alternative; boundary=000e0cd5bd6069535204a548c2a9
List-ID: <linux-iio@vger.kernel.org>

--000e0cd5bd6069535204a548c2a9
Content-Type: text/plain; charset=UTF-8

On Thu, Jun 9, 2011 at 11:51 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:

> On 06/09/11 15:29, anish singh wrote:
> >
> >
> > On Thu, Jun 9, 2011 at 7:46 PM, Jonathan Cameron <jic23@cam.ac.uk<mailto:
> jic23@cam.ac.uk>> wrote:
> >
> >     On 06/09/11 09:48, Jonathan Cameron wrote:
> >     > On 06/09/11 09:34, anish singh wrote:
> >     >>
> >     >>
> >     >> On Thu, Jun 9, 2011 at 1:59 PM, Jean Delvare <khali@linux-fr.org<mailto:
> khali@linux-fr.org> <mailto:khali@linux-fr.org <mailto:khali@linux-fr.org>>>
> wrote:
> >     >>
> >     >>     On Thu, 9 Jun 2011 13:53:09 +0530, anish singh wrote:
> >     >>     > On Wed, Jun 8, 2011 at 10:41 AM, anish singh <
> anish198519851985@gmail.com <mailto:anish198519851985@gmail.com> <mailto:
> anish198519851985@gmail.com <mailto:anish198519851985@gmail.com>>>wrote:
> >     >>     > >  On Tue, Jun 7, 2011 at 7:32 PM, Jean Delvare <
> khali@linux-fr.org <mailto:khali@linux-fr.org> <mailto:khali@linux-fr.org<mailto:
> khali@linux-fr.org>>> wrote:
> >     >>     > >> To be clearer, it is down to the i2c BUS (adapter)
> driver, NOT the i2c
> >     >>     > >> device driver. So the patch is correct.
> >     >>     > >>
> >     >>     > > I think i can take Jean ack on this?If yes then Joanthan
> kindly apply
> >     >>     > > this patch and i think you didn't lead me in wrong way as
> whatever
> >     >>     > > said by you is corroborated by jean also i.e. it is I2C
> bus driver
> >     >>     > > responsiblity
> >     >>     > > to care about DMA.
> >     >>     > >
> >     >>     > Sorry to ping you again.Can i take your ack on this?
> >     >>
> >     >>     Yes of course.
> >     >>
> >     >>     Acked-by: Jean Delvare <khali@linux-fr.org <mailto:
> khali@linux-fr.org> <mailto:khali@linux-fr.org <mailto:khali@linux-fr.org
> >>>
> >     >>
> >     >> Thanks a ton.Jonathan kindly apply it now :)
> >     > Greg, I'll send this one on to you with the set I currently have
> out for review.
> >     >
> >     Doh, after all this, I just tried to apply this to find the code in
> question has already
> >     gone.  Anish, what tree are you working against?
> >
> > I am using linux-next.Is it not the right tree for staging?
> Something curious is going on then because this code is no longer in
> linux-next either.
>
Even checked it now it is not there.Will check, thanks.

>  >
> >     Looks like I did an equivalent clean up
> >     (with a load of others) back in May then forgot about it.
> >
> >     Sorry all. I should have actually have checked it was still relevant
> rather than reviewing
> >     purely on basis of content of patch...
> >
> >     Jonathan
> >
> >
>
>

--000e0cd5bd6069535204a548c2a9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Thu, Jun 9, 2011 at 11:51 PM, Jonathan Camero=
n <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@cam.ac.uk">jic23@cam.ac.uk<=
/a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">On 06/09/11 15:29, anish singh w=
rote:<br>
<div class=3D"im">&gt;<br>&gt;<br>&gt; On Thu, Jun 9, 2011 at 7:46 PM, Jona=
than Cameron &lt;<a href=3D"mailto:jic23@cam.ac.uk">jic23@cam.ac.uk</a> &lt=
;mailto:<a href=3D"mailto:jic23@cam.ac.uk">jic23@cam.ac.uk</a>&gt;&gt; wrot=
e:<br>
&gt;<br>&gt; =C2=A0 =C2=A0 On 06/09/11 09:48, Jonathan Cameron wrote:<br>&g=
t; =C2=A0 =C2=A0 &gt; On 06/09/11 09:34, anish singh wrote:<br>&gt; =C2=A0 =
=C2=A0 &gt;&gt;<br>&gt; =C2=A0 =C2=A0 &gt;&gt;<br></div>
<div class=3D"im">&gt; =C2=A0 =C2=A0 &gt;&gt; On Thu, Jun 9, 2011 at 1:59 P=
M, Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.or=
g</a> &lt;mailto:<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</=
a>&gt; &lt;mailto:<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org<=
/a> &lt;mailto:<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>=
&gt;&gt;&gt; wrote:<br>
&gt; =C2=A0 =C2=A0 &gt;&gt;<br>&gt; =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 On=
 Thu, 9 Jun 2011 13:53:09 +0530, anish singh wrote:<br></div>
<div class=3D"im">&gt; =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; On Wed, Ju=
n 8, 2011 at 10:41 AM, anish singh &lt;<a href=3D"mailto:anish198519851985@=
gmail.com">anish198519851985@gmail.com</a> &lt;mailto:<a href=3D"mailto:ani=
sh198519851985@gmail.com">anish198519851985@gmail.com</a>&gt; &lt;mailto:<a=
 href=3D"mailto:anish198519851985@gmail.com">anish198519851985@gmail.com</a=
> &lt;mailto:<a href=3D"mailto:anish198519851985@gmail.com">anish1985198519=
85@gmail.com</a>&gt;&gt;&gt;wrote:<br>
&gt; =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; &gt; =C2=A0On Tue, Jun 7, 20=
11 at 7:32 PM, Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali=
@linux-fr.org</a> &lt;mailto:<a href=3D"mailto:khali@linux-fr.org">khali@li=
nux-fr.org</a>&gt; &lt;mailto:<a href=3D"mailto:khali@linux-fr.org">khali@l=
inux-fr.org</a> &lt;mailto:<a href=3D"mailto:khali@linux-fr.org">khali@linu=
x-fr.org</a>&gt;&gt;&gt; wrote:<br>
&gt; =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; &gt;&gt; To be clearer, it i=
s down to the i2c BUS (adapter) driver, NOT the i2c<br>&gt; =C2=A0 =C2=A0 &=
gt;&gt; =C2=A0 =C2=A0 &gt; &gt;&gt; device driver. So the patch is correct.=
<br>&gt; =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; &gt; I think i can take Jean=
 ack on this?If yes then Joanthan kindly apply<br>&gt; =C2=A0 =C2=A0 &gt;&g=
t; =C2=A0 =C2=A0 &gt; &gt; this patch and i think you didn&#39;t lead me in=
 wrong way as whatever<br>&gt; =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; &g=
t; said by you is corroborated by jean also i.e. it is I2C bus driver<br>
&gt; =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; &gt; responsiblity<br>&gt; =
=C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; &gt; to care about DMA.<br>&gt; =
=C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; &gt;<br>&gt; =C2=A0 =C2=A0 &gt;&g=
t; =C2=A0 =C2=A0 &gt; Sorry to ping you again.Can i take your ack on this?<=
br>
&gt; =C2=A0 =C2=A0 &gt;&gt;<br>&gt; =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 Ye=
s of course.<br>&gt; =C2=A0 =C2=A0 &gt;&gt;<br></div>&gt; =C2=A0 =C2=A0 &gt=
;&gt; =C2=A0 =C2=A0 Acked-by: Jean Delvare &lt;<a href=3D"mailto:khali@linu=
x-fr.org">khali@linux-fr.org</a> &lt;mailto:<a href=3D"mailto:khali@linux-f=
r.org">khali@linux-fr.org</a>&gt; &lt;mailto:<a href=3D"mailto:khali@linux-=
fr.org">khali@linux-fr.org</a> &lt;mailto:<a href=3D"mailto:khali@linux-fr.=
org">khali@linux-fr.org</a>&gt;&gt;&gt;<br>

<div class=3D"im">&gt; =C2=A0 =C2=A0 &gt;&gt;<br>&gt; =C2=A0 =C2=A0 &gt;&gt=
; Thanks a ton.Jonathan kindly apply it now :)<br>&gt; =C2=A0 =C2=A0 &gt; G=
reg, I&#39;ll send this one on to you with the set I currently have out for=
 review.<br>&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 Doh, after all this, I just tried to apply this to find =
the code in question has already<br>&gt; =C2=A0 =C2=A0 gone. =C2=A0Anish, w=
hat tree are you working against?<br>&gt;<br>&gt; I am using linux-next.Is =
it not the right tree for staging?<br>
</div>Something curious is going on then because this code is no longer in =
linux-next either.<br></blockquote>
<div>Even checked it now it is not there.Will check, thanks.</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div>
<div></div>
<div class=3D"h5">&gt;<br>&gt; =C2=A0 =C2=A0 Looks like I did an equivalent=
 clean up<br>&gt; =C2=A0 =C2=A0 (with a load of others) back in May then fo=
rgot about it.<br>&gt;<br>&gt; =C2=A0 =C2=A0 Sorry all. I should have actua=
lly have checked it was still relevant rather than reviewing<br>
&gt; =C2=A0 =C2=A0 purely on basis of content of patch...<br>&gt;<br>&gt; =
=C2=A0 =C2=A0 Jonathan<br>&gt;<br>&gt;<br><br></div></div></blockquote></di=
v><br>

--000e0cd5bd6069535204a548c2a9--
