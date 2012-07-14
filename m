Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33681 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab2GNIqu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jul 2012 04:46:50 -0400
Message-ID: <500131F1.2050200@kernel.org>
Date: Sat, 14 Jul 2012 09:46:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] staging:iio:adis16260: Fix drvdata inconsistency
References: <1342181050-22579-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1342181050-22579-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/13/2012 01:04 PM, Lars-Peter Clausen wrote:
> The SPI drvdata is set to adis16260_state struct in probe(), but assumed to be
> the iio_dev struct in remove(). Fix this by setting it to the iio_dev in
> probe().
> 
> The issue has been discovered using the following coccinelle patch:
> 
> // <smpl>
> @r1@
> type T;
> T data;
> expression dev;
> @@
> (
> spi_set_drvdata(dev, (void *)data)
> |
> spi_set_drvdata(dev, data)
> )
> 
> @r2@
> type r1.T;
> T data;
> position p;
> expression dev;
> @@
> data = spi_get_drvdata@p(dev)
> 
> @depends on r1@
> position p != r2.p;
> expression dev;
> identifier data;
> @@
> *data = spi_get_drvdata@p(dev)
> // </smpl>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
All merged to fixes-togreg.

Thanks
> ---
>  drivers/staging/iio/gyro/adis16260_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index f16b393..93aa431 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -617,7 +617,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
>  	if (pd)
>  		st->negate = pd->negate;
>  	/* this is only used for removal purposes */
> -	spi_set_drvdata(spi, st);
> +	spi_set_drvdata(spi, indio_dev);
>  
>  	st->us = spi;
>  	mutex_init(&st->buf_lock);
> 


