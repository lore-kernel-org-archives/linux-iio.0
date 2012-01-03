Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-229.synserver.de ([212.40.185.229]:1059 "EHLO
	smtp-out-228.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751185Ab2ACJpQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2012 04:45:16 -0500
Message-ID: <4F02CE57.9040202@metafoo.de>
Date: Tue, 03 Jan 2012 10:45:59 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, pirmin.duss@flytec.ch
Subject: Re: [PATCH 2/6] staging:iio:dds:ad9834 unwind use of is_visible for
 attrs.
References: <1325525123-31158-1-git-send-email-jic23@kernel.org> <1325525123-31158-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1325525123-31158-3-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/02/2012 06:25 PM, Jonathan Cameron wrote:
> Trivial usecase in which just having two different attr
> groups covers all options.  Slightly more code, but a simpler
> to follow result.
> 

>  static int __devinit ad9834_probe(struct spi_device *spi)
>  {
>  	struct ad9834_platform_data *pdata = spi->dev.platform_data;
> @@ -344,7 +347,10 @@ static int __devinit ad9834_probe(struct spi_device *spi)
>  	st->reg = reg;
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
> -	indio_dev->info = &ad9834_info;
> +	if ((st->devid == ID_AD9833) || (st->devid == ID_AD9837))

Maybe use a switch statement.

> +		indio_dev->info = &ad9833_info;
> +	else
> +		indio_dev->info = &ad9834_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	/* Setup default messages */

