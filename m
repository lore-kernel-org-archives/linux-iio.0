Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47299 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdDBIyw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:54:52 -0400
Subject: Re: [PATCH v2 2/2] iio: adc: stm32: add dt option to set resolution
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1490963559-32159-1-git-send-email-fabrice.gasnier@st.com>
 <1490963559-32159-3-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
        linus.walleij@linaro.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8d440abd-3548-6aab-bba9-3f62fe27e72d@kernel.org>
Date: Sun, 2 Apr 2017 09:54:48 +0100
MIME-Version: 1.0
In-Reply-To: <1490963559-32159-3-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/17 13:32, Fabrice Gasnier wrote:
> stm32 adc supports several resolution. Add 'assigned-resolution-bits'
> dt optional property to set it. Default to maximum resolution in case
> it isn't set.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
The code is fine.  Just waiting on review of the binding.

Give me a poke if I seem to have dropped this in a week or two.

Thanks,

Jonathan
> ---
> Changes in v2:
> - rename property from 'st,adc-res' to 'assigned-resolution-bits', so it
>   is more common.
> ---
>  drivers/iio/adc/stm32-adc.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 9b49a6ad..c28e7ff 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -60,6 +60,8 @@
>  #define STM32F4_EOC			BIT(1)
>  
>  /* STM32F4_ADC_CR1 - bit fields */
> +#define STM32F4_RES_SHIFT		24
> +#define STM32F4_RES_MASK		GENMASK(25, 24)
>  #define STM32F4_SCAN			BIT(8)
>  #define STM32F4_EOCIE			BIT(5)
>  
> @@ -141,6 +143,7 @@ struct stm32_adc_regs {
>   * @lock:		spinlock
>   * @bufi:		data buffer index
>   * @num_conv:		expected number of scan conversions
> + * @res:		data resolution (e.g. RES bitfield value)
>   * @trigger_polarity:	external trigger polarity (e.g. exten)
>   * @dma_chan:		dma channel
>   * @rx_buf:		dma rx buffer cpu address
> @@ -157,6 +160,7 @@ struct stm32_adc {
>  	spinlock_t		lock;		/* interrupt lock */
>  	unsigned int		bufi;
>  	unsigned int		num_conv;
> +	u32			res;
>  	u32			trigger_polarity;
>  	struct dma_chan		*dma_chan;
>  	u8			*rx_buf;
> @@ -196,6 +200,11 @@ struct stm32_adc_chan_spec {
>  	{ IIO_VOLTAGE, 15, "in15" },
>  };
>  
> +static const unsigned int stm32f4_adc_resolutions[] = {
> +	/* sorted values so the index matches RES[1:0] in STM32F4_ADC_CR1 */
> +	12, 10, 8, 6,
> +};
> +
>  /**
>   * stm32f4_sq - describe regular sequence registers
>   * - L: sequence len (register & bit field)
> @@ -302,6 +311,14 @@ static void stm32_adc_conv_irq_disable(struct stm32_adc *adc)
>  	stm32_adc_clr_bits(adc, STM32F4_ADC_CR1, STM32F4_EOCIE);
>  }
>  
> +static void stm32_adc_set_res(struct stm32_adc *adc)
> +{
> +	u32 val = stm32_adc_readl(adc, STM32F4_ADC_CR1);
> +
> +	val = (val & ~STM32F4_RES_MASK) | (adc->res << STM32F4_RES_SHIFT);
> +	stm32_adc_writel(adc, STM32F4_ADC_CR1, val);
> +}
> +
>  /**
>   * stm32_adc_start_conv() - Start conversions for regular channels.
>   * @adc: stm32 adc instance
> @@ -870,11 +887,37 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
>  	{},
>  };
>  
> +static int stm32_adc_of_get_resolution(struct iio_dev *indio_dev)
> +{
> +	struct device_node *node = indio_dev->dev.of_node;
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	unsigned int i;
> +	u32 res;
> +
> +	if (of_property_read_u32(node, "assigned-resolution-bits", &res))
> +		res = stm32f4_adc_resolutions[0];
> +
> +	for (i = 0; i < ARRAY_SIZE(stm32f4_adc_resolutions); i++)
> +		if (res == stm32f4_adc_resolutions[i])
> +			break;
> +	if (i >= ARRAY_SIZE(stm32f4_adc_resolutions)) {
> +		dev_err(&indio_dev->dev, "Bad resolution: %u bits\n", res);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&indio_dev->dev, "Using %u bits resolution\n", res);
> +	adc->res = i;
> +
> +	return 0;
> +}
> +
>  static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
>  				    struct iio_chan_spec *chan,
>  				    const struct stm32_adc_chan_spec *channel,
>  				    int scan_index)
>  {
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
>  	chan->type = channel->type;
>  	chan->channel = channel->channel;
>  	chan->datasheet_name = channel->name;
> @@ -883,7 +926,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>  	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
>  	chan->scan_type.sign = 'u';
> -	chan->scan_type.realbits = 12;
> +	chan->scan_type.realbits = stm32f4_adc_resolutions[adc->res];
>  	chan->scan_type.storagebits = 16;
>  	chan->ext_info = stm32_adc_ext_info;
>  }
> @@ -1022,6 +1065,11 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = stm32_adc_of_get_resolution(indio_dev);
> +	if (ret < 0)
> +		goto err_clk_disable;
> +	stm32_adc_set_res(adc);
> +
>  	ret = stm32_adc_chan_of_init(indio_dev);
>  	if (ret < 0)
>  		goto err_clk_disable;
> 

