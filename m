Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48345 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab3K3LMJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:12:09 -0500
Message-ID: <5299C808.7050108@kernel.org>
Date: Sat, 30 Nov 2013 11:12:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/15] staging:iio:ad7280a: Mark transfer buffer as __be32
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-10-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:42, Lars-Peter Clausen wrote:
> Fixes the following warnings from sparse:
> 	drivers/staging/iio/adc/ad7280a.c:194:35: warning: incorrect type in initializer (different base types)
> 	drivers/staging/iio/adc/ad7280a.c:194:35:    expected unsigned int [unsigned] tx_buf
> 	drivers/staging/iio/adc/ad7280a.c:194:35:    got restricted __be32 [usertype] <noident>
> 	drivers/staging/iio/adc/ad7280a.c:207:16: warning: cast to restricted __be32
> 	drivers/staging/iio/adc/ad7280a.c:207:16: warning: cast to restricted __be32
> 	drivers/staging/iio/adc/ad7280a.c:207:16: warning: cast to restricted __be32
> 	drivers/staging/iio/adc/ad7280a.c:207:16: warning: cast to restricted __be32
> 	drivers/staging/iio/adc/ad7280a.c:207:16: warning: cast to restricted __be32
> 	drivers/staging/iio/adc/ad7280a.c:207:16: warning: cast to restricted __be32
> 	drivers/staging/iio/adc/ad7280a.c:219:13: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/adc/ad7280a.c:219:13:    expected unsigned int [unsigned] [assigned] reg
> 	drivers/staging/iio/adc/ad7280a.c:219:13:    got restricted __be32 [usertype] <noident>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

thanks
> ---
>  drivers/staging/iio/adc/ad7280a.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 8209fa5..89ee65b 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -191,7 +191,7 @@ static void ad7280_delay(struct ad7280_state *st)
>  
>  static int __ad7280_read32(struct spi_device *spi, unsigned *val)
>  {
> -	unsigned rx_buf, tx_buf = cpu_to_be32(AD7280A_READ_TXVAL);
> +	__be32 rx_buf, tx_buf = cpu_to_be32(AD7280A_READ_TXVAL);
>  	int ret;
>  
>  	struct spi_transfer t = {
> @@ -214,11 +214,12 @@ static int ad7280_write(struct ad7280_state *st, unsigned devaddr,
>  {
>  	unsigned reg = (devaddr << 27 | addr << 21 |
>  			(val & 0xFF) << 13 | all << 12);
> +	__be32 tx_buf;
>  
>  	reg |= ad7280_calc_crc8(st->crc_tab, reg >> 11) << 3 | 0x2;
> -	reg = cpu_to_be32(reg);
> +	tx_buf = cpu_to_be32(reg);
>  
> -	return spi_write(st->spi, &reg, 4);
> +	return spi_write(st->spi, &tx_buf, 4);
>  }
>  
>  static int ad7280_read(struct ad7280_state *st, unsigned devaddr,
> 
