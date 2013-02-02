Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43376 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab3BBJzr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 04:55:47 -0500
Message-ID: <510CE2A2.9060004@kernel.org>
Date: Sat, 02 Feb 2013 09:55:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH 04/11] iio/adc: (lp8788) Provide OF node information to
 iio device
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net> <1359668588-13678-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-5-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2013 09:43 PM, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
applied to togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

> ---
>  drivers/iio/adc/lp8788_adc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
> index 72955e4..e5293d0 100644
> --- a/drivers/iio/adc/lp8788_adc.c
> +++ b/drivers/iio/adc/lp8788_adc.c
> @@ -208,6 +208,7 @@ static int lp8788_adc_probe(struct platform_device *pdev)
>  	adc->lp = lp;
>  	platform_set_drvdata(pdev, indio_dev);
>  
> +	indio_dev->dev.of_node = pdev->dev.of_node;
>  	ret = lp8788_iio_map_register(indio_dev, lp->pdata, adc);
>  	if (ret)
>  		goto err_iio_map;
> 
