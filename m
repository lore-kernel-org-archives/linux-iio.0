Return-Path: <bfreed@google.com>
MIME-Version: 1.0
Sender: bfreed@google.com
In-Reply-To: <4DF5D0DC.5090205@cam.ac.uk>
References: <1307737580-14131-1-git-send-email-bfreed@chromium.org>
	<4DF5D0DC.5090205@cam.ac.uk>
Date: Wed, 15 Jun 2011 16:49:08 -0700
Message-ID: <BANLkTinPg158f7A7BSZ7v=M3QecZ-1HYLujq5sOjDa32oVDCkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] light sensor: Add a calibration file to the isl29018 driver.
From: Bryan Freed <bfreed@chromium.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Jon Brenner <jbrenner@taosinc.com>,
        gregkh@suse.de, arnd@arndb.de,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: multipart/alternative; boundary=00151750da4468391b04a5c8cce3
List-ID: <linux-iio@vger.kernel.org>

--00151750da4468391b04a5c8cce3
Content-Type: text/plain; charset=ISO-8859-1

Hi Jon.  Thanks for the feedback.

So I took a look at sysfs-bus-iio documentation.
*_calibscale is supposed to be "Hardware applied calibration scale factor."
But what I want is software applied calibration scaling.

tsl2563 provides this with (apparently undocumented)
intensity0_both_calibgain, and tsl2583 provides this (incorrectly, according
to documentation) with illuminance0_calibbias.

As for the iio_chan_spec interface, we are a bit behind you guys in source
drops.  We are at 2.6.38, and that appears to be added in 2.6.39 just before
the switch to 3.0.
I have not found what you mean by pseudo floating point.  Still working on
it.
For Mike's changes, are you referring
to 8a27a023f8f66a8361c5e3d8160a690f480479ec in particular?  He has quite a
few in there.

I see tsl2563 has been updated to use iio_chan_spec.  But the software gain
is still provided by the old intensity0_both_calibgain file.
Should we be moving away from this interface?

bryan.


On Mon, Jun 13, 2011 at 1:57 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:

> cc'd linux-iio
> On 06/10/11 21:26, Bryan Freed wrote:
> > This is the same tuning file used in tsl2583.c.
> > Add documentation for it to sysfs-bus-iio-light.
> > Normalize it at 1024 instead of 1000 so we can avoid 64bit division
> (div_u64).
> > Use u64 so we can do all multiplication before division to avoid loss of
> > granularity on amplified values.
> Hi  Brian.
>
> This attribute is a general IIO one rather than a light specific one so is
> already documented in sysfs-bus-iio.
>
> Now it is supposed to be an offset rather than a gain.  The current docs
> say:
>
> "Hardware applied calibration offset. (assumed to fix production
>  inaccuracies). If shared across all channels, <type>_calibbias
>  is used."
>
> I do note that the illuminance variant isn't actually listed and would be
> happy to have a patch adding it alongside the gyro and accel ones already
> there.
>
> My first issue here is that it supposed to be an offset not a gain.
>  Secondly that
> description could clearly do with amending to make it clear that this can
> be used
> for devices with complex non linear transformations to SI units which is
> what it
> is supposed to be doing here.  In cases where there is no '_raw' output we
> can assume
> something complex may be happening, so changing this value won't result in
> a additive
> change the output.
>
> If we are playing with a gain, then calibscale is the parameter name that
> should be used
> (also a core attribute definition, not a light specific one).
>
> "Hardware applied calibration scale factor. (assumed to fix
>  production inaccuracies).  If shared across all channels,
>  <type>_calibscale is used."
>
> Note all these attributes are defined to be pseudo floating point.  The
> chan_spec approach
> to registration handles this cleanly (particularly with Michael Hennerich's
> additional
> callbacks added last week).  It's a gain, so 1 is the no change value.
> Sorry, but anything
> that assumes 1024 is the no effect value is never going to generalize well
> so is a non starter.
>
> Sorry, I'll be happy to see a patch adding the support you want to the
> isl29018 driver
> but it must conform to the existing abi.  It looks like you may have found
> a discrepancy
> between a driver and the spec, but I'll leave Jon to comment on that.
>
> Jonathan
> >
> > Signed-off-by: Bryan Freed <bfreed@chromium.org>
> > ---
> >  .../staging/iio/Documentation/sysfs-bus-iio-light  |   10 +++++
> >  drivers/staging/iio/light/isl29018.c               |   36
> +++++++++++++++++++-
> >  2 files changed, 45 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> > index 21d2774..704b6c9 100644
> > --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> > +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> > @@ -75,3 +75,13 @@ KernelVersion:     2.6.37
> >  Contact:     linux-iio@vger.kernel.org
> >  Description:
> >               This property gets/sets the sensors ADC analog integration
> time.
> > +
> > +What:
>  /sys/bus/iio/devices/device[n]/illuminance0_calibbias
> > +KernelVersion:       2.6.38
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             This property gets/sets the illuminance0_input
> amplification
> > +             value.  The calculated lux reading is multiplied by this
> value
> > +             and divided by 1024.  Default of 1024 gives no
> amplification.
> > +             This provides compensation for glass or bezel that can
> > +             attenuate the ambient light.
> > diff --git a/drivers/staging/iio/light/isl29018.c
> b/drivers/staging/iio/light/isl29018.c
> > index 4794ffd..a106f16 100644
> > --- a/drivers/staging/iio/light/isl29018.c
> > +++ b/drivers/staging/iio/light/isl29018.c
> > @@ -57,6 +57,7 @@ struct isl29018_chip {
> >       struct iio_dev          *indio_dev;
> >       struct i2c_client       *client;
> >       struct mutex            lock;
> > +     unsigned int            calibbias;
> >       unsigned int            range;
> >       unsigned int            adc_bit;
> >       int                     prox_scheme;
> > @@ -157,6 +158,7 @@ static int isl29018_read_sensor_input(struct
> i2c_client *client, int mode)
> >
> >  static int isl29018_read_lux(struct i2c_client *client, int *lux)
> >  {
> > +     u64 lux64;
> >       int lux_data;
> >       struct isl29018_chip *chip = i2c_get_clientdata(client);
> >
> > @@ -166,7 +168,8 @@ static int isl29018_read_lux(struct i2c_client
> *client, int *lux)
> >       if (lux_data < 0)
> >               return lux_data;
> >
> > -     *lux = (lux_data * chip->range) >> chip->adc_bit;
> > +     lux64 = lux_data * chip->range;
> > +     *lux = (lux64 * chip->calibbias) >> (10 + chip->adc_bit);
> >
> >       return 0;
> >  }
> > @@ -264,6 +267,33 @@ static ssize_t get_sensor_data(struct device *dev,
> char *buf, int mode)
> >  }
> >
> >  /* Sysfs interface */
> > +/* calibbias */
> > +static ssize_t show_calibbias(struct device *dev,
> > +                     struct device_attribute *attr, char *buf)
> > +{
> > +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +     struct isl29018_chip *chip = indio_dev->dev_data;
> > +
> > +     return sprintf(buf, "%u\n", chip->calibbias);
> > +}
> > +
> > +static ssize_t store_calibbias(struct device *dev,
> > +             struct device_attribute *attr, const char *buf, size_t
> count)
> > +{
> > +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +     struct isl29018_chip *chip = indio_dev->dev_data;
> > +     unsigned long lval;
> > +
> > +     if (strict_strtoul(buf, 10, &lval))
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&chip->lock);
> > +     chip->calibbias = lval;
> > +     mutex_unlock(&chip->lock);
> > +
> > +     return count;
> > +}
> > +
> >  /* range */
> >  static ssize_t show_range(struct device *dev,
> >                       struct device_attribute *attr, char *buf)
> > @@ -412,6 +442,8 @@ static
> IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_supression,
> >                                       show_prox_infrared_supression,
> >                                       store_prox_infrared_supression, 0);
> >  static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO, show_lux, NULL, 0);
> > +static IIO_DEVICE_ATTR(illuminance0_calibbias, S_IRUGO | S_IWUSR,
> > +                                     show_calibbias, store_calibbias,
> 0);
> >  static IIO_DEVICE_ATTR(intensity_infrared_raw, S_IRUGO, show_ir, NULL,
> 0);
> >  static IIO_DEVICE_ATTR(proximity_raw, S_IRUGO, show_proxim_ir, NULL, 0);
> >
> > @@ -424,6 +456,7 @@ static struct attribute *isl29018_attributes[] = {
> >       ISL29018_CONST_ATTR(adc_resolution_available),
> >       ISL29018_DEV_ATTR(proximity_on_chip_ambient_infrared_supression),
> >       ISL29018_DEV_ATTR(illuminance0_input),
> > +     ISL29018_DEV_ATTR(illuminance0_calibbias),
> >       ISL29018_DEV_ATTR(intensity_infrared_raw),
> >       ISL29018_DEV_ATTR(proximity_raw),
> >       NULL
> > @@ -478,6 +511,7 @@ static int __devinit isl29018_probe(struct i2c_client
> *client,
> >
> >       mutex_init(&chip->lock);
> >
> > +     chip->calibbias = 1024;
> >       chip->range = 1000;
> >       chip->adc_bit = 16;
> >
>
>

--00151750da4468391b04a5c8cce3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jon. =A0Thanks for the feedback.<div><br></div><div>So I took a look at=
=A0sysfs-bus-iio documentation.<div>*_calibscale is supposed to be &quot;Ha=
rdware applied calibration scale factor.&quot;</div><div>But what I want is=
 software applied calibration scaling.</div>
<div><br></div><div>tsl2563 provides this with (apparently undocumented) in=
tensity0_both_calibgain, and tsl2583 provides this (incorrectly, according =
to documentation) with=A0illuminance0_calibbias.</div><div><br></div><div>
As for the iio_chan_spec interface, we are a bit behind you guys in source =
drops. =A0We are at 2.6.38, and that appears to be added in 2.6.39 just bef=
ore the switch to 3.0.</div><div>I have not found what you mean by pseudo f=
loating point. =A0Still working on it.</div>
<div>For Mike&#39;s changes, are you referring to=A08a27a023f8f66a8361c5e3d=
8160a690f480479ec in particular? =A0He has quite a few in there.</div><div>=
<br></div><div>I see tsl2563 has been updated to use iio_chan_spec. =A0But =
the software gain is still provided by the old=A0intensity0_both_calibgain =
file.</div>
<div>Should we be moving away from this interface?</div><div><br></div><div=
>bryan.</div><div><br><br><div class=3D"gmail_quote">On Mon, Jun 13, 2011 a=
t 1:57 AM, Jonathan Cameron <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@c=
am.ac.uk">jic23@cam.ac.uk</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">cc&#39;d linux-iio<br>
<div class=3D"im">On 06/10/11 21:26, Bryan Freed wrote:<br>
&gt; This is the same tuning file used in tsl2583.c.<br>
&gt; Add documentation for it to sysfs-bus-iio-light.<br>
&gt; Normalize it at 1024 instead of 1000 so we can avoid 64bit division (d=
iv_u64).<br>
&gt; Use u64 so we can do all multiplication before division to avoid loss =
of<br>
&gt; granularity on amplified values.<br>
</div>Hi =A0Brian.<br>
<br>
This attribute is a general IIO one rather than a light specific one so is<=
br>
already documented in sysfs-bus-iio.<br>
<br>
Now it is supposed to be an offset rather than a gain. =A0The current docs =
say:<br>
<br>
&quot;Hardware applied calibration offset. (assumed to fix production<br>
=A0inaccuracies). If shared across all channels, &lt;type&gt;_calibbias<br>
=A0is used.&quot;<br>
<br>
I do note that the illuminance variant isn&#39;t actually listed and would =
be<br>
happy to have a patch adding it alongside the gyro and accel ones already t=
here.<br>
<br>
My first issue here is that it supposed to be an offset not a gain. =A0Seco=
ndly that<br>
description could clearly do with amending to make it clear that this can b=
e used<br>
for devices with complex non linear transformations to SI units which is wh=
at it<br>
is supposed to be doing here. =A0In cases where there is no &#39;_raw&#39; =
output we can assume<br>
something complex may be happening, so changing this value won&#39;t result=
 in a additive<br>
change the output.<br>
<br>
If we are playing with a gain, then calibscale is the parameter name that s=
hould be used<br>
(also a core attribute definition, not a light specific one).<br>
<br>
&quot;Hardware applied calibration scale factor. (assumed to fix<br>
=A0production inaccuracies). =A0If shared across all channels,<br>
=A0&lt;type&gt;_calibscale is used.&quot;<br>
<br>
Note all these attributes are defined to be pseudo floating point. =A0The c=
han_spec approach<br>
to registration handles this cleanly (particularly with Michael Hennerich&#=
39;s additional<br>
callbacks added last week). =A0It&#39;s a gain, so 1 is the no change value=
. Sorry, but anything<br>
that assumes 1024 is the no effect value is never going to generalize well<=
br>
so is a non starter.<br>
<br>
Sorry, I&#39;ll be happy to see a patch adding the support you want to the =
isl29018 driver<br>
but it must conform to the existing abi. =A0It looks like you may have foun=
d a discrepancy<br>
between a driver and the spec, but I&#39;ll leave Jon to comment on that.<b=
r>
<font color=3D"#888888"><br>
Jonathan<br>
</font><div><div></div><div class=3D"h5">&gt;<br>
&gt; Signed-off-by: Bryan Freed &lt;<a href=3D"mailto:bfreed@chromium.org">=
bfreed@chromium.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0.../staging/iio/Documentation/sysfs-bus-iio-light =A0| =A0 10 +++++=
<br>
&gt; =A0drivers/staging/iio/light/isl29018.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 36 +++++++++++++++++++-<br>
&gt; =A02 files changed, 45 insertions(+), 1 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light b/d=
rivers/staging/iio/Documentation/sysfs-bus-iio-light<br>
&gt; index 21d2774..704b6c9 100644<br>
&gt; --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light<br>
&gt; +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-light<br>
&gt; @@ -75,3 +75,13 @@ KernelVersion: =A0 =A0 2.6.37<br>
&gt; =A0Contact: =A0 =A0 <a href=3D"mailto:linux-iio@vger.kernel.org">linux=
-iio@vger.kernel.org</a><br>
&gt; =A0Description:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 This property gets/sets the sensors ADC an=
alog integration time.<br>
&gt; +<br>
&gt; +What: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/sys/bus/iio/devices/device[n]/i=
lluminance0_calibbias<br>
&gt; +KernelVersion: =A0 =A0 =A0 2.6.38<br>
&gt; +Contact: =A0 =A0 <a href=3D"mailto:linux-iio@vger.kernel.org">linux-i=
io@vger.kernel.org</a><br>
&gt; +Description:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 This property gets/sets the illuminance0_inp=
ut amplification<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 value. =A0The calculated lux reading is mult=
iplied by this value<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 and divided by 1024. =A0Default of 1024 give=
s no amplification.<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 This provides compensation for glass or beze=
l that can<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 attenuate the ambient light.<br>
&gt; diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/ii=
o/light/isl29018.c<br>
&gt; index 4794ffd..a106f16 100644<br>
&gt; --- a/drivers/staging/iio/light/isl29018.c<br>
&gt; +++ b/drivers/staging/iio/light/isl29018.c<br>
&gt; @@ -57,6 +57,7 @@ struct isl29018_chip {<br>
&gt; =A0 =A0 =A0 struct iio_dev =A0 =A0 =A0 =A0 =A0*indio_dev;<br>
&gt; =A0 =A0 =A0 struct i2c_client =A0 =A0 =A0 *client;<br>
&gt; =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0lock;<br>
&gt; + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0calibbias;<br>
&gt; =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0range;<br>
&gt; =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0adc_bit;<br>
&gt; =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prox_scheme;<b=
r>
&gt; @@ -157,6 +158,7 @@ static int isl29018_read_sensor_input(struct i2c_c=
lient *client, int mode)<br>
&gt;<br>
&gt; =A0static int isl29018_read_lux(struct i2c_client *client, int *lux)<b=
r>
&gt; =A0{<br>
&gt; + =A0 =A0 u64 lux64;<br>
&gt; =A0 =A0 =A0 int lux_data;<br>
&gt; =A0 =A0 =A0 struct isl29018_chip *chip =3D i2c_get_clientdata(client);=
<br>
&gt;<br>
&gt; @@ -166,7 +168,8 @@ static int isl29018_read_lux(struct i2c_client *cl=
ient, int *lux)<br>
&gt; =A0 =A0 =A0 if (lux_data &lt; 0)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return lux_data;<br>
&gt;<br>
&gt; - =A0 =A0 *lux =3D (lux_data * chip-&gt;range) &gt;&gt; chip-&gt;adc_b=
it;<br>
&gt; + =A0 =A0 lux64 =3D lux_data * chip-&gt;range;<br>
&gt; + =A0 =A0 *lux =3D (lux64 * chip-&gt;calibbias) &gt;&gt; (10 + chip-&g=
t;adc_bit);<br>
&gt;<br>
&gt; =A0 =A0 =A0 return 0;<br>
&gt; =A0}<br>
&gt; @@ -264,6 +267,33 @@ static ssize_t get_sensor_data(struct device *dev=
, char *buf, int mode)<br>
&gt; =A0}<br>
&gt;<br>
&gt; =A0/* Sysfs interface */<br>
&gt; +/* calibbias */<br>
&gt; +static ssize_t show_calibbias(struct device *dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *att=
r, char *buf)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<br>
&gt; + =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;dev_data;<br>
&gt; +<br>
&gt; + =A0 =A0 return sprintf(buf, &quot;%u\n&quot;, chip-&gt;calibbias);<b=
r>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t store_calibbias(struct device *dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const char *b=
uf, size_t count)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<br>
&gt; + =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;dev_data;<br>
&gt; + =A0 =A0 unsigned long lval;<br>
&gt; +<br>
&gt; + =A0 =A0 if (strict_strtoul(buf, 10, &amp;lval))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 mutex_lock(&amp;chip-&gt;lock);<br>
&gt; + =A0 =A0 chip-&gt;calibbias =3D lval;<br>
&gt; + =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
&gt; +<br>
&gt; + =A0 =A0 return count;<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0/* range */<br>
&gt; =A0static ssize_t show_range(struct device *dev,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *a=
ttr, char *buf)<br>
&gt; @@ -412,6 +442,8 @@ static IIO_DEVICE_ATTR(proximity_on_chip_ambient_i=
nfrared_supression,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 show_prox_infrared_supression,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 store_prox_infrared_supression, 0);<br>
&gt; =A0static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO, show_lux, NULL,=
 0);<br>
&gt; +static IIO_DEVICE_ATTR(illuminance0_calibbias, S_IRUGO | S_IWUSR,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 show_calibbias, store_calibbias, 0);<br>
&gt; =A0static IIO_DEVICE_ATTR(intensity_infrared_raw, S_IRUGO, show_ir, NU=
LL, 0);<br>
&gt; =A0static IIO_DEVICE_ATTR(proximity_raw, S_IRUGO, show_proxim_ir, NULL=
, 0);<br>
&gt;<br>
&gt; @@ -424,6 +456,7 @@ static struct attribute *isl29018_attributes[] =3D=
 {<br>
&gt; =A0 =A0 =A0 ISL29018_CONST_ATTR(adc_resolution_available),<br>
&gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(proximity_on_chip_ambient_infrared_supre=
ssion),<br>
&gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(illuminance0_input),<br>
&gt; + =A0 =A0 ISL29018_DEV_ATTR(illuminance0_calibbias),<br>
&gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(intensity_infrared_raw),<br>
&gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(proximity_raw),<br>
&gt; =A0 =A0 =A0 NULL<br>
&gt; @@ -478,6 +511,7 @@ static int __devinit isl29018_probe(struct i2c_cli=
ent *client,<br>
&gt;<br>
&gt; =A0 =A0 =A0 mutex_init(&amp;chip-&gt;lock);<br>
&gt;<br>
&gt; + =A0 =A0 chip-&gt;calibbias =3D 1024;<br>
&gt; =A0 =A0 =A0 chip-&gt;range =3D 1000;<br>
&gt; =A0 =A0 =A0 chip-&gt;adc_bit =3D 16;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div></div>

--00151750da4468391b04a5c8cce3--
