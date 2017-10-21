Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42144 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbdJUQ6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Oct 2017 12:58:13 -0400
Date: Sat, 21 Oct 2017 17:58:09 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Colin King <colin.king@canonical.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: make array ch_to_mux static, makes object
 code smaller
Message-ID: <20171021175809.3e036d39@archlinux>
In-Reply-To: <20171019134622.31712-1-colin.king@canonical.com>
References: <20171019134622.31712-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 15:46:22 +0200
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate const array ch_to_mux on the stack, instead
> make it static. Makes the object code smaller by over 200 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   12663	   1648	    128	  14439	   3867	drivers/iio/adc/ti-adc12138.o
> 
> After
>    text	   data	    bss	    dec	    hex	filename
>   12353	   1744	    128	  14225	   3791	drivers/iio/adc/ti-adc12138.o
> 
> (gcc version 7.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thanks.  I added the driver name to the title though as people tend
to scan lists of commits to see if there is anything they care about
and this only effects on driver rather than all adcs.

Applied to the togreg branch of iio.git and pusehd out as testing for the
autobuilders to play with it.

thanks,

Jonathan
> ---
>  drivers/iio/adc/ti-adc12138.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
> index bf890244789a..703d68ae96b7 100644
> --- a/drivers/iio/adc/ti-adc12138.c
> +++ b/drivers/iio/adc/ti-adc12138.c
> @@ -164,7 +164,7 @@ static int __adc12138_start_conv(struct adc12138 *adc,
>  				 void *data, int len)
>  
>  {
> -	const u8 ch_to_mux[] = { 0, 4, 1, 5, 2, 6, 3, 7 };
> +	static const u8 ch_to_mux[] = { 0, 4, 1, 5, 2, 6, 3, 7 };
>  	u8 mode = (ch_to_mux[channel->channel] << 4) |
>  		  (channel->differential ? 0 : 0x80);
>  

