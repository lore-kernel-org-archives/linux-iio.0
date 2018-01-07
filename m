Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753897AbeAGQW3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jan 2018 11:22:29 -0500
Date: Sun, 7 Jan 2018 16:22:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: remove
 st_lsm6dsx_write_with_mask() declaration
Message-ID: <20180107162226.79e047f4@archlinux>
In-Reply-To: <20180106222325.17442-3-lorenzo.bianconi@redhat.com>
References: <20180106222325.17442-3-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  6 Jan 2018 23:23:25 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Remove st_lsm6dsx_write_with_mask() declaration since it has been removed
> in commit 6674bef628e6 ("iio: imu: st_lsm6dsx: add regmap API support")
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 35acb9c96745..8fdd723afa05 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -153,8 +153,6 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor);
>  int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor);
>  int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw);
> -int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_hw *hw, u8 addr, u8 mask,
> -			       u8 val);
>  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
>  				u16 watermark);
>  int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);

