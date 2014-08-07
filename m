Return-Path: <balbi@ti.com>
Date: Thu, 7 Aug 2014 09:28:30 -0500
From: Felipe Balbi <balbi@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Felipe Balbi <balbi@ti.com>, <linux-iio@vger.kernel.org>
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
Message-ID: <20140807142829.GA24581@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407341409-30284-1-git-send-email-balbi@ti.com>
 <53E34E60.80507@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <53E34E60.80507@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 07, 2014 at 11:01:04AM +0100, Jonathan Cameron wrote:
> On 06/08/14 17:10, Felipe Balbi wrote:
> > TI's opt3001 light sensor is a simple and yet powerful
> > little device. The device provides 99% IR rejection,
> > Automatic full-scale, very low power consumption and
> > measurements from 0.01 to 83k lux.
> >
> > This patch adds support for that device using the IIO
> > framework.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> I don't suppose there is a datasheet available?

There is a summary datasheet available. The device isn't released yet:

http://www.ti.com/product/OPT3001?keyMatch=3Dopt3001&tisearch=3DSearch-EN

> When in M_CONTINUOUS is it just providing event interrupts
> (threshold etc)?

It depends on the mode. If Latch bit is set, then it'll report event
interrupts. Datasheet calls this a "window-style comparison operation).

If Latch bit is cleared, then it'll continuously report the comparison
result. Datasheet calls this a "hysteresis-style comoparison operation).

> > Jonathan, I have a few doubts on how can I test buffered
> > mode properly. I can see my IRQs triggering now problem,
> > but where is the data pushed ? Can it be read from sysfs
> > or /dev somehwere ?
> As  I guess has become clear from your thread with Peter,
> what you have here in IIO terms are called events (separate
> form the buffer which is for the main data flow).
>=20
> Anyhow, see drivers/staging/iio/Documentation/iio_event_monitor.c.
> Some trickery with an anonymous file descriptor is used to avoid
> using lots of chardevs for the same device.

ok, will look at it.

> > Also, there are a couple details about this device which
> > I need to know if it looks for you:
> >
> > This device has a single enable bit which will enable both
> > rising and falling edge triggers, but the limits are separate.
> >
> > The same limits are also used for hysteresis-style capture and
> > that's controlled by a single bit flip.
> With this on, it generates an event whenever the value changes by
> more than a certain amount?  If so this is better handled by
> providing a trigger and a buffer.  Note that the events path
> carries no data other than an event code.

It's still a bit weird to me. So, without Latch bit, then yeah, it'll be
more of a trigger e.g:

I can set low limit to 200 lux and high limit to 50 lux, then I'll get a
rising edge IRQ when I have more than 50 lux and a falling edge when I
get less than 200 lux.

If Latch bit is set, however, then it's almost like it ignores low/high
limit altogether and I get an IRQ ever $int_time ms or so.

> > How do you want this to look on sysfs ? Currently, enable/disabling
> > any of rising/falling edges, will disable both.
> That's pretty common.  The ABI basically allows for any setting to
> change any other (as there are much weirder connections than this
> in some devices).

ok, so it's alright to have two "enable" files and have they refer to
the same bit ?

> > +static int opt3001_read(const struct opt3001 *opt, u8 reg)
> > +{
> > +	return i2c_smbus_read_word_swapped(opt->client, reg);
> > +}
> I'm very much against wrapper functions unless they add something. These
> really do not.

as I mentioned before, it helps a lot when using function tracer. I can
just "echo opt3001* > set_trace_function". But if you guys are so much
against it, I'll remove it.

> > +static const struct iio_chan_spec opt3001_channels[] =3D {
> > +	{
> > +		.type =3D IIO_LIGHT,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +				BIT(IIO_CHAN_INFO_SCALE) |
> > +				BIT(IIO_CHAN_INFO_INT_TIME),
> > +		.channel =3D 0,
>=20
> No buffering at the moment so can drop scan_type and scan_index.

will do

> > +static int opt3001_read_event_value(struct iio_dev *iio,
> > +		const struct iio_chan_spec *chan, enum iio_event_type type,
> > +		enum iio_event_direction dir, enum iio_event_info info,
> > +		int *val, int *val2)
> > +{
> > +	struct opt3001 *opt =3D iio_priv(iio);
> > +	int ret =3D IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	mutex_lock(&opt->lock);
> > +
> So these will return the same value whether the value attribute is read
> or the hysteresis one?

yeah, the comparison done is the same.

> > +static int opt3001_write_event_value(struct iio_dev *iio,
> > +		const struct iio_chan_spec *chan, enum iio_event_type type,
> > +		enum iio_event_direction dir, enum iio_event_info info,
> > +		int val, int val2)
> > +{
> > +	struct opt3001 *opt =3D iio_priv(iio);
> > +	int ret =3D 0;
> > +
> > +	u16 *thresh_mantissa;
> > +	u16 mantissa;
> > +	u16 value;
> > +	u16 reg;
> > +
> > +	u8 *thresh_exp;
> > +
> > +	u8 exponent;
> > +
> > +	mutex_lock(&opt->lock);
> > +
> > +	ret =3D opt3001_read(opt, OPT3001_CONFIGURATION);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_CONFIGURATION);
> > +		goto err;
> > +	}
> > +
> > +	reg =3D ret;
> > +	if (info =3D=3D IIO_EV_INFO_HYSTERESIS)
> Without a datasheet I'm not entirely sure how the hysteresis is
> applied here and what it's connection to the thresholds is...

yeah, that'll still take a while to be fully released.

>=20
> > +		opt->hysteresis =3D true;
> > +	else
> > +		opt->hysteresis =3D false;
> > +
> > +	switch (dir) {
> > +	case IIO_EV_DIR_RISING:
> > +		reg =3D OPT3001_HIGH_LIMIT;
> Why bother with the indirection via a pointer. Just have a second
> switch statement at the end of the function that sets the right ones.
> Easier to follow than this.

sure

> > +		thresh_mantissa =3D &opt->high_thresh_mantissa;
> > +		thresh_exp =3D &opt->high_thresh_exp;
> > +		break;
> > +	case IIO_EV_DIR_FALLING:
> > +		reg =3D OPT3001_LOW_LIMIT;
> > +		thresh_mantissa =3D &opt->low_thresh_mantissa;
> > +		thresh_exp =3D &opt->low_thresh_exp;
> > +		break;
> > +	default:
> > +		ret =3D -EINVAL;
> > +		goto err;
> > +	}
> > +
> > +	ret =3D opt3001_find_scale(opt, val, val2, &exponent);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "can't find scale for %d.%d\n", val, val2);
> > +		goto err;
> > +	}
> > +
> > +	mantissa =3D (((val * 1000) + (val2 / 1000)) / 10) >> exponent;
> > +	value =3D exponent << 12 | mantissa;
> > +	ret =3D opt3001_write(opt, reg, value);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n", reg);
> > +		goto err;
> > +	}
> > +
> As stated above an additional switch statement here with direct assignment
> of the relevant threshold values would be clearer.
> > +	*thresh_mantissa =3D mantissa;
> > +	*thresh_exp =3D exponent;
> > +
> > +err:
> > +	mutex_unlock(&opt->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int opt3001_read_event_config(struct iio_dev *iio,
> > +		const struct iio_chan_spec *chan, enum iio_event_type type,
> > +		enum iio_event_direction dir)
> > +{
> > +	struct opt3001 *opt =3D iio_priv(iio);
> > +
> > +	return opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS;
> > +}
> > +
> > +static int opt3001_write_event_config(struct iio_dev *iio,
> > +		const struct iio_chan_spec *chan, enum iio_event_type type,
> > +		enum iio_event_direction dir, int state)
> > +{
> > +	struct opt3001 *opt =3D iio_priv(iio);
> > +	int ret;
> > +	u16 mode;
> > +	u16 reg;
> > +
> > +	if (state && opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS)
> > +		return 0;
> > +
> > +	if (!state && opt->mode =3D=3D OPT3001_CONFIGURATION_M_SHUTDOWN)
> > +		return 0;
> > +
> > +	mode =3D state ? OPT3001_CONFIGURATION_M_CONTINUOUS
> > +		: OPT3001_CONFIGURATION_M_SHUTDOWN;
> > +
> > +	ret =3D opt3001_read(opt, OPT3001_CONFIGURATION);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_CONFIGURATION);
> > +		return ret;
> > +	}
> > +
> > +	reg =3D ret;
> > +	opt3001_set_mode(opt, &reg, mode);
> > +
> > +	if (opt->hysteresis)
> > +		reg |=3D OPT3001_CONFIGURATION_L;
> > +	else
> > +		reg &=3D ~OPT3001_CONFIGURATION_L;
> > +
> > +	ret =3D opt3001_write(opt, OPT3001_CONFIGURATION, reg);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_CONFIGURATION);
> > +		return ret;
> > +	}
> > +
> > +	/* wait for mode change to go through */
> > +	usleep_range(opt->int_time + 5000, opt->int_time + 10000);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct iio_info opt3001_info =3D {
> > +	.driver_module =3D THIS_MODULE,
> > +	.attrs =3D &opt3001_attribute_group,
> > +	.read_raw =3D opt3001_read_raw,
> > +	.write_raw =3D opt3001_write_raw,
> > +	.read_event_value =3D opt3001_read_event_value,
> > +	.write_event_value =3D opt3001_write_event_value,
> > +	.read_event_config =3D opt3001_read_event_config,
> > +	.write_event_config =3D opt3001_write_event_config,
> > +};
> > +
> > +static int opt3001_read_id(struct opt3001 *opt)
> > +{
> > +	char manufacturer[2];
> > +	u16 device_id;
> > +	int ret;
> > +
> > +	ret =3D opt3001_read(opt, OPT3001_MANUFACTURER_ID);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_MANUFACTURER_ID);
> > +		return ret;
> > +	}
> > +
> > +	manufacturer[0] =3D ret >> 8;
> > +	manufacturer[1] =3D ret & 0xff;
> > +
> > +	ret =3D opt3001_read(opt, OPT3001_DEVICE_ID);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_DEVICE_ID);
> > +		return ret;
> > +	}
> > +
> > +	device_id =3D ret;
> > +
> > +	dev_info(opt->dev, "Found %c%c OPT%04x\n", manufacturer[0],
> > +			manufacturer[1], device_id);
> > +
> > +	return 0;
> > +}
> > +
> > +static int opt3001_configure(struct opt3001 *opt)
> > +{
> > +	int ret;
> > +	u16 reg;
> > +
> > +	ret =3D opt3001_read(opt, OPT3001_CONFIGURATION);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_CONFIGURATION);
> > +		return ret;
> > +	}
> > +
> > +	reg =3D ret;
> > +
> > +	if (reg & OPT3001_CONFIGURATION_CT)
> > +		opt->int_time =3D 800000;
> > +	else
> > +		opt->int_time =3D 100000;
> > +
> > +	reg &=3D ~OPT3001_CONFIGURATION_L;
> > +	reg &=3D ~OPT3001_CONFIGURATION_RN_MASK;
> > +	reg |=3D OPT3001_CONFIGURATION_RN_AUTO;
> > +
> > +	ret =3D opt3001_write(opt, OPT3001_CONFIGURATION, reg);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to write register %02x\n",
> > +				OPT3001_CONFIGURATION);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D opt3001_read(opt, OPT3001_LOW_LIMIT);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_LOW_LIMIT);
> > +		return ret;
> > +	}
> > +
> > +	opt->low_thresh_mantissa =3D OPT3001_REG_MANTISSA(ret);
> > +	opt->low_thresh_exp =3D OPT3001_REG_EXPONENT(ret);
> > +
> > +	ret =3D opt3001_read(opt, OPT3001_HIGH_LIMIT);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_HIGH_LIMIT);
> > +		return ret;
> > +	}
> > +
> > +	opt->high_thresh_mantissa =3D OPT3001_REG_MANTISSA(ret);
> > +	opt->high_thresh_exp =3D OPT3001_REG_EXPONENT(ret);
> > +
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t opt3001_irq(int irq, void *_opt)
> > +{
>=20
> Pass the iio_dev in to the irq setup instead of opt and
> you will then not need the opt reference to the struct iio_dev.

What's the difference ? When used this way we have:

	struct opt3001 *opt =3D _opt;
	struct iio_dev *iio =3D opt->dev;

Done your way we will have:

	struct iio_dev *iio =3D _iio;
	struct opt3001 *opt =3D iio_priv(iio);

I don't see the benefit of changing this as I'll access to both opt and
iio.

> > +static int opt3001_probe(struct i2c_client *client,
> > +		const struct i2c_device_id *id)
> > +{
> > +	struct device *dev =3D &client->dev;
> > +
> > +	struct iio_dev *iio;
> > +	struct opt3001 *opt;
> > +	int irq =3D client->irq;
> > +	int ret;
> > +
> > +	iio =3D devm_iio_device_alloc(dev, sizeof(*opt));
> > +	if (!iio)
> > +		return -ENOMEM;
> > +
> > +	opt =3D iio_priv(iio);
> > +	opt->client =3D client;
> > +	opt->dev =3D dev;
>=20
> This is very circular and it rarely makes sense to have
> the device private structure have a reference to the
> iio_dev.  Here it is only used in the interrupt handler.
> Avoid that by making the private data passed to the interrupt
> handler the struct iio_dev instead of the struct opt3001.
>=20
> > +	opt->iio =3D iio;
> > +
> > +	mutex_init(&opt->lock);
> > +	i2c_set_clientdata(client, opt);
> > +
> > +	ret =3D opt3001_read_id(opt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D opt3001_configure(opt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	iio->name =3D client->name;
> > +	iio->channels =3D opt3001_channels;
> > +	iio->num_channels =3D ARRAY_SIZE(opt3001_channels);
> > +	iio->dev.parent =3D dev;
> > +	iio->modes =3D INDIO_DIRECT_MODE;
> > +	iio->info =3D &opt3001_info;
> > +
> > +	ret =3D devm_iio_device_register(dev, iio);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register IIO device\n");
> > +		return ret;
> > +	}
> > +
> Normally we'd expect the devm_iio_device_register (that provides the
> userspace interfaces) to be after the irq request.

that's wrong. By the time the IRQ is requested, an IRQ can actually fire
and you better have a valid e.g. iio_dev by then.

--=20
balbi

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT440NAAoJEIaOsuA1yqREqdwQAJ3/H56PLN/SAKRIgmYTyLhD
Wz0qQzftVEpRlTO9XZxtaoUJoXU3tmcJpWjHATNReL7jxWqIxQ9MRpDcIWbQIjmM
w3rxFDGpohrVrVddzlF8IW4xztJ2LOdfQ7y8U+MrPWdT4nB1CJO4BedJf2eiBx1Z
9RAgsKF3XnB4xNVpr14MptTr8C+6D6rQfQB7Uj4oLiDlXjYz4iz+m3e7t3jmQIaH
3HNQCvMxo4aP+5Z8RodguTJ7tXddHQ/+wFNb+SwEOr4MXL2plyt4IPZVu7nbr7Sq
c/lyuN2OknsFVekkZpEK7wtwER1A22/epdnUsom4M7YzJVu6JgldOkIAtDY17mgS
dZ7CsaXry2htrU+uKr1dxAf1Jav/hnWkd4P3Jj+dD3+3SZndyaxSZj6hTfAaOPhh
799HqlEnqD8D10uQ9BiGVq6JKzB3cqVuB/9AKBbg04UkZ7YxB7ZPcPANHnhoiOGY
6nkX6BaFiUVe8PkBlZ5q0vxhkKOdXO0DgjFTkfA+gTY2Dm5rhOG+uzJ96NeO8YfI
oM5i3wWNfdfbYfxjufTlGNGfLxlfH2S74TFymQDPLcOG7nbq/TzshL9EUob6y0nv
1pA5MsFqAMI/g0QaMare8Or2BQ9Mvp+Ej21ul1QWqX1lzmVe/oudvqnHbCubvbms
t0MupYT0NkPtsYnrmLi8
=uneL
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
