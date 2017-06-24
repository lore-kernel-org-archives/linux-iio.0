Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdFXUIk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jun 2017 16:08:40 -0400
Date: Sat, 24 Jun 2017 21:08:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: support open drain mode
Message-ID: <20170624210835.56ffdd1c@kernel.org>
In-Reply-To: <20170621192129.10226-2-lorenzo.bianconi@st.com>
References: <20170621192129.10226-1-lorenzo.bianconi@st.com>
        <20170621192129.10226-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Jun 2017 21:21:28 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Add open drain support in order to share requested IRQ line between
> st_lsm6dsx device and other peripherals
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Issue when IRQF_RISING and open drain is set.

Otherwise looks good.
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 2a72acc6e049..e2737dc71b67 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -31,6 +31,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  
> +#include <linux/platform_data/st_sensors_pdata.h>
> +
>  #include "st_lsm6dsx.h"
>  
>  #define ST_LSM6DSX_REG_FIFO_THL_ADDR		0x06
> @@ -39,6 +41,8 @@
>  #define ST_LSM6DSX_REG_FIFO_DEC_GXL_ADDR	0x08
>  #define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
>  #define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
> +#define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
> +#define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
>  #define ST_LSM6DSX_REG_FIFO_MODE_ADDR		0x0a
>  #define ST_LSM6DSX_FIFO_MODE_MASK		GENMASK(2, 0)
>  #define ST_LSM6DSX_FIFO_ODR_MASK		GENMASK(6, 3)
> @@ -417,6 +421,8 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
>  
>  int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  {
> +	struct device_node *np = hw->dev->of_node;
> +	struct st_sensors_platform_data *pdata;
>  	struct iio_buffer *buffer;
>  	unsigned long irq_type;
>  	bool irq_active_low;
> @@ -444,6 +450,17 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  	if (err < 0)
>  		return err;
>  
> +	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
> +	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
> +	    (pdata && pdata->open_drain)) {
> +		err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_PP_OD_ADDR,
> +						 ST_LSM6DSX_REG_PP_OD_MASK, 1);
> +		if (err < 0)
> +			return err;
> +
> +		irq_type |= IRQF_SHARED;
> +	}
> +
In common with the mpu3050 which was the first driver in IIO to do open drain,
I think you need to think about precedence as we allow for IRQF_RISING
and IRQF_FALLING already.  Open drain only allows for shared interrupts
if IRQF_FALLING (I think)
>  	err = devm_request_threaded_irq(hw->dev, hw->irq,
>  					st_lsm6dsx_handler_irq,
>  					st_lsm6dsx_handler_thread,

