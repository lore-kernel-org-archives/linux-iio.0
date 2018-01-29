Return-Path: <SRS0=uf+1=EY=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 29 Jan 2018 10:40:45 +0100
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
Subject: Re: [PATCH v2 07/16] iio: adc: sun4i-gpadc-iio: rework: support
 nvmem calibration data
Message-ID: <20180129094045.sagz2dnzvdadd4yx@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-8-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5tc6bnwyrlietxpn"
In-Reply-To: <20180128232919.12639-8-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--5tc6bnwyrlietxpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 12:29:10AM +0100, Philipp Rossak wrote:
> This patch reworks the driver to support nvmem calibration cells.
> The driver checks if the nvmem calibration is supported and reads out
> the nvmem.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 44 +++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index ac9ad2f8232f..74eeb5cd5218 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -74,6 +75,7 @@ struct gpadc_data {
>  	bool		has_bus_rst;
>  	bool		has_mod_clk;
>  	int		sensor_count;
> +	bool		supports_nvmem;

I think you should add some documentation along with all the fields
you're adding.

>  };
> =20
>  static const struct gpadc_data sun4i_gpadc_data =3D {
> @@ -87,6 +89,7 @@ static const struct gpadc_data sun4i_gpadc_data =3D {
>  	.sample_start =3D sun4i_gpadc_sample_start,
>  	.sample_end =3D sun4i_gpadc_sample_end,
>  	.sensor_count =3D 1,
> +	.supports_nvmem =3D false,

That's already its value if you leave it out.

>  };
> =20
>  static const struct gpadc_data sun5i_gpadc_data =3D {
> @@ -100,6 +103,7 @@ static const struct gpadc_data sun5i_gpadc_data =3D {
>  	.sample_start =3D sun4i_gpadc_sample_start,
>  	.sample_end =3D sun4i_gpadc_sample_end,
>  	.sensor_count =3D 1,
> +	.supports_nvmem =3D false,
>  };
> =20
>  static const struct gpadc_data sun6i_gpadc_data =3D {
> @@ -113,6 +117,7 @@ static const struct gpadc_data sun6i_gpadc_data =3D {
>  	.sample_start =3D sun4i_gpadc_sample_start,
>  	.sample_end =3D sun4i_gpadc_sample_end,
>  	.sensor_count =3D 1,
> +	.supports_nvmem =3D false,
>  };
> =20
>  static const struct gpadc_data sun8i_a33_gpadc_data =3D {
> @@ -123,6 +128,7 @@ static const struct gpadc_data sun8i_a33_gpadc_data =
=3D {
>  	.sample_start =3D sun4i_gpadc_sample_start,
>  	.sample_end =3D sun4i_gpadc_sample_end,
>  	.sensor_count =3D 1,
> +	.supports_nvmem =3D false,
>  };
> =20
>  struct sun4i_gpadc_iio {
> @@ -141,6 +147,8 @@ struct sun4i_gpadc_iio {
>  	struct clk			*mod_clk;
>  	struct reset_control		*reset;
>  	int				sensor_id;
> +	u32				calibration_data[2];
> +	bool				has_calibration_data[2];

Why do you have two different values here?

>  	/* prevents concurrent reads of temperature and ADC */
>  	struct mutex			mutex;
>  	struct thermal_zone_device	*tzd;
> @@ -561,6 +569,9 @@ static int sun4i_gpadc_probe_dt(struct platform_devic=
e *pdev,
>  	struct resource *mem;
>  	void __iomem *base;
>  	int ret;
> +	struct nvmem_cell *cell;
> +	ssize_t cell_size;
> +	u64 *cell_data;
> =20
>  	info->data =3D of_device_get_match_data(&pdev->dev);
>  	if (!info->data)
> @@ -575,6 +586,39 @@ static int sun4i_gpadc_probe_dt(struct platform_devi=
ce *pdev,
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> =20
> +	info->has_calibration_data[0] =3D false;
> +	info->has_calibration_data[1] =3D false;
> +
> +	if (!info->data->supports_nvmem)
> +		goto no_nvmem;
> +
> +	cell =3D nvmem_cell_get(&pdev->dev, "calibration");
> +	if (IS_ERR(cell)) {
> +		if (PTR_ERR(cell) =3D=3D -EPROBE_DEFER)
> +			return PTR_ERR(cell);
> +		goto no_nvmem;

goto considered evil ? :)

> +	}
> +
> +	cell_data =3D (u64 *)nvmem_cell_read(cell, &cell_size);
> +	nvmem_cell_put(cell);
> +	switch (cell_size) {
> +		case 8:
> +		case 6:
> +			info->has_calibration_data[1] =3D true;
> +			info->calibration_data[1] =3D be32_to_cpu(
> +					upper_32_bits(cell_data[0]));
> +		case 4:
> +		case 2:
> +			info->has_calibration_data[0] =3D true;
> +			info->calibration_data[0] =3D be32_to_cpu(
> +					lower_32_bits(cell_data[0]));

Why do you need that switch?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5tc6bnwyrlietxpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu7BwACgkQ0rTAlCFN
r3Soag/+I6EXkohyDYlSmGPc6n7MiDLB86nxWCuoYSAv4IfmKLdr3nQpfhbnXq2Y
LKAf13DnVBb0o1p8TSlgMhk+0kHRM47516etxxXN4bPvWxPA72R6KywSBBZvNfXZ
w8gS/GFamDWcDVg9cwL8vB8WB1of2+9bfO1voWDRjChO7pCnpw6Z0G1Gfkd3Vl+2
qHK/dh70qwbInAsLfQTtmfAEvjFBzdX0M0H//XMFtCG8BC5+oZka3nJKRK4q1hF+
d4HmWhOZORtWCethDiaba+7jZjrZvOmFZxseWDF0rtZJ9SXZ6D0Mr52AHEmCqjPE
dhbccWUL3qXvNCxjMED7IfWfhIsbY79MyTAurFsSNiJdtQdXE4iAJSeExsyczY0B
C0RNEtHBi0zk3xpICTsiJNFk6TtA/dD0nDfluzUdEkJKaWzaF10aPjok7CVDDIRw
xu7/UziSVOWwPlgmXbQGzAYo22I76icAsTO1YsO33LR7KfaZQjMlz75ROzRbxyVw
7WyKZR5I7wfJHAGEaEdpAHrSPfxBxVM1z2ylZh3lSAmaKQs/2G5iRlQ2O46qmBG8
RbcYJzdMsnySt86fN5f02+y3XMAMUkaQHpm5PQgnQdsoSYO3QTWoRuxuwE9VttER
79cJcmnrB1t0+wcUkedkXPzdGfbgvrb+RbRX0YYcJ39PkOGKEsQ=
=jZKp
-----END PGP SIGNATURE-----

--5tc6bnwyrlietxpn--
