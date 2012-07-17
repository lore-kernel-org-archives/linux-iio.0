Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <11465aef98dbd52476a33c69e1cfb5ef@mail.gmail.com>
 <5001343D.5080302@kernel.org> <5001494F.2020207@kernel.org>
In-Reply-To: <5001494F.2020207@kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Jul 2012 17:56:53 -0700
Message-ID: <fc06c8a11ad2e9e9ce765635690d17f8@mail.gmail.com>
Subject: RE: Invensense MPU6050/9150/6500 driver submission(resubmitted)
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=f46d04428104c5cdf204c4fc0593
List-ID: <linux-iio@vger.kernel.org>

--f46d04428104c5cdf204c4fc0593
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

   RE: Invensense MPU6050/9150/6500 driver submission(resubmitted)

Dear Jonathan,

        Thanks for your comments. I have fixed the code according to them. =
T
he code is reduced more than 40%.  However, there are some comments that I
don't understand. It is listed as below in red.

Ge

-----Original Message-----
From: Jonathan Cameron [mailto:jic23@kernel.org <jic23@kernel.org>]
Sent: Saturday, July 14, 2012 3:26 AM
To: Ge Gao
Cc: linux-iio@vger.kernel.org
Subject: Re: Invensense MPU6050/9150/6500 driver submission(resubmitted)

> +     &iio_dev_attr_gyro_enable.dev_attr.attr,

> +     &dev_attr_temperature.attr,

> +     &iio_dev_attr_clock_source.dev_attr.attr,

> +     &iio_dev_attr_power_state.dev_attr.attr,

> +     &dev_attr_reg_dump.attr,

> +     &iio_dev_attr_self_test.dev_attr.attr,

> +     &iio_dev_attr_key.dev_attr.attr,

> +     &iio_dev_attr_gyro_matrix.dev_attr.attr,

> +     &iio_dev_attr_sampling_frequency.dev_attr.attr,

> +     &iio_const_attr_sampling_frequency_available.dev_attr.attr,

> +};

> +

> +static const struct attribute *inv_mpu6050_attributes[] =3D {

> +     &iio_dev_attr_accl_enable.dev_attr.attr,

> +     &iio_dev_attr_accl_matrix.dev_attr.attr,

> +     &iio_dev_attr_lpa_mode.dev_attr.attr,

> +     &iio_dev_attr_lpa_freq.dev_attr.attr,

> +};

> +

> +static const struct attribute *inv_compass_attributes[] =3D {

> +     &iio_dev_attr_compass_matrix.dev_attr.attr,

> +     &iio_dev_attr_compass_enable.dev_attr.attr,

> +};

> +

> +static struct attribute *inv_attributes[ARRAY_SIZE(inv_gyro_attributes) =
+

> +                             ARRAY_SIZE(inv_mpu6050_attributes) +

> +                             ARRAY_SIZE(inv_compass_attributes) + 1];

Don't do this. You have just limited yourself to only have one device

attached

to a given machine.  Please just have the relevant combinations statically

defined.

Ge: why is that? Inv_attributes is also a static variable. Its value can
change according to different chip type. In the end, it is the same as some
hard-coded attributes. For multiple devices in one machine, isn=92t that ea=
ch
device has one separate directory =93iio_deviceX=94 with private attributes=
 in
each directory?

> +

> +static const struct attribute_group inv_attribute_group =3D {

Why are these in there own group? Should be in the base group.

Ge: What is =93base=94 group? Isn=92t this the standard way of doing it?.

> +     .name =3D "mpu",

> +     .attrs =3D inv_attributes

> +};

> +

> +static const struct iio_info mpu_info =3D {

> +     .driver_module =3D THIS_MODULE,

> +     .read_raw =3D &mpu_read_raw,

> +     .write_raw =3D &mpu_write_raw,

> +     .attrs =3D &inv_attribute_group,

> +};

> +

> +/**

> + *  inv_setup_compass() - Configure compass.

> + */

This next bit is a very bad idea for the reasons stated above.

You've ended up with more complex code and reduced flexibility.

There will be people who will attach several of your devices

to one machine, so please cater for them (it's the sort of thing

I'd do for starters ;)

Ge: Like I said, what the difference between the hardcoded attribute and th=
e
flexibly changeable ones. What would the IIO core do when multiple devices
are connected to one machine in my case?

Thanks.

> +     t_ind =3D 0;

> +     memcpy(&inv_attributes[t_ind], inv_gyro_attributes,

> +             sizeof(inv_gyro_attributes));

> +     t_ind +=3D ARRAY_SIZE(inv_gyro_attributes);

> +

> +     memcpy(&inv_attributes[t_ind], inv_mpu6050_attributes,

> +                    sizeof(inv_mpu6050_attributes));

> +     t_ind +=3D ARRAY_SIZE(inv_mpu6050_attributes);

> +

> +     if (st->chip_config.has_compass) {

> +             memcpy(&inv_attributes[t_ind], inv_compass_attributes,

> +                    sizeof(inv_compass_attributes));

> +             t_ind +=3D ARRAY_SIZE(inv_compass_attributes);

> +     }

> +     inv_attributes[t_ind] =3D NULL;

> +

> +     st->secondary_client =3D *client;

really? That's 'interesting'... the secondary client is the same as

the primary one (up to a dereference).

> +MODULE_DEVICE_TABLE(i2c, inv_mpu_id);

> +

> +static struct i2c_driver inv_mpu_driver =3D {

> +     .class =3D I2C_CLASS_HWMON,

really? hwmon driver?

Ge: Is there any other possibility? I can=92t see other I2C classes.

> +     .probe          =3D       inv_mpu_probe,

--f46d04428104c5cdf204c4fc0593
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"MS Exchange Server version 14.02.5004.0=
00">
<title>RE: Invensense MPU6050/9150/6500 driver submission(resubmitted)</tit=
le>
</head>
<body>


<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">Dear Jonathan,</=
font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us">=A0=A0=A0=A0=A0=A0=A0</span><span lang=
=3D"en-us"> <font face=3D"Calibri">Thanks for your comments.</font> <font f=
ace=3D"Calibri">I have fixed the code according to</font> <font face=3D"Cal=
ibri">them. T</font><font face=3D"Calibri">h</font><font face=3D"Calibri">e=
</font> <font face=3D"Calibri">code is reduced</font> <font face=3D"Calibri=
">more</font><font face=3D"Calibri"></font> <font face=3D"Calibri">than 40%=
.=A0 However, there are some</font></span><span lang=3D"en-us"> <font face=
=3D"Calibri">comments</font></span><span lang=3D"en-us"> <font face=3D"Cali=
bri">that I don&#39;t understand. It is listed as below</font></span><span =
lang=3D"en-us"><font face=3D"Calibri"> in</font></span><span lang=3D"en-us"=
> <font color=3D"#FF0000" face=3D"Calibri">red</font></span><span lang=3D"e=
n-us">.</span></p>


<p dir=3D"LTR"><span lang=3D"en-us"></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">Ge</font></span>=
<span lang=3D"en-us"></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">-----Original Me=
ssage-----<br>
</font><font face=3D"Calibri">From:</font><font face=3D"Calibri"></font> <f=
ont face=3D"Calibri">Jonathan Cameron [<a href=3D"mailto:jic23@kernel.org">=
mailto:jic23@kernel.org</a>]<br>
</font><font face=3D"Calibri">Sent:</font><font face=3D"Calibri"> Saturday,=
 July 14, 2012 3:26 AM<br>
</font><font face=3D"Calibri">To:</font><font face=3D"Calibri"> Ge Gao<br>
</font><font face=3D"Calibri">Cc:</font><font face=3D"Calibri"> <a href=3D"=
mailto:linux-iio@vger.kernel.org">linux-iio@vger.kernel.org</a><br>
</font><font face=3D"Calibri">Subject:</font><font face=3D"Calibri"> Re: In=
vensense MPU6050/9150/6500 driver submission(resubmitted)</font></span><spa=
n lang=3D"en-us"></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_gyro_enable.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;dev_attr_temperature.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_clock_source.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_power_state.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;dev_attr_reg_dump.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_self_test.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_key.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_gyro_matrix.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_sampling_frequency.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_const_attr_sampling_frequency_available.d</font><font face=3D"=
Calibri">ev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +};</font><=
/span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +static con=
st struct attribute *inv_mpu6050_attributes[] =3D {</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_accl_enable.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_accl_matrix.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_lpa_mode.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_lpa_freq.dev_attr.a</font><font face=3D"Calibri">ttr,=
</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +};</font><=
/span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +static con=
st struct attribute *inv_compass_attributes[] =3D {</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_compass_matrix.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 &amp;iio_dev_attr_compass_enable.dev_attr.attr,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +};</font><=
/span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +static str=
uct attribute *inv_attributes[ARRAY_SIZE(inv_gyro_attribute</font><font fac=
e=3D"Calibri">s) +</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ARRAY=
_SIZE(inv_mpu6050_attributes) +</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ARRAY=
_SIZE(inv_compass_attributes) + 1];</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">Don&#39;t do thi=
s. You have just limited yourself to only have one device</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">attached</font><=
/span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">to a given machi=
ne.=A0 Please just have the relevant combinations statically</font></span><=
/p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">defin</font><fon=
t face=3D"Calibri">ed.</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Calibri=
">Ge:</font></span><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Cal=
ibri"></font></span><span lang=3D"en-us"> <font color=3D"#FF0000" face=3D"C=
alibri">why is that?</font> <font color=3D"#FF0000" face=3D"Calibri">I</fon=
t><font color=3D"#FF0000" face=3D"Calibri">nv_</font></span><span lang=3D"e=
n-us"><font color=3D"#FF0000" face=3D"Calibri">attributes</font><font color=
=3D"#FF0000" face=3D"Calibri"></font></span><span lang=3D"en-us"> <font col=
or=3D"#FF0000" face=3D"Calibri">is</font></span><span lang=3D"en-us"><font =
color=3D"#FF0000" face=3D"Calibri"> also</font></span><span lang=3D"en-us">=
 <font color=3D"#FF0000" face=3D"Calibri">a</font></span><span lang=3D"en-u=
s"> <font color=3D"#FF0000" face=3D"Calibri">static variable.</font></span>=
<span lang=3D"en-us"> <font color=3D"#FF0000" face=3D"Calibri">Its value ca=
n change</font> <font color=3D"#FF0000" face=3D"Calibri">according to diffe=
rent chip type.</font></span><span lang=3D"en-us"> <font color=3D"#FF0000" =
face=3D"Calibri">In the end, it is the same as some hard-coded attributes. =
For multiple devices in one machine, isn</font><font color=3D"#FF0000" face=
=3D"Calibri">=92</font><font color=3D"#FF0000" face=3D"Calibri">t that each=
 device has one separate directory</font></span><span lang=3D"en-us"> <font=
 color=3D"#FF0000" face=3D"Calibri">=93</font><font color=3D"#FF0000" face=
=3D"Calibri">iio_deviceX</font><font color=3D"#FF0000" face=3D"Calibri">=94=
</font><font color=3D"#FF0000" face=3D"Calibri"> with private attributes in=
 each</font> <font color=3D"#FF0000" face=3D"Calibri">directory</font><font=
 color=3D"#FF0000" face=3D"Calibri">?</font></span><span lang=3D"en-us"></s=
pan></p>


<p dir=3D"LTR"><span lang=3D"en-us"></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +static con=
st struct attribute_group inv_attribute_group =3D {</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">Why are these in=
 there own group? Should be in the base group.</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Calibri=
">Ge:</font></span><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Cal=
ibri"></font></span><span lang=3D"en-us"> <font color=3D"#FF0000" face=3D"C=
alibri">What is</font><font color=3D"#FF0000" face=3D"Calibri"></font></spa=
n><span lang=3D"en-us"> <font color=3D"#FF0000" face=3D"Calibri">=93</font>=
<font color=3D"#FF0000" face=3D"Calibri">base</font><font color=3D"#FF0000"=
 face=3D"Calibri">=94</font><font color=3D"#FF0000" face=3D"Calibri"> group=
? Isn</font><font color=3D"#FF0000" face=3D"Calibri">=92</font><font color=
=3D"#FF0000" face=3D"Calibri">t this the standard way of doing it?.</font><=
/span><span lang=3D"en-us"></span></p>


<p dir=3D"LTR"><span lang=3D"en-us"></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 .name =3D &quot;mpu&quot;,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 .attrs =3D inv_attributes</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +};</font><=
/span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +static con=
st struct iio_info mpu_info =3D {</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 .driver_module =3D THIS_MODULE,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 .read_raw =3D &amp;mpu_read_raw,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 .write_raw =3D &amp;mpu_write_raw,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 .attrs =3D &amp;inv_attribute_group,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +};</font><=
/span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +/**</font>=
</span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; + *=A0 inv_=
setup_compass() - Configure compass.</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; + */</font>=
</span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">This next bit is=
 a very bad idea for the reasons stated above.</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">You&#39;ve ended=
 up with more complex code and reduced flexibility.</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">There will be pe=
ople who will attach several of your devices</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">to one machine, =
so please cater for them (it&#39;s the sort of thing</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">I&#39;d</font><f=
ont face=3D"Calibri"> do for starters ;)</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Calibri=
">Ge:</font></span><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Cal=
ibri"></font></span><span lang=3D"en-us"> <font color=3D"#FF0000" face=3D"C=
alibri">Like I said,</font> <font color=3D"#FF0000" face=3D"Calibri">what t=
he difference between</font> <font color=3D"#FF0000" face=3D"Calibri">the</=
font><font color=3D"#FF0000" face=3D"Calibri"></font> <font color=3D"#FF000=
0" face=3D"Calibri">hardcoded attribute and the</font></span><span lang=3D"=
en-us"> <font color=3D"#FF0000" face=3D"Calibri">flexibly</font></span><spa=
n lang=3D"en-us"><font color=3D"#FF0000" face=3D"Calibri"></font></span><sp=
an lang=3D"en-us"> <font color=3D"#FF0000" face=3D"Calibri">changeable ones=
. What would the IIO core do when multiple devices are connected to one mac=
hine in my ca</font><font color=3D"#FF0000" face=3D"Calibri">se?</font></sp=
an></p>


<p dir=3D"LTR"><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Calibri=
">Thanks.</font></span><span lang=3D"en-us"></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 t_ind =3D 0;</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 memcpy(&amp;inv_attributes[t_ind], inv_gyro_attributes,</font></span></=
p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 sizeof(inv_gyro_attributes));</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 t_ind +=3D ARRAY_SIZE(inv_gyro_attributes);</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 memcpy(&amp;inv_attributes[t_ind], inv_mpu6050_attributes,</font></span=
></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 sizeof(in</font><font face=3D"=
Calibri">v_mpu6050_attributes));</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 t_ind +=3D ARRAY_SIZE(inv_mpu6050_attributes);</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 if (st-&gt;chip_config.has_compass) {</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 memcpy(&amp;inv_attributes[t_ind], inv_compass_at=
tributes,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 sizeof(inv_compass_attributes)=
);</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 t_ind +=3D ARRAY_SIZE(inv_compas</font><font face=
=3D"Calibri">s_attributes);</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 }</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 inv_attributes[t_ind] =3D NULL;</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 st-&gt;secondary_client =3D *client;</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">r</font><font fa=
ce=3D"Calibri">eally? That&#39;s &#39;interesting&#39;... the secondary cli=
ent is the same as</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">the primary one =
(up to a dereference).</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +MODULE_DEV=
ICE_TABLE(i2c, inv_mpu_id);</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +</font></s=
pan></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +static str=
uct i2c_driver inv_mpu_driver =3D {</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 .class =3D I2C_CLASS_HWMON,</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">really? hwmon dr=
iver?</font></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Calibri=
">Ge:</font></span><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"Cal=
ibri"> I</font></span><span lang=3D"en-us"><font color=3D"#FF0000" face=3D"=
Calibri">s there any other possibility? I can</font><font color=3D"#FF0000"=
 face=3D"Calibri">=92</font><font color=3D"#FF0000" face=3D"Calibri">t see =
other I2C classes.</font></span><span lang=3D"en-us"></span></p>


<p dir=3D"LTR"><span lang=3D"en-us"></span></p>

<p dir=3D"LTR"><span lang=3D"en-us"><font face=3D"Calibri">&gt; +=A0=A0=A0=
=A0 .probe=A0 =A0=A0=A0=A0=A0=A0=A0 =3D=A0=A0=A0=A0=A0=A0 inv_mpu_probe,</f=
ont></span></p>
<br>

</body>
</html>

--f46d04428104c5cdf204c4fc0593--
