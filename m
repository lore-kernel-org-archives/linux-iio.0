Return-Path: <SRS0=TAb7=7G=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] iio: imu: adis16480: Fix acceleration scale factor for
 adis16480
To: Dragos Bogdan <dragos.bogdan@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20170803223727.14472-1-dragos.bogdan@analog.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e34f87db-694c-e83e-5ee8-ff93d4f63e39@metafoo.de>
Date: Fri, 4 Aug 2017 05:49:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170803223727.14472-1-dragos.bogdan@analog.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 08/04/2017 12:37 AM, Dragos Bogdan wrote:
> According to the datasheet, the range of the acceleration is [-10 g, + 10 g],
> so the scale factor should be 10 instead of 5.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  drivers/iio/imu/adis16480.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 8cf84d3488b2..12898424d838 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -696,7 +696,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.gyro_max_val = IIO_RAD_TO_DEGREE(22500),
>  		.gyro_max_scale = 450,
>  		.accel_max_val = IIO_M_S_2_TO_G(12500),
> -		.accel_max_scale = 5,
> +		.accel_max_scale = 10,
>  	},
>  	[ADIS16485] = {
>  		.channels = adis16485_channels,
> 
