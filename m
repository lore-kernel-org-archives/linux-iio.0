Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
From: Crt Mori <cmo@melexis.com>
Date: Mon, 20 Jul 2015 21:06:56 +0200
Message-ID: <CAKv63uvS8-wf_7DWxw57pHEoF_Aq7uGrYWrOkRJfergwZP5_Uw@mail.gmail.com>
Subject: [PATCH] iio: mlx90614: Define magic numbers
To: Johnathan Iain Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Vianney_le_Cl=C3=A9ment_de_Saint=2DMarcq?= <vianney.leclement@essensium.com>
Content-Type: multipart/alternative; boundary=001a1139d1da1fada4051b5340bd
List-ID: <linux-iio@vger.kernel.org>

--001a1139d1da1fada4051b5340bd
Content-Type: text/plain; charset=UTF-8

Translates the magic constant numbers to named macros and add some
additional comments about their meaning.

The diff is made towards togreg branch as that branch seems to have the
most recent updates of mlx90614 driver (many are yet to be merged).

Signed-off-by: Crt Mori <cmo@melexis.com>
Acked-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c
b/drivers/iio/temperature/mlx90614.c
index cb2e8ad..4590f83 100644
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
- *val = 13657;
- *val2 = 500000;
+ *val = MLX90614_CONST_OFFSET_DEC;
+ *val2 = MLX90614_CONST_OFFSET_REM;
  return IIO_VAL_INT_PLUS_MICRO;
  case IIO_CHAN_INFO_SCALE:
- *val = 20;
+ *val = MLX90614_CONST_SCALE;
  return IIO_VAL_INT;
  case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
  mlx90614_power_get(data, false);
@@ -221,12 +228,12 @@ static int mlx90614_read_raw(struct iio_dev
*indio_dev,
  if (ret < 0)
  return ret;

- if (ret == 65535) {
+ if (ret == MLX90614_CONST_RAW_EMISSIVITY_MAX) {
  *val = 1;
  *val2 = 0;
  } else {
  *val = 0;
- *val2 = ret * 15259; /* 1/65535 ~ 0.000015259 */
+ *val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
  }
  return IIO_VAL_INT_PLUS_NANO;
  default:
@@ -245,7 +252,8 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
  case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
  if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2 != 0))
  return -EINVAL;
- val = val * 65535 + val2 / 15259; /* 1/65535 ~ 0.000015259 */
+ val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
+ val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;

  mlx90614_power_get(data, false);
  mutex_lock(&data->lock);
-- 
2.1.4

--001a1139d1da1fada4051b5340bd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Translates the magic constant numbers to named macros=
 and add some<br></div><div>additional comments about their meaning.</div><=
div><br></div><div>The diff is made towards togreg branch as that branch se=
ems to have the</div><div>most recent updates of mlx90614 driver (many are =
yet to be merged).</div><div><br></div><div>Signed-off-by: Crt Mori &lt;<a =
href=3D"mailto:cmo@melexis.com">cmo@melexis.com</a>&gt;</div><div>Acked-by:=
 Peter Meerwald &lt;<a href=3D"mailto:pmeerw@pmeerw.net">pmeerw@pmeerw.net<=
/a>&gt;</div><div>---</div><div>=C2=A0drivers/iio/temperature/mlx90614.c | =
20 ++++++++++++++------</div><div>=C2=A01 file changed, 14 insertions(+), 6=
 deletions(-)</div><div><br></div><div>diff --git a/drivers/iio/temperature=
/mlx90614.c b/drivers/iio/temperature/mlx90614.c</div><div>index cb2e8ad..4=
590f83 100644</div><div>--- a/drivers/iio/temperature/mlx90614.c</div><div>=
+++ b/drivers/iio/temperature/mlx90614.c</div><div>@@ -65,6 +65,13 @@</div>=
<div>=C2=A0</div><div>=C2=A0#define MLX90614_AUTOSLEEP_DELAY 5000 /* defaul=
t autosleep delay */</div><div>=C2=A0</div><div>+/* Magic constants */</div=
><div>+#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the Kelv=
in offset */</div><div>+#define MLX90614_CONST_OFFSET_REM 500000 /* remaind=
er of offset (273.15*50) */</div><div>+#define MLX90614_CONST_SCALE 20 /* S=
cale in milliKelvin (0.02 * 1000) */</div><div>+#define MLX90614_CONST_RAW_=
EMISSIVITY_MAX 65535 /* max value for emissivity */</div><div>+#define MLX9=
0614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000015259 */</div><di=
v>+</div><div>=C2=A0struct mlx90614_data {</div><div>=C2=A0<span class=3D""=
 style=3D"white-space:pre">	</span>struct i2c_client *client;</div><div>=C2=
=A0<span class=3D"" style=3D"white-space:pre">	</span>struct mutex lock; /*=
 for EEPROM access only */</div><div>@@ -204,11 +211,11 @@ static int mlx90=
614_read_raw(struct iio_dev *indio_dev,</div><div>=C2=A0<span class=3D"" st=
yle=3D"white-space:pre">		</span>*val =3D ret;</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">		</span>return IIO_VAL_INT;</div><div>=C2=
=A0<span class=3D"" style=3D"white-space:pre">	</span>case IIO_CHAN_INFO_OF=
FSET:</div><div>-<span class=3D"" style=3D"white-space:pre">		</span>*val =
=3D 13657;</div><div>-<span class=3D"" style=3D"white-space:pre">		</span>*=
val2 =3D 500000;</div><div>+<span class=3D"" style=3D"white-space:pre">		</=
span>*val =3D MLX90614_CONST_OFFSET_DEC;</div><div>+<span class=3D"" style=
=3D"white-space:pre">		</span>*val2 =3D MLX90614_CONST_OFFSET_REM;</div><di=
v>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>return IIO_VAL_=
INT_PLUS_MICRO;</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">=
	</span>case IIO_CHAN_INFO_SCALE:</div><div>-<span class=3D"" style=3D"whit=
e-space:pre">		</span>*val =3D 20;</div><div>+<span class=3D"" style=3D"whi=
te-space:pre">		</span>*val =3D MLX90614_CONST_SCALE;</div><div>=C2=A0<span=
 class=3D"" style=3D"white-space:pre">		</span>return IIO_VAL_INT;</div><di=
v>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>case IIO_CHAN_IN=
FO_CALIBEMISSIVITY: /* 1/65535 / LSB */</div><div>=C2=A0<span class=3D"" st=
yle=3D"white-space:pre">		</span>mlx90614_power_get(data, false);</div><div=
>@@ -221,12 +228,12 @@ static int mlx90614_read_raw(struct iio_dev *indio_d=
ev,</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>if =
(ret &lt; 0)</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">			=
</span>return ret;</div><div>=C2=A0</div><div>-<span class=3D"" style=3D"wh=
ite-space:pre">		</span>if (ret =3D=3D 65535) {</div><div>+<span class=3D""=
 style=3D"white-space:pre">		</span>if (ret =3D=3D MLX90614_CONST_RAW_EMISS=
IVITY_MAX) {</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">			=
</span>*val =3D 1;</div><div>=C2=A0<span class=3D"" style=3D"white-space:pr=
e">			</span>*val2 =3D 0;</div><div>=C2=A0<span class=3D"" style=3D"white-s=
pace:pre">		</span>} else {</div><div>=C2=A0<span class=3D"" style=3D"white=
-space:pre">			</span>*val =3D 0;</div><div>-<span class=3D"" style=3D"whit=
e-space:pre">			</span>*val2 =3D ret * 15259; /* 1/65535 ~ 0.000015259 */</=
div><div>+<span class=3D"" style=3D"white-space:pre">			</span>*val2 =3D re=
t * MLX90614_CONST_EMISSIVITY_RESOLUTION;</div><div>=C2=A0<span class=3D"" =
style=3D"white-space:pre">		</span>}</div><div>=C2=A0<span class=3D"" style=
=3D"white-space:pre">		</span>return IIO_VAL_INT_PLUS_NANO;</div><div>=C2=
=A0<span class=3D"" style=3D"white-space:pre">	</span>default:</div><div>@@=
 -245,7 +252,8 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,<=
/div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>case IIO=
_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">		</span>if (val &lt; 0 || val2 &lt; 0 || v=
al &gt; 1 || (val =3D=3D 1 &amp;&amp; val2 !=3D 0))</div><div>=C2=A0<span c=
lass=3D"" style=3D"white-space:pre">			</span>return -EINVAL;</div><div>-<s=
pan class=3D"" style=3D"white-space:pre">		</span>val =3D val * 65535 + val=
2 / 15259; /* 1/65535 ~ 0.000015259 */</div><div>+<span class=3D"" style=3D=
"white-space:pre">		</span>val =3D val * MLX90614_CONST_RAW_EMISSIVITY_MAX =
+</div><div>+<span class=3D"" style=3D"white-space:pre">			</span>val2 / ML=
X90614_CONST_EMISSIVITY_RESOLUTION;</div><div>=C2=A0</div><div>=C2=A0<span =
class=3D"" style=3D"white-space:pre">		</span>mlx90614_power_get(data, fals=
e);</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>mut=
ex_lock(&amp;data-&gt;lock);</div><div>--=C2=A0</div><div>2.1.4</div><div><=
br></div></div>

--001a1139d1da1fada4051b5340bd--
