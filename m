Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754233AbdGJU7m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Jul 2017 16:59:42 -0400
Date: Mon, 10 Jul 2017 21:59:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:adc:at91-sama5d2: make array startup_lookup static
Message-ID: <20170710215938.4279bb07@kernel.org>
In-Reply-To: <20170710165616.16734-1-colin.king@canonical.com>
References: <20170710165616.16734-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 10 Jul 2017 17:56:16 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate array startup_lookup on the stack but instead make
> it static.  Makes the object code smaller.  Also add in missing 'int' type
> specifier to clean up a checkpatch warning.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   10297	   2800	    128	  13225	   33a9	drivers/iio/adc/at91-sama5d2_adc.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   10140	   2888	    128	  13156	   3364	drivers/iio/adc/at91-sama5d2_adc.o
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Hi Colin

I'm guessing accidental repost?  I applied this yesterday and you haven't marked
it as a resend!

Jonathan
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index e10dca3ed74b..509988a6817a 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -231,7 +231,7 @@ static const struct iio_chan_spec at91_adc_channels[] = {
>  static unsigned at91_adc_startup_time(unsigned startup_time_min,
>  				      unsigned adc_clk_khz)
>  {
> -	const unsigned startup_lookup[] = {
> +	static const unsigned int startup_lookup[] = {
>  		  0,   8,  16,  24,
>  		 64,  80,  96, 112,
>  		512, 576, 640, 704,

