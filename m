Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40252 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaBHKZQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 05:25:16 -0500
Message-ID: <52F60628.6000404@kernel.org>
Date: Sat, 08 Feb 2014 10:25:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Beomho Seo <beomho.seo@samsung.com>, linux-iio@vger.kernel.org,
	ldewangan@nvidia.com
CC: Peter Meerwald <pmeerw@pmeerw.net>,
	Myungjoo Ham <myungjoo.ham@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH RESEND 1/2] iio: ak8975: Fix calculation formula for convert
 micro tesla to gauss unit
References: <52F0AFCF.1090302@samsung.com>
In-Reply-To: <52F0AFCF.1090302@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/02/14 09:15, Beomho Seo wrote:
>
> One micro tesla equal 0.01 gauss. So I have fixed calculation formula And add RAW_TO_GAUSS macro.
> ASA is in the range of 0 to 255. If multiply 0.003, calculation result(in_magn_[*]_scale) is
> always 0. So multiply 3000 and return and IIO_VAL_INT_PLUS_MICRO.
> As a result, read_raw call back function return accurate scale value.
>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Applied to the fixes-togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/magnetometer/ak8975.c |   16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index ff284e5..0542354 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -85,6 +85,7 @@
>   #define AK8975_MAX_CONVERSION_TIMEOUT	500
>   #define AK8975_CONVERSION_DONE_POLL_TIME 10
>   #define AK8975_DATA_READY_TIMEOUT	((100*HZ)/1000)
> +#define RAW_TO_GAUSS(asa) ((((asa) + 128) * 3000) / 256)
>
>   /*
>    * Per-instance context data for the device.
> @@ -265,15 +266,15 @@ static int ak8975_setup(struct i2c_client *client)
>    *
>    * Since 1uT = 0.01 gauss, our final scale factor becomes:
>    *
> - * Hadj = H * ((ASA + 128) / 256) * 3/10 * 100
> - * Hadj = H * ((ASA + 128) * 30 / 256
> + * Hadj = H * ((ASA + 128) / 256) * 3/10 * 1/100
> + * Hadj = H * ((ASA + 128) * 0.003) / 256
>    *
>    * Since ASA doesn't change, we cache the resultant scale factor into the
>    * device context in ak8975_setup().
>    */
> -	data->raw_to_gauss[0] = ((data->asa[0] + 128) * 30) >> 8;
> -	data->raw_to_gauss[1] = ((data->asa[1] + 128) * 30) >> 8;
> -	data->raw_to_gauss[2] = ((data->asa[2] + 128) * 30) >> 8;
> +	data->raw_to_gauss[0] = RAW_TO_GAUSS(data->asa[0]);
> +	data->raw_to_gauss[1] = RAW_TO_GAUSS(data->asa[1]);
> +	data->raw_to_gauss[2] = RAW_TO_GAUSS(data->asa[2]);
>
>   	return 0;
>   }
> @@ -428,8 +429,9 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
>   	case IIO_CHAN_INFO_RAW:
>   		return ak8975_read_axis(indio_dev, chan->address, val);
>   	case IIO_CHAN_INFO_SCALE:
> -		*val = data->raw_to_gauss[chan->address];
> -		return IIO_VAL_INT;
> +		*val = 0;
> +		*val2 = data->raw_to_gauss[chan->address];
> +		return IIO_VAL_INT_PLUS_MICRO;
>   	}
>   	return -EINVAL;
>   }
>

