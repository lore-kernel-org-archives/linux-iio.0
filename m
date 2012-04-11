Return-Path: <lars@metafoo.de>
Message-ID: <4F856F07.9030401@metafoo.de>
Date: Wed, 11 Apr 2012 13:46:15 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 12/14] staging:iio:impedance-analyzer:ad5933 unwind use
 of IIO_CHAN macro.
References: <1334089310-22576-1-git-send-email-jic23@kernel.org> <1334089310-22576-13-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-13-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/10/2012 10:21 PM, Jonathan Cameron wrote:
> This macro is being removed to simplify ongoing maintenance
> so we need to unwind and remaining users.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>

The cocci patches disagrees on one occasion, but I think it's a bug in the
original driver again.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c |   47 ++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index cd82b56..06b9fe2 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -109,15 +109,44 @@ static struct ad5933_platform_data ad5933_default_pdata  = {
>  };
>  
>  static struct iio_chan_spec ad5933_channels[] = {
> -	IIO_CHAN(IIO_TEMP, 0, 1, 1, NULL, 0, 0, 0,
> -		 0, AD5933_REG_TEMP_DATA, IIO_ST('s', 14, 16, 0), 0),
> -	/* Ring Channels */
> -	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "real_raw", 0, 0,
> -		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> -		 AD5933_REG_REAL_DATA, 0, IIO_ST('s', 16, 16, 0), 0),
> -	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "imag_raw", 0, 0,
> -		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> -		 AD5933_REG_IMAG_DATA, 1, IIO_ST('s', 16, 16, 0), 0),
> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.processed_val = 1,
> +		.channel = 0,
> +		.address = AD5933_REG_TEMP_DATA,

address was set to 0 and scan_index was set to AD5933_REG_TEMP_DATA with the
original code, but that doesn't make any sense.

> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 14,
> +			.storagebits = 16,
> +		},
> +	}
