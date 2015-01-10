Return-Path: <lars@metafoo.de>
Message-ID: <54B108FA.6010704@metafoo.de>
Date: Sat, 10 Jan 2015 12:11:54 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Karol Wrona <k.wrona@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 linux-kernel@vger.kernel.org
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Karol Wrona <wrona.vy@gmail.com>
Subject: Re: [PATCH 2/2] iio: Deselect IIO_TRIGGER for IIO_KFIFO_BUF
References: <1420735227-21091-1-git-send-email-k.wrona@samsung.com> <1420735227-21091-3-git-send-email-k.wrona@samsung.com>
In-Reply-To: <1420735227-21091-3-git-send-email-k.wrona@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 01/08/2015 05:40 PM, Karol Wrona wrote:
> iio kfifo can be used without trigger support so there is no need to build it.
>
> Signed-off-by: Karol Wrona <k.wrona@samsung.com>

Looks good, not sure why this was ever selected it in the first place.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/iio/Kconfig |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 50f6599..dfda2c3 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -27,7 +27,6 @@ boolean "IIO callback buffer used for push in-kernel interfaces"
>   	  usage.  That is, those where the data is pushed to the consumer.
>
>   config IIO_KFIFO_BUF
> -	select IIO_TRIGGER
>   	tristate "Industrial I/O buffering based on kfifo"
>   	help
>   	  A simple fifo based on kfifo.  Note that this currently provides
>
