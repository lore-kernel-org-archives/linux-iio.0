Return-Path: <SRS0=w6xg=6J=gmail.com=thierry.reding@kernel.org>
Date: Thu, 6 Jul 2017 09:43:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: lee.jones@linaro.org, benjamin.gaignard@linaro.org, jic23@kernel.org,
	robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
	mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 4/8] pwm: Add STM32 LPTimer PWM driver
Message-ID: <20170706074320.GK16144@ulmo.fritz.box>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-5-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IA03tywDYuoVKXrw"
In-Reply-To: <1498055415-31513-5-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>


--IA03tywDYuoVKXrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2017 at 04:30:11PM +0200, Fabrice Gasnier wrote:
> Add support for single PWM channel on Low-Power Timer, that can be
> found on some STM32 platforms.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - s/Low Power/Low-Power
> - update few comment lines
> ---
>  drivers/pwm/Kconfig        |  10 +++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-stm32-lp.c | 216 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 227 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stm32-lp.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 313c107..7cb982b 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -417,6 +417,16 @@ config PWM_STM32
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-stm32.
> =20
> +config PWM_STM32_LP
> +	tristate "STMicroelectronics STM32 PWM LP"
> +	depends on MFD_STM32_LPTIMER || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for STMicroelectronics STM32 SoCs
> +	  with Low-Power Timer (LPTIM).
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-stm32-lp.
> +
>  config PWM_STMPE
>  	bool "STMPE expander PWM export"
>  	depends on MFD_STMPE
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 93da1f7..a3a4bee 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
>  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
>  obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
> +obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> new file mode 100644
> index 0000000..eb997a8
> --- /dev/null
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -0,0 +1,216 @@
> +/*
> + * STM32 Low-Power Timer PWM driver
> + *
> + * Copyright (C) STMicroelectronics 2017
> + *
> + * Author: Gerald Baeza <gerald.baeza@st.com>
> + *
> + * License terms: GNU General Public License (GPL), version 2
> + *
> + * Inspired by Gerald Baeza's pwm-stm32 driver
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/mfd/stm32-lptimer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +struct stm32_pwm_lp {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +};
> +
> +static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct stm32_pwm_lp, chip);
> +}
> +
> +static const u8 prescalers[] =3D {1, 2, 4, 8, 16, 32, 64, 128};
> +
> +static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      struct pwm_state *state)
> +{
> +	struct stm32_pwm_lp *priv =3D to_stm32_pwm_lp(chip);
> +	unsigned long long prd, div, dty;
> +	struct pwm_state cstate;
> +	u32 val, mask, cfgr, wavpol, presc =3D 0;
> +	bool reenable =3D false;
> +	int ret;
> +
> +	pwm_get_state(pwm, &cstate);
> +
> +	if (!state->enabled) {
> +		if (cstate.enabled) {
> +			/* Disable LP timer */
> +			ret =3D regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
> +			if (ret)
> +				return ret;
> +			clk_disable(priv->clk);
> +		}
> +		return 0;
> +	}
> +
> +	/* Calculate the period and prescaler value */
> +	div =3D (unsigned long long)clk_get_rate(priv->clk) * state->period;
> +	do_div(div, NSEC_PER_SEC);
> +	prd =3D div;
> +	while (div > STM32_LPTIM_MAX_ARR) {
> +		presc++;
> +		if (presc >=3D ARRAY_SIZE(prescalers)) {
> +			dev_err(priv->chip.dev, "max prescaler exceeded\n");
> +			return -EINVAL;
> +		}
> +		div =3D prd;
> +		do_div(div, prescalers[presc]);
> +	}
> +	prd =3D div;
> +
> +	/* Calculate the duty cycle */
> +	dty =3D prd * state->duty_cycle;
> +	do_div(dty, state->period);
> +
> +	wavpol =3D FIELD_PREP(STM32_LPTIM_WAVPOL, state->polarity);
> +
> +	if (!cstate.enabled) {
> +		ret =3D clk_enable(priv->clk);
> +		if (ret)
> +			return ret;
> +	}

Why do you need the checks here? Clock enabled are reference counted, so
you could do the clk_enable() unconditionally.

Speaking of which, I don't see a clk_prepare() anywhere. Doesn't the clk
core warn about clk_enable() being called on a clock that's not been
prepared?

> +
> +	ret =3D regmap_read(priv->regmap, STM32_LPTIM_CFGR, &cfgr);
> +	if (ret)
> +		goto err;
> +
> +	if ((wavpol !=3D FIELD_GET(STM32_LPTIM_WAVPOL, cfgr)) ||

This looks wrong to me. Looking at the macro definitions, FIELD_PREP()
will store the shifted value in wavpol, but FIELD_GET() will shift the
value before returning, so you will compare an in-register value with
a field value. I don't see how those could ever match (unless they're
0 or the field is at position 0, which isn't the case for WAVPOL).

> +	    (presc !=3D FIELD_GET(STM32_LPTIM_PRESC, cfgr))) {
> +		val =3D FIELD_PREP(STM32_LPTIM_PRESC, presc) | wavpol;
> +		mask =3D STM32_LPTIM_PRESC | STM32_LPTIM_WAVPOL;
> +
> +		/* Must disable LP timer to modify CFGR */
> +		ret =3D regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
> +		if (ret)
> +			goto err;
> +		reenable =3D true;

The placement of this is somewhat odd. It suggests that it is somehow
related to the disabling of the LP timer, whereas it really isn't.

> +		ret =3D regmap_update_bits(priv->regmap, STM32_LPTIM_CFGR, mask,
> +					 val);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	if (!cstate.enabled || reenable) {

You have this condition in a couple of places and it's rather difficult
to parse. Maybe this could be simplified a little:

	bool reenable =3D !cstate.enabled;
	...
	if (...) {
		...
		reenable =3D true;
		...
	}
	...
	if (reenable) {
		...
	}

> +		/* Must enable LP timer to modify CMP & ARR */
> +		ret =3D regmap_write(priv->regmap, STM32_LPTIM_CR,
> +				   STM32_LPTIM_ENABLE);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret =3D regmap_write(priv->regmap, STM32_LPTIM_ARR, prd - 1);
> +	if (ret)
> +		goto err;
> +
> +	ret =3D regmap_write(priv->regmap, STM32_LPTIM_CMP, prd - (1 + dty));
> +	if (ret)
> +		goto err;
> +
> +	/* ensure CMP & ARR registers are properly written */
> +	ret =3D regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
> +				       (val & STM32_LPTIM_CMPOK_ARROK),
> +				       100, 1000);
> +	if (ret) {
> +		dev_err(priv->chip.dev, "ARR/CMP registers write issue\n");
> +		goto err;
> +	}
> +	ret =3D regmap_write(priv->regmap, STM32_LPTIM_ICR,
> +			   STM32_LPTIM_CMPOKCF_ARROKCF);
> +	if (ret)
> +		goto err;
> +
> +	if (!cstate.enabled || reenable) {
> +		/* Start LP timer in continuous mode */
> +		ret =3D regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
> +					 STM32_LPTIM_CNTSTRT,
> +					 STM32_LPTIM_CNTSTRT);
> +		if (ret) {
> +			regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +err:
> +	if (!cstate.enabled)
> +		clk_disable(priv->clk);

I think you can drop the clk_disable() here as well.

> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops stm32_pwm_lp_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.apply =3D stm32_pwm_lp_apply,
> +};

You should implement the .get_state() callback as well, otherwise the
atomic PWM support will be somewhat handicapped.

> +
> +static int stm32_pwm_lp_probe(struct platform_device *pdev)
> +{
> +	struct stm32_lptimer *ddata =3D dev_get_drvdata(pdev->dev.parent);
> +	struct stm32_pwm_lp *priv;
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(ddata))
> +		return -EINVAL;

It seems to me like this can never happen. How would you trigger this
condition?

> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->regmap =3D ddata->regmap;
> +	priv->clk =3D ddata->clk;
> +	if (!priv->regmap || !priv->clk)
> +		return -EINVAL;

Likewise for these. the stm32-lptimer driver already checks that these
are valid, which do you need to do it again?

Well, technically you check for !NULL here, whereas stm32-lptimer does
check for IS_ERR(), but neither regmap nor clk looks as though they're
optional, and you won't ever get here if they can't be requested by
stm32-lptimer in the first place.

> +
> +	priv->chip.base =3D -1;
> +	priv->chip.dev =3D &pdev->dev;
> +	priv->chip.ops =3D &stm32_pwm_lp_ops;
> +	priv->chip.npwm =3D 1;
> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int stm32_pwm_lp_remove(struct platform_device *pdev)
> +{
> +	struct stm32_pwm_lp *priv =3D platform_get_drvdata(pdev);
> +
> +	if (pwm_is_enabled(priv->chip.pwms))
> +		pwm_disable(priv->chip.pwms);

It'd be better to use the more idiomatic variant for this:

	for (i =3D 0; i < priv->chip.npwm; i++)
		if (pwm_is_enabled(priv->chip.npwm))
			pwm_disable(&priv->chip.pwms[i]);

That makes it easier to discern the common pattern and extract a helper,
or move this to the core.

Thierry

--IA03tywDYuoVKXrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld6hUACgkQ3SOs138+
s6FLpw/+OgdoeLDgCv4b/cyYbN+ec3FIm/nbJctGlBDeI1rJB2wyaK5CZl0ArM5a
ut6pHaxqyu9a2ZkkyBnkt6mlIZVKocehJiA4TVYLQeOikMuTnxzZaJEdMgULuLSU
Lo6CLsXhSCMgf8nBhm+D1Q+hNjVOXUFBSwehzhAIW7WnSf+5pDMK4cKdsVXZdNIn
jbdHdOj84B5QsrVU1M69FGwod8UK7mVnIUDXYabFoZi87itdY8MnOJr/A/61mtxn
P7PHEbIb96cBQ7sAJCeYHJZSQEw0Q6ta70yL4U4u2hCVc4adKYh1GQxBlXqsXnbI
BLJS0wWoBnkCoRJYIqEXRSOf+Xjg9uifLAjUsPT51UL+ePgnhDqaw/KGu/vt0Fz4
KlkeQJcHOYt/yXfLywiLRZzqsf84jp86MZn641KQByEQhha9q+hY6KnAVmnPIg+9
HGCDeORCCWWRBGYgZ3qVhvgje30AuJEfu8yXWh2twWiq2qVhv+9szEV51HmdfaDq
NYIT5L4KxfYsg3xNKaqTjaXGamh7aTPyJk0XXYhTXMMTHUTdmicGFdRmVhKitlgf
ZdavgFztpXLK5Xb+oIOSlCg7dxgaXw8BJB4BYsKrkSX78JX8XyiUxsZkfYJbOghW
sxmBjAhR+0VHyeFa0LnE1+6JqNr83n0ANraKdI4OoxQZWpUv5o4=
=NCxH
-----END PGP SIGNATURE-----

--IA03tywDYuoVKXrw--
