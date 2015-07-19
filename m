Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
In-Reply-To: <55AB8B13.7090907@kernel.org>
References: <CAKv63utwT_KTvTYcOogAWQ4NUcVUsAFvFgWwqa2rZ+5+1bM7Cw@mail.gmail.com>
 <55AB8B13.7090907@kernel.org>
From: Crt Mori <cmo@melexis.com>
Date: Sun, 19 Jul 2015 22:14:34 +0200
Message-ID: <CAKv63ut35A_f2P_xdrtCtsc8mPztDx1h2PaFz4JYC1r5NhR-Ww@mail.gmail.com>
Subject: Re: [PATCH] iio: mlx90614: Define magic numbers
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Vianney_le_Cl=C3=A9ment_de_Saint=2DMarcq?= <vianney.leclement@essensium.com>
Content-Type: multipart/alternative; boundary=001a1141b94e29879d051b401408
List-ID: <linux-iio@vger.kernel.org>

--001a1141b94e29879d051b401408
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
index cb2e8ad..909278a 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -65,6 +65,13 @@

 #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */

+/* Magic constants */
+#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the
Kelvin offset */
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


On 19 July 2015 at 13:33, Jonathan Cameron <jic23@kernel.org> wrote:

> On 05/07/15 19:07, Crt Mori wrote:
> > Translates the magic constant numbers to named macros and add some
> > additional comments about their meaning.
> >
> > The diff is made towards togreg branch as that branch seems to have the
> > most recent updates of mlx90614 driver (many are yet to be merged).
> >
> > Signed-off-by: Crt Mori <cmo@melexis.com>
> > Acked-by: Peter Meerwald <pmeerw@pmeerw.net>
> Crt,
>
> This patch is malformed, probably as a result of your email client.
> It seems to have replaced tabs with spaces meaning I can't apply this
> without doing it line by line.
>
> Could you take a look at Documentation/SubmittingPatches and the advice
> in there on how to lure an email client into not messing things up.
>
> If you can't persuade that to work, I will take the occasional attachment.
>
> Otherwise, the patch looks fine.
>
Jonathan
>
I hope it is now OK? I needed to turn off google's mail mode, and
apparently plain text
mode also translates tabs into spaces. I have now fixed the tabs and I hope
they are
also sent. Please let me know - I will otherwise just pull some mail client
and get it
working.

Crt


> > ---
> >  drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/temperature/mlx90614.c
> > b/drivers/iio/temperature/mlx90614.c
> > index cb2e8ad..909278a 100644
> > --- a/drivers/iio/temperature/mlx90614.c
> > +++ b/drivers/iio/temperature/mlx90614.c
> > @@ -65,6 +65,13 @@
> >
> >  #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
> >
> > +/* Magic constants */
> > +#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the
> > Kelvin offset */
> > +#define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset
> (273.15*50) */
> > +#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
> > +#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for
> emissivity */
> > +#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~
> 0.000015259 */
> > +
> >  struct mlx90614_data {
> >         struct i2c_client *client;
> >         struct mutex lock; /* for EEPROM access only */
> > @@ -204,11 +211,11 @@ static int mlx90614_read_raw(struct iio_dev
> *indio_dev,
> >                 *val = ret;
> >                 return IIO_VAL_INT;
> >         case IIO_CHAN_INFO_OFFSET:
> > -               *val = 13657;
> > -               *val2 = 500000;
> > +               *val = MLX90614_CONST_OFFSET_DEC;
> > +               *val2 = MLX90614_CONST_OFFSET_REM;
> >                 return IIO_VAL_INT_PLUS_MICRO;
> >         case IIO_CHAN_INFO_SCALE:
> > -               *val = 20;
> > +               *val = MLX90614_CONST_SCALE;
> >                 return IIO_VAL_INT;
> >         case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
> >                 mlx90614_power_get(data, false);
> > @@ -221,12 +228,12 @@ static int mlx90614_read_raw(struct iio_dev
> *indio_dev,
> >                 if (ret < 0)
> >                         return ret;
> >
> > -               if (ret == 65535) {
> > +               if (ret == MLX90614_CONST_RAW_EMISSIVITY_MAX) {
> >                         *val = 1;
> >                         *val2 = 0;
> >                 } else {
> >                         *val = 0;
> > -                       *val2 = ret * 15259; /* 1/65535 ~ 0.000015259 */
> > +                       *val2 = ret *
> MLX90614_CONST_EMISSIVITY_RESOLUTION;
> >                 }
> >                 return IIO_VAL_INT_PLUS_NANO;
> >         default:
> > @@ -245,7 +252,8 @@ static int mlx90614_write_raw(struct iio_dev
> *indio_dev,
> >         case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
> >                 if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2
> != 0))
> >                         return -EINVAL;
> > -               val = val * 65535 + val2 / 15259; /* 1/65535 ~
> 0.000015259 */
> > +               val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
> > +                       val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
> >
> >                 mlx90614_power_get(data, false);
> >                 mutex_lock(&data->lock);
> >
>
>

--001a1141b94e29879d051b401408
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Translates the magic constant numbers to named macros=
 and add some</div><div>additional comments about their meaning.</div><div>=
<br></div><div>The diff is made towards togreg branch as that branch seems =
to have the</div><div>most recent updates of mlx90614 driver (many are yet =
to be merged).</div><div><br></div><div>Signed-off-by: Crt Mori &lt;<a href=
=3D"mailto:cmo@melexis.com">cmo@melexis.com</a>&gt;</div><div>Acked-by: Pet=
er Meerwald &lt;<a href=3D"mailto:pmeerw@pmeerw.net">pmeerw@pmeerw.net</a>&=
gt;</div><div>---</div><div>=C2=A0drivers/iio/temperature/mlx90614.c | 20 +=
+++++++++++++------</div><div>=C2=A01 file changed, 14 insertions(+), 6 del=
etions(-)</div><div><br></div><div>diff --git a/drivers/iio/temperature/mlx=
90614.c</div><div>b/drivers/iio/temperature/mlx90614.c</div><div>index cb2e=
8ad..909278a 100644</div><div>--- a/drivers/iio/temperature/mlx90614.c</div=
><div>+++ b/drivers/iio/temperature/mlx90614.c</div><div>@@ -65,6 +65,13 @@=
</div><div><br></div><div>=C2=A0#define MLX90614_AUTOSLEEP_DELAY 5000 /* de=
fault autosleep delay */</div><div><br></div><div>+/* Magic constants */</d=
iv><div>+#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the</d=
iv><div>Kelvin offset */</div><div>+#define MLX90614_CONST_OFFSET_REM 50000=
0 /* remainder of offset (273.15*50) */</div><div>+#define MLX90614_CONST_S=
CALE 20 /* Scale in milliKelvin (0.02 * 1000) */</div><div>+#define MLX9061=
4_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for emissivity */</div><div>+=
#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000015259=
 */</div><div>+</div><div>=C2=A0struct mlx90614_data {</div><div><span clas=
s=3D"" style=3D"white-space:pre">		</span>struct i2c_client *client;</div><=
div><span class=3D"" style=3D"white-space:pre">		</span>struct mutex lock; =
/* for EEPROM access only */</div><div>@@ -204,11 +211,11 @@ static int mlx=
90614_read_raw(struct iio_dev *indio_dev,</div><div><span class=3D"" style=
=3D"white-space:pre">				</span>*val =3D ret;</div><div><span class=3D"" st=
yle=3D"white-space:pre">				</span>return IIO_VAL_INT;</div><div><span clas=
s=3D"" style=3D"white-space:pre">		</span>case IIO_CHAN_INFO_OFFSET:</div><=
div>-<span class=3D"" style=3D"white-space:pre">				</span>*val =3D 13657;<=
/div><div>-<span class=3D"" style=3D"white-space:pre">				</span>*val2 =3D =
500000;</div><div>+<span class=3D"" style=3D"white-space:pre">				</span>*v=
al =3D MLX90614_CONST_OFFSET_DEC;</div><div>+<span class=3D"" style=3D"whit=
e-space:pre">				</span>*val2 =3D MLX90614_CONST_OFFSET_REM;</div><div><spa=
n class=3D"" style=3D"white-space:pre">				</span>return IIO_VAL_INT_PLUS_M=
ICRO;</div><div><span class=3D"" style=3D"white-space:pre">		</span>case II=
O_CHAN_INFO_SCALE:</div><div>-<span class=3D"" style=3D"white-space:pre">		=
		</span>*val =3D 20;</div><div>+<span class=3D"" style=3D"white-space:pre"=
>				</span>*val =3D MLX90614_CONST_SCALE;</div><div><span class=3D"" style=
=3D"white-space:pre">				</span>return IIO_VAL_INT;</div><div><span class=
=3D"" style=3D"white-space:pre">		</span>case IIO_CHAN_INFO_CALIBEMISSIVITY=
: /* 1/65535 / LSB */</div><div><span class=3D"" style=3D"white-space:pre">=
				</span>mlx90614_power_get(data, false);</div><div>@@ -221,12 +228,12 @@=
 static int mlx90614_read_raw(struct iio_dev *indio_dev,</div><div><span cl=
ass=3D"" style=3D"white-space:pre">				</span>if (ret &lt; 0)</div><div><sp=
an class=3D"" style=3D"white-space:pre">					</span>return ret;</div><div><=
br></div><div>-<span class=3D"" style=3D"white-space:pre">				</span>if (re=
t =3D=3D 65535) {</div><div>+<span class=3D"" style=3D"white-space:pre">			=
	</span>if (ret =3D=3D MLX90614_CONST_RAW_EMISSIVITY_MAX) {</div><div><span=
 class=3D"" style=3D"white-space:pre">						</span>*val =3D 1;</div><div><s=
pan class=3D"" style=3D"white-space:pre">						</span>*val2 =3D 0;</div><di=
v><span class=3D"" style=3D"white-space:pre">				</span>} else {</div><div>=
<span class=3D"" style=3D"white-space:pre">						</span>*val =3D 0;</div><d=
iv>-<span class=3D"" style=3D"white-space:pre">						</span>*val2 =3D ret *=
 15259; /* 1/65535 ~ 0.000015259 */</div><div>+<span class=3D"" style=3D"wh=
ite-space:pre">						</span>*val2 =3D ret * MLX90614_CONST_EMISSIVITY_RESOL=
UTION;</div><div><span class=3D"" style=3D"white-space:pre">				</span>}</d=
iv><div><span class=3D"" style=3D"white-space:pre">				</span>return IIO_VA=
L_INT_PLUS_NANO;</div><div><span class=3D"" style=3D"white-space:pre">		</s=
pan>default:</div><div>@@ -245,7 +252,8 @@ static int mlx90614_write_raw(st=
ruct iio_dev *indio_dev,</div><div><span class=3D"" style=3D"white-space:pr=
e">		</span>case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */</div><d=
iv><span class=3D"" style=3D"white-space:pre">				</span>if (val &lt; 0 || =
val2 &lt; 0 || val &gt; 1 || (val =3D=3D 1 &amp;&amp; val2 !=3D 0))</div><d=
iv><span class=3D"" style=3D"white-space:pre">					</span>return -EINVAL;</=
div><div>-<span class=3D"" style=3D"white-space:pre">				</span>val =3D val=
 * 65535 + val2 / 15259; /* 1/65535 ~ 0.000015259 */</div><div>+<span class=
=3D"" style=3D"white-space:pre">				</span>val =3D val * MLX90614_CONST_RAW=
_EMISSIVITY_MAX +</div><div>+<span class=3D"" style=3D"white-space:pre">			=
			</span>val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;</div><div><br></div>=
<div><span class=3D"" style=3D"white-space:pre">				</span>mlx90614_power_g=
et(data, false);</div><div><span class=3D"" style=3D"white-space:pre">				<=
/span>mutex_lock(&amp;data-&gt;lock);</div><div class=3D"gmail_extra"><div>=
<div class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div style=3D"font-size:12.8000001907349px"><br></div></div></div>=
</div></div></div>
<br><div class=3D"gmail_quote">On 19 July 2015 at 13:33, Jonathan Cameron <=
span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank">=
jic23@kernel.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:=
rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span class=3D""=
>On 05/07/15 19:07, Crt Mori wrote:<br>
&gt; Translates the magic constant numbers to named macros and add some<br>
&gt; additional comments about their meaning.<br>
&gt;<br>
&gt; The diff is made towards togreg branch as that branch seems to have th=
e<br>
&gt; most recent updates of mlx90614 driver (many are yet to be merged).<br=
>
&gt;<br>
&gt; Signed-off-by: Crt Mori &lt;<a href=3D"mailto:cmo@melexis.com">cmo@mel=
exis.com</a>&gt;<br>
&gt; Acked-by: Peter Meerwald &lt;<a href=3D"mailto:pmeerw@pmeerw.net">pmee=
rw@pmeerw.net</a>&gt;<br>
</span>Crt,<br>
<br>
This patch is malformed, probably as a result of your email client.<br>
It seems to have replaced tabs with spaces meaning I can&#39;t apply this<b=
r>
without doing it line by line.<br>
<br>
Could you take a look at Documentation/SubmittingPatches and the advice<br>
in there on how to lure an email client into not messing things up.<br>
<br>
If you can&#39;t persuade that to work, I will take the occasional attachme=
nt.<br>
<br>
Otherwise, the patch looks fine.=C2=A0<br></blockquote><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><sp=
an class=3D""><font color=3D"#888888">
Jonathan<br></font></span></blockquote><div>I hope it is now OK? I needed t=
o turn off google&#39;s mail mode, and apparently plain text</div><div>mode=
 also translates tabs into spaces. I have now fixed the tabs and I hope the=
y are</div><div>also sent. Please let me know - I will otherwise just pull =
some mail client and get it</div><div>working.</div><div><br></div><div>Crt=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bo=
rder-left-style:solid;padding-left:1ex"><span class=3D""><font color=3D"#88=
8888">
</font></span><div class=3D""><div class=3D"h5">&gt; ---<br>
&gt;=C2=A0 drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++------<br>
&gt;=C2=A0 1 file changed, 14 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/iio/temperature/mlx90614.c<br>
&gt; b/drivers/iio/temperature/mlx90614.c<br>
&gt; index cb2e8ad..909278a 100644<br>
&gt; --- a/drivers/iio/temperature/mlx90614.c<br>
&gt; +++ b/drivers/iio/temperature/mlx90614.c<br>
&gt; @@ -65,6 +65,13 @@<br>
&gt;<br>
&gt;=C2=A0 #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay=
 */<br>
&gt;<br>
&gt; +/* Magic constants */<br>
&gt; +#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the<br>
&gt; Kelvin offset */<br>
&gt; +#define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset (273.=
15*50) */<br>
&gt; +#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000)=
 */<br>
&gt; +#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for emis=
sivity */<br>
&gt; +#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000=
015259 */<br>
&gt; +<br>
&gt;=C2=A0 struct mlx90614_data {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_client *client;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex lock; /* for EEPROM acce=
ss only */<br>
&gt; @@ -204,11 +211,11 @@ static int mlx90614_read_raw(struct iio_dev *ind=
io_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D =
ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return II=
O_VAL_INT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_OFFSET:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D 13657=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val2 =3D 5000=
00;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D MLX90=
614_CONST_OFFSET_DEC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val2 =3D MLX9=
0614_CONST_OFFSET_REM;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return II=
O_VAL_INT_PLUS_MICRO;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_SCALE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D 20;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D MLX90=
614_CONST_SCALE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return II=
O_VAL_INT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_CALIBEMISSIVITY: /=
* 1/65535 / LSB */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mlx90614_=
power_get(data, false);<br>
&gt; @@ -221,12 +228,12 @@ static int mlx90614_read_raw(struct iio_dev *ind=
io_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &=
lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D=
 65535) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D=
 MLX90614_CONST_RAW_EMISSIVITY_MAX) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*val =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*val2 =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*val =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*val2 =3D ret * 15259; /* 1/65535 ~ 0.000015259 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*val2 =3D ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return II=
O_VAL_INT_PLUS_NANO;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; @@ -245,7 +252,8 @@ static int mlx90614_write_raw(struct iio_dev *indi=
o_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_CALIBEMISSIVITY: /=
* 1/65535 / LSB */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &=
lt; 0 || val2 &lt; 0 || val &gt; 1 || (val =3D=3D 1 &amp;&amp; val2 !=3D 0)=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D val * =
65535 + val2 / 15259; /* 1/65535 ~ 0.000015259 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D val * =
MLX90614_CONST_RAW_EMISSIVITY_MAX +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mlx90614_=
power_get(data, false);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_loc=
k(&amp;data-&gt;lock);<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a1141b94e29879d051b401408--
