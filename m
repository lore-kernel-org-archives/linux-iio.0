Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48307 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab3K3LK5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:10:57 -0500
Message-ID: <5299C7C0.7060005@kernel.org>
Date: Sat, 30 Nov 2013 11:10:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 08/15] iio:ad7266: Mark transfer buffer as __be16
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-8-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:42, Lars-Peter Clausen wrote:
> Fixes the following warnings from sparse:
> 	drivers/iio/adc/ad7266.c:140:16: warning: cast to restricted __be16
> 	drivers/iio/adc/ad7266.c:140:16: warning: cast to restricted __be16
> 	drivers/iio/adc/ad7266.c:140:16: warning: cast to restricted __be16
> 	drivers/iio/adc/ad7266.c:140:16: warning: cast to restricted __be16

Technically this does a fair bit of other refactoring, but that's all good
anyway.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the togreg branch of iio.git

Thanks.

> ---
>  drivers/iio/adc/ad7266.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 58e9455..70f78c3 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -43,19 +43,22 @@ struct ad7266_state {
>  	 * The buffer needs to be large enough to hold two samples (4 bytes) and
>  	 * the naturally aligned timestamp (8 bytes).
>  	 */
> -	uint8_t data[ALIGN(4, sizeof(s64)) + sizeof(s64)] ____cacheline_aligned;
> +	struct {
> +		__be16 sample[2];
> +		s64 timestamp;
> +	} data ____cacheline_aligned;
>  };
>  
>  static int ad7266_wakeup(struct ad7266_state *st)
>  {
>  	/* Any read with >= 2 bytes will wake the device */
> -	return spi_read(st->spi, st->data, 2);
> +	return spi_read(st->spi, &st->data.sample[0], 2);
>  }
>  
>  static int ad7266_powerdown(struct ad7266_state *st)
>  {
>  	/* Any read with < 2 bytes will powerdown the device */
> -	return spi_read(st->spi, st->data, 1);
> +	return spi_read(st->spi, &st->data.sample[0], 1);
>  }
>  
>  static int ad7266_preenable(struct iio_dev *indio_dev)
> @@ -84,9 +87,9 @@ static irqreturn_t ad7266_trigger_handler(int irq, void *p)
>  	struct ad7266_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = spi_read(st->spi, st->data, 4);
> +	ret = spi_read(st->spi, st->data.sample, 4);
>  	if (ret == 0) {
> -		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +		iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
>  			    pf->timestamp);
>  	}
>  
> @@ -137,7 +140,7 @@ static int ad7266_read_single(struct ad7266_state *st, int *val,
>  	ad7266_select_input(st, address);
>  
>  	ret = spi_sync(st->spi, &st->single_msg);
> -	*val = be16_to_cpu(st->data[address % 2]);
> +	*val = be16_to_cpu(st->data.sample[address % 2]);
>  
>  	return ret;
>  }
> @@ -442,15 +445,15 @@ static int ad7266_probe(struct spi_device *spi)
>  	ad7266_init_channels(indio_dev);
>  
>  	/* wakeup */
> -	st->single_xfer[0].rx_buf = &st->data;
> +	st->single_xfer[0].rx_buf = &st->data.sample[0];
>  	st->single_xfer[0].len = 2;
>  	st->single_xfer[0].cs_change = 1;
>  	/* conversion */
> -	st->single_xfer[1].rx_buf = &st->data;
> +	st->single_xfer[1].rx_buf = st->data.sample;
>  	st->single_xfer[1].len = 4;
>  	st->single_xfer[1].cs_change = 1;
>  	/* powerdown */
> -	st->single_xfer[2].tx_buf = &st->data;
> +	st->single_xfer[2].tx_buf = &st->data.sample[0];
>  	st->single_xfer[2].len = 1;
>  
>  	spi_message_init(&st->single_msg);
> 
