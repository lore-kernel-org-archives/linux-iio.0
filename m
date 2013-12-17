Return-Path: <jic23@kernel.org>
Message-ID: <52B0B638.7060004@kernel.org>
Date: Tue, 17 Dec 2013 20:38:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
 stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 02/24] iio:imu:adis16400 fix pressure channel scan type
References: <1386787542-19666-1-git-send-email-jic23@kernel.org> <1386787542-19666-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-3-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/11/13 18:45, Jonathan Cameron wrote:
> A single channel in this driver was using the IIO_ST macro.
> This does not provide a parameter for setting the endianness of
> the channel.  Thus this channel will have been reported as whatever
> is the native endianness of the cpu rather than big endian. This
> means it would be incorrect on little endian platforms.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Applied to the fixes-togreg branch of iio.git
> ---
>  drivers/iio/imu/adis16400_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 3fb7757a1028..368660dfe135 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -651,7 +651,12 @@ static const struct iio_chan_spec adis16448_channels[] = {
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  		.address = ADIS16448_BARO_OUT,
>  		.scan_index = ADIS16400_SCAN_BARO,
> -		.scan_type = IIO_ST('s', 16, 16, 0),
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
>  	},
>  	ADIS16400_TEMP_CHAN(ADIS16448_TEMP_OUT, 12),
>  	IIO_CHAN_SOFT_TIMESTAMP(11)
> 
