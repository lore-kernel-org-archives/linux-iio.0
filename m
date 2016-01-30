Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53930 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141AbcA3RSN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 12:18:13 -0500
Subject: Re: [PATCH 2/5] iio: inv_mpu6050: Remove unused parameter
To: Adriana Reus <adriana.reus@intel.com>
References: <1454147028-22449-1-git-send-email-adriana.reus@intel.com>
 <1454147028-22449-3-git-send-email-adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACF053.2050807@kernel.org>
Date: Sat, 30 Jan 2016 17:18:11 +0000
MIME-Version: 1.0
In-Reply-To: <1454147028-22449-3-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/01/16 09:43, Adriana Reus wrote:
> The inv_check_and_setup_chip function does not use the i2c_device_id
> parameter. Therefore remove it.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
This one stands just fine on it's own.  Hence applied to the togreg branch
of iio.git - initially pushed out as testing for the autobuilders to
play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 5fe1dd8..1121f4e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -727,8 +727,7 @@ static const struct iio_info mpu_info = {
>  /**
>   *  inv_check_and_setup_chip() - check and setup chip.
>   */
> -static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
> -		const struct i2c_device_id *id)
> +static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  {
>  	int result;
>  
> @@ -795,7 +794,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  	if (pdata)
>  		st->plat_data = *pdata;
>  	/* power is turned on inside check chip type*/
> -	result = inv_check_and_setup_chip(st, id);
> +	result = inv_check_and_setup_chip(st);
>  	if (result)
>  		return result;
>  
> 

