Return-Path: <bfreed@google.com>
MIME-Version: 1.0
Sender: bfreed@google.com
In-Reply-To: <4DF9C853.80305@cam.ac.uk>
References: <1307737580-14131-1-git-send-email-bfreed@chromium.org>
	<4DF5D0DC.5090205@cam.ac.uk>
	<BANLkTinPg158f7A7BSZ7v=M3QecZ-1HYLujq5sOjDa32oVDCkg@mail.gmail.com>
	<4DF9C853.80305@cam.ac.uk>
Date: Thu, 16 Jun 2011 17:17:53 -0700
Message-ID: <BANLkTikJ++PDyW2q6H0OiWVuGRgGqzCPg=0giBxEANgHO_n-0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] light sensor: Add a calibration file to the isl29018 driver.
From: Bryan Freed <bfreed@chromium.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Jon Brenner <jbrenner@taosinc.com>,
        gregkh@suse.de, arnd@arndb.de,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Content-Type: multipart/alternative; boundary=0015174c448c17fde204a5dd517a
List-ID: <linux-iio@vger.kernel.org>

--0015174c448c17fde204a5dd517a
Content-Type: text/plain; charset=ISO-8859-1

Comments inline...
Again, thanks for the response.

On Thu, Jun 16, 2011 at 2:09 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:

> On 06/16/11 00:49, Bryan Freed wrote:
> > Hi Jon.  Thanks for the feedback.
> >
> > So I took a look at sysfs-bus-iio documentation.
> > *_calibscale is supposed to be "Hardware applied calibration scale
> factor."
> > But what I want is software applied calibration scaling.
> Yes an no.  That description could do with expanding.  What it really means
> is
> a factor applied somewhere before the reading being available to userspace.
> On most devices this indeed in hardware.  With the light sensors as you
> have
> observed it serves much the same role but is applied in software.  Still
> userspace doesn't care where it occurs, just that it can in theory fiddle
> with it.
>

Cool.  I think I see that now.


> >
> > tsl2563 provides this with (apparently undocumented)
> intensity0_both_calibgain,
> oops.  That was an ancient form of naming. Needs updating to current abi.
>
> > and tsl2583 provides this (incorrectly, according to documentation) with
> illuminance0_calibbias.
> Indeed. I'm waiting for Jon to have time to take a look at that (and fix it
> ;)  Sorry, that one
> slipped past me when I reviewed the driver.
> >
> > As for the iio_chan_spec interface, we are a bit behind you guys in
> > source drops. We are at 2.6.38, and that appears to be added in
> > 2.6.39 just before the switch to 3.0.
> Yup, it went in during the most recent merge window.  If you have to work
> with
> 2.6.38 I suggest lifting some of the code form the core and putting it in
> the
> driver to interpret a fixed point decimal input for calibscale.  It'll need
> a few minor changes as you move forward (and there will be major code
> reductions
> if you do move to newer interfaces, but there is no requirement to do so).
>

Ok, I see the effect of the interface change now.
Sysfs filenames no longer come from the individual iio drivers with
IIO_DEVICE_ATTR() and DEVICE_ATTR() calls that specify separate set and show
functions.  Now they come from the
industrialio-core.c:iio_chan_type_name_spec_shared basic names as selected
by the type field of each iio_chan_spec entry provided by a driver, and they
are updated by the channel, modified, and channel2 fields
in __iio_build_postfix() and __iio_device_attr_init().
And the read/write call now goes through iio_read/write_channel_info() to
the driver's combined read/write_raw() function instead of an attribute
specific show/set function.

> I have not found what you mean by pseudo floating point.  Still working on
> it.
> For reading and writing values are passed in two ints.  val and val2
> (iirc).
> There is also a type specification.  For reading from devices this is
> returned by
> read_raw callback, for writing it can be queried (if no callback is
> supplied then
> it assumed to be int for _raw attributes and int + micro for everything
> else.
>

Ok, I see the pseudo floating point stuff now.  Thanks.


> Michael added a IIO_VAL_INT_PLUS_NANO version as he had a 24bit adc that
> required a
> very small value for in_scale.
>

Uhh...  I do not think I need that level of granularity.


>
> We have had some discussions about extending this further, but have left
> that for
> when we actually have a user.  Right now you can have:
>
> IIO_VAL_INT, IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO.
> > For Mike's changes, are you referring to
> 8a27a023f8f66a8361c5e3d8160a690f480479ec in particular?  He has quite a few
> in there.
> Greg KH hasn't picked it up yet (I think Michael has sent it on).
> On mailing list, patches in question are:
>
> http://marc.info/?l=linux-iio&m=130734563905574&w=2 (for the read raw)
> http://marc.info/?l=linux-iio&m=130754290631769&w=2 (for the write raw and
> fmt querying callback)
>
>
> >
> > I see tsl2563 has been updated to use iio_chan_spec.  But the software
> gain is still provided by the old intensity0_both_calibgain file.
> Really? Chanspec is:
>

My mistake.
The variables are all still there, and the math is the same.
But the filename is no longer provided by the driver.  It comes from iio.



>
> static const struct iio_chan_spec tsl2563_channels[] = {
>        IIO_CHAN(IIO_LIGHT, 0, 1, 1, NULL, 0, 0, 0, 0, 0, {}, 0),
>        IIO_CHAN(IIO_INTENSITY, 1, 1, 0, "both", 0,
>                 (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE), 0, 0, 0, {},
>                 IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
>                 IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING)),
>        IIO_CHAN(IIO_INTENSITY, 1, 1, 0, "ir", 1,
>                 (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE), 0, 0, 0, {},
>                 0)
> };
>
> The both bit is referring to the light spectrum (that sensor has a ir +
> visible sensor and an ir only one).
> ir should indeed be infrared. Don't think this driver has a huge number of
> users so probably
> can fix that up quickly (Jon, Amit, do you guys know anyone who would be
> effected by that?)
> We changed the threshold control naming recently anyway and no one has
> shouted about it yet!
>
> We don't actually have the equivalent of 'both' in the documentation. The
> only reason
> we have this readable form userspace is that thresholding on that part is
> done on the
> underlying value of this adc.  If someone cares to move the gain control
> into the driver
> then I'd be happy to see this go (as long as no one is using the threshold
> events for anything
> else.)  We could probably come up with a better naming convention it not.
>
> > Should we be moving away from this interface?
> Yes to calibgain. That should be long gone.  For a while we accidentally
> had both calibscale
> and calibgain in the tree so we eventually went with one and in theory
> standardized on it.
> Just took a while to propagate through (grep tells me there are no users
> left now).
>
>
Ok, I have a good idea what to do.
By the way, I am not a big fan of the IIO_CHAN() macros passing 12
parameters.  It is hard to follow and prone to errors.
In looking at the tsl2563 IIO_INTENSITY channels, it looks like the mask is
passed incorrectly at parameter 7 (_chan2) instead of parameter 8
(_inf_mask).
I will fix that if I can verify it, though I see the write_raw function does
not check the mask.  Hmm...

And the IIO_INTENSITY channels are still normalized at 1000 (the default
calib0 value) instead of 1.000000.  Do you think I should fix that, as well?

bryan.


>
> >
> > bryan.
> >
> >
> > On Mon, Jun 13, 2011 at 1:57 AM, Jonathan Cameron <jic23@cam.ac.uk<mailto:
> jic23@cam.ac.uk>> wrote:
> >
> >     cc'd linux-iio
> >     On 06/10/11 21:26, Bryan Freed wrote:
> >     > This is the same tuning file used in tsl2583.c.
> >     > Add documentation for it to sysfs-bus-iio-light.
> >     > Normalize it at 1024 instead of 1000 so we can avoid 64bit division
> (div_u64).
> >     > Use u64 so we can do all multiplication before division to avoid
> loss of
> >     > granularity on amplified values.
> >     Hi  Brian.
> >
> >     This attribute is a general IIO one rather than a light specific one
> so is
> >     already documented in sysfs-bus-iio.
> >
> >     Now it is supposed to be an offset rather than a gain.  The current
> docs say:
> >
> >     "Hardware applied calibration offset. (assumed to fix production
> >      inaccuracies). If shared across all channels, <type>_calibbias
> >      is used."
> >
> >     I do note that the illuminance variant isn't actually listed and
> would be
> >     happy to have a patch adding it alongside the gyro and accel ones
> already there.
> >
> >     My first issue here is that it supposed to be an offset not a gain.
>  Secondly that
> >     description could clearly do with amending to make it clear that this
> can be used
> >     for devices with complex non linear transformations to SI units which
> is what it
> >     is supposed to be doing here.  In cases where there is no '_raw'
> output we can assume
> >     something complex may be happening, so changing this value won't
> result in a additive
> >     change the output.
> >
> >     If we are playing with a gain, then calibscale is the parameter name
> that should be used
> >     (also a core attribute definition, not a light specific one).
> >
> >     "Hardware applied calibration scale factor. (assumed to fix
> >      production inaccuracies).  If shared across all channels,
> >      <type>_calibscale is used."
> >
> >     Note all these attributes are defined to be pseudo floating point.
>  The chan_spec approach
> >     to registration handles this cleanly (particularly with Michael
> Hennerich's additional
> >     callbacks added last week).  It's a gain, so 1 is the no change
> value. Sorry, but anything
> >     that assumes 1024 is the no effect value is never going to generalize
> well
> >     so is a non starter.
> >
> >     Sorry, I'll be happy to see a patch adding the support you want to
> the isl29018 driver
> >     but it must conform to the existing abi.  It looks like you may have
> found a discrepancy
> >     between a driver and the spec, but I'll leave Jon to comment on that.
> >
> >     Jonathan
> >     >
> >     > Signed-off-by: Bryan Freed <bfreed@chromium.org <mailto:
> bfreed@chromium.org>>
> >     > ---
> >     >  .../staging/iio/Documentation/sysfs-bus-iio-light  |   10 +++++
> >     >  drivers/staging/iio/light/isl29018.c               |   36
> +++++++++++++++++++-
> >     >  2 files changed, 45 insertions(+), 1 deletions(-)
> >     >
> >     > diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> >     > index 21d2774..704b6c9 100644
> >     > --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> >     > +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> >     > @@ -75,3 +75,13 @@ KernelVersion:     2.6.37
> >     >  Contact:     linux-iio@vger.kernel.org <mailto:
> linux-iio@vger.kernel.org>
> >     >  Description:
> >     >               This property gets/sets the sensors ADC analog
> integration time.
> >     > +
> >     > +What:
>  /sys/bus/iio/devices/device[n]/illuminance0_calibbias
> >     > +KernelVersion:       2.6.38
> >     > +Contact:     linux-iio@vger.kernel.org <mailto:
> linux-iio@vger.kernel.org>
> >     > +Description:
> >     > +             This property gets/sets the illuminance0_input
> amplification
> >     > +             value.  The calculated lux reading is multiplied by
> this value
> >     > +             and divided by 1024.  Default of 1024 gives no
> amplification.
> >     > +             This provides compensation for glass or bezel that
> can
> >     > +             attenuate the ambient light.
> >     > diff --git a/drivers/staging/iio/light/isl29018.c
> b/drivers/staging/iio/light/isl29018.c
> >     > index 4794ffd..a106f16 100644
> >     > --- a/drivers/staging/iio/light/isl29018.c
> >     > +++ b/drivers/staging/iio/light/isl29018.c
> >     > @@ -57,6 +57,7 @@ struct isl29018_chip {
> >     >       struct iio_dev          *indio_dev;
> >     >       struct i2c_client       *client;
> >     >       struct mutex            lock;
> >     > +     unsigned int            calibbias;
> >     >       unsigned int            range;
> >     >       unsigned int            adc_bit;
> >     >       int                     prox_scheme;
> >     > @@ -157,6 +158,7 @@ static int isl29018_read_sensor_input(struct
> i2c_client *client, int mode)
> >     >
> >     >  static int isl29018_read_lux(struct i2c_client *client, int *lux)
> >     >  {
> >     > +     u64 lux64;
> >     >       int lux_data;
> >     >       struct isl29018_chip *chip = i2c_get_clientdata(client);
> >     >
> >     > @@ -166,7 +168,8 @@ static int isl29018_read_lux(struct i2c_client
> *client, int *lux)
> >     >       if (lux_data < 0)
> >     >               return lux_data;
> >     >
> >     > -     *lux = (lux_data * chip->range) >> chip->adc_bit;
> >     > +     lux64 = lux_data * chip->range;
> >     > +     *lux = (lux64 * chip->calibbias) >> (10 + chip->adc_bit);
> >     >
> >     >       return 0;
> >     >  }
> >     > @@ -264,6 +267,33 @@ static ssize_t get_sensor_data(struct device
> *dev, char *buf, int mode)
> >     >  }
> >     >
> >     >  /* Sysfs interface */
> >     > +/* calibbias */
> >     > +static ssize_t show_calibbias(struct device *dev,
> >     > +                     struct device_attribute *attr, char *buf)
> >     > +{
> >     > +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >     > +     struct isl29018_chip *chip = indio_dev->dev_data;
> >     > +
> >     > +     return sprintf(buf, "%u\n", chip->calibbias);
> >     > +}
> >     > +
> >     > +static ssize_t store_calibbias(struct device *dev,
> >     > +             struct device_attribute *attr, const char *buf,
> size_t count)
> >     > +{
> >     > +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >     > +     struct isl29018_chip *chip = indio_dev->dev_data;
> >     > +     unsigned long lval;
> >     > +
> >     > +     if (strict_strtoul(buf, 10, &lval))
> >     > +             return -EINVAL;
> >     > +
> >     > +     mutex_lock(&chip->lock);
> >     > +     chip->calibbias = lval;
> >     > +     mutex_unlock(&chip->lock);
> >     > +
> >     > +     return count;
> >     > +}
> >     > +
> >     >  /* range */
> >     >  static ssize_t show_range(struct device *dev,
> >     >                       struct device_attribute *attr, char *buf)
> >     > @@ -412,6 +442,8 @@ static
> IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_supression,
> >     >
> show_prox_infrared_supression,
> >     >
> store_prox_infrared_supression, 0);
> >     >  static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO, show_lux,
> NULL, 0);
> >     > +static IIO_DEVICE_ATTR(illuminance0_calibbias, S_IRUGO | S_IWUSR,
> >     > +                                     show_calibbias,
> store_calibbias, 0);
> >     >  static IIO_DEVICE_ATTR(intensity_infrared_raw, S_IRUGO, show_ir,
> NULL, 0);
> >     >  static IIO_DEVICE_ATTR(proximity_raw, S_IRUGO, show_proxim_ir,
> NULL, 0);
> >     >
> >     > @@ -424,6 +456,7 @@ static struct attribute *isl29018_attributes[]
> = {
> >     >       ISL29018_CONST_ATTR(adc_resolution_available),
> >     >
> ISL29018_DEV_ATTR(proximity_on_chip_ambient_infrared_supression),
> >     >       ISL29018_DEV_ATTR(illuminance0_input),
> >     > +     ISL29018_DEV_ATTR(illuminance0_calibbias),
> >     >       ISL29018_DEV_ATTR(intensity_infrared_raw),
> >     >       ISL29018_DEV_ATTR(proximity_raw),
> >     >       NULL
> >     > @@ -478,6 +511,7 @@ static int __devinit isl29018_probe(struct
> i2c_client *client,
> >     >
> >     >       mutex_init(&chip->lock);
> >     >
> >     > +     chip->calibbias = 1024;
> >     >       chip->range = 1000;
> >     >       chip->adc_bit = 16;
> >     >
> >
> >
>
>

--0015174c448c17fde204a5dd517a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Comments inline...<div>Again, thanks for the response.<br><br><div class=3D=
"gmail_quote">On Thu, Jun 16, 2011 at 2:09 AM, Jonathan Cameron <span dir=
=3D"ltr">&lt;<a href=3D"mailto:jic23@cam.ac.uk">jic23@cam.ac.uk</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 06/16/11 00:49, Bryan =
Freed wrote:<br>
&gt; Hi Jon. =A0Thanks for the feedback.<br>
&gt;<br>
&gt; So I took a look at sysfs-bus-iio documentation.<br>
&gt; *_calibscale is supposed to be &quot;Hardware applied calibration scal=
e factor.&quot;<br>
&gt; But what I want is software applied calibration scaling.<br>
</div>Yes an no. =A0That description could do with expanding. =A0What it re=
ally means is<br>
a factor applied somewhere before the reading being available to userspace.=
<br>
On most devices this indeed in hardware. =A0With the light sensors as you h=
ave<br>
observed it serves much the same role but is applied in software. =A0Still<=
br>
userspace doesn&#39;t care where it occurs, just that it can in theory fidd=
le<br>
with it.<br></blockquote><div><br></div><div>Cool. =A0I think I see that no=
w.</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">&gt;<br>
&gt; tsl2563 provides this with (apparently undocumented) intensity0_both_c=
alibgain,<br>
</div>oops. =A0That was an ancient form of naming. Needs updating to curren=
t abi.<br>
<div class=3D"im"><br>
&gt; and tsl2583 provides this (incorrectly, according to documentation) wi=
th illuminance0_calibbias.<br>
</div>Indeed. I&#39;m waiting for Jon to have time to take a look at that (=
and fix it ;) =A0Sorry, that one<br>
slipped past me when I reviewed the driver.<br>
<div class=3D"im">&gt;<br>
&gt; As for the iio_chan_spec interface, we are a bit behind you guys in<br=
>
&gt; source drops. We are at 2.6.38, and that appears to be added in<br>
&gt; 2.6.39 just before the switch to 3.0.<br>
</div>Yup, it went in during the most recent merge window. =A0If you have t=
o work with<br>
2.6.38 I suggest lifting some of the code form the core and putting it in t=
he<br>
driver to interpret a fixed point decimal input for calibscale. =A0It&#39;l=
l need<br>
a few minor changes as you move forward (and there will be major code reduc=
tions<br>
if you do move to newer interfaces, but there is no requirement to do so).<=
br></blockquote><div><br></div><div>Ok, I see the effect of the interface c=
hange now.</div><div>Sysfs filenames no longer come from the individual iio=
 drivers with IIO_DEVICE_ATTR() and DEVICE_ATTR() calls that specify separa=
te set and show functions. =A0Now they come from the industrialio-core.c:ii=
o_chan_type_name_spec_shared basic names as selected by the type field of e=
ach iio_chan_spec entry provided by a driver, and they are updated by the c=
hannel, modified, and channel2 fields in=A0__iio_build_postfix() and __iio_=
device_attr_init().</div>
<div>And the read/write call now goes through iio_read/write_channel_info()=
 to the driver&#39;s combined read/write_raw() function instead of an attri=
bute specific show/set function.</div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex;">

<div class=3D"im">&gt; I have not found what you mean by pseudo floating po=
int. =A0Still working on it.<br>
</div>For reading and writing values are passed in two ints. =A0val and val=
2 (iirc).<br>
There is also a type specification. =A0For reading from devices this is ret=
urned by<br>
read_raw callback, for writing it can be queried (if no callback is supplie=
d then<br>
it assumed to be int for _raw attributes and int + micro for everything els=
e.<br></blockquote><div><br></div><div>Ok, I see the pseudo floating point =
stuff now. =A0Thanks.</div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<br>
Michael added a IIO_VAL_INT_PLUS_NANO version as he had a 24bit adc that re=
quired a<br>
very small value for in_scale.<br></blockquote><div><br></div><div>Uhh... =
=A0I do not think I need that level of granularity.</div><div>=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex;">

<br>
We have had some discussions about extending this further, but have left th=
at for<br>
when we actually have a user. =A0Right now you can have:<br>
<br>
IIO_VAL_INT, IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO.<br>
<div class=3D"im">&gt; For Mike&#39;s changes, are you referring to 8a27a02=
3f8f66a8361c5e3d8160a690f480479ec in particular? =A0He has quite a few in t=
here.<br>
</div>Greg KH hasn&#39;t picked it up yet (I think Michael has sent it on).=
<br>
On mailing list, patches in question are:<br>
<br>
<a href=3D"http://marc.info/?l=3Dlinux-iio&amp;m=3D130734563905574&amp;w=3D=
2" target=3D"_blank">http://marc.info/?l=3Dlinux-iio&amp;m=3D13073456390557=
4&amp;w=3D2</a> (for the read raw)<br>
<a href=3D"http://marc.info/?l=3Dlinux-iio&amp;m=3D130754290631769&amp;w=3D=
2" target=3D"_blank">http://marc.info/?l=3Dlinux-iio&amp;m=3D13075429063176=
9&amp;w=3D2</a> (for the write raw and fmt querying callback)<br>
<div class=3D"im"><br>
<br>
&gt;<br>
&gt; I see tsl2563 has been updated to use iio_chan_spec. =A0But the softwa=
re gain is still provided by the old intensity0_both_calibgain file.<br>
</div>Really? Chanspec is:<br></blockquote><div><br></div><div>My mistake.<=
/div><div>The variables are all still there, and the math is the same.</div=
><div>But the filename is no longer provided by the driver. =A0It comes fro=
m iio.</div>
<div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<br>
static const struct iio_chan_spec tsl2563_channels[] =3D {<br>
 =A0 =A0 =A0 =A0IIO_CHAN(IIO_LIGHT, 0, 1, 1, NULL, 0, 0, 0, 0, 0, {}, 0),<b=
r>
 =A0 =A0 =A0 =A0IIO_CHAN(IIO_INTENSITY, 1, 1, 0, &quot;both&quot;, 0,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; IIO_CHAN_INFO_CALIBSCALE_SEPAR=
ATE), 0, 0, 0, {},<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_=
RISING) |<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_=
FALLING)),<br>
 =A0 =A0 =A0 =A0IIO_CHAN(IIO_INTENSITY, 1, 1, 0, &quot;ir&quot;, 1,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; IIO_CHAN_INFO_CALIBSCALE_SEPAR=
ATE), 0, 0, 0, {},<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0)<br>
};<br>
<br>
The both bit is referring to the light spectrum (that sensor has a ir + vis=
ible sensor and an ir only one).<br>
ir should indeed be infrared. Don&#39;t think this driver has a huge number=
 of users so probably<br>
can fix that up quickly (Jon, Amit, do you guys know anyone who would be ef=
fected by that?)<br>
We changed the threshold control naming recently anyway and no one has shou=
ted about it yet!<br>
<br>
We don&#39;t actually have the equivalent of &#39;both&#39; in the document=
ation. The only reason<br>
we have this readable form userspace is that thresholding on that part is d=
one on the<br>
underlying value of this adc. =A0If someone cares to move the gain control =
into the driver<br>
then I&#39;d be happy to see this go (as long as no one is using the thresh=
old events for anything<br>
else.) =A0We could probably come up with a better naming convention it not.=
<br>
<div class=3D"im"><br>
&gt; Should we be moving away from this interface?<br>
</div>Yes to calibgain. That should be long gone. =A0For a while we acciden=
tally had both calibscale<br>
and calibgain in the tree so we eventually went with one and in theory stan=
dardized on it.<br>
Just took a while to propagate through (grep tells me there are no users le=
ft now).<br>
<br></blockquote><div><br></div><div>Ok, I have a good idea what to do.</di=
v><div>By the way, I am not a big fan of the IIO_CHAN() macros passing 12 p=
arameters. =A0It is hard to follow and prone to errors.</div><div>In lookin=
g at the tsl2563 IIO_INTENSITY channels, it looks like the mask is passed i=
ncorrectly at parameter 7 (_chan2) instead of parameter 8 (_inf_mask).</div=
>
<div>I will fix that if I can verify it, though I see the write_raw functio=
n does not check the mask. =A0Hmm...</div><div><br></div><div>And the IIO_I=
NTENSITY channels are still normalized at 1000 (the default calib0 value) i=
nstead of 1.000000. =A0Do you think I should fix that, as well?</div>
<div><br></div><div>bryan.</div><div>=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
;">
<br>
&gt;<br>
&gt; bryan.<br>
<div><div></div><div class=3D"h5">&gt;<br>
&gt;<br>
&gt; On Mon, Jun 13, 2011 at 1:57 AM, Jonathan Cameron &lt;<a href=3D"mailt=
o:jic23@cam.ac.uk">jic23@cam.ac.uk</a> &lt;mailto:<a href=3D"mailto:jic23@c=
am.ac.uk">jic23@cam.ac.uk</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 cc&#39;d linux-iio<br>
&gt; =A0 =A0 On 06/10/11 21:26, Bryan Freed wrote:<br>
&gt; =A0 =A0 &gt; This is the same tuning file used in tsl2583.c.<br>
&gt; =A0 =A0 &gt; Add documentation for it to sysfs-bus-iio-light.<br>
&gt; =A0 =A0 &gt; Normalize it at 1024 instead of 1000 so we can avoid 64bi=
t division (div_u64).<br>
&gt; =A0 =A0 &gt; Use u64 so we can do all multiplication before division t=
o avoid loss of<br>
&gt; =A0 =A0 &gt; granularity on amplified values.<br>
&gt; =A0 =A0 Hi =A0Brian.<br>
&gt;<br>
&gt; =A0 =A0 This attribute is a general IIO one rather than a light specif=
ic one so is<br>
&gt; =A0 =A0 already documented in sysfs-bus-iio.<br>
&gt;<br>
&gt; =A0 =A0 Now it is supposed to be an offset rather than a gain. =A0The =
current docs say:<br>
&gt;<br>
&gt; =A0 =A0 &quot;Hardware applied calibration offset. (assumed to fix pro=
duction<br>
&gt; =A0 =A0 =A0inaccuracies). If shared across all channels, &lt;type&gt;_=
calibbias<br>
&gt; =A0 =A0 =A0is used.&quot;<br>
&gt;<br>
&gt; =A0 =A0 I do note that the illuminance variant isn&#39;t actually list=
ed and would be<br>
&gt; =A0 =A0 happy to have a patch adding it alongside the gyro and accel o=
nes already there.<br>
&gt;<br>
&gt; =A0 =A0 My first issue here is that it supposed to be an offset not a =
gain. =A0Secondly that<br>
&gt; =A0 =A0 description could clearly do with amending to make it clear th=
at this can be used<br>
&gt; =A0 =A0 for devices with complex non linear transformations to SI unit=
s which is what it<br>
&gt; =A0 =A0 is supposed to be doing here. =A0In cases where there is no &#=
39;_raw&#39; output we can assume<br>
&gt; =A0 =A0 something complex may be happening, so changing this value won=
&#39;t result in a additive<br>
&gt; =A0 =A0 change the output.<br>
&gt;<br>
&gt; =A0 =A0 If we are playing with a gain, then calibscale is the paramete=
r name that should be used<br>
&gt; =A0 =A0 (also a core attribute definition, not a light specific one).<=
br>
&gt;<br>
&gt; =A0 =A0 &quot;Hardware applied calibration scale factor. (assumed to f=
ix<br>
&gt; =A0 =A0 =A0production inaccuracies). =A0If shared across all channels,=
<br>
&gt; =A0 =A0 =A0&lt;type&gt;_calibscale is used.&quot;<br>
&gt;<br>
&gt; =A0 =A0 Note all these attributes are defined to be pseudo floating po=
int. =A0The chan_spec approach<br>
&gt; =A0 =A0 to registration handles this cleanly (particularly with Michae=
l Hennerich&#39;s additional<br>
&gt; =A0 =A0 callbacks added last week). =A0It&#39;s a gain, so 1 is the no=
 change value. Sorry, but anything<br>
&gt; =A0 =A0 that assumes 1024 is the no effect value is never going to gen=
eralize well<br>
&gt; =A0 =A0 so is a non starter.<br>
&gt;<br>
&gt; =A0 =A0 Sorry, I&#39;ll be happy to see a patch adding the support you=
 want to the isl29018 driver<br>
&gt; =A0 =A0 but it must conform to the existing abi. =A0It looks like you =
may have found a discrepancy<br>
&gt; =A0 =A0 between a driver and the spec, but I&#39;ll leave Jon to comme=
nt on that.<br>
&gt;<br>
&gt; =A0 =A0 Jonathan<br>
&gt; =A0 =A0 &gt;<br>
</div></div>&gt; =A0 =A0 &gt; Signed-off-by: Bryan Freed &lt;<a href=3D"mai=
lto:bfreed@chromium.org">bfreed@chromium.org</a> &lt;mailto:<a href=3D"mail=
to:bfreed@chromium.org">bfreed@chromium.org</a>&gt;&gt;<br>
<div class=3D"im">&gt; =A0 =A0 &gt; ---<br>
&gt; =A0 =A0 &gt; =A0.../staging/iio/Documentation/sysfs-bus-iio-light =A0|=
 =A0 10 +++++<br>
&gt; =A0 =A0 &gt; =A0drivers/staging/iio/light/isl29018.c =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 36 +++++++++++++++++++-<br>
&gt; =A0 =A0 &gt; =A02 files changed, 45 insertions(+), 1 deletions(-)<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; diff --git a/drivers/staging/iio/Documentation/sysfs-bus-=
iio-light b/drivers/staging/iio/Documentation/sysfs-bus-iio-light<br>
&gt; =A0 =A0 &gt; index 21d2774..704b6c9 100644<br>
&gt; =A0 =A0 &gt; --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-lig=
ht<br>
&gt; =A0 =A0 &gt; +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-lig=
ht<br>
&gt; =A0 =A0 &gt; @@ -75,3 +75,13 @@ KernelVersion: =A0 =A0 2.6.37<br>
</div>&gt; =A0 =A0 &gt; =A0Contact: =A0 =A0 <a href=3D"mailto:linux-iio@vge=
r.kernel.org">linux-iio@vger.kernel.org</a> &lt;mailto:<a href=3D"mailto:li=
nux-iio@vger.kernel.org">linux-iio@vger.kernel.org</a>&gt;<br>
<div class=3D"im">&gt; =A0 =A0 &gt; =A0Description:<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 This property gets/sets the s=
ensors ADC analog integration time.<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; +What: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/sys/bus/iio/device=
s/device[n]/illuminance0_calibbias<br>
&gt; =A0 =A0 &gt; +KernelVersion: =A0 =A0 =A0 2.6.38<br>
</div>&gt; =A0 =A0 &gt; +Contact: =A0 =A0 <a href=3D"mailto:linux-iio@vger.=
kernel.org">linux-iio@vger.kernel.org</a> &lt;mailto:<a href=3D"mailto:linu=
x-iio@vger.kernel.org">linux-iio@vger.kernel.org</a>&gt;<br>
<div><div></div><div class=3D"h5">&gt; =A0 =A0 &gt; +Description:<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 This property gets/sets the ill=
uminance0_input amplification<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 value. =A0The calculated lux re=
ading is multiplied by this value<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 and divided by 1024. =A0Default=
 of 1024 gives no amplification.<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 This provides compensation for =
glass or bezel that can<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 attenuate the ambient light.<br=
>
&gt; =A0 =A0 &gt; diff --git a/drivers/staging/iio/light/isl29018.c b/drive=
rs/staging/iio/light/isl29018.c<br>
&gt; =A0 =A0 &gt; index 4794ffd..a106f16 100644<br>
&gt; =A0 =A0 &gt; --- a/drivers/staging/iio/light/isl29018.c<br>
&gt; =A0 =A0 &gt; +++ b/drivers/staging/iio/light/isl29018.c<br>
&gt; =A0 =A0 &gt; @@ -57,6 +57,7 @@ struct isl29018_chip {<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 struct iio_dev =A0 =A0 =A0 =A0 =A0*indio_dev;=
<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 struct i2c_client =A0 =A0 =A0 *client;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0lock;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0calibbias;<=
br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0range;<br=
>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0adc_bit;<=
br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p=
rox_scheme;<br>
&gt; =A0 =A0 &gt; @@ -157,6 +158,7 @@ static int isl29018_read_sensor_input=
(struct i2c_client *client, int mode)<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0static int isl29018_read_lux(struct i2c_client *client=
, int *lux)<br>
&gt; =A0 =A0 &gt; =A0{<br>
&gt; =A0 =A0 &gt; + =A0 =A0 u64 lux64;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 int lux_data;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 struct isl29018_chip *chip =3D i2c_get_client=
data(client);<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; @@ -166,7 +168,8 @@ static int isl29018_read_lux(struct i=
2c_client *client, int *lux)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 if (lux_data &lt; 0)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return lux_data;<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; - =A0 =A0 *lux =3D (lux_data * chip-&gt;range) &gt;&gt; c=
hip-&gt;adc_bit;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 lux64 =3D lux_data * chip-&gt;range;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 *lux =3D (lux64 * chip-&gt;calibbias) &gt;&gt; =
(10 + chip-&gt;adc_bit);<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 return 0;<br>
&gt; =A0 =A0 &gt; =A0}<br>
&gt; =A0 =A0 &gt; @@ -264,6 +267,33 @@ static ssize_t get_sensor_data(struc=
t device *dev, char *buf, int mode)<br>
&gt; =A0 =A0 &gt; =A0}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0/* Sysfs interface */<br>
&gt; =A0 =A0 &gt; +/* calibbias */<br>
&gt; =A0 =A0 &gt; +static ssize_t show_calibbias(struct device *dev,<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_a=
ttribute *attr, char *buf)<br>
&gt; =A0 =A0 &gt; +{<br>
&gt; =A0 =A0 &gt; + =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(d=
ev);<br>
&gt; =A0 =A0 &gt; + =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;de=
v_data;<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0 return sprintf(buf, &quot;%u\n&quot;, chip-&gt;=
calibbias);<br>
&gt; =A0 =A0 &gt; +}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; +static ssize_t store_calibbias(struct device *dev,<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, =
const char *buf, size_t count)<br>
&gt; =A0 =A0 &gt; +{<br>
&gt; =A0 =A0 &gt; + =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(d=
ev);<br>
&gt; =A0 =A0 &gt; + =A0 =A0 struct isl29018_chip *chip =3D indio_dev-&gt;de=
v_data;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 unsigned long lval;<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0 if (strict_strtoul(buf, 10, &amp;lval))<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0 mutex_lock(&amp;chip-&gt;lock);<br>
&gt; =A0 =A0 &gt; + =A0 =A0 chip-&gt;calibbias =3D lval;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0 return count;<br>
&gt; =A0 =A0 &gt; +}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; =A0/* range */<br>
&gt; =A0 =A0 &gt; =A0static ssize_t show_range(struct device *dev,<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device=
_attribute *attr, char *buf)<br>
&gt; =A0 =A0 &gt; @@ -412,6 +442,8 @@ static IIO_DEVICE_ATTR(proximity_on_c=
hip_ambient_infrared_supression,<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 show_prox_infrared_supression,<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 store_prox_infrared_supression, 0);<br>
&gt; =A0 =A0 &gt; =A0static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO, sh=
ow_lux, NULL, 0);<br>
&gt; =A0 =A0 &gt; +static IIO_DEVICE_ATTR(illuminance0_calibbias, S_IRUGO |=
 S_IWUSR,<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 show_calibbias, store_calibbias, 0);<br>
&gt; =A0 =A0 &gt; =A0static IIO_DEVICE_ATTR(intensity_infrared_raw, S_IRUGO=
, show_ir, NULL, 0);<br>
&gt; =A0 =A0 &gt; =A0static IIO_DEVICE_ATTR(proximity_raw, S_IRUGO, show_pr=
oxim_ir, NULL, 0);<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; @@ -424,6 +456,7 @@ static struct attribute *isl29018_att=
ributes[] =3D {<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 ISL29018_CONST_ATTR(adc_resolution_available)=
,<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(proximity_on_chip_ambient_i=
nfrared_supression),<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(illuminance0_input),<br>
&gt; =A0 =A0 &gt; + =A0 =A0 ISL29018_DEV_ATTR(illuminance0_calibbias),<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(intensity_infrared_raw),<br=
>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 ISL29018_DEV_ATTR(proximity_raw),<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 NULL<br>
&gt; =A0 =A0 &gt; @@ -478,6 +511,7 @@ static int __devinit isl29018_probe(s=
truct i2c_client *client,<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 mutex_init(&amp;chip-&gt;lock);<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 chip-&gt;calibbias =3D 1024;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 chip-&gt;range =3D 1000;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 chip-&gt;adc_bit =3D 16;<br>
&gt; =A0 =A0 &gt;<br>
&gt;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div>

--0015174c448c17fde204a5dd517a--
