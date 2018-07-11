Return-Path: <SRS0=eKBR=J3=redhat.com=lorenzo.bianconi@kernel.org>
Date: Wed, 11 Jul 2018 14:29:54 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: irq not handled unless data pushed
 to buffers
Message-ID: <20180711122953.GC3871@localhost.localdomain>
References: <1531297928-3824-1-git-send-email-jramirez@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531297928-3824-1-git-send-email-jramirez@baylibre.com>
List-ID: <linux-iio@vger.kernel.org>

> Currently IRQ_NONE is returned only when there is no data on the fifo.
> 
> When there is no data on the fifo the driver can not push to the
> buffers and therefore user space readers polling for data available
> will not be awoken and continue to wait.
> 
> This commit just extends the same semantics to fifo read errors.

Hi Jorge,

IRQ_NONE is used to indicate this interrupt is not intended for this driver
(this could happen if the irq line is in open-drain). If the interrupt is for
st_lsm6dsx I would prefer to return IRQ_HANDLED even in case of error.

Regards,
Lorenzo

> 
> Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 4994f92..4959923 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -472,7 +472,7 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  	count = st_lsm6dsx_read_fifo(hw);
>  	mutex_unlock(&hw->fifo_lock);
>  
> -	return !count ? IRQ_NONE : IRQ_HANDLED;
> +	return (!count || count < 0) ? IRQ_NONE : IRQ_HANDLED;
>  }
>  
>  static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
> -- 
> 2.7.4
> 
