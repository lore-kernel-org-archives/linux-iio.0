Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62649C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 15:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BA4222EC
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 15:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfCXPFB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:05:01 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:38032 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXPFB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Mar 2019 11:05:01 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 70EF19E781E;
        Sun, 24 Mar 2019 15:04:59 +0000 (GMT)
Date:   Sun, 24 Mar 2019 15:04:57 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 1/5] iio: imu: adis16400: move trigger handler into
 adis16400_core
Message-ID: <20190324150457.2331f31a@archlinux>
In-Reply-To: <20190322204442.4035-1-ardeleanalex@gmail.com>
References: <20190322204442.4035-1-ardeleanalex@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Mar 2019 22:44:38 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> The trigger handler for the ADIS16400 is very different from the generic
> one in the ADIS library. Keeping it in a separate file won't make much
> sense once the update_scan_mode function will be made more generic and
> moved into the ADIS library.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Seems fine to me.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16400.h        |  2 --
>  drivers/iio/imu/adis16400_buffer.c | 41 --------------------------
>  drivers/iio/imu/adis16400_core.c   | 46 ++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.h b/drivers/iio/imu/adis16400.h
> index 73b189c1c0fb..93b6c0c41fdd 100644
> --- a/drivers/iio/imu/adis16400.h
> +++ b/drivers/iio/imu/adis16400.h
> @@ -203,12 +203,10 @@ ssize_t adis16400_read_data_from_ring(struct device *dev,
>  
>  int adis16400_update_scan_mode(struct iio_dev *indio_dev,
>  	const unsigned long *scan_mask);
> -irqreturn_t adis16400_trigger_handler(int irq, void *p);
>  
>  #else /* CONFIG_IIO_BUFFER */
>  
>  #define adis16400_update_scan_mode NULL
> -#define adis16400_trigger_handler NULL
>  
>  #endif /* CONFIG_IIO_BUFFER */
>  
> diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
> index e70a5339acb1..268349eb51c7 100644
> --- a/drivers/iio/imu/adis16400_buffer.c
> +++ b/drivers/iio/imu/adis16400_buffer.c
> @@ -58,44 +58,3 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
>  
>  	return 0;
>  }
> -
> -irqreturn_t adis16400_trigger_handler(int irq, void *p)
> -{
> -	struct iio_poll_func *pf = p;
> -	struct iio_dev *indio_dev = pf->indio_dev;
> -	struct adis16400_state *st = iio_priv(indio_dev);
> -	struct adis *adis = &st->adis;
> -	u32 old_speed_hz = st->adis.spi->max_speed_hz;
> -	void *buffer;
> -	int ret;
> -
> -	if (!adis->buffer)
> -		return -ENOMEM;
> -
> -	if (!(st->variant->flags & ADIS16400_NO_BURST) &&
> -		st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
> -		st->adis.spi->max_speed_hz = ADIS16400_SPI_BURST;
> -		spi_setup(st->adis.spi);
> -	}
> -
> -	ret = spi_sync(adis->spi, &adis->msg);
> -	if (ret)
> -		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
> -
> -	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
> -		st->adis.spi->max_speed_hz = old_speed_hz;
> -		spi_setup(st->adis.spi);
> -	}
> -
> -	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
> -		buffer = adis->buffer + sizeof(u16);
> -	else
> -		buffer = adis->buffer;
> -
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> -		pf->timestamp);
> -
> -	iio_trigger_notify_done(indio_dev->trig);
> -
> -	return IRQ_HANDLED;
> -}
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 9b697d35dbef..34d52863377a 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -31,6 +31,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  
>  #include "adis16400.h"
>  
> @@ -465,6 +466,51 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +#if IS_ENABLED(CONFIG_IIO_BUFFER)
> +static irqreturn_t adis16400_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adis16400_state *st = iio_priv(indio_dev);
> +	struct adis *adis = &st->adis;
> +	u32 old_speed_hz = st->adis.spi->max_speed_hz;
> +	void *buffer;
> +	int ret;
> +
> +	if (!adis->buffer)
> +		return -ENOMEM;
> +
> +	if (!(st->variant->flags & ADIS16400_NO_BURST) &&
> +		st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
> +		st->adis.spi->max_speed_hz = ADIS16400_SPI_BURST;
> +		spi_setup(st->adis.spi);
> +	}
> +
> +	ret = spi_sync(adis->spi, &adis->msg);
> +	if (ret)
> +		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
> +
> +	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
> +		st->adis.spi->max_speed_hz = old_speed_hz;
> +		spi_setup(st->adis.spi);
> +	}
> +
> +	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
> +		buffer = adis->buffer + sizeof(u16);
> +	else
> +		buffer = adis->buffer;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +		pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +#else
> +#define adis16400_trigger_handler	NULL
> +#endif /* IS_ENABLED(CONFIG_IIO_BUFFER) */
> +
>  #define ADIS16400_VOLTAGE_CHAN(addr, bits, name, si, chn) { \
>  	.type = IIO_VOLTAGE, \
>  	.indexed = 1, \

