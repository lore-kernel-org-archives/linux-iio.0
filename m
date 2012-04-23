Return-Path: <jic23@kernel.org>
Message-ID: <4F95BE84.9030601@kernel.org>
Date: Mon, 23 Apr 2012 21:41:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/8] staging:iio:dac:ad5446: Remove unused struct field
References: <1335203497-11041-1-git-send-email-lars@metafoo.de> <1335203497-11041-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1335203497-11041-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/23/2012 06:51 PM, Lars-Peter Clausen wrote:
> Remove the unused "poll_work" field from the ad5446_state struct.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/ad5446.h |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
> index 4ea3476..72ad07f 100644
> --- a/drivers/staging/iio/dac/ad5446.h
> +++ b/drivers/staging/iio/dac/ad5446.h
> @@ -34,7 +34,6 @@
>   * @spi:		spi_device
>   * @chip_info:		chip model specific constants, available modes etc
>   * @reg:		supply regulator
> - * @poll_work:		bottom half of polling interrupt handler
>   * @vref_mv:		actual reference voltage used
>   * @xfer:		default spi transfer
>   * @msg:		default spi message
> @@ -45,7 +44,6 @@ struct ad5446_state {
>  	struct spi_device		*spi;
>  	const struct ad5446_chip_info	*chip_info;
>  	struct regulator		*reg;
> -	struct work_struct		poll_work;
>  	unsigned short			vref_mv;
>  	unsigned			cached_val;
>  	unsigned			pwr_down_mode;
