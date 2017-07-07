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
 <b82d9c76-d8c5-43bf-45cc-b5c26c1c7164@st.com>
 <20170707092316.GA15652@ulmo.fritz.box>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <af822b98-8258-ff91-92ba-13add262743f@st.com>
Date: Fri, 7 Jul 2017 12:11:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170707092316.GA15652@ulmo.fritz.box>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 07/07/2017 11:23 AM, Thierry Reding wrote:
> On Fri, Jul 07, 2017 at 10:10:32AM +0200, Fabrice Gasnier wrote:
>> On 07/06/2017 09:43 AM, Thierry Reding wrote:
>>> On Wed, Jun 21, 2017 at 04:30:11PM +0200, Fabrice Gasnier wrote:
>>>> Add support for single PWM channel on Low-Power Timer, that can be
>>>> found on some STM32 platforms.
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>> ---
>>>> Changes in v2:
>>>> - s/Low Power/Low-Power
>>>> - update few comment lines
>>>> ---
>>>>  drivers/pwm/Kconfig        |  10 +++
>>>>  drivers/pwm/Makefile       |   1 +
>>>>  drivers/pwm/pwm-stm32-lp.c | 216 +++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 227 insertions(+)
>>>>  create mode 100644 drivers/pwm/pwm-stm32-lp.c
>>>>
>>>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>>> index 313c107..7cb982b 100644
>>>> --- a/drivers/pwm/Kconfig
>>>> +++ b/drivers/pwm/Kconfig
>>>> @@ -417,6 +417,16 @@ config PWM_STM32
>>>>  	  To compile this driver as a module, choose M here: the module
>>>>  	  will be called pwm-stm32.
>>>>  
>>>> +config PWM_STM32_LP
>>>> +	tristate "STMicroelectronics STM32 PWM LP"
>>>> +	depends on MFD_STM32_LPTIMER || COMPILE_TEST
>>>> +	help
>>>> +	  Generic PWM framework driver for STMicroelectronics STM32 SoCs
>>>> +	  with Low-Power Timer (LPTIM).
>>>> +
>>>> +	  To compile this driver as a module, choose M here: the module
>>>> +	  will be called pwm-stm32-lp.
>>>> +
>>>>  config PWM_STMPE
>>>>  	bool "STMPE expander PWM export"
>>>>  	depends on MFD_STMPE
>>>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>>>> index 93da1f7..a3a4bee 100644
>>>> --- a/drivers/pwm/Makefile
>>>> +++ b/drivers/pwm/Makefile
>>>> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>>>>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>>>>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>>>>  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>>>> +obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
>>>>  obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
>>>>  obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
>>>>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>>>> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
>>>> new file mode 100644
>>>> index 0000000..eb997a8
>>>> --- /dev/null
>>>> +++ b/drivers/pwm/pwm-stm32-lp.c
>>>> @@ -0,0 +1,216 @@
>>>> +/*
>>>> + * STM32 Low-Power Timer PWM driver
>>>> + *
>>>> + * Copyright (C) STMicroelectronics 2017
>>>> + *
>>>> + * Author: Gerald Baeza <gerald.baeza@st.com>
>>>> + *
>>>> + * License terms: GNU General Public License (GPL), version 2
>>>> + *
>>>> + * Inspired by Gerald Baeza's pwm-stm32 driver
>>>> + */
>>>> +
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/mfd/stm32-lptimer.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/pwm.h>
>>>> +
>>>> +struct stm32_pwm_lp {
>>>> +	struct pwm_chip chip;
>>>> +	struct clk *clk;
>>>> +	struct regmap *regmap;
>>>> +};
>>>> +
>>>> +static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
>>>> +{
>>>> +	return container_of(chip, struct stm32_pwm_lp, chip);
>>>> +}
>>>> +
>>>> +static const u8 prescalers[] = {1, 2, 4, 8, 16, 32, 64, 128};
>>>> +
>>>> +static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>> +			      struct pwm_state *state)
>>>> +{
>>>> +	struct stm32_pwm_lp *priv = to_stm32_pwm_lp(chip);
>>>> +	unsigned long long prd, div, dty;
>>>> +	struct pwm_state cstate;
>>>> +	u32 val, mask, cfgr, wavpol, presc = 0;
>>>> +	bool reenable = false;
>>>> +	int ret;
>>>> +
>>>> +	pwm_get_state(pwm, &cstate);
>>>> +
>>>> +	if (!state->enabled) {
>>>> +		if (cstate.enabled) {
>>>> +			/* Disable LP timer */
>>>> +			ret = regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
>>>> +			if (ret)
>>>> +				return ret;
>>>> +			clk_disable(priv->clk);
>>>> +		}
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	/* Calculate the period and prescaler value */
>>>> +	div = (unsigned long long)clk_get_rate(priv->clk) * state->period;
>>>> +	do_div(div, NSEC_PER_SEC);
>>>> +	prd = div;
>>>> +	while (div > STM32_LPTIM_MAX_ARR) {
>>>> +		presc++;
>>>> +		if (presc >= ARRAY_SIZE(prescalers)) {
>>>> +			dev_err(priv->chip.dev, "max prescaler exceeded\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>> +		div = prd;
>>>> +		do_div(div, prescalers[presc]);
>>>> +	}
>>>> +	prd = div;
>>>> +
>>>> +	/* Calculate the duty cycle */
>>>> +	dty = prd * state->duty_cycle;
>>>> +	do_div(dty, state->period);
>>>> +
>>>> +	wavpol = FIELD_PREP(STM32_LPTIM_WAVPOL, state->polarity);
>>>> +
>>>> +	if (!cstate.enabled) {
>>>> +		ret = clk_enable(priv->clk);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>
>>> Why do you need the checks here? Clock enabled are reference counted, so
>>> you could do the clk_enable() unconditionally.
>>
>> Hi Thierry,
>>
>> This clock is used to generate PWM (source for LP timer counter). I
>> enable it here as:
>> - required state is 'enabled'
>> - current state is 'disabled'.
>> PWM is being turned on: first enable clock, then configure & enable PWM
>> bellow.
>>
>> The opposite is done earlier, at the beginning of this routine:
>> - required state is 'disabled'
>> - current state is 'enabled'
>> PWM is turned off, then clock is disabled.
>>
>> Enable count should be balanced, and clock is enabled when required
>> (e.g. when PWM is 'on'). Doing it unconditionally here may cause
>> unbalanced enable count (e.g. any duty_cycle update would increase
>> enable count)
>> Is it ok to keep this ?
> 
> The placement of the call suggested that you also need to enable the
> clock in order to access any of the registers. In such cases it's often
> simpler to take (and release) the reference to the clock irrespective
> of the current state.
> 
> So the general sequence might look like this:
> 
> 	/* allow access to registers */
> 	clk_enable();
> 
> 	/* modify registers */
> 	...
> 
> 	/* enable clock to drive PWM counter */
> 	if (state->enabled && !cstate.enabled)
> 		clk_enable();
> 
> 	/* disable clock to PWM counter */
> 	if (!state->enabled && cstate.enabled)
> 		clk_disable();
> 
> 	/* access to registers no longer needed */
> 	clk_disable();
> 
> This ensures that as long as you keep the "register" reference to the
> clock, the clock will remain on.

Hi Thierry,

I better see your point now. Regmap is already handling clock for
register access. I'll try to re-arrange things a little, so it's easier
to read and comment about enable/disable clock to PWM counter.

> 
> There is a somewhat tricky situation that could happen if the initial
> clock reference count is not in sync. Consider the case where your
> ->get_state() determines that the PWM is enabled. cstate.enabled would
> be true, but the clock enable count would not be incremented. So you'd
> have to make sure to add code to the ->get_state() implementation that
> calls clk_enable() for each PWM that is enabled.
> 
> In my opinion that would be the cleanest option and easiest to follow,
> but its more work to properly implement than I initially assumed, so
> I'm fine with the version that you have, too.

Thanks for these hints, I'll try to follow your advise on this:
- use get_state()
- call clk_enable() if PWM is already enabled.

> 
>>> Speaking of which, I don't see a clk_prepare() anywhere. Doesn't the clk
>>> core warn about clk_enable() being called on a clock that's not been
>>> prepared?
>>
>> clk_get() and clk_prepare() happens in regmap layer, when probing mfd part:
>> -> stm32_lptimer_probe()
>>   -> devm_regmap_init_mmio_clk()
>>     -> __devm_regmap_init_mmio_clk()
>>       -> regmap_mmio_gen_context()
> 
> Okay, looks like we don't need it here, then.
> 
>>>> +	    (presc != FIELD_GET(STM32_LPTIM_PRESC, cfgr))) {
>>>> +		val = FIELD_PREP(STM32_LPTIM_PRESC, presc) | wavpol;
>>>> +		mask = STM32_LPTIM_PRESC | STM32_LPTIM_WAVPOL;
>>>> +
>>>> +		/* Must disable LP timer to modify CFGR */
>>>> +		ret = regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
>>>> +		if (ret)
>>>> +			goto err;
>>>> +		reenable = true;
>>>
>>> The placement of this is somewhat odd. It suggests that it is somehow
>>> related to the disabling of the LP timer, whereas it really isn't.
>>
>> In case of prescaler or polarity change, CFGR register needs to be
>> updated. CFGR register must be modified only when LP timer HW is disabled.
>> - Initial choice is to use this flag, to temporarily disable HW, update
>> cfgr, then re-enable it. More thinking about this...
> 
> What I find odd about the placement is that it is between the
> regmap_write() and the regmap_update_bits(). But it could just as well
> be after the regmap_update_bits() (or before regmap_write() for that
> matter). So the confusing thing is why it "breaks" the sequence of
> register accesses.

Ok, I'll move it before or after register accesses sequence.

> 
>> - Another choice could be to refuse such a 'live' change and report
>> (busy?) error ? Then user would have to explicitly disable it, configure
>> new setting and re-enable it.
>>
>> Please let me know your opinion.
> 
> The PWM subsystem doesn't give a guarantee that a live change is
> possible. Drivers always have to assume that the PWM may get disabled
> and reenabled as part of the sequence.
> 
> That said, something like this could be added in the future if users
> come along that required this guarantee.
> 
> For your driver, I think it's fine to keep this as-is.
Got it.

> 
>>>> +static int stm32_pwm_lp_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
>>>> +	struct stm32_pwm_lp *priv;
>>>> +	int ret;
>>>> +
>>>> +	if (IS_ERR_OR_NULL(ddata))
>>>> +		return -EINVAL;
>>>
>>> It seems to me like this can never happen. How would you trigger this
>>> condition?
>>
>> Bad dt configuration can trigger this error: thinking of a
>> 'st,stm32-pwm-lp' dt node without proper mfd parent. Do you want me to
>> drop this ?
>> (or add comment about it ?)
> 
> In my opinion we should trust DTB in this type of situation. If the DT
> binding says that the PWM node needs to be a child of an MFD, then the
> author of the DTB needs to make sure it is.
> 
> For things that can be easily checked I think it makes sense to validate
> the DTB, but this check here is not enough for all situations, right?
> What if somebody added the device node as child to some unrelated node.
> ddata could be a valid pointer, but pointing at something that's not a
> struct stm32_lptimer at all. That's still pretty bad, and completely
> undetectable.

You're right. I'll remove this as well.

Thanks again,
Best Regards,
Fabrice

> 
> Thierry
> 
