Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1506291413340.16737@pmeerw.net>
References: <CAKv63uv5RZxmtVpMMAZ=xtTwMQZ8D=LxPHQ+ZHezj=814_m6eg@mail.gmail.com>
	<alpine.DEB.2.02.1506291413340.16737@pmeerw.net>
Date: Mon, 29 Jun 2015 16:39:37 +0200
Message-ID: <CAKv63uvqTuVwTn8pq7MVF=TPyCcCNQGvOdAh7DPNy_=W6=FBpw@mail.gmail.com>
Subject: Re: [PATCH] iio: mlx90614: Replace offset sign and define magic numbers
From: Crt Mori <cmo@melexis.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	=?UTF-8?Q?Vianney_le_Cl=C3=A9ment_de_Saint=2DMarcq?= <vianney.leclement@essensium.com>,
	Johnathan Iain Cameron <jic23@kernel.org>
Content-Type: multipart/alternative; boundary=001a113904aa1df9ba0519a90f8f
List-ID: <linux-iio@vger.kernel.org>

--001a113904aa1df9ba0519a90f8f
Content-Type: text/plain; charset=UTF-8

>> Translates the magic constant numbers to named macros and add some
>> additional comments about their meaning. Also changed the offset to
>> negative as usual equation is: (raw + offset)*scale and in this
>> case offset should be negative (as we deduct 273.15 Kelvin to get
>> temperature in Celsius)..

> On 29 June 2015 at 14:19, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>looks good; strictly, this patch is
>(a) a bugfix (the offset should be negative),
>(b) cleanup to replace constants by macros.

I agree, but other things are more design than a proper change.

I would also like you to reconsider the usage of
IIO_CHAN_INFO_PROCESSED which would report calculated value
to avoid knowing the sensor specifics and just provide general output
(this would avoid different calculations of final temperature for different
sensors).

>>
>> The diff is made towards togreg branch as that branch seems to have the
>> most recent updates of mlx90614 driver (many are yet to be merged).
>>
>> Signed-off-by: Crt Mori <cmo@melexis.com>
>> ---
>>  drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/temperature/mlx90614.c
>> b/drivers/iio/temperature/mlx90614.c
>> index cb2e8ad..909278a 100644
>> --- a/drivers/iio/temperature/mlx90614.c
>> +++ b/drivers/iio/temperature/mlx90614.c
>> @@ -65,6 +65,13 @@
>>
>>  #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
>>
>> +/* Magic constants */
>> +#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the Kelvin
>> offset */
>> +#define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset
>> (273.15*50) */
>> +#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
>> +#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for
>> emissivity */
>> +#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~
>> 0.000015259 */
>> +
>>  struct mlx90614_data {
>>         struct i2c_client *client;
>>         struct mutex lock; /* for EEPROM access only */
>> @@ -204,11 +211,11 @@ static int mlx90614_read_raw(struct iio_dev
>> *indio_dev,
>>                 *val = ret;
>>                 return IIO_VAL_INT;
>>         case IIO_CHAN_INFO_OFFSET:
>> -               *val = 13657;
>> -               *val2 = 500000;
>> +               *val = MLX90614_CONST_OFFSET_DEC;
>> +               *val2 = MLX90614_CONST_OFFSET_REM;
>>                 return IIO_VAL_INT_PLUS_MICRO;
>>         case IIO_CHAN_INFO_SCALE:
>> -               *val = 20;
>> +               *val = MLX90614_CONST_SCALE;
>>                 return IIO_VAL_INT;
>>         case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
>>                 mlx90614_power_get(data, false);
>> @@ -221,12 +228,12 @@ static int mlx90614_read_raw(struct iio_dev
>> *indio_dev,
>>                 if (ret < 0)
>>                         return ret;
>>
>> -               if (ret == 65535) {
>> +               if (ret == MLX90614_CONST_RAW_EMISSIVITY_MAX) {
>>                         *val = 1;
>>                         *val2 = 0;
>>                 } else {
>>                         *val = 0;
>> -                       *val2 = ret * 15259; /* 1/65535 ~ 0.000015259 */
>> +                       *val2 = ret *
MLX90614_CONST_EMISSIVITY_RESOLUTION;
>>                 }
>>                 return IIO_VAL_INT_PLUS_NANO;
>>         default:
>> @@ -245,7 +252,8 @@ static int mlx90614_write_raw(struct iio_dev
*indio_dev,
>>         case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
>>                 if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2
!=
>> 0))
>>                         return -EINVAL;
>> -               val = val * 65535 + val2 / 15259; /* 1/65535 ~
0.000015259
>> */
>> +               val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
>> +                       val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
>>
>>                 mlx90614_power_get(data, false);
>>                 mutex_lock(&data->lock);
>>

--001a113904aa1df9ba0519a90f8f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;&gt; Translates the magic constant numbers to named ma=
cros and add some<br>&gt;&gt; additional comments about their meaning. Also=
 changed the offset to<br>&gt;&gt; negative as usual equation is: (raw + of=
fset)*scale and in this<br>&gt;&gt; case offset should be negative (as we d=
educt 273.15 Kelvin to get<br>&gt;&gt; temperature in Celsius)..<div><br>&g=
t; On 29 June 2015 at 14:19, Peter Meerwald=C2=A0<span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:pmeerw@pmeerw.net" target=3D"_blank">pmeerw@pmeerw.net</a>&gt=
;</span>=C2=A0wrote:<br>&gt;looks good; strictly, this patch is<br>&gt;(a) =
a bugfix (the offset should be negative),<br>&gt;(b) cleanup to replace con=
stants by macros.<div><br></div><div>I agree, but other things are more des=
ign than a proper change.=C2=A0</div><div><br></div><div>I would also like =
you to reconsider the usage of=C2=A0</div><div>IIO_CHAN_INFO_PROCESSED whic=
h would report calculated value</div><div>to avoid knowing the sensor speci=
fics and just provide general output=C2=A0</div><div>(this would avoid diff=
erent calculations of final temperature for different=C2=A0</div><div>senso=
rs).</div><div>=C2=A0<br>&gt;&gt;<br>&gt;&gt; The diff is made towards togr=
eg branch as that branch seems to have the<br>&gt;&gt; most recent updates =
of mlx90614 driver (many are yet to be merged).<br>&gt;&gt;<br>&gt;&gt; Sig=
ned-off-by: Crt Mori &lt;<a href=3D"mailto:cmo@melexis.com">cmo@melexis.com=
</a>&gt;<br>&gt;&gt; ---<br>&gt;&gt; =C2=A0drivers/iio/temperature/mlx90614=
.c | 20 ++++++++++++++------<br>&gt;&gt; =C2=A01 file changed, 14 insertion=
s(+), 6 deletions(-)<br>&gt;&gt;<br>&gt;&gt; diff --git a/drivers/iio/tempe=
rature/mlx90614.c<br>&gt;&gt; b/drivers/iio/temperature/mlx90614.c<br>&gt;&=
gt; index cb2e8ad..909278a 100644<br>&gt;&gt; --- a/drivers/iio/temperature=
/mlx90614.c<br>&gt;&gt; +++ b/drivers/iio/temperature/mlx90614.c<br>&gt;&gt=
; @@ -65,6 +65,13 @@<br>&gt;&gt;<br>&gt;&gt; =C2=A0#define MLX90614_AUTOSLE=
EP_DELAY 5000 /* default autosleep delay */<br>&gt;&gt;<br>&gt;&gt; +/* Mag=
ic constants */<br>&gt;&gt; +#define MLX90614_CONST_OFFSET_DEC -13657 /* de=
cimal part of the Kelvin<br>&gt;&gt; offset */<br>&gt;&gt; +#define MLX9061=
4_CONST_OFFSET_REM 500000 /* remainder of offset<br>&gt;&gt; (273.15*50) */=
<br>&gt;&gt; +#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02=
 * 1000) */<br>&gt;&gt; +#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /*=
 max value for<br>&gt;&gt; emissivity */<br>&gt;&gt; +#define MLX90614_CONS=
T_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~<br>&gt;&gt; 0.000015259 */<br>&g=
t;&gt; +<br>&gt;&gt; =C2=A0struct mlx90614_data {<br>&gt;&gt; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct i2c_client *client;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct mutex lock; /* for EEPROM access only */<br>&gt;&gt; @@ -204,=
11 +211,11 @@ static int mlx90614_read_raw(struct iio_dev<br>&gt;&gt; *indi=
o_dev,<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
*val =3D ret;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return IIO_VAL_INT;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO=
_CHAN_INFO_OFFSET:<br>&gt;&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *val =3D 13657;<br>&gt;&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *val2 =3D 500000;<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 *val =3D MLX90614_CONST_OFFSET_DEC;<br>&gt;&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val2 =3D MLX90614_CONST_OFFSET_R=
EM;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn IIO_VAL_INT_PLUS_MICRO;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 case II=
O_CHAN_INFO_SCALE:<br>&gt;&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *val =3D 20;<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 *val =3D MLX90614_CONST_SCALE;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IIO_VAL_INT;<br>&gt;&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */<b=
r>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mlx90614=
_power_get(data, false);<br>&gt;&gt; @@ -221,12 +228,12 @@ static int mlx90=
614_read_raw(struct iio_dev<br>&gt;&gt; *indio_dev,<br>&gt;&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>&gt;&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return ret;<br>&gt;&gt;<br>&gt;&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 65535) {<br>&gt;&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D MLX90614_CONST_RAW_EM=
ISSIVITY_MAX) {<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D 1;<br>&gt;&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=
val2 =3D 0;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 } else {<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D 0;<br>&gt;&gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val2 =
=3D ret * 15259; /* 1/65535 ~ 0.000015259 */<br>&gt;&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val2 =3D re=
t * MLX90614_CONST_EMISSIVITY_RESOLUTION;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IIO_VAL_INT_PLUS_NANO;<br>&gt;&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>&gt;&gt; @@ -245,7 +252,8 @@ static=
 int mlx90614_write_raw(struct iio_dev *indio_dev,<br>&gt;&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */<b=
r>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val =
&lt; 0 || val2 &lt; 0 || val &gt; 1 || (val =3D=3D 1 &amp;&amp; val2 !=3D<b=
r>&gt;&gt; 0))<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>&gt;&gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D val * 65535 + val2 / 1525=
9; /* 1/65535 ~ 0.000015259<br>&gt;&gt; */<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D val * MLX90614_CONST_RAW_EMISSIVITY=
_MAX +<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;<br>&g=
t;&gt;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
mlx90614_power_get(data, false);<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;data-&gt;lock);<br>&gt;&gt;</di=
v></div></div>

--001a113904aa1df9ba0519a90f8f--
