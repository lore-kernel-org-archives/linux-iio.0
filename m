Return-Path: <SRS0=+hvP=ER=free-electrons.com=quentin.schulz@kernel.org>
Date: Mon, 22 Jan 2018 09:22:25 +0100
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
	mark.rutland@arm.com, wens@csie.org, sre@kernel.org,
	linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
	lee.jones@linaro.org, linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com,
	julian.calaby@gmail.com
Subject: Re: [PATCH v3 07/16] iio: adc: axp20x_adc: add support for AXP813 ADC
Message-ID: <20180122082225.ovh4l4mu7uwnph3d@qschulz>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <e9e6b1e841f6b2ce66076d3a4031e3579ead8486.1516012352.git-series.quentin.schulz@free-electrons.com>
 <20180121122655.0efd9480@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3kfaxkk7ftnpn2o5"
In-Reply-To: <20180121122655.0efd9480@archlinux>
List-ID: <linux-iio@vger.kernel.org>


--3kfaxkk7ftnpn2o5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Jan 21, 2018 at 12:26:55PM +0000, Jonathan Cameron wrote:
> On Mon, 15 Jan 2018 11:33:41 +0100
> Quentin Schulz <quentin.schulz@free-electrons.com> wrote:
>=20
> > The X-Powers AXP813 PMIC is really close to what is already done for
> > AXP20X/AXP22X.
> >=20
> > There are two pairs of bits to set the rate (one for Voltage and Current
> > measurements and one for TS/GPIO0 voltage measurements) instead of one.
> >=20
> > The register to set the ADC rates is different from the one for
> > AXP20X/AXP22X.
> >=20
> > GPIO0 can be used as an ADC (measuring Volts) unlike for AXP22X.
> >=20
> > The scales to apply to the different inputs are unlike the ones from
> > AXP20X and AXP22X.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>=20
> One thing that might be nice to tidy up in this driver though.
>=20
> CHECK   drivers/iio/adc/axp20x_adc.c
> drivers/iio/adc/axp20x_adc.c:548:26: warning: dubious: !x & y
> drivers/iio/adc/axp20x_adc.c:553:26: warning: dubious: !x & y
>=20
> Those are 'interesting' code constructions.  It may be worth being
> a little more verbose to keep sparse happy and suppress the
> warning.
>=20

Would adding a val =3D !!val; before the call to the macro be "verbose"
enough for you?

Sparse does not complain anymore after that.

Thanks,
Quentin

> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/adc/axp20x_adc.c | 123 +++++++++++++++++++++++++++++++++++=
+-
> >  include/linux/mfd/axp20x.h   |   2 +-
> >  2 files changed, 125 insertions(+)
> >=20
> > diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> > index 3968053..7cdb8bc 100644
> > --- a/drivers/iio/adc/axp20x_adc.c
> > +++ b/drivers/iio/adc/axp20x_adc.c
> > @@ -35,8 +35,13 @@
> >  #define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
> > =20
> >  #define AXP20X_ADC_RATE_MASK			GENMASK(7, 6)
> > +#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
> > +#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_=
RATE_MASK)
> >  #define AXP20X_ADC_RATE_HZ(x)			((ilog2((x) / 25) << 6) & AXP20X_ADC_R=
ATE_MASK)
> >  #define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_=
RATE_MASK)
> > +#define AXP813_TS_GPIO0_ADC_RATE_HZ(x)		AXP20X_ADC_RATE_HZ(x)
> > +#define AXP813_V_I_ADC_RATE_HZ(x)		((ilog2((x) / 100) << 4) & AXP813_V=
_I_ADC_RATE_MASK)
> > +#define AXP813_ADC_RATE_HZ(x)			(AXP20X_ADC_RATE_HZ(x) | AXP813_V_I_AD=
C_RATE_HZ(x))
> > =20
> >  #define AXP20X_ADC_CHANNEL(_channel, _name, _type, _reg)	\
> >  	{							\
> > @@ -95,6 +100,12 @@ enum axp22x_adc_channel_i {
> >  	AXP22X_BATT_DISCHRG_I,
> >  };
> > =20
> > +enum axp813_adc_channel_v {
> > +	AXP813_TS_IN =3D 0,
> > +	AXP813_GPIO0_V,
> > +	AXP813_BATT_V,
> > +};
> > +
> >  static struct iio_map axp20x_maps[] =3D {
> >  	{
> >  		.consumer_dev_name =3D "axp20x-usb-power-supply",
> > @@ -197,6 +208,25 @@ static const struct iio_chan_spec axp22x_adc_chann=
els[] =3D {
> >  			   AXP20X_BATT_DISCHRG_I_H),
> >  };
> > =20
> > +static const struct iio_chan_spec axp813_adc_channels[] =3D {
> > +	{
> > +		.type =3D IIO_TEMP,
> > +		.address =3D AXP22X_PMIC_TEMP_H,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_OFFSET),
> > +		.datasheet_name =3D "pmic_temp",
> > +	},
> > +	AXP20X_ADC_CHANNEL(AXP813_GPIO0_V, "gpio0_v", IIO_VOLTAGE,
> > +			   AXP288_GP_ADC_H),
> > +	AXP20X_ADC_CHANNEL(AXP813_BATT_V, "batt_v", IIO_VOLTAGE,
> > +			   AXP20X_BATT_V_H),
> > +	AXP20X_ADC_CHANNEL(AXP22X_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
> > +			   AXP20X_BATT_CHRG_I_H),
> > +	AXP20X_ADC_CHANNEL(AXP22X_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRE=
NT,
> > +			   AXP20X_BATT_DISCHRG_I_H),
> > +};
> > +
> >  static int axp20x_adc_raw(struct iio_dev *indio_dev,
> >  			  struct iio_chan_spec const *chan, int *val)
> >  {
> > @@ -243,6 +273,18 @@ static int axp22x_adc_raw(struct iio_dev *indio_de=
v,
> >  	return IIO_VAL_INT;
> >  }
> > =20
> > +static int axp813_adc_raw(struct iio_dev *indio_dev,
> > +			  struct iio_chan_spec const *chan, int *val)
> > +{
> > +	struct axp20x_adc_iio *info =3D iio_priv(indio_dev);
> > +
> > +	*val =3D axp20x_read_variable_width(info->regmap, chan->address, 12);
> > +	if (*val < 0)
> > +		return *val;
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> >  static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
> >  {
> >  	switch (channel) {
> > @@ -273,6 +315,24 @@ static int axp20x_adc_scale_voltage(int channel, i=
nt *val, int *val2)
> >  	}
> >  }
> > =20
> > +static int axp813_adc_scale_voltage(int channel, int *val, int *val2)
> > +{
> > +	switch (channel) {
> > +	case AXP813_GPIO0_V:
> > +		*val =3D 0;
> > +		*val2 =3D 800000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	case AXP813_BATT_V:
> > +		*val =3D 1;
> > +		*val2 =3D 100000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int axp20x_adc_scale_current(int channel, int *val, int *val2)
> >  {
> >  	switch (channel) {
> > @@ -342,6 +402,26 @@ static int axp22x_adc_scale(struct iio_chan_spec c=
onst *chan, int *val,
> >  	}
> >  }
> > =20
> > +static int axp813_adc_scale(struct iio_chan_spec const *chan, int *val,
> > +			    int *val2)
> > +{
> > +	switch (chan->type) {
> > +	case IIO_VOLTAGE:
> > +		return axp813_adc_scale_voltage(chan->channel, val, val2);
> > +
> > +	case IIO_CURRENT:
> > +		*val =3D 1;
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_TEMP:
> > +		*val =3D 100;
> > +		return IIO_VAL_INT;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int ch=
annel,
> >  				     int *val)
> >  {
> > @@ -425,6 +505,26 @@ static int axp22x_read_raw(struct iio_dev *indio_d=
ev,
> >  	}
> >  }
> > =20
> > +static int axp813_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan, int *val,
> > +			   int *val2, long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		*val =3D -2667;
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return axp813_adc_scale(chan, val, val2);
> > +
> > +	case IIO_CHAN_INFO_RAW:
> > +		return axp813_adc_raw(indio_dev, chan, val);
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int axp20x_write_raw(struct iio_dev *indio_dev,
> >  			    struct iio_chan_spec const *chan, int val, int val2,
> >  			    long mask)
> > @@ -470,6 +570,10 @@ static const struct iio_info axp22x_adc_iio_info =
=3D {
> >  	.read_raw =3D axp22x_read_raw,
> >  };
> > =20
> > +static const struct iio_info axp813_adc_iio_info =3D {
> > +	.read_raw =3D axp813_read_raw,
> > +};
> > +
> >  static int axp20x_adc_rate(struct axp20x_adc_iio *info, int rate)
> >  {
> >  	return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> > @@ -484,6 +588,13 @@ static int axp22x_adc_rate(struct axp20x_adc_iio *=
info, int rate)
> >  				  AXP22X_ADC_RATE_HZ(rate));
> >  }
> > =20
> > +static int axp813_adc_rate(struct axp20x_adc_iio *info, int rate)
> > +{
> > +	return regmap_update_bits(info->regmap, AXP813_ADC_RATE,
> > +				 AXP813_ADC_RATE_MASK,
> > +				 AXP813_ADC_RATE_HZ(rate));
> > +}
> > +
> >  struct axp_data {
> >  	const struct iio_info		*iio_info;
> >  	int				num_channels;
> > @@ -515,9 +626,20 @@ static const struct axp_data axp22x_data =3D {
> >  	.maps =3D axp22x_maps,
> >  };
> > =20
> > +static const struct axp_data axp813_data =3D {
> > +	.iio_info =3D &axp813_adc_iio_info,
> > +	.num_channels =3D ARRAY_SIZE(axp813_adc_channels),
> > +	.channels =3D axp813_adc_channels,
> > +	.adc_en1_mask =3D AXP22X_ADC_EN1_MASK,
> > +	.adc_rate =3D axp813_adc_rate,
> > +	.adc_en2 =3D false,
> > +	.maps =3D axp22x_maps,
> > +};
> > +
> >  static const struct of_device_id axp20x_adc_of_match[] =3D {
> >  	{ .compatible =3D "x-powers,axp209-adc", .data =3D (void *)&axp20x_da=
ta, },
> >  	{ .compatible =3D "x-powers,axp221-adc", .data =3D (void *)&axp22x_da=
ta, },
> > +	{ .compatible =3D "x-powers,axp813-adc", .data =3D (void *)&axp813_da=
ta, },
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
> > @@ -525,6 +647,7 @@ MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
> >  static const struct platform_device_id axp20x_adc_id_match[] =3D {
> >  	{ .name =3D "axp20x-adc", .driver_data =3D (kernel_ulong_t)&axp20x_da=
ta, },
> >  	{ .name =3D "axp22x-adc", .driver_data =3D (kernel_ulong_t)&axp22x_da=
ta, },
> > +	{ .name =3D "axp813-adc", .driver_data =3D (kernel_ulong_t)&axp813_da=
ta, },
> >  	{ /* sentinel */ },
> >  };
> >  MODULE_DEVICE_TABLE(platform, axp20x_adc_id_match);
> > diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> > index 080798f..82bf774 100644
> > --- a/include/linux/mfd/axp20x.h
> > +++ b/include/linux/mfd/axp20x.h
> > @@ -266,6 +266,8 @@ enum axp20x_variants {
> >  #define AXP288_RT_BATT_V_H		0xa0
> >  #define AXP288_RT_BATT_V_L		0xa1
> > =20
> > +#define AXP813_ADC_RATE			0x85
> > +
> >  /* Fuel Gauge */
> >  #define AXP288_FG_RDC1_REG          0xba
> >  #define AXP288_FG_RDC0_REG          0xbb
>=20

--3kfaxkk7ftnpn2o5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJaZZ89AAoJEIS4mnU+4PGjZpoQAImQDkOEJwrEaVzc8JyPDz63
d/qS2o4CmQW490wG2m6MDE36oaqvF2xsP4nyeMheMWM2/ClRds65a5K+Me4W9mN6
Tf6zvnzdvFQxIMbTN04AQ+pZyasgfUNSwcnLHVaeGhRHGy4i6B2hsqVSyQVLKII6
8SddtRPtDZtx3VpL+Do7LYBjH5pHS0t9ot8v5VQx480SDU/oG5t58/aEWa0NqYeN
ZstqSSy4nZQTPsx8zV7j/OlsY2PzMtS/LLgxf7B03NzXC7qGIklW3L5MygXSohlr
JhkGsuQX/0+Ij5aLFFChEm3p2Hc1SOPANoX4AUxVfBnqWG1tSKkyCAgY7XRfU+RE
agcurDGVCVa04q7xuv6rb2KcGRoXOqztjDWfVkhMdX3KlynvQ6xvCbcszlp9ixxu
4IRQL9f6xzv+5t9D2SDjBwNxl3ZfVJ0Gem7EsjFt7vNs5/gvibSIryT5Ff+VBHeQ
WOHvf4nOStD8dr1oeA9w0YoIP5ueY5Xd5hkFsJYr6KAMd9vQfXT13EB6aCM+tsz1
S7pbdw02Aq7aePUKDS3fSl5+xWyVvikHTxsa98RPT/EUX+FBPOzUlgLfweAbchbO
qIDjpnFwmfeWhPCOo32FTFzeG6Zo5ZX9k0TlXr76JxBzZv+iwfMltvHjfvCbIyjp
82oDLbFMFUIp/3skUDv1
=3cHw
-----END PGP SIGNATURE-----

--3kfaxkk7ftnpn2o5--
