Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47007 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdA1SlF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 13:41:05 -0500
Subject: Re: [PATCH v2 5/7] iio: adc: stm32: add optional dma support
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
 <1485440915-30119-6-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7c2e5529-970a-ef4c-1c47-e7d77594e023@kernel.org>
Date: Sat, 28 Jan 2017 18:40:30 +0000
MIME-Version: 1.0
In-Reply-To: <1485440915-30119-6-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/01/17 14:28, Fabrice Gasnier wrote:
> Add DMA optional support to STM32 ADC, as there is a limited number DMA
> channels (request lines) that can be assigned to ADC. This way, driver
> may fall back using interrupts when all DMA channels are in use for
> other IPs.
> Use dma cyclic mode with two periods. Allow to tune period length by
> using watermark. Coherent memory is used for dma (max buffer size is
> fixed to PAGE_SIZE).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git - pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes in v2:
> - Use iio_trigger_poll_chained() avoids to bounce back into irq context.
>   Remove irq_work.
> - Rework dma buffer allocation and use. Allocation moved to probe time,
>   fixed to PAGE_SIZE. Use hwfifo_set_watermark() routine to tune dma
>   cyclic period length.
> ---
>  drivers/iio/adc/Kconfig          |   1 +
>  drivers/iio/adc/stm32-adc-core.c |   1 +
>  drivers/iio/adc/stm32-adc-core.h |   2 +
>  drivers/iio/adc/stm32-adc.c      | 227 ++++++++++++++++++++++++++++++++++++---
>  4 files changed, 218 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9a7b090..03a73f9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -444,6 +444,7 @@ config ROCKCHIP_SARADC
>  config STM32_ADC_CORE
>  	tristate "STMicroelectronics STM32 adc core"
>  	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on HAS_DMA
>  	depends on OF
>  	depends on REGULATOR
>  	select IIO_BUFFER
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 4214b0c..22b7c93 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -201,6 +201,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	priv->common.base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->common.base))
>  		return PTR_ERR(priv->common.base);
> +	priv->common.phys_base = res->start;
>  
>  	priv->vref = devm_regulator_get(&pdev->dev, "vref");
>  	if (IS_ERR(priv->vref)) {
> diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
> index 081fa5f..2ec7abb 100644
> --- a/drivers/iio/adc/stm32-adc-core.h
> +++ b/drivers/iio/adc/stm32-adc-core.h
> @@ -42,10 +42,12 @@
>  /**
>   * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
>   * @base:		control registers base cpu addr
> + * @phys_base:		control registers base physical addr
>   * @vref_mv:		vref voltage (mv)
>   */
>  struct stm32_adc_common {
>  	void __iomem			*base;
> +	phys_addr_t			phys_base;
>  	int				vref_mv;
>  };
>  
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 9a38f9a..8a30039 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -21,6 +21,8 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/timer/stm32-timer-trigger.h>
> @@ -68,12 +70,16 @@
>  #define STM32F4_EXTSEL_SHIFT		24
>  #define STM32F4_EXTSEL_MASK		GENMASK(27, 24)
>  #define STM32F4_EOCS			BIT(10)
> +#define STM32F4_DDS			BIT(9)
> +#define STM32F4_DMA			BIT(8)
>  #define STM32F4_ADON			BIT(0)
>  
>  #define STM32_ADC_MAX_SQ		16	/* SQ1..SQ16 */
>  #define STM32_ADC_TIMEOUT_US		100000
>  #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
>  
> +#define STM32_DMA_BUFFER_SIZE		PAGE_SIZE
> +
>  /* External trigger enable */
>  enum stm32_adc_exten {
>  	STM32_EXTEN_SWTRIG,
> @@ -136,6 +142,10 @@ struct stm32_adc_regs {
>   * @bufi:		data buffer index
>   * @num_conv:		expected number of scan conversions
>   * @trigger_polarity:	external trigger polarity (e.g. exten)
> + * @dma_chan:		dma channel
> + * @rx_buf:		dma rx buffer cpu address
> + * @rx_dma_buf:		dma rx buffer bus address
> + * @rx_buf_sz:		dma rx buffer size
>   */
>  struct stm32_adc {
>  	struct stm32_adc_common	*common;
> @@ -148,6 +158,10 @@ struct stm32_adc {
>  	unsigned int		bufi;
>  	unsigned int		num_conv;
>  	u32			trigger_polarity;
> +	struct dma_chan		*dma_chan;
> +	u8			*rx_buf;
> +	dma_addr_t		rx_dma_buf;
> +	unsigned int		rx_buf_sz;
>  };
>  
>  /**
> @@ -291,10 +305,21 @@ static void stm32_adc_conv_irq_disable(struct stm32_adc *adc)
>  /**
>   * stm32_adc_start_conv() - Start conversions for regular channels.
>   * @adc: stm32 adc instance
> + * @dma: use dma to transfer conversion result
> + *
> + * Start conversions for regular channels.
> + * Also take care of normal or DMA mode. Circular DMA may be used for regular
> + * conversions, in IIO buffer modes. Otherwise, use ADC interrupt with direct
> + * DR read instead (e.g. read_raw, or triggered buffer mode without DMA).
>   */
> -static void stm32_adc_start_conv(struct stm32_adc *adc)
> +static void stm32_adc_start_conv(struct stm32_adc *adc, bool dma)
>  {
>  	stm32_adc_set_bits(adc, STM32F4_ADC_CR1, STM32F4_SCAN);
> +
> +	if (dma)
> +		stm32_adc_set_bits(adc, STM32F4_ADC_CR2,
> +				   STM32F4_DMA | STM32F4_DDS);
> +
>  	stm32_adc_set_bits(adc, STM32F4_ADC_CR2, STM32F4_EOCS | STM32F4_ADON);
>  
>  	/* Wait for Power-up time (tSTAB from datasheet) */
> @@ -311,7 +336,8 @@ static void stm32_adc_stop_conv(struct stm32_adc *adc)
>  	stm32_adc_clr_bits(adc, STM32F4_ADC_SR, STM32F4_STRT);
>  
>  	stm32_adc_clr_bits(adc, STM32F4_ADC_CR1, STM32F4_SCAN);
> -	stm32_adc_clr_bits(adc, STM32F4_ADC_CR2, STM32F4_ADON);
> +	stm32_adc_clr_bits(adc, STM32F4_ADC_CR2,
> +			   STM32F4_ADON | STM32F4_DMA | STM32F4_DDS);
>  }
>  
>  /**
> @@ -494,7 +520,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>  
>  	stm32_adc_conv_irq_enable(adc);
>  
> -	stm32_adc_start_conv(adc);
> +	stm32_adc_start_conv(adc, false);
>  
>  	timeout = wait_for_completion_interruptible_timeout(
>  					&adc->completion, STM32_ADC_TIMEOUT);
> @@ -581,6 +607,23 @@ static int stm32_adc_validate_trigger(struct iio_dev *indio_dev,
>  	return stm32_adc_get_trig_extsel(trig) < 0 ? -EINVAL : 0;
>  }
>  
> +static int stm32_adc_set_watermark(struct iio_dev *indio_dev, unsigned val)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	unsigned int watermark = STM32_DMA_BUFFER_SIZE / 2;
> +
> +	/*
> +	 * dma cyclic transfers are used, buffer is split into two periods.
> +	 * There should be :
> +	 * - always one buffer (period) dma is working on
> +	 * - one buffer (period) driver can push with iio_trigger_poll().
> +	 */
> +	watermark = min(watermark, val * sizeof(u16));
> +	adc->rx_buf_sz = watermark * 2;
> +
> +	return 0;
> +}
> +
>  static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
>  				      const unsigned long *scan_mask)
>  {
> @@ -635,12 +678,83 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
>  static const struct iio_info stm32_adc_iio_info = {
>  	.read_raw = stm32_adc_read_raw,
>  	.validate_trigger = stm32_adc_validate_trigger,
> +	.hwfifo_set_watermark = stm32_adc_set_watermark,
>  	.update_scan_mode = stm32_adc_update_scan_mode,
>  	.debugfs_reg_access = stm32_adc_debugfs_reg_access,
>  	.of_xlate = stm32_adc_of_xlate,
>  	.driver_module = THIS_MODULE,
>  };
>  
> +static unsigned int stm32_adc_dma_residue(struct stm32_adc *adc)
> +{
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	status = dmaengine_tx_status(adc->dma_chan,
> +				     adc->dma_chan->cookie,
> +				     &state);
> +	if (status == DMA_IN_PROGRESS) {
> +		/* Residue is size in bytes from end of buffer */
> +		unsigned int i = adc->rx_buf_sz - state.residue;
> +		unsigned int size;
> +
> +		/* Return available bytes */
> +		if (i >= adc->bufi)
> +			size = i - adc->bufi;
> +		else
> +			size = adc->rx_buf_sz + i - adc->bufi;
> +
> +		return size;
> +	}
> +
> +	return 0;
> +}
> +
> +static void stm32_adc_dma_buffer_done(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +
> +	iio_trigger_poll_chained(indio_dev->trig);
> +}
> +
> +static int stm32_adc_dma_start(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	struct dma_async_tx_descriptor *desc;
> +	dma_cookie_t cookie;
> +	int ret;
> +
> +	if (!adc->dma_chan)
> +		return 0;
> +
> +	dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
> +		adc->rx_buf_sz, adc->rx_buf_sz / 2);
> +
> +	/* Prepare a DMA cyclic transaction */
> +	desc = dmaengine_prep_dma_cyclic(adc->dma_chan,
> +					 adc->rx_dma_buf,
> +					 adc->rx_buf_sz, adc->rx_buf_sz / 2,
> +					 DMA_DEV_TO_MEM,
> +					 DMA_PREP_INTERRUPT);
> +	if (!desc)
> +		return -EBUSY;
> +
> +	desc->callback = stm32_adc_dma_buffer_done;
> +	desc->callback_param = indio_dev;
> +
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret) {
> +		dmaengine_terminate_all(adc->dma_chan);
> +		return ret;
> +	}
> +
> +	/* Issue pending DMA requests */
> +	dma_async_issue_pending(adc->dma_chan);
> +
> +	return 0;
> +}
> +
>  static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct stm32_adc *adc = iio_priv(indio_dev);
> @@ -652,18 +766,29 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> +	ret = stm32_adc_dma_start(indio_dev);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Can't start dma\n");
> +		goto err_clr_trig;
> +	}
> +
>  	ret = iio_triggered_buffer_postenable(indio_dev);
>  	if (ret < 0)
> -		goto err_clr_trig;
> +		goto err_stop_dma;
>  
>  	/* Reset adc buffer index */
>  	adc->bufi = 0;
>  
> -	stm32_adc_conv_irq_enable(adc);
> -	stm32_adc_start_conv(adc);
> +	if (!adc->dma_chan)
> +		stm32_adc_conv_irq_enable(adc);
> +
> +	stm32_adc_start_conv(adc, !!adc->dma_chan);
>  
>  	return 0;
>  
> +err_stop_dma:
> +	if (adc->dma_chan)
> +		dmaengine_terminate_all(adc->dma_chan);
>  err_clr_trig:
>  	stm32_adc_set_trig(indio_dev, NULL);
>  
> @@ -676,12 +801,16 @@ static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  	int ret;
>  
>  	stm32_adc_stop_conv(adc);
> -	stm32_adc_conv_irq_disable(adc);
> +	if (!adc->dma_chan)
> +		stm32_adc_conv_irq_disable(adc);
>  
>  	ret = iio_triggered_buffer_predisable(indio_dev);
>  	if (ret < 0)
>  		dev_err(&indio_dev->dev, "predisable failed\n");
>  
> +	if (adc->dma_chan)
> +		dmaengine_terminate_all(adc->dma_chan);
> +
>  	if (stm32_adc_set_trig(indio_dev, NULL))
>  		dev_err(&indio_dev->dev, "Can't clear trigger\n");
>  
> @@ -701,15 +830,31 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
>  
>  	dev_dbg(&indio_dev->dev, "%s bufi=%d\n", __func__, adc->bufi);
>  
> -	/* reset buffer index */
> -	adc->bufi = 0;
> -	iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
> -					   pf->timestamp);
> +	if (!adc->dma_chan) {
> +		/* reset buffer index */
> +		adc->bufi = 0;
> +		iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
> +						   pf->timestamp);
> +	} else {
> +		int residue = stm32_adc_dma_residue(adc);
> +
> +		while (residue >= indio_dev->scan_bytes) {
> +			u16 *buffer = (u16 *)&adc->rx_buf[adc->bufi];
> +
> +			iio_push_to_buffers_with_timestamp(indio_dev, buffer,
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
> @@ -781,6 +926,45 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static int stm32_adc_dma_request(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	struct dma_slave_config config;
> +	int ret;
> +
> +	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
> +	if (!adc->dma_chan)
> +		return 0;
> +
> +	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
> +					 STM32_DMA_BUFFER_SIZE,
> +					 &adc->rx_dma_buf, GFP_KERNEL);
> +	if (!adc->rx_buf) {
> +		goto err_release;
> +		ret = -ENOMEM;
> +	}
> +
> +	/* Configure DMA channel to read data register */
> +	memset(&config, 0, sizeof(config));
> +	config.src_addr = (dma_addr_t)adc->common->phys_base;
> +	config.src_addr += adc->offset + STM32F4_ADC_DR;
> +	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +
> +	ret = dmaengine_slave_config(adc->dma_chan, &config);
> +	if (ret)
> +		goto err_free;
> +
> +	return 0;
> +
> +err_free:
> +	dma_free_coherent(adc->dma_chan->device->dev, STM32_DMA_BUFFER_SIZE,
> +			  adc->rx_buf, adc->rx_dma_buf);
> +err_release:
> +	dma_release_channel(adc->dma_chan);
> +
> +	return ret;
> +}
> +
>  static int stm32_adc_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev;
> @@ -842,13 +1026,17 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_clk_disable;
>  
> +	ret = stm32_adc_dma_request(indio_dev);
> +	if (ret < 0)
> +		goto err_clk_disable;
> +
>  	ret = iio_triggered_buffer_setup(indio_dev,
>  					 &iio_pollfunc_store_time,
>  					 &stm32_adc_trigger_handler,
>  					 &stm32_adc_buffer_setup_ops);
>  	if (ret) {
>  		dev_err(&pdev->dev, "buffer setup failed\n");
> -		goto err_clk_disable;
> +		goto err_dma_disable;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -862,6 +1050,13 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  
> +err_dma_disable:
> +	if (adc->dma_chan) {
> +		dma_free_coherent(adc->dma_chan->device->dev,
> +				  STM32_DMA_BUFFER_SIZE,
> +				  adc->rx_buf, adc->rx_dma_buf);
> +		dma_release_channel(adc->dma_chan);
> +	}
>  err_clk_disable:
>  	clk_disable_unprepare(adc->clk);
>  
> @@ -875,6 +1070,12 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
> +	if (adc->dma_chan) {
> +		dma_free_coherent(adc->dma_chan->device->dev,
> +				  STM32_DMA_BUFFER_SIZE,
> +				  adc->rx_buf, adc->rx_dma_buf);
> +		dma_release_channel(adc->dma_chan);
> +	}
>  	clk_disable_unprepare(adc->clk);
>  
>  	return 0;
> 

