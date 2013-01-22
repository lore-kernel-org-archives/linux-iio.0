Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48363 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987Ab3AVMMY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 07:12:24 -0500
Message-ID: <50FE8226.5050209@kernel.org>
Date: Tue, 22 Jan 2013 12:12:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 11/33] iio: Convert to devm_ioremap_resource()
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de> <1358762966-20791-12-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1358762966-20791-12-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/21/2013 10:09 AM, Thierry Reding wrote:
> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: linux-iio@vger.kernel.org
Looks fine to me.

Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/adc/at91_adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index a526c0e..83c836b 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -557,9 +557,9 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  
> -	st->reg_base = devm_request_and_ioremap(&pdev->dev, res);
> -	if (!st->reg_base) {
> -		ret = -ENOMEM;
> +	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(st->reg_base)) {
> +		ret = PTR_ERR(st->reg_base);
>  		goto error_free_device;
>  	}
>  
> 
