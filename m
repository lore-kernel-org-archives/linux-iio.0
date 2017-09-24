Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752362AbdIXPuO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 11:50:14 -0400
Date: Sun, 24 Sep 2017 16:50:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: remove LIR configuration
Message-ID: <20170924165010.03f06740@archlinux>
In-Reply-To: <20170923191052.14419-2-lorenzo.bianconi@st.com>
References: <20170923191052.14419-1-lorenzo.bianconi@st.com>
        <20170923191052.14419-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 23 Sep 2017 21:10:51 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Remove Latched Interrupt configuration since it is enabled by default
> for FIFO watermark interrupt
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Not the most detailed explanation ever of a change, but I guess it
suffices (just!)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index c68cc7c91928..37d6e324ae74 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -56,8 +56,6 @@
>  #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
>  #define ST_LSM6DSX_REG_ROUNDING_ADDR		0x16
>  #define ST_LSM6DSX_REG_ROUNDING_MASK		BIT(2)
> -#define ST_LSM6DSX_REG_LIR_ADDR			0x58
> -#define ST_LSM6DSX_REG_LIR_MASK			BIT(0)
>  
>  #define ST_LSM6DSX_REG_ACC_ODR_ADDR		0x10
>  #define ST_LSM6DSX_REG_ACC_ODR_MASK		GENMASK(7, 4)
> @@ -607,12 +605,6 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  
>  	msleep(200);
>  
> -	/* latch interrupts */
> -	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_LIR_ADDR,
> -					 ST_LSM6DSX_REG_LIR_MASK, 1);
> -	if (err < 0)
> -		return err;
> -
>  	/* enable Block Data Update */
>  	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_BDU_ADDR,
>  					 ST_LSM6DSX_REG_BDU_MASK, 1);

