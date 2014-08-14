Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50175 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbaHNRGQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 14 Aug 2014 13:06:16 -0400
Date: Thu, 14 Aug 2014 12:05:30 -0500
From: Felipe Balbi <balbi@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Felipe Balbi <balbi@ti.com>, <linux-iio@vger.kernel.org>,
	<pmeerw@pmeerw.net>
Subject: Re: [PATCH v3] iio: ligth: add support for TI's opt3001 ligth sensor
Message-ID: <20140814170530.GB1445@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407940605-12270-1-git-send-email-balbi@ti.com>
 <53ECE90A.8010609@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
In-Reply-To: <53ECE90A.8010609@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Thu, Aug 14, 2014 at 05:51:22PM +0100, Jonathan Cameron wrote:
> On 13/08/14 15:36, Felipe Balbi wrote:
> > TI's opt3001 light sensor is a simple and yet powerful
> > little device. The device provides 99% IR rejection,
> > Automatic full-scale, very low power consumption and
> > measurements from 0.01 to 83k lux.
> >
> > This patch adds support for that device using the IIO
> > framework.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> Please fix your patch title spelling of light!

alright done and sent another version too.

> I'm not keen on the ordering during remove and
> your use of hysteresis does not conform to the ABI so please
> take a look at that and the other drivers that make use of it.

see below

> Hystersis is documented in Documentation/ABI/testing/sysfs-bus-iio
>=20
> Specifies the hysteresis of threshold that the device is comparing
> 	against for the events enabled by
> 	<type>Y[_name]_thresh[_(rising|falling)]_hysteresis.

this is exactly what the driver is doing, read again

> 	If separate attributes exist for the two directions, but
> 	direction is not specified for this attribute, then a single
> 	hysteresis value applies to both directions.
> 	For falling events the hysteresis is added to the _value attribute for
> 	this event to get the upper threshold for when the event goes back to
> 	normal, for rising events the hysteresis is subtracted from the _value
> 	attribute. E.g. if in_voltage0_raw_thresh_rising_value is set to 1200
> 	and in_voltage0_raw_thresh_rising_hysteresis is set to 50. The event
> 	will get activated once in_voltage0_raw goes above 1200 and will become
> 	deactived again once the value falls below 1150.
>=20
> Also, I'll probably wait for Peter to take a look at any final version
> (would like to credit him for his work reviewing the earlier versions!)
> Not as though we are likely to be in a rush at this time in the cycle.

right

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
> > +	switch (dir) {
> > +	case IIO_EV_DIR_RISING:
> This should have separate handling for the hyseresis and value attributes
> as they should return the relevant numeric values...

the register is the same for both cases.

> > +static int opt3001_write_event_value(struct iio_dev *iio,
> > +		const struct iio_chan_spec *chan, enum iio_event_type type,
> > +		enum iio_event_direction dir, enum iio_event_info info,
> > +		int val, int val2)
> > +{
> > +	struct opt3001 *opt =3D iio_priv(iio);
> > +	int ret =3D 0;
> > +
> > +	u16 mantissa;
> > +	u16 value;
> > +	u16 reg;
> > +
> > +	u8 exponent;
> > +
> > +	mutex_lock(&opt->lock);
> > +
> > +	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATIO=
N);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_CONFIGURATION);
> > +		goto err;
> > +	}
> > +
> > +	reg =3D ret;
> > +	if (info =3D=3D IIO_EV_INFO_HYSTERESIS)
> Hysteresis is typically a numeric value.  The options here should be eith=
er 0
> (for none) or the value of hysteresis applied (how far we have to back off
> from the thereshold to trigger the event).  It's not a boolean and even
> if it were enabling it or not based on last write is not a good way of do=
ing
> things.

this is just to tell me if I should set the bit in the register or not.
IOW, this is just a driver internal flag, note that it doesn't get
returned to userland in no occasion.

See write_even_config below

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
> > +	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATIO=
N);
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

here, I need to know if I have to set this bit or not. When it comes to
values passed from sysfs, the register that gets written is the same
hysteresis or not.

> > +static int opt3001_read_id(struct opt3001 *opt)
> > +{
> > +	char manufacturer[2];
> > +	u16 device_id;
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_MANUFACTURER=
_ID);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_MANUFACTURER_ID);
> > +		return ret;
> > +	}
> > +
> > +	manufacturer[0] =3D ret >> 8;
> > +	manufacturer[1] =3D ret & 0xff;
> I would be a little 'unusual' but you could use an endian conversion here=
 :)
> Perhaps better to have the clarity of the way you have done it!

byte ordering is already handled by read_word_swapped, though.

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
> > +	ret =3D devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,
> > +			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
> > +			| IRQF_ONESHOT, "opt3001", iio);
> > +	if (ret) {
> > +		dev_err(dev, "failed to request IRQ #%d\n", irq);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +
> > +}
> > +
> > +static int opt3001_remove(struct i2c_client *client)
> > +{
> > +	struct opt3001 *opt =3D i2c_get_clientdata(client);
> > +	int ret;
> > +	u16 reg;
> > +
>=20
> So here you are shutting down the part before removing the userspace inte=
rfaces
> (due to using the devm_iio_unregister).  I'm guessing this might create s=
ome
> interesting race conditions.  Would prefer to see non devm versions of the
> register and irq request to ensure the ordering is exactly what we would
> expect.

this will cause no problems whatsoever. The device is *always* shutdown
unless I left a continuous transfer running. This is coping with that
only situation. It's also unnecessary to check if we have a continuous
transfer running because shutting down something which is already
shutdown won't cause any problems with this device.

Dropping devm_* would just add pointless complexity to the remove
function.

--=20
balbi

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT7OxaAAoJEIaOsuA1yqREMTwP/10dUvAng7DrfNotRuV81K5+
bpv/7EbzOV1LHpRaptlQpRhjavxLeYMlR0GJQEFLskLXm1mEVVyhqfETWVGk+ZL0
JauJZ1xtO0ahOCSO6lb0uLKdXQK6UHr764/2UlfAn3ROjeB8dKNTYs2EzgepLOaB
hbkQnuNjnSDLSKkd22bUX3oaLC1Kn4Z7P4v0TQVTnhvNp5hxDP/Fae4FGGtFgTmP
3oo6/oqdxDhfWhgCqlFa1hRSvG/XGAXtvz9M0Q8rH7mQ+lCeb37YCGe4HnCCSuft
UWfKYsjOiRxp3p1Phsm95Zd79zj37KECwTp4dmCp2gyvBY1CSgmyr0rGtJEgRb9r
txVGz1nyzhiVzGu1vRFg70DYS1JGvI5MxfaWSjOb7pDzRlXsZOOZSYX1a9yVBdxE
+kELKrMhZvt9ibYyc0ZybkbyKgysSPSHYp/3915Gw3amRMUm6rmM8o0r0gV9k1rW
GHpaSM7HAPRv9LhJ2deiy+qHBJ1Fl6JuqiO2kC4dbuYEYS7tbQTh2DeQ8g5futrH
78KFiPTOS4Kvh9FNCGrsqym68Z93lvLGvMZqtjnggr09dD5txcFSiYNCdOHM+7oV
X67B9HjVf5GETcuR5P4Betu3sANcSgkfisyrQosLGK4lXNMN1VLLa1MKCjHupg5q
rMAYZq4bajLE+tJEct/K
=csBn
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
