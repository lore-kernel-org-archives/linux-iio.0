Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48360 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3K3LMw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:12:52 -0500
Message-ID: <5299C833.2020805@kernel.org>
Date: Sat, 30 Nov 2013 11:12:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 11/15] staging:iio:ad7280a: Do not store transfer buffer
 on the stack
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-11-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:42, Lars-Peter Clausen wrote:
> Some I2C controllers may not be able to handle transfer buffers that are placed
> on the stack.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git
> ---
>  drivers/staging/iio/adc/ad7280a.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 89ee65b..1ac11f6 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -134,6 +134,8 @@ struct ad7280_state {
>  	unsigned char			aux_threshhigh;
>  	unsigned char			aux_threshlow;
>  	unsigned char			cb_mask[AD7280A_MAX_CHAIN];
> +
> +	__be32				buf[2] ____cacheline_aligned;
>  };
>  
>  static void ad7280_crc8_build_table(unsigned char *crc_tab)
> @@ -189,22 +191,22 @@ static void ad7280_delay(struct ad7280_state *st)
>  		msleep(1);
>  }
>  
> -static int __ad7280_read32(struct spi_device *spi, unsigned *val)
> +static int __ad7280_read32(struct ad7280_state *st, unsigned *val)
>  {
> -	__be32 rx_buf, tx_buf = cpu_to_be32(AD7280A_READ_TXVAL);
>  	int ret;
> -
>  	struct spi_transfer t = {
> -		.tx_buf	= &tx_buf,
> -		.rx_buf = &rx_buf,
> +		.tx_buf	= &st->buf[0],
> +		.rx_buf = &st->buf[1],
>  		.len = 4,
>  	};
>  
> -	ret = spi_sync_transfer(spi, &t, 1);
> +	st->buf[0] = cpu_to_be32(AD7280A_READ_TXVAL);
> +
> +	ret = spi_sync_transfer(st->spi, &t, 1);
>  	if (ret)
>  		return ret;
>  
> -	*val = be32_to_cpu(rx_buf);
> +	*val = be32_to_cpu(st->buf[1]);
>  
>  	return 0;
>  }
> @@ -214,12 +216,11 @@ static int ad7280_write(struct ad7280_state *st, unsigned devaddr,
>  {
>  	unsigned reg = (devaddr << 27 | addr << 21 |
>  			(val & 0xFF) << 13 | all << 12);
> -	__be32 tx_buf;
>  
>  	reg |= ad7280_calc_crc8(st->crc_tab, reg >> 11) << 3 | 0x2;
> -	tx_buf = cpu_to_be32(reg);
> +	st->buf[0] = cpu_to_be32(reg);
>  
> -	return spi_write(st->spi, &tx_buf, 4);
> +	return spi_write(st->spi, &st->buf[0], 4);
>  }
>  
>  static int ad7280_read(struct ad7280_state *st, unsigned devaddr,
> @@ -249,7 +250,7 @@ static int ad7280_read(struct ad7280_state *st, unsigned devaddr,
>  	if (ret)
>  		return ret;
>  
> -	__ad7280_read32(st->spi, &tmp);
> +	__ad7280_read32(st, &tmp);
>  
>  	if (ad7280_check_crc(st, tmp))
>  		return -EIO;
> @@ -287,7 +288,7 @@ static int ad7280_read_channel(struct ad7280_state *st, unsigned devaddr,
>  
>  	ad7280_delay(st);
>  
> -	__ad7280_read32(st->spi, &tmp);
> +	__ad7280_read32(st, &tmp);
>  
>  	if (ad7280_check_crc(st, tmp))
>  		return -EIO;
> @@ -320,7 +321,7 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned cnt,
>  	ad7280_delay(st);
>  
>  	for (i = 0; i < cnt; i++) {
> -		__ad7280_read32(st->spi, &tmp);
> +		__ad7280_read32(st, &tmp);
>  
>  		if (ad7280_check_crc(st, tmp))
>  			return -EIO;
> @@ -363,7 +364,7 @@ static int ad7280_chain_setup(struct ad7280_state *st)
>  		return ret;
>  
>  	for (n = 0; n <= AD7280A_MAX_CHAIN; n++) {
> -		__ad7280_read32(st->spi, &val);
> +		__ad7280_read32(st, &val);
>  		if (val == 0)
>  			return n - 1;
>  
> 
