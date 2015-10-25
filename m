Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58962 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbbJYMOj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 08:14:39 -0400
Subject: Re: [PATCH v2] vf610_adc: Fix internal temperature calculation
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, stefan@agner.ch,
	linux-iio@vger.kernel.org
References: <1445270076-10725-1-git-send-email-bhuvanchandra.dv@toradex.com>
Cc: B38611@freescale.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, shawn.guo@linaro.org,
	linux-kernel@vger.kernel.org, maitysanchayan@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <562CC7AB.5050902@kernel.org>
Date: Sun, 25 Oct 2015 12:14:35 +0000
MIME-Version: 1.0
In-Reply-To: <1445270076-10725-1-git-send-email-bhuvanchandra.dv@toradex.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/15 16:54, Bhuvanchandra DV wrote:
> Calculate ADCR_VTEMP25 using VTEMP25 at VREFH_ADC 3V3. Existing
> calculations consider the typical values provided in datasheet.
> Those typical values are valid for VREFH_ADC at 3.0V. VTEMP25
> is different for different VREFH_ADC voltages. With VREFH_ADC
> at 3.3V, voltage at 25°C is 0.699V. Hence update the VTEMP25
> to 0.699V which gives ADCR@Temp25 as 867.
> 
> Formula for finding ADCR@Temp25:
> ADCR@Temp25 = (ADCR@Vdd * V@TEMP25 * 10) / VDDconv
> 
> ADCR@Vdd for 12-Bit ADC = 4095
> VDDconv = VREFH_ADC * 10
> 
> VREFH_ADC@3.3V
> ADCR@Temp25 = (4095 * .699 * 10) / 33
> ADCR@Temp25 ~= 867
> 
> | VREFH_ADC | V@TEMP25 | VDDconv | ADCR@Temp25 |
> |   3.0V    | 0.696mV  |    30   |     950     |
> |   3.3V    | 0.699mV  |    33   |     867     |
> 
> Acked-by: Fugang Duan <B38611@freescale.com>
> 
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
Note these won't now go anywhere until after the release occurs
(to close for a fix for something that has been true a while)

Note standard ordering of signed-off by etc is

Author sign off
Reviewer acked by
My sign off (though I add this).
> ---
>  drivers/iio/adc/vf610_adc.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index f4df2a7..e7abc13 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -103,6 +103,13 @@
>  
>  #define DEFAULT_SAMPLE_TIME		1000
>  
> +/* V at 25°C of 696 mV */
> +#define VF610_VTEMP25_3V0		950
> +/* V at 25°C of 699 mV */
> +#define VF610_VTEMP25_3V3		867
> +/* Typical sensor slope coefficient at all temperatures */
> +#define VF610_TEMP_SLOPE_COEFF		1840
> +
>  enum clk_sel {
>  	VF610_ADCIOC_BUSCLK_SET,
>  	VF610_ADCIOC_ALTCLK_SET,
> @@ -636,11 +643,13 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		case IIO_TEMP:
>  			/*
> -			* Calculate in degree Celsius times 1000
> -			* Using sensor slope of 1.84 mV/°C and
> -			* V at 25°C of 696 mV
> -			*/
> -			*val = 25000 - ((int)info->value - 864) * 1000000 / 1840;
> +			 * Calculate in degree Celsius times 1000
> +			 * Using the typical sensor slope of 1.84 mV/°C
> +			 * and VREFH_ADC at 3.3V, V at 25°C of 699 mV
> +			 */
> +			*val = 25000 - ((int)info->value - VF610_VTEMP25_3V3) *
> +					1000000 / VF610_TEMP_SLOPE_COEFF;
> +
>  			break;
>  		default:
>  			mutex_unlock(&indio_dev->mlock);
> 

