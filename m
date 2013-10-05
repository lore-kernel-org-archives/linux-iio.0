Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32977 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab3JEKBn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2013 06:01:43 -0400
Message-ID: <524FF1B6.2040804@kernel.org>
Date: Sat, 05 Oct 2013 12:02:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 8/8] staging:iio:ad9951: Use spi_sync_transfer()
References: <1380959108-21775-1-git-send-email-lars@metafoo.de> <1380959108-21775-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1380959108-21775-8-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/13 08:45, Lars-Peter Clausen wrote:
> Use the spi_sync_transfer() helper function instead of open-coding it. Makes the
> code a bit shorter.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied. Thanks,
> ---
>  drivers/staging/iio/frequency/ad9951.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9951.c b/drivers/staging/iio/frequency/ad9951.c
> index 0094c2f..5e8990a 100644
> --- a/drivers/staging/iio/frequency/ad9951.c
> +++ b/drivers/staging/iio/frequency/ad9951.c
> @@ -60,7 +60,6 @@ static ssize_t ad9951_set_parameter(struct device *dev,
>  					const char *buf,
>  					size_t len)
>  {
> -	struct spi_message msg;
>  	struct spi_transfer xfer;
>  	int ret;
>  	struct ad9951_config *config = (struct ad9951_config *)buf;
> @@ -71,36 +70,28 @@ static ssize_t ad9951_set_parameter(struct device *dev,
>  	xfer.tx_buf = &config->asf[0];
>  	mutex_lock(&st->lock);
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 2;
>  	xfer.tx_buf = &config->arr[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 5;
>  	xfer.tx_buf = &config->ftw0[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 3;
>  	xfer.tx_buf = &config->ftw1[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  error_ret:
> @@ -113,7 +104,6 @@ static IIO_DEVICE_ATTR(dds, S_IWUSR, NULL, ad9951_set_parameter, 0);
>  
>  static void ad9951_init(struct ad9951_state *st)
>  {
> -	struct spi_message msg;
>  	struct spi_transfer xfer;
>  	int ret;
>  	u8 cfr[5];
> @@ -129,9 +119,7 @@ static void ad9951_init(struct ad9951_state *st)
>  	xfer.len = 5;
>  	xfer.tx_buf = &cfr;
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
> @@ -143,9 +131,7 @@ static void ad9951_init(struct ad9951_state *st)
>  	xfer.len = 4;
>  	xfer.tx_buf = &cfr;
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
> 
