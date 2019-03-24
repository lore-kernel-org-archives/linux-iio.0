Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E9C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22F22148D
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 17:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCXRrq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:47:46 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39198 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXRrq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Mar 2019 13:47:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 0EA9E9E74A6;
        Sun, 24 Mar 2019 17:47:43 +0000 (GMT)
Date:   Sun, 24 Mar 2019 17:47:41 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V2] iio: ad_sigma_delta: Properly handle SPI bus locking
 vs CS assertion
Message-ID: <20190324174741.39c23b0d@archlinux>
In-Reply-To: <20190319113755.8982-1-alexandru.ardelean@analog.com>
References: <20190319113755.8982-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Mar 2019 13:37:55 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> For devices from the SigmaDelta family we need to keep CS low when doing a
> conversion, since the device will use the MISO line as a interrupt to
> indicate that the conversion is complete.
> 
> This is why the driver locks the SPI bus and when the SPI bus is locked
> keeps as long as a conversion is going on. The current implementation gets
> one small detail wrong though. CS is only de-asserted after the SPI bus is
> unlocked. This means it is possible for a different SPI device on the same
> bus to send a message which would be wrongfully be addressed to the
> SigmaDelta device as well. Make sure that the last SPI transfer that is
> done while holding the SPI bus lock de-asserts the CS signal.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <Alexandru.Ardelean@analog.com>
Hi Alex,

So, it's a fix for a long existing problem.  Do we have anyone who
has experienced it?  I'm trying to judge whether this is stable material
or not.  If it is stable material, do you want to have a go at identifying
a patch for the Fixes tag?

Patch looks good.

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * added my S-o-B line
> 
>  drivers/iio/adc/ad_sigma_delta.c       | 16 +++++++++++-----
>  include/linux/iio/adc/ad_sigma_delta.h |  1 +
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index ff5f2da2e1b1..af6cbc683214 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -62,7 +62,7 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
>  	struct spi_transfer t = {
>  		.tx_buf		= data,
>  		.len		= size + 1,
> -		.cs_change	= sigma_delta->bus_locked,
> +		.cs_change	= sigma_delta->keep_cs_asserted,
>  	};
>  	struct spi_message m;
>  	int ret;
> @@ -217,6 +217,7 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  
>  	spi_bus_lock(sigma_delta->spi->master);
>  	sigma_delta->bus_locked = true;
> +	sigma_delta->keep_cs_asserted = true;
>  	reinit_completion(&sigma_delta->completion);
>  
>  	ret = ad_sigma_delta_set_mode(sigma_delta, mode);
> @@ -234,9 +235,10 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  		ret = 0;
>  	}
>  out:
> +	sigma_delta->keep_cs_asserted = false;
> +	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
>  	sigma_delta->bus_locked = false;
>  	spi_bus_unlock(sigma_delta->spi->master);
> -	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
>  
>  	return ret;
>  }
> @@ -289,6 +291,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  
>  	spi_bus_lock(sigma_delta->spi->master);
>  	sigma_delta->bus_locked = true;
> +	sigma_delta->keep_cs_asserted = true;
>  	reinit_completion(&sigma_delta->completion);
>  
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
> @@ -298,9 +301,6 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  	ret = wait_for_completion_interruptible_timeout(
>  			&sigma_delta->completion, HZ);
>  
> -	sigma_delta->bus_locked = false;
> -	spi_bus_unlock(sigma_delta->spi->master);
> -
>  	if (ret == 0)
>  		ret = -EIO;
>  	if (ret < 0)
> @@ -321,7 +321,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  		sigma_delta->irq_dis = true;
>  	}
>  
> +	sigma_delta->keep_cs_asserted = false;
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> +	sigma_delta->bus_locked = false;
> +	spi_bus_unlock(sigma_delta->spi->master);
>  	mutex_unlock(&indio_dev->mlock);
>  
>  	if (ret)
> @@ -358,6 +361,8 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  
>  	spi_bus_lock(sigma_delta->spi->master);
>  	sigma_delta->bus_locked = true;
> +	sigma_delta->keep_cs_asserted = true;
> +
>  	ret = ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_CONTINUOUS);
>  	if (ret)
>  		goto err_unlock;
> @@ -386,6 +391,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
>  		sigma_delta->irq_dis = true;
>  	}
>  
> +	sigma_delta->keep_cs_asserted = false;
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
>  
>  	sigma_delta->bus_locked = false;
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 7e84351fa2c0..6e9fb1932dde 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -69,6 +69,7 @@ struct ad_sigma_delta {
>  	bool			irq_dis;
>  
>  	bool			bus_locked;
> +	bool			keep_cs_asserted;
>  
>  	uint8_t			comm;
>  

