Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37007 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933164AbdCKS25 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 13:28:57 -0500
Subject: Re: [PATCH] staging: iio: ad9832: replace mlock with driver private
 lock
To: Alison Schofield <amsfield22@gmail.com>
References: <20170309204617.GA9281@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, daniel.baluta@gmail.com,
        Michael.Hennerich@analog.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <085bee39-31b3-2317-80b5-5694c948c918@kernel.org>
Date: Sat, 11 Mar 2017 18:28:50 +0000
MIME-Version: 1.0
In-Reply-To: <20170309204617.GA9281@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/17 20:46, Alison Schofield wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
> Jonathan et al,
> 
> If you still want to do this change, is it time to change the
> iio_dev->mlock comment back to [INTERN] in iio.h so that it
> doesn't get any new uses whilst we are migrating. Yes?
> 
> I'd like to give this as a task to the outreachy applicants.  There
> are ~70 mlock usages spread amongst ~15 iio drivers in staging. 
> Are you ready for a wave of these?
Yes. That was an easy question ;)

Make sure that they fully review the locking whilst at it though
as chances are some of it may be less than ideal!

Jonathan
> 
> 
>  drivers/staging/iio/frequency/ad9832.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 8d40c8e..c992648 100644
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
> 

