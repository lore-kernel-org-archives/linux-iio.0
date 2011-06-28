Return-Path: <bfreed@google.com>
MIME-Version: 1.0
Sender: bfreed@google.com
In-Reply-To: <1309299480.10209.13.camel@rklein-linux2>
References: <1309298401-8623-1-git-send-email-bfreed@chromium.org>
	<1309299480.10209.13.camel@rklein-linux2>
Date: Tue, 28 Jun 2011 16:10:46 -0700
Message-ID: <CAEYUcX1XwSN4n2Xy56AD9tY7yNfpDN+gsB0Uff+qXsMFzemqFw@mail.gmail.com>
Subject: Re: [PATCH] light sensor: Add a calibscale file to the isl29018 light
 sensor driver.
From: Bryan Freed <bfreed@chromium.org>
To: Rhyland Klein <rklein@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "gregkh@suse.de" <gregkh@suse.de>,
        "arnd@arndb.de" <arnd@arndb.de>
Content-Type: multipart/alternative; boundary=0015174c448c2ea38404a6cdc7ee
List-ID: <linux-iio@vger.kernel.org>

--0015174c448c2ea38404a6cdc7ee
Content-Type: text/plain; charset=ISO-8859-1

Hi Rhyland.

On Tue, Jun 28, 2011 at 3:18 PM, Rhyland Klein <rklein@nvidia.com> wrote:

> On Tue, 2011-06-28 at 15:00 -0700, Bryan Freed wrote:
> > Defaulting to 1, this gives a way to amplify the lux value before being
> > reduced by the programmed adc_bit shift.
> > Only support whole numbers right now.  When this driver is converted to
> the new
> > IIO_CHAN framework, it will be easy to support the framework's pseudo
> float.
> >
> > Signed-off-by: Bryan Freed <bfreed@chromium.org>
> > ---
> >  drivers/staging/iio/light/isl29018.c |   35
> +++++++++++++++++++++++++++++++++-
> >  1 files changed, 34 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/staging/iio/light/isl29018.c
> b/drivers/staging/iio/light/isl29018.c
> > index 4794ffd..cd88311 100644
> > --- a/drivers/staging/iio/light/isl29018.c
> > +++ b/drivers/staging/iio/light/isl29018.c
> > @@ -57,6 +57,7 @@ struct isl29018_chip {
> >       struct iio_dev          *indio_dev;
> >       struct i2c_client       *client;
> >       struct mutex            lock;
> > +     unsigned int            lux_scale;
> >       unsigned int            range;
> >       unsigned int            adc_bit;
> >       int                     prox_scheme;
> > @@ -166,7 +167,7 @@ static int isl29018_read_lux(struct i2c_client
> *client, int *lux)
> >       if (lux_data < 0)
> >               return lux_data;
> >
> > -     *lux = (lux_data * chip->range) >> chip->adc_bit;
> > +     *lux = (lux_data * chip->range * chip->lux_scale) >> chip->adc_bit;
>
> This calibscale property changes the output of the _input property.
> Properties defined with _input I believe are designed to return values
> in SI units. Wouldn't changing the scale, say to 1000, change the units
> from like lux to say kilolux? Wouldn't it be more appropriate then to
> return this calibrated value through illuminance_raw ?
>

Yes, setting it to 1000 will give something like kilolux.  But putting the
sensor under a glass that filters out 99.9% of the light returns the result
to real SI units.  The addition of this file lets us tune each system to
account for its Industrial Design (ie, glass and bezel hole).


> >
> >       return 0;
> >  }
> > @@ -264,6 +265,34 @@ static ssize_t get_sensor_data(struct device *dev,
> char *buf, int mode)
> >  }
> >
> >  /* Sysfs interface */
> > +/* lux_scale */
> > +static ssize_t show_lux_scale(struct device *dev,
> > +                     struct device_attribute *attr, char *buf)
> > +{
> > +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +     struct isl29018_chip *chip = indio_dev->dev_data;
> > +
> > +     return sprintf(buf, "%d\n", chip->lux_scale);
> > +}
> > +
> > +static ssize_t store_lux_scale(struct device *dev,
> > +             struct device_attribute *attr, const char *buf, size_t
> count)
> > +{
> > +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +     struct isl29018_chip *chip = indio_dev->dev_data;
> > +     unsigned long lval;
> > +
> > +     lval = simple_strtoul(buf, NULL, 10);
> > +     if (lval == 0)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&chip->lock);
> > +     chip->lux_scale = lval;
> > +     mutex_unlock(&chip->lock);
> > +
> > +     return count;
> > +}
> > +
> >  /* range */
> >  static ssize_t show_range(struct device *dev,
> >                       struct device_attribute *attr, char *buf)
> > @@ -412,6 +441,8 @@ static
> IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_supression,
> >                                       show_prox_infrared_supression,
> >                                       store_prox_infrared_supression, 0);
> >  static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO, show_lux, NULL, 0);
> > +static IIO_DEVICE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,
> > +                                     show_lux_scale, store_lux_scale,
> 0);
> >  static IIO_DEVICE_ATTR(intensity_infrared_raw, S_IRUGO, show_ir, NULL,
> 0);
> >  static IIO_DEVICE_ATTR(proximity_raw, S_IRUGO, show_proxim_ir, NULL, 0);
> >
> > @@ -424,6 +455,7 @@ static struct attribute *isl29018_attributes[] = {
> >       ISL29018_CONST_ATTR(adc_resolution_available),
> >       ISL29018_DEV_ATTR(proximity_on_chip_ambient_infrared_supression),
> >       ISL29018_DEV_ATTR(illuminance0_input),
> > +     ISL29018_DEV_ATTR(illuminance0_calibscale),
> >       ISL29018_DEV_ATTR(intensity_infrared_raw),
> >       ISL29018_DEV_ATTR(proximity_raw),
> >       NULL
> > @@ -478,6 +510,7 @@ static int __devinit isl29018_probe(struct i2c_client
> *client,
> >
> >       mutex_init(&chip->lock);
> >
> > +     chip->lux_scale = 1;
> >       chip->range = 1000;
> >       chip->adc_bit = 16;
> >
>
> Also, please update
> drivers/staging/iio/Documentation/sysfs-bus-iio-light with definitions
> for the calibscale property so that it is properly documented there.
>

I will actually put it in sysfs-bus-iio since that is where all the other
*_calibscale files are described.

bryan.


>
> -rhyland
>
>

--0015174c448c2ea38404a6cdc7ee
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">Hi Rhyland.</div><div class=3D"gmail_quote"><br>=
</div><div class=3D"gmail_quote">On Tue, Jun 28, 2011 at 3:18 PM, Rhyland K=
lein <span dir=3D"ltr">&lt;<a href=3D"mailto:rklein@nvidia.com">rklein@nvid=
ia.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On Tue, 2=
011-06-28 at 15:00 -0700, Bryan Freed wrote:<br>
&gt; Defaulting to 1, this gives a way to amplify the lux value before bein=
g<br>
&gt; reduced by the programmed adc_bit shift.<br>
&gt; Only support whole numbers right now. =A0When this driver is converted=
 to the new<br>
&gt; IIO_CHAN framework, it will be easy to support the framework&#39;s pse=
udo float.<br>
&gt;<br>
&gt; Signed-off-by: Bryan Freed &lt;<a href=3D"mailto:bfreed@chromium.org">=
bfreed@chromium.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/staging/iio/light/isl29018.c | =A0 35 +++++++++++++++++++++=
++++++++++++-<br>
&gt; =A01 files changed, 34 insertions(+), 1 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/ii=
o/light/isl29018.c<br>
&gt; index 4794ffd..cd88311 100644<br>
&gt; --- a/drivers/staging/iio/light/isl29018.c<br>
&gt; +++ b/drivers/staging/iio/light/isl29018.c<br>
&gt; @@ -57,6 +57,7 @@ struct isl29018_chip {<br>
&gt; =A0 =A0 =A0 struct iio_dev =A0 =A0 =A0 =A0 =A0*indio_dev;<br>
&gt; =A0 =A0 =A0 struct i2c_client =A0 =A0 =A0 *client;<br>
&gt; =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0lock;<br>
&gt; + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0lux_scale;<br>
&gt; =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0range;<br>
&gt; =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0adc_bit;<br>
&gt; =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prox_scheme;<b=
r>
&gt; @@ -166,7 +167,7 @@ static int isl29018_read_lux(struct i2c_client *cl=
ient, int *lux)<br>
&gt; =A0 =A0 =A0 if (lux_data &lt; 0)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return lux_data;<br>
&gt;<br>
&gt; - =A0 =A0 *lux =3D (lux_data * chip-&gt;range) &gt;&gt; chip-&gt;adc_b=
it;<br>
&gt; + =A0 =A0 *lux =3D (lux_data * chip-&gt;range * chip-&gt;lux_scale) &g=
t;&gt; chip-&gt;adc_bit;<br>
<br>
</div></div>This calibscale property changes the output of the _input prope=
rty.<br>
Properties defined with _input I believe are designed to return values<br>
in SI units. Wouldn&#39;t changing the scale, say to 1000, change the units=
<br>
from like lux to say kilolux? Wouldn&#39;t it be more appropriate then to<b=
r>
return this calibrated value through illuminance_raw ?<br></blockquote><div=
><br></div><div>Yes, setting it to 1000 will give something like kilolux. =
=A0But putting the sensor under a glass that filters out 99.9% of the light=
 returns the result to real SI units. =A0The addition of this file lets us =
tune each system to account for its Industrial Design (ie, glass and bezel =
hole).</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex;">
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; =A0 =A0 =A0 return 0;<br>
&gt; =A0}<br>
&gt; @@ -264,6 +265,34 @@ static ssize_t get_sensor_data(struct device *dev=
, char *buf, int mode)<br>
&gt; =A0}<br>
&gt;<br>
&gt; =A0/* Sysfs interface */<br>
&gt; +/* lux_scale */<br>
&gt; +static ssize_t show_lux_scale(struct device *dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *att=
r, char *buf)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<br>
&gt; + =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;dev_data;<br>
&gt; +<br>
&gt; + =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, chip-&gt;lux_scale);<b=
r>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t store_lux_scale(struct device *dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const char *b=
uf, size_t count)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<br>
&gt; + =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;dev_data;<br>
&gt; + =A0 =A0 unsigned long lval;<br>
&gt; +<br>
&gt; + =A0 =A0 lval =3D simple_strtoul(buf, NULL, 10);<br>
&gt; + =A0 =A0 if (lval =3D=3D 0)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 mutex_lock(&amp;chip-&gt;lock);<br>
&gt; + =A0 =A0 chip-&gt;lux_scale =3D lval;<br>
&gt; + =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
&gt; +<br>
&gt; + =A0 =A0 return count;<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0/* range */<br>
&gt; =A0static ssize_t show_range(struct device *dev,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *a=
ttr, char *buf)<br>
&gt; @@ -412,6 +441,8 @@ static IIO_DEVICE_ATTR(proximity_on_chip_ambient_i=
nfrared_supression,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 show_prox_infrared_supression,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 store_prox_infrared_supression, 0);<br>
&gt; =A0static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO, show_lux, NULL,=
 0);<br>
&gt; +static IIO_DEVICE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,<br=
>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 show_lux_scale, store_lux_scale, 0);<br>
&gt; =A0static IIO_DEVICE_ATTR(intensity_infrared_raw, S_IRUGO, show_ir, NU=
LL, 0);<br>
&gt; =A0static IIO_DEVICE_ATTR(proximity_raw, S_IRUGO, show_proxim_ir, NULL=
, 0);<br>
&gt;<br>
&gt; @@ -424,6 +455,7 @@ static struct attribute *isl29018_attributes[] =3D=
 {<br>
&gt; =A0 =A0 =A0 ISL29018_CONST_ATTR(adc_resolution_available),<br>
&gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(proximity_on_chip_ambient_infrared_supre=
ssion),<br>
&gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(illuminance0_input),<br>
&gt; + =A0 =A0 ISL29018_DEV_ATTR(illuminance0_calibscale),<br>
&gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(intensity_infrared_raw),<br>
&gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(proximity_raw),<br>
&gt; =A0 =A0 =A0 NULL<br>
&gt; @@ -478,6 +510,7 @@ static int __devinit isl29018_probe(struct i2c_cli=
ent *client,<br>
&gt;<br>
&gt; =A0 =A0 =A0 mutex_init(&amp;chip-&gt;lock);<br>
&gt;<br>
&gt; + =A0 =A0 chip-&gt;lux_scale =3D 1;<br>
&gt; =A0 =A0 =A0 chip-&gt;range =3D 1000;<br>
&gt; =A0 =A0 =A0 chip-&gt;adc_bit =3D 16;<br>
&gt;<br>
<br>
</div></div>Also, please update<br>
drivers/staging/iio/Documentation/sysfs-bus-iio-light with definitions<br>
for the calibscale property so that it is properly documented there.<br></b=
lockquote><div><br></div><div>I will actually put it in sysfs-bus-iio since=
 that is where all the other *_calibscale files are described.</div><div>
<br></div><div>bryan.</div><div>=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<font color=3D"#888888"><br>
-rhyland<br>
<br>
</font></blockquote></div><br>

--0015174c448c2ea38404a6cdc7ee--
