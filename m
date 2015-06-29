Return-Path: <vlad.dogaru@intel.com>
Date: Mon, 29 Jun 2015 10:36:56 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: sx9500: Add missing init in
 sx9500_buffer_pre{en,dis}able()
Message-ID: <20150629073655.GC12017@vdogaru>
References: <1435562073-31503-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1435562073-31503-1-git-send-email-geert@linux-m68k.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 29, 2015 at 09:14:33AM +0200, Geert Uytterhoeven wrote:
> drivers/iio/proximity/sx9500.c: In function ‘sx9500_buffer_preenable’:
> drivers/iio/proximity/sx9500.c:682: warning: ‘ret’ may be used uninitialized in this function
> drivers/iio/proximity/sx9500.c: In function ‘sx9500_buffer_predisable’:
> drivers/iio/proximity/sx9500.c:706: warning: ‘ret’ may be used uninitialized in this function
> 
> If active_scan_mask is empty, it will loop once more over all channels,
> doing nothing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>

I wonder if those functions are ever called with an empty scan mask.
But the fix is correct nonetheless.  Nice catch :)

> ---
>  drivers/iio/proximity/sx9500.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 2042e375f8351de6..7624cfa2422d4e41 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -679,7 +679,7 @@ out:
>  static int sx9500_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct sx9500_data *data = iio_priv(indio_dev);
> -	int ret, i;
> +	int ret = 0, i;
>  
>  	mutex_lock(&data->mutex);
>  
> @@ -703,7 +703,7 @@ static int sx9500_buffer_preenable(struct iio_dev *indio_dev)
>  static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct sx9500_data *data = iio_priv(indio_dev);
> -	int ret, i;
> +	int ret = 0, i;
>  
>  	iio_triggered_buffer_predisable(indio_dev);
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
