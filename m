Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48250 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdCMVUF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 17:20:05 -0400
Subject: Re: [PATCH v2] staging: iio: ad9832: replace mlock with driver
 private lock
To: Alison Schofield <amsfield22@gmail.com>
References: <20170313190848.GA5930@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, Michael.Hennerich@analog.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2ad3725f-ad11-c39d-bacb-e4847e0eca3b@kernel.org>
Date: Mon, 13 Mar 2017 21:20:02 +0000
MIME-Version: 1.0
In-Reply-To: <20170313190848.GA5930@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/03/17 19:08, Alison Schofield wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> ---
> v2: mutex_init() the newly added lock
> Jonathan - If it's too late for a v2, I'll send a new patch.
Fixed up in original patch,

Jonathan
> 
> 
>  drivers/staging/iio/frequency/ad9832.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 8d40c8e..425b8ab 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -84,6 +84,7 @@
>   * @freq_msg:		tuning word spi message
>   * @phase_xfer:		tuning word spi transfer
>   * @phase_msg:		tuning word spi message
> + * @lock		protect sensor state
>   * @data:		spi transmit buffer
>   * @phase_data:		tuning word spi transmit buffer
>   * @freq_data:		tuning word spi transmit buffer
> @@ -103,6 +104,7 @@ struct ad9832_state {
>  	struct spi_message		freq_msg;
>  	struct spi_transfer		phase_xfer[2];
>  	struct spi_message		phase_msg;
> +	struct mutex			lock;	/* protect sensor state */
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -177,7 +179,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  	if (ret)
>  		goto error_ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD9832_FREQ0HM:
>  	case AD9832_FREQ1HM:
> @@ -238,7 +240,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  	default:
>  		ret = -ENODEV;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -334,6 +336,7 @@ static int ad9832_probe(struct spi_device *spi)
>  
>  	st->mclk = pdata->mclk;
>  	st->spi = spi;
> +	mutex_init(&st->lock);
>  
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
> 

