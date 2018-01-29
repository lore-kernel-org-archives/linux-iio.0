Return-Path: <SRS0=uf+1=EY=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 29 Jan 2018 10:37:38 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
	wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
	rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
	krzk@kernel.org, quentin.schulz@free-electrons.com, icenowy@aosc.io,
	edu.molinas@gmail.com, singhalsimran0@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 06/16] iio: adc: sun4i-gpadc-iio: rework: support
 multiple sensors
Message-ID: <20180129093738.5edpjclcbtsoneiw@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-7-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="htifghagwui5ssmn"
In-Reply-To: <20180128232919.12639-7-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--htifghagwui5ssmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 29, 2018 at 12:29:09AM +0100, Philipp Rossak wrote:
> For adding newer sensor some basic rework of the code is necessary.
>=20
> This patch reworks the driver to be able to handle more than one
> thermal sensor. Newer SoC like the A80 have 4 thermal sensors.
> Because of this the maximal sensor count value was set to 4.
>=20
> The sensor_id value is set during sensor registration and is for each
> registered sensor indiviual. This makes it able to differntiate the
> sensors when the value is read from the register.
>=20
> In function sun4i_gpadc_read_raw(), the sensor number of the ths sensor
> was directly set to 0 (sun4i_gpadc_temp_read(x,x,0)). This selects
> in the temp_read function automatically sensor 0. A check for the
> sensor_id is here not required since the old sensors only have one
> thermal sensor. In addition to that is the sun4i_gpadc_read_raw()
> function only used by the "older" sensors (before A33) where the
> thermal sensor was a cobination of an adc and a thermal sensor.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 36 +++++++++++++++++++++++----------=
---
>  include/linux/mfd/sun4i-gpadc.h   |  3 +++
>  2 files changed, 26 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index 51ec0104d678..ac9ad2f8232f 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -67,12 +67,13 @@ struct gpadc_data {
>  	unsigned int	tp_adc_select;
>  	unsigned int	(*adc_chan_select)(unsigned int chan);
>  	unsigned int	adc_chan_mask;
> -	unsigned int	temp_data;
> +	unsigned int	temp_data[MAX_SENSOR_COUNT];
>  	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>  	int		(*sample_end)(struct sun4i_gpadc_iio *info);
>  	bool		has_bus_clk;
>  	bool		has_bus_rst;
>  	bool		has_mod_clk;
> +	int		sensor_count;
>  };
> =20
>  static const struct gpadc_data sun4i_gpadc_data =3D {
> @@ -82,9 +83,10 @@ static const struct gpadc_data sun4i_gpadc_data =3D {
>  	.tp_adc_select =3D SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
>  	.adc_chan_select =3D &sun4i_gpadc_chan_select,
>  	.adc_chan_mask =3D SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
> -	.temp_data =3D SUN4I_GPADC_TEMP_DATA,
> +	.temp_data =3D {SUN4I_GPADC_TEMP_DATA, 0, 0, 0},
>  	.sample_start =3D sun4i_gpadc_sample_start,
>  	.sample_end =3D sun4i_gpadc_sample_end,
> +	.sensor_count =3D 1,
>  };
> =20
>  static const struct gpadc_data sun5i_gpadc_data =3D {
> @@ -94,9 +96,10 @@ static const struct gpadc_data sun5i_gpadc_data =3D {
>  	.tp_adc_select =3D SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
>  	.adc_chan_select =3D &sun4i_gpadc_chan_select,
>  	.adc_chan_mask =3D SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
> -	.temp_data =3D SUN4I_GPADC_TEMP_DATA,
> +	.temp_data =3D {SUN4I_GPADC_TEMP_DATA, 0, 0, 0},
>  	.sample_start =3D sun4i_gpadc_sample_start,
>  	.sample_end =3D sun4i_gpadc_sample_end,
> +	.sensor_count =3D 1,
>  };
> =20
>  static const struct gpadc_data sun6i_gpadc_data =3D {
> @@ -106,18 +109,20 @@ static const struct gpadc_data sun6i_gpadc_data =3D=
 {
>  	.tp_adc_select =3D SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
>  	.adc_chan_select =3D &sun6i_gpadc_chan_select,
>  	.adc_chan_mask =3D SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
> -	.temp_data =3D SUN4I_GPADC_TEMP_DATA,
> +	.temp_data =3D {SUN4I_GPADC_TEMP_DATA, 0, 0, 0},
>  	.sample_start =3D sun4i_gpadc_sample_start,
>  	.sample_end =3D sun4i_gpadc_sample_end,
> +	.sensor_count =3D 1,
>  };
> =20
>  static const struct gpadc_data sun8i_a33_gpadc_data =3D {
>  	.temp_offset =3D -1662,
>  	.temp_scale =3D 162,
>  	.tp_mode_en =3D SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
> -	.temp_data =3D SUN4I_GPADC_TEMP_DATA,
> +	.temp_data =3D {SUN4I_GPADC_TEMP_DATA, 0, 0, 0},
>  	.sample_start =3D sun4i_gpadc_sample_start,
>  	.sample_end =3D sun4i_gpadc_sample_end,
> +	.sensor_count =3D 1,
>  };
> =20
>  struct sun4i_gpadc_iio {
> @@ -135,6 +140,7 @@ struct sun4i_gpadc_iio {
>  	struct clk			*bus_clk;
>  	struct clk			*mod_clk;
>  	struct reset_control		*reset;
> +	int				sensor_id;
>  	/* prevents concurrent reads of temperature and ADC */
>  	struct mutex			mutex;
>  	struct thermal_zone_device	*tzd;
> @@ -302,14 +308,15 @@ static int sun4i_gpadc_adc_read(struct iio_dev *ind=
io_dev, int channel,
>  	return sun4i_gpadc_read(indio_dev, channel, val, info->fifo_data_irq);
>  }
> =20
> -static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
> +static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val,
> +				int sensor)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(indio_dev);
> =20
>  	if (info->no_irq) {
>  		pm_runtime_get_sync(indio_dev->dev.parent);
> =20
> -		regmap_read(info->regmap, info->data->temp_data, val);
> +		regmap_read(info->regmap, info->data->temp_data[sensor], val);
> =20
>  		pm_runtime_mark_last_busy(indio_dev->dev.parent);
>  		pm_runtime_put_autosuspend(indio_dev->dev.parent);
> @@ -356,7 +363,7 @@ static int sun4i_gpadc_read_raw(struct iio_dev *indio=
_dev,
>  			ret =3D sun4i_gpadc_adc_read(indio_dev, chan->channel,
>  						   val);
>  		else
> -			ret =3D sun4i_gpadc_temp_read(indio_dev, val);
> +			ret =3D sun4i_gpadc_temp_read(indio_dev, val, 0);
> =20
>  		if (ret)
>  			return ret;
> @@ -470,7 +477,7 @@ static int sun4i_gpadc_get_temp(void *data, int *temp)
>  	struct sun4i_gpadc_iio *info =3D data;
>  	int val, scale, offset;
> =20
> -	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
> +	if (sun4i_gpadc_temp_read(info->indio_dev, &val, info->sensor_id))
>  		return -ETIMEDOUT;
> =20
>  	sun4i_gpadc_temp_scale(info->indio_dev, &scale);
> @@ -712,7 +719,7 @@ static int sun4i_gpadc_probe(struct platform_device *=
pdev)
>  {
>  	struct sun4i_gpadc_iio *info;
>  	struct iio_dev *indio_dev;
> -	int ret;
> +	int ret, i;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>  	if (!indio_dev)
> @@ -745,9 +752,12 @@ static int sun4i_gpadc_probe(struct platform_device =
*pdev)
>  	pm_runtime_enable(&pdev->dev);
> =20
>  	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> -		info->tzd =3D thermal_zone_of_sensor_register(info->sensor_device,
> -							    0, info,
> -							    &sun4i_ts_tz_ops);
> +		for (i =3D 0; i < info->data->sensor_count; i++) {
> +			info->sensor_id =3D i;
> +			info->tzd =3D thermal_zone_of_sensor_register(
> +					info->sensor_device,
> +					i, info, &sun4i_ts_tz_ops);
> +		}

I'm not sure how that works. Isn't the info structure shared between
all the sensors? The sensor_id value would be always set to the last
sensor then.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--htifghagwui5ssmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu62EACgkQ0rTAlCFN
r3S0KA//Z6QtY14DZGa7sO2cRE+vfDH4TtUmGpczbdQUuv03pza3YnLyBN4P7f8U
047pAo4kuwaHARM0kErGTlj2i+07qtsdtrraeFHStL6VM50+XyiqCZEmYGeWv7Th
UNtsgphdv3rajd15smRNKZrkLr9fY/GBhsaiW6ICCb+/oAF7wJ2PGZvPcSmeKLlZ
qDkRWKwvARBq7OKXhPAY39/UM+jYYwVtBktgH9E+RZn7OyZuIWNWw8Dn4yiggy7K
hDHhj46s6ObMZCrEe2LU+CT+an4pYNScKUMtg5SszvzbRN7NqhyD1dgSaIH2/SvJ
Fvc5Dl3vpzWEviJ88m4eC90T5nOzxcm59fXDQEQQkorJB11WBc7AZ6K6rab9AUha
wByfmnVQ6DHvWfZDVp+Zv2Fkqp7I4pRyGI/vlCkwjhP3pvrQfqGn0BnOQPUSbev9
nbWifnugTabecLYrAP+xY7QKcurK0z9d8+HSDFFTqjgMhO2F5Bg9/e9Vr83sdP26
pX8nDFFj83lTLMJtpGsZytS0x5vQ7AGAqmQlM1Nue1He8vk7vNS9f/HXuXaZH3v2
WZiykgpar9swhk+gt1tfXepInXSehiGLXKvOMs0+2uydhWDe6Aun4u8zCRUM/VEj
rsanOvFPItVrnszGMKRpeWsc7aoAwRcmxEJ2M7DYdBLhQ6fkLAg=
=ody9
-----END PGP SIGNATURE-----

--htifghagwui5ssmn--
