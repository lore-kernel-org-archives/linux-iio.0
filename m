Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
Date: Mon, 29 Jun 2015 14:03:09 +0200
Message-ID: <CAKv63uv5RZxmtVpMMAZ=xtTwMQZ8D=LxPHQ+ZHezj=814_m6eg@mail.gmail.com>
Subject: [PATCH] iio: mlx90614: Replace offset sign and define magic numbers
From: Crt Mori <cmo@melexis.com>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Vianney_le_Cl=C3=A9ment_de_Saint=2DMarcq?= <vianney.leclement@essensium.com>,
	Johnathan Iain Cameron <jic23@kernel.org>
Content-Type: multipart/alternative; boundary=001a113904aa901a8f0519a6dfbe
List-ID: <linux-iio@vger.kernel.org>

--001a113904aa901a8f0519a6dfbe
Content-Type: text/plain; charset=UTF-8

Translates the magic constant numbers to named macros and add some
additional comments about their meaning. Also changed the offset to
negative as usual equation is: (raw + offset)*scale and in this
case offset should be negative (as we deduct 273.15 Kelvin to get
temperature in Celsius).

The diff is made towards togreg branch as that branch seems to have the
most recent updates of mlx90614 driver (many are yet to be merged).

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c
b/drivers/iio/temperature/mlx90614.c
index cb2e8ad..909278a 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -65,6 +65,13 @@

 #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */

+/* Magic constants */
+#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the Kelvin
offset */
+#define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset
(273.15*50) */
+#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
+#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for
emissivity */
+#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~
0.000015259 */
+
 struct mlx90614_data {
        struct i2c_client *client;
        struct mutex lock; /* for EEPROM access only */
@@ -204,11 +211,11 @@ static int mlx90614_read_raw(struct iio_dev
*indio_dev,
                *val = ret;
                return IIO_VAL_INT;
        case IIO_CHAN_INFO_OFFSET:
-               *val = 13657;
-               *val2 = 500000;
+               *val = MLX90614_CONST_OFFSET_DEC;
+               *val2 = MLX90614_CONST_OFFSET_REM;
                return IIO_VAL_INT_PLUS_MICRO;
        case IIO_CHAN_INFO_SCALE:
-               *val = 20;
+               *val = MLX90614_CONST_SCALE;
                return IIO_VAL_INT;
        case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
                mlx90614_power_get(data, false);
@@ -221,12 +228,12 @@ static int mlx90614_read_raw(struct iio_dev
*indio_dev,
                if (ret < 0)
                        return ret;

-               if (ret == 65535) {
+               if (ret == MLX90614_CONST_RAW_EMISSIVITY_MAX) {
                        *val = 1;
                        *val2 = 0;
                } else {
                        *val = 0;
-                       *val2 = ret * 15259; /* 1/65535 ~ 0.000015259 */
+                       *val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
                }
                return IIO_VAL_INT_PLUS_NANO;
        default:
@@ -245,7 +252,8 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
        case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
                if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2 !=
0))
                        return -EINVAL;
-               val = val * 65535 + val2 / 15259; /* 1/65535 ~ 0.000015259
*/
+               val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
+                       val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;

                mlx90614_power_get(data, false);
                mutex_lock(&data->lock);

--001a113904aa901a8f0519a6dfbe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Translates the magic constant numbers to na=
med macros and add some</div><div>additional comments about their meaning. =
Also changed the offset to</div><div>negative as usual equation is: (raw + =
offset)*scale and in this</div><div>case offset should be negative (as we d=
educt 273.15 Kelvin to get</div><div>temperature in Celsius).</div></div><d=
iv><br></div><div>The diff is made towards togreg branch as that branch see=
ms to have the</div><div>most recent updates of mlx90614 driver (many are y=
et to be merged).</div><div><br></div></div><div>Signed-off-by: Crt Mori &l=
t;<a href=3D"mailto:cmo@melexis.com">cmo@melexis.com</a>&gt;</div><div>---<=
/div><div><div>=C2=A0drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++=
------</div><div>=C2=A01 file changed, 14 insertions(+), 6 deletions(-)</di=
v></div><div><br></div><div>diff --git a/drivers/iio/temperature/mlx90614.c=
 b/drivers/iio/temperature/mlx90614.c<br></div><div>index cb2e8ad..909278a =
100644<br></div><div>--- a/drivers/iio/temperature/mlx90614.c</div><div>+++=
 b/drivers/iio/temperature/mlx90614.c</div><div>@@ -65,6 +65,13 @@</div><di=
v>=C2=A0</div><div>=C2=A0#define MLX90614_AUTOSLEEP_DELAY 5000 /* default a=
utosleep delay */<br></div><div>=C2=A0</div><div>+/* Magic constants */</di=
v><div>+#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the Kel=
vin offset */</div><div>+#define MLX90614_CONST_OFFSET_REM 500000 /* remain=
der of offset (273.15*50) */</div><div>+#define MLX90614_CONST_SCALE 20 /* =
Scale in milliKelvin (0.02 * 1000) */</div><div>+#define MLX90614_CONST_RAW=
_EMISSIVITY_MAX 65535 /* max value for emissivity */</div><div>+#define MLX=
90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000015259 */</div><d=
iv>+</div><div>=C2=A0struct mlx90614_data {</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct i2c_client *client;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 str=
uct mutex lock; /* for EEPROM access only */</div><div>@@ -204,11 +211,11 @=
@ static int mlx90614_read_raw(struct iio_dev *indio_dev,</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D ret;</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IIO_VAL_INT;=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_OFFSET:</div><div=
>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D 13657;</div><d=
iv>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val2 =3D 500000;</di=
v><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D MLX90614=
_CONST_OFFSET_DEC;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *val2 =3D MLX90614_CONST_OFFSET_REM;</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IIO_VAL_INT_PLUS_MICRO;</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_SCALE:</div><div>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D 20;</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D MLX90614_CONST_SCALE;</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IIO_=
VAL_INT;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_CALIBEMIS=
SIVITY: /* 1/65535 / LSB */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 mlx90614_power_get(data, false);</div><div>@@ -221,12 =
+228,12 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)</=
div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return ret;</div><div>=C2=A0</div><div>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 65535) {</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D MLX90614_CONST=
_RAW_EMISSIVITY_MAX) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D 1;</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=
val2 =3D 0;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } else {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D 0;</div><div>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val2 =3D ret *=
 15259; /* 1/65535 ~ 0.000015259 */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val2 =3D ret * MLX90614_=
CONST_EMISSIVITY_RESOLUTION;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 }</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return IIO_VAL_INT_PLUS_NANO;</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 default:</div><div>@@ -245,7 +252,8 @@ static int mlx90614_write_raw=
(struct iio_dev *indio_dev,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_=
CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &lt; 0 || val2 &lt; 0 || val=
 &gt; 1 || (val =3D=3D 1 &amp;&amp; val2 !=3D 0))</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retur=
n -EINVAL;</div><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val=
 =3D val * 65535 + val2 / 15259; /* 1/65535 ~ 0.000015259 */</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D val * MLX90614_CON=
ST_RAW_EMISSIVITY_MAX +</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val2 / MLX90614_CONST_EMISSIVITY_RES=
OLUTION;</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mlx90614_power_get(data, false);</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;data-&gt;lock);</=
div><div><br></div>
</div>

--001a113904aa901a8f0519a6dfbe--
