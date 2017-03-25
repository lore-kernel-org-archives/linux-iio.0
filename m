Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43019 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdCYPy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 11:54:28 -0400
Subject: Re: [PATCH v3 05/11] IIO: ADC: add stm32 DFSDM support for Sigma
 delta ADC
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-6-git-send-email-arnaud.pouliquen@st.com>
 <9555c62a-694d-7427-a221-9736667073fc@kernel.org>
 <df0de3f2-1aba-d9d9-4893-255d0c9480e1@st.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4f7d05a2-3d02-5f9d-ba20-60b0b7add128@kernel.org>
Date: Sat, 25 Mar 2017 15:53:54 +0000
MIME-Version: 1.0
In-Reply-To: <df0de3f2-1aba-d9d9-4893-255d0c9480e1@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/17 11:24, Arnaud Pouliquen wrote:
> Hello Jonathan
> 
> Thanks for your comments
> Few answers in-line.
> 
> Regards
> Arnaud
> 
> On 03/19/2017 11:25 PM, Jonathan Cameron wrote:
>> On 17/03/17 14:08, Arnaud Pouliquen wrote:
>>> Add driver for stm32 DFSDM IP. This IP converts a sigma delta stream
>>> in n bit samples through a low pass filter and an integrator.
>>> stm32-dfsdm-adc driver allows to handle sigma delta ADC.
>>>
>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> Various minor bits inline.
>>
>> I'm mostly liking this.  I do slightly wondering if semantically it
>> should be the front end that has the channels rather than the
>> backend.  Would be fiddly to do though and probably not worth the
>> hassle.
> DFSDM support the scan mode, so several front ends can be connected to
> One filter. In this case not possible to expose channel FE.
It still could but would admittedly get really fiddly and require demuxing
the scan...
> 
>>
>> Would love to see it running in a continuous mode in IIO, but
>> I guess that can follow along later.
> Yes for the rest of the management it should be quite close to the
> stm32-adc driver.
> 
>>
>> The comment about the trigger has me confused
>> - perhaps you could elaborate further on that?
> Code associated to the trigger should be part of the [PATCH v3 06/11]
> IIO: ADC: add stm32 DFSDM support for PDM microphone, as it concern the
> audio part...
> I did not found a way to use consumer.h interface to enable DFSDM IIO,
> without defining triggered buffer. that's why i defined a trigger and
> use it.
> But i just saw that my reasoning is wrong. I'm linked to trigger in
> stm32-dfsdm-audio.c because i use iio_triggered_buffer_postenable and
> iio_triggered_buffer_predisable.
This used to be more obvious until we put those boiler plate functions in
to avoid lots of replication.  Pretty much everything should be optional.
> As i don't use the callback for buffer
> no need to call it...i can call the ASoC callback directly in DMA IRQ.
> Still a hack but more logic...
Cool.  We definitely need to clean this up long term, but perhaps not
as part of this initially at least!

I hate holding drivers up for internal stuff that we can change in
our own good time!
> 
>>
>> Jonathan
>>> ---
>>> V2 -> V3 :
>>> 	- Split audio and ADC support in 2 drivers
>>> 	- Implement DMA cyclic mode
>>> 	- Add SPI bus Trigger for buffer management
>>>
>>>  drivers/iio/adc/Kconfig            |  26 ++
>>>  drivers/iio/adc/Makefile           |   2 +
>>>  drivers/iio/adc/stm32-dfsdm-adc.c  | 419 +++++++++++++++++++++++
>>>  drivers/iio/adc/stm32-dfsdm-core.c | 658 +++++++++++++++++++++++++++++++++++++
>>>  drivers/iio/adc/stm32-dfsdm.h      | 372 +++++++++++++++++++++
>>>  5 files changed, 1477 insertions(+)
>>>  create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c
>>>  create mode 100644 drivers/iio/adc/stm32-dfsdm-core.c
>>>  create mode 100644 drivers/iio/adc/stm32-dfsdm.h
>>>
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index d411d66..3e0eb11 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -452,6 +452,32 @@ config STM32_ADC
>>>  	  This driver can also be built as a module.  If so, the module
>>>  	  will be called stm32-adc.
>>>  
>>> +config STM32_DFSDM_CORE
>>> +	tristate "STMicroelectronics STM32 dfsdm core"
>>> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>>> +	select REGMAP
>>> +	select REGMAP_MMIO
>>> +	help
>>> +	  Select this option to enable the  driver for STMicroelectronics
>>> +	  STM32 digital filter for sigma delta converter.
>>> +
>>> +	  This driver can also be built as a module.  If so, the module
>>> +	  will be called stm32-dfsdm-core.
>>> +
>>> +config STM32_DFSDM_ADC
>>> +	tristate "STMicroelectronics STM32 dfsdm adc"
>>> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>>> +	select STM32_DFSDM_CORE
>>> +	select REGMAP_MMIO
>>> +	select IIO_BUFFER_DMAENGINE
>>> +	select IIO_HW_CONSUMER
>>> +	help
>>> +	  Select this option to support ADCSigma delta modulator for
>>> +	  STMicroelectronics STM32 digital filter for sigma delta converter.
>>> +
>>> +	  This driver can also be built as a module.  If so, the module
>>> +	  will be called stm32-dfsdm-adc.
>>> +
>>>  config STX104
>>>  	tristate "Apex Embedded Systems STX104 driver"
>>>  	depends on X86 && ISA_BUS_API
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index c68819c..161f271 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -43,6 +43,8 @@ obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>>>  obj-$(CONFIG_STX104) += stx104.o
>>>  obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>>>  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
>>> +obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
>>> +obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
>>>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>>>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>>>  obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
>>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
>>> new file mode 100644
>>> index 0000000..ebcb3b4
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>>> @@ -0,0 +1,419 @@
>>> +/*
>>> + * This file is the ADC part of of the STM32 DFSDM driver
>>> + *
>>> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>>> + * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
>>> + *
>>> + * License type: GPLv2
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms of the GNU General Public License version 2 as published by
>>> + * the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
>>> + * or FITNESS FOR A PARTICULAR PURPOSE.
>>> + * See the GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License along with
>>> + * this program. If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include <linux/iio/hw_consumer.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +
>>> +#include "stm32-dfsdm.h"
>>> +
>>> +#define DFSDM_TIMEOUT_US 100000
>>> +#define DFSDM_TIMEOUT (msecs_to_jiffies(DFSDM_TIMEOUT_US / 1000))
>>> +
>>> +struct stm32_dfsdm_adc {
>>> +	struct stm32_dfsdm *dfsdm;
>>> +	unsigned int fl_id;
>>> +	unsigned int ch_id;
>>> +
>>> +	unsigned int oversamp;
>>> +
>>> +	struct completion completion;
>>> +
>>> +	u32 *buffer;
>>> +
>>> +	/* Hardware consumer structure for Front End IIO */
>>> +	struct iio_hw_consumer *hwc;
>>> +};
>>> +
>>> +static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = stm32_dfsdm_start_dfsdm(adc->dfsdm);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	ret = stm32_dfsdm_start_channel(adc->dfsdm, adc->ch_id);
>>> +	if (ret < 0)
>>> +		goto stop_dfsdm;
>>> +
>>> +	ret = stm32_dfsdm_filter_configure(adc->dfsdm, adc->fl_id, adc->ch_id);
>>> +	if (ret < 0)
>>> +		goto stop_channels;
>>> +
>>> +	ret = stm32_dfsdm_start_filter(adc->dfsdm, adc->fl_id);
>>> +	if (ret < 0)
>>> +		goto stop_channels;
>>> +
>>> +	return 0;
>>> +
>>> +stop_channels:
>>> +	stm32_dfsdm_stop_channel(adc->dfsdm, adc->ch_id);
>>> +stop_dfsdm:
>>> +	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc)
>>> +{
>>> +	stm32_dfsdm_stop_filter(adc->dfsdm, adc->fl_id);
>>> +
>>> +	stm32_dfsdm_stop_channel(adc->dfsdm, adc->ch_id);
>>> +
>>> +	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
>>> +}
>>> +
>>> +static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
>>> +				   const struct iio_chan_spec *chan, int *res)
>>> +{
>>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>> +	long timeout;
>>> +	int ret;
>>> +
>>> +	reinit_completion(&adc->completion);
>>> +
>>> +	adc->buffer = res;
>>> +
>>> +	/* Unmask IRQ for regular conversion achievement*/
>>> +	ret = regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
>>> +				 DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(1));
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	ret = stm32_dfsdm_start_conv(adc);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	timeout = wait_for_completion_interruptible_timeout(&adc->completion,
>>> +							    DFSDM_TIMEOUT);
>> blank line perhaps.
>>> +	/* Mask IRQ for regular conversion achievement*/
>>> +	regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
>>> +			   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
>>> +
>>> +	if (timeout == 0) {
>>> +		dev_warn(&indio_dev->dev, "Conversion timed out!\n");
>>> +		ret = -ETIMEDOUT;
>>> +	} else if (timeout < 0) {
>>> +		ret = timeout;
>>> +	} else {
>>> +		dev_dbg(&indio_dev->dev, "Converted val %#x\n", *res);
>>> +		ret = IIO_VAL_INT;
>>> +	}
>>> +
>>> +	/* Mask IRQ for regular conversion achievement*/
>>> +	regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
>>> +			   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
>>> +
>>> +	stm32_dfsdm_stop_conv(adc);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
>>> +				 struct iio_chan_spec const *chan,
>>> +				 int val, int val2, long mask)
>>> +{
>>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>> +	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
>>> +	int ret = -EINVAL;
>>> +
>>> +	if (mask == IIO_CHAN_INFO_OVERSAMPLING_RATIO) {
>>> +		ret = stm32_dfsdm_set_osrs(fl, 0, val);
>>> +		if (!ret)
>>> +			adc->oversamp = val;
>>> +	}
>> blank line here.
>>> +	return ret;
>>> +}
>>> +
>>> +static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>>> +				struct iio_chan_spec const *chan, int *val,
>>> +				int *val2, long mask)
>>> +{
>>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>> +	int ret;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_RAW:
>>> +		ret = iio_hw_consumer_enable(adc->hwc);
>>> +		if (ret < 0) {
>>> +			dev_err(&indio_dev->dev,
>>> +				"%s: IIO enable failed (channel %d)\n",
>>> +				__func__, chan->channel);
>>> +			return ret;
>>> +		}
>>> +		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
>>> +		if (ret < 0) {
>>> +			dev_err(&indio_dev->dev,
>>> +				"%s: Conversion failed (channel %d)\n",
>>> +				__func__, chan->channel);
>>> +			return ret;
>>> +		}
>>> +
>>> +		iio_hw_consumer_disable(adc->hwc);
>>> +
>>> +		return IIO_VAL_INT;
>>> +
>>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>>> +		*val = adc->oversamp;
>>> +
>>> +		return IIO_VAL_INT;
>>> +	}
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static const struct iio_info stm32_dfsdm_info_adc = {
>>> +	.read_raw = stm32_dfsdm_read_raw,
>>> +	.write_raw = stm32_dfsdm_write_raw,
>>> +	.driver_module = THIS_MODULE,
>>> +};
>>> +
>>> +static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
>>> +{
>>> +	struct stm32_dfsdm_adc *adc = arg;
>>> +	struct regmap *regmap = adc->dfsdm->regmap;
>>> +	unsigned int status;
>>> +
>>> +	regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
>>> +
>>> +	if (status & DFSDM_ISR_REOCF_MASK) {
>>> +		/* read the data register clean the IRQ status */
>>> +		regmap_read(regmap, DFSDM_RDATAR(adc->fl_id), adc->buffer);
>>> +		complete(&adc->completion);
>>> +	}
>>> +	if (status & DFSDM_ISR_ROVRF_MASK) {
>> What's this one?  Might want a comment given it's an irq you basically eat.
> Yes  at least an error message that to inform on an overrun.
>>> +		regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),
>>> +				   DFSDM_ICR_CLRROVRF_MASK,
>>> +				   DFSDM_ICR_CLRROVRF_MASK);
>>> +	}
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>>> +{
>>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>> +
>>> +	return stm32_dfsdm_start_conv(adc);
>>> +}
>>> +
>>> +static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
>>> +{
>>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>> +
>>> +	stm32_dfsdm_stop_conv(adc);
>> blank line.
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct iio_buffer_setup_ops stm32_dfsdm_buffer_setup_ops = {
>>> +	.postenable = &stm32_dfsdm_postenable,
>>> +	.predisable = &stm32_dfsdm_predisable,
>>> +};
>>> +
>>> +static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
>>> +					 struct iio_chan_spec *chan,
>>> +					 int ch_idx)
>>> +{
>>> +	struct iio_chan_spec *ch = &chan[ch_idx];
>>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>> +	int ret;
>>> +
>>> +	ret = stm32_dfsdm_channel_parse_of(adc->dfsdm, indio_dev, chan, ch_idx);
>>> +
>>> +	ch->type = IIO_VOLTAGE;
>>> +	ch->indexed = 1;
>>> +	ch->scan_index = ch_idx;
>>> +
>>> +	/*
>>> +	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
>>> +	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
>>> +	 */
>>> +	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +				 BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
>>> +
>>> +	ch->scan_type.sign = 'u';
>>> +	ch->scan_type.realbits = 24;
>>> +	ch->scan_type.storagebits = 32;
>>> +	adc->ch_id = ch->channel;
>>> +
>>> +	return stm32_dfsdm_chan_configure(adc->dfsdm,
>>> +					  &adc->dfsdm->ch_list[ch->channel]);
>>> +}
>>> +
>>> +static int stm32_dfsdm_adc_chan_init(struct iio_dev *indio_dev)
>>> +{
>>> +	struct iio_chan_spec *channels;
>>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>> +	unsigned int num_ch;
>>> +	int ret, chan_idx;
>>> +
>>> +	num_ch = of_property_count_u32_elems(indio_dev->dev.of_node,
>>> +					     "st,adc-channels");
>>> +	if (num_ch < 0 || num_ch >= adc->dfsdm->num_chs) {
>>> +		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
>>> +		return num_ch < 0 ? num_ch : -EINVAL;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Number of channel per filter is temporary limited to 1.
>>> +	 * Restriction should be cleaned with scan mode
>>> +	 */
>>> +	if (num_ch > 1) {
>>> +		dev_err(&indio_dev->dev, "Multi channel not yet supported\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	/* Bind to SD modulator IIO device */
>>> +	adc->hwc = iio_hw_consumer_alloc(&indio_dev->dev);
>>> +	if (IS_ERR(adc->hwc))
>>> +		return -EPROBE_DEFER;
>>> +
>>> +	channels = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*channels),
>>> +				GFP_KERNEL);
>>> +	if (!channels)
>>> +		return -ENOMEM;
>>> +
>>> +	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
>>> +		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, channels,
>>> +						    chan_idx);
>>> +		if (ret < 0)
>>> +			goto free_hwc;
>>> +	}
>>> +
>>> +	indio_dev->num_channels = num_ch;
>>> +	indio_dev->channels = channels;
>>> +
>>> +	return 0;
>>> +
>>> +free_hwc:
>>> +	iio_hw_consumer_free(adc->hwc);
>> Given you have to free this in the error path, I would imagine you will
>> need a free somewhere in the main remove path?  Or just create a devm
>> version of iio_hw_consumer_alloc.  It will be useful in the long run.
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct of_device_id stm32_dfsdm_adc_match[] = {
>>> +	{ .compatible = "st,stm32-dfsdm-adc"},
>>> +	{}
>>> +};
>>> +
>>> +static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct stm32_dfsdm_adc *adc;
>>> +	struct device_node *np = dev->of_node;
>>> +	struct iio_dev *iio;
>>> +	char *name;
>>> +	int ret, irq, val;
>>> +
>>> +	iio = devm_iio_device_alloc(dev, sizeof(*adc));
>>> +	if (IS_ERR(iio)) {
>>> +		dev_err(dev, "%s: Failed to allocate IIO\n", __func__);
>>> +		return PTR_ERR(iio);
>>> +	}
>>> +
>>> +	adc = iio_priv(iio);
>>> +	if (IS_ERR(adc)) {
>>> +		dev_err(dev, "%s: Failed to allocate ADC\n", __func__);
>>> +		return PTR_ERR(adc);
>>> +	}
>>> +	adc->dfsdm = dev_get_drvdata(dev->parent);
>>> +
>>> +	iio->dev.parent = dev;
>>> +	iio->dev.of_node = np;
>>> +	iio->info = &stm32_dfsdm_info_adc;
>>> +	iio->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>>> +
>>> +	platform_set_drvdata(pdev, adc);
>>> +
>>> +	ret = of_property_read_u32(dev->of_node, "reg", &adc->fl_id);
>>> +	if (ret != 0) {
>>> +		dev_err(dev, "Missing reg property\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	name = kzalloc(sizeof("dfsdm-adc0"), GFP_KERNEL);
>> not freed.  Maybe devm_kzalloc
>>> +	if (!name)
>>> +		return -ENOMEM;
>>> +	snprintf(name, sizeof("dfsdm-adc0"), "dfsdm-adc%d", adc->fl_id);
>>> +	iio->name = name;
>>> +
>>> +	/*
>>> +	 * In a first step IRQs generated for channels are not treated.
>>> +	 * So IRQ associated to filter instance 0 is dedicated to the Filter 0.
>>> +	 */
>>> +	irq = platform_get_irq(pdev, 0);
>>> +	ret = devm_request_irq(dev, irq, stm32_dfsdm_irq,
>>> +			       0, pdev->name, adc);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "Failed to request IRQ\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = of_property_read_u32(dev->of_node, "st,filter-order", &val);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "Failed to set filter order\n");
>>> +		return ret;
>>> +	}
>>> +	adc->dfsdm->fl_list[adc->fl_id].ford = val;
>>> +
>>> +	ret = of_property_read_u32(dev->of_node, "st,filter0-sync", &val);
>>> +	if (!ret)
>>> +		adc->dfsdm->fl_list[adc->fl_id].sync_mode = val;
>>> +
>>> +	ret = stm32_dfsdm_adc_chan_init(iio);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	init_completion(&adc->completion);
>>> +
>>> +	return iio_device_register(iio);
>>> +}
>>> +
>>> +static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
>>> +{
>>> +	struct stm32_dfsdm_adc *adc = platform_get_drvdata(pdev);
>>> +	struct iio_dev *iio = iio_priv_to_dev(adc);
>>> +
>>> +	iio_device_unregister(iio);
>> If all you have is this in remove, you can probably get away with
>> devm_iio_device_register and get rid of the remove entirely.
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver stm32_dfsdm_adc_driver = {
>>> +	.driver = {
>>> +		.name = "stm32-dfsdm-adc",
>>> +		.of_match_table = stm32_dfsdm_adc_match,
>>> +	},
>>> +	.probe = stm32_dfsdm_adc_probe,
>>> +	.remove = stm32_dfsdm_adc_remove,
>>> +};
>>> +module_platform_driver(stm32_dfsdm_adc_driver);
>>> +
>>> +MODULE_DESCRIPTION("STM32 sigma delta ADC");
>>> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
>>> new file mode 100644
>>> index 0000000..488e456
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
>>> @@ -0,0 +1,658 @@
>>> +/*
>>> + * This file is part the core part STM32 DFSDM driver
>>> + *
>>> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>>> + * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
>>> + *
>>> + * License terms: GPL V2.0.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms of the GNU General Public License version 2 as published by
>>> + * the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
>>> + * details.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include <linux/iio/trigger.h>
>>> +#include <linux/iio/sysfs.h>
>>> +
>>> +#include "stm32-dfsdm.h"
>>> +
>>> +struct stm32_dfsdm_dev_data {
>>> +	unsigned int num_filters;
>>> +	unsigned int num_channels;
>>> +	const struct regmap_config *regmap_cfg;
>>> +};
>>> +
>>> +#define STM32H7_DFSDM_NUM_FILTERS	4
>>> +#define STM32H7_DFSDM_NUM_CHANNELS	8
>>> +
>>> +#define DFSDM_MAX_INT_OVERSAMPLING 256
>>> +
>>> +#define DFSDM_MAX_FL_OVERSAMPLING 1024
>>> +
>>> +#define DFSDM_MAX_RES BIT(31)
>>> +#define DFSDM_DATA_RES BIT(23)
>>> +
>>> +static bool stm32_dfsdm_volatile_reg(struct device *dev, unsigned int reg)
>>> +{
>>> +	if (reg < DFSDM_FILTER_BASE_ADR)
>>> +		return false;
>>> +
>>> +	/*
>>> +	 * Mask is done on register to avoid to list registers of all them
>>> +	 * filter instances.
>>> +	 */
>>> +	switch (reg & DFSDM_FILTER_REG_MASK) {
>>> +	case DFSDM_CR1(0) & DFSDM_FILTER_REG_MASK:
>>> +	case DFSDM_ISR(0) & DFSDM_FILTER_REG_MASK:
>>> +	case DFSDM_JDATAR(0) & DFSDM_FILTER_REG_MASK:
>>> +	case DFSDM_RDATAR(0) & DFSDM_FILTER_REG_MASK:
>>> +		return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +static const struct regmap_config stm32h7_dfsdm_regmap_cfg = {
>>> +	.reg_bits = 32,
>>> +	.val_bits = 32,
>>> +	.reg_stride = sizeof(u32),
>>> +	.max_register = 0x2B8,
>>> +	.volatile_reg = stm32_dfsdm_volatile_reg,
>>> +	.fast_io = true,
>>> +};
>>> +
>>> +static const struct stm32_dfsdm_dev_data stm32h7_dfsdm_data = {
>>> +	.num_filters = STM32H7_DFSDM_NUM_FILTERS,
>>> +	.num_channels = STM32H7_DFSDM_NUM_CHANNELS,
>>> +	.regmap_cfg = &stm32h7_dfsdm_regmap_cfg,
>>> +};
>>> +
>>> +struct dfsdm_priv {
>>> +	struct platform_device *pdev; /* platform device*/
>>> +
>>> +	struct stm32_dfsdm dfsdm; /* common data exported for all instances */
>>> +
>>> +	unsigned int spi_clk_out_div; /* SPI clkout divider value */
>>> +	atomic_t n_active_ch;	/* number of current active channels */
>>> +
>>> +	/* Clock */
>>> +	struct clk *clk; /* DFSDM clock */
>>> +	struct clk *aclk; /* audio clock */
>>> +};
>>> +
>>> +/**
>>> + * stm32_dfsdm_set_osrs - compute filter parameters.
>> Naming would suggest it's more specific than this.
>> Setting over sampling ratios?
> Right, it is a computation not a set.
>>> + *
>>> + * Enable interface if n_active_ch is not null.
>>> + * @dfsdm: Handle used to retrieve dfsdm context.
>>> + * @fast: Fast mode enabled or disabled
>>> + * @oversamp: Expected oversampling between filtered sample and SD input stream
>>> + */
>>> +int stm32_dfsdm_set_osrs(struct stm32_dfsdm_filter *fl, unsigned int fast,
>>> +			 unsigned int oversamp)
>>> +{
>>> +	unsigned int i, d, fosr, iosr;
>>> +	u64 res;
>>> +	s64 delta;
>>> +	unsigned int m = 1;	/* multiplication factor */
>>> +	unsigned int p = fl->ford;	/* filter order (ford) */
>>> +
>>> +	pr_debug("%s: Requested oversampling: %d\n",  __func__, oversamp);
>>> +	/*
>>> +	 * This function tries to compute filter oversampling and integrator
>>> +	 * oversampling, base on oversampling ratio requested by user.
>>> +	 *
>>> +	 * Decimation d depends on the filter order and the oversampling ratios.
>>> +	 * ford: filter order
>>> +	 * fosr: filter over sampling ratio
>>> +	 * iosr: integrator over sampling ratio
>>> +	 */
>>> +	if (fl->ford == DFSDM_FASTSINC_ORDER) {
>>> +		m = 2;
>>> +		p = 2;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Looks for filter and integrator oversampling ratios which allows
>>> +	 * to reach 24 bits data output resolution.
>>> +	 * Leave at once if exact resolution if reached.
>>> +	 * Otherwise the higher resolution below 32 bits is kept.
>>> +	 */
>>> +	for (fosr = 1; fosr <= DFSDM_MAX_FL_OVERSAMPLING; fosr++) {
>>> +		for (iosr = 1; iosr <= DFSDM_MAX_INT_OVERSAMPLING; iosr++) {
>>> +			if (fast)
>>> +				d = fosr * iosr;
>>> +			else if (fl->ford == DFSDM_FASTSINC_ORDER)
>>> +				d = fosr * (iosr + 3) + 2;
>>> +			else
>>> +				d = fosr * (iosr - 1 + p) + p;
>>> +
>>> +			if (d > oversamp)
>>> +				break;
>>> +			else if (d != oversamp)
>>> +				continue;
>>> +			/*
>>> +			 * Check resolution (limited to signed 32 bits)
>>> +			 *   res <= 2^31
>>> +			 * Sincx filters:
>>> +			 *   res = m * fosr^p x iosr (with m=1, p=ford)
>>> +			 * FastSinc filter
>>> +			 *   res = m * fosr^p x iosr (with m=2, p=2)
>>> +			 */
>>> +			res = fosr;
>>> +			for (i = p - 1; i > 0; i--) {
>>> +				res = res * (u64)fosr;
>>> +				if (res > DFSDM_MAX_RES)
>>> +					break;
>>> +			}
>>> +			if (res > DFSDM_MAX_RES)
>>> +				continue;
>>> +			res = res * (u64)m * (u64)iosr;
>>> +			if (res > DFSDM_MAX_RES)
>>> +				continue;
>>> +
>>> +			delta = res - DFSDM_DATA_RES;
>>> +
>>> +			if (res >= fl->res) {
>>> +				fl->res = res;
>>> +				fl->fosr = fosr;
>>> +				fl->iosr = iosr;
>>> +				fl->fast = fast;
>>> +				pr_debug("%s: fosr = %d, iosr = %d\n",
>>> +					 __func__, fl->fosr, fl->iosr);
>>> +			}
>>> +
>>> +			if (!delta)
>>> +				return 0;
>>> +		}
>>> +	}
>>> +
>>> +	if (!fl->fosr)
>>> +		return -EINVAL;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * stm32_dfsdm_start_dfsdm - start global dfsdm IP interface.
>>> + *
>>> + * Enable interface if n_active_ch is not null.
>>> + * @dfsdm: Handle used to retrieve dfsdm context.
>>> + */
>>> +int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
>>> +{
>>> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
>>> +	struct device *dev = &priv->pdev->dev;
>>> +	unsigned int clk_div = priv->spi_clk_out_div;
>>> +	int ret;
>>> +
>>> +	if (atomic_inc_return(&priv->n_active_ch) == 1) {
>>> +		/* Enable clocks */
>>> +		ret = clk_prepare_enable(priv->clk);
>>> +		if (ret < 0) {
>>> +			dev_err(dev, "Failed to start clock\n");
>>> +			return ret;
>>> +		}
>>> +		if (priv->aclk) {
>>> +			ret = clk_prepare_enable(priv->aclk);
>>> +			if (ret < 0) {
>>> +				dev_err(dev, "Failed to start audio clock\n");
>>> +				goto disable_clk;
>>> +			}
>>> +		}
>>> +
>>> +		/* Output the SPI CLKOUT (if clk_div == 0 clock if OFF) */
>>> +		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
>>> +					 DFSDM_CHCFGR1_CKOUTDIV_MASK,
>>> +					 DFSDM_CHCFGR1_CKOUTDIV(clk_div));
>>> +		if (ret < 0)
>>> +			goto disable_aclk;
>>> +
>>> +		/* Global enable of DFSDM interface */
>>> +		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
>>> +					 DFSDM_CHCFGR1_DFSDMEN_MASK,
>>> +					 DFSDM_CHCFGR1_DFSDMEN(1));
>>> +		if (ret < 0)
>>> +			goto disable_aclk;
>>> +	}
>>> +
>>> +	dev_dbg(dev, "%s: n_active_ch %d\n", __func__,
>>> +		atomic_read(&priv->n_active_ch));
>>> +
>>> +	return 0;
>>> +
>>> +disable_aclk:
>>> +	clk_disable_unprepare(priv->aclk);
>>> +disable_clk:
>>> +	clk_disable_unprepare(priv->clk);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +/**
>>> + * stm32_dfsdm_stop_dfsdm - stop global DFSDM IP interface.
>>> + *
>>> + * Disable interface if n_active_ch is null
>>> + * @dfsdm: Handle used to retrieve dfsdm context.
>>> + */
>>> +int stm32_dfsdm_stop_dfsdm(struct stm32_dfsdm *dfsdm)
>>> +{
>>> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
>>> +	int ret;
>>> +
>>> +	if (atomic_dec_and_test(&priv->n_active_ch)) {
>>> +		/* Global disable of DFSDM interface */
>>> +		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
>>> +					 DFSDM_CHCFGR1_DFSDMEN_MASK,
>>> +					 DFSDM_CHCFGR1_DFSDMEN(0));
>>> +		if (ret < 0)
>>> +			return ret;
>>> +
>>> +		/* Stop SPI CLKOUT */
>>> +		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
>>> +					 DFSDM_CHCFGR1_CKOUTDIV_MASK,
>>> +					 DFSDM_CHCFGR1_CKOUTDIV(0));
>>> +		if (ret < 0)
>>> +			return ret;
>>> +
>>> +		/* Disable clocks */
>>> +		clk_disable_unprepare(priv->clk);
>>> +		if (priv->aclk)
>>> +			clk_disable_unprepare(priv->aclk);
>>> +	}
>>> +	dev_dbg(&priv->pdev->dev, "%s: n_active_ch %d\n", __func__,
>>> +		atomic_read(&priv->n_active_ch));
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * stm32_dfsdm_start_channel
>>> + *	Start DFSDM IP channels and associated interface.
>>> + *
>>> + * @dfsdm: Handle used to retrieve dfsdm context.
>>> + * @ch_id: Channel index.
>>> + */
>>> +int stm32_dfsdm_start_channel(struct stm32_dfsdm *dfsdm, unsigned int ch_id)
>>> +{
>>> +	return regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(ch_id),
>>> +				  DFSDM_CHCFGR1_CHEN_MASK,
>>> +				  DFSDM_CHCFGR1_CHEN(1));
>>> +}
>>> +
>>> +/**
>>> + * stm32_dfsdm_stop_channel
>>> + *	Stop DFSDM IP channels and associated interface.
>>> + *
>>> + * @dfsdm: Handle used to retrieve dfsdm context.
>>> + * @ch_id: Channel index.
>>> + */
>>> +void stm32_dfsdm_stop_channel(struct stm32_dfsdm *dfsdm, unsigned int ch_id)
>>> +{
>>> +	regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(ch_id),
>>> +			   DFSDM_CHCFGR1_CHEN_MASK,
>>> +			   DFSDM_CHCFGR1_CHEN(0));
>>> +}
>>> +
>>> +/**
>>> + * stm32_dfsdm_chan_configure
>>> + *	Configure DFSDM IP channels and associated interface.
>>> + *
>>> + * @dfsdm: Handle used to retrieve dfsdm context.
>>> + * @ch_id: channel index.
>>> + */
>>> +int stm32_dfsdm_chan_configure(struct stm32_dfsdm *dfsdm,
>>> +			       struct stm32_dfsdm_channel *ch)
>>> +{
>>> +	unsigned int id = ch->id;
>>> +	struct regmap *regmap = dfsdm->regmap;
>>> +	int ret;
>>> +
>>> +	ret = regmap_update_bits(regmap, DFSDM_CHCFGR1(id),
>>> +				 DFSDM_CHCFGR1_SITP_MASK,
>>> +				 DFSDM_CHCFGR1_SITP(ch->type));
>>> +	if (ret < 0)
>>> +		return ret;
>> Blank line here and in similar places makes it easier for my
>> eyes to parse at least...
>> I'd also like to see some docs in here, not all of these
>> are self explanatory.
> I will apply recommendation in my whole code for next time
>>> +	ret = regmap_update_bits(regmap, DFSDM_CHCFGR1(id),
>>> +				 DFSDM_CHCFGR1_SPICKSEL_MASK,
>>> +				 DFSDM_CHCFGR1_SPICKSEL(ch->src));
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	return regmap_update_bits(regmap, DFSDM_CHCFGR1(id),
>>> +				  DFSDM_CHCFGR1_CHINSEL_MASK,
>>> +				  DFSDM_CHCFGR1_CHINSEL(ch->alt_si));
>>> +}
>>> +
>>> +/**
>>> + * stm32_dfsdm_start_filter - Start DFSDM IP filter conversion.
>>> + *
>>> + * @dfsdm: Handle used to retrieve dfsdm context.
>>> + * @fl_id: Filter index.
>>> + */
>>> +int stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
>>> +{
>>> +	int ret;
>>> +
>>> +	/* Enable filter */
>>> +	ret = regmap_update_bits(dfsdm->regmap, DFSDM_CR1(fl_id),
>>> +				 DFSDM_CR1_DFEN_MASK, DFSDM_CR1_DFEN(1));
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	/* Start conversion */
>>> +	return regmap_update_bits(dfsdm->regmap, DFSDM_CR1(fl_id),
>>> +				  DFSDM_CR1_RSWSTART_MASK,
>>> +				  DFSDM_CR1_RSWSTART(1));
>>> +}
>>> +
>>> +/**
>>> + * stm32_dfsdm_stop_filter - Stop DFSDM IP filter conversion.
>>> + *
>>> + * @dfsdm: Handle used to retrieve dfsdm context.
>>> + * @fl_id: Filter index.
>>> + */
>>> +void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
>>> +{
>>> +	/* Mask IRQ for regular conversion achievement*/
>>> +	regmap_update_bits(dfsdm->regmap, DFSDM_CR2(fl_id),
>>> +			   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
>>> +	/* Disable conversion */
>>> +	regmap_update_bits(dfsdm->regmap, DFSDM_CR1(fl_id),
>>> +			   DFSDM_CR1_DFEN_MASK, DFSDM_CR1_DFEN(0));
>>> +}
>>> +
>>> +/**
>>> + * stm32_dfsdm_filter_configure - Configure DFSDM IP filter and associate it
>>> + *	to channel.
>>> + *
>>> + * @dfsdm: Handle used to retrieve dfsdm context.
>>> + * @fl_id: channel index.
>>> + * @fl_id: Filter index.
>>> + */
>>> +int stm32_dfsdm_filter_configure(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
>>> +				 unsigned int ch_id)
>>> +{
>>> +	struct regmap *regmap = dfsdm->regmap;
>>> +	struct stm32_dfsdm_filter *fl = &dfsdm->fl_list[fl_id];
>>> +	int ret;
>>> +
>>> +	/* Average integrator oversampling */
>>> +	ret = regmap_update_bits(regmap, DFSDM_FCR(fl_id), DFSDM_FCR_IOSR_MASK,
>>> +				 DFSDM_FCR_IOSR(fl->iosr));
>>> +
>>> +	/* Filter order and Oversampling */
>> Please handle each error properly as it happens rather than mudling onwards.
>> If there is reason for this odd construction, then document it clearly.
> If you mention the checks on ret value that are missing at end of
> functions, yes dirty code to fix.
> 
>>> +	if (!ret)
>>> +		ret = regmap_update_bits(regmap, DFSDM_FCR(fl_id),
>>> +					 DFSDM_FCR_FOSR_MASK,
>>> +					 DFSDM_FCR_FOSR(fl->fosr));
>>> +
>>> +	if (!ret)
>>> +		ret = regmap_update_bits(regmap, DFSDM_FCR(fl_id),
>>> +					 DFSDM_FCR_FORD_MASK,
>>> +					 DFSDM_FCR_FORD(fl->ford));
>>> +
>>> +	/* If only one channel no scan mode supported for the moment */
>>> +	ret = regmap_update_bits(regmap, DFSDM_CR1(fl_id),
>>> +				 DFSDM_CR1_RCH_MASK,
>>> +				 DFSDM_CR1_RCH(ch_id));
>>> +
>>> +	return regmap_update_bits(regmap, DFSDM_CR1(fl_id),
>>> +					 DFSDM_CR1_RSYNC_MASK,
>>> +			  DFSDM_CR1_RSYNC(fl->sync_mode));
>>> +}
>>> +
>>> +static const struct iio_trigger_ops dfsdm_trigger_ops = {
>>> +	.owner = THIS_MODULE,
>>> +};
>>> +
>>> +static int stm32_dfsdm_setup_spi_trigger(struct platform_device *pdev,
>>> +					 struct stm32_dfsdm *dfsdm)
>>> +{
>>> +	/*
>>> +	 * To be able to use buffer consumer interface a trigger is needed.
>>> +	 * As conversion are trigged by PDM samples from SPI bus, that makes
>>> +	 * sense to define the serial interface ( SPI or manchester) as
>>> +	 * trigger source.
>> It's not actually the case that you have to have a triggrer.
>> There are plenty of drivers (particularly ones with hardware buffering)
>> where there is no trigger envolved.  That's not to say it doesn't make sense
>> here.
>>
>> I'm not entirely sure yet if it's needed... Given it has no ops, I doubt it
>> somewhat...
>>> +	 */
>>> +
>>> +	struct iio_trigger *trig;
>>> +	int ret;
>>> +
>>> +	trig = devm_iio_trigger_alloc(&pdev->dev, DFSDM_SPI_TRIGGER_NAME);
>>> +	if (!trig)
>>> +		return -ENOMEM;
>>> +
>>> +	trig->dev.parent = pdev->dev.parent;
>>> +	trig->ops = &dfsdm_trigger_ops;
>>> +
>>> +	iio_trigger_set_drvdata(trig, dfsdm);
>>> +
>>> +	ret = devm_iio_trigger_register(&pdev->dev, trig);
>>> +	if (ret)
>>> +		return ret;
>> Just return ret in all cases.
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
>>> +				 struct iio_dev *indio_dev,
>>> +				 struct iio_chan_spec *chan, int chan_idx)
>>> +{
>>> +	struct iio_chan_spec *ch = &chan[chan_idx];
>>> +	struct stm32_dfsdm_channel *df_ch;
>>> +	const char *of_str;
>>> +	int ret, val;
>>> +
>>> +	ret = of_property_read_u32_index(indio_dev->dev.of_node,
>>> +					 "st,adc-channels", chan_idx,
>>> +					 &ch->channel);
>>> +	if (ret < 0) {
>>> +		dev_err(&indio_dev->dev,
>>> +			" Error parsing 'st,adc-channels' for idx %d\n",
>>> +			chan_idx);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = of_property_read_string_index(indio_dev->dev.of_node,
>>> +					    "st,adc-channel-names", chan_idx,
>>> +					    &ch->datasheet_name);
>>> +	if (ret < 0) {
>>> +		dev_err(&indio_dev->dev,
>>> +			" Error parsing 'st,adc-channel-names' for idx %d\n",
>>> +			chan_idx);
>>> +		return ret;
>>> +	}
>>> +
>>> +	df_ch =  &dfsdm->ch_list[ch->channel];
>> Extra space on the line above.
>>> +	df_ch->id = ch->channel;
>>> +	ret = of_property_read_string_index(indio_dev->dev.of_node,
>>> +					    "st,adc-channel-types", chan_idx,
>>> +					    &of_str);
>>> +	val  = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_type);
>>> +	if (ret < 0 || val < 0)
>>> +		df_ch->type = 0;
>>> +	else
>>> +		df_ch->type = val;
>>> +
>>> +	ret = of_property_read_string_index(indio_dev->dev.of_node,
>>> +					    "st,adc-channel-clk-src", chan_idx,
>>> +					    &of_str);
>>> +	val  = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_src);
>>> +	if (ret < 0 || val < 0)
>>> +		df_ch->src = 0;
>>> +	else
>>> +		df_ch->src = val;
>>> +
>>> +	ret = of_property_read_u32_index(indio_dev->dev.of_node,
>>> +					 "st,adc-alt-channel", chan_idx,
>>> +					 &df_ch->alt_si);
>>> +	if (ret < 0)
>>> +		df_ch->alt_si = 0;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>>> +				struct dfsdm_priv *priv)
>>> +{
>>> +	struct device_node *node = pdev->dev.of_node;
>>> +	struct resource *res;
>>> +	unsigned long clk_freq;
>>> +	unsigned int spi_freq, rem;
>>> +	int ret;
>>> +
>>> +	if (!node)
>>> +		return -EINVAL;
>>> +
>>> +	/* Get resources */
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (!res) {
>>> +		dev_err(&pdev->dev, "Failed to get memory resource\n");
>>> +		return -ENODEV;
>>> +	}
>>> +	priv->dfsdm.phys_base = res->start;
>>> +	priv->dfsdm.base = devm_ioremap_resource(&pdev->dev, res);
>>> +
>>> +	/* Source clock */
>>> +	priv->clk = devm_clk_get(&pdev->dev, "dfsdm");
>>> +	if (IS_ERR(priv->clk)) {
>>> +		dev_err(&pdev->dev, "No stm32_dfsdm_clk clock found\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	priv->aclk = devm_clk_get(&pdev->dev, "audio");
>>> +	if (IS_ERR(priv->aclk))
>>> +		priv->aclk = NULL;
>>> +
>>> +	if (priv->aclk)
>>> +		clk_freq = clk_get_rate(priv->aclk);
>>> +	else
>>> +		clk_freq = clk_get_rate(priv->clk);
>>> +
>>> +	/* SPI clock freq */
>>> +	ret = of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
>>> +				   &spi_freq);
>>> +	if (ret < 0) {
>>> +		dev_err(&pdev->dev, "Failed to get spi-max-frequency\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem) - 1;
>>> +	priv->dfsdm.spi_master_freq = spi_freq;
>>> +
>>> +	if (rem) {
>>> +		dev_warn(&pdev->dev, "SPI clock not accurate\n");
>>> +		dev_warn(&pdev->dev, "%ld = %d * %d + %d\n",
>>> +			 clk_freq, spi_freq, priv->spi_clk_out_div + 1, rem);
>>> +	}
>>> +
>>> +	return 0;
>>> +};
>>> +
>>> +static const struct of_device_id stm32_dfsdm_of_match[] = {
>>> +	{
>>> +		.compatible = "st,stm32h7-dfsdm",
>>> +		.data = &stm32h7_dfsdm_data,
>>> +	},
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
>>> +
>>> +static int stm32_dfsdm_remove(struct platform_device *pdev)
>>> +{
>>> +	of_platform_depopulate(&pdev->dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int stm32_dfsdm_probe(struct platform_device *pdev)
>>> +{
>>> +	struct dfsdm_priv *priv;
>>> +	struct device_node *pnode = pdev->dev.of_node;
>>> +	const struct of_device_id *of_id;
>>> +	const struct stm32_dfsdm_dev_data *dev_data;
>>> +	struct stm32_dfsdm *dfsdm;
>>> +	int ret, i;
>>> +
>>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->pdev = pdev;
>>> +
>>> +	/* Populate data structure depending on compatibility */
>>> +	of_id = of_match_node(stm32_dfsdm_of_match, pnode);
>>> +	if (!of_id->data) {
>>> +		dev_err(&pdev->dev, "Data associated to device is missing\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
>>> +	dfsdm = &priv->dfsdm;
>>> +	dfsdm->fl_list = devm_kcalloc(&pdev->dev, dev_data->num_filters,
>>> +				      sizeof(*dfsdm->fl_list), GFP_KERNEL);
>>> +	if (!dfsdm->fl_list)
>>> +		return -ENOMEM;
>>> +
>>> +	dfsdm->num_fls = dev_data->num_filters;
>>> +	dfsdm->ch_list = devm_kcalloc(&pdev->dev, dev_data->num_channels,
>>> +				      sizeof(*dfsdm->ch_list),
>>> +				      GFP_KERNEL);
>>> +	if (!dfsdm->ch_list)
>>> +		return -ENOMEM;
>>> +	dfsdm->num_chs = dev_data->num_channels;
>>> +
>>> +	ret = stm32_dfsdm_parse_of(pdev, priv);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	dfsdm->regmap = devm_regmap_init_mmio(&pdev->dev, dfsdm->base,
>>> +					    &stm32h7_dfsdm_regmap_cfg);
>>> +	if (IS_ERR(dfsdm->regmap)) {
>>> +		ret = PTR_ERR(dfsdm->regmap);
>>> +		dev_err(&pdev->dev, "%s: Failed to allocate regmap: %d\n",
>>> +			__func__, ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	for (i = 0; i < STM32H7_DFSDM_NUM_FILTERS; i++) {
>>> +		struct stm32_dfsdm_filter *fl = &dfsdm->fl_list[i];
>>> +
>>> +		fl->id = i;
>> I'd like a comment on why this is needed...
>  to  be cleaned.
>>> +	}
>>> +
>>> +	platform_set_drvdata(pdev, dfsdm);
>>> +
>>> +	ret = stm32_dfsdm_setup_spi_trigger(pdev, dfsdm);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	return of_platform_populate(pnode, NULL, NULL, &pdev->dev);
>>> +}
>>> +
>>> +static struct platform_driver stm32_dfsdm_driver = {
>>> +	.probe = stm32_dfsdm_probe,
>>> +	.remove = stm32_dfsdm_remove,
>>> +	.driver = {
>>> +		.name = "stm32-dfsdm",
>>> +		.of_match_table = stm32_dfsdm_of_match,
>>> +	},
>>> +};
>>> +
>>> +module_platform_driver(stm32_dfsdm_driver);
>>> +
>>> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
>>> +MODULE_DESCRIPTION("STMicroelectronics STM32 dfsdm driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/iio/adc/stm32-dfsdm.h b/drivers/iio/adc/stm32-dfsdm.h
>>> new file mode 100644
>>> index 0000000..bb7d74f
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/stm32-dfsdm.h
>>> @@ -0,0 +1,371 @@
>>> +/*
>>> + * This file is part of STM32 DFSDM driver
>>> + *
>>> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>>> + * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com>.
>>> + *
>>> + * License terms: GPL V2.0.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms of the GNU General Public License version 2 as published by
>>> + * the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
>>> + * details.
>>> + */
>>> +#ifndef MDF_STM32_DFSDM__H
>>> +#define MDF_STM32_DFSDM__H
>>> +
>>> +#include <linux/bitfield.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +/*
>>> + * STM32 DFSDM - global register map
>>> + * ________________________________________________________
>>> + * | Offset |                 Registers block             |
>>> + * --------------------------------------------------------
>>> + * | 0x000  |      CHANNEL 0 + COMMON CHANNEL FIELDS      |
>>> + * --------------------------------------------------------
>>> + * | 0x020  |                CHANNEL 1                    |
>>> + * --------------------------------------------------------
>>> + * | ...    |                .....                        |
>>> + * --------------------------------------------------------
>>> + * | 0x0E0  |                CHANNEL 7                    |
>>> + * --------------------------------------------------------
>>> + * | 0x100  |      FILTER  0 + COMMON  FILTER FIELDs      |
>>> + * --------------------------------------------------------
>>> + * | 0x200  |                FILTER  1                    |
>>> + * --------------------------------------------------------
>>> + * | 0x300  |                FILTER  2                    |
>>> + * --------------------------------------------------------
>>> + * | 0x400  |                FILTER  3                    |
>>> + * --------------------------------------------------------
>>> + */
>>> +
>>> +/*
>>> + * Channels register definitions
>>> + */
>>> +#define DFSDM_CHCFGR1(y)  ((y) * 0x20 + 0x00)
>>> +#define DFSDM_CHCFGR2(y)  ((y) * 0x20 + 0x04)
>>> +#define DFSDM_AWSCDR(y)   ((y) * 0x20 + 0x08)
>>> +#define DFSDM_CHWDATR(y)  ((y) * 0x20 + 0x0C)
>>> +#define DFSDM_CHDATINR(y) ((y) * 0x20 + 0x10)
>>> +
>>> +/* CHCFGR1: Channel configuration register 1 */
>>> +#define DFSDM_CHCFGR1_SITP_MASK     GENMASK(1, 0)
>>> +#define DFSDM_CHCFGR1_SITP(v)       FIELD_PREP(DFSDM_CHCFGR1_SITP_MASK, v)
>>> +#define DFSDM_CHCFGR1_SPICKSEL_MASK GENMASK(3, 2)
>>> +#define DFSDM_CHCFGR1_SPICKSEL(v)   FIELD_PREP(DFSDM_CHCFGR1_SPICKSEL_MASK, v)
>>> +#define DFSDM_CHCFGR1_SCDEN_MASK    BIT(5)
>>> +#define DFSDM_CHCFGR1_SCDEN(v)      FIELD_PREP(DFSDM_CHCFGR1_SCDEN_MASK, v)
>>> +#define DFSDM_CHCFGR1_CKABEN_MASK   BIT(6)
>>> +#define DFSDM_CHCFGR1_CKABEN(v)     FIELD_PREP(DFSDM_CHCFGR1_CKABEN_MASK, v)
>>> +#define DFSDM_CHCFGR1_CHEN_MASK     BIT(7)
>>> +#define DFSDM_CHCFGR1_CHEN(v)       FIELD_PREP(DFSDM_CHCFGR1_CHEN_MASK, v)
>>> +#define DFSDM_CHCFGR1_CHINSEL_MASK  BIT(8)
>>> +#define DFSDM_CHCFGR1_CHINSEL(v)    FIELD_PREP(DFSDM_CHCFGR1_CHINSEL_MASK, v)
>>> +#define DFSDM_CHCFGR1_DATMPX_MASK   GENMASK(13, 12)
>>> +#define DFSDM_CHCFGR1_DATMPX(v)     FIELD_PREP(DFSDM_CHCFGR1_DATMPX_MASK, v)
>>> +#define DFSDM_CHCFGR1_DATPACK_MASK  GENMASK(15, 14)
>>> +#define DFSDM_CHCFGR1_DATPACK(v)    FIELD_PREP(DFSDM_CHCFGR1_DATPACK_MASK, v)
>>> +#define DFSDM_CHCFGR1_CKOUTDIV_MASK GENMASK(23, 16)
>>> +#define DFSDM_CHCFGR1_CKOUTDIV(v)   FIELD_PREP(DFSDM_CHCFGR1_CKOUTDIV_MASK, v)
>>> +#define DFSDM_CHCFGR1_CKOUTSRC_MASK BIT(30)
>>> +#define DFSDM_CHCFGR1_CKOUTSRC(v)   FIELD_PREP(DFSDM_CHCFGR1_CKOUTSRC_MASK, v)
>>> +#define DFSDM_CHCFGR1_DFSDMEN_MASK  BIT(31)
>>> +#define DFSDM_CHCFGR1_DFSDMEN(v)    FIELD_PREP(DFSDM_CHCFGR1_DFSDMEN_MASK, v)
>>> +
>>> +/* CHCFGR2: Channel configuration register 2 */
>>> +#define DFSDM_CHCFGR2_DTRBS_MASK    GENMASK(7, 3)
>>> +#define DFSDM_CHCFGR2_DTRBS(v)      FIELD_PREP(DFSDM_CHCFGR2_DTRBS_MASK, v)
>>> +#define DFSDM_CHCFGR2_OFFSET_MASK   GENMASK(31, 8)
>>> +#define DFSDM_CHCFGR2_OFFSET(v)     FIELD_PREP(DFSDM_CHCFGR2_OFFSET_MASK, v)
>>> +
>>> +/* AWSCDR: Channel analog watchdog and short circuit detector */
>>> +#define DFSDM_AWSCDR_SCDT_MASK    GENMASK(7, 0)
>>> +#define DFSDM_AWSCDR_SCDT(v)      FIELD_PREP(DFSDM_AWSCDR_SCDT_MASK, v)
>>> +#define DFSDM_AWSCDR_BKSCD_MASK   GENMASK(15, 12)
>>> +#define DFSDM_AWSCDR_BKSCD(v)	  FIELD_PREP(DFSDM_AWSCDR_BKSCD_MASK, v)
>>> +#define DFSDM_AWSCDR_AWFOSR_MASK  GENMASK(20, 16)
>>> +#define DFSDM_AWSCDR_AWFOSR(v)    FIELD_PREP(DFSDM_AWSCDR_AWFOSR_MASK, v)
>>> +#define DFSDM_AWSCDR_AWFORD_MASK  GENMASK(23, 22)
>>> +#define DFSDM_AWSCDR_AWFORD(v)    FIELD_PREP(DFSDM_AWSCDR_AWFORD_MASK, v)
>>> +
>>> +/*
>>> + * Filters register definitions
>>> + */
>>> +#define DFSDM_FILTER_BASE_ADR		0x100
>>> +#define DFSDM_FILTER_REG_MASK		0x7F
>>> +#define DFSDM_FILTER_X_BASE_ADR(x)	((x) * 0x80 + DFSDM_FILTER_BASE_ADR)
>>> +
>>> +#define DFSDM_CR1(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x00)
>>> +#define DFSDM_CR2(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x04)
>>> +#define DFSDM_ISR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x08)
>>> +#define DFSDM_ICR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x0C)
>>> +#define DFSDM_JCHGR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x10)
>>> +#define DFSDM_FCR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x14)
>>> +#define DFSDM_JDATAR(x)  (DFSDM_FILTER_X_BASE_ADR(x)  + 0x18)
>>> +#define DFSDM_RDATAR(x)  (DFSDM_FILTER_X_BASE_ADR(x)  + 0x1C)
>>> +#define DFSDM_AWHTR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x20)
>>> +#define DFSDM_AWLTR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x24)
>>> +#define DFSDM_AWSR(x)    (DFSDM_FILTER_X_BASE_ADR(x)  + 0x28)
>>> +#define DFSDM_AWCFR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x2C)
>>> +#define DFSDM_EXMAX(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x30)
>>> +#define DFSDM_EXMIN(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x34)
>>> +#define DFSDM_CNVTIMR(x) (DFSDM_FILTER_X_BASE_ADR(x)  + 0x38)
>>> +
>>> +/* CR1 Control register 1 */
>>> +#define DFSDM_CR1_DFEN_MASK	BIT(0)
>>> +#define DFSDM_CR1_DFEN(v)	FIELD_PREP(DFSDM_CR1_DFEN_MASK, v)
>>> +#define DFSDM_CR1_JSWSTART_MASK	BIT(1)
>>> +#define DFSDM_CR1_JSWSTART(v)	FIELD_PREP(DFSDM_CR1_JSWSTART_MASK, v)
>>> +#define DFSDM_CR1_JSYNC_MASK	BIT(3)
>>> +#define DFSDM_CR1_JSYNC(v)	FIELD_PREP(DFSDM_CR1_JSYNC_MASK, v)
>>> +#define DFSDM_CR1_JSCAN_MASK	BIT(4)
>>> +#define DFSDM_CR1_JSCAN(v)	FIELD_PREP(DFSDM_CR1_JSCAN_MASK, v)
>>> +#define DFSDM_CR1_JDMAEN_MASK	BIT(5)
>>> +#define DFSDM_CR1_JDMAEN(v)	FIELD_PREP(DFSDM_CR1_JDMAEN_MASK, v)
>>> +#define DFSDM_CR1_JEXTSEL_MASK	GENMASK(12, 8)
>>> +#define DFSDM_CR1_JEXTSEL(v)	FIELD_PREP(DFSDM_CR1_JEXTSEL_MASK, v)
>>> +#define DFSDM_CR1_JEXTEN_MASK	GENMASK(14, 13)
>>> +#define DFSDM_CR1_JEXTEN(v)	FIELD_PREP(DFSDM_CR1_JEXTEN_MASK, v)
>>> +#define DFSDM_CR1_RSWSTART_MASK	BIT(17)
>>> +#define DFSDM_CR1_RSWSTART(v)	FIELD_PREP(DFSDM_CR1_RSWSTART_MASK, v)
>>> +#define DFSDM_CR1_RCONT_MASK	BIT(18)
>>> +#define DFSDM_CR1_RCONT(v)	FIELD_PREP(DFSDM_CR1_RCONT_MASK, v)
>>> +#define DFSDM_CR1_RSYNC_MASK	BIT(19)
>>> +#define DFSDM_CR1_RSYNC(v)	FIELD_PREP(DFSDM_CR1_RSYNC_MASK, v)
>>> +#define DFSDM_CR1_RDMAEN_MASK	BIT(21)
>>> +#define DFSDM_CR1_RDMAEN(v)	FIELD_PREP(DFSDM_CR1_RDMAEN_MASK, v)
>>> +#define DFSDM_CR1_RCH_MASK	GENMASK(26, 24)
>>> +#define DFSDM_CR1_RCH(v)	FIELD_PREP(DFSDM_CR1_RCH_MASK, v)
>>> +#define DFSDM_CR1_FAST_MASK	BIT(29)
>>> +#define DFSDM_CR1_FAST(v)	FIELD_PREP(DFSDM_CR1_FAST_MASK, v)
>>> +#define DFSDM_CR1_AWFSEL_MASK	BIT(30)
>>> +#define DFSDM_CR1_AWFSEL(v)	FIELD_PREP(DFSDM_CR1_AWFSEL_MASK, v)
>>> +
>>> +/* CR2: Control register 2 */
>>> +#define DFSDM_CR2_IE_MASK	GENMASK(6, 0)
>>> +#define DFSDM_CR2_IE(v)		FIELD_PREP(DFSDM_CR2_IE_MASK, v)
>>> +#define DFSDM_CR2_JEOCIE_MASK	BIT(0)
>>> +#define DFSDM_CR2_JEOCIE(v)	FIELD_PREP(DFSDM_CR2_JEOCIE_MASK, v)
>>> +#define DFSDM_CR2_REOCIE_MASK	BIT(1)
>>> +#define DFSDM_CR2_REOCIE(v)	FIELD_PREP(DFSDM_CR2_REOCIE_MASK, v)
>>> +#define DFSDM_CR2_JOVRIE_MASK	BIT(2)
>>> +#define DFSDM_CR2_JOVRIE(v)	FIELD_PREP(DFSDM_CR2_JOVRIE_MASK, v)
>>> +#define DFSDM_CR2_ROVRIE_MASK	BIT(3)
>>> +#define DFSDM_CR2_ROVRIE(v)	FIELD_PREP(DFSDM_CR2_ROVRIE_MASK, v)
>>> +#define DFSDM_CR2_AWDIE_MASK	BIT(4)
>>> +#define DFSDM_CR2_AWDIE(v)	FIELD_PREP(DFSDM_CR2_AWDIE_MASK, v)
>>> +#define DFSDM_CR2_SCDIE_MASK	BIT(5)
>>> +#define DFSDM_CR2_SCDIE(v)	FIELD_PREP(DFSDM_CR2_SCDIE_MASK, v)
>>> +#define DFSDM_CR2_CKABIE_MASK	BIT(6)
>>> +#define DFSDM_CR2_CKABIE(v)	FIELD_PREP(DFSDM_CR2_CKABIE_MASK, v)
>>> +#define DFSDM_CR2_EXCH_MASK	GENMASK(15, 8)
>>> +#define DFSDM_CR2_EXCH(v)	FIELD_PREP(DFSDM_CR2_EXCH_MASK, v)
>>> +#define DFSDM_CR2_AWDCH_MASK	GENMASK(23, 16)
>>> +#define DFSDM_CR2_AWDCH(v)	FIELD_PREP(DFSDM_CR2_AWDCH_MASK, v)
>>> +
>>> +/* ISR: Interrupt status register */
>>> +#define DFSDM_ISR_JEOCF_MASK	BIT(0)
>>> +#define DFSDM_ISR_JEOCF(v)	FIELD_PREP(DFSDM_ISR_JEOCF_MASK, v)
>>> +#define DFSDM_ISR_REOCF_MASK	BIT(1)
>>> +#define DFSDM_ISR_REOCF(v)	FIELD_PREP(DFSDM_ISR_REOCF_MASK, v)
>>> +#define DFSDM_ISR_JOVRF_MASK	BIT(2)
>>> +#define DFSDM_ISR_JOVRF(v)	FIELD_PREP(DFSDM_ISR_JOVRF_MASK, v)
>>> +#define DFSDM_ISR_ROVRF_MASK	BIT(3)
>>> +#define DFSDM_ISR_ROVRF(v)	FIELD_PREP(DFSDM_ISR_ROVRF_MASK, v)
>>> +#define DFSDM_ISR_AWDF_MASK	BIT(4)
>>> +#define DFSDM_ISR_AWDF(v)	FIELD_PREP(DFSDM_ISR_AWDF_MASK, v)
>>> +#define DFSDM_ISR_JCIP_MASK	BIT(13)
>>> +#define DFSDM_ISR_JCIP(v)	FIELD_PREP(DFSDM_ISR_JCIP_MASK, v)
>>> +#define DFSDM_ISR_RCIP_MASK	BIT(14)
>>> +#define DFSDM_ISR_RCIP(v)	FIELD_PREP(DFSDM_ISR_RCIP, v)
>>> +#define DFSDM_ISR_CKABF_MASK	GENMASK(23, 16)
>>> +#define DFSDM_ISR_CKABF(v)	FIELD_PREP(DFSDM_ISR_CKABF_MASK, v)
>>> +#define DFSDM_ISR_SCDF_MASK	GENMASK(31, 24)
>>> +#define DFSDM_ISR_SCDF(v)	FIELD_PREP(DFSDM_ISR_SCDF_MASK, v)
>>> +
>>> +/* ICR: Interrupt flag clear register */
>>> +#define DFSDM_ICR_CLRJOVRF_MASK	      BIT(2)
>>> +#define DFSDM_ICR_CLRJOVRF(v)	      FIELD_PREP(DFSDM_ICR_CLRJOVRF_MASK, v)
>>> +#define DFSDM_ICR_CLRROVRF_MASK	      BIT(3)
>>> +#define DFSDM_ICR_CLRROVRF(v)	      FIELD_PREP(DFSDM_ICR_CLRROVRF_MASK, v)
>>> +#define DFSDM_ICR_CLRCKABF_MASK	      GENMASK(23, 16)
>>> +#define DFSDM_ICR_CLRCKABF(v)	      FIELD_PREP(DFSDM_ICR_CLRCKABF_MASK, v)
>>> +#define DFSDM_ICR_CLRCKABF_CH_MASK(y) BIT(16 + (y))
>>> +#define DFSDM_ICR_CLRCKABF_CH(v, y)   \
>>> +			   (((v) << (16 + (y))) & DFSDM_ICR_CLRCKABF_CH_MASK(y))
>>> +#define DFSDM_ICR_CLRSCDF_MASK	      GENMASK(31, 24)
>>> +#define DFSDM_ICR_CLRSCDF(v)	      FIELD_PREP(DFSDM_ICR_CLRSCDF_MASK, v)
>>> +#define DFSDM_ICR_CLRSCDF_CH_MASK(y)  BIT(24 + (y))
>>> +#define DFSDM_ICR_CLRSCDF_CH(v, y)    \
>>> +			       (((v) << (24 + (y))) & DFSDM_ICR_CLRSCDF_MASK(y))
>>> +
>>> +/* FCR: Filter control register */
>>> +#define DFSDM_FCR_IOSR_MASK	GENMASK(7, 0)
>>> +#define DFSDM_FCR_IOSR(v)	FIELD_PREP(DFSDM_FCR_IOSR_MASK, v)
>>> +#define DFSDM_FCR_FOSR_MASK	GENMASK(25, 16)
>>> +#define DFSDM_FCR_FOSR(v)	FIELD_PREP(DFSDM_FCR_FOSR_MASK, v)
>>> +#define DFSDM_FCR_FORD_MASK	GENMASK(31, 29)
>>> +#define DFSDM_FCR_FORD(v)	FIELD_PREP(DFSDM_FCR_FORD_MASK, v)
>>> +
>>> +/* RDATAR: Filter data register for regular channel */
>>> +#define DFSDM_DATAR_CH_MASK	GENMASK(2, 0)
>>> +#define DFSDM_DATAR_DATA_OFFSET 8
>>> +#define DFSDM_DATAR_DATA_MASK	GENMASK(31, DFSDM_DATAR_DATA_OFFSET)
>>> +
>>> +/* AWLTR: Filter analog watchdog low threshold register */
>>> +#define DFSDM_AWLTR_BKAWL_MASK	GENMASK(3, 0)
>>> +#define DFSDM_AWLTR_BKAWL(v)	FIELD_PREP(DFSDM_AWLTR_BKAWL_MASK, v)
>>> +#define DFSDM_AWLTR_AWLT_MASK	GENMASK(31, 8)
>>> +#define DFSDM_AWLTR_AWLT(v)	FIELD_PREP(DFSDM_AWLTR_AWLT_MASK, v)
>>> +
>>> +/* AWHTR: Filter analog watchdog low threshold register */
>>> +#define DFSDM_AWHTR_BKAWH_MASK	GENMASK(3, 0)
>>> +#define DFSDM_AWHTR_BKAWH(v)	FIELD_PREP(DFSDM_AWHTR_BKAWH_MASK, v)
>>> +#define DFSDM_AWHTR_AWHT_MASK	GENMASK(31, 8)
>>> +#define DFSDM_AWHTR_AWHT(v)	FIELD_PREP(DFSDM_AWHTR_AWHT_MASK, v)
>>> +
>>> +/* AWSR: Filter watchdog status register */
>>> +#define DFSDM_AWSR_AWLTF_MASK	GENMASK(7, 0)
>>> +#define DFSDM_AWSR_AWLTF(v)	FIELD_PREP(DFSDM_AWSR_AWLTF_MASK, v)
>>> +#define DFSDM_AWSR_AWHTF_MASK	GENMASK(15, 8)
>>> +#define DFSDM_AWSR_AWHTF(v)	FIELD_PREP(DFSDM_AWSR_AWHTF_MASK, v)
>>> +
>>> +/* AWCFR: Filter watchdog status register */
>>> +#define DFSDM_AWCFR_AWLTF_MASK	GENMASK(7, 0)
>>> +#define DFSDM_AWCFR_AWLTF(v)	FIELD_PREP(DFSDM_AWCFR_AWLTF_MASK, v)
>>> +#define DFSDM_AWCFR_AWHTF_MASK	GENMASK(15, 8)
>>> +#define DFSDM_AWCFR_AWHTF(v)	FIELD_PREP(DFSDM_AWCFR_AWHTF_MASK, v)
>>> +
>>> +/* DFSDM filter order  */
>>> +enum stm32_dfsdm_sinc_order {
>>> +	DFSDM_FASTSINC_ORDER, /* FastSinc filter type */
>>> +	DFSDM_SINC1_ORDER,    /* Sinc 1 filter type */
>>> +	DFSDM_SINC2_ORDER,    /* Sinc 2 filter type */
>>> +	DFSDM_SINC3_ORDER,    /* Sinc 3 filter type */
>>> +	DFSDM_SINC4_ORDER,    /* Sinc 4 filter type (N.A. for watchdog) */
>>> +	DFSDM_SINC5_ORDER,    /* Sinc 5 filter type (N.A. for watchdog) */
>>> +	DFSDM_NB_SINC_ORDER,
>>> +};
>>> +
>>> +/**
>>> + * struct stm32_dfsdm_filter - structure relative to stm32 FDSDM filter
>>> + * TODO: complete structure.
>> nice :) RFC I guess :)
>>> + * @id:		filetr ID,
>>> + */
>>> +struct stm32_dfsdm_filter {
>>> +	unsigned int id;
>>> +	unsigned int iosr; /* integrator oversampling */
>>> +	unsigned int fosr; /* filter oversampling */
>>> +	enum stm32_dfsdm_sinc_order ford;
>>> +	u64 res; /* output sample resolution */
>>> +	unsigned int sync_mode; /* filter suynchronized with filter0 */
>>> +	unsigned int fast; /* filter fast mode */
>>> +};
>>> +
>>> +/**
>>> + * struct stm32_dfsdm_channel - structure relative to stm32 FDSDM channel
>>> + * TODO: complete structure.
>>> + * @id:		filetr ID,
>> filter
>>> + */
>>> +struct stm32_dfsdm_channel {
>>> +	unsigned int id;   /* id of the channel */
>>> +	unsigned int type; /* interface type linked to stm32_dfsdm_chan_type */
>>> +	unsigned int src; /* interface type linked to stm32_dfsdm_chan_src */
>>> +	unsigned int alt_si; /* use alternative serial input interface */
>>> +};
>>> +
>>> +/**
>>> + * struct stm32_dfsdm - stm32 FDSDM driver common data (for all instances)
>>> + * @base:	control registers base cpu addr
>>> + * @phys_base:	DFSDM IP register physical address.
>>> + * @fl_list:	filter resources list
>>> + * @num_fl:	number of filter resources available
>>> + * @ch_list:	channel resources list
>>> + * @num_chs:	number of channel resources available
>>> + */
>>> +struct stm32_dfsdm {
>>> +	void __iomem	*base;
>>> +	phys_addr_t	phys_base;
>>> +	struct regmap *regmap;
>>> +	struct stm32_dfsdm_filter *fl_list;
>>> +	unsigned int num_fls;
>>> +	struct stm32_dfsdm_channel *ch_list;
>>> +	unsigned int num_chs;
>>> +	unsigned int spi_master_freq;
>>> +};
>>> +
>>> +struct stm32_dfsdm_str2field {
>>> +	const char	*name;
>>> +	unsigned int	val;
>>> +};
>>> +
>>> +/* DFSDM channel serial interface type */
>>> +static const struct stm32_dfsdm_str2field stm32_dfsdm_chan_type[] = {
>>> +	{ "SPI_R", 0 }, /* SPI with data on rising edge */
>>> +	{ "SPI_F", 1 }, /* SPI with data on falling edge */
>>> +	{ "MANCH_R", 2 }, /* Manchester codec, rising edge = logic 0 */
>>> +	{ "MANCH_F", 3 }, /* Manchester codec, falling edge = logic 1 */
>>> +	{ 0, 0},
>>> +};
>>> +
>>> +/* DFSDM channel serial spi clock source */
>>> +enum stm32_dfsdm_spi_clk_src {
>>> +	DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL,
>>> +	DFSDM_CHANNEL_SPI_CLOCK_INTERNAL,
>>> +	DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_FALLING,
>>> +	DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_RISING
>>> +};
>>> +
>>> +/* DFSDM channel clock source */
>>> +static const struct stm32_dfsdm_str2field stm32_dfsdm_chan_src[] = {
>>> +	/* External SPI clock (CLKIN x) */
>>> +	{ "CLKIN", DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL },
>>> +	/* Internal SPI clock (CLKOUT) */
>>> +	{ "CLKOUT", DFSDM_CHANNEL_SPI_CLOCK_INTERNAL },
>>> +	/* Internal SPI clock divided by 2 (falling edge) */
>>> +	{ "CLKOUT_F", DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_FALLING },
>>> +	/* Internal SPI clock divided by 2 (falling edge) */
>>> +	{ "CLKOUT_R", DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_RISING },
>>> +	{ 0, 0 },
>>> +};
>>> +
>>> +/* DFSDM Serial interface trigger name  */
>>> +#define DFSDM_SPI_TRIGGER_NAME "DFSDM_SERIAL_IN"
>>> +
>>> +static inline int stm32_dfsdm_str2val(const char *str,
>>> +				      const struct stm32_dfsdm_str2field *list)
>>> +{
>>> +	const struct stm32_dfsdm_str2field *p = list;
>>> +
>>> +	for (p = list; p && p->name; p++) {
>>> +		if (!strcmp(p->name, str))
>>> +			return p->val;
>>> +	}
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +int stm32_dfsdm_set_osrs(struct stm32_dfsdm_filter *fl, unsigned int fast,
>>> +			 unsigned int oversamp);
>>> +int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm);
>>> +int stm32_dfsdm_stop_dfsdm(struct stm32_dfsdm *dfsdm);
>>> +
>>> +int stm32_dfsdm_filter_configure(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
>>> +				 unsigned int ch_id);
>>> +int stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id);
>>> +void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id);
>>> +
>>> +int stm32_dfsdm_chan_configure(struct stm32_dfsdm *dfsdm,
>>> +			       struct stm32_dfsdm_channel *ch);
>>> +int stm32_dfsdm_start_channel(struct stm32_dfsdm *dfsdm, unsigned int ch_id);
>>> +void stm32_dfsdm_stop_channel(struct stm32_dfsdm *dfsdm, unsigned int ch_id);
>>> +
>>> +int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
>>> +				 struct iio_dev *indio_dev,
>>> +				 struct iio_chan_spec *chan, int chan_idx);
>>> +
>>> +#endif
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

