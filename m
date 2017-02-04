Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58881 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdBDMX0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Feb 2017 07:23:26 -0500
Subject: Re: [PATCH 1/5] iio: imu: st_lsm6dsx: add support to multiple devices
 with the same settings
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170129104928.15533-1-lorenzo.bianconi@st.com>
 <20170129104928.15533-2-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2a6ad76c-399d-bb2e-1ad5-54a1fb91aa00@kernel.org>
Date: Sat, 4 Feb 2017 12:23:24 +0000
MIME-Version: 1.0
In-Reply-To: <20170129104928.15533-2-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/01/17 10:49, Lorenzo Bianconi wrote:
> Add capability to support multiple devices with the same
> st_lsm6dsx_settings like LSM6DSM/LSM6DSL
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++-------------
>  2 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 69deafe..2c1bb9e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -20,6 +20,7 @@
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
>  	ST_LSM6DSM_ID,
> +	ST_LSM6DSX_MAX_ID,
>  };
>  
>  #define ST_LSM6DSX_CHAN_SIZE		2
> @@ -50,7 +51,7 @@ struct st_lsm6dsx_reg {
>  struct st_lsm6dsx_settings {
>  	u8 wai;
>  	u16 max_fifo_size;
> -	enum st_lsm6dsx_hw_id id;
> +	enum st_lsm6dsx_hw_id id[ST_LSM6DSX_MAX_ID];
>  };
>  
>  enum st_lsm6dsx_sensor_id {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index c92ddcc..499e60a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -74,12 +74,6 @@
>  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
>  
> -#define ST_LSM6DS3_WHOAMI			0x69
> -#define ST_LSM6DSM_WHOAMI			0x6a
> -
> -#define ST_LSM6DS3_MAX_FIFO_SIZE		8192
> -#define ST_LSM6DSM_MAX_FIFO_SIZE		4096
> -
>  #define ST_LSM6DSX_ACC_FS_2G_GAIN		IIO_G_TO_M_S_2(61)
>  #define ST_LSM6DSX_ACC_FS_4G_GAIN		IIO_G_TO_M_S_2(122)
>  #define ST_LSM6DSX_ACC_FS_8G_GAIN		IIO_G_TO_M_S_2(244)
> @@ -164,14 +158,18 @@ static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
>  
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  	{
> -		.wai = ST_LSM6DS3_WHOAMI,
> -		.max_fifo_size = ST_LSM6DS3_MAX_FIFO_SIZE,
> -		.id = ST_LSM6DS3_ID,
> +		.wai = 0x69,
> +		.max_fifo_size = 8192,
> +		.id = {
> +			[0] = ST_LSM6DS3_ID,
> +		},
>  	},
>  	{
> -		.wai = ST_LSM6DSM_WHOAMI,
> -		.max_fifo_size = ST_LSM6DSM_MAX_FIFO_SIZE,
> -		.id = ST_LSM6DSM_ID,
> +		.wai = 0x6a,
> +		.max_fifo_size = 4096,
> +		.id = {
> +			[0] = ST_LSM6DSM_ID,
> +		},
>  	},
>  };
>  
> @@ -241,11 +239,15 @@ int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_hw *hw, u8 addr, u8 mask,
>  
>  static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id)
>  {
> -	int err, i;
> +	int err, i, j;
>  	u8 data;
>  
>  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> -		if (id == st_lsm6dsx_sensor_settings[i].id)
> +		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
> +			if (id == st_lsm6dsx_sensor_settings[i].id[j])
> +				break;
> +		}
> +		if (j < ST_LSM6DSX_MAX_ID)
>  			break;
>  	}
>  
> 

