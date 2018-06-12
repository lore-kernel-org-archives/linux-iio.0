Return-Path: <SRS0=aj+/=I6=gmail.com=karim.eshapa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <48143872d69d231273bd2c8ed835cbf0046a263d.camel@perches.com>
References: <20180611233814.18597-1-karim.eshapa@gmail.com> <48143872d69d231273bd2c8ed835cbf0046a263d.camel@perches.com>
From: karim eshapa <karim.eshapa@gmail.com>
Date: Tue, 12 Jun 2018 02:14:06 +0200
Message-ID: <CABf4As9qx8QyRQoPiBoXnT1tXMgU6Cf==raPksQYm3xU1J1RNw@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:accel:adis16240: sign extend function
 avoiding code duplication
To: Joe Perches <joe@perches.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000a394c7056e66be9a"
List-ID: <linux-iio@vger.kernel.org>

--000000000000a394c7056e66be9a
Content-Type: text/plain; charset="UTF-8"

>On Tue, 2018-06-12 at 01:38 +0200, Karim Eshapa wrote:
>> Use sign_extend32 kernel function instead of code duplication.
>> Safe also for 16 bit.
>
>Perhaps remove the bits declaration and assignments
>and just use 9 directly.

I think it's more readable in that way(bits - 1) instead of dealing with
magic numbers.
for more readability we can replace the declaration and assignment with
macro's
represent the cases.

Thanks,
Karim

>> @@ -292,9 +292,7 @@ static int adis16240_read_raw(struct iio_dev
*indio_dev,
>>               ret = adis_read_reg_16(st, addr, &val16);
>>               if (ret)
>>                       return ret;
>> -             val16 &= (1 << bits) - 1;
>> -             val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>> -             *val = val16;
>> +             *val = sign_extend32(val16, bits - 1);
>>               return IIO_VAL_INT;
>>       case IIO_CHAN_INFO_PEAK:
>>               bits = 10;
>> @@ -302,9 +300,7 @@ static int adis16240_read_raw(struct iio_dev
*indio_dev,
>>               ret = adis_read_reg_16(st, addr, &val16);
>>               if (ret)
>>                       return ret;
>> -             val16 &= (1 << bits) - 1;
>> -             val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>> -             *val = val16;
>> +             *val = sign_extend32(val16, bits - 1);
>>               return IIO_VAL_INT;
>>       }
>>       return -EINVAL;

On 12 June 2018 at 01:57, Joe Perches <joe@perches.com> wrote:

> On Tue, 2018-06-12 at 01:38 +0200, Karim Eshapa wrote:
> > Use sign_extend32 kernel function instead of code duplication.
> > Safe also for 16 bit.
>
> Perhaps remove the bits declaration and assignments
> and just use 9 directly.
>
> > diff --git a/drivers/staging/iio/accel/adis16240.c
> b/drivers/staging/iio/accel/adis16240.c
> []
> > @@ -292,9 +292,7 @@ static int adis16240_read_raw(struct iio_dev
> *indio_dev,
> >               ret = adis_read_reg_16(st, addr, &val16);
> >               if (ret)
> >                       return ret;
> > -             val16 &= (1 << bits) - 1;
> > -             val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> > -             *val = val16;
> > +             *val = sign_extend32(val16, bits - 1);
> >               return IIO_VAL_INT;
> >       case IIO_CHAN_INFO_PEAK:
> >               bits = 10;
> > @@ -302,9 +300,7 @@ static int adis16240_read_raw(struct iio_dev
> *indio_dev,
> >               ret = adis_read_reg_16(st, addr, &val16);
> >               if (ret)
> >                       return ret;
> > -             val16 &= (1 << bits) - 1;
> > -             val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> > -             *val = val16;
> > +             *val = sign_extend32(val16, bits - 1);
> >               return IIO_VAL_INT;
> >       }
> >       return -EINVAL;
>

--000000000000a394c7056e66be9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-im" style=3D"color:rgb(80,0,80);font-=
size:12.8px;text-decoration-style:initial;text-decoration-color:initial">&g=
t;On Tue, 2018-06-12 at 01:38 +0200, Karim Eshapa wrote:<br>&gt;&gt;</span>=
<span style=3D"color:rgb(80,0,80);font-size:12.8px">=C2=A0Use sign_extend32=
 kernel function instead of code duplication.</span><div><span class=3D"gma=
il-im" style=3D"color:rgb(80,0,80);font-size:12.8px;text-decoration-style:i=
nitial;text-decoration-color:initial">&gt;&gt; Safe also for 16 bit.<br>&gt=
;<br></span><span style=3D"font-size:12.8px;text-decoration-style:initial;t=
ext-decoration-color:initial;float:none;display:inline">&gt;Perhaps remove =
the bits declaration and assignments</span><br style=3D"font-size:12.8px;te=
xt-decoration-style:initial;text-decoration-color:initial"><span style=3D"f=
ont-size:12.8px;text-decoration-style:initial;text-decoration-color:initial=
;float:none;display:inline">&gt;and just use 9 directly.</span><br></div><d=
iv><span style=3D"font-size:12.8px;text-decoration-style:initial;text-decor=
ation-color:initial;float:none;display:inline"><br></span></div><div><span =
style=3D"font-size:12.8px;text-decoration-style:initial;text-decoration-col=
or:initial;float:none;display:inline">I think it&#39;s more readable in tha=
t way(bits - 1) instead of dealing with magic numbers.<br>for more readabil=
ity we can replace the declaration and assignment with macro&#39;s<br>repre=
sent the cases.<br><br>Thanks,<br>Karim<br><br><span style=3D"color:rgb(80,=
0,80);background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial;float:none;display:inline">&gt;&gt; @@ -292,9 +292=
,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,</span><br st=
yle=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial"><span style=3D"color:rgb(80,0=
,80);background-color:rgb(255,255,255);text-decoration-style:initial;text-d=
ecoration-color:initial;float:none;display:inline">&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D adis_read_reg_16(st, addr,=
 &amp;val16);</span><br style=3D"color:rgb(80,0,80);background-color:rgb(25=
5,255,255);text-decoration-style:initial;text-decoration-color:initial"><sp=
an style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;float:none;display:inline=
">&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)</=
span><br style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial"><span style=3D"col=
or:rgb(80,0,80);background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial;float:none;display:inline">&gt;&gt;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return ret;</span><br style=3D"color:rgb(80,0,80);background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial"=
><span style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial;float:none;display:in=
line">&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 &amp;=
=3D (1 &lt;&lt; bits) - 1;</span><br style=3D"color:rgb(80,0,80);background=
-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color=
:initial"><span style=3D"color:rgb(80,0,80);background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial;float:none;d=
isplay:inline">&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0va=
l16 =3D (s16)(val16 &lt;&lt; (16 - bits)) &gt;&gt; (16 - bits);</span><br s=
tyle=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial"><span style=3D"color:rgb(80,=
0,80);background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial;float:none;display:inline">&gt;&gt; -=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D val16;</span><br style=3D"color=
:rgb(80,0,80);background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial"><span style=3D"color:rgb(80,0,80);backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial;float:none;display:inline">&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*val =3D sign_extend32(val16, bits - 1);</span><br =
style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial"><span style=3D"color:rgb(80=
,0,80);background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial;float:none;display:inline">&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_INT;</span><br styl=
e=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial"><span style=3D"color:rgb(80,0,8=
0);background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial;float:none;display:inline">&gt;&gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0case IIO_CHAN_INFO_PEAK:</span><br style=3D"color:rgb(80,0,80);ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial"><span style=3D"color:rgb(80,0,80);background-color:rgb(25=
5,255,255);text-decoration-style:initial;text-decoration-color:initial;floa=
t:none;display:inline">&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bits =3D 10;</span><br style=3D"color:rgb(80,0,80);background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial"><span style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255=
);text-decoration-style:initial;text-decoration-color:initial;float:none;di=
splay:inline">&gt;&gt; @@ -302,9 +300,7 @@ static int adis16240_read_raw(st=
ruct iio_dev *indio_dev,</span><br style=3D"color:rgb(80,0,80);background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial"><span style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255)=
;text-decoration-style:initial;text-decoration-color:initial;float:none;dis=
play:inline">&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D adis_read_reg_16(st, addr, &amp;val16);</span><br style=3D"color=
:rgb(80,0,80);background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial"><span style=3D"color:rgb(80,0,80);backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial;float:none;display:inline">&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)</span><br style=3D"color:rgb(80,0,80);b=
ackground-color:rgb(255,255,255);text-decoration-style:initial;text-decorat=
ion-color:initial"><span style=3D"color:rgb(80,0,80);background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial;flo=
at:none;display:inline">&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;</span><br style=3D"col=
or:rgb(80,0,80);background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial"><span style=3D"color:rgb(80,0,80);backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial;float:none;display:inline">&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0val16 &amp;=3D (1 &lt;&lt; bits) - 1;</span><br sty=
le=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial"><span style=3D"color:rgb(80,0,=
80);background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial;float:none;display:inline">&gt;&gt; -=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 =3D (s16)(val16 &lt;&lt; (16 - bits=
)) &gt;&gt; (16 - bits);</span><br style=3D"color:rgb(80,0,80);background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial"><span style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255)=
;text-decoration-style:initial;text-decoration-color:initial;float:none;dis=
play:inline">&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val=
 =3D val16;</span><br style=3D"color:rgb(80,0,80);background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial"><span=
 style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D sign_ext=
end32(val16, bits - 1);</span><br style=3D"color:rgb(80,0,80);background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial"><span style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial;float:none;disp=
lay:inline">&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return IIO_VAL_INT;</span><br style=3D"color:rgb(80,0,80);background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l"><span style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial;float:none;display:=
inline">&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}</span><br style=3D"color:rgb(8=
0,0,80);background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial"><span style=3D"color:rgb(80,0,80);background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial;float:none;display:inline">&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return =
-EINVAL;</span><br></span></div></div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On 12 June 2018 at 01:57, Joe Perches <span dir=3D"ltr=
">&lt;<a href=3D"mailto:joe@perches.com" target=3D"_blank">joe@perches.com<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On=
 Tue, 2018-06-12 at 01:38 +0200, Karim Eshapa wrote:<br>
&gt; Use sign_extend32 kernel function instead of code duplication.<br>
&gt; Safe also for 16 bit.<br>
<br>
</span>Perhaps remove the bits declaration and assignments<br>
and just use 9 directly.<br>
<br>
&gt; diff --git a/drivers/staging/iio/accel/<wbr>adis16240.c b/drivers/stag=
ing/iio/accel/<wbr>adis16240.c<br>
<div class=3D"HOEnZb"><div class=3D"h5">[]<br>
&gt; @@ -292,9 +292,7 @@ static int adis16240_read_raw(struct iio_dev *indi=
o_dev,<br>
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
2(val16, bits - 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_I=
NT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_PEAK:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bits =3D 10;<br>
&gt; @@ -302,9 +300,7 @@ static int adis16240_read_raw(struct iio_dev *indi=
o_dev,<br>
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
2(val16, bits - 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_I=
NT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
</div></div></blockquote></div><br></div>

--000000000000a394c7056e66be9a--
