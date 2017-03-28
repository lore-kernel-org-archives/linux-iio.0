Return-Path: <SRS0=46q2=3F=st.com=arnaud.pouliquen@kernel.org>
Subject: Re: [PATCH v3 06/11] IIO: ADC: add stm32 DFSDM support for PDM
 microphone
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-7-git-send-email-arnaud.pouliquen@st.com>
 <6dd34cfb-dc86-906b-b309-23d96e172c10@kernel.org>
 <33699891-e102-1967-f47b-46a22e79a251@st.com>
 <35e8a42e-3703-692e-6023-8498bebeb837@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE
	<alexandre.torgue@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <44b86aac-a24c-f39e-8613-f14ba94da9f0@st.com>
Date: Tue, 28 Mar 2017 09:45:51 +0200
MIME-Version: 1.0
In-Reply-To: <35e8a42e-3703-692e-6023-8498bebeb837@kernel.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>



On 03/25/2017 04:59 PM, Jonathan Cameron wrote:
> On 20/03/17 11:29, Arnaud Pouliquen wrote:
>> Please find my comments in-line
>>
>> Thanks and Regards,
>> Arnaud
>>
>> On 03/19/2017 11:38 PM, Jonathan Cameron wrote:
>>> On 17/03/17 14:08, Arnaud Pouliquen wrote:
>>>> Add DFSDM driver to handle PDM audio microphones.
>>>>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>> So key element here is that we really need to have a proper way of
>>> doing DMA buffer consumers from IIO (as you said in your cover letter).
>>>
>>> Not entirely obvious how to do this.  Would like some input from Lars
>>> if possible.  I'm afraid I don't have an suitable hardware to try anything
>>> out on (or the time really!).  This will obviously be quite different from
>>> the single scan stuff you have seen is there at the moment.
>> I saw 2 other drivers ti_am335x_adc.c and stm32_adc.c) that use cyclic
>> DMA. I suppose that problematics are similar. Perhaps the extra
>> constrains in DFSDM is the in-kernel API used to get the data.
> Absolutely.  Cyclic dma is becoming more and more common on SoC ADCs.
> There are a few more fpga based ones in Analog devices tree as well -
> most of those actually do the dma buffer route rather than pushing through
> the normal buffer interface (kfifo effectively).  Right now we just
> don't have any means of accessing these dma buffers in kernel.
> 
> Unlike the normal consumer interface, I doubt we'll want to do demuxing
> of the stream for this sort of usecase - feels like exclusive use is more
> likely.
>>
>>>
>>> Whether this whole approach makes sense vs doing the dma in the alsa driver
>>> isn't clear to me.
>>>
>>> On the plus side, presumably we'll get love dma ADC support for free
>>> as part of doing it this way ;)
>>>
>>> It's been a while since I looked at the IIO dma buffer stuff at all. Will
>>> try and refresh my memory sometime this week.
>>
>> Ok, i will wait your feedback (and Lars's one) before updating my code
>> for next version.
> It may well be the case that it will take us sometime (when I say us, I mean
> you and Lars ;) to pin down how to do dma buffer consumers, so it may be
> a case of taking the driver in a state close to the current one with the
> intent to switch to a generic way of handling it later.

I had a short discussion with Lars on IIO IRC, seems that he also does
not see a straightforward solution for this IP.
The Fact that audio part is in a separate file should help to rework it
in a generic way.
So i will propose a V4 for upstream, integrating discussed fixes.

Thanks
Arnaud


> 
> As long as bindings and userspace don't change we can of course mess with
> anything we like.
> 
> Jonathan
>>>
>>> Jonathan
>>>> ---
>>>>  drivers/iio/adc/Kconfig                   |  13 +
>>>>  drivers/iio/adc/Makefile                  |   1 +
>>>>  drivers/iio/adc/stm32-dfsdm-audio.c       | 720 ++++++++++++++++++++++++++++++
>>>>  include/linux/iio/adc/stm32-dfsdm-audio.h |  41 ++
>>>>  4 files changed, 775 insertions(+)
>>>>  create mode 100644 drivers/iio/adc/stm32-dfsdm-audio.c
>>>>  create mode 100644 include/linux/iio/adc/stm32-dfsdm-audio.h
>>>>
>>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>>> index 3e0eb11..c108933 100644
>>>> --- a/drivers/iio/adc/Kconfig
>>>> +++ b/drivers/iio/adc/Kconfig
>>>> @@ -478,6 +478,19 @@ config STM32_DFSDM_ADC
>>>>  	  This driver can also be built as a module.  If so, the module
>>>>  	  will be called stm32-dfsdm-adc.
>>>>  
>>>> +config STM32_DFSDM_AUDIO
>>>> +	tristate "STMicroelectronics STM32 dfsdm audio
>>>> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>>>> +	select STM32_DFSDM_CORE
>>>> +	select REGMAP_MMIO
>>>> +	select IIO_BUFFER_DMAENGINE
>>>> +	help
>>>> +	  Select this option to support Audio PDM micophone for
>>>> +	  STMicroelectronics  STM32 digital filter for sigma delta converter.
>>>> +
>>>> +	  This driver can also be built as a module.  If so, the module
>>>> +	  will be called stm32-dfsdm-audio.
>>>> +
>>>>  config STX104
>>>>  	tristate "Apex Embedded Systems STX104 driver"
>>>>  	depends on X86 && ISA_BUS_API
>>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>>> index 161f271..79f975d 100644
>>>> --- a/drivers/iio/adc/Makefile
>>>> +++ b/drivers/iio/adc/Makefile
>>>> @@ -44,6 +44,7 @@ obj-$(CONFIG_STX104) += stx104.o
>>>>  obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>>>>  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
>>>>  obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
>>>> +obj-$(CONFIG_STM32_DFSDM_AUDIO) += stm32-dfsdm-audio.o
>>>>  obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
>>>>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>>>>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>>>> diff --git a/drivers/iio/adc/stm32-dfsdm-audio.c b/drivers/iio/adc/stm32-dfsdm-audio.c
>>>> new file mode 100644
>>>> index 0000000..115ef8f
>>>> --- /dev/null
>>>> +++ b/drivers/iio/adc/stm32-dfsdm-audio.c
>>>> @@ -0,0 +1,720 @@
>>>> +/*
>>>> + * This file is the ADC part of of the STM32 DFSDM driver
>>>> + *
>>>> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>>>> + * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
>>>> + *
>>>> + * License type: GPLv2
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify it
>>>> + * under the terms of the GNU General Public License version 2 as published by
>>>> + * the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful, but
>>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
>>>> + * or FITNESS FOR A PARTICULAR PURPOSE.
>>>> + * See the GNU General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU General Public License along with
>>>> + * this program. If not, see <http://www.gnu.org/licenses/>.
>>>> + */
>>>> +
>>>> +#include <linux/dmaengine.h>
>>>> +#include <linux/dma-mapping.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/slab.h>
>>>> +
>>>> +#include <linux/iio/buffer.h>
>>>> +#include <linux/iio/hw_consumer.h>
>>>> +#include <linux/iio/sysfs.h>
>>>> +#include <linux/iio/trigger.h>
>>>> +#include <linux/iio/trigger_consumer.h>
>>>> +#include <linux/iio/triggered_buffer.h>
>>>> +
>>>> +#include "stm32-dfsdm.h"
>>>> +
>>>> +#define DFSDM_DMA_BUFFER_SIZE (4 * PAGE_SIZE)
>>>> +
>>>> +struct stm32_dfsdm_audio {
>>>> +	struct stm32_dfsdm *dfsdm;
>>>> +	unsigned int fl_id;
>>>> +	unsigned int ch_id;
>>>> +	unsigned int spi_freq;  /* SPI bus clock frequency */
>>>> +	unsigned int sample_freq; /* Sample frequency after filter decimation */
>>>> +
>>>> +	u8 *rx_buf;
>>>> +	unsigned int bufi; /* Buffer current position */
>>>> +	unsigned int buf_sz; /* Buffer size */
>>>> +
>>>> +	struct dma_chan	*dma_chan;
>>>> +	dma_addr_t dma_buf;
>>>> +
>>>> +	int (*cb)(const void *data, size_t size, void *cb_priv);
>>>> +	void *cb_priv;
>>>> +};
>>>> +
>>>> +const char *stm32_dfsdm_spi_trigger = DFSDM_SPI_TRIGGER_NAME;
>>>> +
>>>> +static ssize_t dfsdm_audio_get_rate(struct iio_dev *indio_dev, uintptr_t priv,
>>>> +				    const struct iio_chan_spec *chan, char *buf)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +
>>>> +	return snprintf(buf, PAGE_SIZE, "%d\n", pdmc->sample_freq);
>>>> +}
>>>> +
>>>> +static ssize_t dfsdm_audio_set_rate(struct iio_dev *indio_dev, uintptr_t priv,
>>>> +				    const struct iio_chan_spec *chan,
>>>> +				    const char *buf, size_t len)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +	struct stm32_dfsdm_filter *fl = &pdmc->dfsdm->fl_list[pdmc->fl_id];
>>>> +	struct stm32_dfsdm_channel *ch = &pdmc->dfsdm->ch_list[pdmc->ch_id];
>>>> +	unsigned int spi_freq = pdmc->spi_freq;
>>>> +	unsigned int sample_freq;
>>>> +	int ret;
>>>> +
>>>> +	ret = kstrtoint(buf, 0, &sample_freq);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	dev_dbg(&indio_dev->dev, "Requested sample_freq :%d\n", sample_freq);
>>>> +	if (!sample_freq)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (ch->src != DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL)
>>>> +		spi_freq = pdmc->dfsdm->spi_master_freq;
>>>> +
>>>> +	if (spi_freq % sample_freq)
>>>> +		dev_warn(&indio_dev->dev, "Sampling rate not accurate (%d)\n",
>>>> +			 spi_freq / (spi_freq / sample_freq));
>>>> +
>>>> +	ret = stm32_dfsdm_set_osrs(fl, 0, (spi_freq / sample_freq));
>>>> +	if (ret < 0) {
>>>> +		dev_err(&indio_dev->dev,
>>>> +			"Not able to find filter parameter that match!\n");
>>>> +		return ret;
>>>> +	}
>>>> +	pdmc->sample_freq = sample_freq;
>>>> +
>>>> +	return len;
>>>> +}
>>>> +
>>>> +static ssize_t dfsdm_audio_get_spiclk(struct iio_dev *indio_dev, uintptr_t priv,
>>>> +				      const struct iio_chan_spec *chan,
>>>> +				      char *buf)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +
>>>> +	return snprintf(buf, PAGE_SIZE, "%d\n", pdmc->spi_freq);
>>>> +}
>>>> +
>>>> +static ssize_t dfsdm_audio_set_spiclk(struct iio_dev *indio_dev, uintptr_t priv,
>>>> +				      const struct iio_chan_spec *chan,
>>>> +				      const char *buf, size_t len)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +	struct stm32_dfsdm_filter *fl = &pdmc->dfsdm->fl_list[pdmc->fl_id];
>>>> +	struct stm32_dfsdm_channel *ch = &pdmc->dfsdm->ch_list[pdmc->ch_id];
>>>> +	unsigned int sample_freq = pdmc->sample_freq;
>>>> +	unsigned int spi_freq;
>>>> +	int ret;
>>>> +
>>>> +	/* If DFSDM is master on SPI, SPI freq can not be updated */
>>>> +	if (ch->src != DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL)
>>>> +		return -EPERM;
>>>> +
>>>> +	ret = kstrtoint(buf, 0, &spi_freq);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	dev_dbg(&indio_dev->dev, "Requested frequency :%d\n", spi_freq);
>>>> +	if (!spi_freq)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (sample_freq) {
>>>> +		if (spi_freq % sample_freq)
>>>> +			dev_warn(&indio_dev->dev,
>>>> +				 "Sampling rate not accurate (%d)\n",
>>>> +				 spi_freq / (spi_freq / sample_freq));
>>>> +
>>>> +		ret = stm32_dfsdm_set_osrs(fl, 0, (spi_freq / sample_freq));
>>>> +		if (ret < 0) {
>>>> +			dev_err(&indio_dev->dev,
>>>> +				"No filter parameters that match!\n");
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +	pdmc->spi_freq = spi_freq;
>>>> +
>>>> +	return len;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Define external info for SPI Frequency and audio sampling rate that can be
>>>> + * configured by ASoC driver through consumer.h API
>>>> + */
>>>> +static const struct iio_chan_spec_ext_info dfsdm_adc_ext_info[] = {
>>>> +	/* filter oversampling: Post filter oversampling ratio */
>>>> +	{
>>>> +		.name = "audio_sampling_rate",
>>>> +		.shared = IIO_SHARED_BY_TYPE,
>>>> +		.read = dfsdm_audio_get_rate,
>>>> +		.write = dfsdm_audio_set_rate,
>>>> +	},
>>>> +	/* data_right_bit_shift : Filter output data shifting */
>>>> +	{
>>>> +		.name = "spi_clk_freq",
>>>> +		.shared = IIO_SHARED_BY_TYPE,
>>>> +		.read = dfsdm_audio_get_spiclk,
>>>> +		.write = dfsdm_audio_set_spiclk,
>>>> +	},
>>>> +	{},
>>>> +};
>>>> +
>>>> +static int stm32_dfsdm_start_conv(struct stm32_dfsdm_audio *pdmc, bool single)
>>>> +{
>>>> +	struct regmap *regmap = pdmc->dfsdm->regmap;
>>>> +	int ret;
>>>> +
>>>> +	ret = stm32_dfsdm_start_dfsdm(pdmc->dfsdm);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = stm32_dfsdm_start_channel(pdmc->dfsdm, pdmc->ch_id);
>>>> +	if (ret < 0)
>>>> +		goto stop_dfsdm;
>>>> +
>>>> +	ret = stm32_dfsdm_filter_configure(pdmc->dfsdm, pdmc->fl_id,
>>>> +					   pdmc->ch_id);
>>>> +	if (ret < 0)
>>>> +		goto stop_channels;
>>>> +
>>>> +	/* Enable DMA transfer*/
>>>> +	ret = regmap_update_bits(regmap, DFSDM_CR1(pdmc->fl_id),
>>>> +				 DFSDM_CR1_RDMAEN_MASK, DFSDM_CR1_RDMAEN(1));
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	/* Enable conversion triggered by SPI clock*/
>>>> +	ret = regmap_update_bits(regmap, DFSDM_CR1(pdmc->fl_id),
>>>> +				 DFSDM_CR1_RCONT_MASK,  DFSDM_CR1_RCONT(1));
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = stm32_dfsdm_start_filter(pdmc->dfsdm, pdmc->fl_id);
>>>> +	if (ret < 0)
>>>> +		goto stop_channels;
>>>> +
>>>> +	return 0;
>>>> +
>>>> +stop_channels:
>>>> +	stm32_dfsdm_stop_channel(pdmc->dfsdm, pdmc->fl_id);
>>>> +stop_dfsdm:
>>>> +	stm32_dfsdm_stop_dfsdm(pdmc->dfsdm);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_audio *pdmc)
>>>> +{
>>>> +	stm32_dfsdm_stop_filter(pdmc->dfsdm, pdmc->fl_id);
>>>> +
>>>> +	stm32_dfsdm_stop_channel(pdmc->dfsdm, pdmc->ch_id);
>>>> +
>>>> +	stm32_dfsdm_stop_dfsdm(pdmc->dfsdm);
>>>> +}
>>>> +
>>>> +static int stm32_dfsdm_set_watermark(struct iio_dev *indio_dev,
>>>> +				     unsigned int val)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +	unsigned int watermark = DFSDM_DMA_BUFFER_SIZE / 2;
>>>> +
>>>> +	/*
>>>> +	 * DMA cyclic transfers are used, buffer is split into two periods.
>>>> +	 * There should be :
>>>> +	 * - always one buffer (period) DMA is working on
>>>> +	 * - one buffer (period) driver pushed to ASoC side ().
>>>> +	 */
>>>> +	watermark = min(watermark, val * (unsigned int)(sizeof(u32)));
>>>> +	pdmc->buf_sz = watermark * 2;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int stm32_dfsdm_validate_trigger(struct iio_dev *indio_dev,
>>>> +				 struct iio_trigger *trig)
>>>> +{
>>>> +	if (!strcmp(stm32_dfsdm_spi_trigger, trig->name))
>>>> +		return 0;
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>> +
>>>> +static const struct iio_info stm32_dfsdm_info_pdmc = {
>>>> +	.hwfifo_set_watermark = stm32_dfsdm_set_watermark,
>>>> +	.driver_module = THIS_MODULE,
>>>> +	.validate_trigger = stm32_dfsdm_validate_trigger,
>>>> +};
>>>> +
>>>> +static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = arg;
>>>> +	struct iio_dev *indio_dev = iio_priv_to_dev(pdmc);
>>>> +	struct regmap *regmap = pdmc->dfsdm->regmap;
>>>> +	unsigned int status;
>>>> +
>>>> +	regmap_read(regmap, DFSDM_ISR(pdmc->fl_id), &status);
>>>> +
>>>> +	if (status & DFSDM_ISR_ROVRF_MASK) {
>>>> +		dev_err(&indio_dev->dev, "Unexpected Conversion overflow\n");
>>>> +		regmap_update_bits(regmap, DFSDM_ICR(pdmc->fl_id),
>>>> +				   DFSDM_ICR_CLRROVRF_MASK,
>>>> +				   DFSDM_ICR_CLRROVRF_MASK);
>>>> +	}
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static unsigned int stm32_dfsdm_audio_avail_data(struct stm32_dfsdm_audio *pdmc)
>>>> +{
>>>> +	struct dma_tx_state state;
>>>> +	enum dma_status status;
>>>> +
>>>> +	status = dmaengine_tx_status(pdmc->dma_chan,
>>>> +				     pdmc->dma_chan->cookie,
>>>> +				     &state);
>>>> +	if (status == DMA_IN_PROGRESS) {
>>>> +		/* Residue is size in bytes from end of buffer */
>>>> +		unsigned int i = pdmc->buf_sz - state.residue;
>>>> +		unsigned int size;
>>>> +
>>>> +		/* Return available bytes */
>>>> +		if (i >= pdmc->bufi)
>>>> +			size = i - pdmc->bufi;
>>>> +		else
>>>> +			size = pdmc->buf_sz + i - pdmc->bufi;
>>>> +
>>>> +		return size;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void stm32_dfsdm_audio_dma_buffer_done(void *data)
>>>> +{
>>>> +	struct iio_dev *indio_dev = data;
>>>> +
>>>> +	iio_trigger_poll_chained(indio_dev->trig);
>>> This shouldn't be going through the trigger infrastructure at all really.
>>> I'm not 100% sure what doing so is gaining you...
>> Yes i will clean trigger part and call directly the ASoC callback here.
>>>> +}
>>>> +
>>>> +static int stm32_dfsdm_audio_dma_start(struct iio_dev *indio_dev)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +	struct dma_async_tx_descriptor *desc;
>>>> +	dma_cookie_t cookie;
>>>> +	int ret;
>>>> +
>>>> +	if (!pdmc->dma_chan)
>>>> +		return -EINVAL;
>>>> +
>>>> +	dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
>>>> +		pdmc->buf_sz, pdmc->buf_sz / 2);
>>>> +
>>>> +	/* Prepare a DMA cyclic transaction */
>>>> +	desc = dmaengine_prep_dma_cyclic(pdmc->dma_chan,
>>>> +					 pdmc->dma_buf,
>>>> +					 pdmc->buf_sz, pdmc->buf_sz / 2,
>>>> +					 DMA_DEV_TO_MEM,
>>>> +					 DMA_PREP_INTERRUPT);
>>>> +	if (!desc)
>>>> +		return -EBUSY;
>>>> +
>>>> +	desc->callback = stm32_dfsdm_audio_dma_buffer_done;
>>>> +	desc->callback_param = indio_dev;
>>>> +
>>>> +	cookie = dmaengine_submit(desc);
>>>> +	ret = dma_submit_error(cookie);
>>>> +	if (ret) {
>>>> +		dmaengine_terminate_all(pdmc->dma_chan);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/* Issue pending DMA requests */
>>>> +	dma_async_issue_pending(pdmc->dma_chan);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +	int ret;
>>>> +
>>>> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>>>> +	/* Reset pdmc buffer index */
>>>> +	pdmc->bufi = 0;
>>>> +
>>>> +	ret = stm32_dfsdm_start_conv(pdmc, false);
>>>> +	if (ret) {
>>>> +		dev_err(&indio_dev->dev, "Can't start conversion\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = stm32_dfsdm_audio_dma_start(indio_dev);
>>>> +	if (ret) {
>>>> +		dev_err(&indio_dev->dev, "Can't start DMA\n");
>>>> +		goto err_stop_conv;
>>>> +	}
>>>> +
>>>> +	ret = iio_triggered_buffer_postenable(indio_dev);
>>>> +	if (ret < 0) {
>>>> +		dev_err(&indio_dev->dev, "%s :%d\n", __func__, __LINE__);
>>>> +		goto err_stop_dma;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err_stop_dma:
>>>> +	if (pdmc->dma_chan)
>>>> +		dmaengine_terminate_all(pdmc->dma_chan);
>>>> +err_stop_conv:
>>>> +	stm32_dfsdm_stop_conv(pdmc);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +	int ret;
>>>> +
>>>> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>>>> +	ret = iio_triggered_buffer_predisable(indio_dev);
>>>> +	if (ret < 0)
>>>> +		dev_err(&indio_dev->dev, "Predisable failed\n");
>>>> +
>>>> +	if (pdmc->dma_chan)
>>>> +		dmaengine_terminate_all(pdmc->dma_chan);
>>>> +
>>>> +	stm32_dfsdm_stop_conv(pdmc);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct iio_buffer_setup_ops stm32_dfsdm_buffer_setup_ops = {
>>>> +	.postenable = &stm32_dfsdm_postenable,
>>>> +	.predisable = &stm32_dfsdm_predisable,
>>>> +};
>>>> +
>>>> +static irqreturn_t stm32_dfsdm_audio_trigger_handler(int irq, void *p)
>>>> +{
>>> OK. So now I kind of understand what the trigger provided in the adc driver
>>> was about.  hmm.  Triggers are supposed to be per sample so this is indeed
>>> a hack.  We need fullblown DMA buffer consumers to do this right.
>> Yes exactly.
>>>
>>> Probably best person to comment on that is Lars. 
>>>> +	struct iio_poll_func *pf = p;
>>>> +	struct iio_dev *indio_dev = pf->indio_dev;
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +	size_t old_pos;
>>>> +	int available = stm32_dfsdm_audio_avail_data(pdmc);
>>>> +
>>>> +	/*
>>>> +	 * Buffer interface is not support cyclic DMA buffer,and offer only
>>>> +	 * an interface to push data samples per samples.
>>>> +	 * For this reason iio_push_to_buffers_with_timestamp in not used
>>>> +	 * and interface is hacked using a private callback registered by ASoC.
>>>> +	 * This should be a temporary solution waiting a cyclic DMA engine
>>>> +	 * support in IIO.
>>>> +	 */
>>>> +
>>>> +	dev_dbg(&indio_dev->dev, "%s: pos = %d, available = %d\n", __func__,
>>>> +		pdmc->bufi, available);
>>>> +	old_pos = pdmc->bufi;
>>>> +	while (available >= indio_dev->scan_bytes) {
>>>> +		u32 *buffer = (u32 *)&pdmc->rx_buf[pdmc->bufi];
>>>> +
>>>> +		/* Mask 8 LSB that contains the channel ID */
>>>> +		*buffer &= 0xFFFFFF00;
>>>> +		available -= indio_dev->scan_bytes;
>>>> +		pdmc->bufi += indio_dev->scan_bytes;
>>>> +		if (pdmc->bufi >= pdmc->buf_sz) {
>>>> +			if (pdmc->cb)
>>>> +				pdmc->cb(&pdmc->rx_buf[old_pos],
>>>> +					 pdmc->buf_sz - old_pos, pdmc->cb_priv);
>>>> +			pdmc->bufi = 0;
>>>> +			old_pos = 0;
>>>> +		}
>>>> +	}
>>>> +	if (pdmc->cb)
>>>> +		pdmc->cb(&pdmc->rx_buf[old_pos], pdmc->bufi - old_pos,
>>>> +				pdmc->cb_priv);
>>>> +
>>>> +	iio_trigger_notify_done(indio_dev->trig);
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +/**
>>>> + * stm32_dfsdm_get_buff_cb - register a callback
>>>> + *	that will be called when DMA transfer period is achieved.
>>>> + *
>>>> + * @iio_dev: Handle to IIO device.
>>>> + * @cb: pointer to callback function.
>>>> + *	@data: pointer to data buffer
>>>> + *	@size: size in byte of the data buffer
>>>> + *	@private: pointer to consumer private structure
>>>> + * @private: pointer to consumer private structure
>>>> + */
>>>> +int stm32_dfsdm_get_buff_cb(struct iio_dev *iio_dev,
>>>> +			    int (*cb)(const void *data, size_t size,
>>>> +				      void *private),
>>>> +			    void *private)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc;
>>>> +
>>>> +	if (!iio_dev)
>>>> +		return -EINVAL;
>>>> +	pdmc = iio_priv(iio_dev);
>>>> +
>>>> +	if (iio_dev !=  iio_priv_to_dev(pdmc))
>>>> +		return -EINVAL;
>>>> +
>>>> +	pdmc->cb = cb;
>>>> +	pdmc->cb_priv = private;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(stm32_dfsdm_get_buff_cb);
>>>> +
>>>> +/**
>>>> + * stm32_dfsdm_release_buff_cb - unregister buffer callback
>>>> + *
>>>> + * @iio_dev: Handle to IIO device.
>>>> + */
>>>> +int stm32_dfsdm_release_buff_cb(struct iio_dev *iio_dev)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc;
>>>> +
>>>> +	if (!iio_dev)
>>>> +		return -EINVAL;
>>>> +	pdmc = iio_priv(iio_dev);
>>>> +
>>>> +	if (iio_dev !=  iio_priv_to_dev(pdmc))
>>>> +		return -EINVAL;
>>>> +	pdmc->cb = NULL;
>>>> +	pdmc->cb_priv = NULL;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(stm32_dfsdm_release_buff_cb);
>>>> +
>>>> +static int stm32_dfsdm_audio_chan_init(struct iio_dev *indio_dev)
>>>> +{
>>>> +	struct iio_chan_spec *ch;
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +	int ret;
>>>> +
>>>> +	ch = devm_kzalloc(&indio_dev->dev, sizeof(*ch), GFP_KERNEL);
>>>> +	if (!ch)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	ret = stm32_dfsdm_channel_parse_of(pdmc->dfsdm, indio_dev, ch, 0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ch->type = IIO_VOLTAGE;
>>>> +	ch->indexed = 1;
>>>> +	ch->scan_index = 0;
>>>> +	ch->ext_info = dfsdm_adc_ext_info;
>>>> +
>>>> +	ch->scan_type.sign = 's';
>>>> +	ch->scan_type.realbits = 24;
>>>> +	ch->scan_type.storagebits = 32;
>>>> +
>>>> +	pdmc->ch_id = ch->channel;
>>>> +	ret = stm32_dfsdm_chan_configure(pdmc->dfsdm,
>>>> +					 &pdmc->dfsdm->ch_list[ch->channel]);
>>>> +
>>>> +	indio_dev->num_channels = 1;
>>>> +	indio_dev->channels = ch;
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static const struct of_device_id stm32_dfsdm_audio_match[] = {
>>>> +	{ .compatible = "st,stm32-dfsdm-audio"},
>>>> +	{}
>>>> +};
>>>> +
>>>> +static int stm32_dfsdm_audio_dma_request(struct iio_dev *indio_dev)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = iio_priv(indio_dev);
>>>> +	struct dma_slave_config config;
>>>> +	int ret;
>>>> +
>>>> +	pdmc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
>>>> +	if (!pdmc->dma_chan)
>>>> +		return -EINVAL;
>>>> +
>>>> +	pdmc->rx_buf = dma_alloc_coherent(pdmc->dma_chan->device->dev,
>>>> +					 DFSDM_DMA_BUFFER_SIZE,
>>>> +					 &pdmc->dma_buf, GFP_KERNEL);
>>>> +	if (!pdmc->rx_buf) {
>>>> +		ret = -ENOMEM;
>>>> +		goto err_release;
>>>> +	}
>>>> +
>>>> +	/* Configure DMA channel to read data register */
>>>> +	memset(&config, 0, sizeof(config));
>>>> +	config.src_addr = (dma_addr_t)pdmc->dfsdm->phys_base;
>>>> +	config.src_addr += DFSDM_RDATAR(pdmc->fl_id);
>>>> +	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>>> +
>>>> +	ret = dmaengine_slave_config(pdmc->dma_chan, &config);
>>>> +	if (ret)
>>>> +		goto err_free;
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err_free:
>>>> +	dma_free_coherent(pdmc->dma_chan->device->dev, DFSDM_DMA_BUFFER_SIZE,
>>>> +			  pdmc->rx_buf, pdmc->dma_buf);
>>>> +err_release:
>>>> +	dma_release_channel(pdmc->dma_chan);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int stm32_dfsdm_audio_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct device *dev = &pdev->dev;
>>>> +	struct stm32_dfsdm_audio *pdmc;
>>>> +	struct device_node *np = dev->of_node;
>>>> +	struct iio_dev *iio;
>>>> +	char *name;
>>>> +	int ret, irq, val;
>>>> +
>>>> +	iio = devm_iio_device_alloc(dev, sizeof(*pdmc));
>>>> +	if (IS_ERR(iio)) {
>>>> +		dev_err(dev, "%s: Failed to allocate IIO\n", __func__);
>>>> +		return PTR_ERR(iio);
>>>> +	}
>>>> +
>>>> +	pdmc = iio_priv(iio);
>>>> +	if (IS_ERR(pdmc)) {
>>>> +		dev_err(dev, "%s: Failed to allocate ADC\n", __func__);
>>>> +		return PTR_ERR(pdmc);
>>>> +	}
>>>> +	pdmc->dfsdm = dev_get_drvdata(dev->parent);
>>>> +
>>>> +	iio->name = np->name;
>>>> +	iio->dev.parent = dev;
>>>> +	iio->dev.of_node = np;
>>>> +	iio->info = &stm32_dfsdm_info_pdmc;
>>>> +	iio->modes = INDIO_DIRECT_MODE;
>>>> +
>>>> +	platform_set_drvdata(pdev, pdmc);
>>>> +
>>>> +	ret = of_property_read_u32(dev->of_node, "reg", &pdmc->fl_id);
>>>> +	if (ret != 0) {
>>>> +		dev_err(dev, "Missing reg property\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	name = kzalloc(sizeof("dfsdm-pdm0"), GFP_KERNEL);
>>>> +	if (!name)
>>>> +		return -ENOMEM;
>>>> +	snprintf(name, sizeof("dfsdm-pdm0"), "dfsdm-pdm%d", pdmc->fl_id);
>>>> +	iio->name = name;
>>>> +
>>>> +	/*
>>>> +	 * In a first step IRQs generated for channels are not treated.
>>>> +	 * So IRQ associated to filter instance 0 is dedicated to the Filter 0.
>>>> +	 */
>>>> +	irq = platform_get_irq(pdev, 0);
>>>> +	ret = devm_request_irq(dev, irq, stm32_dfsdm_irq,
>>>> +			       0, pdev->name, pdmc);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dev, "Failed to request IRQ\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = of_property_read_u32(dev->of_node, "st,filter-order", &val);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dev, "Failed to set filter order\n");
>>>> +		return ret;
>>>> +	}
>>>> +	pdmc->dfsdm->fl_list[pdmc->fl_id].ford = val;
>>>> +
>>>> +	ret = of_property_read_u32(dev->of_node, "st,filter0-sync", &val);
>>>> +	if (!ret)
>>>> +		pdmc->dfsdm->fl_list[pdmc->fl_id].sync_mode = val;
>>>> +
>>>> +	ret = stm32_dfsdm_audio_chan_init(iio);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = stm32_dfsdm_audio_dma_request(iio);
>>>> +	if (ret) {
>>>> +		dev_err(&pdev->dev, "DMA request failed\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	iio->modes |= INDIO_BUFFER_SOFTWARE;
>>>> +
>>>> +	ret = iio_triggered_buffer_setup(iio,
>>>> +					 &iio_pollfunc_store_time,
>>>> +					 &stm32_dfsdm_audio_trigger_handler,
>>>> +					 &stm32_dfsdm_buffer_setup_ops);
>>>> +	if (ret) {
>>>> +		dev_err(&pdev->dev, "Buffer setup failed\n");
>>>> +		goto err_dma_disable;
>>>> +	}
>>>> +
>>>> +	ret = iio_device_register(iio);
>>>> +	if (ret) {
>>>> +		dev_err(&pdev->dev, "IIO dev register failed\n");
>>>> +		goto err_buffer_cleanup;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err_buffer_cleanup:
>>>> +	iio_triggered_buffer_cleanup(iio);
>>>> +
>>>> +err_dma_disable:
>>>> +	if (pdmc->dma_chan) {
>>>> +		dma_free_coherent(pdmc->dma_chan->device->dev,
>>>> +				  DFSDM_DMA_BUFFER_SIZE,
>>>> +				  pdmc->rx_buf, pdmc->dma_buf);
>>>> +		dma_release_channel(pdmc->dma_chan);
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int stm32_dfsdm_audio_remove(struct platform_device *pdev)
>>>> +{
>>>> +	struct stm32_dfsdm_audio *pdmc = platform_get_drvdata(pdev);
>>>> +	struct iio_dev *iio = iio_priv_to_dev(pdmc);
>>>> +
>>>> +	iio_device_unregister(iio);
>>> Same as in the other driver. Can just use the devm_iio_device_register
>>> version and drop remove.
>> oops missing the previous comment... sorry.
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static struct platform_driver stm32_dfsdm_audio_driver = {
>>>> +	.driver = {
>>>> +		.name = "stm32-dfsdm-audio",
>>>> +		.of_match_table = stm32_dfsdm_audio_match,
>>>> +	},
>>>> +	.probe = stm32_dfsdm_audio_probe,
>>>> +	.remove = stm32_dfsdm_audio_remove,
>>>> +};
>>>> +module_platform_driver(stm32_dfsdm_audio_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("STM32 sigma delta converter for PDM microphone");
>>>> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/include/linux/iio/adc/stm32-dfsdm-audio.h b/include/linux/iio/adc/stm32-dfsdm-audio.h
>>>> new file mode 100644
>>>> index 0000000..9b41b28
>>>> --- /dev/null
>>>> +++ b/include/linux/iio/adc/stm32-dfsdm-audio.h
>>>> @@ -0,0 +1,41 @@
>>>> +/*
>>>> + * This file discribe the STM32 DFSDM IIO driver API for audio part
>>>> + *
>>>> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>>>> + * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com>.
>>>> + *
>>>> + * License terms: GPL V2.0.
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify it
>>>> + * under the terms of the GNU General Public License version 2 as published by
>>>> + * the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful, but
>>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
>>>> + * details.
>>>> + */
>>>> +#ifndef STM32_DFSDM_AUDIO_H
>>>> +#define STM32_DFSDM_AUDIO_H
>>>> +
>>>> +/**
>>>> + * stm32_dfsdm_get_buff_cb() - register callback for capture buffer period.
>>>> + * @dev:	Pointer to client device.
>>>> + * @indio_dev:	Device on which the channel exists.
>>>> + * @cb:		Callback function.
>>>> + *		@data:  pointer to data buffer
>>>> + *		@size: size of the data buffer in bytes
>>>> + * @private:	Private data passed to callback.
>>>> + *
>>>> + */
>>>> +int stm32_dfsdm_get_buff_cb(struct iio_dev *iio_dev,
>>>> +			    int (*cb)(const void *data, size_t size,
>>>> +				      void *private),
>>>> +			    void *private);
>>>> +/**
>>>> + * stm32_dfsdm_get_buff_cb() - release callback for capture buffer period.
>>>> + * @indio_dev:	Device on which the channel exists.
>>>> + */
>>>> +int stm32_dfsdm_release_buff_cb(struct iio_dev *iio_dev);
>>>> +
>>>> +#endif
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
