Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37912 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbbFMSAU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jun 2015 14:00:20 -0400
Message-ID: <557C6FB2.3010206@kernel.org>
Date: Sat, 13 Jun 2015 19:00:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <GGao@invensense.com>, Adriana Reus <adriana.reus@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: inv-mpu: Specify the expected format/precision
 for write channels
References: <1434121823-26266-1-git-send-email-adriana.reus@intel.com> <1434121823-26266-3-git-send-email-adriana.reus@intel.com> <E7747D604FBC9F43A71AA431AFF4476299C52ADD@IUSEXCH01.invcorp.invensense.com>
In-Reply-To: <E7747D604FBC9F43A71AA431AFF4476299C52ADD@IUSEXCH01.invcorp.invensense.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/15 18:31, Ge Gao wrote:
> These code looks good to me.
> Thanks.
> 
> Best Regards,
> 
> Ge GAO
Ge, formal Ack definitely preferred, but thanks for taking a look.

Adriana, please put fixes at the start of such a series.  It didn't
matter here as the two changes were non overlapping but they take
different paths so if there is overlap I need to get the fix
out ASAP and then the improvements such as patch 1 can follow slower.

Anyhow, applied to the fixes-togreg branch of iio.git (probably to
go upstream post the merge window now). Marked for stable.
> 
> 
> -----Original Message-----
> From: Adriana Reus [mailto:adriana.reus@intel.com] 
> Sent: Friday, June 12, 2015 8:10 AM
> To: Ge Gao; jic23@kernel.org
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Adriana Reus
> Subject: [PATCH 2/2] iio: inv-mpu: Specify the expected format/precision for write channels
> 
> The gyroscope needs IIO_VAL_INT_PLUS_NANO for the scale channel and unless specified write returns MICRO by default.
> This needs to be properly specified so that write operations into scale have the expected behaviour.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 096e545..4de5374 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -431,6 +431,23 @@ static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
>  	return -EINVAL;
>  }
>  
> +static int inv_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan, long mask) {
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;
> +}
>  static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)  {
>  	int result, i;
> @@ -702,6 +719,7 @@ static const struct iio_info mpu_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &inv_mpu6050_read_raw,
>  	.write_raw = &inv_mpu6050_write_raw,
> +	.write_raw_get_fmt = &inv_write_raw_get_fmt,
>  	.attrs = &inv_attribute_group,
>  	.validate_trigger = inv_mpu6050_validate_trigger,  };
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

