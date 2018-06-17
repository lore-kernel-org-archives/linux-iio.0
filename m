Return-Path: <SRS0=mkf5=JD=gmail.com=karim.eshapa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180616190226.4a6a5980@archlinux>
References: <20180612162153.21789-1-karim.eshapa@gmail.com> <20180616190226.4a6a5980@archlinux>
From: karim eshapa <karim.eshapa@gmail.com>
Date: Sun, 17 Jun 2018 02:25:17 +0200
Message-ID: <CABf4As8beCiuof=qyC_pwZmWgBPZfOGEM8K3YvTW+SWXtpaoCg@mail.gmail.com>
Subject: Re: [PATCH v2] staging:iio:accel:adis16240: sign extend function
 avoiding code duplication
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000ca34d0056ecb7b81"
List-ID: <linux-iio@vger.kernel.org>

--000000000000ca34d0056ecb7b81
Content-Type: text/plain; charset="UTF-8"

>> Use sign_extend32 kernel function instead of code duplication,
>> Safe also for 16 bit. and remove declaration of bits variable not needed.
>>
>> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
>
>Please consider how a patch is applied and resend as a v3 which can
actually
>be applied.  Test it (by applying it yourself) to make sure you have
everything correct...

OK I did with the previous patches, but i didn't know what you meant in the
previous
mail with resend patch V2 included the change log so, I did what you have
seen :)
sorry for that.

Thanks,

On 16 June 2018 at 20:02, Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 12 Jun 2018 18:21:53 +0200
> Karim Eshapa <karim.eshapa@gmail.com> wrote:
>
> > Use sign_extend32 kernel function instead of code duplication,
> > Safe also for 16 bit. and remove declaration of bits variable not needed.
> >
> > Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
>
> Please consider how a patch is applied and resend as a v3 which can
> actually
> be applied.  Test it (by applying it yourself) to make sure you have
> everything correct...
>
> Jonathan
>
> >
> > >On Tue, 2018-06-12 at 01:38 +0200, Karim Eshapa wrote:
> > >> Use sign_extend32 kernel function instead of code duplication.
> > >> Safe also for 16 bit.
> > >
> > >Perhaps remove the bits declaration and assignments
> > >and just use 9 directly.
> > >
> > >> diff --git a/drivers/staging/iio/accel/adis16240.c
> b/drivers/staging/iio/accel/adis16240.c
> > >
> > >> @@ -292,9 +292,7 @@ static int adis16240_read_raw(struct iio_dev
> *indio_dev,
> > >>               ret = adis_read_reg_16(st, addr, &val16);
> > >>               if (ret)
> > >>                       return ret;
> > >> -             val16 &= (1 << bits) - 1;
> > >> -             val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> > >> -             *val = val16;
> > >> +             *val = sign_extend32(val16, bits - 1);
> > >>               return IIO_VAL_INT;
> > >>       case IIO_CHAN_INFO_PEAK:
> > >>               bits = 10;
> > >> @@ -302,9 +300,7 @@ static int adis16240_read_raw(struct iio_dev
> *indio_dev,
> > >>               ret = adis_read_reg_16(st, addr, &val16);
> > >>               if (ret)
> > >>                       return ret;
> > >> -             val16 &= (1 << bits) - 1;
> > >> -             val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> > >> -             *val = val16;
> > >> +             *val = sign_extend32(val16, bits - 1);
> > >>               return IIO_VAL_INT;
> > >>       }
> > >>       return -EINVAL;
> > ---
> >  drivers/staging/iio/accel/adis16240.c | 11 ++---------
> >  1 file changed, 2 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/staging/iio/accel/adis16240.c
> b/drivers/staging/iio/accel/adis16240.c
> > index fff6d99089cc..24e525f1ef25 100644
> > --- a/drivers/staging/iio/accel/adis16240.c
> > +++ b/drivers/staging/iio/accel/adis16240.c
> > @@ -250,7 +250,6 @@ static int adis16240_read_raw(struct iio_dev
> *indio_dev,
> >  {
> >       struct adis *st = iio_priv(indio_dev);
> >       int ret;
> > -     int bits;
> >       u8 addr;
> >       s16 val16;
> >
> > @@ -287,24 +286,18 @@ static int adis16240_read_raw(struct iio_dev
> *indio_dev,
> >               *val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
> >               return IIO_VAL_INT;
> >       case IIO_CHAN_INFO_CALIBBIAS:
> > -             bits = 10;
> >               addr = adis16240_addresses[chan->scan_index][0];
> >               ret = adis_read_reg_16(st, addr, &val16);
> >               if (ret)
> >                       return ret;
> > -             val16 &= (1 << bits) - 1;
> > -             val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> > -             *val = val16;
> > +             *val = sign_extend32(val16, 9);
> >               return IIO_VAL_INT;
> >       case IIO_CHAN_INFO_PEAK:
> > -             bits = 10;
> >               addr = adis16240_addresses[chan->scan_index][1];
> >               ret = adis_read_reg_16(st, addr, &val16);
> >               if (ret)
> >                       return ret;
> > -             val16 &= (1 << bits) - 1;
> > -             val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> > -             *val = val16;
> > +             *val = sign_extend32(val16, 9);
> >               return IIO_VAL_INT;
> >       }
> >       return -EINVAL;
>
>

--000000000000ca34d0056ecb7b81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-im" style=3D"color:rgb(80,0,80);font-=
size:12.8px;text-decoration-style:initial;text-decoration-color:initial">&g=
t;&gt; Use sign_extend32 kernel function instead of code duplication,<br>&g=
t;&gt; Safe also for 16 bit. and remove declaration of bits variable not ne=
eded.<br>&gt;&gt;<span>=C2=A0</span><br>&gt;&gt; Signed-off-by: Karim Eshap=
a &lt;<a href=3D"mailto:karim.eshapa@gmail.com" style=3D"color:rgb(17,85,20=
4)">karim.eshapa@gmail.com</a>&gt;<br>&gt;<br></span><span style=3D"font-si=
ze:12.8px;text-decoration-style:initial;text-decoration-color:initial;float=
:none;display:inline">&gt;Please consider how a patch is applied and resend=
 as a v3 which can actually<span>=C2=A0</span></span><br style=3D"font-size=
:12.8px;text-decoration-style:initial;text-decoration-color:initial"><span =
style=3D"font-size:12.8px;text-decoration-style:initial;text-decoration-col=
or:initial;float:none;display:inline">&gt;be applied.=C2=A0 Test it (by app=
lying it yourself) to make sure you have everything correct...</span><br><d=
iv><span style=3D"font-size:12.8px;text-decoration-style:initial;text-decor=
ation-color:initial;float:none;display:inline"><br></span></div><div><span =
style=3D"font-size:12.8px;text-decoration-style:initial;text-decoration-col=
or:initial;float:none;display:inline">OK I did with the previous patches, b=
ut i didn&#39;t know what you meant in the previous<br>mail with=C2=A0resen=
d patch V2 included the change log so, I did what you have seen :)=C2=A0<br=
>sorry for that.<br><br>Thanks,=C2=A0=C2=A0</span></div></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On 16 June 2018 at 20:02, Jona=
than Cameron <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@kernel.org" targ=
et=3D"_blank">jic23@kernel.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">On Tue, 12 Jun 2018 18:21:53 +0200<br>
Karim Eshapa &lt;<a href=3D"mailto:karim.eshapa@gmail.com">karim.eshapa@gma=
il.com</a>&gt; wrote:<br>
<br>
&gt; Use sign_extend32 kernel function instead of code duplication,<br>
&gt; Safe also for 16 bit. and remove declaration of bits variable not need=
ed.<br>
&gt; <br>
&gt; Signed-off-by: Karim Eshapa &lt;<a href=3D"mailto:karim.eshapa@gmail.c=
om">karim.eshapa@gmail.com</a>&gt;<br>
<br>
</span>Please consider how a patch is applied and resend as a v3 which can =
actually <br>
be applied.=C2=A0 Test it (by applying it yourself) to make sure you have e=
verything correct...<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Jonathan<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; <br>
&gt; &gt;On Tue, 2018-06-12 at 01:38 +0200, Karim Eshapa wrote:=C2=A0 <br>
&gt; &gt;&gt; Use sign_extend32 kernel function instead of code duplication=
.<br>
&gt; &gt;&gt; Safe also for 16 bit.=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt;Perhaps remove the bits declaration and assignments<br>
&gt; &gt;and just use 9 directly.<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;&gt; diff --git a/drivers/staging/iio/accel/<wbr>adis16240.c b/dri=
vers/staging/iio/accel/<wbr>adis16240.c=C2=A0 <br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;&gt; @@ -292,9 +292,7 @@ static int adis16240_read_raw(struct iio_=
dev *indio_dev,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D=
 adis_read_reg_16(st, addr, &amp;val16);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret=
)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 &amp;=
=3D (1 &lt;&lt; bits) - 1;<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 =3D (s=
16)(val16 &lt;&lt; (16 - bits)) &gt;&gt; (16 - bits);<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D val=
16;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D sig=
n_extend32(val16, bits - 1);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
IIO_VAL_INT;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_PEAK:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bits =
=3D 10;<br>
&gt; &gt;&gt; @@ -302,9 +300,7 @@ static int adis16240_read_raw(struct iio_=
dev *indio_dev,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D=
 adis_read_reg_16(st, addr, &amp;val16);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret=
)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 &amp;=
=3D (1 &lt;&lt; bits) - 1;<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 =3D (s=
16)(val16 &lt;&lt; (16 - bits)) &gt;&gt; (16 - bits);<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D val=
16;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D sig=
n_extend32(val16, bits - 1);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
IIO_VAL_INT;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;=C2=A0 <br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/iio/accel/<wbr>adis16240.c | 11 ++---------<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/staging/iio/accel/<wbr>adis16240.c b/drivers/stag=
ing/iio/accel/<wbr>adis16240.c<br>
&gt; index fff6d99089cc..24e525f1ef25 100644<br>
&gt; --- a/drivers/staging/iio/accel/<wbr>adis16240.c<br>
&gt; +++ b/drivers/staging/iio/accel/<wbr>adis16240.c<br>
&gt; @@ -250,7 +250,6 @@ static int adis16240_read_raw(struct iio_dev *indi=
o_dev,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis *st =3D iio_priv(indio_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int bits;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 addr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s16 val16;<br>
&gt;=C2=A0 <br>
&gt; @@ -287,24 +286,18 @@ static int adis16240_read_raw(struct iio_dev *in=
dio_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D 25000 /=
 244 - 0x133; /* 25 C =3D 0x133 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_I=
NT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_CALIBBIAS:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bits =3D 10;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D adis162=
40_addresses[chan-&gt;<wbr>scan_index][0];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D adis_rea=
d_reg_16(st, addr, &amp;val16);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 &amp;=3D (1 &lt=
;&lt; bits) - 1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 =3D (s16)(val16=
 &lt;&lt; (16 - bits)) &gt;&gt; (16 - bits);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D val16;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D sign_extend3=
2(val16, 9);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_I=
NT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_PEAK:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bits =3D 10;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D adis162=
40_addresses[chan-&gt;<wbr>scan_index][1];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D adis_rea=
d_reg_16(st, addr, &amp;val16);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 &amp;=3D (1 &lt=
;&lt; bits) - 1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 =3D (s16)(val16=
 &lt;&lt; (16 - bits)) &gt;&gt; (16 - bits);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D val16;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D sign_extend3=
2(val16, 9);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_I=
NT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
<br>
</div></div></blockquote></div><br></div>

--000000000000ca34d0056ecb7b81--
