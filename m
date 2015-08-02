Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45552 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbHBRvl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:51:41 -0400
Subject: Re: [PATCH] iio: inv-mpu: make inv_write_raw_get_fmt() more readable
To: Luis Henriques <luis.henriques@canonical.com>
References: <1438033697-22772-1-git-send-email-luis.henriques@canonical.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE58AA.4090701@kernel.org>
Date: Sun, 2 Aug 2015 18:51:38 +0100
MIME-Version: 1.0
In-Reply-To: <1438033697-22772-1-git-send-email-luis.henriques@canonical.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/15 22:48, Luis Henriques wrote:
> Replace nested switch statements by a single if statement, making function
> inv_write_raw_get_fmt() more readable.
> 
> Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
Hi Luis,

I can see where you are coming from here, but my gut feeling
is to leave it be as the chances are more stuff will get added
to this function in the future.  The mpu6050 are complex parts
for which we currently only support a very limited subset of
functionality.  An example of this is we have no filter
control at the moment.  The double case statement is ugly
but it easy to verify.

So I'm not going to take this one.

Sorry,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 65ce86837177..afbc2d2b8608 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -434,19 +434,9 @@ static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
>  static int inv_write_raw_get_fmt(struct iio_dev *indio_dev,
>  				 struct iio_chan_spec const *chan, long mask)
>  {
> -	switch (mask) {
> -	case IIO_CHAN_INFO_SCALE:
> -		switch (chan->type) {
> -		case IIO_ANGL_VEL:
> -			return IIO_VAL_INT_PLUS_NANO;
> -		default:
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		}
> -	default:
> -		return IIO_VAL_INT_PLUS_MICRO;
> -	}
> -
> -	return -EINVAL;
> +	if ((mask == IIO_CHAN_INFO_SCALE) && (chan->type == IIO_ANGL_VEL))
> +		return IIO_VAL_INT_PLUS_NANO;
> +	return IIO_VAL_INT_PLUS_MICRO;
>  }
>  static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)
>  {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

