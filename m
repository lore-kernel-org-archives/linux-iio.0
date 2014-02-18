Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38169 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024AbaBRKTi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 05:19:38 -0500
Message-ID: <530333DF.90808@kernel.org>
Date: Tue, 18 Feb 2014 10:20:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Beomho Seo <beomho.seo@samsung.com>, linux-iio@vger.kernel.org
CC: Myungjoo Ham <myungjoo.ham@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/2] iio: cm36651:  Fix read/write integration time
 function.
References: <52FDEA17.2020808@samsung.com>
In-Reply-To: <52FDEA17.2020808@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/14 10:04, Beomho Seo wrote:
>
> This patch is fixed [read/write] integration time function.
> cm36651 have integration time from 1 to 640 milliseconds.
> But, print more then the thousand second. when call *_integration_time attribute.
> Because read_integration_time function return IIO_VAL_INT.
> read integration time function is changed return IIO_VAL_INT_PLUS_MICRO;
> And then .write_raw_get_fmt callback function for parse a fixed-point number from a string.
> Some description is revised milliseconds unit.
>
> v2: cm36651_write_int_time function fixed as it was.
>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
I have dropped the get_write_fmt callback as int_plus_micro is the default if that isn't
provided.  Hence the callback is unnecessary.

Applied to the fixes-togreg branch of iio.git.

Thanks,

> ---
>   drivers/iio/light/cm36651.c |   53 +++++++++++++++++++++++++------------------
>   1 file changed, 31 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index 0a142af..3dd84ca 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -50,10 +50,10 @@
>   #define CM36651_CS_CONF2_DEFAULT_BIT	0x08
>
>   /* CS_CONF3 channel integration time */
> -#define CM36651_CS_IT1			0x00 /* Integration time 80000 usec */
> -#define CM36651_CS_IT2			0x40 /* Integration time 160000 usec */
> -#define CM36651_CS_IT3			0x80 /* Integration time 320000 usec */
> -#define CM36651_CS_IT4			0xC0 /* Integration time 640000 usec */
> +#define CM36651_CS_IT1			0x00 /* Integration time 80 msec */
> +#define CM36651_CS_IT2			0x40 /* Integration time 160 msec */
> +#define CM36651_CS_IT3			0x80 /* Integration time 320 msec */
> +#define CM36651_CS_IT4			0xC0 /* Integration time 640 msec */
>
>   /* PS_CONF1 command code */
>   #define CM36651_PS_ENABLE		0x00
> @@ -64,10 +64,10 @@
>   #define CM36651_PS_PERS4		0x0C
>
>   /* PS_CONF1 command code: integration time */
> -#define CM36651_PS_IT1			0x00 /* Integration time 320 usec */
> -#define CM36651_PS_IT2			0x10 /* Integration time 420 usec */
> -#define CM36651_PS_IT3			0x20 /* Integration time 520 usec */
> -#define CM36651_PS_IT4			0x30 /* Integration time 640 usec */
> +#define CM36651_PS_IT1			0x00 /* Integration time 0.32 msec */
> +#define CM36651_PS_IT2			0x10 /* Integration time 0.42 msec */
> +#define CM36651_PS_IT3			0x20 /* Integration time 0.52 msec */
> +#define CM36651_PS_IT4			0x30 /* Integration time 0.64 msec */
>
>   /* PS_CONF1 command code: duty ratio */
>   #define CM36651_PS_DR1			0x00 /* Duty ratio 1/80 */
> @@ -93,8 +93,8 @@
>   #define CM36651_CLOSE_PROXIMITY		0x32
>   #define CM36651_FAR_PROXIMITY			0x33
>
> -#define CM36651_CS_INT_TIME_AVAIL	"80000 160000 320000 640000"
> -#define CM36651_PS_INT_TIME_AVAIL	"320 420 520 640"
> +#define CM36651_CS_INT_TIME_AVAIL	"0.08 0.16 0.32 0.64"
> +#define CM36651_PS_INT_TIME_AVAIL	"0.000320 0.000420 0.000520 0.000640"
>
>   enum cm36651_operation_mode {
>   	CM36651_LIGHT_EN,
> @@ -356,30 +356,30 @@ static int cm36651_read_channel(struct cm36651_data *cm36651,
>   }
>
>   static int cm36651_read_int_time(struct cm36651_data *cm36651,
> -				struct iio_chan_spec const *chan, int *val)
> +				struct iio_chan_spec const *chan, int *val2)
>   {
>   	switch (chan->type) {
>   	case IIO_LIGHT:
>   		if (cm36651->cs_int_time[chan->address] == CM36651_CS_IT1)
> -			*val = 80000;
> +			*val2 = 80000;
>   		else if (cm36651->cs_int_time[chan->address] == CM36651_CS_IT2)
> -			*val = 160000;
> +			*val2 = 160000;
>   		else if (cm36651->cs_int_time[chan->address] == CM36651_CS_IT3)
> -			*val = 320000;
> +			*val2 = 320000;
>   		else if (cm36651->cs_int_time[chan->address] == CM36651_CS_IT4)
> -			*val = 640000;
> +			*val2 = 640000;
>   		else
>   			return -EINVAL;
>   		break;
>   	case IIO_PROXIMITY:
>   		if (cm36651->ps_int_time == CM36651_PS_IT1)
> -			*val = 320;
> +			*val2 = 320;
>   		else if (cm36651->ps_int_time == CM36651_PS_IT2)
> -			*val = 420;
> +			*val2 = 420;
>   		else if (cm36651->ps_int_time == CM36651_PS_IT3)
> -			*val = 520;
> +			*val2 = 520;
>   		else if (cm36651->ps_int_time == CM36651_PS_IT4)
> -			*val = 640;
> +			*val2 = 640;
>   		else
>   			return -EINVAL;
>   		break;
> @@ -387,7 +387,7 @@ static int cm36651_read_int_time(struct cm36651_data *cm36651,
>   		return -EINVAL;
>   	}
>
> -	return IIO_VAL_INT;
> +	return IIO_VAL_INT_PLUS_MICRO;
>   }
>
>   static int cm36651_write_int_time(struct cm36651_data *cm36651,
> @@ -459,7 +459,8 @@ static int cm36651_read_raw(struct iio_dev *indio_dev,
>   		ret = cm36651_read_channel(cm36651, chan, val);
>   		break;
>   	case IIO_CHAN_INFO_INT_TIME:
> -		ret = cm36651_read_int_time(cm36651, chan, val);
> +		*val = 0;
> +		ret = cm36651_read_int_time(cm36651, chan, val2);
>   		break;
>   	default:
>   		ret = -EINVAL;
> @@ -479,7 +480,7 @@ static int cm36651_write_raw(struct iio_dev *indio_dev,
>   	int ret = -EINVAL;
>
>   	if (mask == IIO_CHAN_INFO_INT_TIME) {
> -		ret = cm36651_write_int_time(cm36651, chan, val);
> +		ret = cm36651_write_int_time(cm36651, chan, val2);
>   		if (ret < 0)
>   			dev_err(&client->dev, "Integration time write failed\n");
>   	}
> @@ -487,6 +488,13 @@ static int cm36651_write_raw(struct iio_dev *indio_dev,
>   	return ret;
>   }
>
> +static int cm36651_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				long mask)
> +{
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
>   static int cm36651_read_prox_thresh(struct iio_dev *indio_dev,
>   					const struct iio_chan_spec *chan,
>   					enum iio_event_type type,
> @@ -614,6 +622,7 @@ static const struct iio_info cm36651_info = {
>   	.driver_module		= THIS_MODULE,
>   	.read_raw		= &cm36651_read_raw,
>   	.write_raw		= &cm36651_write_raw,
> +	.write_raw_get_fmt	= &cm36651_write_raw_get_fmt,
>   	.read_event_value	= &cm36651_read_prox_thresh,
>   	.write_event_value	= &cm36651_write_prox_thresh,
>   	.read_event_config	= &cm36651_read_prox_event_config,
>

