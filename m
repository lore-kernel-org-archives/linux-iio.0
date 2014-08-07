Return-Path: <balbi@ti.com>
Date: Thu, 7 Aug 2014 11:35:09 -0500
From: Felipe Balbi <balbi@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <balbi@ti.com>, <linux-iio@vger.kernel.org>
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
Message-ID: <20140807163509.GA29964@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407341409-30284-1-git-send-email-balbi@ti.com>
 <53E34E60.80507@kernel.org>
 <20140807142829.GA24581@saruman.home>
 <53E3A8B4.70805@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
In-Reply-To: <53E3A8B4.70805@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 07, 2014 at 05:26:28PM +0100, Jonathan Cameron wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 07/08/14 15:28, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Thu, Aug 07, 2014 at 11:01:04AM +0100, Jonathan Cameron wrote:
> >> On 06/08/14 17:10, Felipe Balbi wrote:
> >>> TI's opt3001 light sensor is a simple and yet powerful little device.=
 The device provides 99% IR rejection,=20
> >>> Automatic full-scale, very low power consumption and measurements fro=
m 0.01 to 83k lux.
> >>>=20
> >>> This patch adds support for that device using the IIO framework.
> >>>=20
> >>> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> I don't suppose there is a datasheet available?
> >=20
> > There is a summary datasheet available. The device isn't released yet:
> >=20
> > http://www.ti.com/product/OPT3001?keyMatch=3Dopt3001&tisearch=3DSearch-=
EN
> >=20
> Ah well...  Not much on that ;)

yeah, when the thing is released the full datasheet will be available,
I'm sure. Until then, you'd have to sign an NDA with TI to get the full
datasheet, I'm afraid :-s

> >>> Also, there are a couple details about this device which I need to kn=
ow if it looks for you:
> >>>=20
> >>> This device has a single enable bit which will enable both rising and=
 falling edge triggers, but the limits are
> >>> separate.
> >>>=20
> >>> The same limits are also used for hysteresis-style capture and that's=
 controlled by a single bit flip.
> >> With this on, it generates an event whenever the value changes by more=
 than a certain amount?  If so this is
> >> better handled by providing a trigger and a buffer.  Note that the eve=
nts path carries no data other than an
> >> event code.
> >=20
> > It's still a bit weird to me. So, without Latch bit, then yeah, it'll b=
e more of a trigger e.g:
> IIO triggers are actually more similar to those you find in video
> systems than the osciloscope type triggers you are perhaps thinking of.
> They cause a 'scan' of data to be captured every time the fire.
>=20
> A 'scope trigger would cause a set of data to be captured everytime it
> first (e.g. multiple scans of the available channels).  We have talked
> a few times about adding this option, but it hasn't happened yet...

ok

> > I can set low limit to 200 lux and high limit to 50 lux, then I'll get =
a rising edge IRQ when I have more than 50
> > lux and a falling edge when I get less than 200 lux.
> >=20
> > If Latch bit is set, however, then it's almost like it ignores low/high=
 limit altogether and I get an IRQ ever
> > $int_time ms or so.
> That would be similar to the motion triggers we have for accelerometers.
> They capture every sample as long as the threshold is met (during motion).
> No idea why you'd really want to do that on a light sensor though.  Perha=
ps
> not worth capturing light info if the cover is closed on a phone?

Yeah, but that's something else altogether. This device doesn't really
care about a phone cover. Sounds like policy which should be in
userland, or part of an iio_gpio_trigger...

> >>> How do you want this to look on sysfs ? Currently, enable/disabling a=
ny of rising/falling edges, will disable
> >>> both.
> >> That's pretty common.  The ABI basically allows for any setting to cha=
nge any other (as there are much weirder
> >> connections than this in some devices).
> >=20
> > ok, so it's alright to have two "enable" files and have they refer to t=
he same bit ?
> Absolutely.  Depending on the combinations it is sometimes possible to
> construct an 'EITHER' enable file - for example
> driver/iio/adc/xilinix-xadc-core.c

will read

> >>> +		thresh_mantissa =3D &opt->high_thresh_mantissa; +		thresh_exp =3D =
&opt->high_thresh_exp; +		break; +	case
> >>> IIO_EV_DIR_FALLING: +		reg =3D OPT3001_LOW_LIMIT; +		thresh_mantissa =
=3D &opt->low_thresh_mantissa; +		thresh_exp =3D
> >>> &opt->low_thresh_exp; +		break; +	default: +		ret =3D -EINVAL; +		got=
o err; +	} + +	ret =3D opt3001_find_scale(opt,
> >>> val, val2, &exponent); +	if (ret < 0) { +		dev_err(opt->dev, "can't f=
ind scale for %d.%d\n", val, val2); +
> >>> goto err; +	} + +	mantissa =3D (((val * 1000) + (val2 / 1000)) / 10) =
>> exponent; +	value =3D exponent << 12 |
> >>> mantissa; +	ret =3D opt3001_write(opt, reg, value); +	if (ret < 0) { =
+		dev_err(opt->dev, "failed to read
> >>> register %02x\n", reg); +		goto err; +	} +
> >> As stated above an additional switch statement here with direct assign=
ment of the relevant threshold values would
> >> be clearer.
> >>> +	*thresh_mantissa =3D mantissa; +	*thresh_exp =3D exponent; + +err: =
+	mutex_unlock(&opt->lock); + +	return ret;=20
> >>> +} + +static int opt3001_read_event_config(struct iio_dev *iio, +		co=
nst struct iio_chan_spec *chan, enum
> >>> iio_event_type type, +		enum iio_event_direction dir) +{ +	struct opt=
3001 *opt =3D iio_priv(iio); + +	return
> >>> opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS; +} + +static int=
 opt3001_write_event_config(struct iio_dev
> >>> *iio, +		const struct iio_chan_spec *chan, enum iio_event_type type, =
+		enum iio_event_direction dir, int
> >>> state) +{ +	struct opt3001 *opt =3D iio_priv(iio); +	int ret; +	u16 m=
ode; +	u16 reg; + +	if (state && opt->mode
> >>> =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS) +		return 0; + +	if (!stat=
e && opt->mode =3D=3D
> >>> OPT3001_CONFIGURATION_M_SHUTDOWN) +		return 0; + +	mode =3D state ? O=
PT3001_CONFIGURATION_M_CONTINUOUS +		:
> >>> OPT3001_CONFIGURATION_M_SHUTDOWN; + +	ret =3D opt3001_read(opt, OPT30=
01_CONFIGURATION); +	if (ret < 0) { +
> >>> dev_err(opt->dev, "failed to read register %02x\n", +				OPT3001_CONF=
IGURATION); +		return ret; +	} + +	reg =3D
> >>> ret; +	opt3001_set_mode(opt, &reg, mode); + +	if (opt->hysteresis) +	=
	reg |=3D OPT3001_CONFIGURATION_L; +	else +
> >>> reg &=3D ~OPT3001_CONFIGURATION_L; + +	ret =3D opt3001_write(opt, OPT=
3001_CONFIGURATION, reg); +	if (ret < 0) { +
> >>> dev_err(opt->dev, "failed to read register %02x\n", +				OPT3001_CONF=
IGURATION); +		return ret; +	} + +	/* wait
> >>> for mode change to go through */ +	usleep_range(opt->int_time + 5000,=
 opt->int_time + 10000); + +	return 0; +}=20
> >>> + +static const struct iio_info opt3001_info =3D { +	.driver_module =
=3D THIS_MODULE, +	.attrs =3D
> >>> &opt3001_attribute_group, +	.read_raw =3D opt3001_read_raw, +	.write_=
raw =3D opt3001_write_raw, +	.read_event_value
> >>> =3D opt3001_read_event_value, +	.write_event_value =3D opt3001_write_=
event_value, +	.read_event_config =3D
> >>> opt3001_read_event_config, +	.write_event_config =3D opt3001_write_ev=
ent_config, +}; + +static int
> >>> opt3001_read_id(struct opt3001 *opt) +{ +	char manufacturer[2]; +	u16=
 device_id; +	int ret; + +	ret =3D
> >>> opt3001_read(opt, OPT3001_MANUFACTURER_ID); +	if (ret < 0) { +		dev_e=
rr(opt->dev, "failed to read register
> >>> %02x\n", +				OPT3001_MANUFACTURER_ID); +		return ret; +	} + +	manufa=
cturer[0] =3D ret >> 8; +	manufacturer[1] =3D
> >>> ret & 0xff; + +	ret =3D opt3001_read(opt, OPT3001_DEVICE_ID); +	if (r=
et < 0) { +		dev_err(opt->dev, "failed to
> >>> read register %02x\n", +				OPT3001_DEVICE_ID); +		return ret; +	} + =
+	device_id =3D ret; + +	dev_info(opt->dev,
> >>> "Found %c%c OPT%04x\n", manufacturer[0], +			manufacturer[1], device_=
id); + +	return 0; +} + +static int
> >>> opt3001_configure(struct opt3001 *opt) +{ +	int ret; +	u16 reg; + +	r=
et =3D opt3001_read(opt,
> >>> OPT3001_CONFIGURATION); +	if (ret < 0) { +		dev_err(opt->dev, "failed=
 to read register %02x\n", +
> >>> OPT3001_CONFIGURATION); +		return ret; +	} + +	reg =3D ret; + +	if (r=
eg & OPT3001_CONFIGURATION_CT) +
> >>> opt->int_time =3D 800000; +	else +		opt->int_time =3D 100000; + +	reg=
 &=3D ~OPT3001_CONFIGURATION_L; +	reg &=3D
> >>> ~OPT3001_CONFIGURATION_RN_MASK; +	reg |=3D OPT3001_CONFIGURATION_RN_A=
UTO; + +	ret =3D opt3001_write(opt,
> >>> OPT3001_CONFIGURATION, reg); +	if (ret < 0) { +		dev_err(opt->dev, "f=
ailed to write register %02x\n", +
> >>> OPT3001_CONFIGURATION); +		return ret; +	} + +	ret =3D opt3001_read(o=
pt, OPT3001_LOW_LIMIT); +	if (ret < 0) { +
> >>> dev_err(opt->dev, "failed to read register %02x\n", +				OPT3001_LOW_=
LIMIT); +		return ret; +	} + +
> >>> opt->low_thresh_mantissa =3D OPT3001_REG_MANTISSA(ret); +	opt->low_th=
resh_exp =3D OPT3001_REG_EXPONENT(ret); + +
> >>> ret =3D opt3001_read(opt, OPT3001_HIGH_LIMIT); +	if (ret < 0) { +		de=
v_err(opt->dev, "failed to read register
> >>> %02x\n", +				OPT3001_HIGH_LIMIT); +		return ret; +	} + +	opt->high_t=
hresh_mantissa =3D
> >>> OPT3001_REG_MANTISSA(ret); +	opt->high_thresh_exp =3D OPT3001_REG_EXP=
ONENT(ret); + +	return 0; +} + +static
> >>> irqreturn_t opt3001_irq(int irq, void *_opt) +{
> >>=20
> >> Pass the iio_dev in to the irq setup instead of opt and you will then =
not need the opt reference to the struct
> >> iio_dev.
> >=20
> > What's the difference ? When used this way we have:
> >=20
> > struct opt3001 *opt =3D _opt; struct iio_dev *iio =3D opt->dev;
> >=20
> > Done your way we will have:
> >=20
> > struct iio_dev *iio =3D _iio; struct opt3001 *opt =3D iio_priv(iio);
> >=20
> > I don't see the benefit of changing this as I'll access to both opt and=
 iio.
> Because one way you get it from the IIO core support.  The other way arou=
nd
> you have a local copy.  Basically it's better from a consistency point
> of view to have all drivers do it one way around than end up with a mixtu=
re
> of the two (which way around doesn't really matter - but rather late to
> change now!)

don't really care, frankly. i'll just change it

> >>> +static int opt3001_probe(struct i2c_client *client, +		const struct =
i2c_device_id *id) +{ +	struct device *dev
> >>> =3D &client->dev; + +	struct iio_dev *iio; +	struct opt3001 *opt; +	i=
nt irq =3D client->irq; +	int ret; + +	iio =3D
> >>> devm_iio_device_alloc(dev, sizeof(*opt)); +	if (!iio) +		return -ENOM=
EM; + +	opt =3D iio_priv(iio); +	opt->client
> >>> =3D client; +	opt->dev =3D dev;
> >>=20
> >> This is very circular and it rarely makes sense to have the device pri=
vate structure have a reference to the=20
> >> iio_dev.  Here it is only used in the interrupt handler. Avoid that by=
 making the private data passed to the
> >> interrupt handler the struct iio_dev instead of the struct opt3001.
> >>=20
> >>> +	opt->iio =3D iio; + +	mutex_init(&opt->lock); +	i2c_set_clientdata(=
client, opt); + +	ret =3D
> >>> opt3001_read_id(opt); +	if (ret) +		return ret; + +	ret =3D opt3001_c=
onfigure(opt); +	if (ret) +		return ret; + +
> >>> iio->name =3D client->name; +	iio->channels =3D opt3001_channels; +	i=
io->num_channels =3D
> >>> ARRAY_SIZE(opt3001_channels); +	iio->dev.parent =3D dev; +	iio->modes=
 =3D INDIO_DIRECT_MODE; +	iio->info =3D
> >>> &opt3001_info; + +	ret =3D devm_iio_device_register(dev, iio); +	if (=
ret) { +		dev_err(dev, "failed to register
> >>> IIO device\n"); +		return ret; +	} +
> >> Normally we'd expect the devm_iio_device_register (that provides the u=
serspace interfaces) to be after the irq
> >> request.
> >=20
> > that's wrong. By the time the IRQ is requested, an IRQ can actually fir=
e and you better have a valid e.g. iio_dev
> > by then.
> Its very unusual to bring up a device with the IRQ already in a position
> to fire.  Normally that would require some enabling from userspace after =
the
> driver is loaded?  How can it fire here before that point?

at the moment you call request_irq() (or any of its friends), that IRQ
line is unmasked and ready to fire. Remember that IRQ lines can be
shared and your IRQ handler will be called even if a separate device
triggered the IRQ. Heck, if you have a bad board design, even noise can
assert the IRQ line but let's not go there :-)

In any case, you better have valid pointers around so that by the time
your IRQ is triggered, you don't crash the kernel. Another way would be
to mask the IRQ at your device level, but that still doesn't solve
shared IRQs.

I usually request the IRQ as the last step for that very reason.

cheers

--=20
balbi

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT46q9AAoJEIaOsuA1yqREZ8cP/R3IXO915ZkWzoQ4phSppPKm
wyo5xvNIczsss5QFErp3/Suc0hTeUFfloNzWR1hSnsvRokg49xGAkXP3EieeKZbR
8Sfph1pe5o1HjGo1PCJY8RQ0zQQNzkEX9vKKK0RC1Q7WQ/46TmcbWaQOqJhsval3
dIEWwTjWRaml4jHKchOIkkOAH/CPejKtvvhs4zLL8FufjNwcHyF/erEfd+ULynpy
CDlxrnI9X4nLJYr13b7fNu6dtRUNd7mEzF9hGKcsUEFc2algSq8Kw7rZMtVCBHO5
GWIxzHMjyGVoHth75sY5SpfmwzJSOHUkkZihgeZZHhYim2DDBz1NJBKVNkgfAiE3
sGvBjMmDRZgwK5vSmMPtfKJj4pzWWgYFgwTPiZDbDD5Ir5Pp5/8RwV4nHRG4TXs5
oeU0NtaVKF9yJ06El/z2yU1G6+C5QrcSr/cUhnZFgbw8bLuPSB+9RS50/BtnsJWr
4jgn3T8OOLzd8AD3hpCvNhlT10uwhyXW3bNAKuwNv5Rsd397I+83Hh3wd67O/mOr
waNSdeIParA5I96Q6rvw67V8nddeiBsi5lVAaYv1P/R61Bz9tcNbWCMHFXm8mAx3
8+xuaYYB4etwemTLWQmrK/F6uaaws3qD0baickEmfSefR3wcAX8E87JwhtHOG556
T4CKP8ceA7zPCVeZvP+I
=USpD
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
