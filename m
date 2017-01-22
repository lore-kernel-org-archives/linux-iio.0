Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40606 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdAVOew (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 09:34:52 -0500
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add possibility to select drdy
 pin
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170122103052.8769-1-lorenzo.bianconi@st.com>
 <20170122103052.8769-2-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3ca71ff6-fa9e-449a-8a21-7607ca2c2c55@kernel.org>
Date: Sun, 22 Jan 2017 14:34:01 +0000
MIME-Version: 1.0
In-Reply-To: <20170122103052.8769-2-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/01/17 10:30, Lorenzo Bianconi wrote:
> Add capability to route data ready signal on pin 1 or pin 2 of the package
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 66 +++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index f869dfa..bc50164 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -37,11 +37,14 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> +#include <linux/platform_data/st_sensors_pdata.h>
> +
>  #include "st_lsm6dsx.h"
>  
>  #define ST_LSM6DSX_REG_ACC_DEC_MASK		GENMASK(2, 0)
>  #define ST_LSM6DSX_REG_GYRO_DEC_MASK		GENMASK(5, 3)
>  #define ST_LSM6DSX_REG_INT1_ADDR		0x0d
> +#define ST_LSM6DSX_REG_INT2_ADDR		0x0e
>  #define ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK	BIT(3)
>  #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
>  #define ST_LSM6DSX_REG_RESET_ADDR		0x12
> @@ -532,10 +535,63 @@ static const struct iio_info st_lsm6dsx_gyro_info = {
>  
>  static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
>  
> +#ifdef CONFIG_OF
Perhaps rely on the -ENOSYS return from
of_property_read_u32 stub instead of having the ifdefs around something so
simple.

> +static int st_lsm6dsx_of_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
> +{
> +	struct device_node *np = hw->dev->of_node;
> +	int err;
> +
> +	if (!np)
> +		return -EINVAL;
> +
> +	err = of_property_read_u32(np, "st,drdy-int-pin", drdy_pin);
> +	if (err == -ENODATA) {
> +		/* if the property has not been specified use default value */
> +		*drdy_pin = 1;
> +		err = 0;
> +	}
> +
> +	return err;
> +}
> +#else
> +static int st_lsm6dsx_of_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
> +{
> +	return -EINVAL;
> +}
> +#endif /* CONFIG_OF */
> +
> +static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
> +{
> +	int err = 0, drdy_pin;
> +
> +	if (st_lsm6dsx_of_get_drdy_pin(hw, &drdy_pin) < 0) {
> +		struct st_sensors_platform_data *pdata;
> +		struct device *dev = hw->dev;
> +
> +		pdata = (struct st_sensors_platform_data *)dev->platform_data;
> +		drdy_pin = pdata ? pdata->drdy_int_pin : 1;
> +	}
> +
> +	switch (drdy_pin) {
> +	case 1:
> +		*drdy_reg = ST_LSM6DSX_REG_INT1_ADDR;
> +		break;
> +	case 2:
> +		*drdy_reg = ST_LSM6DSX_REG_INT2_ADDR;
> +		break;
> +	default:
> +		dev_err(hw->dev, "unsupported data ready pin\n");
> +		err = -EINVAL;
> +		break;
> +	}
> +
> +	return err;
> +}
> +
>  static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  {
> +	u8 data, drdy_int_reg;
>  	int err;
> -	u8 data;
>  
>  	data = ST_LSM6DSX_REG_RESET_MASK;
>  	err = hw->tf->write(hw->dev, ST_LSM6DSX_REG_RESET_ADDR, sizeof(data),
> @@ -563,14 +619,12 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  		return err;
>  
>  	/* enable FIFO watermak interrupt */
> -	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_INT1_ADDR,
> -					 ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK, 1);
> +	err = st_lsm6dsx_get_drdy_reg(hw, &drdy_int_reg);
>  	if (err < 0)
>  		return err;
>  
> -	/* redirect INT2 on INT1 */
> -	return st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_INT2_ON_INT1_ADDR,
> -					  ST_LSM6DSX_REG_INT2_ON_INT1_MASK, 1);
Does removing this potentially break existing setups?

> +	return st_lsm6dsx_write_with_mask(hw, drdy_int_reg,
> +					  ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK, 1);
>  }
>  
>  static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
> 

