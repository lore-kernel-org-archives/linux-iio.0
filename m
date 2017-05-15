Return-Path: <SRS0=/Mym=4V=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 15 May 2017 11:11:48 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	wens@csie.org, clabbe.montjoie@gmail.com, linux-iio@vger.kernel.org,
	thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sun4i-gpadc-iio: fix parent device being used
 in devm function
Message-ID: <20170515091148.gk2zvtjy5bdpbfzt@flea.home>
References: <20170515073902.25994-1-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ouvhrf2ifu2lmgol"
In-Reply-To: <20170515073902.25994-1-quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>


--ouvhrf2ifu2lmgol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 09:39:02AM +0200, Quentin Schulz wrote:
> For the sake of DT binding stability, this IIO driver is a child of an
> MFD driver for Allwinner A10, A13 and A31 because there already exists a
> DT binding for this IP. The MFD driver has a DT node but the IIO driver
> does not.
>=20
> The IIO device registers the temperature sensor in the thermal framework
> using the DT node of the parent, the MFD device, so the thermal
> framework could match the phandle to the MFD device in the DT and the
> struct device used to register in the thermal framework.
>=20
> devm_thermal_zone_of_sensor_register was previously used to register the
> thermal sensor with the parent struct device of the IIO device,
> representing the MFD device. By doing so, we registered actually the
> parent in the devm routine and not the actual IIO device.
>=20
> This lead to the devm unregister function not being called when the IIO
> module driver is removed. It resulted in the thermal framework still
> polling the get_temp function of the IIO module while the device doesn't
> exist anymore, thus generated a kernel panic.
>=20
> Use the non-devm function instead and do the unregister manually in the
> remove function.
>=20
> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index b23527309088..0d3df17be405 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -105,6 +105,7 @@ struct sun4i_gpadc_iio {
>  	bool				no_irq;
>  	/* prevents concurrent reads of temperature and ADC */
>  	struct mutex			mutex;
> +	struct thermal_zone_device	*tzd;
>  };
> =20
>  #define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
> @@ -502,7 +503,6 @@ static int sun4i_gpadc_probe_dt(struct platform_devic=
e *pdev,
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(indio_dev);
>  	const struct of_device_id *of_dev;
> -	struct thermal_zone_device *tzd;
>  	struct resource *mem;
>  	void __iomem *base;
>  	int ret;
> @@ -532,13 +532,13 @@ static int sun4i_gpadc_probe_dt(struct platform_dev=
ice *pdev,
>  	if (!IS_ENABLED(CONFIG_THERMAL_OF))
>  		return 0;
> =20
> -	tzd =3D devm_thermal_zone_of_sensor_register(&pdev->dev, 0, info,
> -						   &sun4i_ts_tz_ops);
> -	if (IS_ERR(tzd))
> +	info->tzd =3D thermal_zone_of_sensor_register(&pdev->dev, 0, info,
> +						    &sun4i_ts_tz_ops);
> +	if (IS_ERR(info->tzd))
>  		dev_err(&pdev->dev, "could not register thermal sensor: %ld\n",
> -			PTR_ERR(tzd));
> +			PTR_ERR(info->tzd));
> =20
> -	return PTR_ERR_OR_ZERO(tzd);
> +	return PTR_ERR_OR_ZERO(info->tzd);
>  }
> =20
>  static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
> @@ -584,15 +584,14 @@ static int sun4i_gpadc_probe_mfd(struct platform_de=
vice *pdev,
>  		 * of_node, and the device from this driver as third argument to
>  		 * return the temperature.
>  		 */
> -		struct thermal_zone_device *tzd;
> -		tzd =3D devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0,
> -							   info,
> -							   &sun4i_ts_tz_ops);
> -		if (IS_ERR(tzd)) {
> +		info->tzd =3D thermal_zone_of_sensor_register(pdev->dev.parent, 0,
> +							    info,
> +							    &sun4i_ts_tz_ops);
> +		if (IS_ERR(info->tzd)) {
>  			dev_err(&pdev->dev,
>  				"could not register thermal sensor: %ld\n",
> -				PTR_ERR(tzd));
> -			return PTR_ERR(tzd);
> +				PTR_ERR(info->tzd));
> +			return PTR_ERR(info->tzd);
>  		}
>  	} else {
>  		indio_dev->num_channels =3D
> @@ -688,6 +687,12 @@ static int sun4i_gpadc_remove(struct platform_device=
 *pdev)
> =20
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +
> +	if (pdev->dev.of_node)
> +		thermal_zone_of_sensor_unregister(&pdev->dev, info->tzd);
> +	else
> +		thermal_zone_of_sensor_unregister(pdev->dev.parent, info->tzd);
> +

Can't we just store the device used to create the zone in the
structure as well, that would avoid that non-trivial logic.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ouvhrf2ifu2lmgol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZGXDUAAoJEBx+YmzsjxAgM0EP/R8vOvxksXw8DHS6ddZBdvy+
kRhKTYbSlUzWsnqa5obtc5ew3u6k6xV+U3guR5/08ZEEMUjaN22XT3UdFj/1KIs9
yWwR7NBZpOgrAKXCo0DTgfVp+cnb4iOoyemuBGcvaqeBlOMFJr1GszD5kREzPDIp
cZcE8JkA2O7mqjORsLpi0TFlneXsVH8DeTjaFv+oACECm3QT5STfR05JUa2fGckW
6ml2Hky56G2LlO7fhopZkAouYQmTkeYXDwEqZJI05zSWmEO1cU26d1Tq1dMvJmr2
kfBtk3X+oknapvqrse1+8PY9rg3Eqk34EsNUUh2+OCVHBeIqcmzuaRkoFpuasfC7
n/3u8065qdUfmxjulWVWBCSqxKbM5asa1qrS19dwfKLo6l+YL7VJcdMURNI5VdBa
jtkFGUVWkCN2kvp0IhbBW1FHRgYfOiWKLO65wbGSruB/brTzsMzwF3HKpY7acQxB
5+Q49ACoPCKsUItxXYNOSLSz7lXG8Sp/hITiL3avQRQ6oDjs2tYn04MKmp1jqQhx
5FPyO7/xILRymLqDuLuKJKm55FgI6CucZAKTBts/kR2m1WRMCocBgq9jQDw7KVfd
IxVrYBEuB+SerDeFe4t3i9uJ7vx8R3ZehYHHUCDO0cc0Bo0XNnfbyQ7xLxmEZX9y
ZUolOtFV1pwlrLkIGZOR
=u65K
-----END PGP SIGNATURE-----

--ouvhrf2ifu2lmgol--
