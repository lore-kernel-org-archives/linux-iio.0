Return-Path: <jic23@kernel.org>
Message-ID: <52B0B651.3000805@kernel.org>
Date: Tue, 17 Dec 2013 20:38:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
 stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 03/24] iio:adc:ad7887 Fix channel reported endianness
 from cpu to big endian
References: <1386787542-19666-1-git-send-email-jic23@kernel.org> <1386787542-19666-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-4-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/11/13 18:45, Jonathan Cameron wrote:
> Note this also sets the endianness to big endian whereas it would
> previously have defaulted to the cpu endian.  Hence technically
> this is a bug fix on LE platforms.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Applied to the fixes togreg branch of iio.git with the formatting fix.

> ---
>  drivers/iio/adc/ad7887.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index acb7f90359a3..3ce0160b6398 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -200,7 +200,13 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
>  			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  			.address = 1,
>  			.scan_index = 1,
> -			.scan_type = IIO_ST('u', 12, 16, 0),
> +			.scan_type = {
> +				.sign = 'u',
> +				.realbits = 12,
> +				.storagebits = 16,
> +				.shift = 0,
> +				.endianness = IIO_BE,
> +				},
>  		},
>  		.channel[1] = {
>  			.type = IIO_VOLTAGE,
> @@ -210,7 +216,13 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
>  			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  			.address = 0,
>  			.scan_index = 0,
> -			.scan_type = IIO_ST('u', 12, 16, 0),
> +			.scan_type = {
> +				.sign = 'u',
> +				.realbits = 12,
> +				.storagebits = 16,
> +				.shift = 0,
> +				.endianness = IIO_BE,
> +				},
>  		},
>  		.channel[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
>  		.int_vref_mv = 2500,
> 
