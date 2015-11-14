Return-Path: <lars@metafoo.de>
Message-ID: <5646FEC7.5050600@metafoo.de>
Date: Sat, 14 Nov 2015 10:28:39 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Nizam Haider <nizamhaider786@gmail.com>
CC: knaack.h@gmx.de, jic23@kernel.org, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 Nizam Haider <nijamh@cdac.in>
Subject: Re: [PATCH] Staging: iio: iio_simple_dummy_buffer: Typo in comments
 area
References: <1447469041-5751-1-git-send-email-nizamhaider786@gmail.com>
In-Reply-To: <1447469041-5751-1-git-send-email-nizamhaider786@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 11/14/2015 03:44 AM, Nizam Haider wrote:
> Fix simple typo in comments
> 
> Signed-off-by: Nizam Haider <nijamh@cdac.in>

Thanks for the patch.

> ---
>  drivers/staging/iio/iio_simple_dummy_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index cf44a6f..c8f889b 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -64,7 +64,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  		 * software scans: can be considered to be random access
>  		 *   so efficient reading is just a case of minimal bus
>  		 *   transactions.
> -		 * software culled hardware scans:
> +		 * software called hardware scans:

I don't think that's a typo. The non-patched version makes a lot more sense
then the patched vesion.

>  		 *   occasionally a driver may process the nearest hardware
>  		 *   scan to avoid storing elements that are not desired. This
>  		 *   is the fiddliest option by far.
> 
