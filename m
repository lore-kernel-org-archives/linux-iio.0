Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754817AbdL2MEz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 07:04:55 -0500
Date: Fri, 29 Dec 2017 12:04:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ji-Hun Kim <jihuun.k@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org,
        device-drivers-devel@blackfin.uclinux.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: iio: remove unnecessary parentheses
Message-ID: <20171229120449.449bfb6a@archlinux>
In-Reply-To: <20171228024714.GA3110@MacBook-Air>
References: <20171228024714.GA3110@MacBook-Air>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 27 Dec 2017 18:47:18 -0800
Ji-Hun Kim <jihuun.k@gmail.com> wrote:

> Clean up checkpatch warning:
> CHECK: Unnecessary parentheses around 'st->devid != ID_AD7195'
> 
> Signed-off-by: Ji-Hun Kim <jihuun.k@gmail.com>
I've personally never really cared about this particular one as
removing the brackets doesn't make the code easier to read.

However, it is worthwhile to suppress checkpatch warnings so
we can see the ones that matter.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7192.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index cadfb96..f015955 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -271,7 +271,7 @@ static int ad7192_setup(struct ad7192_state *st,
>  	if (pdata->sinc3_en)
>  		st->mode |= AD7192_MODE_SINC3;
>  
> -	if (pdata->refin2_en && (st->devid != ID_AD7195))
> +	if (pdata->refin2_en && st->devid != ID_AD7195)
>  		st->conf |= AD7192_CONF_REFSEL;
>  
>  	if (pdata->chop_en) {

