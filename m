Return-Path: <SRS0=xJ32=6K=gmail.com=thierry.reding@kernel.org>
Date: Fri, 7 Jul 2017 11:23:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: lee.jones@linaro.org, benjamin.gaignard@linaro.org, jic23@kernel.org,
	robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
	mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 4/8] pwm: Add STM32 LPTimer PWM driver
Message-ID: <20170707092316.GA15652@ulmo.fritz.box>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-5-git-send-email-fabrice.gasnier@st.com>
 <20170706074320.GK16144@ulmo.fritz.box>
 <b82d9c76-d8c5-43bf-45cc-b5c26c1c7164@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <b82d9c76-d8c5-43bf-45cc-b5c26c1c7164@st.com>
List-ID: <linux-iio@vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2017 at 10:10:32AM +0200, Fabrice Gasnier wrote:
> On 07/06/2017 09:43 AM, Thierry Reding wrote:
> > On Wed, Jun 21, 2017 at 04:30:11PM +0200, Fabrice Gasnier wrote:
> >> Add support for single PWM channel on Low-Power Timer, that can be
> >> found on some STM32 platforms.
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> ---
> >> Changes in v2:
> >> - s/Low Power/Low-Power
> >> - update few comment lines
> >> ---
> >>  drivers/pwm/Kconfig        |  10 +++
> >>  drivers/pwm/Makefile       |   1 +
> >>  drivers/pwm/pwm-stm32-lp.c | 216 ++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 227 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-stm32-lp.c
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index 313c107..7cb982b 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -417,6 +417,16 @@ config PWM_STM32
> >>  	  To compile this driver as a module, choose M here: the module
> >>  	  will be called pwm-stm32.
> >> =20
> >> +config PWM_STM32_LP
> >> +	tristate "STMicroelectronics STM32 PWM LP"
> >> +	depends on MFD_STM32_LPTIMER || COMPILE_TEST
> >> +	help
> >> +	  Generic PWM framework driver for STMicroelectronics STM32 SoCs
> >> +	  with Low-Power Timer (LPTIM).
> >> +
> >> +	  To compile this driver as a module, choose M here: the module
> >> +	  will be called pwm-stm32-lp.
> >> +
> >>  config PWM_STMPE
> >>  	bool "STMPE expander PWM export"
> >>  	depends on MFD_STMPE
> >> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> >> index 93da1f7..a3a4bee 100644
> >> --- a/drivers/pwm/Makefile
> >> +++ b/drivers/pwm/Makefile
> >> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
> >>  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
> >>  obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
> >> +obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
> >>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
> >>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> >>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
> >> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> >> new file mode 100644
> >> index 0000000..eb997a8
> >> --- /dev/null
> >> +++ b/drivers/pwm/pwm-stm32-lp.c
> >> @@ -0,0 +1,216 @@
> >> +/*
> >> + * STM32 Low-Power Timer PWM driver
> >> + *
> >> + * Copyright (C) STMicroelectronics 2017
> >> + *
> >> + * Author: Gerald Baeza <gerald.baeza@st.com>
> >> + *
> >> + * License terms: GNU General Public License (GPL), version 2
> >> + *
> >> + * Inspired by Gerald Baeza's pwm-stm32 driver
> >> + */
> >> +
> >> +#include <linux/bitfield.h>
> >> +#include <linux/mfd/stm32-lptimer.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/pwm.h>
> >> +
> >> +struct stm32_pwm_lp {
> >> +	struct pwm_chip chip;
> >> +	struct clk *clk;
> >> +	struct regmap *regmap;
> >> +};
> >> +
> >> +static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *c=
hip)
> >> +{
> >> +	return container_of(chip, struct stm32_pwm_lp, chip);
> >> +}
> >> +
> >> +static const u8 prescalers[] =3D {1, 2, 4, 8, 16, 32, 64, 128};
> >> +
> >> +static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> >> +			      struct pwm_state *state)
> >> +{
> >> +	struct stm32_pwm_lp *priv =3D to_stm32_pwm_lp(chip);
> >> +	unsigned long long prd, div, dty;
> >> +	struct pwm_state cstate;
> >> +	u32 val, mask, cfgr, wavpol, presc =3D 0;
> >> +	bool reenable =3D false;
> >> +	int ret;
> >> +
> >> +	pwm_get_state(pwm, &cstate);
> >> +
> >> +	if (!state->enabled) {
> >> +		if (cstate.enabled) {
> >> +			/* Disable LP timer */
> >> +			ret =3D regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
> >> +			if (ret)
> >> +				return ret;
> >> +			clk_disable(priv->clk);
> >> +		}
> >> +		return 0;
> >> +	}
> >> +
> >> +	/* Calculate the period and prescaler value */
> >> +	div =3D (unsigned long long)clk_get_rate(priv->clk) * state->period;
> >> +	do_div(div, NSEC_PER_SEC);
> >> +	prd =3D div;
> >> +	while (div > STM32_LPTIM_MAX_ARR) {
> >> +		presc++;
> >> +		if (presc >=3D ARRAY_SIZE(prescalers)) {
> >> +			dev_err(priv->chip.dev, "max prescaler exceeded\n");
> >> +			return -EINVAL;
> >> +		}
> >> +		div =3D prd;
> >> +		do_div(div, prescalers[presc]);
> >> +	}
> >> +	prd =3D div;
> >> +
> >> +	/* Calculate the duty cycle */
> >> +	dty =3D prd * state->duty_cycle;
> >> +	do_div(dty, state->period);
> >> +
> >> +	wavpol =3D FIELD_PREP(STM32_LPTIM_WAVPOL, state->polarity);
> >> +
> >> +	if (!cstate.enabled) {
> >> +		ret =3D clk_enable(priv->clk);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >=20
> > Why do you need the checks here? Clock enabled are reference counted, so
> > you could do the clk_enable() unconditionally.
>=20
> Hi Thierry,
>=20
> This clock is used to generate PWM (source for LP timer counter). I
> enable it here as:
> - required state is 'enabled'
> - current state is 'disabled'.
> PWM is being turned on: first enable clock, then configure & enable PWM
> bellow.
>=20
> The opposite is done earlier, at the beginning of this routine:
> - required state is 'disabled'
> - current state is 'enabled'
> PWM is turned off, then clock is disabled.
>=20
> Enable count should be balanced, and clock is enabled when required
> (e.g. when PWM is 'on'). Doing it unconditionally here may cause
> unbalanced enable count (e.g. any duty_cycle update would increase
> enable count)
> Is it ok to keep this ?

The placement of the call suggested that you also need to enable the
clock in order to access any of the registers. In such cases it's often
simpler to take (and release) the reference to the clock irrespective
of the current state.

So the general sequence might look like this:

	/* allow access to registers */
	clk_enable();

	/* modify registers */
	...

	/* enable clock to drive PWM counter */
	if (state->enabled && !cstate.enabled)
		clk_enable();

	/* disable clock to PWM counter */
	if (!state->enabled && cstate.enabled)
		clk_disable();

	/* access to registers no longer needed */
	clk_disable();

This ensures that as long as you keep the "register" reference to the
clock, the clock will remain on.

There is a somewhat tricky situation that could happen if the initial
clock reference count is not in sync. Consider the case where your
->get_state() determines that the PWM is enabled. cstate.enabled would
be true, but the clock enable count would not be incremented. So you'd
have to make sure to add code to the ->get_state() implementation that
calls clk_enable() for each PWM that is enabled.

In my opinion that would be the cleanest option and easiest to follow,
but its more work to properly implement than I initially assumed, so
I'm fine with the version that you have, too.

> > Speaking of which, I don't see a clk_prepare() anywhere. Doesn't the clk
> > core warn about clk_enable() being called on a clock that's not been
> > prepared?
>=20
> clk_get() and clk_prepare() happens in regmap layer, when probing mfd par=
t:
> -> stm32_lptimer_probe()
>   -> devm_regmap_init_mmio_clk()
>     -> __devm_regmap_init_mmio_clk()
>       -> regmap_mmio_gen_context()

Okay, looks like we don't need it here, then.

> >> +	    (presc !=3D FIELD_GET(STM32_LPTIM_PRESC, cfgr))) {
> >> +		val =3D FIELD_PREP(STM32_LPTIM_PRESC, presc) | wavpol;
> >> +		mask =3D STM32_LPTIM_PRESC | STM32_LPTIM_WAVPOL;
> >> +
> >> +		/* Must disable LP timer to modify CFGR */
> >> +		ret =3D regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
> >> +		if (ret)
> >> +			goto err;
> >> +		reenable =3D true;
> >=20
> > The placement of this is somewhat odd. It suggests that it is somehow
> > related to the disabling of the LP timer, whereas it really isn't.
>=20
> In case of prescaler or polarity change, CFGR register needs to be
> updated. CFGR register must be modified only when LP timer HW is disabled.
> - Initial choice is to use this flag, to temporarily disable HW, update
> cfgr, then re-enable it. More thinking about this...

What I find odd about the placement is that it is between the
regmap_write() and the regmap_update_bits(). But it could just as well
be after the regmap_update_bits() (or before regmap_write() for that
matter). So the confusing thing is why it "breaks" the sequence of
register accesses.

> - Another choice could be to refuse such a 'live' change and report
> (busy?) error ? Then user would have to explicitly disable it, configure
> new setting and re-enable it.
>=20
> Please let me know your opinion.

The PWM subsystem doesn't give a guarantee that a live change is
possible. Drivers always have to assume that the PWM may get disabled
and reenabled as part of the sequence.

That said, something like this could be added in the future if users
come along that required this guarantee.

For your driver, I think it's fine to keep this as-is.

> >> +static int stm32_pwm_lp_probe(struct platform_device *pdev)
> >> +{
> >> +	struct stm32_lptimer *ddata =3D dev_get_drvdata(pdev->dev.parent);
> >> +	struct stm32_pwm_lp *priv;
> >> +	int ret;
> >> +
> >> +	if (IS_ERR_OR_NULL(ddata))
> >> +		return -EINVAL;
> >=20
> > It seems to me like this can never happen. How would you trigger this
> > condition?
>=20
> Bad dt configuration can trigger this error: thinking of a
> 'st,stm32-pwm-lp' dt node without proper mfd parent. Do you want me to
> drop this ?
> (or add comment about it ?)

In my opinion we should trust DTB in this type of situation. If the DT
binding says that the PWM node needs to be a child of an MFD, then the
author of the DTB needs to make sure it is.

For things that can be easily checked I think it makes sense to validate
the DTB, but this check here is not enough for all situations, right?
What if somebody added the device node as child to some unrelated node.
ddata could be a valid pointer, but pointing at something that's not a
struct stm32_lptimer at all. That's still pretty bad, and completely
undetectable.

Thierry

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAllfUwAACgkQ3SOs138+
s6ELDg//XWEIjOpQSJLTtJ0nlCi4RXBM8fCIR73oHE1nZ5Pl/+egslC7m75PPUGL
QB7pqLWZpcMeYM+oGje5zXmUbDP/5X18H6Aig/KkAGlw5iNqvblykCsVME939kfO
61TfielxO+jiagAr4xkcXd6NY4bDOZB/YsfE6XCj9WesCtQYtZ+Oa/61Yekw/CX9
EHLk4n2aT695iinMMKPnIVE9wP7FFKURii68mlp9l6uLzJB9JZJ5VeAwK49o2o81
wX6elTttN2ue5yEiaEr+rjbMbeqbCNsvAxVn/PHE3wxuJ4RgQOJePJz9XS2Hr2eu
X2xlFb+8zxYmiPw1FDEfrp7sSoOqgd8aiJAzdZFqLniQ6dV35vcXpxG3TUAx3zn+
BuPpdsYMrQv670IwhZnJNvvl5zioEOP7j22xtw0+xieQ0zj7S8gu8uf1rdWSjhFk
17DqjRqZpcHHhBYkDqTERa86mJGpOxdjs8nJPLOA84Pl6vDn9tI+WuBKMDCalgxN
6Msrl1gn/ZyOvh0ZYlUOXvg4jbUhwe1vMByrayANMSY8Fw68EQDEJb/WY7R1a+xz
lWEH6qxXIsX59bNY+lxR0IfVR17duy3H/YlgBCJG0YdXBw2JLYD6zor7x0OznuMe
jZ3bXonGOshKkg5W5TheNGeeQFQZ3wxnB7tFhRG3ej50xa7oFK0=
=L55c
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
