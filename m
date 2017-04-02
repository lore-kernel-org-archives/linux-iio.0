Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48418 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdDBLp1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 07:45:27 -0400
Subject: Re: [PATCH 3/4] iio: dac: stm32: add support for trigger events
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1490960707-22422-1-git-send-email-fabrice.gasnier@st.com>
 <1490960707-22422-4-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
        linus.walleij@linaro.org, amelie.delaunay@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <eb4d6292-5ae6-c52d-eeb7-2f14c3a4abef@kernel.org>
Date: Sun, 2 Apr 2017 12:45:24 +0100
MIME-Version: 1.0
In-Reply-To: <1490960707-22422-4-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/17 12:45, Fabrice Gasnier wrote:
> STM32 DAC supports triggers to synchronize conversions. When trigger
> occurs, data is transferred from DHR (data holding register) to DOR
> (data output register) so output voltage is updated.
> Both hardware and software triggers are supported.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Hmm. This is a somewhat different use of triggered event from normal...

What you have here is rather closer to the output buffers stuff that Analog
have in their tree which hasn't made it upstream yet.
To that end I'll want Lars to have a look at this...  I've completely
lost track of where they are with this.
Perhaps Lars can give us a quick update?

If that was in place (or what I have in my head was true anyway),
it would look like the reverse of the triggered buffer input devices.
You'd be able to write to a software buffer and it would clock them
out as the trigger fires (here I think it would have to keep updating
the DHR whenever the trigger occurs).

Even if it's not there, we aren't necessarily looking at terribly big job
to implement it in the core and that would make this handling a lot more
'standard' and consistent.

Jonathan

> ---
>  drivers/iio/dac/Kconfig          |   3 +
>  drivers/iio/dac/stm32-dac-core.h |  12 ++++
>  drivers/iio/dac/stm32-dac.c      | 124 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 136 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 7198648..786c38b 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -278,6 +278,9 @@ config STM32_DAC
>  	tristate "STMicroelectronics STM32 DAC"
>  	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>  	depends on REGULATOR
> +	select IIO_TRIGGERED_EVENT
> +	select IIO_STM32_TIMER_TRIGGER
> +	select MFD_STM32_TIMERS
>  	select STM32_DAC_CORE
>  	help
>  	  Say yes here to build support for STMicroelectronics STM32 Digital
> diff --git a/drivers/iio/dac/stm32-dac-core.h b/drivers/iio/dac/stm32-dac-core.h
> index d3099f7..3bf211c 100644
> --- a/drivers/iio/dac/stm32-dac-core.h
> +++ b/drivers/iio/dac/stm32-dac-core.h
> @@ -26,6 +26,7 @@
>  
>  /* STM32 DAC registers */
>  #define STM32_DAC_CR		0x00
> +#define STM32_DAC_SWTRIGR	0x04
>  #define STM32_DAC_DHR12R1	0x08
>  #define STM32_DAC_DHR12R2	0x14
>  #define STM32_DAC_DOR1		0x2C
> @@ -33,8 +34,19 @@
>  
>  /* STM32_DAC_CR bit fields */
>  #define STM32_DAC_CR_EN1		BIT(0)
> +#define STM32H7_DAC_CR_TEN1		BIT(1)
> +#define STM32H7_DAC_CR_TSEL1_SHIFT	2
> +#define STM32H7_DAC_CR_TSEL1		GENMASK(5, 2)
> +#define STM32_DAC_CR_WAVE1		GENMASK(7, 6)
> +#define STM32_DAC_CR_MAMP1		GENMASK(11, 8)
>  #define STM32H7_DAC_CR_HFSEL		BIT(15)
>  #define STM32_DAC_CR_EN2		BIT(16)
> +#define STM32_DAC_CR_WAVE2		GENMASK(23, 22)
> +#define STM32_DAC_CR_MAMP2		GENMASK(27, 24)
> +
> +/* STM32_DAC_SWTRIGR bit fields */
> +#define STM32_DAC_SWTRIGR_SWTRIG1	BIT(0)
> +#define STM32_DAC_SWTRIGR_SWTRIG2	BIT(1)
>  
>  /**
>   * struct stm32_dac_common - stm32 DAC driver common data (for all instances)
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index ee9711d..62e43e9 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -23,6 +23,10 @@
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/timer/stm32-timer-trigger.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_event.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -31,15 +35,112 @@
>  
>  #define STM32_DAC_CHANNEL_1		1
>  #define STM32_DAC_CHANNEL_2		2
> +/* channel2 shift */
> +#define STM32_DAC_CHAN2_SHIFT		16
>  
>  /**
>   * struct stm32_dac - private data of DAC driver
>   * @common:		reference to DAC common data
> + * @swtrig:		Using software trigger
>   */
>  struct stm32_dac {
>  	struct stm32_dac_common *common;
> +	bool swtrig;
>  };
>  
> +/**
> + * struct stm32_dac_trig_info - DAC trigger info
> + * @name: name of the trigger, corresponding to its source
> + * @tsel: trigger selection, value to be configured in DAC_CR.TSELx
> + */
> +struct stm32_dac_trig_info {
> +	const char *name;
> +	u32 tsel;
> +};
> +
> +static const struct stm32_dac_trig_info stm32h7_dac_trinfo[] = {
> +	{ "swtrig", 0 },
> +	{ TIM1_TRGO, 1 },
> +	{ TIM2_TRGO, 2 },
> +	{ TIM4_TRGO, 3 },
> +	{ TIM5_TRGO, 4 },
> +	{ TIM6_TRGO, 5 },
> +	{ TIM7_TRGO, 6 },
> +	{ TIM8_TRGO, 7 },
> +	{},
> +};
> +
> +static irqreturn_t stm32_dac_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +	int channel = indio_dev->channels[0].channel;
> +
> +	/* Using software trigger? Then, trigger it now */
> +	if (dac->swtrig) {
> +		u32 swtrig;
> +
> +		if (channel == STM32_DAC_CHANNEL_1)
> +			swtrig = STM32_DAC_SWTRIGR_SWTRIG1;
> +		else
> +			swtrig = STM32_DAC_SWTRIGR_SWTRIG2;
> +		regmap_update_bits(dac->common->regmap, STM32_DAC_SWTRIGR,
> +				   swtrig, swtrig);
> +	}
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static unsigned int stm32_dac_get_trig_tsel(struct stm32_dac *dac,
> +					    struct iio_trigger *trig)
> +{
> +	unsigned int i;
> +
> +	/* skip 1st trigger that should be swtrig */
> +	for (i = 1; stm32h7_dac_trinfo[i].name; i++) {
> +		/*
> +		 * Checking both stm32 timer trigger type and trig name
> +		 * should be safe against arbitrary trigger names.
> +		 */
> +		if (is_stm32_timer_trigger(trig) &&
> +		    !strcmp(stm32h7_dac_trinfo[i].name, trig->name)) {
> +			return stm32h7_dac_trinfo[i].tsel;
> +		}
> +	}
> +
> +	/* When no trigger has been found, default to software trigger */
> +	dac->swtrig = true;
> +
> +	return stm32h7_dac_trinfo[0].tsel;
> +}
> +
> +static int stm32_dac_set_trig(struct stm32_dac *dac, struct iio_trigger *trig,
> +			      int channel)
> +{
> +	struct iio_dev *indio_dev = iio_priv_to_dev(dac);
> +	u32 shift = channel == STM32_DAC_CHANNEL_1 ? 0 : STM32_DAC_CHAN2_SHIFT;
> +	u32 val = 0, tsel;
> +	u32 msk = (STM32H7_DAC_CR_TEN1 | STM32H7_DAC_CR_TSEL1) << shift;
> +
> +	dac->swtrig = false;
> +	if (trig) {
> +		/* select & enable trigger (tsel / ten) */
> +		tsel = stm32_dac_get_trig_tsel(dac, trig);
> +		val = tsel << STM32H7_DAC_CR_TSEL1_SHIFT;
> +		val = (val | STM32H7_DAC_CR_TEN1) << shift;
> +	}
> +
> +	if (trig)
> +		dev_dbg(&indio_dev->dev, "enable trigger: %s\n", trig->name);
> +	else
> +		dev_dbg(&indio_dev->dev, "disable trigger\n");
> +
> +	return regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, val);
> +}
> +
>  static int stm32_dac_is_enabled(struct stm32_dac *dac, int channel)
>  {
>  	u32 en, val;
> @@ -63,9 +164,16 @@ static int stm32_dac_enable(struct iio_dev *indio_dev, int channel)
>  		STM32_DAC_CR_EN1 : STM32_DAC_CR_EN2;
>  	int ret;
>  
> +	ret = stm32_dac_set_trig(dac, indio_dev->trig, channel);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "Trigger setup failed\n");
> +		return ret;
> +	}
> +
>  	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, en, en);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev, "Enable failed\n");
> +		stm32_dac_set_trig(dac, NULL, channel);
>  		return ret;
>  	}
>  
> @@ -88,10 +196,12 @@ static int stm32_dac_disable(struct iio_dev *indio_dev, int channel)
>  	int ret;
>  
>  	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, en, 0);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&indio_dev->dev, "Disable failed\n");
> +		return ret;
> +	}
>  
> -	return ret;
> +	return stm32_dac_set_trig(dac, NULL, channel);
>  }
>  
>  static int stm32_dac_get_value(struct stm32_dac *dac, int channel, int *val)
> @@ -258,10 +368,17 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = iio_triggered_event_setup(indio_dev, NULL,
> +					stm32_dac_trigger_handler);
>  	if (ret)
>  		return ret;
>  
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		iio_triggered_event_cleanup(indio_dev);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -269,6 +386,7 @@ static int stm32_dac_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  
> +	iio_triggered_event_cleanup(indio_dev);
>  	iio_device_unregister(indio_dev);
>  
>  	return 0;
> 

