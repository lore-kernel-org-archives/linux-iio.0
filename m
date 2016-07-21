Return-Path: <pgrudzinski@openmailbox.org>
MIME-Version: 1.0
In-Reply-To: <db7bbbe6-9c9d-8672-4436-a19cff47525c@metafoo.de>
References: <20160713233202.812-1-pgrudzinski@openmailbox.org> <db7bbbe6-9c9d-8672-4436-a19cff47525c@metafoo.de>
From: =?UTF-8?B?UGF3ZcWCIEdydWR6acWEc2tp?= <pgrudzinski@openmailbox.org>
Date: Thu, 21 Jul 2016 12:05:52 +0200
Message-ID: <CA+XhPW_nRTkGe115wGMO+DKY-UQCuztTgvZh6naZ2wQ0=KHMEA@mail.gmail.com>
Subject: Re: [PATCH] iio: ad5380: Fix probe failure when no external reference
 is supplied
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=94eb2c0d789c93309e05382276fd
List-ID: <linux-iio@vger.kernel.org>

--94eb2c0d789c93309e05382276fd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for comment. I have posted patch with corrections as you suggested.

Best regards,

Pawe=C5=82 Grudzi=C5=84ski

On Thu, Jul 14, 2016 at 9:55 AM, Lars-Peter Clausen <lars@metafoo.de> wrote=
:

> On 07/14/2016 01:32 AM, Pawe=C5=82 Grudzi=C5=84ski wrote:
> > From: Pawel Grudzinski <pgrudzinski@openmailbox.org>
> >
> > Driver fails to load when there is no external Vref regulator defined,
> > leaving no way to use internal reference. ad5380_probe function tries t=
o
> > obtain regulator with demv_regulator_get and checks for error, in which
> > case it would use internal reference. Even without "Vref" regulator
> defined
> > devm_regulator_get returns dummy regulator which makes function omit us=
e
> of
> > internal reference and causes failure on regulator_get_voltage.
> >
> > Replace demv_regulator_get with demv_regulator_get_optional, which
> returns
> > error instead of dummy regulator if it does not find one which is
> specified
> > by the caller to make ad5380_probe configure internal reference when no
> > "Vref" regulator is supplied.
> >
> > Signed-off-by: Pawe=C5=82 Grudzi=C5=84ski <pgrudzinski@openmailbox.org>
>
> Looks good, thanks. But there is a way to improve on it even more, see
> comments inline. Up to you whether you want to do this or not.
>
> Either way.
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
> > ---
> > There are couple more places where I suspect similar issue with devices
> > having integrated reference, but I am sending this one because I tested
> it
> > with hardware. If this gets accepted, I will look through other drivers
> > obtaining Vref in same manner.
>
> I believe most of those drivers predate the get_optional() API.
>
> >
> >  drivers/iio/dac/ad5380.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> > index 97d2c51..257d455 100644
> > --- a/drivers/iio/dac/ad5380.c
> > +++ b/drivers/iio/dac/ad5380.c
> > @@ -401,7 +401,7 @@ static int ad5380_probe(struct device *dev, struct
> regmap *regmap,
> >       if (st->chip_info->int_vref =3D=3D 2500)
> >               ctrl |=3D AD5380_CTRL_INT_VREF_2V5;
> >
> > -     st->vref_reg =3D devm_regulator_get(dev, "vref");
> > +     st->vref_reg =3D devm_regulator_get_optional(dev, "vref");
>
> Ideally we'd do something like
>
>     st->vref_reg =3D devm_regulator_get_optional(&st->spi->dev, "vref");
>     if (!IS_ERR(st->vref_reg)) {
>         /* use external vref */
>     } else {
>         if (PTR_ERR(st->vref_reg) !=3D -ENODEV) {
>             ret =3D PTR_ERR(st->vref_reg);
>             goto err_free_reg;
>         }
>         /* use internal vref ... */
>     }
>
> This makes sure that real errors returned by regulator_get_optional() are
> actually handled. The only error that we want to ignore is the case where
> no
> regulator has been specified, if a regulator has been specified but there
> is
> a problem with the specification we don't want to switch to internal vref
> mode, but rather propagate the error. This is especially important to mak=
e
> probe deferring work, which kicks in when the DAC is tried to be probed
> before the regulator has finished probing.
>
>
> >       if (!IS_ERR(st->vref_reg)) {
> >               ret =3D regulator_enable(st->vref_reg);
> >               if (ret) {
> >
>
>

--94eb2c0d789c93309e05382276fd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Thanks for comment. I have posted patch with cor=
rections as you suggested. <br><br></div>Best regards,<br><br></div>Pawe=C5=
=82 Grudzi=C5=84ski<br></div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Thu, Jul 14, 2016 at 9:55 AM, Lars-Peter Clausen <span dir=
=3D"ltr">&lt;<a href=3D"mailto:lars@metafoo.de" target=3D"_blank">lars@meta=
foo.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On 07/14/2016 01:32 AM, Pawe=C5=82 Grudzi=C5=84ski wrote:<br>
&gt; From: Pawel Grudzinski &lt;<a href=3D"mailto:pgrudzinski@openmailbox.o=
rg">pgrudzinski@openmailbox.org</a>&gt;<br>
&gt;<br>
&gt; Driver fails to load when there is no external Vref regulator defined,=
<br>
&gt; leaving no way to use internal reference. ad5380_probe function tries =
to<br>
&gt; obtain regulator with demv_regulator_get and checks for error, in whic=
h<br>
&gt; case it would use internal reference. Even without &quot;Vref&quot; re=
gulator defined<br>
&gt; devm_regulator_get returns dummy regulator which makes function omit u=
se of<br>
&gt; internal reference and causes failure on regulator_get_voltage.<br>
&gt;<br>
&gt; Replace demv_regulator_get with demv_regulator_get_optional, which ret=
urns<br>
&gt; error instead of dummy regulator if it does not find one which is spec=
ified<br>
&gt; by the caller to make ad5380_probe configure internal reference when n=
o<br>
&gt; &quot;Vref&quot; regulator is supplied.<br>
&gt;<br>
&gt; Signed-off-by: Pawe=C5=82 Grudzi=C5=84ski &lt;<a href=3D"mailto:pgrudz=
inski@openmailbox.org">pgrudzinski@openmailbox.org</a>&gt;<br>
<br>
</span>Looks good, thanks. But there is a way to improve on it even more, s=
ee<br>
comments inline. Up to you whether you want to do this or not.<br>
<br>
Either way.<br>
<br>
Acked-by: Lars-Peter Clausen &lt;<a href=3D"mailto:lars@metafoo.de">lars@me=
tafoo.de</a>&gt;<br>
<span class=3D""><br>
&gt; ---<br>
&gt; There are couple more places where I suspect similar issue with device=
s<br>
&gt; having integrated reference, but I am sending this one because I teste=
d it<br>
&gt; with hardware. If this gets accepted, I will look through other driver=
s<br>
&gt; obtaining Vref in same manner.<br>
<br>
</span>I believe most of those drivers predate the get_optional() API.<br>
<span class=3D""><br>
&gt;<br>
&gt;=C2=A0 drivers/iio/dac/ad5380.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c<br>
&gt; index 97d2c51..257d455 100644<br>
&gt; --- a/drivers/iio/dac/ad5380.c<br>
&gt; +++ b/drivers/iio/dac/ad5380.c<br>
&gt; @@ -401,7 +401,7 @@ static int ad5380_probe(struct device *dev, struct=
 regmap *regmap,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (st-&gt;chip_info-&gt;int_vref =3D=3D 250=
0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl |=3D AD5380=
_CTRL_INT_VREF_2V5;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0st-&gt;vref_reg =3D devm_regulator_get(dev, &quot=
;vref&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0st-&gt;vref_reg =3D devm_regulator_get_optional(d=
ev, &quot;vref&quot;);<br>
<br>
</span>Ideally we&#39;d do something like<br>
<br>
=C2=A0 =C2=A0 st-&gt;vref_reg =3D devm_regulator_get_optional(&amp;st-&gt;s=
pi-&gt;dev, &quot;vref&quot;);<br>
=C2=A0 =C2=A0 if (!IS_ERR(st-&gt;vref_reg)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* use external vref */<br>
=C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PTR_ERR(st-&gt;vref_reg) !=3D -ENODEV) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D PTR_ERR(st-&gt;vref_reg);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free_reg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* use internal vref ... */<br>
=C2=A0 =C2=A0 }<br>
<br>
This makes sure that real errors returned by regulator_get_optional() are<b=
r>
actually handled. The only error that we want to ignore is the case where n=
o<br>
regulator has been specified, if a regulator has been specified but there i=
s<br>
a problem with the specification we don&#39;t want to switch to internal vr=
ef<br>
mode, but rather propagate the error. This is especially important to make<=
br>
probe deferring work, which kicks in when the DAC is tried to be probed<br>
before the regulator has finished probing.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!IS_ERR(st-&gt;vref_reg)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D regulato=
r_enable(st-&gt;vref_reg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div>

--94eb2c0d789c93309e05382276fd--
