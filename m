Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38554 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeANMhr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jan 2018 07:37:47 -0500
Date: Sun, 14 Jan 2018 12:37:45 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] staging: iio: adc: ad7192: fix external frequency
 setting
Message-ID: <20180114123745.7a1180ca@archlinux>
In-Reply-To: <20180110112956.23931-1-alexandru.ardelean@analog.com>
References: <20180110112956.23931-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 10 Jan 2018 13:29:54 +0200
<alexandru.ardelean@analog.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> According to the datasheet:
> * 0 - external crystal, connected from pin MCLK1 to MCLK2

What frequency of crystal?  My quick read of the datasheet
implies this may be flexible.  Possibly as flexible as
the clock option...


> * 1 - external clock, applied to MCLK2 pin
> * 2 - internal 4.92 Mhz clock; pin MCLK2 is tristated
> * 3 - internal 4.92 Mhz clock; internal clock is available on MCLK2
> 
> Which means that the external clock value only has sense
> for value 1 (AD7192_CLK_EXT_MCLK2).
> 
> Also added range validation for the external frequency
> setting, which the datasheet mentions that it's
> between 2.4576 and 5.12 Mhz.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/staging/iio/adc/ad7192.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 7f204013d6d4..7bc04101d133 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -141,6 +141,8 @@
>  #define AD7192_GPOCON_P1DAT	BIT(1) /* P1 state */
>  #define AD7192_GPOCON_P0DAT	BIT(0) /* P0 state */
>  
> +#define AD7192_EXT_FREQ_MHZ_MIN	2457600
> +#define AD7192_EXT_FREQ_MHZ_MAX	5120000
>  #define AD7192_INT_FREQ_MHZ	4915200
>  
>  /* NOTE:
> @@ -217,6 +219,12 @@ static int ad7192_calibrate_all(struct ad7192_state *st)
>  				ARRAY_SIZE(ad7192_calib_arr));
>  }
>  
> +static inline bool ad7192_valid_external_frequency(u32 freq)
> +{
> +	return (freq >= AD7192_EXT_FREQ_MHZ_MIN &&
> +		freq <= AD7192_EXT_FREQ_MHZ_MAX);
> +}
> +
>  static int ad7192_setup(struct ad7192_state *st,
>  			const struct ad7192_platform_data *pdata)
>  {
> @@ -245,16 +253,16 @@ static int ad7192_setup(struct ad7192_state *st,
>  
>  	switch (pdata->clock_source_sel) {
>  	case AD7192_CLK_EXT_MCLK1_2:
> -	case AD7192_CLK_EXT_MCLK2:
> -		st->mclk = AD7192_INT_FREQ_MHZ;
> -		break;
>  	case AD7192_CLK_INT:
>  	case AD7192_CLK_INT_CO:
> -		if (pdata->ext_clk_hz)
> -			st->mclk = pdata->ext_clk_hz;
> -		else
> -			st->mclk = AD7192_INT_FREQ_MHZ;
> +		st->mclk = AD7192_INT_FREQ_MHZ;
>  		break;
> +	case AD7192_CLK_EXT_MCLK2:
> +		if (ad7192_valid_external_frequency(pdata->clock_source_sel)) {
> +			st->mclk = pdata->clock_source_sel;
> +			break;
> +		}
> +		/* FALLTHROUGH */
>  	default:
>  		ret = -EINVAL;
>  		goto out;

