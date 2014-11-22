Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40123 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbaKVLX2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Nov 2014 06:23:28 -0500
Message-ID: <5470722E.3030500@kernel.org>
Date: Sat, 22 Nov 2014 11:23:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Zachary Warren <conflatulence@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] drivers:staging:iio: fix checkpatch complaint about space
 before comma
References: <1416655171-10455-1-git-send-email-conflatulence@gmail.com>
In-Reply-To: <1416655171-10455-1-git-send-email-conflatulence@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/11/14 11:19, Zachary Warren wrote:
> Fixes:
> drivers/staging/iio/adc/ad7192.c:615: ERROR: space prohibited before that ','
> drivers/staging/iio/meter/ade7759.c:119: ERROR: space prohibited before that ','
> 
> Signed-off-by: Zachary Warren <conflatulence@gmail.com>
Correctly formatted patch fixing a small issue - but, rare for for Eudyptula
patches, one that isn't just a matter of taste.

Nicely done.  Applied to the togreg branch iio.git, initially pushed out
as testing because there is some other stuff in the tree that I'd like the
autobuilders to stomp all over before pushing a non rebasable patch out.

Thanks,

Jonathan
> ---
> 
> This is for Eudyptula Challenge Task 10 which requires sending a checkpatch
> fix in linux-next drivers/staging to a maintainer and public mailing list.
> Apologies for mistakes and any inconvenience.
> 
>  drivers/staging/iio/adc/ad7192.c    | 2 +-
>  drivers/staging/iio/meter/ade7759.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index f6526aa..6f8ce6c 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -612,7 +612,7 @@ static int ad7192_probe(struct spi_device *spi)
>  	const struct ad7192_platform_data *pdata = spi->dev.platform_data;
>  	struct ad7192_state *st;
>  	struct iio_dev *indio_dev;
> -	int ret , voltage_uv = 0;
> +	int ret, voltage_uv = 0;
>  
>  	if (!pdata) {
>  		dev_err(&spi->dev, "no platform data?\n");
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index 7d21743..b0c7dbc 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -116,7 +116,7 @@ static int ade7759_spi_read_reg_40(struct device *dev,
>  
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADE7759_READ_REG(reg_address);
> -	memset(&st->tx[1], 0 , 5);
> +	memset(&st->tx[1], 0, 5);
>  
>  	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
>  	if (ret) {
> 

