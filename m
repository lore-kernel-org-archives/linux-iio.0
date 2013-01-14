Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <1354670655-21946-1-git-send-email-ggao@invensense.com>
 <50BF407C.7020709@metafoo.de> <126d7591e6a837d8ff163685716e7f4b@mail.gmail.com>
 <50C0FCF3.3020207@metafoo.de> <50C10BC2.4000704@kernel.org>
In-Reply-To: <50C10BC2.4000704@kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Jan 2013 10:40:52 -0800
Message-ID: <d57096712cb8f081022668d4751f12fd@mail.gmail.com>
Subject: RE: [PATCH] [PATCH V4] Invensense MPU6050 Device Driver.
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b6225e0360a4904d343fcb5
List-ID: <linux-iio@vger.kernel.org>

--047d7b6225e0360a4904d343fcb5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

   RE: [PATCH] [PATCH V4] Invensense MPU6050 Device Driver.

Dear Jonanthan,

        I submitted another version of driver for Invensense MPU6050 last
week. It basically fixed everything you said in the comments. It also
removed the inv_mpu_misc file, which is not useful while taking too much
spaces. However, only one thing I am not sure what to do with your comments=
. In
the trigger part, as the red part shown below, what that mean and what I am
supposed to do to make a =93callback=94. Thanks.

Best Regards,

Ge GAO

> +static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,

> +                                             bool state)

> +{

> +     struct iio_dev *indio_dev =3D trig->private_data;

> +

> +     return set_inv_enable(indio_dev, state);

Combine the above into one line.

> +}

> +

> +static const struct iio_trigger_ops inv_mpu_trigger_ops =3D {

> +     .owner =3D THIS_MODULE,

> +     .set_trigger_state =3D &inv_mpu_data_rdy_trigger_set_state,

You need some callbacks to prevent this being attached to another

trigger...

> +};

> +

> +int inv_mpu_probe_trigger(struct iio_dev *indio_dev)

> +{

> +     int ret;

> +     struct inv_mpu_iio_s *st =3D iio_priv(indio_dev);

> +

> +     st->trig =3D iio_trigger_alloc("%s-dev%d",

--047d7b6225e0360a4904d343fcb5
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"MS Exchange Server version 14.02.5004.0=
00">
<title>RE: [PATCH] [PATCH V4] Invensense MPU6050 Device Driver.</title>
</head>
<body>


<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">Dear Jonanthan,<=
/font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us">=A0=A0=A0=A0=A0=A0=A0 <font face=3D"Cal=
ibri">I submi</font><font face=3D"Calibri">t</font><font face=3D"Calibri">t=
</font><font face=3D"Calibri">ed another version of driver for Invensense M=
PU6050</font></span><span lang=3D"en-us"><font face=3D"Calibri"> last week.=
 It basically fixed everything you said in the com</font><font face=3D"Cali=
bri">m</font><font face=3D"Calibri">ents. It also removed the inv_mpu_misc =
file, which is not useful while taking too much spaces.</font><font face=3D=
"Calibri"> However, only one thing I am not sure</font><font face=3D"Calibr=
i"> what to do with your com</font></span><span lang=3D"en-us"><font face=
=3D"Calibri">m</font></span><span lang=3D"en-us"><font face=3D"Calibri">ent=
s.</font></span><span lang=3D"en-us"> <font face=3D"Calibri">In the trigger=
 part</font></span><span lang=3D"en-us"><font face=3D"Calibri">, as the red=
 part shown below, what that mean and what I am supposed to do to make a</f=
ont></span><span lang=3D"en-us"> <font face=3D"Calibri">=93</font><font fac=
e=3D"Calibri">callback</font><font face=3D"Calibri">=94</font><font face=3D=
"Calibri">. Thanks.</font></span></p>


<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">Best Regards,</f=
ont></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">Ge GAO</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +static int=
 inv_mpu_data_rdy_trigger_s</font><font face=3D"Calibri">et_state(struct ii=
o_trigger *trig,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 bool state)</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +{</font></=
span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 struct iio_dev *indio_dev =3D trig-&gt;private_data;</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 return set_inv_enable(indio_dev, state);</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">Combine the abov=
e into one line.</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +}</font></=
span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +static con=
st struct iio_trigger_ops inv_mpu_trigger_ops =3D {</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 .owner =3D THIS_MODULE,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 .set_trigger_state =3D &amp;inv_mpu_data_rdy_trigger_set_state,</font><=
/span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Calibri=
">You need some callbacks to prevent this being attached to another</font><=
/span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Calibri=
">trigger...</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +};</font><=
/span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +int inv_mp=
u_pro</font><font face=3D"Calibri">be_trigger(struct iio_dev *indio_dev)</f=
ont></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +{</font></=
span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 int ret;</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 struct inv_mpu_iio_s *st =3D iio_priv(indio_dev);</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 st-&gt;trig =3D iio_trigger_alloc(&quot;%s-dev%d&quot;,</font></span><s=
pan lang=3D"en-us"></span></p>

</body>
</html>

--047d7b6225e0360a4904d343fcb5--
