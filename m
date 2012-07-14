Return-Path: <wharms@bfs.de>
Message-ID: <5001A0FB.2010508@bfs.de>
Date: Sat, 14 Jul 2012 18:40:27 +0200
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
 jic23@kernel.org
Subject: Re: [PATCH] iio: fix pointer cast warning
References: <1342283004-15118-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1342283004-15118-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>



Am 14.07.2012 18:23, schrieb Peter Meerwald:
> fix compile warning reported by Fengguang Wu:
> 
> drivers/iio/light/adjd_s311.c: In function 'adjd_s311_trigger_handler':
> drivers/iio/light/adjd_s311.c:188:12: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> drivers/iio/light/adjd_s311.c:188:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> 
>    185              }
>    186
>    187              if (indio_dev->scan_timestamp)
>  > 188                      *(s64 *)((phys_addr_t)data->buffer + ALIGN(len, sizeof(s64)))
>    189                              = time_ns;
>    190              iio_push_to_buffer(buffer, (u8 *)data->buffer, time_ns);
>    191
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  drivers/iio/light/adjd_s311.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> index e485142..1cbb449 100644
> --- a/drivers/iio/light/adjd_s311.c
> +++ b/drivers/iio/light/adjd_s311.c
> @@ -185,7 +185,7 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
>  	}
>  
>  	if (indio_dev->scan_timestamp)
> -		*(s64 *)((phys_addr_t)data->buffer + ALIGN(len, sizeof(s64)))
> +		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
>  			= time_ns;
>  	iio_push_to_buffer(buffer, (u8 *)data->buffer, time_ns);
>  

a few lines below is an othern cast (u8 *)data->buffer, i do not see the rest of the code,
but perhaps adding a helper will help here to improve readability ?

just my 2 cents,
re,
 wh
