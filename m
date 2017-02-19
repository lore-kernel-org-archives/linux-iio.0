Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38179 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdBSOql (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 09:46:41 -0500
Subject: Re: [RFC v2 7/7] IIO: ADC: add stm32 DFSDM support
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
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-8-git-send-email-arnaud.pouliquen@st.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel@stlinux.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        olivier moysan <olivier.moysan@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0fa13efc-6842-3a61-fa3c-433a93ebcf10@kernel.org>
Date: Sun, 19 Feb 2017 14:46:33 +0000
MIME-Version: 1.0
In-Reply-To: <1487003909-11710-8-git-send-email-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/02/17 16:38, Arnaud Pouliquen wrote:
> Add driver for stm32 DFSDM IP. This IP converts a sigma delta stream in
> n bit samples through a low pass filter and an integrator.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
I think this fits together rather nicely.  As before, various comments that
are irrelevant to an RFC (I just couldn't stop myself ;) and a few more
relevant ones.

So as far as I'm concerned: Looking forward to the full version!
(as long as Mark and others are happy of course)

I definitely want to ultimately see buffered and dma support on the
ADC driver side of things as well but that can come later.

Jonathan
> ---
>  drivers/iio/adc/Kconfig            |  13 +
>  drivers/iio/adc/Makefile           |   1 +
>  drivers/iio/adc/stm32-dfsdm-adc.c  | 483 +++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/stm32-dfsdm-core.c | 273 +++++++++++++++++++++
>  drivers/iio/adc/stm32-dfsdm.h      | 141 +++++++++++
>  5 files changed, 911 insertions(+)
>  create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c
>  create mode 100644 drivers/iio/adc/stm32-dfsdm-core.c
>  create mode 100644 drivers/iio/adc/stm32-dfsdm.h
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d4366ac..ab917b6 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -452,6 +452,19 @@ config STM32_ADC
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called stm32-adc.
>  
> +config STM32_DFSDM_ADC
> +	tristate "STMicroelectronics STM32 dfsdm adc"
> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> +	select REGMAP
> +	select REGMAP_MMIO
> +	select IIO_HW_CONSUMER
> +	help
> +	  Select this option to enable the  driver for STMicroelectronics
> +	  STM32 digital filter for sigma delta converter (ADC).
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called stm32-adc-dfsdm-adc.
> +
>  config STX104
>  	tristate "Apex Embedded Systems STX104 driver"
>  	depends on X86 && ISA_BUS_API
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index bd67144..5bcad23 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>  obj-$(CONFIG_STX104) += stx104.o
>  obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
> +obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o stm32-dfsdm-core.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>  obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> new file mode 100644
> index 0000000..8f9c3263
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -0,0 +1,483 @@
> +/*
> + * This file is part of STM32 DFSDM ADC driver
> + *
> + * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
> + * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
> + *
> + * License type: GPLv2
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/hw_consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include <sound/stm32-adfsdm.h>
> +
> +#include "stm32-dfsdm.h"
> +
> +enum stm32_dfsdm_mode {
> +	DFSDM_ADC, /* ADC mode, access through IIO ABI */
> +	DFSDM_AUDIO /* Audio mode, access through ASoC ABI */
> +};
> +
> +struct stm32_dfsdm_adc {
> +	struct stm32_dfsdm *common;
> +
> +	unsigned int fl_id;
> +	unsigned int oversamp;
> +	unsigned int clk_freq;
> +
> +	enum stm32_dfsdm_mode mode;
> +	struct platform_device *audio_pdev;
> +
> +	void (*overrun_cb)(void *context);
> +	void *cb_context;
> +
> +	/* Hardware consumer structure for Front End iio */
IIO
> +	struct iio_hw_consumer *hwc;
> +};
> +
> +static const enum stm32_dfsdm_mode stm32_dfsdm_data_adc = DFSDM_ADC;
> +static const enum stm32_dfsdm_mode stm32_dfsdm_data_audio = DFSDM_AUDIO;
> +
> +struct stm32_dfsdm_adc_devdata {
> +	enum stm32_dfsdm_mode mode;
> +	const struct iio_info *info;
> +};
> +
> +static int stm32_dfsdm_set_osrs(struct stm32_dfsdm_adc *adc, bool fast,
> +				unsigned int oversamp)
> +{
> +	/*
> +	 * TODO
> +	 * This function tries to compute filter oversampling and integrator
> +	 * oversampling, base on oversampling ratio requested by user.
> +	 */
> +
> +	return 0;
> +};
> +
> +static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan, int *res)
> +{
> +	/* TODO: Perform conversion instead of sending fake value */
> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
:( Definitely an RFC
> +
> +	*res = chan->channel + 0xFFFF00;
> +	return 0;
> +}
> +
> +static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = stm32_dfsdm_set_osrs(adc, 0, val);
> +		if (!ret)
> +			adc->oversamp = val;
If no reason to carry on,(i.e. nothing to unwind) return directly from within
the switch statement.
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (adc->mode == DFSDM_AUDIO)
> +			ret = stm32_dfsdm_set_osrs(adc, 0, val);
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan, int *val,
> +				int *val2, long mask)
> +{
> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (adc->hwc) {
> +			ret = iio_hw_consumer_enable(adc->hwc);
> +			if (ret < 0) {
> +				dev_err(&indio_dev->dev,
> +					"%s: iio enable failed (channel %d)\n",
> +					__func__, chan->channel);
> +				return ret;
> +			}
Not an error if hwc not available?
> +		}
> +		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev,
> +				"%s: conversion failed (channel %d)\n",
> +				__func__, chan->channel);
> +			return ret;
> +		}
> +
> +		if (adc->hwc)
> +			iio_hw_consumer_disable(adc->hwc);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = adc->oversamp;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = DIV_ROUND_CLOSEST(adc->clk_freq, adc->oversamp);
> +
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info stm32_dfsdm_info_adc = {
> +	.read_raw = stm32_dfsdm_read_raw,
> +	.write_raw = stm32_dfsdm_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const struct iio_info stm32_dfsdm_info_audio = {
> +	.read_raw = stm32_dfsdm_read_raw,
> +	.write_raw = stm32_dfsdm_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
Hohum. These two are the same, why two copies?  Mind you for the audio
you can't write or read anything so you could drop the callbacks.
> +
> +const struct stm32_dfsdm_adc_devdata stm32_dfsdm_devdata_adc = {
> +	.mode = DFSDM_ADC,
> +	.info = &stm32_dfsdm_info_adc,
> +};
> +
> +const struct stm32_dfsdm_adc_devdata stm32_dfsdm_devdata_audio = {
> +	.mode = DFSDM_AUDIO,
> +	.info = &stm32_dfsdm_info_audio,
> +};
> +
> +static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
> +{
> +	/* TODO */
> +	return IRQ_HANDLED;
> +}
> +
> +static void stm32_dfsdm_set_sysclk(struct stm32_dfsdm_adc *adc,
> +				   unsigned int freq)
> +{
> +	struct iio_dev *iio = iio_priv_to_dev(adc);
> +
> +	dev_dbg(&iio->dev, "%s:\n", __func__);
> +
> +	adc->clk_freq = freq;
> +};
> +
> +	/* Set expected audio sampling rate */
> +static int stm32_dfsdm_set_hwparam(struct stm32_dfsdm_adc *adc,
> +				   struct stm32_dfsdm_hw_param *params)
> +{
> +	struct iio_dev *iio = iio_priv_to_dev(adc);
> +
> +	dev_dbg(&iio->dev, "%s for rate %d\n", __func__, params->rate);
> +
> +	return stm32_dfsdm_set_osrs(adc, 0, params->rate);
> +};
> +
> +	/* Called when ASoC starts an audio stream setup. */
> +static int stm32_dfsdm_audio_startup(struct stm32_dfsdm_adc *adc)
> +{
> +	struct iio_dev *iio = iio_priv_to_dev(adc);
> +
> +	dev_dbg(&iio->dev, "%s\n", __func__);
> +
> +	return 0;
> +};
> +
> +	/* Shuts down the audio stream. */
Odd indenting.
> +static void stm32_dfsdm_audio_shutdown(struct stm32_dfsdm_adc *adc)
> +{
> +	struct iio_dev *iio = iio_priv_to_dev(adc);
> +
> +	dev_dbg(&iio->dev, "%s\n", __func__);
> +};
> +
> +	/*
> +	 * Provides DMA source physicla addr to allow ALsa to handle DMA
> +	 * transfers.
physical - please run a spell checker over the comments.
> +	 */
> +static dma_addr_t stm32_dfsdm_get_dma_source(struct stm32_dfsdm_adc *adc)
> +{
> +	struct iio_dev *iio = iio_priv_to_dev(adc);
> +
> +	dev_dbg(&iio->dev, "%s\n", __func__);
> +
> +	return (dma_addr_t)(adc->common->phys_base + DFSDM_RDATAR(adc->fl_id));
> +};
> +
> +/* Register callback to treat underrun and overrun issues */
> +static void stm32_dfsdm_register_xrun_cb(struct stm32_dfsdm_adc *adc,
> +					 void (*overrun_cb)(void *context),
> +					 void *context)
> +{
> +	struct iio_dev *iio = iio_priv_to_dev(adc);
> +
> +	dev_dbg(&iio->dev, "%s\n", __func__);
> +	adc->overrun_cb = overrun_cb;
> +	adc->cb_context = context;
> +};
> +
> +const struct stm32_adfsdm_codec_ops stm32_dfsdm_audio_ops = {
> +	.set_sysclk = stm32_dfsdm_set_sysclk,
> +	.set_hwparam = stm32_dfsdm_set_hwparam,
> +	.audio_startup = stm32_dfsdm_audio_startup,
> +	.audio_shutdown = stm32_dfsdm_audio_shutdown,
> +	.register_xrun_cb = stm32_dfsdm_register_xrun_cb,
> +	.get_dma_source = stm32_dfsdm_get_dma_source
> +};
Hmm. I'm wondering if it might make sense to farm the audio stuff off
to a separate file.  Potentially we'll have systems that are built with
no audio support at all, so would be odd to have this stuff still provided.

What do you think?  Also provides an obvious clean bit to be Mark's problem
(even if it's in the IIO directory ;)
> +
> +static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
> +					 struct iio_chan_spec *chan,
> +					 int chan_idx)
> +{
> +	struct iio_chan_spec *ch = &chan[chan_idx];
> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	dev_dbg(&indio_dev->dev, "%s:\n", __func__);
> +	ret = of_property_read_u32_index(indio_dev->dev.of_node,
> +					 "st,adc-channels", chan_idx,
> +					 &ch->channel);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev,
> +			" error parsing 'st,adc-channels' for idx %d\n",
> +			chan_idx);
> +		return ret;
> +	}
> +
> +	ret = of_property_read_string_index(indio_dev->dev.of_node,
> +					    "st,adc-channel-names", chan_idx,
> +					    &ch->datasheet_name);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev,
> +			" error parsing 'st,adc-channel-names' for idx %d\n",
> +			chan_idx);
> +		return ret;
> +	}
> +
> +	ch->type = IIO_VOLTAGE;
> +	ch->indexed = 1;
> +	ch->scan_index = chan_idx;
> +	if (adc->mode == DFSDM_ADC) {
> +		/*
> +		 * IIO_CHAN_INFO_RAW: used to compute regular conversion
> +		 * IIO_CHAN_INFO_SAMP_FREQ: used to indicate sampling frequency
> +		 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used set oversampling
> +		 */
> +		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					 BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
Very nice.  I was just thinking you should do this before I got here.
Channels with no properties but still with an existence from the point of
view of consumers using the buffered interface.  Potentially you 'could'
provide some of the info as read only but why bother...
> +	}
> +
> +	ch->scan_type.sign = 'u';
> +	ch->scan_type.realbits = 24;
> +	ch->scan_type.storagebits = 32;
> +
> +	return 0;
> +}
> +
> +static int stm32_dfsdm_adc_chan_init(struct iio_dev *indio_dev)
> +{
> +	struct iio_chan_spec *channels;
> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	unsigned int num_ch;
> +	int ret, chan_idx;
> +
> +	num_ch = of_property_count_u32_elems(indio_dev->dev.of_node,
> +					     "st,adc-channels");
> +	if (num_ch < 0 || num_ch >= adc->common->num_chs) {
> +		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
> +		return num_ch < 0 ? num_ch : -EINVAL;
> +	}
> +
> +	channels = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*channels),
> +				GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	if (adc->mode == DFSDM_ADC) {
> +		/*
> +		 * Bind to sd modulator iio device for ADC only.
> +		 * For Audio the PDM microphone will be handled by ASoC
> +		 */
> +		adc->hwc = iio_hw_consumer_alloc(&indio_dev->dev);
> +		if (IS_ERR(adc->hwc)) {
> +			dev_err(&indio_dev->dev, "no backend found\n");
Deferred probing a possibility? I'm not quite sure and you know what is going
on here better than me ;)
> +			return PTR_ERR(adc->hwc);
> +		}
> +	}
> +
> +	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
> +		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, channels,
> +						    chan_idx);
> +		if (ret < 0)
> +			goto free_hwc;
> +	}
> +
> +	indio_dev->num_channels = num_ch;
> +	indio_dev->channels = channels;
> +
> +	return 0;
> +
> +free_hwc:
> +	if (adc->hwc)
> +		iio_hw_consumer_free(adc->hwc);
> +	return ret;
> +}
> +
> +static const struct of_device_id stm32_dfsdm_adc_match[] = {
> +	{ .compatible = "st,stm32-dfsdm-adc",
> +	  .data = &stm32_dfsdm_devdata_adc},
> +	{ .compatible = "st,stm32-dfsdm-pdm",
> +	  .data = &stm32_dfsdm_devdata_audio},
> +	{}
> +};
> +
> +static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct stm32_dfsdm_adc *adc;
> +	const struct of_device_id *of_id;
> +	struct device_node *np = dev->of_node;
> +	const struct stm32_dfsdm_adc_devdata *devdata;
> +	struct iio_dev *iio;
> +	int ret, irq;
> +
> +	dev_dbg(dev, "%s:\n", __func__);
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (IS_ERR(iio)) {
> +		dev_err(dev, "%s: failed to allocate iio", __func__);
> +		return PTR_ERR(iio);
Returns NULL on failure rather than anything more useful.  I should look at
that one day, but the thought of a flag day to change all the drivers always
puts me off.  Mind you there aren't many ways it can fail and they all
correspond to -ENOMEM anyway so might never be worth the effort.

> +	}
> +
> +	adc = iio_priv(iio);
> +	if (IS_ERR(adc)) {
This one can't happen.  It's part of the same alloc as the struct iio_dev
above so it's both or neither.
> +		dev_err(dev, "%s: failed to allocate adc", __func__);
> +		return PTR_ERR(adc);
> +	}
> +	adc->common = dev_get_drvdata(dev->parent);
> +
> +	/* Populate data structure depending on compatibility */
> +	of_id = of_match_node(stm32_dfsdm_adc_match, np);
> +	if (!of_id->data) {
> +		dev_err(&pdev->dev, "Data associated to device is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	devdata = (const struct stm32_dfsdm_adc_devdata *)of_id->data;
> +	adc->mode = devdata->mode;
> +
> +	iio->name = np->name;
> +	iio->dev.parent = dev;
> +	iio->dev.of_node = np;
> +	iio->info = devdata->info;
> +	iio->modes = INDIO_DIRECT_MODE;
> +
> +	platform_set_drvdata(pdev, adc);
> +
> +	ret = of_property_read_u32(dev->of_node, "reg", &adc->fl_id);
> +	if (ret != 0) {
> +		dev_err(dev, "missing reg property\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * In a first step IRQs generated for channels are not treated.
> +	 * So IRQ associated to filter instance 0 is dedicated to the Filter 0.
I'd say 'for now' or something like that.  I initially thought you meant
they were handled later in this function.

For this first patch, just drop requesting them at all.
> +	 * In a second step IRQ domain should be used for filter 0 when feature
> +	 * like Watchdog, clock absence detection,... will be integrated.
> +	 */
> +	irq = platform_get_irq(pdev, 0);
> +	ret = devm_request_irq(dev, irq, stm32_dfsdm_irq,
> +			       0, pdev->name, adc);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to request IRQ\n");
> +		return ret;
> +	}
> +
> +	ret = stm32_dfsdm_adc_chan_init(iio);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = iio_device_register(iio);
> +	if (ret) {
> +		dev_err(dev, "failed to register iio device\n");
> +		return ret;
> +	}
> +
> +	if (adc->mode == DFSDM_AUDIO) {
> +		struct stm32_adfsdm_pdata dai_data = {
> +			.ops = &stm32_dfsdm_audio_ops,
> +			.adc = adc,
> +		};
> +
> +		adc->audio_pdev = platform_device_register_data(
> +						dev, STM32_ADFSDM_DRV_NAME,
> +						PLATFORM_DEVID_AUTO,
> +						&dai_data, sizeof(dai_data));
> +
> +		if (IS_ERR(adc->audio_pdev))
> +			return PTR_ERR(adc->audio_pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
> +{
> +	struct stm32_dfsdm_adc *adc = platform_get_drvdata(pdev);
> +	struct iio_dev *iio = iio_priv_to_dev(adc);
> +
> +	iio_device_unregister(iio);
As before, if nothing else here, you can just use a devm_iio_device_register
call and drop the remove entirely.
> +
> +	return 0;
> +}
> +
> +static struct platform_driver stm32_dfsdm_adc_driver = {
> +	.driver = {
> +		.name = "stm32-dfsdm-adc",
> +		.of_match_table = stm32_dfsdm_adc_match,
> +	},
> +	.probe = stm32_dfsdm_adc_probe,
> +	.remove = stm32_dfsdm_adc_remove,
> +};
> +module_platform_driver(stm32_dfsdm_adc_driver);
> +
> +MODULE_DESCRIPTION("STM32 sigma delta ADC");
> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> new file mode 100644
> index 0000000..195245d
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -0,0 +1,273 @@
> +/*
> + * This file is part of STM32 DFSDM mfd driver
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
> + *
> + * License terms: GPL V2.0.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
> + * details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include "stm32-dfsdm.h"
> +
> +struct stm32_dfsdm_dev_data {
> +	unsigned int num_filters;
> +	unsigned int num_channels;
> +	const struct regmap_config *regmap_cfg;
> +};
> +
> +#define STM32H7_DFSDM_NUM_FILTERS	4
> +#define STM32H7_DFSDM_NUM_CHANNELS	8
> +
> +static bool stm32_dfsdm_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	if (reg < DFSDM_FILTER_BASE_ADR)
> +		return false;
> +
> +	/*
> +	 * Mask is done on register to avoid to list registers of all them
> +	 * filter instances.
> +	 */
> +	switch (reg & DFSDM_FILTER_REG_MASK) {
> +	case DFSDM_CR1(0) & DFSDM_FILTER_REG_MASK:
> +	case DFSDM_ISR(0) & DFSDM_FILTER_REG_MASK:
> +	case DFSDM_JDATAR(0) & DFSDM_FILTER_REG_MASK:
> +	case DFSDM_RDATAR(0) & DFSDM_FILTER_REG_MASK:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct regmap_config stm32h7_dfsdm_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	.max_register = 0x2B8,
> +	.volatile_reg = stm32_dfsdm_volatile_reg,
> +	.fast_io = true,
> +};
> +
> +static const struct stm32_dfsdm_dev_data stm32h7_dfsdm_data = {
> +	.num_filters = STM32H7_DFSDM_NUM_FILTERS,
> +	.num_channels = STM32H7_DFSDM_NUM_CHANNELS,
> +	.regmap_cfg = &stm32h7_dfsdm_regmap_cfg,
> +};
> +
> +/**
> + * struct dfsdm_priv -  stm32 dfsdm  private data
> + * @pdev:		platform device
> + * @stm32_dfsdm:	common data exported for all instances
> + * @regmap:		register map of the device;
> + * @clkout_div:		SPI clkout divider value.
> + * @n_active_ch:	atomic active channel counter.
> + */
> +struct dfsdm_priv {
> +	struct platform_device *pdev;
> +
> +	struct stm32_dfsdm dfsdm;
> +	struct regmap *regmap;
> +
> +	unsigned int clkout_div;
> +	atomic_t n_active_ch;
> +};
> +
> +/**
> + * stm32_dfsdm_start_dfsdm - start global dfsdm IP interface.
> + *
> + * Enable interface if n_active_ch is not null.
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + */
> +int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +	int ret;
> +	int div = priv->clkout_div;
> +
> +	if (atomic_inc_return(&priv->n_active_ch) == 1) {
> +		/* TODO: enable clocks */
> +
> +		/* Output the SPI CLKOUT (if clkout_div == 0 clok if OFF) */
> +		ret = regmap_update_bits(priv->regmap, DFSDM_CHCFGR1(0),
> +					 DFSDM_CHCFGR1_CKOUTDIV_MASK,
> +					 DFSDM_CHCFGR1_CKOUTDIV(div));
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Global enable of DFSDM interface */
> +		ret = regmap_update_bits(priv->regmap, DFSDM_CHCFGR1(0),
> +					 DFSDM_CHCFGR1_DFSDMEN_MASK,
> +					 DFSDM_CHCFGR1_DFSDMEN(1));
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	dev_dbg(&priv->pdev->dev, "%s: n_active_ch %d\n", __func__,
> +		atomic_read(&priv->n_active_ch));
> +
> +	return 0;
> +}
> +
> +/**
> + * stm32_dfsdm_stop_dfsdm - stop global DFSDM IP interface.
> + *
> + * Disable interface if n_active_ch is null
> + * @dfsdm: Handle used to retrieve dfsdm context.
> + */
> +int stm32_dfsdm_stop_dfsdm(struct stm32_dfsdm *dfsdm)
> +{
> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +	int ret;
> +
> +	if (atomic_dec_and_test(&priv->n_active_ch)) {
> +		/* Global disable of DFSDM interface */
> +		ret = regmap_update_bits(priv->regmap, DFSDM_CHCFGR1(0),
> +					 DFSDM_CHCFGR1_DFSDMEN_MASK,
> +					 DFSDM_CHCFGR1_DFSDMEN(0));
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Stop SPI CLKOUT */
> +		ret = regmap_update_bits(priv->regmap, DFSDM_CHCFGR1(0),
> +					 DFSDM_CHCFGR1_CKOUTDIV_MASK,
> +					 DFSDM_CHCFGR1_CKOUTDIV(0));
> +		if (ret < 0)
> +			return ret;
> +
> +		/* TODO: disable clocks */
> +	}
> +	dev_dbg(&priv->pdev->dev, "%s: n_active_ch %d\n", __func__,
> +		atomic_read(&priv->n_active_ch));
> +
> +	return 0;
> +}
> +
> +static int stm32_dfsdm_parse_of(struct platform_device *pdev,
> +				struct dfsdm_priv *priv)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct resource *res;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	/* Get resources */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get memory resource\n");
> +		return -ENODEV;
> +	}
> +	priv->dfsdm.phys_base = res->start;
> +	priv->dfsdm.base = devm_ioremap_resource(&pdev->dev, res);
> +
> +	return 0;
> +};
> +
> +static const struct of_device_id stm32_dfsdm_of_match[] = {
> +	{
> +		.compatible = "st,stm32h7-dfsdm",
> +		.data = &stm32h7_dfsdm_data,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
> +
> +static int stm32_dfsdm_remove(struct platform_device *pdev)
> +{
> +	of_platform_depopulate(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int stm32_dfsdm_probe(struct platform_device *pdev)
> +{
> +	struct dfsdm_priv *priv;
> +	struct device_node *pnode = pdev->dev.of_node;
> +	const struct of_device_id *of_id;
> +	const struct stm32_dfsdm_dev_data *dev_data;
> +	struct stm32_dfsdm *dfsdm;
> +	int ret, i;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pdev = pdev;
> +
> +	/* Populate data structure depending on compatibility */
> +	of_id = of_match_node(stm32_dfsdm_of_match, pnode);
> +	if (!of_id->data) {
> +		dev_err(&pdev->dev, "Data associated to device is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
> +	dfsdm = &priv->dfsdm;
> +	dfsdm->fl_list = devm_kzalloc(&pdev->dev, sizeof(*dfsdm->fl_list),
> +				      GFP_KERNEL);
> +	if (!dfsdm->fl_list)
> +		return -ENOMEM;
> +
> +	dfsdm->num_fls = dev_data->num_filters;
> +	dfsdm->ch_list = devm_kzalloc(&pdev->dev, sizeof(*dfsdm->ch_list),
> +				      GFP_KERNEL);
> +	if (!dfsdm->ch_list)
> +		return -ENOMEM;
> +	dfsdm->num_chs = dev_data->num_channels;
> +		dev_err(&pdev->dev, "%s: dfsdm->num_ch: %d\n",
> +			__func__, dfsdm->num_chs);
> +
> +	ret = stm32_dfsdm_parse_of(pdev, priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->regmap = devm_regmap_init_mmio(&pdev->dev, dfsdm->base,
> +					    &stm32h7_dfsdm_regmap_cfg);
> +	if (IS_ERR(priv->regmap)) {
> +		ret = PTR_ERR(priv->regmap);
> +		dev_err(&pdev->dev, "%s: Failed to allocate regmap: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < STM32H7_DFSDM_NUM_FILTERS; i++) {
> +		struct stm32_dfsdm_filter *fl = &dfsdm->fl_list[i];
> +
> +		fl->id = i;
> +	}
> +
> +	platform_set_drvdata(pdev, dfsdm);
> +
> +	return of_platform_populate(pnode, NULL, NULL, &pdev->dev);
> +}
> +
> +static struct platform_driver stm32_dfsdm_driver = {
> +	.probe = stm32_dfsdm_probe,
> +	.remove = stm32_dfsdm_remove,
> +	.driver = {
> +		.name = "stm32-dfsdm",
> +		.of_match_table = stm32_dfsdm_of_match,
> +	},
> +};
> +
> +module_platform_driver(stm32_dfsdm_driver);
> +
> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 dfsdm driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/adc/stm32-dfsdm.h b/drivers/iio/adc/stm32-dfsdm.h
> new file mode 100644
> index 0000000..38ab15e
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-dfsdm.h
> @@ -0,0 +1,141 @@
> +/*
> + * This file is part of STM32 DFSDM mfd driver
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com>.
> + *
> + * License terms: GPL V2.0.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
> + * details.
> + */
> +#ifndef MDF_STM32_DFSDM__H
> +#define MDF_STM32_DFSDM__H
> +
> +#include <linux/bitfield.h>
> +
> +/*
> + * STM32 DFSDM - global register map
> + * ________________________________________________________
> + * | Offset |                 Registers block             |
> + * --------------------------------------------------------
> + * | 0x000  |      CHANNEL 0 + COMMON CHANNEL FIELDS      |
> + * --------------------------------------------------------
> + * | 0x020  |                CHANNEL 1                    |
> + * --------------------------------------------------------
> + * | ...    |                .....                        |
> + * --------------------------------------------------------
> + * | 0x0E0  |                CHANNEL 7                    |
> + * --------------------------------------------------------
> + * | 0x100  |      FILTER  0 + COMMON  FILTER FIELDs      |
> + * --------------------------------------------------------
> + * | 0x200  |                FILTER  1                    |
> + * --------------------------------------------------------
> + * | 0x300  |                FILTER  2                    |
> + * --------------------------------------------------------
> + * | 0x400  |                FILTER  3                    |
> + * --------------------------------------------------------
> + */
> +
> +/*
> + * Channels register definitions
> + */
> +#define DFSDM_CHCFGR1(y)  ((y) * 0x20 + 0x00)
Prefix these to make them a little more specific.
STM32_DFSDM perhaps?
> +#define DFSDM_CHCFGR2(y)  ((y) * 0x20 + 0x04)
> +#define DFSDM_AWSCDR(y)   ((y) * 0x20 + 0x08)
> +#define DFSDM_CHWDATR(y)  ((y) * 0x20 + 0x0C)
> +#define DFSDM_CHDATINR(y) ((y) * 0x20 + 0x10)
> +
> +/* CHCFGR1: Channel configuration register 1 */
> +#define DFSDM_CHCFGR1_SITP_MASK     GENMASK(1, 0)
> +#define DFSDM_CHCFGR1_SITP(v)       FIELD_PREP(DFSDM_CHCFGR1_SITP_MASK, v)
> +#define DFSDM_CHCFGR1_SPICKSEL_MASK GENMASK(3, 2)
> +#define DFSDM_CHCFGR1_SPICKSEL(v)   FIELD_PREP(DFSDM_CHCFGR1_SPICKSEL_MASK, v)
> +#define DFSDM_CHCFGR1_SCDEN_MASK    BIT(5)
> +#define DFSDM_CHCFGR1_SCDEN(v)      FIELD_PREP(DFSDM_CHCFGR1_SCDEN_MASK, v)
> +#define DFSDM_CHCFGR1_CKABEN_MASK   BIT(6)
> +#define DFSDM_CHCFGR1_CKABEN(v)     FIELD_PREP(DFSDM_CHCFGR1_CKABEN_MASK, v)
> +#define DFSDM_CHCFGR1_CHEN_MASK     BIT(7)
> +#define DFSDM_CHCFGR1_CHEN(v)       FIELD_PREP(DFSDM_CHCFGR1_CHEN_MASK, v)
> +#define DFSDM_CHCFGR1_CHINSEL_MASK  BIT(8)
> +#define DFSDM_CHCFGR1_CHINSEL(v)    FIELD_PREP(DFSDM_CHCFGR1_CHINSEL_MASK, v)
> +#define DFSDM_CHCFGR1_DATMPX_MASK   GENMASK(13, 12)
> +#define DFSDM_CHCFGR1_DATMPX(v)     FIELD_PREP(DFSDM_CHCFGR1_DATMPX_MASK, v)
> +#define DFSDM_CHCFGR1_DATPACK_MASK  GENMASK(15, 14)
> +#define DFSDM_CHCFGR1_DATPACK(v)    FIELD_PREP(DFSDM_CHCFGR1_DATPACK_MASK, v)
> +#define DFSDM_CHCFGR1_CKOUTDIV_MASK GENMASK(23, 16)
> +#define DFSDM_CHCFGR1_CKOUTDIV(v)   FIELD_PREP(DFSDM_CHCFGR1_CKOUTDIV_MASK, v)
> +#define DFSDM_CHCFGR1_CKOUTSRC_MASK BIT(30)
> +#define DFSDM_CHCFGR1_CKOUTSRC(v)   FIELD_PREP(DFSDM_CHCFGR1_CKOUTSRC_MASK, v)
> +#define DFSDM_CHCFGR1_DFSDMEN_MASK  BIT(31)
> +#define DFSDM_CHCFGR1_DFSDMEN(v)    FIELD_PREP(DFSDM_CHCFGR1_DFSDMEN_MASK, v)
> +
> +/*
> + * Filters register definitions
> + */
> +#define DFSDM_FILTER_BASE_ADR		0x100
> +#define DFSDM_FILTER_REG_MASK		0x7F
> +#define DFSDM_FILTER_X_BASE_ADR(x)	((x) * 0x80 + DFSDM_FILTER_BASE_ADR)
> +
> +#define DFSDM_CR1(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x00)
> +#define DFSDM_CR2(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x04)
> +#define DFSDM_ISR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x08)
> +#define DFSDM_ICR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x0C)
> +#define DFSDM_JCHGR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x10)
> +#define DFSDM_FCR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x14)
> +#define DFSDM_JDATAR(x)  (DFSDM_FILTER_X_BASE_ADR(x)  + 0x18)
> +#define DFSDM_RDATAR(x)  (DFSDM_FILTER_X_BASE_ADR(x)  + 0x1C)
> +#define DFSDM_AWHTR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x20)
> +#define DFSDM_AWLTR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x24)
> +#define DFSDM_AWSR(x)    (DFSDM_FILTER_X_BASE_ADR(x)  + 0x28)
> +#define DFSDM_AWCFR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x2C)
> +#define DFSDM_EXMAX(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x30)
> +#define DFSDM_EXMIN(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x34)
> +#define DFSDM_CNVTIMR(x) (DFSDM_FILTER_X_BASE_ADR(x)  + 0x38)
> +
> +/**
> + * struct stm32_dfsdm_filter - structure relative to stm32 FDSDM filter
> + * TODO: complete structure.
> + * @id:		filetr ID,
> + */
> +struct stm32_dfsdm_filter {
> +	unsigned int id;
> +};
> +
> +/**
> + * struct stm32_dfsdm_channel - structure relative to stm32 FDSDM channel
> + * TODO: complete structure.
> + * @id:		filetr ID,
filter?
> + */
> +struct stm32_dfsdm_channel {
> +	unsigned int id;
> +};
> +
> +/**
> + * struct stm32_dfsdm - stm32 FDSDM driver common data (for all instances)
> + * @base:	control registers base cpu addr
> + * @phys_base:	DFSDM IP register physical address.
> + * @fl_list:	filter resources list
> + * @num_fl:	number of filter resources available
> + * @ch_list:	channel resources list
> + * @num_chs:	number of channel resources available
> + */
> +struct stm32_dfsdm {
> +	void __iomem	*base;
> +	phys_addr_t	phys_base;
> +	struct stm32_dfsdm_filter *fl_list;
> +	int num_fls;
> +	struct stm32_dfsdm_channel *ch_list;
> +	int num_chs;
> +};
> +
> +int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm);
> +int stm32_dfsdm_stop_dfsdm(struct stm32_dfsdm *dfsdm);
> +
> +#endif
> 

