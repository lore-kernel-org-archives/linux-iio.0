Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeGOJeL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Jul 2018 05:34:11 -0400
Date: Sun, 15 Jul 2018 10:11:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, jramirez@baylibre.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: add error logs to
 st_lsm6dsx_read_fifo()
Message-ID: <20180715101151.7a48b309@archlinux>
In-Reply-To: <20180711221512.20366-1-lorenzo.bianconi@redhat.com>
References: <20180711221512.20366-1-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 12 Jul 2018 00:15:12 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Add debug info to error conditions in st_lsm6dsx_read_fifo routine
> 
> Suggested-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 4994f920a836..7589f2ad1dae 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -298,8 +298,11 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	err = regmap_bulk_read(hw->regmap,
>  			       hw->settings->fifo_ops.fifo_diff.addr,
>  			       &fifo_status, sizeof(fifo_status));
> -	if (err < 0)
> +	if (err < 0) {
> +		dev_err(hw->dev, "failed to read fifo status (err=%d)\n",
> +			err);
>  		return err;
> +	}
>  
>  	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
>  		return 0;
> @@ -313,8 +316,12 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  
>  	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
>  		err = st_lsm6dsx_read_block(hw, hw->buff, pattern_len);
> -		if (err < 0)
> +		if (err < 0) {
> +			dev_err(hw->dev,
> +				"failed to read pattern from fifo (err=%d)\n",
> +				err);
>  			return err;
> +		}
>  
>  		/*
>  		 * Data are written to the FIFO with a specific pattern
> @@ -385,8 +392,11 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  
>  	if (unlikely(reset_ts)) {
>  		err = st_lsm6dsx_reset_hw_ts(hw);
> -		if (err < 0)
> +		if (err < 0) {
> +			dev_err(hw->dev, "failed to reset hw ts (err=%d)\n",
> +				err);
>  			return err;
> +		}
>  	}
>  	return read_len;
>  }

