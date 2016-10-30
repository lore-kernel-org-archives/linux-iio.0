Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42556 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbcJ3PeT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 11:34:19 -0400
Subject: Re: [PATCH 03/10] iio: adc: stm32: add optional dma support
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
 <1477412722-24061-4-git-send-email-fabrice.gasnier@st.com>
Cc: linux@armlinux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dc2b9c32-30f0-24b4-f11e-571b6cb130b3@kernel.org>
Date: Sun, 30 Oct 2016 15:34:16 +0000
MIME-Version: 1.0
In-Reply-To: <1477412722-24061-4-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/16 17:25, Fabrice Gasnier wrote:
> Add optional DMA support to STM32 ADC.
> Use dma cyclic mode with at least two periods.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Few little bits inline, but looks superficially good (my dma knowledge isn't
really up to reviewing this.) Lars can you take a look (perhaps at the next
version)?

Also, you 'could' potentially use the dma buffer stuff to give a lower overhead
route for the data to userspace if the device goes quick enough to warrant
it.

Jonathan
> ---
>  drivers/iio/adc/stm32/Kconfig       |   2 +
>  drivers/iio/adc/stm32/stm32-adc.c   | 222 ++++++++++++++++++++++++++++++++----
>  drivers/iio/adc/stm32/stm32-adc.h   |  15 +++
>  drivers/iio/adc/stm32/stm32f4-adc.c |  20 +++-
>  4 files changed, 235 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32/Kconfig b/drivers/iio/adc/stm32/Kconfig
> index 245d037..5554ac8 100644
> --- a/drivers/iio/adc/stm32/Kconfig
> +++ b/drivers/iio/adc/stm32/Kconfig
> @@ -8,6 +8,7 @@ config STM32_ADC
>  	select REGULATOR_FIXED_VOLTAGE
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select IRQ_WORK
>  	help
>  	  Say yes here to build the driver for the STMicroelectronics
>  	  STM32 analog-to-digital converter (ADC).
> @@ -18,6 +19,7 @@ config STM32_ADC
>  config STM32F4_ADC
>  	tristate "STMicroelectronics STM32F4 adc"
>  	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on HAS_DMA
>  	depends on OF
>  	select STM32_ADC
>  	help
> diff --git a/drivers/iio/adc/stm32/stm32-adc.c b/drivers/iio/adc/stm32/stm32-adc.c
> index 1e0850d..25d0307 100644
> --- a/drivers/iio/adc/stm32/stm32-adc.c
> +++ b/drivers/iio/adc/stm32/stm32-adc.c
> @@ -21,6 +21,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/debugfs.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
> @@ -371,6 +372,34 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int stm32_adc_residue(struct stm32_adc *adc)
> +{
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	if (!adc->rx_buf)
> +		return 0;
> +
> +	status = dmaengine_tx_status(adc->dma_chan,
> +				     adc->dma_chan->cookie,
> +				     &state);
> +	if (status == DMA_IN_PROGRESS) {
> +		/* Residue is size in bytes from end of buffer */
> +		int i = adc->rx_buf_sz - state.residue;
> +		int size;
> +
> +		/* Return available bytes */
> +		if (i >= adc->bufi)
> +			size = i - adc->bufi;
> +		else
> +			size = adc->rx_buf_sz - adc->bufi + i;
> +
> +		return size;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * stm32_adc_isr() - Treat interrupt for one ADC instance within ADC block
>   */
> @@ -394,8 +423,8 @@ static irqreturn_t stm32_adc_isr(struct stm32_adc *adc)
>  	stm32_adc_writel(adc, reginfo->isr, status & ~clr_mask);
>  	status &= mask;
>  
> -	/* Regular data */
> -	if (status & reginfo->eoc) {
> +	/* Regular data (when dma isn't used) */
> +	if ((status & reginfo->eoc) && (!adc->rx_buf)) {
>  		adc->buffer[adc->bufi] = stm32_adc_readl(adc, reginfo->dr);
>  		if (iio_buffer_enabled(indio_dev)) {
>  			adc->bufi++;
> @@ -553,29 +582,154 @@ static int stm32_adc_validate_device(struct iio_trigger *trig,
>  	return indio != indio_dev ? -EINVAL : 0;
>  }
>  
> -static int stm32_adc_set_trigger_state(struct iio_trigger *trig,
> -				       bool state)
> +static void stm32_adc_dma_irq_work(struct irq_work *work)
>  {
> -	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct stm32_adc *adc = container_of(work, struct stm32_adc, work);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +
> +	/**
> +	 * iio_trigger_poll calls generic_handle_irq(). So, it requires hard
> +	 * irq context, and cannot be called directly from dma callback,
> +	 * dma cb has to schedule this work instead.
> +	 */
> +	iio_trigger_poll(indio_dev->trig);
> +}
> +
> +static void stm32_adc_dma_buffer_done(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
>  	struct stm32_adc *adc = iio_priv(indio_dev);
> -	int ret;
>  
> -	if (state) {
> -		/* Reset adc buffer index */
> -		adc->bufi = 0;
> +	/* invoques iio_trigger_poll() from hard irq context */
invokes.
> +	irq_work_queue(&adc->work);
> +}
> +
> +static int stm32_adc_buffer_alloc_dma_start(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	const struct stm32_adc_reginfo *reginfo =
> +		adc->common->data->adc_reginfo;
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_slave_config config;
> +	dma_cookie_t cookie;
> +	int ret, size, watermark;
>  
> +	/* Reset adc buffer index */
> +	adc->bufi = 0;
> +
> +	if (!adc->dma_chan) {
>  		/* Allocate adc buffer */
>  		adc->buffer = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
>  		if (!adc->buffer)
>  			return -ENOMEM;
>  
> +		return 0;
> +	}
> +
> +	/*
> +	 * Allocate at least twice the buffer size for dma cyclic transfers, so
> +	 * we can work with at least two dma periods. There should be :
> +	 * - always one buffer (period) dma is working on
> +	 * - one buffer (period) driver can push with iio_trigger_poll().
> +	 */
> +	size = indio_dev->buffer->bytes_per_datum * indio_dev->buffer->length;
> +	size = max(indio_dev->scan_bytes * 2, size);
> +
> +	adc->rx_buf = dma_alloc_coherent(adc->common->dev, PAGE_ALIGN(size),
> +					 &adc->rx_dma_buf,
> +					 GFP_KERNEL);
> +	if (!adc->rx_buf)
> +		return -ENOMEM;
> +	adc->rx_buf_sz = size;
> +	watermark = indio_dev->buffer->bytes_per_datum
> +		* indio_dev->buffer->watermark;
> +	watermark = max(indio_dev->scan_bytes, watermark);
> +	watermark = rounddown(watermark, indio_dev->scan_bytes);
> +
> +	dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__, size,
> +		watermark);
> +
> +	/* Configure DMA channel to read data register */
> +	memset(&config, 0, sizeof(config));
> +	config.src_addr = (dma_addr_t)adc->common->phys_base;
> +	config.src_addr += adc->offset + reginfo->dr;
> +	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +
> +	ret = dmaengine_slave_config(adc->dma_chan, &config);
> +	if (ret)
> +		goto config_err;
> +
> +	/* Prepare a DMA cyclic transaction */
> +	desc = dmaengine_prep_dma_cyclic(adc->dma_chan,
> +					 adc->rx_dma_buf,
> +					 size, watermark,
> +					 DMA_DEV_TO_MEM,
> +					 DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		ret = -ENODEV;
> +		goto config_err;
> +	}
> +
> +	desc->callback = stm32_adc_dma_buffer_done;
> +	desc->callback_param = indio_dev;
> +
> +	cookie = dmaengine_submit(desc);
> +	if (dma_submit_error(cookie)) {
> +		ret = dma_submit_error(cookie);
> +		goto config_err;
> +	}
> +
> +	/* Issue pending DMA requests */
> +	dma_async_issue_pending(adc->dma_chan);
> +
> +	return 0;
> +
> +config_err:
> +	dma_free_coherent(adc->common->dev, PAGE_ALIGN(size), adc->rx_buf,
> +			  adc->rx_dma_buf);
> +
> +	return ret;
> +}
> +
> +static void stm32_adc_dma_stop_buffer_free(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
> +	if (!adc->dma_chan) {
> +		kfree(adc->buffer);
> +	} else {
> +		dmaengine_terminate_all(adc->dma_chan);
> +		irq_work_sync(&adc->work);
> +		dma_free_coherent(adc->common->dev, PAGE_ALIGN(adc->rx_buf_sz),
> +				  adc->rx_buf, adc->rx_dma_buf);
> +		adc->rx_buf = NULL;
> +	}
> +
> +	adc->buffer = NULL;
> +}
> +
> +static int stm32_adc_set_trigger_state(struct iio_trigger *trig,
> +				       bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (state) {
> +		ret = stm32_adc_buffer_alloc_dma_start(indio_dev);
> +		if (ret) {
> +			dev_err(&indio_dev->dev, "alloc failed\n");
> +			return ret;
> +		}
> +
>  		ret = stm32_adc_set_trig(indio_dev, trig);
>  		if (ret) {
>  			dev_err(&indio_dev->dev, "Can't set trigger\n");
>  			goto err_buffer_free;
>  		}
>  
> -		stm32_adc_conv_irq_enable(adc);
> +		if (!adc->dma_chan)
> +			stm32_adc_conv_irq_enable(adc);
>  
>  		ret = stm32_adc_start_conv(adc);
>  		if (ret) {
> @@ -589,25 +743,25 @@ static int stm32_adc_set_trigger_state(struct iio_trigger *trig,
>  			return ret;
>  		}
>  
> -		stm32_adc_conv_irq_disable(adc);
> +		if (!adc->dma_chan)
> +			stm32_adc_conv_irq_disable(adc);
>  
>  		ret = stm32_adc_set_trig(indio_dev, NULL);
>  		if (ret)
>  			dev_warn(&indio_dev->dev, "Can't clear trigger\n");
>  
> -		kfree(adc->buffer);
> -		adc->buffer = NULL;
> +		stm32_adc_dma_stop_buffer_free(indio_dev);
>  	}
>  
>  	return 0;
>  
>  err_irq_trig_disable:
> -	stm32_adc_conv_irq_disable(adc);
> +	if (!adc->dma_chan)
> +		stm32_adc_conv_irq_disable(adc);
>  	stm32_adc_set_trig(indio_dev, NULL);
>  
>  err_buffer_free:
> -	kfree(adc->buffer);
> -	adc->buffer = NULL;
> +	stm32_adc_dma_stop_buffer_free(indio_dev);
>  
>  	return ret;
>  }
> @@ -624,17 +778,30 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  
> -	dev_dbg(&indio_dev->dev, "%s bufi=%d\n", __func__, adc->bufi);
> -
> -	/* reset buffer index */
> -	adc->bufi = 0;
> -	iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
> -					   pf->timestamp);
> +	if (!adc->dma_chan) {
> +		adc->bufi = 0;
> +		iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
> +						   pf->timestamp);
> +	} else {
> +		int residue = stm32_adc_residue(adc);
> +
This bit wants some explanatory comments I think.
> +		while (residue >= indio_dev->scan_bytes) {
> +			adc->buffer = (u16 *)&adc->rx_buf[adc->bufi];
> +			iio_push_to_buffers_with_timestamp(indio_dev,
> +							   adc->buffer,
> +							   pf->timestamp);
> +			residue -= indio_dev->scan_bytes;
> +			adc->bufi += indio_dev->scan_bytes;
> +			if (adc->bufi >= adc->rx_buf_sz)
> +				adc->bufi = 0;
> +		}
> +	}
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	/* re-enable eoc irq */
> -	stm32_adc_conv_irq_enable(adc);
> +	if (!adc->dma_chan)
> +		stm32_adc_conv_irq_enable(adc);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -827,6 +994,10 @@ static int stm32_adc_register(struct stm32_adc_common *common,
>  	if (ret)
>  		goto err_clk_disable;
>  
> +	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
> +	if (adc->dma_chan)
> +		init_irq_work(&adc->work, stm32_adc_dma_irq_work);
> +
>  	ret = iio_triggered_buffer_setup(indio_dev,
>  					 &iio_pollfunc_store_time,
>  					 &stm32_adc_trigger_handler,
> @@ -850,6 +1021,8 @@ static int stm32_adc_register(struct stm32_adc_common *common,
>  	iio_triggered_buffer_cleanup(indio_dev);
>  
>  err_trig_unregister:
> +	if (adc->dma_chan)
> +		dma_release_channel(adc->dma_chan);
>  	stm32_adc_trig_unregister(indio_dev);
>  
>  err_clk_disable:
> @@ -870,6 +1043,8 @@ static void stm32_adc_unregister(struct stm32_adc *adc)
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	stm32_adc_trig_unregister(indio_dev);
> +	if (adc->dma_chan)
> +		dma_release_channel(adc->dma_chan);
>  	if (adc->clk) {
>  		clk_disable_unprepare(adc->clk);
>  		clk_put(adc->clk);
> @@ -900,6 +1075,7 @@ int stm32_adc_probe(struct platform_device *pdev)
>  	common->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(common->base))
>  		return PTR_ERR(common->base);
> +	common->phys_base = res->start;
>  
>  	common->data = match->data;
>  	common->dev = &pdev->dev;
> diff --git a/drivers/iio/adc/stm32/stm32-adc.h b/drivers/iio/adc/stm32/stm32-adc.h
> index 0be603c..01a0dda 100644
> --- a/drivers/iio/adc/stm32/stm32-adc.h
> +++ b/drivers/iio/adc/stm32/stm32-adc.h
> @@ -22,6 +22,9 @@
>  #ifndef __STM32_ADC_H
>  #define __STM32_ADC_H
>  
> +#include <linux/dmaengine.h>
> +#include <linux/irq_work.h>
> +
>  /*
>   * STM32 - ADC global register map
>   * ________________________________________________________
> @@ -276,6 +279,11 @@ struct stm32_adc_ops {
>   * @num_conv:		expected number of scan conversions
>   * @injected:		use injected channels on this adc
>   * @lock:		spinlock
> + * @work:		irq work used to call trigger poll routine
> + * @dma_chan:		dma channel
> + * @rx_buf:		dma rx buffer cpu address
> + * @rx_dma_buf:		dma rx buffer bus address
> + * @rx_buf_sz:		dma rx buffer size
>   * @clk:		optional adc clock, for this adc instance
>   * @calib:		optional calibration data
>   * @en:			emulates enabled state on some stm32 adc
> @@ -293,6 +301,11 @@ struct stm32_adc {
>  	int			num_conv;
>  	bool			injected;
>  	spinlock_t		lock;		/* interrupt lock */
> +	struct irq_work		work;
> +	struct dma_chan		*dma_chan;
> +	u8			*rx_buf;
> +	dma_addr_t		rx_dma_buf;
> +	int			rx_buf_sz;
>  	struct clk		*clk;
>  	void			*calib;
>  	bool			en;
> @@ -302,6 +315,7 @@ struct stm32_adc {
>   * struct stm32_adc_common - private data of ADC driver, common to all
>   * ADC instances (ADC block)
>   * @dev:		device for this controller
> + * @phys_base:		control registers base physical addr
>   * @base:		control registers base cpu addr
>   * @irq:		Common irq line for all adc instances
>   * @data:		STM32 dependent data from compatible
> @@ -313,6 +327,7 @@ struct stm32_adc {
>   */
>  struct stm32_adc_common {
>  	struct device			*dev;
> +	phys_addr_t			phys_base;
>  	void __iomem			*base;
>  	int				irq;
>  	const struct stm32_adc_ops	*data;
> diff --git a/drivers/iio/adc/stm32/stm32f4-adc.c b/drivers/iio/adc/stm32/stm32f4-adc.c
> index 147fe9c..4d7a2a8 100644
> --- a/drivers/iio/adc/stm32/stm32f4-adc.c
> +++ b/drivers/iio/adc/stm32/stm32f4-adc.c
> @@ -437,16 +437,30 @@ static bool stm32f4_adc_injected_started(struct stm32_adc *adc)
>   * @adc: stm32 adc instance
>   *
>   * Start single conversions for regular or injected channels.
> + * Also take care of normal or DMA mode. DMA is used in circular mode for
> + * regular conversions, in IIO buffer modes. Rely on rx_buf as raw
> + * read doesn't use dma, but direct DR read.
>   */
>  static int stm32f4_adc_start_conv(struct stm32_adc *adc)
>  {
> -	u32 trig_msk, start_msk;
> +	u32 val, trig_msk, start_msk;
> +	unsigned long flags;
>  
>  	dev_dbg(adc->common->dev, "%s %s\n", __func__,
>  		adc->injected ? "injected" : "regular");
>  
>  	stm32_adc_set_bits(adc, STM32F4_ADCX_CR1, STM32F4_SCAN);
>  
> +	if (!adc->injected) {
> +		spin_lock_irqsave(&adc->lock, flags);
> +		val = stm32_adc_readl(adc, STM32F4_ADCX_CR2);
> +		val &= ~(STM32F4_DMA | STM32F4_DDS);
> +		if (adc->rx_buf)
> +			val |= STM32F4_DMA | STM32F4_DDS;
> +		stm32_adc_writel(adc, STM32F4_ADCX_CR2, val);
> +		spin_unlock_irqrestore(&adc->lock, flags);
> +	}
> +
>  	if (!stm32f4_adc_is_started(adc)) {
>  		stm32_adc_set_bits(adc, STM32F4_ADCX_CR2,
>  				   STM32F4_EOCS | STM32F4_ADON);
> @@ -494,6 +508,10 @@ static int stm32f4_adc_stop_conv(struct stm32_adc *adc)
>  		stm32_adc_clr_bits(adc, STM32F4_ADCX_CR2, STM32F4_ADON);
>  	}
>  
> +	if (!adc->injected)
> +		stm32_adc_clr_bits(adc, STM32F4_ADCX_CR2,
> +				   STM32F4_DMA | STM32F4_DDS);
> +
>  	return 0;
>  }
>  
> 

