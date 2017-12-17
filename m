Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753315AbdLQMq4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Dec 2017 07:46:56 -0500
Date: Sun, 17 Dec 2017 12:46:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: venkat.prashanth2498@gmail.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Drivers: iio:adc: fix brace coding style issue in
 at91_adc.c
Message-ID: <20171217124652.5f557728@archlinux>
In-Reply-To: <1513501668-13227-1-git-send-email-venkat.prashanth2498@gmail.com>
References: <1513501668-13227-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Dec 2017 14:37:48 +0530
venkat.prashanth2498@gmail.com wrote:

> From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> 
> This is a patch to the at91_adc.c file that fixes up a brace
> warning found by the checkpatch.pl tool
> 
> Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 7b40925..a4767d6 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1165,9 +1165,9 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
>  	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(st->reg_base)) {
> +	if (IS_ERR(st->reg_base))
>  		return PTR_ERR(st->reg_base);
> -	}
> +
> 
>  	/*
>  	 * Disable all IRQs before setting up the handler
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

