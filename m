Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:61835 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751996AbdB0Lgl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 06:36:41 -0500
Subject: Re: [RFC v2 7/7] IIO: ADC: add stm32 DFSDM support
To: Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-8-git-send-email-arnaud.pouliquen@st.com>
 <0fa13efc-6842-3a61-fa3c-433a93ebcf10@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <fe86eca5-5dca-efb3-45d2-46e193f60dc9@st.com>
Date: Mon, 27 Feb 2017 11:09:55 +0100
MIME-Version: 1.0
In-Reply-To: <0fa13efc-6842-3a61-fa3c-433a93ebcf10@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,

Late answer... sorry for this.

I will integrate your remark in V2.
Please find my answers in-line

Regards
Arnaud

On 02/19/2017 03:46 PM, Jonathan Cameron wrote:
> On 13/02/17 16:38, Arnaud Pouliquen wrote:
>> Add driver for stm32 DFSDM IP. This IP converts a sigma delta stream in
>> n bit samples through a low pass filter and an integrator.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> I think this fits together rather nicely.  As before, various comments that
> are irrelevant to an RFC (I just couldn't stop myself ;) and a few more
> relevant ones.
> 
> So as far as I'm concerned: Looking forward to the full version!
> (as long as Mark and others are happy of course)
> 
> I definitely want to ultimately see buffered and dma support on the
> ADC driver side of things as well but that can come later.
Ok, I suppose that DMA in cyclic mode should also be required for some
other IIO driver...
> 
> Jonathan
>> ---
>>  drivers/iio/adc/Kconfig            |  13 +
>>  drivers/iio/adc/Makefile           |   1 +
>>  drivers/iio/adc/stm32-dfsdm-adc.c  | 483 +++++++++++++++++++++++++++++++++++++
>>  drivers/iio/adc/stm32-dfsdm-core.c | 273 +++++++++++++++++++++
>>  drivers/iio/adc/stm32-dfsdm.h      | 141 +++++++++++
>>  5 files changed, 911 insertions(+)
>>  create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c
>>  create mode 100644 drivers/iio/adc/stm32-dfsdm-core.c
>>  create mode 100644 drivers/iio/adc/stm32-dfsdm.h
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index d4366ac..ab917b6 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -452,6 +452,19 @@ config STM32_ADC
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called stm32-adc.
>>  
>> +config STM32_DFSDM_ADC
>> +	tristate "STMicroelectronics STM32 dfsdm adc"
>> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>> +	select REGMAP
>> +	select REGMAP_MMIO
>> +	select IIO_HW_CONSUMER
>> +	help
>> +	  Select this option to enable the  driver for STMicroelectronics
>> +	  STM32 digital filter for sigma delta converter (ADC).
>> +
>> +	  This driver can also be built as a module.  If so, the module
>> +	  will be called stm32-adc-dfsdm-adc.
>> +
>>  config STX104
>>  	tristate "Apex Embedded Systems STX104 driver"
>>  	depends on X86 && ISA_BUS_API
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index bd67144..5bcad23 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -43,6 +43,7 @@ obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>>  obj-$(CONFIG_STX104) += stx104.o
>>  obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>>  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
>> +obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o stm32-dfsdm-core.o
>>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>>  obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
>> new file mode 100644
>> index 0000000..8f9c3263
>> --- /dev/null
>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>> @@ -0,0 +1,483 @@
>> +/*
>> + * This file is part of STM32 DFSDM ADC driver
>> + *
>> + * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
>> + * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
>> + *
>> + * License type: GPLv2
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
>> + * or FITNESS FOR A PARTICULAR PURPOSE.
>> + * See the GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#include <linux/iio/hw_consumer.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +#include <sound/stm32-adfsdm.h>
>> +
>> +#include "stm32-dfsdm.h"
>> +
>> +enum stm32_dfsdm_mode {
>> +	DFSDM_ADC, /* ADC mode, access through IIO ABI */
>> +	DFSDM_AUDIO /* Audio mode, access through ASoC ABI */
>> +};
>> +
>> +struct stm32_dfsdm_adc {
>> +	struct stm32_dfsdm *common;
>> +
>> +	unsigned int fl_id;
>> +	unsigned int oversamp;
>> +	unsigned int clk_freq;
>> +
>> +	enum stm32_dfsdm_mode mode;
>> +	struct platform_device *audio_pdev;
>> +
>> +	void (*overrun_cb)(void *context);
>> +	void *cb_context;
>> +
>> +	/* Hardware consumer structure for Front End iio */
> IIO
>> +	struct iio_hw_consumer *hwc;
>> +};
>> +
>> +static const enum stm32_dfsdm_mode stm32_dfsdm_data_adc = DFSDM_ADC;
>> +static const enum stm32_dfsdm_mode stm32_dfsdm_data_audio = DFSDM_AUDIO;
>> +
>> +struct stm32_dfsdm_adc_devdata {
>> +	enum stm32_dfsdm_mode mode;
>> +	const struct iio_info *info;
>> +};
>> +
>> +static int stm32_dfsdm_set_osrs(struct stm32_dfsdm_adc *adc, bool fast,
>> +				unsigned int oversamp)
>> +{
>> +	/*
>> +	 * TODO
>> +	 * This function tries to compute filter oversampling and integrator
>> +	 * oversampling, base on oversampling ratio requested by user.
>> +	 */
>> +
>> +	return 0;
>> +};
>> +
>> +static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
>> +				   const struct iio_chan_spec *chan, int *res)
>> +{
>> +	/* TODO: Perform conversion instead of sending fake value */
>> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
> :( Definitely an RFC
>> +
>> +	*res = chan->channel + 0xFFFF00;
>> +	return 0;
>> +}
>> +
>> +static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
>> +				 struct iio_chan_spec const *chan,
>> +				 int val, int val2, long mask)
>> +{
>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> +		ret = stm32_dfsdm_set_osrs(adc, 0, val);
>> +		if (!ret)
>> +			adc->oversamp = val;
> If no reason to carry on,(i.e. nothing to unwind) return directly from within
> the switch statement.
>> +		break;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		if (adc->mode == DFSDM_AUDIO)
>> +			ret = stm32_dfsdm_set_osrs(adc, 0, val);
>> +		else
>> +			ret = -EINVAL;
>> +		break;
>> +
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>> +				struct iio_chan_spec const *chan, int *val,
>> +				int *val2, long mask)
>> +{
>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		if (adc->hwc) {
>> +			ret = iio_hw_consumer_enable(adc->hwc);
>> +			if (ret < 0) {
>> +				dev_err(&indio_dev->dev,
>> +					"%s: iio enable failed (channel %d)\n",
>> +					__func__, chan->channel);
>> +				return ret;
>> +			}
> Not an error if hwc not available?
ASoC framework requests to handle a codec driver. So in case of PDM
usecase, no IIO SD modulator device is used, instead an ASoC generic
dmic-codec device is probed. In other words the link between the DFSDM
and the external SD-modulator has to be done in ASOC for PDMs and in
IIO for ADCs.

>> +		}
>> +		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
>> +		if (ret < 0) {
>> +			dev_err(&indio_dev->dev,
>> +				"%s: conversion failed (channel %d)\n",
>> +				__func__, chan->channel);
>> +			return ret;
>> +		}
>> +
>> +		if (adc->hwc)
>> +			iio_hw_consumer_disable(adc->hwc);
>> +
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> +		*val = adc->oversamp;
>> +
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val = DIV_ROUND_CLOSEST(adc->clk_freq, adc->oversamp);
>> +
>> +		return IIO_VAL_INT;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct iio_info stm32_dfsdm_info_adc = {
>> +	.read_raw = stm32_dfsdm_read_raw,
>> +	.write_raw = stm32_dfsdm_write_raw,
>> +	.driver_module = THIS_MODULE,
>> +};
>> +
>> +static const struct iio_info stm32_dfsdm_info_audio = {
>> +	.read_raw = stm32_dfsdm_read_raw,
>> +	.write_raw = stm32_dfsdm_write_raw,
>> +	.driver_module = THIS_MODULE,
>> +};
> Hohum. These two are the same, why two copies?  Mind you for the audio
> you can't write or read anything so you could drop the callbacks.
yes to rework.
>> +
>> +const struct stm32_dfsdm_adc_devdata stm32_dfsdm_devdata_adc = {
>> +	.mode = DFSDM_ADC,
>> +	.info = &stm32_dfsdm_info_adc,
>> +};
>> +
>> +const struct stm32_dfsdm_adc_devdata stm32_dfsdm_devdata_audio = {
>> +	.mode = DFSDM_AUDIO,
>> +	.info = &stm32_dfsdm_info_audio,
>> +};
>> +
>> +static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
>> +{
>> +	/* TODO */
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void stm32_dfsdm_set_sysclk(struct stm32_dfsdm_adc *adc,
>> +				   unsigned int freq)
>> +{
>> +	struct iio_dev *iio = iio_priv_to_dev(adc);
>> +
>> +	dev_dbg(&iio->dev, "%s:\n", __func__);
>> +
>> +	adc->clk_freq = freq;
>> +};
>> +
>> +	/* Set expected audio sampling rate */
>> +static int stm32_dfsdm_set_hwparam(struct stm32_dfsdm_adc *adc,
>> +				   struct stm32_dfsdm_hw_param *params)
>> +{
>> +	struct iio_dev *iio = iio_priv_to_dev(adc);
>> +
>> +	dev_dbg(&iio->dev, "%s for rate %d\n", __func__, params->rate);
>> +
>> +	return stm32_dfsdm_set_osrs(adc, 0, params->rate);
>> +};
>> +
>> +	/* Called when ASoC starts an audio stream setup. */
>> +static int stm32_dfsdm_audio_startup(struct stm32_dfsdm_adc *adc)
>> +{
>> +	struct iio_dev *iio = iio_priv_to_dev(adc);
>> +
>> +	dev_dbg(&iio->dev, "%s\n", __func__);
>> +
>> +	return 0;
>> +};
>> +
>> +	/* Shuts down the audio stream. */
> Odd indenting.
>> +static void stm32_dfsdm_audio_shutdown(struct stm32_dfsdm_adc *adc)
>> +{
>> +	struct iio_dev *iio = iio_priv_to_dev(adc);
>> +
>> +	dev_dbg(&iio->dev, "%s\n", __func__);
>> +};
>> +
>> +	/*
>> +	 * Provides DMA source physicla addr to allow ALsa to handle DMA
>> +	 * transfers.
> physical - please run a spell checker over the comments.
>> +	 */
>> +static dma_addr_t stm32_dfsdm_get_dma_source(struct stm32_dfsdm_adc *adc)
>> +{
>> +	struct iio_dev *iio = iio_priv_to_dev(adc);
>> +
>> +	dev_dbg(&iio->dev, "%s\n", __func__);
>> +
>> +	return (dma_addr_t)(adc->common->phys_base + DFSDM_RDATAR(adc->fl_id));
>> +};
>> +
>> +/* Register callback to treat underrun and overrun issues */
>> +static void stm32_dfsdm_register_xrun_cb(struct stm32_dfsdm_adc *adc,
>> +					 void (*overrun_cb)(void *context),
>> +					 void *context)
>> +{
>> +	struct iio_dev *iio = iio_priv_to_dev(adc);
>> +
>> +	dev_dbg(&iio->dev, "%s\n", __func__);
>> +	adc->overrun_cb = overrun_cb;
>> +	adc->cb_context = context;
>> +};
>> +
>> +const struct stm32_adfsdm_codec_ops stm32_dfsdm_audio_ops = {
>> +	.set_sysclk = stm32_dfsdm_set_sysclk,
>> +	.set_hwparam = stm32_dfsdm_set_hwparam,
>> +	.audio_startup = stm32_dfsdm_audio_startup,
>> +	.audio_shutdown = stm32_dfsdm_audio_shutdown,
>> +	.register_xrun_cb = stm32_dfsdm_register_xrun_cb,
>> +	.get_dma_source = stm32_dfsdm_get_dma_source
>> +};
> Hmm. I'm wondering if it might make sense to farm the audio stuff off
> to a separate file.  Potentially we'll have systems that are built with
> no audio support at all, so would be odd to have this stuff still provided.
Ok, this make sense if the API become generic.
> 
> What do you think?  Also provides an obvious clean bit to be Mark's problem
> (even if it's in the IIO directory ;)
I can't answer instead of Mark,( and perhaps i misunderstood...) but
regarding HDMI story (drivers shared between ASoC and DRM), not sure
that Mark accepts to have an ASoC drivers in IIO directory. So need a
part in ASoC that is customer of IIO driver...

>> +
>> +static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
>> +					 struct iio_chan_spec *chan,
>> +					 int chan_idx)
>> +{
>> +	struct iio_chan_spec *ch = &chan[chan_idx];
>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	dev_dbg(&indio_dev->dev, "%s:\n", __func__);
>> +	ret = of_property_read_u32_index(indio_dev->dev.of_node,
>> +					 "st,adc-channels", chan_idx,
>> +					 &ch->channel);
>> +	if (ret < 0) {
>> +		dev_err(&indio_dev->dev,
>> +			" error parsing 'st,adc-channels' for idx %d\n",
>> +			chan_idx);
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_string_index(indio_dev->dev.of_node,
>> +					    "st,adc-channel-names", chan_idx,
>> +					    &ch->datasheet_name);
>> +	if (ret < 0) {
>> +		dev_err(&indio_dev->dev,
>> +			" error parsing 'st,adc-channel-names' for idx %d\n",
>> +			chan_idx);
>> +		return ret;
>> +	}
>> +
>> +	ch->type = IIO_VOLTAGE;
>> +	ch->indexed = 1;
>> +	ch->scan_index = chan_idx;
>> +	if (adc->mode == DFSDM_ADC) {
>> +		/*
>> +		 * IIO_CHAN_INFO_RAW: used to compute regular conversion
>> +		 * IIO_CHAN_INFO_SAMP_FREQ: used to indicate sampling frequency
>> +		 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used set oversampling
>> +		 */
>> +		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +					 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>> +					 BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> Very nice.  I was just thinking you should do this before I got here.
> Channels with no properties but still with an existence from the point of
> view of consumers using the buffered interface.  Potentially you 'could'
> provide some of the info as read only but why bother...
>> +	}
>> +
>> +	ch->scan_type.sign = 'u';
>> +	ch->scan_type.realbits = 24;
>> +	ch->scan_type.storagebits = 32;
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_dfsdm_adc_chan_init(struct iio_dev *indio_dev)
>> +{
>> +	struct iio_chan_spec *channels;
>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>> +	unsigned int num_ch;
>> +	int ret, chan_idx;
>> +
>> +	num_ch = of_property_count_u32_elems(indio_dev->dev.of_node,
>> +					     "st,adc-channels");
>> +	if (num_ch < 0 || num_ch >= adc->common->num_chs) {
>> +		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
>> +		return num_ch < 0 ? num_ch : -EINVAL;
>> +	}
>> +
>> +	channels = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*channels),
>> +				GFP_KERNEL);
>> +	if (!channels)
>> +		return -ENOMEM;
>> +
>> +	if (adc->mode == DFSDM_ADC) {
>> +		/*
>> +		 * Bind to sd modulator iio device for ADC only.
>> +		 * For Audio the PDM microphone will be handled by ASoC
>> +		 */
>> +		adc->hwc = iio_hw_consumer_alloc(&indio_dev->dev);
>> +		if (IS_ERR(adc->hwc)) {
>> +			dev_err(&indio_dev->dev, "no backend found\n");
> Deferred probing a possibility? I'm not quite sure and you know what is going
> on here better than me ;)
Reading your comment i have a doubt... i will cross check
Idea here is that there is a customer-provider relationchip with the
sd-modulator driver. So need that sd-modulator driver is probed first.

>> +			return PTR_ERR(adc->hwc);
>> +		}
>> +	}
>> +
>> +	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
>> +		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, channels,
>> +						    chan_idx);
>> +		if (ret < 0)
>> +			goto free_hwc;
>> +	}
>> +
>> +	indio_dev->num_channels = num_ch;
>> +	indio_dev->channels = channels;
>> +
>> +	return 0;
>> +
>> +free_hwc:
>> +	if (adc->hwc)
>> +		iio_hw_consumer_free(adc->hwc);
>> +	return ret;
>> +}
>> +
[...]
