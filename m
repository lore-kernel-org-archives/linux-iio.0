Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48360 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdCSKqY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:46:24 -0400
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix FIFO_CTRL2 overwrite during
 watermark configuration
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170314210520.28665-1-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f93da6f4-1ad9-88f1-2c5a-3ca3b9d4b70e@kernel.org>
Date: Sun, 19 Mar 2017 10:45:35 +0000
MIME-Version: 1.0
In-Reply-To: <20170314210520.28665-1-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/03/17 21:05, Lorenzo Bianconi wrote:
> Fixes: 290a6ce11d93 (iio: imu: add support to lsm6dsx driver)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index e71ecce..e959825 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -194,8 +194,8 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
>  	if (err < 0)
>  		goto out;
>  
> -	fifo_watermark = ((data & ~ST_LSM6DSX_FIFO_TH_MASK) << 8) |
> -			  (fifo_watermark & ST_LSM6DSX_FIFO_TH_MASK);
> +	fifo_watermark = ((data << 8) & ~ST_LSM6DSX_FIFO_TH_MASK) |
> +			 (fifo_watermark & ST_LSM6DSX_FIFO_TH_MASK);
>  
>  	wdata = cpu_to_le16(fifo_watermark);
>  	err = hw->tf->write(hw->dev, ST_LSM6DSX_REG_FIFO_THL_ADDR,
> 

