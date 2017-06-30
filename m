Return-Path: <SRS0=nB8X=6D=st.com=fabrice.gasnier@kernel.org>
Subject: Re: [PATCH v2 6/8] iio: trigger: Add STM32 LPTimer trigger driver
To: Jonathan Cameron <jic23@kernel.org>
CC: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-7-git-send-email-fabrice.gasnier@st.com>
 <20170624211335.680b5b90@kernel.org>
 <a1368383-8e5e-72ab-32f9-efe9715aaccb@st.com>
 <20170630145713.2e612033@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <5435defb-f32e-c874-4977-e3eea5574774@st.com>
Date: Fri, 30 Jun 2017 18:26:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170630145713.2e612033@kernel.org>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 06/30/2017 03:57 PM, Jonathan Cameron wrote:
> On Mon, 26 Jun 2017 18:41:36 +0200
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
>> On 06/24/2017 10:13 PM, Jonathan Cameron wrote:
>>> On Wed, 21 Jun 2017 16:30:13 +0200
>>> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>>>   
>>>> Add support for LPTIMx_OUT triggers that can be found on some STM32
>>>> devices. These triggers can be used then by ADC or DAC.
>>>> Typical usage is to configure LPTimer as PWM output (via pwm-stm32-lp)
>>>> and have synchronised analog conversions with these triggers.
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>  
>>> Given this can't be used as a trigger for other devices (no exposed
>>> interrupt?) I'd expect to see a validate_device callback provided for
>>> the trigger ops.  That would prevent other devices trying to use it.  
>>
>> Hi Jonathan,
>>
>> This is something I had in mind also earlier. Only thing is...
>> Basically, this is limiting: when trigger poll happens on device side
>> (e.g. ADC), another device could use same trigger. But I admit this
>> looks like corner case.
>>
>> I'll add it in next version, with additional patch for ADC part to
>> validate it's a valid device (No DAC yet).
>> I think I'll use INDIO_HARDWARE_TRIGGERED mode:
>> - in adc driver: indio_dev->modes |= INDIO_HARDWARE_TRIGGERED;
>> - in lptimer: if (indio_dev->modes & INDIO_HARDWARE_TRIGGERED)...
> That may not be enough in of itself.  Could be other hardware
> triggered elements on the platform (quite likely with these
> stm parts!)
> 

Hi Jonathan,

As far as I can see, devices supporting it need to check trigger anyway
(e.g. validate_trigger() cb). That is the case currently on stm32-adc
driver. Do you think this "handshake" is okay ?

If not, I can probably add an export symbol instead, in stm32-adc, like:
bool is_stm32_adc_iio_dev(struct iio_dev *indio_dev);
Then use it in validate_device callback.

Please let me know.

Best regards,
Fabrice

> J
>>
>>>
>>> Otherwise, looks good.  
>>
>> Many thanks for your review.
>> Best Regards,
>> Fabrice
>>
>>>
>>> Jonathan  
>>>> ---
>>>> Changes in v2:
>>>> - s/Low Power/Low-Power
>>>> - update few comments
>>>> ---
>>>>  drivers/iio/trigger/Kconfig                   |  11 +++
>>>>  drivers/iio/trigger/Makefile                  |   1 +
>>>>  drivers/iio/trigger/stm32-lptimer-trigger.c   | 110 ++++++++++++++++++++++++++
>>>>  include/linux/iio/timer/stm32-lptim-trigger.h |  24 ++++++
>>>>  4 files changed, 146 insertions(+)
>>>>  create mode 100644 drivers/iio/trigger/stm32-lptimer-trigger.c
>>>>  create mode 100644 include/linux/iio/timer/stm32-lptim-trigger.h
>>>>
>>>> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
>>>> index e4d4e63..a633d2c 100644
>>>> --- a/drivers/iio/trigger/Kconfig
>>>> +++ b/drivers/iio/trigger/Kconfig
>>>> @@ -24,6 +24,17 @@ config IIO_INTERRUPT_TRIGGER
>>>>  	  To compile this driver as a module, choose M here: the
>>>>  	  module will be called iio-trig-interrupt.
>>>>  
>>>> +config IIO_STM32_LPTIMER_TRIGGER
>>>> +	tristate "STM32 Low-Power Timer Trigger"
>>>> +	depends on MFD_STM32_LPTIMER || COMPILE_TEST
>>>> +	help
>>>> +	  Select this option to enable STM32 Low-Power Timer Trigger.
>>>> +	  This can be used as trigger source for STM32 internal ADC
>>>> +	  and/or DAC.
>>>> +
>>>> +	  To compile this driver as a module, choose M here: the
>>>> +	  module will be called stm32-lptimer-trigger.
>>>> +
>>>>  config IIO_STM32_TIMER_TRIGGER
>>>>  	tristate "STM32 Timer Trigger"
>>>>  	depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST
>>>> diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
>>>> index 5c4ecd3..0a72a2a 100644
>>>> --- a/drivers/iio/trigger/Makefile
>>>> +++ b/drivers/iio/trigger/Makefile
>>>> @@ -6,6 +6,7 @@
>>>>  
>>>>  obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
>>>>  obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
>>>> +obj-$(CONFIG_IIO_STM32_LPTIMER_TRIGGER) += stm32-lptimer-trigger.o
>>>>  obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) += stm32-timer-trigger.o
>>>>  obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
>>>>  obj-$(CONFIG_IIO_TIGHTLOOP_TRIGGER) += iio-trig-loop.o
>>>> diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
>>>> new file mode 100644
>>>> index 0000000..bcb9aa2
>>>> --- /dev/null
>>>> +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
>>>> @@ -0,0 +1,110 @@
>>>> +/*
>>>> + * STM32 Low-Power Timer Trigger driver
>>>> + *
>>>> + * Copyright (C) STMicroelectronics 2017
>>>> + *
>>>> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
>>>> + *
>>>> + * License terms:  GNU General Public License (GPL), version 2
>>>> + *
>>>> + * Inspired by Benjamin Gaignard's stm32-timer-trigger driver
>>>> + */
>>>> +
>>>> +#include <linux/iio/iio.h>
>>>> +#include <linux/iio/timer/stm32-lptim-trigger.h>
>>>> +#include <linux/iio/trigger.h>
>>>> +#include <linux/mfd/stm32-lptimer.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +/* List Low-Power Timer triggers */
>>>> +static const char * const stm32_lptim_triggers[] = {
>>>> +	LPTIM1_OUT,
>>>> +	LPTIM2_OUT,
>>>> +	LPTIM3_OUT,
>>>> +};
>>>> +
>>>> +struct stm32_lptim_trigger {
>>>> +	struct device *dev;
>>>> +	const char *trg;
>>>> +};
>>>> +
>>>> +static const struct iio_trigger_ops stm32_lptim_trigger_ops = {
>>>> +	.owner = THIS_MODULE,
>>>> +};
>>>> +
>>>> +/**
>>>> + * is_stm32_lptim_trigger
>>>> + * @trig: trigger to be checked
>>>> + *
>>>> + * return true if the trigger is a valid STM32 IIO Low-Power Timer Trigger
>>>> + * either return false
>>>> + */
>>>> +bool is_stm32_lptim_trigger(struct iio_trigger *trig)
>>>> +{
>>>> +	return (trig->ops == &stm32_lptim_trigger_ops);
>>>> +}
>>>> +EXPORT_SYMBOL(is_stm32_lptim_trigger);
>>>> +
>>>> +static int stm32_lptim_setup_trig(struct stm32_lptim_trigger *priv)
>>>> +{
>>>> +	struct iio_trigger *trig;
>>>> +
>>>> +	trig = devm_iio_trigger_alloc(priv->dev, "%s", priv->trg);
>>>> +	if  (!trig)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	trig->dev.parent = priv->dev->parent;
>>>> +	trig->ops = &stm32_lptim_trigger_ops;
>>>> +	iio_trigger_set_drvdata(trig, priv);
>>>> +
>>>> +	return devm_iio_trigger_register(priv->dev, trig);
>>>> +}
>>>> +
>>>> +static int stm32_lptim_trigger_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct stm32_lptim_trigger *priv;
>>>> +	u32 index;
>>>> +	int ret;
>>>> +
>>>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>>> +	if (!priv)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	if (of_property_read_u32(pdev->dev.of_node, "reg", &index))
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (index >= ARRAY_SIZE(stm32_lptim_triggers))
>>>> +		return -EINVAL;
>>>> +
>>>> +	priv->dev = &pdev->dev;
>>>> +	priv->trg = stm32_lptim_triggers[index];
>>>> +
>>>> +	ret = stm32_lptim_setup_trig(priv);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	platform_set_drvdata(pdev, priv);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct of_device_id stm32_lptim_trig_of_match[] = {
>>>> +	{ .compatible = "st,stm32-lptimer-trigger", },
>>>> +	{},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, stm32_lptim_trig_of_match);
>>>> +
>>>> +static struct platform_driver stm32_lptim_trigger_driver = {
>>>> +	.probe = stm32_lptim_trigger_probe,
>>>> +	.driver = {
>>>> +		.name = "stm32-lptimer-trigger",
>>>> +		.of_match_table = stm32_lptim_trig_of_match,
>>>> +	},
>>>> +};
>>>> +module_platform_driver(stm32_lptim_trigger_driver);
>>>> +
>>>> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>>>> +MODULE_ALIAS("platform:stm32-lptimer-trigger");
>>>> +MODULE_DESCRIPTION("STMicroelectronics STM32 LPTIM trigger driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/include/linux/iio/timer/stm32-lptim-trigger.h b/include/linux/iio/timer/stm32-lptim-trigger.h
>>>> new file mode 100644
>>>> index 0000000..cb795b1
>>>> --- /dev/null
>>>> +++ b/include/linux/iio/timer/stm32-lptim-trigger.h
>>>> @@ -0,0 +1,24 @@
>>>> +/*
>>>> + * Copyright (C) STMicroelectronics 2017
>>>> + *
>>>> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>> + *
>>>> + * License terms:  GNU General Public License (GPL), version 2
>>>> + */
>>>> +
>>>> +#ifndef _STM32_LPTIM_TRIGGER_H_
>>>> +#define _STM32_LPTIM_TRIGGER_H_
>>>> +
>>>> +#define LPTIM1_OUT	"lptim1_out"
>>>> +#define LPTIM2_OUT	"lptim2_out"
>>>> +#define LPTIM3_OUT	"lptim3_out"
>>>> +
>>>> +#if IS_ENABLED(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
>>>> +bool is_stm32_lptim_trigger(struct iio_trigger *trig);
>>>> +#else
>>>> +static inline bool is_stm32_lptim_trigger(struct iio_trigger *trig)
>>>> +{
>>>> +	return false;
>>>> +}
>>>> +#endif
>>>> +#endif  
>>>   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
