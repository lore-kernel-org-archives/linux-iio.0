Return-Path: <bfreed@google.com>
MIME-Version: 1.0
Sender: bfreed@google.com
In-Reply-To: <1309978586-10092-3-git-send-email-bfreed@chromium.org>
References: <1309978586-10092-1-git-send-email-bfreed@chromium.org>
	<1309978586-10092-3-git-send-email-bfreed@chromium.org>
Date: Wed, 6 Jul 2011 11:59:23 -0700
Message-ID: <CAEYUcX0uypn2PjeVG6qVgT28f9z-JcKDABjcyav0kv3Nqb9Dgg@mail.gmail.com>
Subject: Re: [PATCH 3/3] staging:iio:light:isl29018: Convert some of the
 isl29018 driver to the new IIO_CHAN framework.
From: Bryan Freed <bfreed@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: jic23@cam.ac.uk, gregkh@suse.de, rklein@nvidia.com,
        linux-iio@vger.kernel.org, Bryan Freed <bfreed@chromium.org>
Content-Type: multipart/alternative; boundary=000e0cd70d96d82ca804a76b32e0
List-ID: <linux-iio@vger.kernel.org>

--000e0cd70d96d82ca804a76b32e0
Content-Type: text/plain; charset=ISO-8859-1

Criminy!

I failed to address the problems previously requested.  So this this one
still needs a bit of work.

bryan.

On Wed, Jul 6, 2011 at 11:56 AM, Bryan Freed <bfreed@chromium.org> wrote:

> Remove the driver's get_sensor_data() interfaces and replace them with
> IIO_CHAN channels.  This converts 4 files to the new framework.
> Driver ABI change: The intensity_infrared_raw file is now intensity_ir_raw.
>
> Signed-off-by: Bryan Freed <bfreed@chromium.org>
> ---
>  drivers/staging/iio/light/isl29018.c |  159
> +++++++++++++++-------------------
>  1 files changed, 69 insertions(+), 90 deletions(-)
>
> diff --git a/drivers/staging/iio/light/isl29018.c
> b/drivers/staging/iio/light/isl29018.c
> index cd88311..aac4e39 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -225,74 +225,7 @@ static int isl29018_read_proximity_ir(struct
> i2c_client *client, int scheme,
>        return 0;
>  }
>
> -static ssize_t get_sensor_data(struct device *dev, char *buf, int mode)
> -{
> -       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -       struct isl29018_chip *chip = indio_dev->dev_data;
> -       struct i2c_client *client = chip->client;
> -       int value = 0;
> -       int status;
> -
> -       mutex_lock(&chip->lock);
> -       switch (mode) {
> -       case COMMMAND1_OPMODE_PROX_ONCE:
> -               status = isl29018_read_proximity_ir(client,
> -                               chip->prox_scheme, &value);
> -               break;
> -
> -       case COMMMAND1_OPMODE_ALS_ONCE:
> -               status = isl29018_read_lux(client, &value);
> -               break;
> -
> -       case COMMMAND1_OPMODE_IR_ONCE:
> -               status = isl29018_read_ir(client, &value);
> -               break;
> -
> -       default:
> -               dev_err(&client->dev, "Mode %d is not supported\n", mode);
> -               mutex_unlock(&chip->lock);
> -               return -EBUSY;
> -       }
> -       if (status < 0) {
> -               dev_err(&client->dev, "Error in Reading data");
> -               mutex_unlock(&chip->lock);
> -               return status;
> -       }
> -
> -       mutex_unlock(&chip->lock);
> -
> -       return sprintf(buf, "%d\n", value);
> -}
> -
>  /* Sysfs interface */
> -/* lux_scale */
> -static ssize_t show_lux_scale(struct device *dev,
> -                       struct device_attribute *attr, char *buf)
> -{
> -       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -       struct isl29018_chip *chip = indio_dev->dev_data;
> -
> -       return sprintf(buf, "%d\n", chip->lux_scale);
> -}
> -
> -static ssize_t store_lux_scale(struct device *dev,
> -               struct device_attribute *attr, const char *buf, size_t
> count)
> -{
> -       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -       struct isl29018_chip *chip = indio_dev->dev_data;
> -       unsigned long lval;
> -
> -       lval = simple_strtoul(buf, NULL, 10);
> -       if (lval == 0)
> -               return -EINVAL;
> -
> -       mutex_lock(&chip->lock);
> -       chip->lux_scale = lval;
> -       mutex_unlock(&chip->lock);
> -
> -       return count;
> -}
> -
>  /* range */
>  static ssize_t show_range(struct device *dev,
>                        struct device_attribute *attr, char *buf)
> @@ -410,27 +343,78 @@ static ssize_t store_prox_infrared_supression(struct
> device *dev,
>        return count;
>  }
>
> -/* Read lux */
> -static ssize_t show_lux(struct device *dev,
> -               struct device_attribute *devattr, char *buf)
> +/* Channel IO */
> +static int isl29018_write_raw(struct iio_dev *indio_dev,
> +                             struct iio_chan_spec const *chan,
> +                             int val,
> +                             int val2,
> +                             long mask)
>  {
> -       return get_sensor_data(dev, buf, COMMMAND1_OPMODE_ALS_ONCE);
> -}
> +       struct isl29018_chip *chip = indio_dev->dev_data;
> +       int ret = -EINVAL;
>
> -/* Read ir */
> -static ssize_t show_ir(struct device *dev,
> -               struct device_attribute *devattr, char *buf)
> -{
> -       return get_sensor_data(dev, buf, COMMMAND1_OPMODE_IR_ONCE);
> +       mutex_lock(&chip->lock);
> +       if (mask == (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) &&
> +           chan->type == IIO_LIGHT) {
> +               chip->lux_scale = val;
> +               ret = 0;
> +       }
> +       mutex_unlock(&chip->lock);
> +
> +       return 0;
>  }
>
> -/* Read nearest ir */
> -static ssize_t show_proxim_ir(struct device *dev,
> -               struct device_attribute *devattr, char *buf)
> +static int isl29018_read_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int *val,
> +                            int *val2,
> +                            long mask)
>  {
> -       return get_sensor_data(dev, buf, COMMMAND1_OPMODE_PROX_ONCE);
> +       int ret = -EINVAL;
> +       struct isl29018_chip *chip = indio_dev->dev_data;
> +       struct i2c_client *client = chip->client;
> +
> +       mutex_lock(&chip->lock);
> +       switch (mask) {
> +       case 0:
> +               switch (chan->type) {
> +               case IIO_LIGHT:
> +                       ret = isl29018_read_lux(client, val);
> +                       break;
> +               case IIO_INTENSITY:
> +                       ret = isl29018_read_ir(client, val);
> +                       break;
> +               case IIO_PROXIMITY:
> +                       ret = isl29018_read_proximity_ir(client,
> +                                       chip->prox_scheme, val);
> +                       break;
> +               default:
> +                       break;
> +               }
> +               if (!ret)
> +                       ret = IIO_VAL_INT;
> +               break;
> +       case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
> +               if (chan->type == IIO_LIGHT) {
> +                       *val = chip->lux_scale;
> +                       ret = IIO_VAL_INT;
> +               }
> +               break;
> +       default:
> +               break;
> +       }
> +       mutex_unlock(&chip->lock);
> +       return ret;
>  }
>
> +#define LIGHT_INFO_MASK (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE)
> +static const struct iio_chan_spec isl29018_channels[] = {
> +       IIO_CHAN(IIO_LIGHT,     0, 1, 1, NULL, 0, 0, LIGHT_INFO_MASK,
> +                                                       0, 0, {}, 0),
> +       IIO_CHAN(IIO_INTENSITY, 1, 0, 0, NULL, 0, 1, 0, 0, 0, {}, 0),
> +       IIO_CHAN(IIO_PROXIMITY, 0, 0, 0, NULL, 0, 0, 0, 0, 0, {}, 0),
> +};
> +
>  static IIO_DEVICE_ATTR(range, S_IRUGO | S_IWUSR, show_range, store_range,
> 0);
>  static IIO_CONST_ATTR(range_available, "1000 4000 16000 64000");
>  static IIO_CONST_ATTR(adc_resolution_available, "4 8 12 16");
> @@ -440,11 +424,6 @@ static
> IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_supression,
>                                        S_IRUGO | S_IWUSR,
>                                        show_prox_infrared_supression,
>                                        store_prox_infrared_supression, 0);
> -static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO, show_lux, NULL, 0);
> -static IIO_DEVICE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,
> -                                       show_lux_scale, store_lux_scale,
> 0);
> -static IIO_DEVICE_ATTR(intensity_infrared_raw, S_IRUGO, show_ir, NULL, 0);
> -static IIO_DEVICE_ATTR(proximity_raw, S_IRUGO, show_proxim_ir, NULL, 0);
>
>  #define ISL29018_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
>  #define ISL29018_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
> @@ -454,10 +433,6 @@ static struct attribute *isl29018_attributes[] = {
>        ISL29018_DEV_ATTR(adc_resolution),
>        ISL29018_CONST_ATTR(adc_resolution_available),
>        ISL29018_DEV_ATTR(proximity_on_chip_ambient_infrared_supression),
> -       ISL29018_DEV_ATTR(illuminance0_input),
> -       ISL29018_DEV_ATTR(illuminance0_calibscale),
> -       ISL29018_DEV_ATTR(intensity_infrared_raw),
> -       ISL29018_DEV_ATTR(proximity_raw),
>        NULL
>  };
>
> @@ -490,6 +465,8 @@ static int isl29018_chip_init(struct i2c_client
> *client)
>  static const struct iio_info isl29108_info = {
>        .attrs = &isl29108_group,
>        .driver_module = THIS_MODULE,
> +       .read_raw = &isl29018_read_raw,
> +       .write_raw = &isl29018_write_raw,
>  };
>
>  static int __devinit isl29018_probe(struct i2c_client *client,
> @@ -524,6 +501,8 @@ static int __devinit isl29018_probe(struct i2c_client
> *client,
>                goto exit_free;
>        }
>        chip->indio_dev->info = &isl29108_info;
> +       chip->indio_dev->channels = isl29018_channels;
> +       chip->indio_dev->num_channels = ARRAY_SIZE(isl29018_channels);
>        chip->indio_dev->name = id->name;
>        chip->indio_dev->dev.parent = &client->dev;
>        chip->indio_dev->dev_data = (void *)(chip);
> --
> 1.7.3.1
>
>

--000e0cd70d96d82ca804a76b32e0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Criminy!<div><br></div><div>I failed to address the problems previously req=
uested. =A0So this this one still needs a bit of work.</div><div><br></div>=
<div>bryan.<br><br><div class=3D"gmail_quote">On Wed, Jul 6, 2011 at 11:56 =
AM, Bryan Freed <span dir=3D"ltr">&lt;<a href=3D"mailto:bfreed@chromium.org=
">bfreed@chromium.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Remove the driver&#39;s get_sensor_data() i=
nterfaces and replace them with<br>
IIO_CHAN channels. =A0This converts 4 files to the new framework.<br>
Driver ABI change: The intensity_infrared_raw file is now intensity_ir_raw.=
<br>
<br>
Signed-off-by: Bryan Freed &lt;<a href=3D"mailto:bfreed@chromium.org">bfree=
d@chromium.org</a>&gt;<br>
---<br>
=A0drivers/staging/iio/light/isl29018.c | =A0159 +++++++++++++++-----------=
--------<br>
=A01 files changed, 69 insertions(+), 90 deletions(-)<br>
<br>
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/lig=
ht/isl29018.c<br>
index cd88311..aac4e39 100644<br>
--- a/drivers/staging/iio/light/isl29018.c<br>
+++ b/drivers/staging/iio/light/isl29018.c<br>
@@ -225,74 +225,7 @@ static int isl29018_read_proximity_ir(struct i2c_clien=
t *client, int scheme,<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
<br>
-static ssize_t get_sensor_data(struct device *dev, char *buf, int mode)<br=
>
-{<br>
- =A0 =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<br>
- =A0 =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;dev_data;<br>
- =A0 =A0 =A0 struct i2c_client *client =3D chip-&gt;client;<br>
- =A0 =A0 =A0 int value =3D 0;<br>
- =A0 =A0 =A0 int status;<br>
-<br>
- =A0 =A0 =A0 mutex_lock(&amp;chip-&gt;lock);<br>
- =A0 =A0 =A0 switch (mode) {<br>
- =A0 =A0 =A0 case COMMMAND1_OPMODE_PROX_ONCE:<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D isl29018_read_proximity_ir(client,=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip-&gt;prox=
_scheme, &amp;value);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
-<br>
- =A0 =A0 =A0 case COMMMAND1_OPMODE_ALS_ONCE:<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D isl29018_read_lux(client, &amp;val=
ue);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
-<br>
- =A0 =A0 =A0 case COMMMAND1_OPMODE_IR_ONCE:<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D isl29018_read_ir(client, &amp;valu=
e);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
-<br>
- =A0 =A0 =A0 default:<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;client-&gt;dev, &quot;Mode %d is=
 not supported\n&quot;, mode);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;<br>
- =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 if (status &lt; 0) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;client-&gt;dev, &quot;Error in R=
eading data&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
-<br>
- =A0 =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, value);<br>
-}<br>
-<br>
=A0/* Sysfs interface */<br>
-/* lux_scale */<br>
-static ssize_t show_lux_scale(struct device *dev,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr=
, char *buf)<br>
-{<br>
- =A0 =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<br>
- =A0 =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;dev_data;<br>
-<br>
- =A0 =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, chip-&gt;lux_scale);<br=
>
-}<br>
-<br>
-static ssize_t store_lux_scale(struct device *dev,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const char *bu=
f, size_t count)<br>
-{<br>
- =A0 =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<br>
- =A0 =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;dev_data;<br>
- =A0 =A0 =A0 unsigned long lval;<br>
-<br>
- =A0 =A0 =A0 lval =3D simple_strtoul(buf, NULL, 10);<br>
- =A0 =A0 =A0 if (lval =3D=3D 0)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
-<br>
- =A0 =A0 =A0 mutex_lock(&amp;chip-&gt;lock);<br>
- =A0 =A0 =A0 chip-&gt;lux_scale =3D lval;<br>
- =A0 =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
-<br>
- =A0 =A0 =A0 return count;<br>
-}<br>
-<br>
=A0/* range */<br>
=A0static ssize_t show_range(struct device *dev,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *at=
tr, char *buf)<br>
@@ -410,27 +343,78 @@ static ssize_t store_prox_infrared_supression(struct =
device *dev,<br>
 =A0 =A0 =A0 =A0return count;<br>
=A0}<br>
<br>
-/* Read lux */<br>
-static ssize_t show_lux(struct device *dev,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, char *buf)<=
br>
+/* Channel IO */<br>
+static int isl29018_write_raw(struct iio_dev *indio_dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct iio_chan_s=
pec const *chan,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int val,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int val2,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 long mask)<br>
=A0{<br>
- =A0 =A0 =A0 return get_sensor_data(dev, buf, COMMMAND1_OPMODE_ALS_ONCE);<=
br>
-}<br>
+ =A0 =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;dev_data;<br>
+ =A0 =A0 =A0 int ret =3D -EINVAL;<br>
<br>
-/* Read ir */<br>
-static ssize_t show_ir(struct device *dev,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, char *buf)<=
br>
-{<br>
- =A0 =A0 =A0 return get_sensor_data(dev, buf, COMMMAND1_OPMODE_IR_ONCE);<b=
r>
+ =A0 =A0 =A0 mutex_lock(&amp;chip-&gt;lock);<br>
+ =A0 =A0 =A0 if (mask =3D=3D (1 &lt;&lt; IIO_CHAN_INFO_CALIBSCALE_SEPARATE=
) &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 chan-&gt;type =3D=3D IIO_LIGHT) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip-&gt;lux_scale =3D val;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
=A0}<br>
<br>
-/* Read nearest ir */<br>
-static ssize_t show_proxim_ir(struct device *dev,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, char *buf)<=
br>
+static int isl29018_read_raw(struct iio_dev *indio_dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct iio_chan_sp=
ec const *chan,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *val,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *val2,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long mask)<br>
=A0{<br>
- =A0 =A0 =A0 return get_sensor_data(dev, buf, COMMMAND1_OPMODE_PROX_ONCE);=
<br>
+ =A0 =A0 =A0 int ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;dev_data;<br>
+ =A0 =A0 =A0 struct i2c_client *client =3D chip-&gt;client;<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;chip-&gt;lock);<br>
+ =A0 =A0 =A0 switch (mask) {<br>
+ =A0 =A0 =A0 case 0:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (chan-&gt;type) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 case IIO_LIGHT:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D isl29018_read_lux(cli=
ent, val);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 case IIO_INTENSITY:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D isl29018_read_ir(clie=
nt, val);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 case IIO_PROXIMITY:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D isl29018_read_proximi=
ty_ir(client,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 chip-&gt;prox_scheme, val);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D IIO_VAL_INT;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case (1 &lt;&lt; IIO_CHAN_INFO_CALIBSCALE_SEPARATE):<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chan-&gt;type =3D=3D IIO_LIGHT) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val =3D chip-&gt;lux_scale;<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D IIO_VAL_INT;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
+ =A0 =A0 =A0 return ret;<br>
=A0}<br>
<br>
+#define LIGHT_INFO_MASK (1 &lt;&lt; IIO_CHAN_INFO_CALIBSCALE_SEPARATE)<br>
+static const struct iio_chan_spec isl29018_channels[] =3D {<br>
+ =A0 =A0 =A0 IIO_CHAN(IIO_LIGHT, =A0 =A0 0, 1, 1, NULL, 0, 0, LIGHT_INFO_M=
ASK,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, 0, {}, 0),<br>
+ =A0 =A0 =A0 IIO_CHAN(IIO_INTENSITY, 1, 0, 0, NULL, 0, 1, 0, 0, 0, {}, 0),=
<br>
+ =A0 =A0 =A0 IIO_CHAN(IIO_PROXIMITY, 0, 0, 0, NULL, 0, 0, 0, 0, 0, {}, 0),=
<br>
+};<br>
+<br>
=A0static IIO_DEVICE_ATTR(range, S_IRUGO | S_IWUSR, show_range, store_range=
, 0);<br>
=A0static IIO_CONST_ATTR(range_available, &quot;1000 4000 16000 64000&quot;=
);<br>
=A0static IIO_CONST_ATTR(adc_resolution_available, &quot;4 8 12 16&quot;);<=
br>
@@ -440,11 +424,6 @@ static IIO_DEVICE_ATTR(proximity_on_chip_ambient_infra=
red_supression,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0S_IRUGO | S_IWUSR,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0show_prox_infrared_supression,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0store_prox_infrared_supression, 0);<br>
-static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO, show_lux, NULL, 0);<br=
>
-static IIO_DEVICE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 show_lux_scale, store_lux_scale, 0);<br>
-static IIO_DEVICE_ATTR(intensity_infrared_raw, S_IRUGO, show_ir, NULL, 0);=
<br>
-static IIO_DEVICE_ATTR(proximity_raw, S_IRUGO, show_proxim_ir, NULL, 0);<b=
r>
<br>
=A0#define ISL29018_DEV_ATTR(name) (&amp;iio_dev_attr_##name.dev_attr.attr)=
<br>
=A0#define ISL29018_CONST_ATTR(name) (&amp;iio_const_attr_##name.dev_attr.a=
ttr)<br>
@@ -454,10 +433,6 @@ static struct attribute *isl29018_attributes[] =3D {<b=
r>
 =A0 =A0 =A0 =A0ISL29018_DEV_ATTR(adc_resolution),<br>
 =A0 =A0 =A0 =A0ISL29018_CONST_ATTR(adc_resolution_available),<br>
 =A0 =A0 =A0 =A0ISL29018_DEV_ATTR(proximity_on_chip_ambient_infrared_supres=
sion),<br>
- =A0 =A0 =A0 ISL29018_DEV_ATTR(illuminance0_input),<br>
- =A0 =A0 =A0 ISL29018_DEV_ATTR(illuminance0_calibscale),<br>
- =A0 =A0 =A0 ISL29018_DEV_ATTR(intensity_infrared_raw),<br>
- =A0 =A0 =A0 ISL29018_DEV_ATTR(proximity_raw),<br>
 =A0 =A0 =A0 =A0NULL<br>
=A0};<br>
<br>
@@ -490,6 +465,8 @@ static int isl29018_chip_init(struct i2c_client *client=
)<br>
=A0static const struct iio_info isl29108_info =3D {<br>
 =A0 =A0 =A0 =A0.attrs =3D &amp;isl29108_group,<br>
 =A0 =A0 =A0 =A0.driver_module =3D THIS_MODULE,<br>
+ =A0 =A0 =A0 .read_raw =3D &amp;isl29018_read_raw,<br>
+ =A0 =A0 =A0 .write_raw =3D &amp;isl29018_write_raw,<br>
=A0};<br>
<br>
=A0static int __devinit isl29018_probe(struct i2c_client *client,<br>
@@ -524,6 +501,8 @@ static int __devinit isl29018_probe(struct i2c_client *=
client,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_free;<br>
 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0chip-&gt;indio_dev-&gt;info =3D &amp;isl29108_info;<br>
+ =A0 =A0 =A0 chip-&gt;indio_dev-&gt;channels =3D isl29018_channels;<br>
+ =A0 =A0 =A0 chip-&gt;indio_dev-&gt;num_channels =3D ARRAY_SIZE(isl29018_c=
hannels);<br>
 =A0 =A0 =A0 =A0chip-&gt;indio_dev-&gt;name =3D id-&gt;name;<br>
 =A0 =A0 =A0 =A0chip-&gt;indio_dev-&gt;dev.parent =3D &amp;client-&gt;dev;<=
br>
 =A0 =A0 =A0 =A0chip-&gt;indio_dev-&gt;dev_data =3D (void *)(chip);<br>
<font color=3D"#888888">--<br>
1.7.3.1<br>
<br>
</font></blockquote></div><br></div>

--000e0cd70d96d82ca804a76b32e0--
