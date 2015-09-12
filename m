Return-Path: <shraddha.6596@gmail.com>
MIME-Version: 1.0
In-Reply-To: <55F3F49D.9000201@kernel.org>
References: <1441902761-11190-1-git-send-email-shraddha.6596@gmail.com>
	<55F3F49D.9000201@kernel.org>
Date: Sat, 12 Sep 2015 16:47:23 +0530
Message-ID: <CAO393ABYMQof2s-R3E1GPS5c9OZDFN_VhidCaXS6HHULcd0zXg@mail.gmail.com>
Subject: Re: [PATCH 4/6] Staging: iio: cdc: Prefer using the BIT macro
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>,
	Hartmut Knaack <knaack.h@gmx.de>, Andreas Dilger <andreas.dilger@intel.com>,
	Ian Abbott <abbotti@mev.co.uk>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=089e0111d1befbceb3051f8af9ae
List-ID: <linux-iio@vger.kernel.org>

--089e0111d1befbceb3051f8af9ae
Content-Type: text/plain; charset=UTF-8

On Sat, Sep 12, 2015 at 3:17 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 10/09/15 17:32, Shraddha Barke wrote:
> > This patch replaces bit shifting on 1 with the BIT(x) macro
> >
> > This was done with coccinelle:
> > @@ int g; @@
> >
> > -(1 << g)
> > +BIT(g)
> >
> > Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> Something odd happened here as this is only a small proportion of the cases
> that should be updated in this file.  There's one at the bottom of the
> patch for starters!
>
> I didn't apply BIT(x) for mixed cases.I think I should drop this patch
altogether but
Greg has added it. Will it cause problems ? :(


> This driver also uses  a lot of cases of 0 shifted to represent
> the opposite state for a given bit in the register.  The effective
> documentation provided by that is lost if we convert the bit set ones
> over like this.  Might seem odd, but perhaps we need a ZERO(X) macro
> as well (which is of course always 0) to cover that approach.
>
> Jonathan
> > ---
> >  drivers/staging/iio/cdc/ad7746.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7746.c
> b/drivers/staging/iio/cdc/ad7746.c
> > index e6e9eaa..10fa372 100644
> > --- a/drivers/staging/iio/cdc/ad7746.c
> > +++ b/drivers/staging/iio/cdc/ad7746.c
> > @@ -46,10 +46,10 @@
> >  #define AD7746_REG_VOLT_GAINL                18
> >
> >  /* Status Register Bit Designations (AD7746_REG_STATUS) */
> > -#define AD7746_STATUS_EXCERR         (1 << 3)
> > -#define AD7746_STATUS_RDY            (1 << 2)
> > -#define AD7746_STATUS_RDYVT          (1 << 1)
> > -#define AD7746_STATUS_RDYCAP         (1 << 0)
> > +#define AD7746_STATUS_EXCERR         BIT(3)
> > +#define AD7746_STATUS_RDY            BIT(2)
> > +#define AD7746_STATUS_RDYVT          BIT(1)
> > +#define AD7746_STATUS_RDYCAP         BIT(0)
> >
> >  /* Capacitive Channel Setup Register Bit Designations
> (AD7746_REG_CAP_SETUP) */
> >  #define AD7746_CAPSETUP_CAPEN                (1 << 7)
> >
>
>

--089e0111d1befbceb3051f8af9ae
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Sep 12, 2015 at 3:17 PM, Jonathan Cameron <span dir=3D"ltr">&lt=
;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@kernel.org</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 10/09/15 17:32, Shr=
addha Barke wrote:<br>
&gt; This patch replaces bit shifting on 1 with the BIT(x) macro<br>
&gt;<br>
&gt; This was done with coccinelle:<br>
&gt; @@ int g; @@<br>
&gt;<br>
&gt; -(1 &lt;&lt; g)<br>
&gt; +BIT(g)<br>
&gt;<br>
&gt; Signed-off-by: Shraddha Barke &lt;<a href=3D"mailto:shraddha.6596@gmai=
l.com">shraddha.6596@gmail.com</a>&gt;<br>
Something odd happened here as this is only a small proportion of the cases=
<br>
that should be updated in this file.=C2=A0 There&#39;s one at the bottom of=
 the<br>
patch for starters!<br>
<br></blockquote><div>I didn&#39;t apply BIT(x) for mixed cases.I think I s=
hould drop this patch altogether but <br></div><div>Greg has added it. Will=
 it cause problems ? :(<br></div><div>=C2=A0<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
This driver also uses=C2=A0 a lot of cases of 0 shifted to represent<br>
the opposite state for a given bit in the register.=C2=A0 The effective<br>
documentation provided by that is lost if we convert the bit set ones<br>
over like this.=C2=A0 Might seem odd, but perhaps we need a ZERO(X) macro<b=
r>
as well (which is of course always 0) to cover that approach.<br>
<br>
Jonathan<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/iio/cdc/ad7746.c | 8 ++++----<br>
&gt;=C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cd=
c/ad7746.c<br>
&gt; index e6e9eaa..10fa372 100644<br>
&gt; --- a/drivers/staging/iio/cdc/ad7746.c<br>
&gt; +++ b/drivers/staging/iio/cdc/ad7746.c<br>
&gt; @@ -46,10 +46,10 @@<br>
&gt;=C2=A0 #define AD7746_REG_VOLT_GAINL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 18<br>
&gt;<br>
&gt;=C2=A0 /* Status Register Bit Designations (AD7746_REG_STATUS) */<br>
&gt; -#define AD7746_STATUS_EXCERR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;=
&lt; 3)<br>
&gt; -#define AD7746_STATUS_RDY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1=
 &lt;&lt; 2)<br>
&gt; -#define AD7746_STATUS_RDYVT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;=
&lt; 1)<br>
&gt; -#define AD7746_STATUS_RDYCAP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;=
&lt; 0)<br>
&gt; +#define AD7746_STATUS_EXCERR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(3)<=
br>
&gt; +#define AD7746_STATUS_RDY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BI=
T(2)<br>
&gt; +#define AD7746_STATUS_RDYVT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(1)<=
br>
&gt; +#define AD7746_STATUS_RDYCAP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<=
br>
&gt;<br>
&gt;=C2=A0 /* Capacitive Channel Setup Register Bit Designations (AD7746_RE=
G_CAP_SETUP) */<br>
&gt;=C2=A0 #define AD7746_CAPSETUP_CAPEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 7)<br>
&gt;<br>
<br>
</blockquote></div><br></div></div>

--089e0111d1befbceb3051f8af9ae--
