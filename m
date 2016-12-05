Return-Path: <SRS0=WF8f=XU=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161205072357.GB18069@ulmo.ba.sec>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-5-git-send-email-benjamin.gaignard@st.com> <20161205072357.GB18069@ulmo.ba.sec>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 5 Dec 2016 12:02:45 +0100
Message-ID: <CA+M3ks7_utdw1c0A0m+RzuPTfvFAv5d8HoQvQDzXwHR8M6RKJA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] PWM: add pwm driver for stm32 plaftorm
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
	Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2016-12-05 8:23 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> On Fri, Dec 02, 2016 at 11:17:19AM +0100, Benjamin Gaignard wrote:
>> This driver add support for pwm driver on stm32 platform.
>
> "adds". Also please use PWM in prose because it's an abbreviation.
>
>> The SoC have multiple instances of the hardware IP and each
>> of them could have small differences: number of channels,
>> complementary output, counter register size...
>> Use DT parameters to handle those differentes configuration
>
> "different configurations"

ok

>
>>
>> version 2:
>> - only keep one comptatible
>> - use DT paramaters to discover hardware block configuration
>
> "parameters"

ok

>
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  drivers/pwm/Kconfig     |   8 ++
>>  drivers/pwm/Makefile    |   1 +
>>  drivers/pwm/pwm-stm32.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 294 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-stm32.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index bf01288..a89fdba 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -388,6 +388,14 @@ config PWM_STI
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-sti.
>>
>> +config PWM_STM32
>> +     bool "STMicroelectronics STM32 PWM"
>> +     depends on ARCH_STM32
>> +     depends on OF
>> +     select MFD_STM32_GP_TIMER
>
> Should that be a "depends on"?

I think select is fine because the wanted feature is PWM not the mfd part

>
>> +     help
>> +       Generic PWM framework driver for STM32 SoCs.
>> +
>>  config PWM_STMPE
>>       bool "STMPE expander PWM export"
>>       depends on MFD_STMPE
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 1194c54..5aa9308 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)  += pwm-rockchip.o
>>  obj-$(CONFIG_PWM_SAMSUNG)    += pwm-samsung.o
>>  obj-$(CONFIG_PWM_SPEAR)              += pwm-spear.o
>>  obj-$(CONFIG_PWM_STI)                += pwm-sti.o
>> +obj-$(CONFIG_PWM_STM32)              += pwm-stm32.o
>>  obj-$(CONFIG_PWM_STMPE)              += pwm-stmpe.o
>>  obj-$(CONFIG_PWM_SUN4I)              += pwm-sun4i.o
>>  obj-$(CONFIG_PWM_TEGRA)              += pwm-tegra.o
>> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
>> new file mode 100644
>> index 0000000..a362f63
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-stm32.c
>> @@ -0,0 +1,285 @@
>> +/*
>> + * Copyright (C) STMicroelectronics 2016
>> + * Author:  Gerald Baeza <gerald.baeza@st.com>
>
> Could use a blank line between the above. Also, please use a single
> space after : for consistency.

ok

>
>> + * License terms:  GNU General Public License (GPL), version 2
>
> Here too.

OK

>
>> + *
>> + * Inspired by timer-stm32.c from Maxime Coquelin
>> + *             pwm-atmel.c from Bo Shen
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>
> Please sort these alphabetically.

ok

>> +
>> +#include <linux/mfd/stm32-gptimer.h>
>> +
>> +#define DRIVER_NAME "stm32-pwm"
>> +
>> +#define CAP_COMPLEMENTARY    BIT(0)
>> +#define CAP_32BITS_COUNTER   BIT(1)
>> +#define CAP_BREAKINPUT               BIT(2)
>> +#define CAP_BREAKINPUT_POLARITY BIT(3)
>
> Just make these boolean. Makes the conditionals a lot simpler to read.

I will do that for v4

>> +
>> +struct stm32_pwm_dev {
>
> No need for the _dev suffix.
>
>> +     struct device *dev;
>> +     struct clk *clk;
>> +     struct regmap *regmap;
>> +     struct pwm_chip chip;
>
> It's slightly more efficient to put this as first field because then
> to_stm32_pwm() becomes a no-op.

Ok I will remove it

>
>> +     int caps;
>> +     int npwm;
>
> unsigned int, please.
>
>> +     u32 polarity;
>
> Maybe use a prefix here to stress that it is the polarity of the
> complementary output. Otherwise one might take it for the PWM signal's
> polarity that's already part of the PWM state.

I will rename it

>
>> +};
>> +
>> +#define to_stm32_pwm_dev(x) container_of(chip, struct stm32_pwm_dev, chip)
>
> Please turn this into a static inline.

with putting struct pwm_chip as first filed I will just cast the structure

>> +
>> +static u32 __active_channels(struct stm32_pwm_dev *pwm_dev)
>
> No need for a __ prefix.

I wlll remove it

>
>> +{
>> +     u32 ccer;
>> +
>> +     regmap_read(pwm_dev->regmap, TIM_CCER, &ccer);
>> +
>> +     return ccer & TIM_CCER_CCXE;
>> +}
>> +
>> +static int write_ccrx(struct stm32_pwm_dev *dev, struct pwm_device *pwm,
>> +                   u32 ccr)
>
> u32 value, perhaps? I first mistook this to be a register offset.

OK

>
>> +{
>> +     switch (pwm->hwpwm) {
>> +     case 0:
>> +             return regmap_write(dev->regmap, TIM_CCR1, ccr);
>> +     case 1:
>> +             return regmap_write(dev->regmap, TIM_CCR2, ccr);
>> +     case 2:
>> +             return regmap_write(dev->regmap, TIM_CCR3, ccr);
>> +     case 3:
>> +             return regmap_write(dev->regmap, TIM_CCR4, ccr);
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>> +static int stm32_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> +                         int duty_ns, int period_ns)
>
> Please implement this as an atomic PWM driver, I don't want new drivers
> to use the legacy callbacks.

Ok I will just use .apply ops.

>
>> +{
>> +     struct stm32_pwm_dev *dev = to_stm32_pwm_dev(chip);
>
> I think something like "stm", or "priv" would be more appropriate here.
> If you ever need access to a struct device, you'll be hard-pressed to
> find a good name for it.

I will use priv

>
>> +     unsigned long long prd, div, dty;
>> +     int prescaler = 0;
>
> If this can never be negative, please make it unsigned int.
>
>> +     u32 max_arr = 0xFFFF, ccmr, mask, shift, bdtr;
>> +
>> +     if (dev->caps & CAP_32BITS_COUNTER)
>> +             max_arr = 0xFFFFFFFF;
>
> I prefer lower-case hexadecimal digits.

I have found a way to remove this code

>
>> +
>> +     /* Period and prescaler values depends of clock rate */
>
> "depend on"
fixed

>
>> +     div = (unsigned long long)clk_get_rate(dev->clk) * period_ns;
>> +
>> +     do_div(div, NSEC_PER_SEC);
>> +     prd = div;
>> +
>> +     while (div > max_arr) {
>> +             prescaler++;
>> +             div = prd;
>> +             do_div(div, (prescaler + 1));
>> +     }
>> +     prd = div;
>
> Blank line after blocks, please.

fixed

>
>> +
>> +     if (prescaler > MAX_TIM_PSC) {
>> +             dev_err(chip->dev, "prescaler exceeds the maximum value\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* All channels share the same prescaler and counter so
>> +      * when two channels are active at the same we can't change them
>> +      */
>
> This isn't proper block comment style. Also, please use all of the
> columns at your disposal.

done

>
>> +     if (__active_channels(dev) & ~(1 << pwm->hwpwm * 4)) {
>> +             u32 psc, arr;
>> +
>> +             regmap_read(dev->regmap, TIM_PSC, &psc);
>> +             regmap_read(dev->regmap, TIM_ARR, &arr);
>> +
>> +             if ((psc != prescaler) || (arr != prd - 1))
>> +                     return -EINVAL;
>
> Maybe -EBUSY to differentiate from other error cases?

done

>
>> +     }
>> +
>> +     regmap_write(dev->regmap, TIM_PSC, prescaler);
>> +     regmap_write(dev->regmap, TIM_ARR, prd - 1);
>> +     regmap_update_bits(dev->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
>> +
>> +     /* Calculate the duty cycles */
>> +     dty = prd * duty_ns;
>> +     do_div(dty, period_ns);
>> +
>> +     write_ccrx(dev, pwm, dty);
>> +
>> +     /* Configure output mode */
>> +     shift = (pwm->hwpwm & 0x1) * 8;
>> +     ccmr = (TIM_CCMR_PE | TIM_CCMR_M1) << shift;
>> +     mask = 0xFF << shift;
>> +
>> +     if (pwm->hwpwm & 0x2)
>
> This looks as though TIM_CCMR1 is used for channels 0 and 1, while
> TIM_CCMR2 is used for channels 2 and 3. Wouldn't it be more natural to
> make the conditional above:
>
>         if (pwm->hwpwm >= 2)
>
> ? Or perhaps better yet:
>
>         if (pwm->hwpwm < 2)
>                 /* update TIM_CCMR1 */
>         else
>                 /* update TIM_CCMR2 */

I will code it that, thanks.

>
> The other alternative, which might make the code slightly more readable,
> would be to get rid of all these conditionals by parameterizing the
> offsets per PWM channel. The PWM subsystem has a means of storing per-
> channel chip-specific data (see pwm_{set,get}_chip_data()). It might be
> a little overkill for this particular driver, given that the number of
> conditionals is fairly small.
>
>> +             regmap_update_bits(dev->regmap, TIM_CCMR2, mask, ccmr);
>> +     else
>> +             regmap_update_bits(dev->regmap, TIM_CCMR1, mask, ccmr);
>> +
>> +     if (!(dev->caps & CAP_BREAKINPUT))
>> +             return 0;
>
> If you make these capabilities boolean, it becomes much more readable,
> especially for negations:

Yes I will fix that

>
>         if (!dev->has_breakinput)
>
>> +
>> +     bdtr = TIM_BDTR_MOE | TIM_BDTR_AOE;
>> +
>> +     if (dev->caps & CAP_BREAKINPUT_POLARITY)
>> +             bdtr |= TIM_BDTR_BKE;
>> +
>> +     if (dev->polarity)
>> +             bdtr |= TIM_BDTR_BKP;
>> +
>> +     regmap_update_bits(dev->regmap, TIM_BDTR,
>> +                        TIM_BDTR_MOE | TIM_BDTR_AOE |
>> +                        TIM_BDTR_BKP | TIM_BDTR_BKE,
>> +                        bdtr);
>> +
>> +     return 0;
>> +}
>> +
>> +static int stm32_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>> +                               enum pwm_polarity polarity)
>> +{
>> +     u32 mask;
>> +     struct stm32_pwm_dev *dev = to_stm32_pwm_dev(chip);
>> +
>> +     mask = TIM_CCER_CC1P << (pwm->hwpwm * 4);
>> +     if (dev->caps & CAP_COMPLEMENTARY)
>> +             mask |= TIM_CCER_CC1NP << (pwm->hwpwm * 4);
>> +
>> +     regmap_update_bits(dev->regmap, TIM_CCER, mask,
>> +                        polarity == PWM_POLARITY_NORMAL ? 0 : mask);
>> +
>> +     return 0;
>> +}
>> +
>> +static int stm32_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     u32 mask;
>> +     struct stm32_pwm_dev *dev = to_stm32_pwm_dev(chip);
>> +
>> +     clk_enable(dev->clk);
>> +
>> +     /* Enable channel */
>> +     mask = TIM_CCER_CC1E << (pwm->hwpwm * 4);
>> +     if (dev->caps & CAP_COMPLEMENTARY)
>> +             mask |= TIM_CCER_CC1NE << (pwm->hwpwm * 4);
>> +
>> +     regmap_update_bits(dev->regmap, TIM_CCER, mask, mask);
>> +
>> +     /* Make sure that registers are updated */
>> +     regmap_update_bits(dev->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
>> +
>> +     /* Enable controller */
>> +     regmap_update_bits(dev->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
>> +
>> +     return 0;
>> +}
>> +
>> +static void stm32_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     u32 mask;
>> +     struct stm32_pwm_dev *dev = to_stm32_pwm_dev(chip);
>> +
>> +     /* Disable channel */
>> +     mask = TIM_CCER_CC1E << (pwm->hwpwm * 4);
>> +     if (dev->caps & CAP_COMPLEMENTARY)
>> +             mask |= TIM_CCER_CC1NE << (pwm->hwpwm * 4);
>> +
>> +     regmap_update_bits(dev->regmap, TIM_CCER, mask, 0);
>> +
>> +     /* When all channels are disabled, we can disable the controller */
>> +     if (!__active_channels(dev))
>> +             regmap_update_bits(dev->regmap, TIM_CR1, TIM_CR1_CEN, 0);
>> +
>> +     clk_disable(dev->clk);
>> +}
>
> All of the above can be folded into the ->apply() hook for atomic PWM
> support.
>
> Also, in the above you use clk_enable() in the ->enable() callback and
> clk_disable() in ->disable(). If you need the clock to access registers
> you'll have to enabled it in the others as well because there are no
> guarantees that configuration will only happen between ->enable() and
> ->disable(). Atomic PWM simplifies this a bit, but you still need to be
> careful about when to enable the clock in your ->apply() hook.

I have used regmap functions enable/disable clk for me when accessing to
the registers.
I only have to take care of clk enable/disable when PWM state change.

>
>> +
>> +static const struct pwm_ops stm32pwm_ops = {
>> +     .config = stm32_pwm_config,
>> +     .set_polarity = stm32_pwm_set_polarity,
>> +     .enable = stm32_pwm_enable,
>> +     .disable = stm32_pwm_disable,
>> +};
>
> You need to set the .owner field as well.

OK and I will remove legacy ops to use only apply.

>
>> +
>> +static int stm32_pwm_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct device_node *np = dev->of_node;
>> +     struct stm32_gptimer_dev *mfd = dev_get_drvdata(pdev->dev.parent);
>> +     struct stm32_pwm_dev *pwm;
>> +     int ret;
>> +
>> +     pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
>> +     if (!pwm)
>> +             return -ENOMEM;
>> +
>> +     pwm->regmap = mfd->regmap;
>> +     pwm->clk = mfd->clk;
>> +
>> +     if (!pwm->regmap || !pwm->clk)
>> +             return -EINVAL;
>> +
>> +     if (of_property_read_bool(np, "st,complementary"))
>> +             pwm->caps |= CAP_COMPLEMENTARY;
>> +
>> +     if (of_property_read_bool(np, "st,32bits-counter"))
>> +             pwm->caps |= CAP_32BITS_COUNTER;
>> +
>> +     if (of_property_read_bool(np, "st,breakinput"))
>> +             pwm->caps |= CAP_BREAKINPUT;
>> +
>> +     if (!of_property_read_u32(np, "st,breakinput-polarity", &pwm->polarity))
>> +             pwm->caps |= CAP_BREAKINPUT_POLARITY;
>> +
>> +     of_property_read_u32(np, "st,pwm-num-chan", &pwm->npwm);
>> +
>> +     pwm->chip.base = -1;
>> +     pwm->chip.dev = dev;
>> +     pwm->chip.ops = &stm32pwm_ops;
>> +     pwm->chip.npwm = pwm->npwm;
>> +
>> +     ret = pwmchip_add(&pwm->chip);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     platform_set_drvdata(pdev, pwm);
>> +
>> +     return 0;
>> +}
>> +
>> +static int stm32_pwm_remove(struct platform_device *pdev)
>> +{
>> +     struct stm32_pwm_dev *pwm = platform_get_drvdata(pdev);
>> +     int i;
>
> unsigned int, please.
OK

>
>> +
>> +     for (i = 0; i < pwm->npwm; i++)
>> +             pwm_disable(&pwm->chip.pwms[i]);
>> +
>> +     pwmchip_remove(&pwm->chip);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id stm32_pwm_of_match[] = {
>> +     {
>> +             .compatible = "st,stm32-pwm",
>> +     },
>
> The above can be collapsed into a single line.

OK

>
>> +};
>> +MODULE_DEVICE_TABLE(of, stm32_pwm_of_match);
>> +
>> +static struct platform_driver stm32_pwm_driver = {
>> +     .probe          = stm32_pwm_probe,
>> +     .remove         = stm32_pwm_remove,
>> +     .driver = {
>> +             .name   = DRIVER_NAME,
>> +             .of_match_table = stm32_pwm_of_match,
>> +     },
>> +};
>
> Please don't use tabs for padding within the structure definition since
> it doesn't align properly anyway.

OK

>
>> +module_platform_driver(stm32_pwm_driver);
>> +
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
>> +MODULE_DESCRIPTION("STMicroelectronics STM32 PWM driver");
>> +MODULE_LICENSE("GPL");
>
> According to the header comment this should be "GPL v2".

done

>
> Thanks,
> Thierry
