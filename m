Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbdJAKsT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Oct 2017 06:48:19 -0400
Date: Sun, 1 Oct 2017 11:42:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: Re: [PATCH 2/4] iio: imu: st_lsm6dsx: split fifo mode and fifo odr
 configuration
Message-ID: <20171001114244.530a808b@archlinux>
In-Reply-To: <20170927192928.16160-3-lorenzo.bianconi@st.com>
References: <20170927192928.16160-1-lorenzo.bianconi@st.com>
        <20170927192928.16160-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 27 Sep 2017 21:29:26 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Separate fifo mode and max fifo sample rate configuration.
> That change will be necessary to reuse st_lsm6dsx_set_fifo_mode()
> routine and to support more devices in st_lsm6dsx driver
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Sensible change - I'd prefer to see a change like this made
as part of the series making use of it though... Always nice
to have proof that it is a good change ;)

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 32 ++++++++++++++------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index e2737dc71b67..26fb970aed15 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -139,23 +139,10 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>  int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>  			     enum st_lsm6dsx_fifo_mode fifo_mode)
>  {
> -	u8 data;
>  	int err;
>  
> -	switch (fifo_mode) {
> -	case ST_LSM6DSX_FIFO_BYPASS:
> -		data = fifo_mode;
> -		break;
> -	case ST_LSM6DSX_FIFO_CONT:
> -		data = (ST_LSM6DSX_MAX_FIFO_ODR_VAL <<
> -			__ffs(ST_LSM6DSX_FIFO_ODR_MASK)) | fifo_mode;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	err = hw->tf->write(hw->dev, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> -			    sizeof(data), &data);
> +	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> +					 ST_LSM6DSX_FIFO_MODE_MASK, fifo_mode);
>  	if (err < 0)
>  		return err;
>  
> @@ -164,6 +151,17 @@ int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>  	return 0;
>  }
>  
> +static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
> +				   bool enable)
> +{
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	u8 data;
> +
> +	data = hw->enable_mask ? ST_LSM6DSX_MAX_FIFO_ODR_VAL : 0;
> +	return st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> +					  ST_LSM6DSX_FIFO_ODR_MASK, data);
> +}
> +
>  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
>  {
>  	u16 fifo_watermark = ~0, cur_watermark, sip = 0;
> @@ -345,6 +343,10 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
>  			return err;
>  	}
>  
> +	err = st_lsm6dsx_set_fifo_odr(sensor, enable);
> +	if (err < 0)
> +		return err;
> +
>  	err = st_lsm6dsx_update_decimators(hw);
>  	if (err < 0)
>  		return err;

