Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37916 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbFMSBj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jun 2015 14:01:39 -0400
Message-ID: <557C7002.2060604@kernel.org>
Date: Sat, 13 Jun 2015 19:01:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Adriana Reus <adriana.reus@intel.com>, ggao@invensense.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: inv-mpu: Export scale_available attributes
References: <1434121823-26266-1-git-send-email-adriana.reus@intel.com> <1434121823-26266-2-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1434121823-26266-2-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/15 16:10, Adriana Reus wrote:
> Export the available scales for accel and gyro in order
> to hint the user-space as to what are the available valid values.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 17d4bb1..096e545 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -673,6 +673,10 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
>  
>  /* constant IIO attribute */
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
> +static IIO_CONST_ATTR(in_anglvel_scale_available,
> +					  "0.000133090 0.000266181 0.000532362 0.001064724");
> +static IIO_CONST_ATTR(in_accel_scale_available,
> +					  "0.000598 0.001196 0.002392 0.004785");
>  static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
>  	inv_mpu6050_fifo_rate_store);
>  static IIO_DEVICE_ATTR(in_gyro_matrix, S_IRUGO, inv_attr_show, NULL,
> @@ -685,6 +689,8 @@ static struct attribute *inv_attributes[] = {
>  	&iio_dev_attr_in_accel_matrix.dev_attr.attr,
>  	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> +	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
>  	NULL,
>  };
>  
> 

