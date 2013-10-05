Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32932 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab3JEKBG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2013 06:01:06 -0400
Message-ID: <524FF191.1000302@kernel.org>
Date: Sat, 05 Oct 2013 12:01:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/8] staging:iio:ad9852: Use spi_sync_transfer()
References: <1380959108-21775-1-git-send-email-lars@metafoo.de> <1380959108-21775-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1380959108-21775-6-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/13 08:45, Lars-Peter Clausen wrote:
> Use the spi_sync_transfer() helper function instead of open-coding it. Makes
> the code a bit shorter.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
applied.
> ---
>  drivers/staging/iio/frequency/ad9852.c | 45 +++++++++-------------------------
>  1 file changed, 11 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9852.c b/drivers/staging/iio/frequency/ad9852.c
> index 4be2cf8..11e4367 100644
> --- a/drivers/staging/iio/frequency/ad9852.c
> +++ b/drivers/staging/iio/frequency/ad9852.c
> @@ -67,7 +67,6 @@ static ssize_t ad9852_set_parameter(struct device *dev,
>  					const char *buf,
>  					size_t len)
>  {
> -	struct spi_message msg;
>  	struct spi_transfer xfer;
>  	int ret;
>  	struct ad9852_config *config = (struct ad9852_config *)buf;
> @@ -78,99 +77,77 @@ static ssize_t ad9852_set_parameter(struct device *dev,
>  	xfer.tx_buf = &config->phajst0[0];
>  	mutex_lock(&st->lock);
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 3;
>  	xfer.tx_buf = &config->phajst1[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 6;
>  	xfer.tx_buf = &config->fretun1[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 6;
>  	xfer.tx_buf = &config->fretun2[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 6;
>  	xfer.tx_buf = &config->dltafre[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 5;
>  	xfer.tx_buf = &config->updtclk[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 4;
>  	xfer.tx_buf = &config->ramprat[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 5;
>  	xfer.tx_buf = &config->control[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 3;
>  	xfer.tx_buf = &config->outpskm[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 2;
>  	xfer.tx_buf = &config->outpskr[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 3;
>  	xfer.tx_buf = &config->daccntl[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  error_ret:
> 
