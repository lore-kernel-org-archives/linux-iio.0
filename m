Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934210AbdEXTSe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 15:18:34 -0400
Date: Wed, 24 May 2017 20:18:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature
Message-ID: <20170524201831.3504c42d@kernel.org>
In-Reply-To: <20170523005146.726-2-tony@atomide.com>
References: <20170523005146.726-1-tony@atomide.com>
        <20170523005146.726-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 22 May 2017 17:51:44 -0700
Tony Lindgren <tony@atomide.com> wrote:

> Looking at the register dumps from Android kernel on droid 4, I noticed
> the values with the mainline kernel don't match. Let's fix this by
> initializing the ADC registers to what Android does.
> 
> For getting correct values from the battery thermistor, we need to
> toggle the CPCAP_BIT_THERMBIAS_EN when measuring battery temperature
> to get correct battery temperatures. And looks like we also need to
> wait a little bit before reading the battery temperature as otherwise
> the results are inaccurate.
> 
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
Applied to the togreg branch of iio.git and will be shortly pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/cpcap-adc.c | 58 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -52,6 +52,10 @@
>  #define CPCAP_BIT_RAND0			BIT(1)	/* Set with CAL_MODE */
>  #define CPCAP_BIT_ADEN			BIT(0)	/* Currently unused */
>  
> +#define CPCAP_REG_ADCC1_DEFAULTS	(CPCAP_BIT_ADEN_AUTO_CLR | \
> +					 CPCAP_BIT_ADC_CLK_SEL0 |  \
> +					 CPCAP_BIT_RAND1)
> +
>  /* Register CPCAP_REG_ADCC2 bits */
>  #define CPCAP_BIT_CAL_FACTOR_ENABLE	BIT(15)	/* Currently unused */
>  #define CPCAP_BIT_BATDETB_EN		BIT(14)	/* Currently unused */
> @@ -62,7 +66,7 @@
>  #define CPCAP_BIT_ADC_PS_FACTOR0	BIT(9)
>  #define CPCAP_BIT_AD4_SELECT		BIT(8)	/* Currently unused */
>  #define CPCAP_BIT_ADC_BUSY		BIT(7)	/* Currently unused */
> -#define CPCAP_BIT_THERMBIAS_EN		BIT(6)	/* Currently unused */
> +#define CPCAP_BIT_THERMBIAS_EN		BIT(6)	/* Bias for AD0_BATTDETB */
>  #define CPCAP_BIT_ADTRIG_DIS		BIT(5)	/* Disable interrupt */
>  #define CPCAP_BIT_LIADC			BIT(4)	/* Currently unused */
>  #define CPCAP_BIT_TS_REFEN		BIT(3)	/* Currently unused */
> @@ -70,6 +74,13 @@
>  #define CPCAP_BIT_TS_M1			BIT(1)	/* Currently unused */
>  #define CPCAP_BIT_TS_M0			BIT(0)	/* Currently unused */
>  
> +#define CPCAP_REG_ADCC2_DEFAULTS	(CPCAP_BIT_AD4_SELECT | \
> +					 CPCAP_BIT_ADTRIG_DIS | \
> +					 CPCAP_BIT_ADTRIG_DIS | \
> +					 CPCAP_BIT_LIADC | \
> +					 CPCAP_BIT_TS_M2 | \
> +					 CPCAP_BIT_TS_M1)
> +
>  #define CPCAP_MAX_TEMP_LVL		27
>  #define CPCAP_FOUR_POINT_TWO_ADC	801
>  #define ST_ADC_CAL_CHRGI_HIGH_THRESHOLD	530
> @@ -124,10 +135,10 @@ struct cpcap_adc {
>   */
>  enum cpcap_adc_channel {
>  	/* Bank0 channels */
> -	CPCAP_ADC_AD0_BATTDETB,	/* Battery detection */
> +	CPCAP_ADC_AD0,		/* Battery temperature */
>  	CPCAP_ADC_BATTP,	/* Battery voltage */
>  	CPCAP_ADC_VBUS,		/* USB VBUS voltage */
> -	CPCAP_ADC_AD3,		/* Battery temperature when charging */
> +	CPCAP_ADC_AD3,		/* Die temperature when charging */
>  	CPCAP_ADC_BPLUS_AD4,	/* Another battery or system voltage */
>  	CPCAP_ADC_CHG_ISENSE,	/* Calibrated charge current */
>  	CPCAP_ADC_BATTI,	/* Calibrated system current */
> @@ -217,7 +228,7 @@ struct cpcap_adc_request {
>  /* Phasing table for channels. Note that channels 16 & 17 use BATTP and BATTI */
>  static const struct cpcap_adc_phasing_tbl bank_phasing[] = {
>  	/* Bank0 */
> -	[CPCAP_ADC_AD0_BATTDETB] = {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_AD0] =          {0, 0x80, 0x80,    0, 1023},
>  	[CPCAP_ADC_BATTP] =        {0, 0x80, 0x80,    0, 1023},
>  	[CPCAP_ADC_VBUS] =         {0, 0x80, 0x80,    0, 1023},
>  	[CPCAP_ADC_AD3] =          {0, 0x80, 0x80,    0, 1023},
> @@ -243,7 +254,7 @@ static const struct cpcap_adc_phasing_tbl bank_phasing[] = {
>   */
>  static struct cpcap_adc_conversion_tbl bank_conversion[] = {
>  	/* Bank0 */
> -	[CPCAP_ADC_AD0_BATTDETB] = {
> +	[CPCAP_ADC_AD0] = {
>  		IIO_CHAN_INFO_PROCESSED,    0,    0, 0,     1,    1,
>  	},
>  	[CPCAP_ADC_BATTP] = {
> @@ -541,6 +552,15 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
>  		return;
>  
>  	switch (req->channel) {
> +	case CPCAP_ADC_AD0:
> +		value2 |= CPCAP_BIT_THERMBIAS_EN;
> +		error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +					   CPCAP_BIT_THERMBIAS_EN,
> +					   value2);
> +		if (error)
> +			return;
> +		usleep_range(800, 1000);
> +		break;
>  	case CPCAP_ADC_AD8 ... CPCAP_ADC_TSY2_AD15:
>  		value1 |= CPCAP_BIT_AD_SEL1;
>  		break;
> @@ -583,7 +603,8 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
>  	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
>  				   CPCAP_BIT_ATOX_PS_FACTOR |
>  				   CPCAP_BIT_ADC_PS_FACTOR1 |
> -				   CPCAP_BIT_ADC_PS_FACTOR0,
> +				   CPCAP_BIT_ADC_PS_FACTOR0 |
> +				   CPCAP_BIT_THERMBIAS_EN,
>  				   value2);
>  	if (error)
>  		return;
> @@ -664,6 +685,21 @@ static int cpcap_adc_start_bank(struct cpcap_adc *ddata,
>  	return error;
>  }
>  
> +static int cpcap_adc_stop_bank(struct cpcap_adc *ddata)
> +{
> +	int error;
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC1,
> +				   0xffff,
> +				   CPCAP_REG_ADCC1_DEFAULTS);
> +	if (error)
> +		return error;
> +
> +	return regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +				  0xffff,
> +				  CPCAP_REG_ADCC2_DEFAULTS);
> +}
> +
>  static void cpcap_adc_phase(struct cpcap_adc_request *req)
>  {
>  	const struct cpcap_adc_conversion_tbl *conv_tbl = req->conv_tbl;
> @@ -758,7 +794,7 @@ static void cpcap_adc_convert(struct cpcap_adc_request *req)
>  		return;
>  
>  	/* Temperatures use a lookup table instead of conversion table */
> -	if ((req->channel == CPCAP_ADC_AD0_BATTDETB) ||
> +	if ((req->channel == CPCAP_ADC_AD0) ||
>  	    (req->channel == CPCAP_ADC_AD3)) {
>  		req->result =
>  			cpcap_adc_table_to_millicelcius(req->result);
> @@ -820,7 +856,7 @@ static int cpcap_adc_init_request(struct cpcap_adc_request *req,
>  	req->conv_tbl = bank_conversion;
>  
>  	switch (channel) {
> -	case CPCAP_ADC_AD0_BATTDETB ... CPCAP_ADC_USB_ID:
> +	case CPCAP_ADC_AD0 ... CPCAP_ADC_USB_ID:
>  		req->bank_index = channel;
>  		break;
>  	case CPCAP_ADC_AD8 ... CPCAP_ADC_TSY2_AD15:
> @@ -860,6 +896,9 @@ static int cpcap_adc_read(struct iio_dev *indio_dev,
>  		error = regmap_read(ddata->reg, chan->address, val);
>  		if (error)
>  			goto err_unlock;
> +		error = cpcap_adc_stop_bank(ddata);
> +		if (error)
> +			goto err_unlock;
>  		mutex_unlock(&ddata->lock);
>  		break;
>  	case IIO_CHAN_INFO_PROCESSED:
> @@ -870,6 +909,9 @@ static int cpcap_adc_read(struct iio_dev *indio_dev,
>  		error = cpcap_adc_read_bank_scaled(ddata, &req);
>  		if (error)
>  			goto err_unlock;
> +		error = cpcap_adc_stop_bank(ddata);
> +		if (error)
> +			goto err_unlock;
>  		mutex_unlock(&ddata->lock);
>  		*val = req.result;
>  		break;

