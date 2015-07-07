Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
From: Crt Mori <cmo@melexis.com>
Date: Tue, 7 Jul 2015 16:44:51 +0200
Message-ID: <CAKv63usGO4DxYhx-Sz_BugWmi_ztJF7=ce035Wr1EZw+-wMOfg@mail.gmail.com>
Subject: [PATCH 0/1] iio: mlx90614: Implement filter configuration
To: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Vianney_le_Cl=C3=A9ment_de_Saint=2DMarcq?= <vianney.leclement@essensium.com>,
	Johnathan Iain Cameron <jic23@kernel.org>
Content-Type: multipart/alternative; boundary=001a1138ee8ce8f823051a4a1263
List-ID: <linux-iio@vger.kernel.org>

--001a1138ee8ce8f823051a4a1263
Content-Type: text/plain; charset=UTF-8

Implemented FIR and IIR filter configuration which are located
within the configuration register of EEPROM. I have used the
IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY for FIR settings and
IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY for IIR settings just
to reuse IIO_CHAN_INFO structure with closes resemblance of the
settings (although it would have been better to drop that
3DB_FREQUENCY part).

The diff is made towards togreg branch as that branch seems to have the
most recent updates of mlx90614 driver

Signed-off-by: Crt Mori <cmo@melexis.com>
---
diff --git a/drivers/iio/temperature/mlx90614.c
b/drivers/iio/temperature/mlx90614.c
index 909278a..d767d2f 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -20,7 +20,6 @@
  * always has a pull-up so we do not need an extra GPIO to drive it high.
If
  * the "wakeup" GPIO is not given, power management will be disabled.
  *
- * TODO: filter configuration
  */

 #include <linux/err.h>
@@ -79,6 +78,25 @@ struct mlx90614_data {
  unsigned long ready_timestamp; /* in jiffies */
 };

+/* Allowed percentage values for IIR filtering */
+static const u8 mlx90614_iir_values[] = {50, 25, 17, 13, 100, 80, 67, 57};
+
+/*
+ * Find the IIR value inside mlx90614_iir_values array and return its
position
+ */
+static inline s32 mlx90614_iir_search(int value)
+{
+ u8 i;
+ if (value < 0 || value > 100)
+ return -EINVAL;
+
+ for (i=0; i < ARRAY_SIZE(mlx90614_iir_values); ++i) {
+ if (value == mlx90614_iir_values[i])
+ return i;
+ }
+ return -EINVAL;
+}
+
 /*
  * Erase an address and write word.
  * The mutex must be locked before calling.
@@ -236,6 +254,31 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
  *val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
  }
  return IIO_VAL_INT_PLUS_NANO;
+ case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* FIR setting */
+ mlx90614_power_get(data, false);
+ mutex_lock(&data->lock);
+ ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
+ mutex_unlock(&data->lock);
+ mlx90614_power_put(data);
+
+ if (ret < 0)
+ return ret;
+
+ *val = (ret & MLX90614_CONFIG_FIR_MASK) >>
+ MLX90614_CONFIG_FIR_SHIFT;
+ return IIO_VAL_INT;
+ case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY: /* IIR setting */
+ mlx90614_power_get(data, false);
+ mutex_lock(&data->lock);
+ ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
+ mutex_unlock(&data->lock);
+ mlx90614_power_put(data);
+
+ if (ret < 0)
+ return ret;
+
+ *val = mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK];
+ return IIO_VAL_INT;
  default:
  return -EINVAL;
  }
@@ -263,6 +306,52 @@ static int mlx90614_write_raw(struct iio_dev
*indio_dev,
  mlx90614_power_put(data);

  return ret;
+ case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* FIR Filter */
+ if (val < 0 || val > 7)
+ return -EINVAL;
+
+ mlx90614_power_get(data, false);
+ mutex_lock(&data->lock);
+
+ /* CONFIG register values must not be changed so we must read
+ * them before we actually write changes */
+ ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
+ if (ret >= 0)
+ {
+ /* Write changed values */
+ ret = mlx90614_write_word(data->client, MLX90614_CONFIG,
+  (val << MLX90614_CONFIG_FIR_SHIFT) |
+  ((u16) ret & (~((u16) MLX90614_CONFIG_FIR_MASK))));
+ }
+ mutex_unlock(&data->lock);
+ mlx90614_power_put(data);
+
+ return ret;
+ case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY: /* IIR Filter */
+ ret = mlx90614_iir_search(val);
+ if (ret < 0)
+ return ret;
+ /* If there is no error, then we have a sensor equivalent value
+ * in ret. We need to store it temporary to val, as we still
+ * have more data to save in ret before we can actually write */
+ val = ret;
+
+ mlx90614_power_get(data, false);
+ mutex_lock(&data->lock);
+ /* CONFIG register values must not be changed so we must read
+ * them before we actually write changes*/
+ ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
+ if (ret >= 0)
+ {
+ /* Write changed values */
+ ret = mlx90614_write_word(data->client, MLX90614_CONFIG,
+  (val << MLX90614_CONFIG_IIR_SHIFT) |
+  ((u16) ret & (~(u16) MLX90614_CONFIG_IIR_MASK)));
+ }
+ mutex_unlock(&data->lock);
+ mlx90614_power_put(data);
+
+ return ret;
  default:
  return -EINVAL;
  }
@@ -275,6 +364,10 @@ static int mlx90614_write_raw_get_fmt(struct iio_dev
*indio_dev,
  switch (mask) {
  case IIO_CHAN_INFO_CALIBEMISSIVITY:
  return IIO_VAL_INT_PLUS_NANO;
+ case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+ return IIO_VAL_INT_PLUS_MICRO;
+ case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+ return IIO_VAL_INT_PLUS_MICRO;
  default:
  return -EINVAL;
  }
@@ -294,7 +387,9 @@ static const struct iio_chan_spec mlx90614_channels[] =
{
  .modified = 1,
  .channel2 = IIO_MOD_TEMP_OBJECT,
  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
+    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
+ BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
+ BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),
  .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
     BIT(IIO_CHAN_INFO_SCALE),
  },
@@ -305,7 +400,9 @@ static const struct iio_chan_spec mlx90614_channels[] =
{
  .channel = 1,
  .channel2 = IIO_MOD_TEMP_OBJECT,
  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
+    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
+ BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
+ BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),
  .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
     BIT(IIO_CHAN_INFO_SCALE),
  },

--001a1138ee8ce8f823051a4a1263
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Implemented FIR and IIR filter configuration whi=
ch are located<br></div><div>within the configuration register of EEPROM. I=
 have used the</div><div>IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY for FI=
R settings and</div><div>IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY for I=
IR settings just</div><div>to reuse IIO_CHAN_INFO structure with closes res=
emblance of the</div><div>settings (although it would have been better to d=
rop that</div><div>3DB_FREQUENCY part).</div><div><br></div><div>The diff i=
s made towards togreg branch as that branch seems to have the</div><div>mos=
t recent updates of mlx90614 driver</div><div><br></div><div>Signed-off-by:=
 Crt Mori &lt;<a href=3D"mailto:cmo@melexis.com">cmo@melexis.com</a>&gt;</d=
iv><div>---</div></div><div>diff --git a/drivers/iio/temperature/mlx90614.c=
 b/drivers/iio/temperature/mlx90614.c<br></div><div>index 909278a..d767d2f =
100644</div><div>--- a/drivers/iio/temperature/mlx90614.c</div><div>+++ b/d=
rivers/iio/temperature/mlx90614.c</div><div>@@ -20,7 +20,6 @@</div><div>=C2=
=A0 * always has a pull-up so we do not need an extra GPIO to drive it high=
.=C2=A0 If</div><div>=C2=A0 * the &quot;wakeup&quot; GPIO is not given, pow=
er management will be disabled.</div><div>=C2=A0 *</div><div>- * TODO: filt=
er configuration</div><div>=C2=A0 */</div><div>=C2=A0</div><div>=C2=A0#incl=
ude &lt;linux/err.h&gt;</div><div>@@ -79,6 +78,25 @@ struct mlx90614_data {=
</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>unsigne=
d long ready_timestamp; /* in jiffies */</div><div>=C2=A0};</div><div>=C2=
=A0</div><div>+/* Allowed percentage values for IIR filtering */</div><div>=
+static const u8 mlx90614_iir_values[] =3D {50, 25, 17, 13, 100, 80, 67, 57=
};</div><div>+</div><div>+/*</div><div>+ * Find the IIR value inside mlx906=
14_iir_values array and return its position</div><div>+ */</div><div>+stati=
c inline s32 mlx90614_iir_search(int value)</div><div>+{</div><div>+<span c=
lass=3D"" style=3D"white-space:pre">	</span>u8 i;</div><div>+<span class=3D=
"" style=3D"white-space:pre">	</span>if (value &lt; 0 || value &gt; 100)</d=
iv><div>+<span class=3D"" style=3D"white-space:pre">		</span>return -EINVAL=
;</div><div>+</div><div>+<span class=3D"" style=3D"white-space:pre">	</span=
>for (i=3D0; i &lt; ARRAY_SIZE(mlx90614_iir_values); ++i) {</div><div>+<spa=
n class=3D"" style=3D"white-space:pre">		</span>if (value =3D=3D mlx90614_i=
ir_values[i])</div><div>+<span class=3D"" style=3D"white-space:pre">			</sp=
an>return i;</div><div>+<span class=3D"" style=3D"white-space:pre">	</span>=
}</div><div>+<span class=3D"" style=3D"white-space:pre">	</span>return -EIN=
VAL;</div><div>+}</div><div>+</div><div>=C2=A0/*</div><div>=C2=A0 * Erase a=
n address and write word.</div><div>=C2=A0 * The mutex must be locked befor=
e calling.</div><div>@@ -236,6 +254,31 @@ static int mlx90614_read_raw(stru=
ct iio_dev *indio_dev,</div><div>=C2=A0<span class=3D"" style=3D"white-spac=
e:pre">			</span>*val2 =3D ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;</div=
><div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>}</div><div=
>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>return IIO_VAL_I=
NT_PLUS_NANO;</div><div>+<span class=3D"" style=3D"white-space:pre">	</span=
>case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* FIR setting */</div><=
div>+<span class=3D"" style=3D"white-space:pre">		</span>mlx90614_power_get=
(data, false);</div><div>+<span class=3D"" style=3D"white-space:pre">		</sp=
an>mutex_lock(&amp;data-&gt;lock);</div><div>+<span class=3D"" style=3D"whi=
te-space:pre">		</span>ret =3D i2c_smbus_read_word_data(data-&gt;client,MLX=
90614_CONFIG);</div><div>+<span class=3D"" style=3D"white-space:pre">		</sp=
an>mutex_unlock(&amp;data-&gt;lock);</div><div>+<span class=3D"" style=3D"w=
hite-space:pre">		</span>mlx90614_power_put(data);</div><div>+</div><div>+<=
span class=3D"" style=3D"white-space:pre">		</span>if (ret &lt; 0)</div><di=
v>+<span class=3D"" style=3D"white-space:pre">			</span>return ret;</div><d=
iv>+</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>*val =
=3D (ret &amp; MLX90614_CONFIG_FIR_MASK) &gt;&gt;</div><div>+<span class=3D=
"" style=3D"white-space:pre">			</span>MLX90614_CONFIG_FIR_SHIFT;</div><div=
>+<span class=3D"" style=3D"white-space:pre">		</span>return IIO_VAL_INT;</=
div><div>+<span class=3D"" style=3D"white-space:pre">	</span>case IIO_CHAN_=
INFO_HIGH_PASS_FILTER_3DB_FREQUENCY: /* IIR setting */</div><div>+<span cla=
ss=3D"" style=3D"white-space:pre">		</span>mlx90614_power_get(data, false);=
</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>mutex_lock(=
&amp;data-&gt;lock);</div><div>+<span class=3D"" style=3D"white-space:pre">=
		</span>ret =3D i2c_smbus_read_word_data(data-&gt;client,MLX90614_CONFIG);=
</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>mutex_unloc=
k(&amp;data-&gt;lock);</div><div>+<span class=3D"" style=3D"white-space:pre=
">		</span>mlx90614_power_put(data);</div><div>+</div><div>+<span class=3D"=
" style=3D"white-space:pre">		</span>if (ret &lt; 0)</div><div>+<span class=
=3D"" style=3D"white-space:pre">			</span>return ret;</div><div>+</div><div=
>+<span class=3D"" style=3D"white-space:pre">		</span>*val =3D mlx90614_iir=
_values[ret &amp; MLX90614_CONFIG_IIR_MASK];</div><div>+<span class=3D"" st=
yle=3D"white-space:pre">		</span>return IIO_VAL_INT;</div><div>=C2=A0<span =
class=3D"" style=3D"white-space:pre">	</span>default:</div><div>=C2=A0<span=
 class=3D"" style=3D"white-space:pre">		</span>return -EINVAL;</div><div>=
=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>}</div><div>@@ -26=
3,6 +306,52 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,</di=
v><div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>mlx90614_p=
ower_put(data);</div><div>=C2=A0</div><div>=C2=A0<span class=3D"" style=3D"=
white-space:pre">		</span>return ret;</div><div>+<span class=3D"" style=3D"=
white-space:pre">	</span>case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: =
/* FIR Filter */</div><div>+<span class=3D"" style=3D"white-space:pre">		</=
span>if (val &lt; 0 || val &gt; 7)</div><div>+<span class=3D"" style=3D"whi=
te-space:pre">			</span>return -EINVAL;</div><div>+</div><div>+<span class=
=3D"" style=3D"white-space:pre">		</span>mlx90614_power_get(data, false);</=
div><div>+<span class=3D"" style=3D"white-space:pre">		</span>mutex_lock(&a=
mp;data-&gt;lock);</div><div>+</div><div>+<span class=3D"" style=3D"white-s=
pace:pre">		</span>/* CONFIG register values must not be changed so we must=
 read</div><div>+<span class=3D"" style=3D"white-space:pre">		</span> * the=
m before we actually write changes */</div><div>+<span class=3D"" style=3D"=
white-space:pre">		</span>ret =3D i2c_smbus_read_word_data(data-&gt;client,=
MLX90614_CONFIG);</div><div>+<span class=3D"" style=3D"white-space:pre">		<=
/span>if (ret &gt;=3D 0)</div><div>+<span class=3D"" style=3D"white-space:p=
re">		</span>{</div><div>+<span class=3D"" style=3D"white-space:pre">			</s=
pan>/* Write changed values */</div><div>+<span class=3D"" style=3D"white-s=
pace:pre">			</span>ret =3D mlx90614_write_word(data-&gt;client, MLX90614_C=
ONFIG,</div><div>+<span class=3D"" style=3D"white-space:pre">			</span> =C2=
=A0(val &lt;&lt; MLX90614_CONFIG_FIR_SHIFT) |</div><div>+<span class=3D"" s=
tyle=3D"white-space:pre">			</span> =C2=A0((u16) ret &amp; (~((u16) MLX9061=
4_CONFIG_FIR_MASK))));</div><div>+<span class=3D"" style=3D"white-space:pre=
">		</span>}</div><div>+<span class=3D"" style=3D"white-space:pre">		</span=
>mutex_unlock(&amp;data-&gt;lock);</div><div>+<span class=3D"" style=3D"whi=
te-space:pre">		</span>mlx90614_power_put(data);</div><div>+</div><div>+<sp=
an class=3D"" style=3D"white-space:pre">		</span>return ret;</div><div>+<sp=
an class=3D"" style=3D"white-space:pre">	</span>case IIO_CHAN_INFO_HIGH_PAS=
S_FILTER_3DB_FREQUENCY: /* IIR Filter */</div><div>+<span class=3D"" style=
=3D"white-space:pre">		</span>ret =3D mlx90614_iir_search(val);</div><div>+=
<span class=3D"" style=3D"white-space:pre">		</span>if (ret &lt; 0)</div><d=
iv>+<span class=3D"" style=3D"white-space:pre">			</span>return ret;</div><=
div>+<span class=3D"" style=3D"white-space:pre">		</span>/* If there is no =
error, then we have a sensor equivalent value</div><div>+<span class=3D"" s=
tyle=3D"white-space:pre">		</span> * in ret. We need to store it temporary =
to val, as we still</div><div>+<span class=3D"" style=3D"white-space:pre">	=
	</span> * have more data to save in ret before we can actually write */</d=
iv><div>+<span class=3D"" style=3D"white-space:pre">		</span>val =3D ret;</=
div><div>+</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>m=
lx90614_power_get(data, false);</div><div>+<span class=3D"" style=3D"white-=
space:pre">		</span>mutex_lock(&amp;data-&gt;lock);</div><div>+<span class=
=3D"" style=3D"white-space:pre">		</span>/* CONFIG register values must not=
 be changed so we must read</div><div>+<span class=3D"" style=3D"white-spac=
e:pre">		</span> * them before we actually write changes*/</div><div>+<span=
 class=3D"" style=3D"white-space:pre">		</span>ret =3D i2c_smbus_read_word_=
data(data-&gt;client,MLX90614_CONFIG);</div><div>+<span class=3D"" style=3D=
"white-space:pre">		</span>if (ret &gt;=3D 0)</div><div>+<span class=3D"" s=
tyle=3D"white-space:pre">		</span>{</div><div>+<span class=3D"" style=3D"wh=
ite-space:pre">			</span>/* Write changed values */</div><div>+<span class=
=3D"" style=3D"white-space:pre">			</span>ret =3D mlx90614_write_word(data-=
&gt;client, MLX90614_CONFIG,</div><div>+<span class=3D"" style=3D"white-spa=
ce:pre">			</span> =C2=A0(val &lt;&lt; MLX90614_CONFIG_IIR_SHIFT) |</div><d=
iv>+<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0((u16) ret =
&amp; (~(u16) MLX90614_CONFIG_IIR_MASK)));</div><div>+<span class=3D"" styl=
e=3D"white-space:pre">		</span>}</div><div>+<span class=3D"" style=3D"white=
-space:pre">		</span>mutex_unlock(&amp;data-&gt;lock);</div><div>+<span cla=
ss=3D"" style=3D"white-space:pre">		</span>mlx90614_power_put(data);</div><=
div>+</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>return=
 ret;</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>de=
fault:</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>=
return -EINVAL;</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">=
	</span>}</div><div>@@ -275,6 +364,10 @@ static int mlx90614_write_raw_get_=
fmt(struct iio_dev *indio_dev,</div><div>=C2=A0<span class=3D"" style=3D"wh=
ite-space:pre">	</span>switch (mask) {</div><div>=C2=A0<span class=3D"" sty=
le=3D"white-space:pre">	</span>case IIO_CHAN_INFO_CALIBEMISSIVITY:</div><di=
v>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>return IIO_VAL_=
INT_PLUS_NANO;</div><div>+<span class=3D"" style=3D"white-space:pre">	</spa=
n>case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:</div><div>+<span class=
=3D"" style=3D"white-space:pre">		</span>return IIO_VAL_INT_PLUS_MICRO;</di=
v><div>+<span class=3D"" style=3D"white-space:pre">	</span>case IIO_CHAN_IN=
FO_HIGH_PASS_FILTER_3DB_FREQUENCY:</div><div>+<span class=3D"" style=3D"whi=
te-space:pre">		</span>return IIO_VAL_INT_PLUS_MICRO;</div><div>=C2=A0<span=
 class=3D"" style=3D"white-space:pre">	</span>default:</div><div>=C2=A0<spa=
n class=3D"" style=3D"white-space:pre">		</span>return -EINVAL;</div><div>=
=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>}</div><div>@@ -29=
4,7 +387,9 @@ static const struct iio_chan_spec mlx90614_channels[] =3D {</=
div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>.modifie=
d =3D 1,</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</spa=
n>.channel2 =3D IIO_MOD_TEMP_OBJECT,</div><div>=C2=A0<span class=3D"" style=
=3D"white-space:pre">		</span>.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW=
) |</div><div>-<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0 =
=C2=A0BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),</div><div>+<span class=3D"" style=
=3D"white-space:pre">		</span> =C2=A0 =C2=A0BIT(IIO_CHAN_INFO_CALIBEMISSIVI=
TY) |</div><div>+<span class=3D"" style=3D"white-space:pre">			</span>BIT(I=
IO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |</div><div>+<span class=3D"" s=
tyle=3D"white-space:pre">			</span>BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_F=
REQUENCY),</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</s=
pan>.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OFFSET) |</div><div>=C2=
=A0<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0 =C2=A0BIT(II=
O_CHAN_INFO_SCALE),</div><div>=C2=A0<span class=3D"" style=3D"white-space:p=
re">	</span>},</div><div>@@ -305,7 +400,9 @@ static const struct iio_chan_s=
pec mlx90614_channels[] =3D {</div><div>=C2=A0<span class=3D"" style=3D"whi=
te-space:pre">		</span>.channel =3D 1,</div><div>=C2=A0<span class=3D"" sty=
le=3D"white-space:pre">		</span>.channel2 =3D IIO_MOD_TEMP_OBJECT,</div><di=
v>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>.info_mask_sepa=
rate =3D BIT(IIO_CHAN_INFO_RAW) |</div><div>-<span class=3D"" style=3D"whit=
e-space:pre">		</span> =C2=A0 =C2=A0BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),</di=
v><div>+<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0 =C2=A0B=
IT(IIO_CHAN_INFO_CALIBEMISSIVITY) |</div><div>+<span class=3D"" style=3D"wh=
ite-space:pre">			</span>BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |=
</div><div>+<span class=3D"" style=3D"white-space:pre">			</span>BIT(IIO_CH=
AN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),</div><div>=C2=A0<span class=3D"" s=
tyle=3D"white-space:pre">		</span>.info_mask_shared_by_type =3D BIT(IIO_CHA=
N_INFO_OFFSET) |</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre"=
>		</span> =C2=A0 =C2=A0BIT(IIO_CHAN_INFO_SCALE),</div><div>=C2=A0<span cla=
ss=3D"" style=3D"white-space:pre">	</span>},</div><div><br></div><span clas=
s=3D""></span><span class=3D""></span></div>

--001a1138ee8ce8f823051a4a1263--
