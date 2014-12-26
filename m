Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45235 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaLZMhi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 07:37:38 -0500
Message-ID: <549D5690.1070104@kernel.org>
Date: Fri, 26 Dec 2014 12:37:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] iio: imu: inv_mpu6050: Added adapter class
References: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1418678363-22437-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1418678363-22437-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/12/14 21:19, Srinivas Pandruvada wrote:
> To use i2c auto detect to work we need to have a non zero class.
> The closest class is I2C_CLASS_HWMON, as it defined to be used
> with all hw monitoring drivers.
> 
> Also this class is already used by some iio driver, hid drivers, led
> and misc drivers. So this is not new that this is used outside
> hwmon drivers.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Been meaning to sort this out for a while.  We really shouldn't be camping
on the HWMON class (nor should anyone else).

Wolfram, do you mind new classes being added?
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index f73e60b..4af2d24 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -813,7 +813,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  	st->mux_adapter = i2c_add_mux_adapter(client->adapter,
>  					      &client->dev,
>  					      indio_dev,
> -					      0, 0, 0,
> +					      0, 0, I2C_CLASS_HWMON,
>  					      inv_mpu6050_select_bypass,
>  					      inv_mpu6050_deselect_bypass);
>  	if (!st->mux_adapter) {
> 

