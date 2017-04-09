Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42934 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbdDIJFA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Apr 2017 05:05:00 -0400
Subject: Re: [PATCH v2 4/5] iio: dac: stm32: add support for trigger events
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1491495116-7209-1-git-send-email-fabrice.gasnier@st.com>
 <1491495116-7209-5-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <14dfe2a9-d459-0074-532e-d44daf336406@kernel.org>
Date: Sun, 9 Apr 2017 10:04:56 +0100
MIME-Version: 1.0
In-Reply-To: <1491495116-7209-5-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/17 17:11, Fabrice Gasnier wrote:
> STM32 DAC supports triggers to synchronize conversions. When trigger
> occurs, data is transferred from DHR (data holding register) to DOR
> (data output register) so output voltage is updated.
> Both hardware and software triggers are supported.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Hmm. I'm really not sure on how to handle this...  The problem to my mind
is knowing when it has triggered so we can know that it makes sense to
put the next reading in.... Anyhow bear with me...

I think the same arguement holds for this as equivalent input devices.
There we have always argued that if you need multichannel synchronized
capture (which is 'kind' of what we are looking at here) then you have
to use the buffered interface.

I think we need buffered output for this to fit nicely in the subsystem.
It definitely isn't a correct use of the event triggers.

That means we really need to figure out the ABI for buffered output and
get that sorted.  To my mind it shouldn't be too tricky and should look
much like buffered input, just with us writing to a fifo from userspace
rather than reading from it.

The DMA side of that can come later, in a similar fashion to how it is
added for the ADC side of things.  We can also have 'providers'
(equivalent of 'consumers' on the ADC side), perhaps giving a neat way
of describing DDS devices (I'm not so sure on this yet).

So to my mind, if you are not in buffered mode and do a sysfs write it
should be 'instant'. If in buffered mode, then it will wait on the
trigger.

So the complex side of things is what we 'know' about the data flow.
1) Case you have here.  We want to do direct write through to the device,
but have no way of knowing (or do we?) that it has triggered and written
the data to the output.  So we have no way of knowing we can push the next
value in from a fifo yet...  In this case I guess the solution might be to
have a fifo length of 0.  That is data flows straight to hardware.

2) Simple stream case - always enough data in the fifo and we get an interrupt
to signify that the previous trigger happened.

3) Case where we are only just keeping up.  So we won't have data in the fifo
until sometime after the previous trigger.  In this case we need the fifo to
push straight through if there isn't data ready to go.

4) Case where we are not pushing data fast enough.  Just don't update?

That last case 4 is nasty as the reason we typically want to do triggered
DAC updates is to ensure we always have valid states in some control loop,
but we might get a race here where one DAC has a value ready to go on a trigger
and another one isn't quite ready.  In this case we might want to hold off
until all are ready... So there might need to be a sanity check that everyone
on a given trigger is ready to go - an extra callback.

So a bit fiddly and I'm not sure I like the representation of through flow as
a fifo of 0 length... (can't think of a neater way though atm)

Anyhow, time to sort output buffers out once and for all I think if we can
get a reasonable group of people together who have the time.

Sorry Fabrice that this has hit your driver!  Perhaps we can figure
enough out to be able to at least get the basics (i.e. patches 1,2) in as
asap.

Jonathan
> ---
> Changes in v2:
> - Fix issue with trigger, by using set_trigger callback
> - trigger can now be assigned, no matters powerdown state
> ---
>  drivers/iio/dac/Kconfig          |   3 +
>  drivers/iio/dac/stm32-dac-core.h |   8 +++
>  drivers/iio/dac/stm32-dac.c      | 127 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 137 insertions(+), 1 deletion(-)
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
> index daf0993..e51a468 100644
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
> @@ -33,9 +34,16 @@
>  
>  /* STM32_DAC_CR bit fields */
>  #define STM32_DAC_CR_EN1		BIT(0)
> +#define STM32H7_DAC_CR_TEN1		BIT(1)
> +#define STM32H7_DAC_CR_TSEL1_SHIFT	2
> +#define STM32H7_DAC_CR_TSEL1		GENMASK(5, 2)
>  #define STM32H7_DAC_CR_HFSEL		BIT(15)
>  #define STM32_DAC_CR_EN2		BIT(16)
>  
> +/* STM32_DAC_SWTRIGR bit fields */
> +#define STM32_DAC_SWTRIGR_SWTRIG1	BIT(0)
> +#define STM32_DAC_SWTRIGR_SWTRIG2	BIT(1)
> +
>  /**
>   * struct stm32_dac_common - stm32 DAC driver common data (for all instances)
>   * @regmap: DAC registers shared via regmap
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index c0d993a..a7a078e 100644
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
> @@ -32,15 +36,113 @@
>  #define STM32_DAC_CHANNEL_1		1
>  #define STM32_DAC_CHANNEL_2		2
>  #define STM32_DAC_IS_CHAN_1(ch)		((ch) & STM32_DAC_CHANNEL_1)
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
Can we get here otherwise?
If not I'd prefer to either see an error on the other case
(perhaps simply return IRQ_NONE) 
> +	if (dac->swtrig) {
> +		u32 swtrig;
> +
> +		if (STM32_DAC_IS_CHAN_1(channel))
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
> +static int stm32_dac_set_trigger(struct iio_dev *indio_dev,
> +				 struct iio_trigger *trig)
> +{
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +	int channel = indio_dev->channels[0].channel;
> +	u32 shift = STM32_DAC_IS_CHAN_1(channel) ? 0 : STM32_DAC_CHAN2_SHIFT;
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
>  static int stm32_dac_is_enabled(struct iio_dev *indio_dev, int channel)
>  {
>  	struct stm32_dac *dac = iio_priv(indio_dev);
> @@ -167,6 +269,7 @@ static int stm32_dac_debugfs_reg_access(struct iio_dev *indio_dev,
>  static const struct iio_info stm32_dac_iio_info = {
>  	.read_raw = stm32_dac_read_raw,
>  	.write_raw = stm32_dac_write_raw,
> +	.set_trigger = stm32_dac_set_trigger,
>  	.debugfs_reg_access = stm32_dac_debugfs_reg_access,
>  	.driver_module = THIS_MODULE,
>  };
> @@ -326,7 +429,28 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	return devm_iio_device_register(&pdev->dev, indio_dev);
> +	ret = iio_triggered_event_setup(indio_dev, NULL,
> +					stm32_dac_trigger_handler);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		iio_triggered_event_cleanup(indio_dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_dac_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	iio_triggered_event_cleanup(indio_dev);
> +	iio_device_unregister(indio_dev);
> +
> +	return 0;
>  }
>  
>  static const struct of_device_id stm32_dac_of_match[] = {
> @@ -337,6 +461,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  
>  static struct platform_driver stm32_dac_driver = {
>  	.probe = stm32_dac_probe,
> +	.remove = stm32_dac_remove,
>  	.driver = {
>  		.name = "stm32-dac",
>  		.of_match_table = stm32_dac_of_match,
> 

