Return-Path: <jic23@kernel.org>
Message-ID: <4F95C68C.4010705@kernel.org>
Date: Mon, 23 Apr 2012 22:15:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 5/8] staging:iio:dac:ad5446: Remove duplicated write sample
 functions
References: <1335203497-11041-1-git-send-email-lars@metafoo.de> <1335203497-11041-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1335203497-11041-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/23/2012 06:51 PM, Lars-Peter Clausen wrote:
> AD5620_LOAD and AD5446_LOAD are both 0, so all these three functions are
> identical and we can replace them with only one.
Nice spot.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/ad5446.c |   30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index 693485a..6b8f341 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -26,19 +26,9 @@
>  
>  static void ad5446_store_sample(struct ad5446_state *st, unsigned val)
>  {
> -	st->data.d16 = cpu_to_be16(AD5446_LOAD | val);
> -}
> -
> -static void ad5542_store_sample(struct ad5446_state *st, unsigned val)
> -{
>  	st->data.d16 = cpu_to_be16(val);
>  }
>  
> -static void ad5620_store_sample(struct ad5446_state *st, unsigned val)
> -{
> -	st->data.d16 = cpu_to_be16(AD5620_LOAD | val);
> -}
> -
>  static void ad5660_store_sample(struct ad5446_state *st, unsigned val)
>  {
>  	val |= AD5660_LOAD;
> @@ -174,53 +164,53 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  	},
>  	[ID_AD5541A] = {
>  		.channel = AD5446_CHANNEL(16, 16, 0),
> -		.store_sample = ad5542_store_sample,
> +		.store_sample = ad5446_store_sample,
>  	},
>  	[ID_AD5512A] = {
>  		.channel = AD5446_CHANNEL(12, 16, 4),
> -		.store_sample = ad5542_store_sample,
> +		.store_sample = ad5446_store_sample,
>  	},
>  	[ID_AD5553] = {
>  		.channel = AD5446_CHANNEL(14, 16, 0),
> -		.store_sample = ad5542_store_sample,
> +		.store_sample = ad5446_store_sample,
>  	},
>  	[ID_AD5601] = {
>  		.channel = AD5446_CHANNEL(8, 16, 6),
> -		.store_sample = ad5542_store_sample,
> +		.store_sample = ad5446_store_sample,
>  		.store_pwr_down = ad5620_store_pwr_down,
>  	},
>  	[ID_AD5611] = {
>  		.channel = AD5446_CHANNEL(10, 16, 4),
> -		.store_sample = ad5542_store_sample,
> +		.store_sample = ad5446_store_sample,
>  		.store_pwr_down = ad5620_store_pwr_down,
>  	},
>  	[ID_AD5621] = {
>  		.channel = AD5446_CHANNEL(12, 16, 2),
> -		.store_sample = ad5542_store_sample,
> +		.store_sample = ad5446_store_sample,
>  		.store_pwr_down = ad5620_store_pwr_down,
>  	},
>  	[ID_AD5620_2500] = {
>  		.channel = AD5446_CHANNEL(12, 16, 2),
>  		.int_vref_mv = 2500,
> -		.store_sample = ad5620_store_sample,
> +		.store_sample = ad5446_store_sample,
>  		.store_pwr_down = ad5620_store_pwr_down,
>  	},
>  	[ID_AD5620_1250] = {
>  		.channel = AD5446_CHANNEL(12, 16, 2),
>  		.int_vref_mv = 1250,
> -		.store_sample = ad5620_store_sample,
> +		.store_sample = ad5446_store_sample,
>  		.store_pwr_down = ad5620_store_pwr_down,
>  	},
>  	[ID_AD5640_2500] = {
>  		.channel = AD5446_CHANNEL(14, 16, 0),
>  		.int_vref_mv = 2500,
> -		.store_sample = ad5620_store_sample,
> +		.store_sample = ad5446_store_sample,
>  		.store_pwr_down = ad5620_store_pwr_down,
>  	},
>  	[ID_AD5640_1250] = {
>  		.channel = AD5446_CHANNEL(14, 16, 0),
>  		.int_vref_mv = 1250,
> -		.store_sample = ad5620_store_sample,
> +		.store_sample = ad5446_store_sample,
>  		.store_pwr_down = ad5620_store_pwr_down,
>  	},
>  	[ID_AD5660_2500] = {
