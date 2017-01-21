Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35434 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAUPEk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 10:04:40 -0500
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix typo in gyro sensitivity
 definition
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170117183823.11550-1-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b00738eb-82bf-774d-82cb-92268ae9c8a4@kernel.org>
Date: Sat, 21 Jan 2017 15:04:37 +0000
MIME-Version: 1.0
In-Reply-To: <20170117183823.11550-1-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 18:38, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied.  Thanks,

Jonathan
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 01e002c..f869dfa 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -82,9 +82,9 @@
>  #define ST_LSM6DSX_ACC_FS_8G_GAIN		IIO_G_TO_M_S_2(244)
>  #define ST_LSM6DSX_ACC_FS_16G_GAIN		IIO_G_TO_M_S_2(488)
>  
> -#define ST_LSM6DSX_GYRO_FS_245_GAIN		IIO_DEGREE_TO_RAD(4375)
> -#define ST_LSM6DSX_GYRO_FS_500_GAIN		IIO_DEGREE_TO_RAD(8750)
> -#define ST_LSM6DSX_GYRO_FS_1000_GAIN		IIO_DEGREE_TO_RAD(17500)
> +#define ST_LSM6DSX_GYRO_FS_245_GAIN		IIO_DEGREE_TO_RAD(8750)
> +#define ST_LSM6DSX_GYRO_FS_500_GAIN		IIO_DEGREE_TO_RAD(17500)
> +#define ST_LSM6DSX_GYRO_FS_1000_GAIN		IIO_DEGREE_TO_RAD(35000)
>  #define ST_LSM6DSX_GYRO_FS_2000_GAIN		IIO_DEGREE_TO_RAD(70000)
>  
>  struct st_lsm6dsx_odr {
> 

