Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932203AbdJUR7P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:59:15 -0400
Date: Sat, 21 Oct 2017 18:59:09 +0100
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
Subject: Re: [PATCH 2/3] iio: adc: stm32: remove const channel names
 definition
Message-ID: <20171021185909.272ec00a@archlinux>
In-Reply-To: <1508246145-19417-3-git-send-email-fabrice.gasnier@st.com>
References: <1508246145-19417-1-git-send-email-fabrice.gasnier@st.com>
        <1508246145-19417-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 17 Oct 2017 15:15:44 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Remove const array that defines channels. Build channels definition
> at probe time, when initializing channels (only for requested ones).
> This will ease adding differential channels support.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Looks good to me.
> ---
>  drivers/iio/adc/stm32-adc.c | 66 ++++++++++-----------------------------------
>  1 file changed, 14 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 4df32cf..c95e6f7 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -153,6 +153,8 @@ enum stm32h7_adc_dmngt {
>  /* BOOST bit must be set on STM32H7 when ADC clock is above 20MHz */
>  #define STM32H7_BOOST_CLKRATE		20000000UL
>  
> +#define STM32_ADC_CH_MAX		20	/* max number of channels */
> +#define STM32_ADC_CH_SZ			5	/* max channel name size */
>  #define STM32_ADC_MAX_SQ		16	/* SQ1..SQ16 */
>  #define STM32_ADC_MAX_SMP		7	/* SMPx range is [0..7] */
>  #define STM32_ADC_TIMEOUT_US		100000
> @@ -300,6 +302,7 @@ struct stm32_adc_cfg {
>   * @pcsel		bitmask to preselect channels on some devices
>   * @smpr_val:		sampling time settings (e.g. smpr1 / smpr2)
>   * @cal:		optional calibration data on some devices
> + * @chan_name:		channel name array
>   */
>  struct stm32_adc {
>  	struct stm32_adc_common	*common;
> @@ -321,69 +324,28 @@ struct stm32_adc {
>  	u32			pcsel;
>  	u32			smpr_val[2];
>  	struct stm32_adc_calib	cal;
> -};
> -
> -/**
> - * struct stm32_adc_chan_spec - specification of stm32 adc channel
> - * @type:	IIO channel type
> - * @channel:	channel number (single ended)
> - * @name:	channel name (single ended)
> - */
> -struct stm32_adc_chan_spec {
> -	enum iio_chan_type	type;
> -	int			channel;
> -	const char		*name;
> +	char			chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
>  };
>  
>  /**
>   * struct stm32_adc_info - stm32 ADC, per instance config data
> - * @channels:		Reference to stm32 channels spec
>   * @max_channels:	Number of channels
>   * @resolutions:	available resolutions
>   * @num_res:		number of available resolutions
>   */
>  struct stm32_adc_info {
> -	const struct stm32_adc_chan_spec *channels;
>  	int max_channels;
>  	const unsigned int *resolutions;
>  	const unsigned int num_res;
>  };
>  
> -/*
> - * Input definitions common for all instances:
> - * stm32f4 can have up to 16 channels
> - * stm32h7 can have up to 20 channels
> - */
> -static const struct stm32_adc_chan_spec stm32_adc_channels[] = {
> -	{ IIO_VOLTAGE, 0, "in0" },
> -	{ IIO_VOLTAGE, 1, "in1" },
> -	{ IIO_VOLTAGE, 2, "in2" },
> -	{ IIO_VOLTAGE, 3, "in3" },
> -	{ IIO_VOLTAGE, 4, "in4" },
> -	{ IIO_VOLTAGE, 5, "in5" },
> -	{ IIO_VOLTAGE, 6, "in6" },
> -	{ IIO_VOLTAGE, 7, "in7" },
> -	{ IIO_VOLTAGE, 8, "in8" },
> -	{ IIO_VOLTAGE, 9, "in9" },
> -	{ IIO_VOLTAGE, 10, "in10" },
> -	{ IIO_VOLTAGE, 11, "in11" },
> -	{ IIO_VOLTAGE, 12, "in12" },
> -	{ IIO_VOLTAGE, 13, "in13" },
> -	{ IIO_VOLTAGE, 14, "in14" },
> -	{ IIO_VOLTAGE, 15, "in15" },
> -	{ IIO_VOLTAGE, 16, "in16" },
> -	{ IIO_VOLTAGE, 17, "in17" },
> -	{ IIO_VOLTAGE, 18, "in18" },
> -	{ IIO_VOLTAGE, 19, "in19" },
> -};
> -
>  static const unsigned int stm32f4_adc_resolutions[] = {
>  	/* sorted values so the index matches RES[1:0] in STM32F4_ADC_CR1 */
>  	12, 10, 8, 6,
>  };
>  
> +/* stm32f4 can have up to 16 channels */
>  static const struct stm32_adc_info stm32f4_adc_info = {
> -	.channels = stm32_adc_channels,
>  	.max_channels = 16,
>  	.resolutions = stm32f4_adc_resolutions,
>  	.num_res = ARRAY_SIZE(stm32f4_adc_resolutions),
> @@ -394,9 +356,9 @@ struct stm32_adc_info {
>  	16, 14, 12, 10, 8,
>  };
>  
> +/* stm32h7 can have up to 20 channels */
>  static const struct stm32_adc_info stm32h7_adc_info = {
> -	.channels = stm32_adc_channels,
> -	.max_channels = 20,
> +	.max_channels = STM32_ADC_CH_MAX,
>  	.resolutions = stm32h7_adc_resolutions,
>  	.num_res = ARRAY_SIZE(stm32h7_adc_resolutions),
>  };
> @@ -1628,15 +1590,16 @@ static void stm32_adc_smpr_init(struct stm32_adc *adc, int channel, u32 smp_ns)
>  }
>  
>  static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
> -				    struct iio_chan_spec *chan,
> -				    const struct stm32_adc_chan_spec *channel,
> +				    struct iio_chan_spec *chan, u32 val,
>  				    int scan_index, u32 smp)
>  {
>  	struct stm32_adc *adc = iio_priv(indio_dev);
> +	char *name = adc->chan_name[val];
>  
> -	chan->type = channel->type;
> -	chan->channel = channel->channel;
> -	chan->datasheet_name = channel->name;
> +	chan->type = IIO_VOLTAGE;
> +	chan->channel = val;
> +	snprintf(name, STM32_ADC_CH_SZ, "in%d", val);
> +	chan->datasheet_name = name;
>  	chan->scan_index = scan_index;
>  	chan->indexed = 1;
>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> @@ -1699,8 +1662,7 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  					   scan_index, &smp);
>  
>  		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> -					&adc_info->channels[val],
> -					scan_index, smp);
> +					val, scan_index, smp);
>  		scan_index++;
>  	}
>  

