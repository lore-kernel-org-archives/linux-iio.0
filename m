Return-Path: <rdunlap@infradead.org>
Message-ID: <5223EB12.1050904@infradead.org>
Date: Sun, 01 Sep 2013 18:34:10 -0700
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, fengguang.wu@intel.com
Subject: Re: [PATCH] staging:iio:dummy fix kfifo_buf kconfig dependency issue
 if kfifo modular and buffer enabled for built in dummy driver.
References: <20130723235123.GA25723@localhost> <1378058136-18453-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1378058136-18453-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/01/13 10:55, Jonathan Cameron wrote:
> This only occurs in the unlikely event that the example driver is built
> in whilst the buffer implementation is not.
> 
> Solved by switching from a depends on to a select for this particular case.
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/staging/iio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index db4d6dc..b36feb0 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -37,7 +37,7 @@ config IIO_SIMPLE_DUMMY_EVENTS
>  
>  config IIO_SIMPLE_DUMMY_BUFFER
>         boolean "Buffered capture support"
> -       depends on IIO_KFIFO_BUF
> +       select IIO_KFIFO_BUF
>         help
>           Add buffered data capture to the simple dummy driver.
>  
> 


-- 
~Randy
