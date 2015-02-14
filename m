Return-Path: <vthakkar1994@gmail.com>
MIME-Version: 1.0
In-Reply-To: <54DF858C.6030900@kernel.org>
References: <20150211091727.GA17552@vaishali-Ideapad-Z570>
	<54DF38BF.9040404@kernel.org>
	<54DF858C.6030900@kernel.org>
Date: Sat, 14 Feb 2015 23:25:07 +0530
Message-ID: <CAK-LDbJy2Yem5Sy77RdFeJVxuRjYBo+CCgFvggz2JsRGp36abA@mail.gmail.com>
Subject: Re: [PATCH] iio: gp2ap020a00f: Use put_unaligned_le32
From: Vaishali Thakkar <vthakkar1994@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, linux-kernel@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b86ea96bdec69050f100d0e
List-ID: <linux-iio@vger.kernel.org>

--047d7b86ea96bdec69050f100d0e
Content-Type: text/plain; charset=UTF-8

On Feb 14, 2015 10:57 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:
>
> On 14/02/15 11:59, Jonathan Cameron wrote:
> > On 11/02/15 09:17, Vaishali Thakkar wrote:
> >> This patch introduces the use of function put_unaligned_le32.
> >>
> >> This is done using Coccinelle and semantic patch used is as follows:
> >>
> >> @@ identifier tmp; expression ptr; expression y,e; type T; @@
> >>
> >> - tmp = cpu_to_le32(y);
> >>
> >>   <+... when != tmp
> >> - memcpy(ptr, (T)&tmp, ...);
> >> + put_unaligned_le32(y,ptr);
> >>   ...+>
> >> ? tmp = e
> >>
> >> @@ type T; identifier tmp; @@
> >>
> >> - T tmp;
> >> ...when != tmp
> >>
> >> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> > Applied to togreg branch of iio.git.  Will be initially pushed out as
> > testing for the autobuilders to play with it.
> >
> This needs an include - probably asm/unaligned.h so I'll add that.

Oh...sorry.I build tested it.May be something went wrong from my side.

Anyways thanks for adding it.

> > Thanks,
> >> ---
> >>  drivers/iio/light/gp2ap020a00f.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iio/light/gp2ap020a00f.c
b/drivers/iio/light/gp2ap020a00f.c
> >> index 221ed16..650c05f 100644
> >> --- a/drivers/iio/light/gp2ap020a00f.c
> >> +++ b/drivers/iio/light/gp2ap020a00f.c
> >> @@ -966,7 +966,6 @@ static irqreturn_t
gp2ap020a00f_trigger_handler(int irq, void *data)
> >>      struct iio_dev *indio_dev = pf->indio_dev;
> >>      struct gp2ap020a00f_data *priv = iio_priv(indio_dev);
> >>      size_t d_size = 0;
> >> -    __le32 light_lux;
> >>      int i, out_val, ret;
> >>
> >>      for_each_set_bit(i, indio_dev->active_scan_mask,
> >> @@ -981,8 +980,8 @@ static irqreturn_t
gp2ap020a00f_trigger_handler(int irq, void *data)
> >>                  i == GP2AP020A00F_SCAN_MODE_LIGHT_IR) {
> >>                      out_val = le16_to_cpup((__le16
*)&priv->buffer[d_size]);
> >>                      gp2ap020a00f_output_to_lux(priv, &out_val);
> >> -                    light_lux = cpu_to_le32(out_val);
> >> -                    memcpy(&priv->buffer[d_size], (u8 *)&light_lux,
4);
> >> +
> >> +                    put_unaligned_le32(out_val,
&priv->buffer[d_size]);
> >>                      d_size += 4;
> >>              } else {
> >>                      d_size += 2;
> >>
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>

--047d7b86ea96bdec69050f100d0e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
On Feb 14, 2015 10:57 PM, &quot;Jonathan Cameron&quot; &lt;<a href=3D"mailt=
o:jic23@kernel.org">jic23@kernel.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 14/02/15 11:59, Jonathan Cameron wrote:<br>
&gt; &gt; On 11/02/15 09:17, Vaishali Thakkar wrote:<br>
&gt; &gt;&gt; This patch introduces the use of function put_unaligned_le32.=
<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This is done using Coccinelle and semantic patch used is as f=
ollows:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; @@ identifier tmp; expression ptr; expression y,e; type T; @@=
<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; - tmp =3D cpu_to_le32(y);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0&lt;+... when !=3D tmp<br>
&gt; &gt;&gt; - memcpy(ptr, (T)&amp;tmp, ...);<br>
&gt; &gt;&gt; + put_unaligned_le32(y,ptr);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0...+&gt;<br>
&gt; &gt;&gt; ? tmp =3D e<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; @@ type T; identifier tmp; @@<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; - T tmp;<br>
&gt; &gt;&gt; ...when !=3D tmp<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Vaishali Thakkar &lt;<a href=3D"mailto:vthakka=
r1994@gmail.com">vthakkar1994@gmail.com</a>&gt;<br>
&gt; &gt; Applied to togreg branch of iio.git.=C2=A0 Will be initially push=
ed out as<br>
&gt; &gt; testing for the autobuilders to play with it.<br>
&gt; &gt;<br>
&gt; This needs an include - probably asm/unaligned.h so I&#39;ll add that.=
</p>
<p>Oh...sorry.I build tested it.May be something went wrong from my side.</=
p>
<p>Anyways thanks for adding it.=C2=A0 </p>
<p>&gt; &gt; Thanks,<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 drivers/iio/light/gp2ap020a00f.c | 5 ++---<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 2 insertions(+), 3 deletions(-)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/l=
ight/gp2ap020a00f.c<br>
&gt; &gt;&gt; index 221ed16..650c05f 100644<br>
&gt; &gt;&gt; --- a/drivers/iio/light/gp2ap020a00f.c<br>
&gt; &gt;&gt; +++ b/drivers/iio/light/gp2ap020a00f.c<br>
&gt; &gt;&gt; @@ -966,7 +966,6 @@ static irqreturn_t gp2ap020a00f_trigger_h=
andler(int irq, void *data)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D pf-&gt;indi=
o_dev;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 struct gp2ap020a00f_data *priv =3D iio_pr=
iv(indio_dev);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 size_t d_size =3D 0;<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 __le32 light_lux;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 int i, out_val, ret;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 for_each_set_bit(i, indio_dev-&gt;active_=
scan_mask,<br>
&gt; &gt;&gt; @@ -981,8 +980,8 @@ static irqreturn_t gp2ap020a00f_trigger_h=
andler(int irq, void *data)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 i =3D=3D GP2AP020A00F_SCAN_MODE_LIGHT_IR) {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 out_val =3D le16_to_cpup((__le16 *)&amp;priv-&gt;buffer[d_si=
ze]);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 gp2ap020a00f_output_to_lux(priv, &amp;out_val);<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 light_lux =3D cpu_to_le32(out_val);<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 memcpy(&amp;priv-&gt;buffer[d_size], (u8 *)&amp;light_lux, 4);<b=
r>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 put_unaligned_le32(out_val, &amp;priv-&gt;buffer[d_size]);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 d_size +=3D 4;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 d_size +=3D 2;<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; To unsubscribe from this list: send the line &quot;unsubscribe li=
nux-iio&quot; in<br>
&gt; &gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.=
org">majordomo@vger.kernel.org</a><br>
&gt; &gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/ma=
jordomo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
&gt; &gt;<br>
&gt;<br>
</p>

--047d7b86ea96bdec69050f100d0e--
