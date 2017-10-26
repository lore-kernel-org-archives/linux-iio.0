Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932309AbdJZRr7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 13:47:59 -0400
Date: Thu, 26 Oct 2017 18:47:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 3/3] iio: adc: stm32: add support for differential
 channels
Message-ID: <20171026184750.06a35299@archlinux>
In-Reply-To: <1508923665-2274-4-git-send-email-fabrice.gasnier@st.com>
References: <1508923665-2274-1-git-send-email-fabrice.gasnier@st.com>
        <1508923665-2274-4-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 25 Oct 2017 11:27:45 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> STM32H7 ADC channels can be configured either as single ended or
> differential with 'st,adc-channels' or 'st,adc-diff-channels'
> (positive and negative input pair: <vinp vinn>, ...).
> 
> Differential channels have different offset and scale, from spec:
> raw value = (full_scale / 2) * (1 + (vinp - vinn) / vref).
> Add offset attribute.
> 
> Differential channels are selected by DIFSEL register. Negative
> inputs must be added to pre-selected channels as well (PCSEL).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Looks good. Again, DT review needed before I take the whole series.

Jonathan

> ---
> Changes in v2:
> - Improve val & val2 variable names in stm32_adc_chan_init_one()
>   definition as suggested by Jonathan.
> ---
>  drivers/iio/adc/stm32-adc.c | 123 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 103 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 417a894..fd50067 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -92,6 +92,7 @@
>  #define STM32H7_ADC_SQR3		0x38
>  #define STM32H7_ADC_SQR4		0x3C
>  #define STM32H7_ADC_DR			0x40
> +#define STM32H7_ADC_DIFSEL		0xC0
>  #define STM32H7_ADC_CALFACT		0xC4
>  #define STM32H7_ADC_CALFACT2		0xC8
>  
> @@ -154,7 +155,7 @@ enum stm32h7_adc_dmngt {
>  #define STM32H7_BOOST_CLKRATE		20000000UL
>  
>  #define STM32_ADC_CH_MAX		20	/* max number of channels */
> -#define STM32_ADC_CH_SZ			5	/* max channel name size */
> +#define STM32_ADC_CH_SZ			10	/* max channel name size */
>  #define STM32_ADC_MAX_SQ		16	/* SQ1..SQ16 */
>  #define STM32_ADC_MAX_SMP		7	/* SMPx range is [0..7] */
>  #define STM32_ADC_TIMEOUT_US		100000
> @@ -299,6 +300,7 @@ struct stm32_adc_cfg {
>   * @rx_buf:		dma rx buffer cpu address
>   * @rx_dma_buf:		dma rx buffer bus address
>   * @rx_buf_sz:		dma rx buffer size
> + * @difsel		bitmask to set single-ended/differential channel
>   * @pcsel		bitmask to preselect channels on some devices
>   * @smpr_val:		sampling time settings (e.g. smpr1 / smpr2)
>   * @cal:		optional calibration data on some devices
> @@ -321,12 +323,18 @@ struct stm32_adc {
>  	u8			*rx_buf;
>  	dma_addr_t		rx_dma_buf;
>  	unsigned int		rx_buf_sz;
> +	u32			difsel;
>  	u32			pcsel;
>  	u32			smpr_val[2];
>  	struct stm32_adc_calib	cal;
>  	char			chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
>  };
>  
> +struct stm32_adc_diff_channel {
> +	u32 vinp;
> +	u32 vinn;
> +};
> +
>  /**
>   * struct stm32_adc_info - stm32 ADC, per instance config data
>   * @max_channels:	Number of channels
> @@ -944,15 +952,19 @@ static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
>   * stm32h7_adc_prepare() - Leave power down mode to enable ADC.
>   * @adc: stm32 adc instance
>   * Leave power down mode.
> + * Configure channels as single ended or differential before enabling ADC.
>   * Enable ADC.
>   * Restore calibration data.
> - * Pre-select channels that may be used in PCSEL (required by input MUX / IO).
> + * Pre-select channels that may be used in PCSEL (required by input MUX / IO):
> + * - Only one input is selected for single ended (e.g. 'vinp')
> + * - Two inputs are selected for differential channels (e.g. 'vinp' & 'vinn')
>   */
>  static int stm32h7_adc_prepare(struct stm32_adc *adc)
>  {
>  	int ret;
>  
>  	stm32h7_adc_exit_pwr_down(adc);
> +	stm32_adc_writel(adc, STM32H7_ADC_DIFSEL, adc->difsel);
>  
>  	ret = stm32h7_adc_enable(adc);
>  	if (ret)
> @@ -1224,10 +1236,23 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
>  		return ret;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = adc->common->vref_mv;
> -		*val2 = chan->scan_type.realbits;
> +		if (chan->differential) {
> +			*val = adc->common->vref_mv * 2;
> +			*val2 = chan->scan_type.realbits;
> +		} else {
> +			*val = adc->common->vref_mv;
> +			*val2 = chan->scan_type.realbits;
> +		}
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->differential)
> +			/* ADC_full_scale / 2 */
> +			*val = -((1 << chan->scan_type.realbits) / 2);
> +		else
> +			*val = 0;
> +		return IIO_VAL_INT;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1591,29 +1616,39 @@ static void stm32_adc_smpr_init(struct stm32_adc *adc, int channel, u32 smp_ns)
>  
>  static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
>  				    struct iio_chan_spec *chan, u32 vinp,
> -				    int scan_index, u32 smp)
> +				    u32 vinn, int scan_index, bool differential)
>  {
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	char *name = adc->chan_name[vinp];
>  
>  	chan->type = IIO_VOLTAGE;
>  	chan->channel = vinp;
> -	snprintf(name, STM32_ADC_CH_SZ, "in%d", vinp);
> +	if (differential) {
> +		chan->differential = 1;
> +		chan->channel2 = vinn;
> +		snprintf(name, STM32_ADC_CH_SZ, "in%d-in%d", vinp, vinn);
> +	} else {
> +		snprintf(name, STM32_ADC_CH_SZ, "in%d", vinp);
> +	}
>  	chan->datasheet_name = name;
>  	chan->scan_index = scan_index;
>  	chan->indexed = 1;
>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> -	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> +	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> +					 BIT(IIO_CHAN_INFO_OFFSET);
>  	chan->scan_type.sign = 'u';
>  	chan->scan_type.realbits = adc->cfg->adc_info->resolutions[adc->res];
>  	chan->scan_type.storagebits = 16;
>  	chan->ext_info = stm32_adc_ext_info;
>  
> -	/* Prepare sampling time settings */
> -	stm32_adc_smpr_init(adc, chan->channel, smp);
> -
>  	/* pre-build selected channels mask */
>  	adc->pcsel |= BIT(chan->channel);
> +	if (differential) {
> +		/* pre-build diff channels mask */
> +		adc->difsel |= BIT(chan->channel);
> +		/* Also add negative input to pre-selected channels */
> +		adc->pcsel |= BIT(chan->channel2);
> +	}
>  }
>  
>  static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
> @@ -1621,17 +1656,40 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  	struct device_node *node = indio_dev->dev.of_node;
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
> +	struct stm32_adc_diff_channel diff[STM32_ADC_CH_MAX];
>  	struct property *prop;
>  	const __be32 *cur;
>  	struct iio_chan_spec *channels;
> -	int scan_index = 0, num_channels, ret;
> +	int scan_index = 0, num_channels = 0, num_diff = 0, ret, i;
>  	u32 val, smp = 0;
>  
> -	num_channels = of_property_count_u32_elems(node, "st,adc-channels");
> -	if (num_channels < 0 ||
> -	    num_channels > adc_info->max_channels) {
> +	ret = of_property_count_u32_elems(node, "st,adc-channels");
> +	if (ret > adc_info->max_channels) {
>  		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
> -		return num_channels < 0 ? num_channels : -EINVAL;
> +		return -EINVAL;
> +	} else if (ret > 0) {
> +		num_channels += ret;
> +	}
> +
> +	ret = of_property_count_elems_of_size(node, "st,adc-diff-channels",
> +					      sizeof(*diff));
> +	if (ret > adc_info->max_channels) {
> +		dev_err(&indio_dev->dev, "Bad st,adc-diff-channels?\n");
> +		return -EINVAL;
> +	} else if (ret > 0) {
> +		int size = ret * sizeof(*diff) / sizeof(u32);
> +
> +		num_diff = ret;
> +		num_channels += ret;
> +		ret = of_property_read_u32_array(node, "st,adc-diff-channels",
> +						 (u32 *)diff, size);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!num_channels) {
> +		dev_err(&indio_dev->dev, "No channels configured\n");
> +		return -ENODATA;
>  	}
>  
>  	/* Optional sample time is provided either for each, or all channels */
> @@ -1652,6 +1710,33 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  			return -EINVAL;
>  		}
>  
> +		/* Channel can't be configured both as single-ended & diff */
> +		for (i = 0; i < num_diff; i++) {
> +			if (val == diff[i].vinp) {
> +				dev_err(&indio_dev->dev,
> +					"channel %d miss-configured\n",	val);
> +				return -EINVAL;
> +			}
> +		}
> +		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
> +					0, scan_index, false);
> +		scan_index++;
> +	}
> +
> +	for (i = 0; i < num_diff; i++) {
> +		if (diff[i].vinp >= adc_info->max_channels ||
> +		    diff[i].vinn >= adc_info->max_channels) {
> +			dev_err(&indio_dev->dev, "Invalid channel in%d-in%d\n",
> +				diff[i].vinp, diff[i].vinn);
> +			return -EINVAL;
> +		}
> +		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> +					diff[i].vinp, diff[i].vinn, scan_index,
> +					true);
> +		scan_index++;
> +	}
> +
> +	for (i = 0; i < scan_index; i++) {
>  		/*
>  		 * Using of_property_read_u32_index(), smp value will only be
>  		 * modified if valid u32 value can be decoded. This allows to
> @@ -1659,11 +1744,9 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  		 * value per channel.
>  		 */
>  		of_property_read_u32_index(node, "st,min-sample-time-nsecs",
> -					   scan_index, &smp);
> -
> -		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> -					val, scan_index, smp);
> -		scan_index++;
> +					   i, &smp);
> +		/* Prepare sampling time settings */
> +		stm32_adc_smpr_init(adc, channels[i].channel, smp);
>  	}
>  
>  	indio_dev->num_channels = scan_index;

