Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeICAgm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 20:36:42 -0400
Date: Sun, 2 Sep 2018 21:19:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: take into account ts samples in
 wm configuration
Message-ID: <20180902211942.4922c0ec@archlinux>
In-Reply-To: <20180830203859.6527-1-lorenzo.bianconi@redhat.com>
References: <cover.1535705166.git.lorenzo.bianconi@redhat.com>
        <20180830203859.6527-1-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Aug 2018 22:38:59 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Take into account hw timer samples in pattern length computation used
> in st_lsm6dsx_update_watermark routine for watermark configuration
> 
> Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 7589f2ad1dae..2b49d928f4c0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -187,9 +187,10 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
>  
>  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
>  {
> -	u16 fifo_watermark = ~0, cur_watermark, sip = 0, fifo_th_mask;
> +	u16 fifo_watermark = ~0, cur_watermark, fifo_th_mask;
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	struct st_lsm6dsx_sensor *cur_sensor;
> +	u16 sip = hw->ts_sip;
>  	int i, err, data;
>  	__le16 wdata;
>  
