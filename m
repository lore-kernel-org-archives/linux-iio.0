Return-Path: <denis.ciocca@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5246B7C6.7090206@kernel.org>
References: <1380034294-22887-1-git-send-email-denis.ciocca@st.com>
	<1380034294-22887-2-git-send-email-denis.ciocca@st.com>
	<5246B7C6.7090206@kernel.org>
Date: Sat, 28 Sep 2013 14:30:10 +0200
Message-ID: <CAEE_umq58NaSHLfhNYtsABRoBGx03FGsbfBkQ7wWP+5X0qL8JQ@mail.gmail.com>
Subject: Re: [PATCH] iio:magnetometer: Bugfix magnetometer default output registers
From: Denis Ciocca <denis.ciocca@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Denis CIOCCA <denis.ciocca@st.com>, lee.jones@linaro.org
Content-Type: multipart/alternative; boundary=001a11c29f4099f80204e770c31a
List-ID: <linux-iio@vger.kernel.org>

--001a11c29f4099f80204e770c31a
Content-Type: text/plain; charset=ISO-8859-1

Yes thanks!

Denis
 On Sep 28, 2013 12:04 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:

> On 09/24/13 15:51, Denis CIOCCA wrote:
> > Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> Applied to the togreg branch of iio.git
>
> Does this want to go to stable as well?
>
> Thanks,
> > ---
> >  drivers/iio/magnetometer/st_magn_core.c |   18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iio/magnetometer/st_magn_core.c
> b/drivers/iio/magnetometer/st_magn_core.c
> > index e8d2849..cab3bc7 100644
> > --- a/drivers/iio/magnetometer/st_magn_core.c
> > +++ b/drivers/iio/magnetometer/st_magn_core.c
> > @@ -29,9 +29,9 @@
> >  #define ST_MAGN_NUMBER_DATA_CHANNELS         3
> >
> >  /* DEFAULT VALUE FOR SENSORS */
> > -#define ST_MAGN_DEFAULT_OUT_X_L_ADDR         0X04
> > -#define ST_MAGN_DEFAULT_OUT_Y_L_ADDR         0X08
> > -#define ST_MAGN_DEFAULT_OUT_Z_L_ADDR         0X06
> > +#define ST_MAGN_DEFAULT_OUT_X_H_ADDR         0X03
> > +#define ST_MAGN_DEFAULT_OUT_Y_H_ADDR         0X07
> > +#define ST_MAGN_DEFAULT_OUT_Z_H_ADDR         0X05
> >
> >  /* FULLSCALE */
> >  #define ST_MAGN_FS_AVL_1300MG                        1300
> > @@ -117,16 +117,16 @@
> >  static const struct iio_chan_spec st_magn_16bit_channels[] = {
> >       ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
> >                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > -                     ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16,
> 16,
> > -                     ST_MAGN_DEFAULT_OUT_X_L_ADDR),
> > +                     ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_BE, 16,
> 16,
> > +                     ST_MAGN_DEFAULT_OUT_X_H_ADDR),
> >       ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
> >                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > -                     ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16,
> 16,
> > -                     ST_MAGN_DEFAULT_OUT_Y_L_ADDR),
> > +                     ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_BE, 16,
> 16,
> > +                     ST_MAGN_DEFAULT_OUT_Y_H_ADDR),
> >       ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
> >                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > -                     ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16,
> 16,
> > -                     ST_MAGN_DEFAULT_OUT_Z_L_ADDR),
> > +                     ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_BE, 16,
> 16,
> > +                     ST_MAGN_DEFAULT_OUT_Z_H_ADDR),
> >       IIO_CHAN_SOFT_TIMESTAMP(3)
> >  };
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a11c29f4099f80204e770c31a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Yes thanks!</p>
<p dir=3D"ltr">Denis<br>
</p>
<div class=3D"gmail_quote">On Sep 28, 2013 12:04 PM, &quot;Jonathan Cameron=
&quot; &lt;<a href=3D"mailto:jic23@kernel.org">jic23@kernel.org</a>&gt; wro=
te:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On 09/24/13 15:51, Denis CIOCCA wrote:<br>
&gt; Signed-off-by: Denis Ciocca &lt;<a href=3D"mailto:denis.ciocca@st.com"=
>denis.ciocca@st.com</a>&gt;<br>
Applied to the togreg branch of iio.git<br>
<br>
Does this want to go to stable as well?<br>
<br>
Thanks,<br>
&gt; ---<br>
&gt; =A0drivers/iio/magnetometer/st_magn_core.c | =A0 18 +++++++++---------=
<br>
&gt; =A01 file changed, 9 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/mag=
netometer/st_magn_core.c<br>
&gt; index e8d2849..cab3bc7 100644<br>
&gt; --- a/drivers/iio/magnetometer/st_magn_core.c<br>
&gt; +++ b/drivers/iio/magnetometer/st_magn_core.c<br>
&gt; @@ -29,9 +29,9 @@<br>
&gt; =A0#define ST_MAGN_NUMBER_DATA_CHANNELS =A0 =A0 =A0 =A0 3<br>
&gt;<br>
&gt; =A0/* DEFAULT VALUE FOR SENSORS */<br>
&gt; -#define ST_MAGN_DEFAULT_OUT_X_L_ADDR =A0 =A0 =A0 =A0 0X04<br>
&gt; -#define ST_MAGN_DEFAULT_OUT_Y_L_ADDR =A0 =A0 =A0 =A0 0X08<br>
&gt; -#define ST_MAGN_DEFAULT_OUT_Z_L_ADDR =A0 =A0 =A0 =A0 0X06<br>
&gt; +#define ST_MAGN_DEFAULT_OUT_X_H_ADDR =A0 =A0 =A0 =A0 0X03<br>
&gt; +#define ST_MAGN_DEFAULT_OUT_Y_H_ADDR =A0 =A0 =A0 =A0 0X07<br>
&gt; +#define ST_MAGN_DEFAULT_OUT_Z_H_ADDR =A0 =A0 =A0 =A0 0X05<br>
&gt;<br>
&gt; =A0/* FULLSCALE */<br>
&gt; =A0#define ST_MAGN_FS_AVL_1300MG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A01300<br>
&gt; @@ -117,16 +117,16 @@<br>
&gt; =A0static const struct iio_chan_spec st_magn_16bit_channels[] =3D {<br=
>
&gt; =A0 =A0 =A0 ST_SENSORS_LSM_CHANNELS(IIO_MAGN,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(IIO_CHAN_INFO_RAW) | B=
IT(IIO_CHAN_INFO_SCALE),<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_SENSORS_SCAN_X, 1, IIO_MO=
D_X, &#39;s&#39;, IIO_LE, 16, 16,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_MAGN_DEFAULT_OUT_X_L_ADDR=
),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_SENSORS_SCAN_X, 1, IIO_MO=
D_X, &#39;s&#39;, IIO_BE, 16, 16,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_MAGN_DEFAULT_OUT_X_H_ADDR=
),<br>
&gt; =A0 =A0 =A0 ST_SENSORS_LSM_CHANNELS(IIO_MAGN,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(IIO_CHAN_INFO_RAW) | B=
IT(IIO_CHAN_INFO_SCALE),<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_SENSORS_SCAN_Y, 1, IIO_MO=
D_Y, &#39;s&#39;, IIO_LE, 16, 16,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_MAGN_DEFAULT_OUT_Y_L_ADDR=
),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_SENSORS_SCAN_Y, 1, IIO_MO=
D_Y, &#39;s&#39;, IIO_BE, 16, 16,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_MAGN_DEFAULT_OUT_Y_H_ADDR=
),<br>
&gt; =A0 =A0 =A0 ST_SENSORS_LSM_CHANNELS(IIO_MAGN,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(IIO_CHAN_INFO_RAW) | B=
IT(IIO_CHAN_INFO_SCALE),<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_SENSORS_SCAN_Z, 1, IIO_MO=
D_Z, &#39;s&#39;, IIO_LE, 16, 16,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_MAGN_DEFAULT_OUT_Z_L_ADDR=
),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_SENSORS_SCAN_Z, 1, IIO_MO=
D_Z, &#39;s&#39;, IIO_BE, 16, 16,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ST_MAGN_DEFAULT_OUT_Z_H_ADDR=
),<br>
&gt; =A0 =A0 =A0 IIO_CHAN_SOFT_TIMESTAMP(3)<br>
&gt; =A0};<br>
&gt;<br>
&gt;<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</blockquote></div>

--001a11c29f4099f80204e770c31a--
