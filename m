Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36980 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933131AbdCKSZ3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 13:25:29 -0500
Subject: Re: [PATCH] Staging: iio: return expression instead of return ret
To: Bo Yu <tsu.yubo@gmail.com>, Clausen <lars@metafoo.de>,
        Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hennerich <Michael.Hennerich@analog.com>,
        Knaack <knaack.h@gmx.de>, Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170310035738.GA1143@yubo-2>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0634a5c4-44e3-bf39-22b8-9e028c5412a8@kernel.org>
Date: Sat, 11 Mar 2017 18:25:24 +0000
MIME-Version: 1.0
In-Reply-To: <20170310035738.GA1143@yubo-2>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/17 03:57, Bo Yu wrote:
> The following Coccinelle script was used to detect this:
> 
> @@
> local idexpression ret;
> expression e;
> @@
> 
> -ret =
> +return
>       e;
> -return ret;

A bit of fuzz on this one. Presumably things moving around in other recent
changes.

Anyhow, applied to the togreg branch of iio.git. Will push out as testing
shortly for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
>   drivers/staging/iio/meter/ade7754.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index 024463a11c47..19f8cb144768 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -349,9 +349,8 @@ static int ade7754_set_irq(struct device *dev, bool enable)
>       else
>           irqen &= ~BIT(14);
> 
> -    ret = ade7754_spi_write_reg_16(dev, ADE7754_IRQEN, irqen);
> +    return ade7754_spi_write_reg_16(dev, ADE7754_IRQEN, irqen);
> 
> -    return ret;
>   }
> 
>   /* Power down the device */
> -- 
> 1.7.10.4
> 

