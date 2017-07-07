Return-Path: <SRS0=LKit=6K=st.com=fabrice.gasnier@kernel.org>
Subject: Re: [PATCH v2 4/8] pwm: Add STM32 LPTimer PWM driver
To: Thierry Reding <thierry.reding@gmail.com>
CC: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-5-git-send-email-fabrice.gasnier@st.com>
 <20170706074320.GK16144@ulmo.fritz.box>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b82d9c76-d8c5-43bf-45cc-b5c26c1c7164@st.com>
Date: Fri, 7 Jul 2017 10:10:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170706074320.GK16144@ulmo.fritz.box>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 07/06/2017 09:43 AM, Thierry Reding wrote:
> On Wed, Jun 21, 2017 at 04:30:11PM +0200, Fabrice Gasnier wrote:
>> Add support for single PWM channel on Low-Power Timer, that can be
>> found on some STM32 platforms.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>> Changes in v2:
>> - s/Low Power/Low-Power
>> - update few comment lines
>> ---
>>  drivers/pwm/Kconfig        |  10 +++
>>  drivers/pwm/Makefile       |   1 +
>>  drivers/pwm/pwm-stm32-lp.c | 216 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 227 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-stm32-lp.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 313c107..7cb982b 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -417,6 +417,16 @@ config PWM_STM32
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-stm32.
>>  
>> +config PWM_STM32_LP
>> +	tristate "STMicroelectronics STM32 PWM LP"
>> +	depends on MFD_STM32_LPTIMER || COMPILE_TEST
>> +	help
>> +	  Generic PWM framework driver for STMicroelectronics STM32 SoCs
>> +	  with Low-Power Timer (LPTIM).
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-stm32-lp.
>> +
>>  config PWM_STMPE
>>  	bool "STMPE expander PWM export"
>>  	depends on MFD_STMPE
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 93da1f7..a3a4bee 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>>  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>> +obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
>>  obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
>>  obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
>>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
>> new file mode 100644
>> index 0000000..eb997a8
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-stm32-lp.c
>> @@ -0,0 +1,216 @@
>> +/*
>> + * STM32 Low-Power Timer PWM driver
>> + *
>> + * Copyright (C) STMicroelectronics 2017
>> + *
>> + * Author: Gerald Baeza <gerald.baeza@st.com>
>> + *
>> + * License terms: GNU General Public License (GPL), version 2
>> + *
>> + * Inspired by Gerald Baeza's pwm-stm32 driver
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/mfd/stm32-lptimer.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +
>> +struct stm32_pwm_lp {
>> +	struct pwm_chip chip;
>> +	struct clk *clk;
>> +	struct regmap *regmap;
>> +};
>> +
>> +static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
>> +{
>> +	return container_of(chip, struct stm32_pwm_lp, chip);
>> +}
>> +
>> +static const u8 prescalers[] = {1, 2, 4, 8, 16, 32, 64, 128};
>> +
>> +static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			      struct pwm_state *state)
>> +{
>> +	struct stm32_pwm_lp *priv = to_stm32_pwm_lp(chip);
>> +	unsigned long long prd, div, dty;
>> +	struct pwm_state cstate;
>> +	u32 val, mask, cfgr, wavpol, presc = 0;
>> +	bool reenable = false;
>> +	int ret;
>> +
>> +	pwm_get_state(pwm, &cstate);
>> +
>> +	if (!state->enabled) {
>> +		if (cstate.enabled) {
>> +			/* Disable LP timer */
>> +			ret = regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
>> +			if (ret)
>> +				return ret;
>> +			clk_disable(priv->clk);
>> +		}
>> +		return 0;
>> +	}
>> +
>> +	/* Calculate the period and prescaler value */
>> +	div = (unsigned long long)clk_get_rate(priv->clk) * state->period;
>> +	do_div(div, NSEC_PER_SEC);
>> +	prd = div;
>> +	while (div > STM32_LPTIM_MAX_ARR) {
>> +		presc++;
>> +		if (presc >= ARRAY_SIZE(prescalers)) {
>> +			dev_err(priv->chip.dev, "max prescaler exceeded\n");
>> +			return -EINVAL;
>> +		}
>> +		div = prd;
>> +		do_div(div, prescalers[presc]);
>> +	}
>> +	prd = div;
>> +
>> +	/* Calculate the duty cycle */
>> +	dty = prd * state->duty_cycle;
>> +	do_div(dty, state->period);
>> +
>> +	wavpol = FIELD_PREP(STM32_LPTIM_WAVPOL, state->polarity);
>> +
>> +	if (!cstate.enabled) {
>> +		ret = clk_enable(priv->clk);
>> +		if (ret)
>> +			return ret;
>> +	}
> 
> Why do you need the checks here? Clock enabled are reference counted, so
> you could do the clk_enable() unconditionally.

Hi Thierry,

This clock is used to generate PWM (source for LP timer counter). I
enable it here as:
- required state is 'enabled'
- current state is 'disabled'.
PWM is being turned on: first enable clock, then configure & enable PWM
bellow.

The opposite is done earlier, at the beginning of this routine:
- required state is 'disabled'
- current state is 'enabled'
PWM is turned off, then clock is disabled.

Enable count should be balanced, and clock is enabled when required
(e.g. when PWM is 'on'). Doing it unconditionally here may cause
unbalanced enable count (e.g. any duty_cycle update would increase
enable count)
Is it ok to keep this ?

> 
> Speaking of which, I don't see a clk_prepare() anywhere. Doesn't the clk
> core warn about clk_enable() being called on a clock that's not been
> prepared?

clk_get() and clk_prepare() happens in regmap layer, when probing mfd part:
-> stm32_lptimer_probe()
  -> devm_regmap_init_mmio_clk()
    -> __devm_regmap_init_mmio_clk()
      -> regmap_mmio_gen_context()

> 
>> +
>> +	ret = regmap_read(priv->regmap, STM32_LPTIM_CFGR, &cfgr);
>> +	if (ret)
>> +		goto err;
>> +
>> +	if ((wavpol != FIELD_GET(STM32_LPTIM_WAVPOL, cfgr)) ||
> 
> This looks wrong to me. Looking at the macro definitions, FIELD_PREP()
> will store the shifted value in wavpol, but FIELD_GET() will shift the
> value before returning, so you will compare an in-register value with
> a field value. I don't see how those could ever match (unless they're
> 0 or the field is at position 0, which isn't the case for WAVPOL).

Ho, you're right: thanks for pointing this!
I did some test on wavepol, but noticed nothing wrong on PWM signals.
I guess I was lucky! I'll fix it in v3.

> 
>> +	    (presc != FIELD_GET(STM32_LPTIM_PRESC, cfgr))) {
>> +		val = FIELD_PREP(STM32_LPTIM_PRESC, presc) | wavpol;
>> +		mask = STM32_LPTIM_PRESC | STM32_LPTIM_WAVPOL;
>> +
>> +		/* Must disable LP timer to modify CFGR */
>> +		ret = regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
>> +		if (ret)
>> +			goto err;
>> +		reenable = true;
> 
> The placement of this is somewhat odd. It suggests that it is somehow
> related to the disabling of the LP timer, whereas it really isn't.

In case of prescaler or polarity change, CFGR register needs to be
updated. CFGR register must be modified only when LP timer HW is disabled.
- Initial choice is to use this flag, to temporarily disable HW, update
cfgr, then re-enable it. More thinking about this...

- Another choice could be to refuse such a 'live' change and report
(busy?) error ? Then user would have to explicitly disable it, configure
new setting and re-enable it.

Please let me know your opinion.

> 
>> +		ret = regmap_update_bits(priv->regmap, STM32_LPTIM_CFGR, mask,
>> +					 val);
>> +		if (ret)
>> +			goto err;
>> +	}
>> +
>> +	if (!cstate.enabled || reenable) {
> 
> You have this condition in a couple of places and it's rather difficult
> to parse. Maybe this could be simplified a little:
> 
> 	bool reenable = !cstate.enabled;
> 	...
> 	if (...) {
> 		...
> 		reenable = true;
> 		...
> 	}
> 	...
> 	if (reenable) {
> 		...
> 	}

If I keep current 'reenable' approach (CFGR update), I'll adopt your
proposal to simplify this. Or, maybe this can be dropped (e.g. report
busy error above ?).

> 
>> +		/* Must enable LP timer to modify CMP & ARR */
>> +		ret = regmap_write(priv->regmap, STM32_LPTIM_CR,
>> +				   STM32_LPTIM_ENABLE);
>> +		if (ret)
>> +			goto err;
>> +	}
>> +
>> +	ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, prd - 1);
>> +	if (ret)
>> +		goto err;
>> +
>> +	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, prd - (1 + dty));
>> +	if (ret)
>> +		goto err;
>> +
>> +	/* ensure CMP & ARR registers are properly written */
>> +	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
>> +				       (val & STM32_LPTIM_CMPOK_ARROK),
>> +				       100, 1000);
>> +	if (ret) {
>> +		dev_err(priv->chip.dev, "ARR/CMP registers write issue\n");
>> +		goto err;
>> +	}
>> +	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
>> +			   STM32_LPTIM_CMPOKCF_ARROKCF);
>> +	if (ret)
>> +		goto err;
>> +
>> +	if (!cstate.enabled || reenable) {
>> +		/* Start LP timer in continuous mode */
>> +		ret = regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
>> +					 STM32_LPTIM_CNTSTRT,
>> +					 STM32_LPTIM_CNTSTRT);
>> +		if (ret) {
>> +			regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
>> +			goto err;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	if (!cstate.enabled)
>> +		clk_disable(priv->clk);
> 
> I think you can drop the clk_disable() here as well.

This is necessary to balance earlier clk_enable() in case of error.

> 
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct pwm_ops stm32_pwm_lp_ops = {
>> +	.owner = THIS_MODULE,
>> +	.apply = stm32_pwm_lp_apply,
>> +};
> 
> You should implement the .get_state() callback as well, otherwise the
> atomic PWM support will be somewhat handicapped.

Ok, I'll have a look at it.

> 
>> +
>> +static int stm32_pwm_lp_probe(struct platform_device *pdev)
>> +{
>> +	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
>> +	struct stm32_pwm_lp *priv;
>> +	int ret;
>> +
>> +	if (IS_ERR_OR_NULL(ddata))
>> +		return -EINVAL;
> 
> It seems to me like this can never happen. How would you trigger this
> condition?

Bad dt configuration can trigger this error: thinking of a
'st,stm32-pwm-lp' dt node without proper mfd parent. Do you want me to
drop this ?
(or add comment about it ?)

> 
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->regmap = ddata->regmap;
>> +	priv->clk = ddata->clk;
>> +	if (!priv->regmap || !priv->clk)
>> +		return -EINVAL;
> 
> Likewise for these. the stm32-lptimer driver already checks that these
> are valid, which do you need to do it again?
> 
> Well, technically you check for !NULL here, whereas stm32-lptimer does
> check for IS_ERR(), but neither regmap nor clk looks as though they're
> optional, and you won't ever get here if they can't be requested by
> stm32-lptimer in the first place.

You're right, I think I can simply drop this. (I kept this check from
pwm-stm32. Then I guess pmw-stm32 could be fixed as well.)

> 
>> +
>> +	priv->chip.base = -1;
>> +	priv->chip.dev = &pdev->dev;
>> +	priv->chip.ops = &stm32_pwm_lp_ops;
>> +	priv->chip.npwm = 1;
>> +
>> +	ret = pwmchip_add(&priv->chip);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_pwm_lp_remove(struct platform_device *pdev)
>> +{
>> +	struct stm32_pwm_lp *priv = platform_get_drvdata(pdev);
>> +
>> +	if (pwm_is_enabled(priv->chip.pwms))
>> +		pwm_disable(priv->chip.pwms);
> 
> It'd be better to use the more idiomatic variant for this:
> 
> 	for (i = 0; i < priv->chip.npwm; i++)
> 		if (pwm_is_enabled(priv->chip.npwm))
> 			pwm_disable(&priv->chip.pwms[i]);
> 
> That makes it easier to discern the common pattern and extract a helper,
> or move this to the core.

Ok, I'll update this in v3.

Many thanks for your careful review.
Best Regards,
Fabrice

> 
> Thierry
> 
