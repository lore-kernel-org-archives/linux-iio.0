Return-Path: <SRS0=HIwy=LO=redhat.com=lorenzo.bianconi@kernel.org>
Date: Fri, 31 Aug 2018 10:44:00 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: take into account ts samples in wm
 configuration
Message-ID: <20180831084359.GA6236@localhost.localdomain>
References: <20180830203859.6527-1-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180830203859.6527-1-lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

> Take into account hw timer samples in pattern length computation used
> in st_lsm6dsx_update_watermark routine for watermark configuration
> 
> Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
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
> -- 
> 2.18.0
> 

Hi Jonathan,

please drop this patch, I am sending a v2 for this issue.

Regards,
Lorenzo
