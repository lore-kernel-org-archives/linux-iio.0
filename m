Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42301 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbcJ3Odl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 10:33:41 -0400
Subject: Re: [PATCH 05/10] iio: adc: stm32: add trigger polarity ext attr
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
 <1477412722-24061-6-git-send-email-fabrice.gasnier@st.com>
Cc: linux@armlinux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <42d0ccc5-7fcd-f30b-42b2-fdd2591984d1@kernel.org>
Date: Sun, 30 Oct 2016 14:33:38 +0000
MIME-Version: 1.0
In-Reply-To: <1477412722-24061-6-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/16 17:25, Fabrice Gasnier wrote:
> Add trigger polarity extended attribute.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
ABI always needs documenting.  Add docs also makes it easy to review
without diving into the code.

This will also need a convincing argument for why it doesn't belong in the
device tree.

J
> ---
>  drivers/iio/adc/stm32/stm32-adc.c   | 41 ++++++++++++++++++++++++++++++++++++-
>  drivers/iio/adc/stm32/stm32-adc.h   |  4 ++++
>  drivers/iio/adc/stm32/stm32f4-adc.c | 12 +++++++++++
>  3 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32/stm32-adc.c b/drivers/iio/adc/stm32/stm32-adc.c
> index 1a13450..9b4b459 100644
> --- a/drivers/iio/adc/stm32/stm32-adc.c
> +++ b/drivers/iio/adc/stm32/stm32-adc.c
> @@ -207,7 +207,11 @@ static int stm32_adc_set_trig(struct iio_dev *indio_dev,
>  
>  		/* trigger source */
>  		extsel = trig_info[ret].extsel;
> -		exten = STM32_EXTEN_HWTRIG_RISING_EDGE;
> +
> +		/* default to rising edge if no polarity */
> +		if (adc->exten == STM32_EXTEN_SWTRIG)
> +			adc->exten = STM32_EXTEN_HWTRIG_RISING_EDGE;
> +		exten = adc->exten;
>  	}
>  
>  	spin_lock_irqsave(&adc->lock, flags);
> @@ -221,6 +225,40 @@ static int stm32_adc_set_trig(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static int stm32_adc_set_trig_pol(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int type)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
> +	adc->exten = type;
> +
> +	return 0;
> +}
> +
> +static int stm32_adc_get_trig_pol(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
> +	return adc->exten;
> +}
> +
> +static const char * const stm32_trig_pol_items[] = {
> +	[STM32_EXTEN_SWTRIG] = "swtrig",
> +	[STM32_EXTEN_HWTRIG_RISING_EDGE] = "rising-edge",
> +	[STM32_EXTEN_HWTRIG_FALLING_EDGE] = "falling-edge",
> +	[STM32_EXTEN_HWTRIG_BOTH_EDGES] = "both-edges",
> +};
> +
> +const struct iio_enum stm32_adc_trig_pol = {
> +	.items = stm32_trig_pol_items,
> +	.num_items = ARRAY_SIZE(stm32_trig_pol_items),
> +	.get = stm32_adc_get_trig_pol,
> +	.set = stm32_adc_set_trig_pol,
> +};
> +EXPORT_SYMBOL_GPL(stm32_adc_trig_pol);
> +
>  /**
>   * stm32_adc_conv_irq_enable() - Unmask end of conversion irq
>   * @adc: stm32 adc instance
> @@ -893,6 +931,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
>  	chan->scan_type.realbits = adc->common->data->highres;
>  	chan->scan_type.storagebits = STM32_STORAGEBITS;
>  	chan->scan_type.shift = 0;
> +	chan->ext_info = adc->common->data->ext_info;
>  }
>  
>  static int stm32_adc_chan_of_init(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/adc/stm32/stm32-adc.h b/drivers/iio/adc/stm32/stm32-adc.h
> index fe3568b..6c9b70d 100644
> --- a/drivers/iio/adc/stm32/stm32-adc.h
> +++ b/drivers/iio/adc/stm32/stm32-adc.h
> @@ -234,6 +234,7 @@ struct stm32_adc_reginfo {
>   * @ext_triggers:	Reference to trigger info for regular channels
>   * @jext_triggers:	Reference to trigger info for injected channels
>   * @adc_reginfo:	stm32 ADC registers description
> + * @ext_info:		Extended channel info
>   * @highres:		Max resolution
>   * @max_clock_rate:	Max input clock rate
>   * @clk_sel:		routine to select common clock and prescaler
> @@ -251,6 +252,7 @@ struct stm32_adc_ops {
>  	const struct stm32_adc_trig_info *ext_triggers;
>  	const struct stm32_adc_trig_info *jext_triggers;
>  	const struct stm32_adc_reginfo *adc_reginfo;
> +	const struct iio_chan_spec_ext_info *ext_info;
>  	int highres;
>  	unsigned long max_clock_rate;
>  	int (*clk_sel)(struct stm32_adc *adc);
> @@ -273,6 +275,7 @@ struct stm32_adc_ops {
>   * @id:			ADC instance number (e.g. adc 1, 2 or 3)
>   * @offset:		ADC instance register offset in ADC block
>   * @max_channels:	Max channels number for this ADC.
> + * @exten:		External trigger config (enable/polarity)
>   * @extrig_list:	External trigger list (for regular channel)
>   * @completion:		end of single conversion completion
>   * @buffer:		data buffer
> @@ -295,6 +298,7 @@ struct stm32_adc {
>  	int			id;
>  	int			offset;
>  	int			max_channels;
> +	enum stm32_adc_exten	exten;
>  	struct list_head	extrig_list;
>  	struct completion	completion;
>  	u16			*buffer;
> diff --git a/drivers/iio/adc/stm32/stm32f4-adc.c b/drivers/iio/adc/stm32/stm32f4-adc.c
> index 4d7a2a8..e033a68 100644
> --- a/drivers/iio/adc/stm32/stm32f4-adc.c
> +++ b/drivers/iio/adc/stm32/stm32f4-adc.c
> @@ -555,11 +555,23 @@ static int stm32f4_adc_clk_sel(struct stm32_adc *adc)
>  	return 0;
>  }
>  
> +static const struct iio_chan_spec_ext_info stm32f4_adc_ext_info[] = {
> +	IIO_ENUM("trigger_pol", IIO_SHARED_BY_ALL, &stm32_adc_trig_pol),
> +	{
> +		.name = "trigger_pol_available",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = iio_enum_available_read,
> +		.private = (uintptr_t)&stm32_adc_trig_pol,
> +	},
> +	{},
> +};
> +
>  static const struct stm32_adc_ops stm32f4_adc_ops = {
>  	.adc_info = stm32f4_adc_info,
>  	.ext_triggers = stm32f4_adc_ext_triggers,
>  	.jext_triggers = stm32f4_adc_jext_triggers,
>  	.adc_reginfo = &stm32f4_adc_reginfo,
> +	.ext_info = stm32f4_adc_ext_info,
>  	.highres = 12,
>  	.max_clock_rate = 36000000,
>  	.clk_sel = stm32f4_adc_clk_sel,
> 

