Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47241 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbGSNI2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 09:08:28 -0400
Message-ID: <55ABA14A.8070409@kernel.org>
Date: Sun, 19 Jul 2015 14:08:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>
CC: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Jonathan Bell <jonathan@raspberrypi.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCHv3 3/4] iio: dht11: avoid multiple assignments to make
 checkpatch.pl --strict happy
References: <55991FEA.50703@kernel.org> <1436276371-7480-1-git-send-email-harald@ccbib.org> <1436276371-7480-3-git-send-email-harald@ccbib.org>
In-Reply-To: <1436276371-7480-3-git-send-email-harald@ccbib.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/15 14:39, Harald Geyer wrote:
> We just do the assignments in two steps.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/dht11.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index bb5ad57..91976e0 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -263,9 +263,10 @@ static int dht11_probe(struct platform_device *pdev)
>  	dht11 = iio_priv(iio);
>  	dht11->dev = dev;
>  
> -	dht11->gpio = ret = of_get_gpio(node, 0);
> +	ret = of_get_gpio(node, 0);
>  	if (ret < 0)
>  		return ret;
> +	dht11->gpio = ret;
>  	ret = devm_gpio_request_one(dev, dht11->gpio, GPIOF_IN, pdev->name);
>  	if (ret)
>  		return ret;
> 

