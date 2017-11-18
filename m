Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030292AbdKRQHc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Nov 2017 11:07:32 -0500
Date: Sat, 18 Nov 2017 16:07:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v3 3/4] iio: adc: at91-sama5d2_adc: add support for DMA
Message-ID: <20171118160719.29293a4c@archlinux>
In-Reply-To: <1510750608-8697-4-git-send-email-eugen.hristev@microchip.com>
References: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
        <1510750608-8697-4-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 15 Nov 2017 14:56:47 +0200
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Added support for DMA transfers. The implementation uses the user watermark
> to decide whether DMA will be used or not. For watermark 1, DMA will not be
> used. If watermark is bigger, DMA will be used.
> Sysfs attributes are created to indicate whether the DMA is used,
> with hwfifo_enabled, and the current DMA watermark is readable
> in hwfifo_watermark. Minimum and maximum values are in hwfifo_watermark_min
> and hwfifo_watermark_max.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
A tiny nitpick inline but otherwise looks fine to me.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  Changes in v3:
>  - Remove misleaded dev_info message when DMA was not enabled at probe
>  - Rebased patch on top of the
> [PATCH] iio: adc: at91-sama5d2_adc: fix probe error on missing trigger property
> Which is already upstreamed in 4.14
>  - Fixed the bug introduced in v2, with buffer size
>  - added extra check when enabling DMA, to have hw trigger present.
> This is because now, we can have the driver with software trigger only (if no
> hw trigger in device tree, start as software only)
> 
>  Changes in v2:
>  - No longer add last timestamp to all samples. Now, compute an interval
> between samples w.r.t. start and end time of the transfer and number
> of samples. Then distribute them each in the time interval.
>  - Add warning for conversion overrun. This helps user identify cases
> when the watermark needs adjustment : the software is too slow in reading
> data from the ADC.
>  - Protection around watermark is not needed, changing of the watermark
> cannot be done while the buffer is enabled. When buffer is disabled, all
> DMA resources are freed anyway.
>  - Added validation on trigger to be used by own device
>  - Best sample rate I could obtain using the low frequency clock was about
> 4k samples/second, with a watermark of 100. To get up to 50k samples/second
> the ADC frequency must be increased to max.
>  - Fixed computation of DMA buffer size
>  - Addressed other comments from mailing list review. Feedback is appreciated
> 
>  drivers/iio/adc/Kconfig            |   1 +
>  drivers/iio/adc/at91-sama5d2_adc.c | 453 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 434 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1d13bf0..1a3a8e3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -158,6 +158,7 @@ config AT91_SAMA5D2_ADC
>  	tristate "Atmel AT91 SAMA5D2 ADC"
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	depends on HAS_IOMEM
> +	depends on HAS_DMA
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Atmel SAMA5D2 ADC which is
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index a70ef7f..11d34a8 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -16,6 +16,8 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -100,6 +102,8 @@
>  #define AT91_SAMA5D2_LCDR	0x20
>  /* Interrupt Enable Register */
>  #define AT91_SAMA5D2_IER	0x24
> +/* Interrupt Enable Register - general overrun error */
> +#define AT91_SAMA5D2_IER_GOVRE BIT(25)
>  /* Interrupt Disable Register */
>  #define AT91_SAMA5D2_IDR	0x28
>  /* Interrupt Mask Register */
> @@ -167,13 +171,19 @@
>  
>  /*
>   * Maximum number of bytes to hold conversion from all channels
> - * plus the timestamp
> + * without the timestamp.
>   */
> -#define AT91_BUFFER_MAX_BYTES ((AT91_SAMA5D2_SINGLE_CHAN_CNT +		\
> -				AT91_SAMA5D2_DIFF_CHAN_CNT) * 2 + 8)
> +#define AT91_BUFFER_MAX_CONVERSION_BYTES ((AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> +					 AT91_SAMA5D2_DIFF_CHAN_CNT) * 2)
> +
> +/* This total must also include the timestamp */
> +#define AT91_BUFFER_MAX_BYTES (AT91_BUFFER_MAX_CONVERSION_BYTES + 8)
>  
>  #define AT91_BUFFER_MAX_HWORDS (AT91_BUFFER_MAX_BYTES / 2)
>  
> +#define AT91_HWFIFO_MAX_SIZE_STR	"128"
> +#define AT91_HWFIFO_MAX_SIZE		128
> +
>  #define AT91_SAMA5D2_CHAN_SINGLE(num, addr)				\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
> @@ -228,6 +238,28 @@ struct at91_adc_trigger {
>  	bool				hw_trig;
>  };
>  
> +/**
> + * at91_adc_dma - at91-sama5d2 dma information struct
> + * @dma_chan:		the dma channel acquired
> + * @rx_buf:		dma coherent allocated area
> + * @rx_dma_buf:		dma handler for the buffer
> + * @phys_addr:		physical address of the ADC base register
> + * @buf_idx:		index inside the dma buffer where reading was last done
> + * @rx_buf_sz:		size of buffer used by DMA operation
> + * @watermark:		number of conversions to copy before DMA triggers irq
> + * @dma_ts:		hold the start timestamp of dma operation
> + */
> +struct at91_adc_dma {
> +	struct dma_chan			*dma_chan;
> +	u8				*rx_buf;
> +	dma_addr_t			rx_dma_buf;
> +	phys_addr_t			phys_addr;
> +	int				buf_idx;
> +	int				rx_buf_sz;
> +	int				watermark;
> +	s64				dma_ts;
> +};
> +
>  struct at91_adc_state {
>  	void __iomem			*base;
>  	int				irq;
> @@ -242,6 +274,7 @@ struct at91_adc_state {
>  	u32				conversion_value;
>  	struct at91_adc_soc_info	soc_info;
>  	wait_queue_head_t		wq_data_available;
> +	struct at91_adc_dma		dma_st;
>  	u16				buffer[AT91_BUFFER_MAX_HWORDS];
>  	/*
>  	 * lock to prevent concurrent 'single conversion' requests through
> @@ -322,11 +355,17 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  		if (state) {
>  			at91_adc_writel(st, AT91_SAMA5D2_CHER,
>  					BIT(chan->channel));
> -			at91_adc_writel(st, AT91_SAMA5D2_IER,
> -					BIT(chan->channel));
> +			/* enable irq only if not using DMA */
> +			if (!st->dma_st.dma_chan) {
> +				at91_adc_writel(st, AT91_SAMA5D2_IER,
> +						BIT(chan->channel));
> +			}
>  		} else {
> -			at91_adc_writel(st, AT91_SAMA5D2_IDR,
> -					BIT(chan->channel));
> +			/* disable irq only if not using DMA */
> +			if (!st->dma_st.dma_chan) {
> +				at91_adc_writel(st, AT91_SAMA5D2_IDR,
> +						BIT(chan->channel));
> +			}
>  			at91_adc_writel(st, AT91_SAMA5D2_CHDR,
>  					BIT(chan->channel));
>  		}
> @@ -340,6 +379,10 @@ static int at91_adc_reenable_trigger(struct iio_trigger *trig)
>  	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
>  	struct at91_adc_state *st = iio_priv(indio);
>  
> +	/* if we are using DMA, we must not reenable irq after each trigger */
> +	if (st->dma_st.dma_chan)
> +		return 0;
> +
>  	enable_irq(st->irq);
>  
>  	/* Needed to ACK the DRDY interruption */
> @@ -351,6 +394,153 @@ static const struct iio_trigger_ops at91_adc_trigger_ops = {
>  	.owner = THIS_MODULE,
>  	.set_trigger_state = &at91_adc_configure_trigger,
>  	.try_reenable = &at91_adc_reenable_trigger,
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static int at91_adc_dma_size_done(struct at91_adc_state *st)
> +{
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +	int i, size;
> +
> +	status = dmaengine_tx_status(st->dma_st.dma_chan,
> +				     st->dma_st.dma_chan->cookie,
> +				     &state);
> +	if (status != DMA_IN_PROGRESS)
> +		return 0;
> +
> +	/* Transferred length is size in bytes from end of buffer */
> +	i = st->dma_st.rx_buf_sz - state.residue;
> +
> +	/* Return available bytes */
> +	if (i >= st->dma_st.buf_idx)
> +		size = i - st->dma_st.buf_idx;
> +	else
> +		size = st->dma_st.rx_buf_sz + i - st->dma_st.buf_idx;
> +	return size;
> +}
> +
> +static void at91_dma_buffer_done(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +
> +	iio_trigger_poll_chained(indio_dev->trig);
> +}
> +
> +static int at91_adc_dma_start(struct iio_dev *indio_dev)
> +{
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +	struct dma_async_tx_descriptor *desc;
> +	dma_cookie_t cookie;
> +	int ret;
> +	u8 bit;
> +
> +	if (!st->dma_st.dma_chan)
> +		return 0;
> +
> +	/* we start a new DMA, so set buffer index to start */
> +	st->dma_st.buf_idx = 0;
> +
> +	/*
> +	 * compute buffer size w.r.t. watermark and enabled channels.
> +	 * scan_bytes is aligned so we need an exact size for DMA
> +	 */
> +	st->dma_st.rx_buf_sz = 0;
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->num_channels) {
> +		struct iio_chan_spec const *chan = indio_dev->channels + bit;
> +
> +		st->dma_st.rx_buf_sz += chan->scan_type.storagebits / 8;
> +	}
> +	st->dma_st.rx_buf_sz *= st->dma_st.watermark;
> +
> +	/* Prepare a DMA cyclic transaction */
> +	desc = dmaengine_prep_dma_cyclic(st->dma_st.dma_chan,
> +					 st->dma_st.rx_dma_buf,
> +					 st->dma_st.rx_buf_sz,
> +					 st->dma_st.rx_buf_sz / 2,
> +					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
> +
> +	if (!desc) {
> +		dev_err(&indio_dev->dev, "cannot prepare DMA cyclic\n");
> +		return -EBUSY;
> +	}
> +
> +	desc->callback = at91_dma_buffer_done;
> +	desc->callback_param = indio_dev;
> +
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "cannot submit DMA cyclic\n");
> +		dmaengine_terminate_async(st->dma_st.dma_chan);
> +		return ret;
> +	}
> +
> +	/* enable general overrun error signaling */
> +	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_GOVRE);
> +	/* Issue pending DMA requests */
> +	dma_async_issue_pending(st->dma_st.dma_chan);
> +
> +	/* consider current time as DMA start time for timestamps */
> +	st->dma_st.dma_ts = iio_get_time_ns(indio_dev);
> +
> +	dev_dbg(&indio_dev->dev, "DMA cyclic started\n");
> +
> +	return 0;
> +}
> +
> +static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +
> +	ret = at91_adc_dma_start(indio_dev);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "buffer postenable failed\n");
> +		return ret;
> +	}
> +
> +	return iio_triggered_buffer_postenable(indio_dev);
> +}
> +
> +static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u8 bit;
> +
> +	ret = iio_triggered_buffer_predisable(indio_dev);
> +	if (ret < 0)
> +		dev_err(&indio_dev->dev, "buffer predisable failed\n");
> +
> +	if (!st->dma_st.dma_chan)
> +		return ret;
> +
> +	/* if we are using DMA we must clear registers and end DMA */
> +	dmaengine_terminate_sync(st->dma_st.dma_chan);
> +
> +	/*
> +	 * For each enabled channel we must read the last converted value
> +	 * to clear EOC status and not get a possible interrupt later.
> +	 * This value is being read by DMA from LCDR anyway
> +	 */
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->num_channels) {
> +		struct iio_chan_spec const *chan = indio_dev->channels + bit;
> +
> +		if (st->dma_st.dma_chan)
> +			at91_adc_readl(st, chan->address);
> +	}
> +
> +	/* read overflow register to clear possible overflow status */
> +	at91_adc_readl(st, AT91_SAMA5D2_OVER);
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
> +	.postenable = &at91_adc_buffer_postenable,
> +	.predisable = &at91_adc_buffer_predisable,
>  };
>  
>  static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
> @@ -389,24 +579,77 @@ static int at91_adc_trigger_init(struct iio_dev *indio)
>  	return 0;
>  }
>  
> -static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
> +static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
> +					   struct iio_poll_func *pf)
>  {
> -	struct iio_poll_func *pf = p;
> -	struct iio_dev *indio = pf->indio_dev;
> -	struct at91_adc_state *st = iio_priv(indio);
> +	struct at91_adc_state *st = iio_priv(indio_dev);
>  	int i = 0;
>  	u8 bit;
>  
> -	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
> -		struct iio_chan_spec const *chan = indio->channels + bit;
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->num_channels) {
> +		struct iio_chan_spec const *chan = indio_dev->channels + bit;
>  
>  		st->buffer[i] = at91_adc_readl(st, chan->address);
>  		i++;
>  	}
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->buffer,
> +					   pf->timestamp);
> +}
> +
> +static void at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
> +{
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +	int transferred_len = at91_adc_dma_size_done(st);
> +	s64 ns = iio_get_time_ns(indio_dev);
> +	s64 interval;
> +	int sample_index = 0, sample_count, sample_size;
> +
> +	u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
> +	/* if we reached this point, we cannot sample faster */
> +	if (status & AT91_SAMA5D2_IER_GOVRE)
> +		pr_info_ratelimited("%s: conversion overrun detected\n",
> +				    indio_dev->name);
> +
> +	sample_size = div_s64(st->dma_st.rx_buf_sz, st->dma_st.watermark);
> +
> +	sample_count = div_s64(transferred_len, sample_size);
> +
> +	/*
> +	 * interval between samples is total time since last transfer handling
> +	 * divided by the number of samples (total size divided by sample size)
> +	 */
> +	interval = div_s64((ns - st->dma_st.dma_ts), sample_count);
> +
> +	while (transferred_len >= sample_size) {
> +		iio_push_to_buffers_with_timestamp(indio_dev,
> +				(st->dma_st.rx_buf + st->dma_st.buf_idx),
> +				(st->dma_st.dma_ts + interval * sample_index));
> +		/* adjust remaining length */
> +		transferred_len -= sample_size;
> +		/* adjust buffer index */
> +		st->dma_st.buf_idx += sample_size;
> +		/* in case of reaching end of buffer, reset index */
> +		if (st->dma_st.buf_idx >= st->dma_st.rx_buf_sz)
> +			st->dma_st.buf_idx = 0;
> +		sample_index++;
> +	}
> +	/* adjust saved time for next transfer handling */
> +	st->dma_st.dma_ts = iio_get_time_ns(indio_dev);
> +}
> +
> +static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> -	iio_push_to_buffers_with_timestamp(indio, st->buffer, pf->timestamp);
> +	if (st->dma_st.dma_chan)
> +		at91_adc_trigger_handler_dma(indio_dev);
> +	else
> +		at91_adc_trigger_handler_nodma(indio_dev, pf);
>  
> -	iio_trigger_notify_done(indio->trig);
> +	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -415,7 +658,7 @@ static int at91_adc_buffer_init(struct iio_dev *indio)
>  {
>  	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
>  			&iio_pollfunc_store_time,
> -			&at91_adc_trigger_handler, NULL);
> +			&at91_adc_trigger_handler, &at91_buffer_setup_ops);
>  }
>  
>  static unsigned at91_adc_startup_time(unsigned startup_time_min,
> @@ -486,10 +729,13 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
>  	if (!(status & imr))
>  		return IRQ_NONE;
>  
> -	if (iio_buffer_enabled(indio)) {
> +	if (iio_buffer_enabled(indio) && !st->dma_st.dma_chan) {
>  		disable_irq_nosync(irq);
>  		iio_trigger_poll(indio->trig);
> -	} else {
> +	} else if (iio_buffer_enabled(indio) && st->dma_st.dma_chan) {
> +		disable_irq_nosync(irq);
> +		WARN(true, "Unexpected irq occurred\n");
> +	} else if (!iio_buffer_enabled(indio)) {
>  		st->conversion_value = at91_adc_readl(st, st->chan->address);
>  		st->conversion_done = true;
>  		wake_up_interruptible(&st->wq_data_available);
> @@ -511,7 +757,6 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  		ret = iio_device_claim_direct_mode(indio_dev);
>  		if (ret)
>  			return ret;
> -
Real nitpick, but this is an unrelated change... Should not be here.
>  		mutex_lock(&st->lock);
>  
>  		st->chan = chan;
> @@ -581,9 +826,123 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static void at91_adc_dma_init(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +	struct dma_slave_config config = {0};
> +	/*
> +	 * We make the buffer double the size of the fifo,
> +	 * such that DMA uses one half of the buffer (full fifo size)
> +	 * and the software uses the other half to read/write.
> +	 */
> +	unsigned int pages = DIV_ROUND_UP(AT91_HWFIFO_MAX_SIZE *
> +					  AT91_BUFFER_MAX_CONVERSION_BYTES * 2,
> +					  PAGE_SIZE);
> +
> +	if (st->dma_st.dma_chan)
> +		return;
> +
> +	st->dma_st.dma_chan = dma_request_slave_channel(&pdev->dev, "rx");
> +
> +	if (!st->dma_st.dma_chan)  {
> +		dev_info(&pdev->dev, "can't get DMA channel\n");
> +		goto dma_exit;
> +	}
> +
> +	st->dma_st.rx_buf = dma_alloc_coherent(st->dma_st.dma_chan->device->dev,
> +					       pages * PAGE_SIZE,
> +					       &st->dma_st.rx_dma_buf,
> +					       GFP_KERNEL);
> +	if (!st->dma_st.rx_buf) {
> +		dev_info(&pdev->dev, "can't allocate coherent DMA area\n");
> +		goto dma_chan_disable;
> +	}
> +
> +	/* Configure DMA channel to read data register */
> +	config.direction = DMA_DEV_TO_MEM;
> +	config.src_addr = (phys_addr_t)(st->dma_st.phys_addr
> +			  + AT91_SAMA5D2_LCDR);
> +	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +	config.src_maxburst = 1;
> +	config.dst_maxburst = 1;
> +
> +	if (dmaengine_slave_config(st->dma_st.dma_chan, &config)) {
> +		dev_info(&pdev->dev, "can't configure DMA slave\n");
> +		goto dma_free_area;
> +	}
> +
> +	dev_info(&pdev->dev, "using %s for rx DMA transfers\n",
> +		 dma_chan_name(st->dma_st.dma_chan));
> +
> +	return;
> +
> +dma_free_area:
> +	dma_free_coherent(st->dma_st.dma_chan->device->dev, pages * PAGE_SIZE,
> +			  st->dma_st.rx_buf, st->dma_st.rx_dma_buf);
> +dma_chan_disable:
> +	dma_release_channel(st->dma_st.dma_chan);
> +	st->dma_st.dma_chan = 0;
> +dma_exit:
> +	dev_info(&pdev->dev, "continuing without DMA support\n");
> +}
> +
> +static void at91_adc_dma_disable(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +	unsigned int pages = DIV_ROUND_UP(AT91_HWFIFO_MAX_SIZE *
> +					  AT91_BUFFER_MAX_CONVERSION_BYTES * 2,
> +					  PAGE_SIZE);
> +
> +	/* if we are not using DMA, just return */
> +	if (!st->dma_st.dma_chan)
> +		return;
> +
> +	/* wait for all transactions to be terminated first*/
> +	dmaengine_terminate_sync(st->dma_st.dma_chan);
> +
> +	dma_free_coherent(st->dma_st.dma_chan->device->dev, pages * PAGE_SIZE,
> +			  st->dma_st.rx_buf, st->dma_st.rx_dma_buf);
> +	dma_release_channel(st->dma_st.dma_chan);
> +	st->dma_st.dma_chan = 0;
> +
> +	dev_info(&pdev->dev, "continuing without DMA support\n");
> +}
> +
> +static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +
> +	if (val > AT91_HWFIFO_MAX_SIZE)
> +		return -EINVAL;
> +
> +	if (!st->selected_trig->hw_trig) {
> +		dev_dbg(&indio_dev->dev, "we need hw trigger for DMA\n");
> +		return 0;
> +	}
> +
> +	dev_dbg(&indio_dev->dev, "new watermark is %u\n", val);
> +	st->dma_st.watermark = val;
> +
> +	/*
> +	 * The logic here is: if we have watermark 1, it means we do
> +	 * each conversion with it's own IRQ, thus we don't need DMA.
> +	 * If the watermark is higher, we do DMA to do all the transfers in bulk
> +	 */
> +
> +	if (val == 1)
> +		at91_adc_dma_disable(to_platform_device(&indio_dev->dev));
> +	else if (val > 1)
> +		at91_adc_dma_init(to_platform_device(&indio_dev->dev));
> +
> +	return 0;
> +}
> +
>  static const struct iio_info at91_adc_info = {
>  	.read_raw = &at91_adc_read_raw,
>  	.write_raw = &at91_adc_write_raw,
> +	.hwfifo_set_watermark = &at91_adc_set_watermark,
>  	.driver_module = THIS_MODULE,
>  };
>  
> @@ -601,6 +960,42 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
>  	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
>  }
>  
> +static ssize_t at91_adc_get_fifo_state(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =
> +			platform_get_drvdata(to_platform_device(dev));
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", !!st->dma_st.dma_chan);
> +}
> +
> +static ssize_t at91_adc_get_watermark(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =
> +			platform_get_drvdata(to_platform_device(dev));
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
> +}
> +
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       at91_adc_get_fifo_state, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +		       at91_adc_get_watermark, NULL, 0);
> +
> +static IIO_CONST_ATTR(hwfifo_watermark_min, "2");
> +static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
> +
> +static const struct attribute *at91_adc_fifo_attributes[] = {
> +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL,
> +};
> +
>  static int at91_adc_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev;
> @@ -676,6 +1071,9 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	if (!res)
>  		return -EINVAL;
>  
> +	/* if we plan to use DMA, we need the physical address of the regs */
> +	st->dma_st.phys_addr = res->start;
> +
>  	st->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(st->base))
>  		return PTR_ERR(st->base);
> @@ -739,11 +1137,22 @@ static int at91_adc_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "couldn't setup the triggers.\n");
>  			goto per_clk_disable_unprepare;
>  		}
> +		/*
> +		 * Initially the iio buffer has a length of 2 and
> +		 * a watermark of 1
> +		 */
> +		st->dma_st.watermark = 1;
> +
> +		iio_buffer_set_attrs(indio_dev->buffer,
> +				     at91_adc_fifo_attributes);
>  	}
>  
> +	if (dma_coerce_mask_and_coherent(&indio_dev->dev, DMA_BIT_MASK(32)))
> +		dev_info(&pdev->dev, "cannot set DMA mask to 32-bit\n");
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
> -		goto per_clk_disable_unprepare;
> +		goto dma_disable;
>  
>  	if (st->selected_trig->hw_trig)
>  		dev_info(&pdev->dev, "setting up trigger as %s\n",
> @@ -754,6 +1163,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +dma_disable:
> +	at91_adc_dma_disable(pdev);
>  per_clk_disable_unprepare:
>  	clk_disable_unprepare(st->per_clk);
>  vref_disable:
> @@ -770,6 +1181,8 @@ static int at91_adc_remove(struct platform_device *pdev)
>  
>  	iio_device_unregister(indio_dev);
>  
> +	at91_adc_dma_disable(pdev);
> +
>  	clk_disable_unprepare(st->per_clk);
>  
>  	regulator_disable(st->vref);

