Return-Path: <SRS0=uf+1=EY=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 29 Jan 2018 10:31:14 +0100
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
Subject: Re: [PATCH v2 05/16] iio: adc: sun4i-gpadc-iio: rework: support
 clocks and reset
Message-ID: <20180129093114.nwohas57kxh347w6@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-6-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pb7hm4jg4ebpgxeo"
In-Reply-To: <20180128232919.12639-6-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--pb7hm4jg4ebpgxeo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 12:29:08AM +0100, Philipp Rossak wrote:
> For adding newer sensor some basic rework of the code is necessary.
>=20
> The SoCs after H3 has newer thermal sensor ADCs, which have two clock
> inputs (bus clock and sampling clock) and a reset. The registers are
> also re-arranged.
>=20
> This commit reworks the code, adds the process of the clocks and
> resets.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Same remark for the SoB

> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 71 +++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 71 insertions(+)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index db57d9fffe48..51ec0104d678 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -22,6 +22,7 @@
>   * shutdown for not being used.
>   */
> =20
> +#include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -31,6 +32,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/thermal.h>
>  #include <linux/delay.h>
> =20
> @@ -68,6 +70,9 @@ struct gpadc_data {
>  	unsigned int	temp_data;
>  	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>  	int		(*sample_end)(struct sun4i_gpadc_iio *info);
> +	bool		has_bus_clk;
> +	bool		has_bus_rst;
> +	bool		has_mod_clk;

Is there SoCs where this insn't all true, or all false?

>  };
> =20
>  static const struct gpadc_data sun4i_gpadc_data =3D {
> @@ -127,6 +132,9 @@ struct sun4i_gpadc_iio {
>  	atomic_t			ignore_temp_data_irq;
>  	const struct gpadc_data		*data;
>  	bool				no_irq;
> +	struct clk			*bus_clk;
> +	struct clk			*mod_clk;
> +	struct reset_control		*reset;
>  	/* prevents concurrent reads of temperature and ADC */
>  	struct mutex			mutex;
>  	struct thermal_zone_device	*tzd;
> @@ -420,6 +428,10 @@ static int sun4i_gpadc_runtime_suspend(struct device=
 *dev)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(dev_get_drvdata(dev));
> =20
> +	clk_disable(info->mod_clk);
> +

Why clk_disable?

> +	clk_disable(info->bus_clk);
> +

You can tie the bus_clk to the regmap directly, instead of having to
maintain it yourself here.

And you can probably put the device in reset and out of reset here as
well.

>  	return info->data->sample_end(info);
>  }
> =20
> @@ -446,6 +458,10 @@ static int sun4i_gpadc_runtime_resume(struct device =
*dev)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(dev_get_drvdata(dev));
> =20
> +	clk_enable(info->mod_clk);
> +
> +	clk_enable(info->bus_clk);
> +
>  	return info->data->sample_start(info);
>  }
> =20
> @@ -560,10 +576,59 @@ static int sun4i_gpadc_probe_dt(struct platform_dev=
ice *pdev,
>  		return ret;
>  	}
> =20
> +	if (info->data->has_bus_rst) {
> +		info->reset =3D devm_reset_control_get(&pdev->dev, NULL);
> +		if (IS_ERR(info->reset)) {
> +			ret =3D PTR_ERR(info->reset);
> +			return ret;
> +		}
> +
> +		ret =3D reset_control_deassert(info->reset);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (info->data->has_bus_clk) {
> +		info->bus_clk =3D devm_clk_get(&pdev->dev, "bus");
> +		if (IS_ERR(info->bus_clk)) {
> +			ret =3D PTR_ERR(info->bus_clk);
> +			goto assert_reset;
> +		}
> +
> +		ret =3D clk_prepare_enable(info->bus_clk);
> +		if (ret)
> +			goto assert_reset;
> +	}
> +
> +	if (info->data->has_mod_clk) {
> +		info->mod_clk =3D devm_clk_get(&pdev->dev, "mod");
> +		if (IS_ERR(info->mod_clk)) {
> +			ret =3D PTR_ERR(info->mod_clk);
> +			goto disable_bus_clk;
> +		}
> +
> +		/* Running at 6MHz */
> +		ret =3D clk_set_rate(info->mod_clk, 4000000);

Your comment and the line below doesn't really make much sense :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--pb7hm4jg4ebpgxeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu6eEACgkQ0rTAlCFN
r3SGfxAAlAPsZeim4qae08IBi8XP5nDTpoujYLw5BXz1wUK5mmyMEr9ak1i0PTCe
Ddm9Yw9GZVIsbVFExcD1cfCPLYKjjM3UrJZnBWW0flmKTPo8hZK3PA71e9IBqatS
04hXz7Y2bdyJm267a5yELoSOx2sNEluQeKZ6Xqa2mQe0rmiOoZQ/pGrcbk8Zv/ei
Kj8fXfcAza5QBIWMnt0A6M+k4r1Koqol6bzplzDczjBjOSOlI9Iq6n+eSCt7IESD
RIRulkQgoUEbFqbHfnReWi4gAg1GtDy3FeFwE5B/PL0EOA3Kb7+/dxxEmQAlydX0
QnGxij6RBBLBPFOQ6AVa5rj3n4LjWVK/TKmVm3ngsGfLArjG+Nn7628G8RNNjRx6
dCofuvVbSssOeL+TNqDX/EauxeqpLS3fFcDaQIowH7nTfwMqMZ0mm8ocTlfERceg
lob26VNN0SO/HHtNyZDGEBwJOmFb2o0thXST8yq6YWef9GtPJYvgl4edzQ0DXXZL
yzCFN/U6V4s2Y2pG6ydPv4ZS0TaL8Z2K2pPGogrqZ53krtIXc71fdX2QZfrt4sfg
NO33xgfH7wFVvy1MYOnE0za+r8whWHPmFzfgT22ZZbIItV3/WtS3Xb8GbxjRs7gI
Y0KSnRbUZv0BTxYuN/yKz3CB+NlmefpnxKfCj5Ec+dNV4FQY4wo=
=Aoh8
-----END PGP SIGNATURE-----

--pb7hm4jg4ebpgxeo--
