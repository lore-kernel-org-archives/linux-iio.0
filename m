Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35047 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165096AbdD3RA7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 13:00:59 -0400
Subject: Re: [PATCH v2 1/2] iio: imu: st_lsm6dsx: modify st_lsm6dsx_flush_fifo
 and st_lsm6dsx_set_fifo_mode scope
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
References: <20170427203156.18637-1-lorenzo.bianconi@st.com>
 <20170427203156.18637-2-lorenzo.bianconi@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <927494e1-e56e-9f5d-03c0-64223e9b61ac@kernel.org>
Date: Sun, 30 Apr 2017 18:00:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170427203156.18637-2-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/04/17 21:31, Lorenzo Bianconi wrote:
> Remove static qualifier from st_lsm6dsx_flush_fifo() and
> st_lsm6dsx_set_fifo_mode() in order to use them in system sleep pm support
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 3 +++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 4839db7..7778520 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -144,5 +144,8 @@ int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_hw *hw, u8 addr, u8 mask,
>  			       u8 val);
>  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
>  				u16 watermark);
> +int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
> +int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> +			     enum st_lsm6dsx_fifo_mode fifo_mode);
>  
>  #endif /* ST_LSM6DSX_H */
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index c8e5cfd..b19a62d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -130,8 +130,8 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>  	return 0;
>  }
>  
> -static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> -				    enum st_lsm6dsx_fifo_mode fifo_mode)
> +int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> +			     enum st_lsm6dsx_fifo_mode fifo_mode)
>  {
>  	u8 data;
>  	int err;
> @@ -303,7 +303,7 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	return read_len;
>  }
>  
> -static int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
> +int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
>  {
>  	int err;
>  
> 

