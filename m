Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbeGUSpP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 14:45:15 -0400
Date: Sat, 21 Jul 2018 18:51:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU
 usage
Message-ID: <20180721185138.673bee00@archlinux>
In-Reply-To: <20180717032052.12273-5-david@lechnology.com>
References: <20180717032052.12273-1-david@lechnology.com>
        <20180717032052.12273-5-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 16 Jul 2018 22:20:52 -0500
David Lechner <david@lechnology.com> wrote:

> This changes how the SPI message for the triggered buffer is setup in
> the TI ADS7950 A/DC driver. By using the SPI_CS_WORD flag, we can read
> multiple samples in a single SPI transfer. If the SPI controller
> supports DMA transfers, we can see a significant reduction in CPU usage.
> 
> For example, on an ARM9 system running at 456MHz reading just 4 channels
> at 100Hz: before this change, top shows the CPU usage of the IRQ thread
> of this driver to be ~7.7%. After this change, the CPU usage drops to
> ~3.8%.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
Hmm. There is a userspace ABI change in here, though it shouldn't matter
as long as people are using the full ABI rather than running some
scripts that make assumptions.  

It's quite nice if we have all the relevant emulation in the SPI core
that this doesn't break things on any spi controllers.

Jonathan

> ---
> 
> Dependency: this patch applies on top of "iio: adc: ti-ads7950: allow
> simultaneous use of buffer and direct mode"[1]
> 
> [1]: https://lore.kernel.org/lkml/20180716233550.6449-1-david@lechnology.com/
> 
> 
>  drivers/iio/adc/ti-ads7950.c | 53 +++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index ba7e5a027490..60de4cbbd5fc 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -60,7 +60,7 @@
>  struct ti_ads7950_state {
>  	struct iio_dev		*indio_dev;
>  	struct spi_device	*spi;
> -	struct spi_transfer	ring_xfer[TI_ADS7950_MAX_CHAN + 2];
> +	struct spi_transfer	ring_xfer;
>  	struct spi_transfer	scan_single_xfer[3];
>  	struct spi_message	ring_msg;
>  	struct spi_message	scan_single_msg;
> @@ -69,16 +69,16 @@ struct ti_ads7950_state {
>  	unsigned int		vref_mv;
>  
>  	unsigned int		settings;
> -	__be16			single_tx;
> -	__be16			single_rx;
> +	u16			single_tx;
> +	u16			single_rx;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
>  	 */
> -	__be16	rx_buf[TI_ADS7950_MAX_CHAN + TI_ADS7950_TIMESTAMP_SIZE]
> +	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2 + TI_ADS7950_TIMESTAMP_SIZE]
>  							____cacheline_aligned;
> -	__be16	tx_buf[TI_ADS7950_MAX_CHAN];
> +	u16 tx_buf[TI_ADS7950_MAX_CHAN + 2];
>  };
>  
>  struct ti_ads7950_chip_info {
> @@ -116,7 +116,7 @@ enum ti_ads7950_id {
>  		.realbits = bits,				\
>  		.storagebits = 16,				\
>  		.shift = 12 - (bits),				\
> -		.endianness = IIO_BE,				\
> +		.endianness = IIO_CPU,				\

Hmm. I'm getting a little dubious.  This is a userspace ABI change - it 'might'
break someone.  We'd have to cross our fingers it doesn't.

>  	},							\
>  }
>  
> @@ -257,23 +257,14 @@ static int ti_ads7950_update_scan_mode(struct iio_dev *indio_dev,
>  	len = 0;
>  	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels) {
>  		cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(i) | st->settings;
> -		st->tx_buf[len++] = cpu_to_be16(cmd);
> +		st->tx_buf[len++] = cmd;
>  	}
>  
>  	/* Data for the 1st channel is not returned until the 3rd transfer */
> -	len += 2;
> -	for (i = 0; i < len; i++) {
> -		if ((i + 2) < len)
> -			st->ring_xfer[i].tx_buf = &st->tx_buf[i];
> -		if (i >= 2)
> -			st->ring_xfer[i].rx_buf = &st->rx_buf[i - 2];
> -		st->ring_xfer[i].len = 2;
> -		st->ring_xfer[i].cs_change = 1;
> -	}
> -	/* make sure last transfer's cs_change is not set */
> -	st->ring_xfer[len - 1].cs_change = 0;
> +	st->tx_buf[len++] = 0;
> +	st->tx_buf[len++] = 0;
>  
> -	spi_message_init_with_transfers(&st->ring_msg, st->ring_xfer, len);
> +	st->ring_xfer.len = len * 2;
>  
>  	return 0;
>  }
> @@ -289,7 +280,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto out;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
>  					   iio_get_time_ns(indio_dev));
>  
>  out:
> @@ -305,13 +296,13 @@ static int ti_ads7950_scan_direct(struct ti_ads7950_state *st, unsigned int ch)
>  	mutex_lock(&st->indio_dev->mlock);
>  
>  	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
> -	st->single_tx = cpu_to_be16(cmd);
> +	st->single_tx = cmd;
>  
>  	ret = spi_sync(st->spi, &st->scan_single_msg);
>  	if (ret)
>  		goto out;
>  
> -	ret = be16_to_cpu(st->single_rx);
> +	ret = st->single_rx;
>  
>  out:
>  	mutex_unlock(&st->indio_dev->mlock);
> @@ -385,6 +376,14 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	const struct ti_ads7950_chip_info *info;
>  	int ret;
>  
> +	spi->bits_per_word = 16;
> +	spi->mode |= SPI_CS_WORD;
> +	ret = spi_setup(spi);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Error in spi setup\n");
> +		return ret;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -406,6 +405,16 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	indio_dev->num_channels = info->num_channels;
>  	indio_dev->info = &ti_ads7950_info;
>  
> +	/* build spi ring message */
> +	spi_message_init(&st->ring_msg);
> +
> +	st->ring_xfer.tx_buf = &st->tx_buf[0];
> +	st->ring_xfer.rx_buf = &st->rx_buf[0];
> +	/* len will be set later */
> +	st->ring_xfer.cs_change = true;
> +
> +	spi_message_add_tail(&st->ring_xfer, &st->ring_msg);
> +
>  	/*
>  	 * Setup default message. The sample is read at the end of the first
>  	 * transfer, then it takes one full cycle to convert the sample and one

