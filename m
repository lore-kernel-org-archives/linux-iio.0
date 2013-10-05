Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32953 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab3JEKBY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2013 06:01:24 -0400
Message-ID: <524FF1A4.6060002@kernel.org>
Date: Sat, 05 Oct 2013 12:01:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 7/8] staging:iio:ad9910: Use spi_sync_transfer()
References: <1380959108-21775-1-git-send-email-lars@metafoo.de> <1380959108-21775-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1380959108-21775-7-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/13 08:45, Lars-Peter Clausen wrote:
> Use the spi_sync_transfer() helper function instead of open-coding it. Makes
> the code a bit shorter.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>  drivers/staging/iio/frequency/ad9910.c | 82 +++++++++-------------------------
>  1 file changed, 20 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9910.c b/drivers/staging/iio/frequency/ad9910.c
> index a7d528e..755e048 100644
> --- a/drivers/staging/iio/frequency/ad9910.c
> +++ b/drivers/staging/iio/frequency/ad9910.c
> @@ -119,7 +119,6 @@ static ssize_t ad9910_set_parameter(struct device *dev,
>  					const char *buf,
>  					size_t len)
>  {
> -	struct spi_message msg;
>  	struct spi_transfer xfer;
>  	int ret;
>  	struct ad9910_config *config = (struct ad9910_config *)buf;
> @@ -130,152 +129,118 @@ static ssize_t ad9910_set_parameter(struct device *dev,
>  	xfer.tx_buf = &config->auxdac[0];
>  	mutex_lock(&st->lock);
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 5;
>  	xfer.tx_buf = &config->ioupd[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 5;
>  	xfer.tx_buf = &config->ftw[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 3;
>  	xfer.tx_buf = &config->pow[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 5;
>  	xfer.tx_buf = &config->asf[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 5;
>  	xfer.tx_buf = &config->multc[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 9;
>  	xfer.tx_buf = &config->dig_rampl[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 9;
>  	xfer.tx_buf = &config->dig_ramps[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 5;
>  	xfer.tx_buf = &config->dig_rampr[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 9;
>  	xfer.tx_buf = &config->sin_tonep0[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 9;
>  	xfer.tx_buf = &config->sin_tonep1[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 9;
>  	xfer.tx_buf = &config->sin_tonep2[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  	xfer.len = 9;
>  	xfer.tx_buf = &config->sin_tonep3[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 9;
>  	xfer.tx_buf = &config->sin_tonep4[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 9;
>  	xfer.tx_buf = &config->sin_tonep5[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 9;
>  	xfer.tx_buf = &config->sin_tonep6[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  
>  	xfer.len = 9;
>  	xfer.tx_buf = &config->sin_tonep7[0];
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->sdev, &msg);
> +	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret)
>  		goto error_ret;
>  error_ret:
> @@ -288,7 +253,6 @@ static IIO_DEVICE_ATTR(dds, S_IWUSR, NULL, ad9910_set_parameter, 0);
>  
>  static void ad9910_init(struct ad9910_state *st)
>  {
> -	struct spi_message msg;
>  	struct spi_transfer xfer;
>  	int ret;
>  	u8 cfr[5];
> @@ -304,9 +268,7 @@ static void ad9910_init(struct ad9910_state *st)
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
> @@ -319,9 +281,7 @@ static void ad9910_init(struct ad9910_state *st)
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
> @@ -334,9 +294,7 @@ static void ad9910_init(struct ad9910_state *st)
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
> 
