Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60497 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcBUUga (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 15:36:30 -0500
Subject: Re: [RFC PATCH 1/9] iio: imu: inv_mpu6050: Fix multiline comments
 style
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
 <1455810794-3188-2-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, adi.reus@gmail.com, cmo@melexis.com,
	mwelling@ieee.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA1FCB.40000@kernel.org>
Date: Sun, 21 Feb 2016 20:36:27 +0000
MIME-Version: 1.0
In-Reply-To: <1455810794-3188-2-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/02/16 15:53, Daniel Baluta wrote:
> The preffered style for long (multi-line) comments is:
> 
> /*
>  * this is a multiline
>  * comment
>  */
> 
> This also fixes checkpatch.pl warning:
> WARNING: Block comments use * on subsequent lines
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git - pushed out as testing as normal.

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 37 +++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 2258600..84e014c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -79,10 +79,11 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>  {
>  	unsigned int d, mgmt_1;
>  	int result;
> -
> -	/* switch clock needs to be careful. Only when gyro is on, can
> -	   clock source be switched to gyro. Otherwise, it must be set to
> -	   internal clock */
> +	/*
> +	 * switch clock needs to be careful. Only when gyro is on, can
> +	 * clock source be switched to gyro. Otherwise, it must be set to
> +	 * internal clock
> +	 */
>  	if (INV_MPU6050_BIT_PWR_GYRO_STBY == mask) {
>  		result = regmap_read(st->map, st->reg->pwr_mgmt_1, &mgmt_1);
>  		if (result)
> @@ -92,8 +93,10 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>  	}
>  
>  	if ((INV_MPU6050_BIT_PWR_GYRO_STBY == mask) && (!en)) {
> -		/* turning off gyro requires switch to internal clock first.
> -		   Then turn off gyro engine */
> +		/*
> +		 * turning off gyro requires switch to internal clock first.
> +		 * Then turn off gyro engine
> +		 */
>  		mgmt_1 |= INV_CLK_INTERNAL;
>  		result = regmap_write(st->map, st->reg->pwr_mgmt_1, mgmt_1);
>  		if (result)
> @@ -391,8 +394,10 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  	int result;
>  
>  	mutex_lock(&indio_dev->mlock);
> -	/* we should only update scale when the chip is disabled, i.e.,
> -		not running */
> +	/*
> +	 * we should only update scale when the chip is disabled, i.e.
> +	 * not running
> +	 */
>  	if (st->chip_config.enable) {
>  		result = -EBUSY;
>  		goto error_write_raw;
> @@ -529,8 +534,10 @@ static ssize_t inv_attr_show(struct device *dev,
>  	s8 *m;
>  
>  	switch (this_attr->address) {
> -	/* In MPU6050, the two matrix are the same because gyro and accel
> -	   are integrated in one chip */
> +	/*
> +	 * In MPU6050, the two matrix are the same because gyro and accel
> +	 * are integrated in one chip
> +	 */
>  	case ATTR_GYRO_MATRIX:
>  	case ATTR_ACCL_MATRIX:
>  		m = st->plat_data.orientation;
> @@ -654,10 +661,12 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	if (result)
>  		return result;
>  	msleep(INV_MPU6050_POWER_UP_TIME);
> -	/* toggle power state. After reset, the sleep bit could be on
> -		or off depending on the OTP settings. Toggling power would
> -		make it in a definite state as well as making the hardware
> -		state align with the software state */
> +	/*
> +	 * toggle power state. After reset, the sleep bit could be on
> +	 * or off depending on the OTP settings. Toggling power would
> +	 * make it in a definite state as well as making the hardware
> +	 * state align with the software state
> +	 */
>  	result = inv_mpu6050_set_power_itg(st, false);
>  	if (result)
>  		return result;
> 

