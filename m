Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:52522 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1A2Pow (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jan 2011 10:44:52 -0500
Message-ID: <4D4437BA.6060702@cam.ac.uk>
Date: Sat, 29 Jan 2011 15:52:26 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: stigge@antcom.de
CC: linux-iio@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] ad7476_core.c: Fixed i2c -> spi documentation typo
References: <1296314837-28136-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1296314837-28136-1-git-send-email-stigge@antcom.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/29/11 15:27, stigge@antcom.de wrote:
> ad7476_core.c: Fixed i2c -> spi documentation typo
> 
> Minor documentation fix in comment
> 
Good spot. Thanks,
> Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
 
> diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
> index deb68c8..4708b8e 100644
> --- a/drivers/staging/iio/adc/ad7476_core.c
> +++ b/drivers/staging/iio/adc/ad7476_core.c
> @@ -190,7 +190,7 @@ static int __devinit ad7476_probe(struct spi_device *spi)
>  		goto error_disable_reg;
>  	}
>  
> -	/* Estabilish that the iio_dev is a child of the i2c device */
> +	/* Establish that the iio_dev is a child of the spi device */
>  	st->indio_dev->dev.parent = &spi->dev;
>  	st->indio_dev->attrs = &ad7476_attribute_group;
>  	st->indio_dev->dev_data = (void *)(st);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

