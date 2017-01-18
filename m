Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36749 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbdARKMR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 05:12:17 -0500
Date: Wed, 18 Jan 2017 11:08:17 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linus.walleij@linaro.org, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v7 4/8] PWM: add PWM driver for STM32 plaftorm
Message-ID: <20170118100817.GF18989@ulmo.ba.sec>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
In-Reply-To: <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 10:25:40AM +0100, Benjamin Gaignard wrote:
> This driver adds support for PWM driver on STM32 platform.
> The SoC have multiple instances of the hardware IP and each
> of them could have small differences: number of channels,
> complementary output, auto reload register size...
>=20
> version 6:
> - change st,breakinput parameter to make it usuable for stm32f7 too.
>=20
> version 4:
> - detect at probe time hardware capabilities
> - fix comments done on v2 and v3
> - use PWM atomic ops
>=20
> version 2:
> - only keep one comptatible
> - use DT parameters to discover hardware block configuration
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/pwm/Kconfig     |   9 +
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-stm32.c | 434 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 444 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stm32.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index f92dd41..88035c0 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -397,6 +397,15 @@ config PWM_STI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sti.
> =20
> +config PWM_STM32
> +	tristate "STMicroelectronics STM32 PWM"
> +	depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for STM32 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-stm32.
> +
>  config PWM_STMPE
>  	bool "STMPE expander PWM export"
>  	depends on MFD_STMPE
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index a48bdb5..346a83b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
>  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
> +obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> new file mode 100644
> index 0000000..fcf0a78
> --- /dev/null
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -0,0 +1,434 @@
> +/*
> + * Copyright (C) STMicroelectronics 2016
> + *
> + * Author: Gerald Baeza <gerald.baeza@st.com>
> + *
> + * License terms: GNU General Public License (GPL), version 2
> + *
> + * Inspired by timer-stm32.c from Maxime Coquelin
> + *             pwm-atmel.c from Bo Shen
> + */
> +
> +#include <linux/mfd/stm32-timers.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/of.h>

Can you please sort these alphabetically?

> +
> +#define CCMR_CHANNEL_SHIFT 8
> +#define CCMR_CHANNEL_MASK  0xFF
> +#define MAX_BREAKINPUT 2

Okay, this answers my question regarding the st,breakinput property. I
still think it'd be good to have this in the binding documentation just
to avoid having to look at implementation to find out.

> +
> +struct stm32_pwm {
> +	struct pwm_chip chip;
> +	struct device *dev;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +	unsigned int caps;

This seems completely unused?

> +	unsigned int npwm;

It's somewhat redundant to have this here, since the same information is
already contained in struct pwm_chip.npwm.

Since you use this primarily for detection, how about you make the
stm32_pwm_detect_channels() function return the value and store it in a
local variable in ->probe()? That might be useful also because you
need to check the return value of regmap_update_bits() which technically
could fail.

> +	u32 max_arr;
> +	bool have_complementary_output;
> +};
> +
> +struct stm32_breakinput {
> +	u32 index;
> +	u32 level;
> +	u32 filter;
> +};
> +
> +static inline struct stm32_pwm *to_stm32_pwm_dev(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct stm32_pwm, chip);
> +}
> +
> +static u32 active_channels(struct stm32_pwm *dev)
> +{
> +	u32 ccer;
> +
> +	regmap_read(dev->regmap, TIM_CCER, &ccer);
> +
> +	return ccer & TIM_CCER_CCXE;
> +}

This looks like something that you could track in software, but this is
probably fine, too. Again, technically regmap_read() could fail, so you
might want to consider adding some code to handle it. In practice it
probably won't, so maybe you don't.

> +
> +static int write_ccrx(struct stm32_pwm *dev, struct pwm_device *pwm,
> +		      u32 value)
> +{
> +	switch (pwm->hwpwm) {
> +	case 0:
> +		return regmap_write(dev->regmap, TIM_CCR1, value);
> +	case 1:
> +		return regmap_write(dev->regmap, TIM_CCR2, value);
> +	case 2:
> +		return regmap_write(dev->regmap, TIM_CCR3, value);
> +	case 3:
> +		return regmap_write(dev->regmap, TIM_CCR4, value);
> +	}
> +	return -EINVAL;
> +}
> +
> +static int stm32_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    int duty_ns, int period_ns)
> +{
> +	struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> +	unsigned long long prd, div, dty;
> +	unsigned int prescaler =3D 0;
> +	u32 ccmr, mask, shift;
> +
> +	/* Period and prescaler values depends on clock rate */
> +	div =3D (unsigned long long)clk_get_rate(priv->clk) * period_ns;
> +
> +	do_div(div, NSEC_PER_SEC);
> +	prd =3D div;
> +
> +	while (div > priv->max_arr) {
> +		prescaler++;
> +		div =3D prd;
> +		do_div(div, (prescaler + 1));

Nit: there's no need for the parentheses here.

> +	}
> +
> +	prd =3D div;
> +
> +	if (prescaler > MAX_TIM_PSC) {
> +		dev_err(chip->dev, "prescaler exceeds the maximum value\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * All channels share the same prescaler and counter so when two
> +	 * channels are active at the same we can't change them

Nit: "at the same time"?

> +	 */
> +	if (active_channels(priv) & ~(1 << pwm->hwpwm * 4)) {
> +		u32 psc, arr;
> +
> +		regmap_read(priv->regmap, TIM_PSC, &psc);
> +		regmap_read(priv->regmap, TIM_ARR, &arr);
> +
> +		if ((psc !=3D prescaler) || (arr !=3D prd - 1))
> +			return -EBUSY;
> +	}
> +
> +	regmap_write(priv->regmap, TIM_PSC, prescaler);
> +	regmap_write(priv->regmap, TIM_ARR, prd - 1);
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
> +
> +	/* Calculate the duty cycles */
> +	dty =3D prd * duty_ns;
> +	do_div(dty, period_ns);
> +
> +	write_ccrx(priv, pwm, dty);
> +
> +	/* Configure output mode */
> +	shift =3D (pwm->hwpwm & 0x1) * CCMR_CHANNEL_SHIFT;
> +	ccmr =3D (TIM_CCMR_PE | TIM_CCMR_M1) << shift;
> +	mask =3D CCMR_CHANNEL_MASK << shift;
> +
> +	if (pwm->hwpwm < 2)
> +		regmap_update_bits(priv->regmap, TIM_CCMR1, mask, ccmr);
> +	else
> +		regmap_update_bits(priv->regmap, TIM_CCMR2, mask, ccmr);
> +
> +	regmap_update_bits(priv->regmap, TIM_BDTR,
> +			   TIM_BDTR_MOE | TIM_BDTR_AOE,
> +			   TIM_BDTR_MOE | TIM_BDTR_AOE);
> +
> +	return 0;
> +}
> +
> +static int stm32_pwm_set_polarity(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  enum pwm_polarity polarity)
> +{
> +	u32 mask;
> +	struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> +
> +	mask =3D TIM_CCER_CC1P << (pwm->hwpwm * 4);
> +	if (priv->have_complementary_output)
> +		mask |=3D TIM_CCER_CC1NP << (pwm->hwpwm * 4);
> +
> +	regmap_update_bits(priv->regmap, TIM_CCER, mask,
> +			   polarity =3D=3D PWM_POLARITY_NORMAL ? 0 : mask);
> +
> +	return 0;
> +}
> +
> +static int stm32_pwm_enable(struct pwm_chip *chip, struct pwm_device *pw=
m)
> +{
> +	u32 mask;
> +	struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> +
> +	clk_enable(priv->clk);

This can fail, so its return value should be checked. Also, I don't see
a clk_prepare() anywhere. Is that something that maybe the MFD driver
should be doing? It currently isn't.

> +
> +	/* Enable channel */
> +	mask =3D TIM_CCER_CC1E << (pwm->hwpwm * 4);
> +	if (priv->have_complementary_output)
> +		mask |=3D TIM_CCER_CC1NE << (pwm->hwpwm * 4);
> +
> +	regmap_update_bits(priv->regmap, TIM_CCER, mask, mask);
> +
> +	/* Make sure that registers are updated */
> +	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
> +
> +	/* Enable controller */
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
> +
> +	return 0;
> +}
> +
> +static void stm32_pwm_disable(struct pwm_chip *chip, struct pwm_device *=
pwm)
> +{
> +	u32 mask;
> +	struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> +
> +	/* Disable channel */
> +	mask =3D TIM_CCER_CC1E << (pwm->hwpwm * 4);
> +	if (priv->have_complementary_output)
> +		mask |=3D TIM_CCER_CC1NE << (pwm->hwpwm * 4);
> +
> +	regmap_update_bits(priv->regmap, TIM_CCER, mask, 0);
> +
> +	/* When all channels are disabled, we can disable the controller */
> +	if (!active_channels(priv))
> +		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> +
> +	clk_disable(priv->clk);
> +}
> +
> +static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   struct pwm_state *state)
> +{
> +	struct pwm_state curstate;
> +	bool enabled;
> +	int ret;
> +
> +	pwm_get_state(pwm, &curstate);
> +	enabled =3D curstate.enabled;

There should be no need to do this in drivers. pwm_get_state() is for
PWM API users. Drivers can directly dereference pwm->state.

> +
> +	if (enabled && !state->enabled) {
> +		stm32_pwm_disable(chip, pwm);
> +		return 0;
> +	}
> +
> +	if (state->polarity !=3D curstate.polarity && enabled)
> +		stm32_pwm_set_polarity(chip, pwm, state->polarity);

So that's kind of a violation of atomic API semantics. The above means
that if you have a PWM in the following state:

	enabled: no
	polarity: normal

and want to set this:

	enabled: yes
	polarity: inversed

then you will ignore the new polarity setting. What's the reason for
"&& enabled) in the conditional above?

> +
> +	ret =3D stm32_pwm_config(chip, pwm, state->duty_cycle, state->period);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled && state->enabled)
> +		ret =3D stm32_pwm_enable(chip, pwm);
> +
> +	return ret;
> +}

Would it be possible to merge stm32_pwm_disable(), stm32_pwm_enable(),
stm32_pwm_set_polarity() and stm32_pwm_config() into stm32_pwm_apply()?
Part of the reason for the atomic API was to make it easier to write
these drivers, but your implementation effectively copies what the
transitional helpers do.

It might not make a difference technically in your case, but I think
it'd make the implementation more compact and set a better example for
future reference.

> +
> +static const struct pwm_ops stm32pwm_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.apply =3D stm32_pwm_apply,
> +};
> +
> +static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> +				    int level, int filter)
> +{
> +	u32 bdtr =3D TIM_BDTR_BKE;
> +
> +	if (level)
> +		bdtr |=3D TIM_BDTR_BKP;
> +
> +	bdtr |=3D (filter & TIM_BDTR_BKF_MASK) << TIM_BDTR_BKF_SHIFT;
> +
> +	regmap_update_bits(priv->regmap,
> +			   TIM_BDTR, TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF,
> +			   bdtr);
> +
> +	regmap_read(priv->regmap, TIM_BDTR, &bdtr);
> +
> +	return (bdtr & TIM_BDTR_BKE) ? 0 : -EINVAL;
> +}
> +
> +static int stm32_pwm_set_breakinput2(struct stm32_pwm *priv,
> +				     int level, int filter)
> +{
> +	u32 bdtr =3D TIM_BDTR_BK2E;
> +
> +	if (level)
> +		bdtr |=3D TIM_BDTR_BK2P;
> +
> +	bdtr |=3D (filter & TIM_BDTR_BKF_MASK) << TIM_BDTR_BK2F_SHIFT;
> +
> +	regmap_update_bits(priv->regmap,
> +			   TIM_BDTR, TIM_BDTR_BK2E |
> +			   TIM_BDTR_BK2P |
> +			   TIM_BDTR_BK2F,
> +			   bdtr);
> +
> +	regmap_read(priv->regmap, TIM_BDTR, &bdtr);
> +
> +	return (bdtr & TIM_BDTR_BK2E) ? 0 : -EINVAL;
> +}

As far as I can tell the only difference here is the various bit
positions. Can you collapse the above two functions and add a new
parameter to unify some code?

> +
> +static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
> +				       struct device_node *np)
> +{
> +	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
> +	int nb, ret, i, array_size;
> +
> +	nb =3D of_property_count_elems_of_size(np, "st,breakinput",
> +					     sizeof(struct stm32_breakinput));
> +
> +	/*
> +	 * Because "st,breakinput" parameter is optional do not make probe
> +	 * failed if it doesn't exist.
> +	 */
> +	if (nb <=3D 0)
> +		return 0;
> +
> +	if (nb > MAX_BREAKINPUT)
> +		return -EINVAL;
> +
> +	array_size =3D nb * sizeof(struct stm32_breakinput) / sizeof(u32);
> +	ret =3D of_property_read_u32_array(np, "st,breakinput",
> +					 &breakinput[0].index, array_size);

Maybe (u32 *)breakinput? That would make it more resilient against
changes in ordering of fields in the struct. Granted, that's not likely
to change, but I think it's a good idea in general to write code in a
way that's safe in a more general case. That way if somebody ever were
to copy from your code and then decide to reorder fields in their code
things wouldn't fall apart.

> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < nb && !ret; i++) {
> +		switch (breakinput[i].index) {
> +		case 0:
> +		{
> +			ret =3D stm32_pwm_set_breakinput(priv,
> +						       breakinput[i].level,
> +						       breakinput[i].filter);
> +			break;
> +		}

Curly braces are unnecessary here.

> +		case 1:
> +		{
> +			ret =3D stm32_pwm_set_breakinput2(priv,
> +							breakinput[i].level,
> +							breakinput[i].filter);
> +
> +			break;
> +		}
> +		default:
> +		{
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
> +{
> +	u32 ccer;
> +
> +	/*
> +	 * If complementary bit doesn't exist writing 1 will have no
> +	 * effect so we can detect it.
> +	 */
> +	regmap_update_bits(priv->regmap,
> +			   TIM_CCER, TIM_CCER_CC1NE, TIM_CCER_CC1NE);
> +	regmap_read(priv->regmap, TIM_CCER, &ccer);
> +	regmap_update_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE, 0);

This is strange: why are we disabling outputs here? Shouldn't the last
line here undo the first instead?

> +
> +	priv->have_complementary_output =3D (ccer !=3D 0);
> +}
> +
> +static void stm32_pwm_detect_channels(struct stm32_pwm *priv)
> +{
> +	u32 ccer;
> +
> +	/*
> +	 * If channels enable bits don't exist writing 1 will have no
> +	 * effect so we can detect and count them.
> +	 */
> +	regmap_update_bits(priv->regmap,
> +			   TIM_CCER, TIM_CCER_CCXE, TIM_CCER_CCXE);
> +	regmap_read(priv->regmap, TIM_CCER, &ccer);
> +	regmap_update_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE, 0);

Does this have the potential to glitch? I suspect that the clock may not
be on at this point and therefore no PWM outputs will be generated, but
is that guaranteed to always be the case?

Thierry

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/Po8ACgkQ3SOs138+
s6FuOhAAsH9ryuifOpdy4bcWXIx/wwcYRz2NTdH04wQ71xfUY2VByNiyVg7Wakv9
wvQrwTlmz+Vz3Oa/c5PbSTHczWhwvZGpwmGDRiMphroJ1kRPY4aJq8umZUnmUO5v
1E9OSIeMiWYzD20zn0mYfn8AeL0T7YjRns0H8d+GZjbOCZkPHRiSTNGnHQrh/uO/
KbbdQDBNNl/Q4OeZ3QhCQU9Q0b6OUQgu/6atV9x7UoH4NdZMT1I5zPrqWgf5uwco
5W0ibK6gvuxXRVO8A1dXJsaZaZhK3rgBJeNxL+0yJGs2Q/wBsLHSWsqULSqZ6zV4
q/oK+gBB7ViTs9QdipFtW37G+SGvBoUjWU73l9uW4dzBkA3i1w3xzJYjybhg2ATW
/HynO/sp2r06ijuTVFoDoEmmGIAFe+Brg4gE9ZjTmMV3S4lBTRTPeGw1R7kjrFsr
VvSRLDktTdc2t9zb3ASx97reVHm33Lhq8QlfVqWmCuSIZwSdiMLlaEpi/JpNGdrs
/ms0sGAsdlwrd0nBhFsnRTGDHuGXpo7QrqfxTtWjn4v3DLXwEThJd34UqQRZdqzv
iclNyButHOFsIqWo7p66j3mDRIuU+1x67LwEa6ExVVLd3vVxF6xn+H5Qf1MIc5cT
vGEJAu6Um03HmjeQsRkOMkR7zYMVVZbBjPveBqSp9YmKXBFBeso=
=lnQl
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
