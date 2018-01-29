Return-Path: <SRS0=uf+1=EY=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 29 Jan 2018 10:46:50 +0100
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
Subject: Re: [PATCH v2 09/16] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
Message-ID: <20180129094650.kpbhtbcpo42huadl@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-10-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gd24cx5qwqzi4jit"
In-Reply-To: <20180128232919.12639-10-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--gd24cx5qwqzi4jit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 12:29:12AM +0100, Philipp Rossak wrote:
> This patch adds support for the H3 ths sensor.
>=20
> The H3 supports interrupts. The interrupt is configured to update the
> the sensor values every second. The calibration data is writen at the
> begin of the init process.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 86 +++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/sun4i-gpadc.h   | 22 ++++++++++
>  2 files changed, 108 insertions(+)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index b7b5451226b0..8196203d65fe 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -61,6 +61,9 @@ struct sun4i_gpadc_iio;
>  static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info);
>  static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info);
> =20
> +static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info);
> +static int sunxi_ths_sample_end(struct sun4i_gpadc_iio *info);
> +
>  struct gpadc_data {
>  	int		temp_offset;
>  	int		temp_scale;
> @@ -71,6 +74,10 @@ struct gpadc_data {
>  	unsigned int	temp_data[MAX_SENSOR_COUNT];
>  	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>  	int		(*sample_end)(struct sun4i_gpadc_iio *info);
> +	u32		ctrl0_map;
> +	u32		ctrl2_map;
> +	u32		sensor_en_map;
> +	u32		filter_map;

You can use a regmap_field for that.

>  	u32		irq_clear_map;
>  	u32		irq_control_map;
>  	bool		has_bus_clk;
> @@ -138,6 +145,31 @@ static const struct gpadc_data sun8i_a33_gpadc_data =
=3D {
>  	.support_irq =3D false,
>  };
> =20
> +static const struct gpadc_data sun8i_h3_ths_data =3D {
> +	.temp_offset =3D -1791,
> +	.temp_scale =3D -121,
> +	.temp_data =3D {SUN8I_H3_THS_TDATA0, 0, 0, 0},
> +	.sample_start =3D sunxi_ths_sample_start,
> +	.sample_end =3D sunxi_ths_sample_end,
> +	.has_bus_clk =3D true,
> +	.has_bus_rst =3D true,
> +	.has_mod_clk =3D true,
> +	.sensor_count =3D 1,
> +	.supports_nvmem =3D true,
> +	.support_irq =3D true,
> +	.ctrl0_map =3D SUN4I_GPADC_CTRL0_T_ACQ(0xff),
> +	.ctrl2_map =3D SUN8I_H3_THS_ACQ1(0x3f),
> +	.sensor_en_map =3D SUN8I_H3_THS_TEMP_SENSE_EN0,
> +	.filter_map =3D SUN4I_GPADC_CTRL3_FILTER_EN |
> +		SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2),
> +	.irq_clear_map =3D SUN8I_H3_THS_INTS_ALARM_INT_0 |
> +			SUN8I_H3_THS_INTS_SHUT_INT_0   |
> +			SUN8I_H3_THS_INTS_TDATA_IRQ_0  |
> +			SUN8I_H3_THS_INTS_ALARM_OFF_0,
> +	.irq_control_map =3D SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
> +		SUN8I_H3_THS_TEMP_PERIOD(0x7),
> +};
> +
>  struct sun4i_gpadc_iio {
>  	struct iio_dev			*indio_dev;
>  	struct completion		completion;
> @@ -462,6 +494,16 @@ static int sun4i_gpadc_sample_end(struct sun4i_gpadc=
_iio *info)
>  	return 0;
>  }
> =20
> +static int sunxi_ths_sample_end(struct sun4i_gpadc_iio *info)
> +{
> +	/* Disable ths interrupt */
> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC, 0x0);
> +	/* Disable temperature sensor */
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2, 0x0);
> +
> +	return 0;
> +}
> +
>  static int sun4i_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(dev_get_drvdata(dev));
> @@ -473,6 +515,17 @@ static int sun4i_gpadc_runtime_suspend(struct device=
 *dev)
>  	return info->data->sample_end(info);
>  }
> =20
> +static void sunxi_calibrate(struct sun4i_gpadc_iio *info)
> +{
> +	if (info->has_calibration_data[0])
> +		regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
> +			info->calibration_data[0]);
> +
> +	if (info->has_calibration_data[1])
> +		regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
> +			info->calibration_data[1]);
> +}
> +
>  static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
>  {
>  	/* clkin =3D 6MHz */
> @@ -492,6 +545,35 @@ static int sun4i_gpadc_sample_start(struct sun4i_gpa=
dc_iio *info)
>  	return 0;
>  }
> =20
> +static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info)

Please remain consistent with the prefixes used in the driver

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--gd24cx5qwqzi4jit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu7YkACgkQ0rTAlCFN
r3TTZQ/9E9HtoW3omwSUySaUVMtzKl9cy+xoWn6jUQBjnbewDgs180WLnCm+sk+z
iN0UPMxTJ8T02KF8p7cq9JdWqYZHWdE1L8IBFLdrG3OJGVLnhbO+lubQ/e0wj0Oa
LuDoIqnu11rvVwS4yzpDHwwmkgAJfql7fgTweK3DYYKXAjaz6aLiBRXWMEJXvnHz
17yqtsydbdc++vu6PkcjHu6p3jK3HpKJtRShsNMomi+CCQ441/zMnEk1EuYJZ1XY
8ggQp5B5l33E5IpPdjQc3uGFUajVpAzO/k5ocWE/RZptMO5CfUXdG2EZxOSOHSv+
XRzc0NeWo8w0Tn1jU+vkhvsqMU6rdbFqqA7buhcwx1R0cog5wLVKf0kW/wNJ6vBT
QYUvGuNn5HIjg6ZkyKfMxJ9Fkwkj54Fnr6VJDcwGTZoqLsWJnJKzdaiIyxJj7cA4
KpczFC99CFzsy5X0f2F/ppFQTRG79V1uJrfgZ1XwjoUOMs0OUJBGEMQ6z6ixMZLy
GQQH7nlhRtKV9RNa1I/oIM4UGTxWRtvTT3N3cGJdAyNXsVkfSknJvfHwz6hk5Pxz
rr6mJw2eFcB4i16bb5hxj7wO4bPdq3YGqoIfjQzBA6M+hFNfgAa2jmavy/LLyYMH
U5tRZg7gipgEQ3hzi6Ybh6dTqwWqFuJ42m3vfbcKVFPzBaP3SKM=
=JOI2
-----END PGP SIGNATURE-----

--gd24cx5qwqzi4jit--
