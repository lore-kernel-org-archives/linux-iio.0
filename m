Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbeKLCCt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 21:02:49 -0500
Date: Sun, 11 Nov 2018 16:13:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/9] iio: imu: st_lsm6dsx: reload trimming parameter
 at bootstrap
Message-ID: <20181111161348.1dc61ab6@archlinux>
In-Reply-To: <9b47f1429ddec5144d52605ef0ccf1f15a310db4.1541945612.git.lorenzo.bianconi@redhat.com>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
        <9b47f1429ddec5144d52605ef0ccf1f15a310db4.1541945612.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 11 Nov 2018 15:15:29 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Perform a complete device reset at bootstrap reloading trimming parameter
> after sw reset is completed. Device sw reset/boot is explained here:
> https://www.st.com/resource/en/application_note/dm00517282.pdf,
> section 5.7
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index c8b993bea757..961ce9d65d82 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -56,6 +56,7 @@
>  #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
>  #define ST_LSM6DSX_REG_RESET_ADDR		0x12
>  #define ST_LSM6DSX_REG_RESET_MASK		BIT(0)
> +#define ST_LSM6DSX_REG_BOOT_MASK		BIT(7)
>  #define ST_LSM6DSX_REG_BDU_ADDR			0x12
>  #define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
>  #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
> @@ -778,12 +779,23 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  	u8 drdy_int_reg;
>  	int err;
>  
> -	err = regmap_write(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> -			   ST_LSM6DSX_REG_RESET_MASK);
> +	/* device sw reset */
> +	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> +				 ST_LSM6DSX_REG_RESET_MASK,
> +				 FIELD_PREP(ST_LSM6DSX_REG_RESET_MASK, 1));
>  	if (err < 0)
>  		return err;
>  
> -	msleep(200);
> +	msleep(50);
> +
> +	/* reload trimming parameter */
> +	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> +				 ST_LSM6DSX_REG_BOOT_MASK,
> +				 FIELD_PREP(ST_LSM6DSX_REG_BOOT_MASK, 1));
> +	if (err < 0)
> +		return err;
> +
> +	msleep(50);
>  
>  	/* enable Block Data Update */
>  	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_BDU_ADDR,
