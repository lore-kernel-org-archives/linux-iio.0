Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55742 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab1F2UG1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2011 16:06:27 -0400
Date: 29 Jun 2011 20:41:06 +0100
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Dan Carpenter <error27@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] Staging: iio: uninitialized variable in sca3000_probe()
Message-ID: <Prayer.1.3.4.1106292041060.4512@hermes-2.csi.cam.ac.uk>
In-Reply-To: <20110629184053.GI14591@shale.localdomain>
References: <20110629184053.GI14591@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Jun 29 2011, Dan Carpenter wrote:

>We recently changed how "st" was allocated in 83f0422dc6a16
>"staging:iio:accel:sca3000: allocate state in iio_dev and use
>iio_priv to access."  Unfortunately this assignment was left out.
>
Thanks,
>Signed-off-by: Dan Carpenter <error27@gmail.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>
> diff --git a/drivers/staging/iio/accel/sca3000_core.c 
> b/drivers/staging/iio/accel/sca3000_core.c index 4313f73..603f5bc 100644 
> --- a/drivers/staging/iio/accel/sca3000_core.c +++ 
> b/drivers/staging/iio/accel/sca3000_core.c @@ -1133,6 +1133,7 @@ static 
> int __devinit sca3000_probe(struct spi_device *spi)
> 		goto error_ret;
> 	}
> 
>+	st = iio_priv(indio_dev);
> 	spi_set_drvdata(spi, indio_dev);
> 	st->us = spi;
> 	mutex_init(&st->lock);
>
