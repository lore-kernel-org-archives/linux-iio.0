Return-Path: <knaack.h@gmx.de>
Message-ID: <546FE632.6020803@gmx.de>
Date: Sat, 22 Nov 2014 02:26:10 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1 linux-next] iio: common: remove unnecessary sizeof(u8)
References: <1416141204-19989-1-git-send-email-fabf@skynet.be>
In-Reply-To: <1416141204-19989-1-git-send-email-fabf@skynet.be>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Fabian Frederick schrieb am 16.11.2014 13:33:
> sizeof(u8) is always 1.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/common/st_sensors/st_sensors_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
> index 78a6a1a..5b37737 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> @@ -54,7 +54,7 @@ static int st_sensors_spi_read(struct st_sensor_transfer_buffer *tb,
>  	if (err)
>  		goto acc_spi_read_error;
>  
> -	memcpy(data, tb->rx_buf, len*sizeof(u8));
> +	memcpy(data, tb->rx_buf, len);
>  	mutex_unlock(&tb->buf_lock);
>  	return len;
>  
> 
