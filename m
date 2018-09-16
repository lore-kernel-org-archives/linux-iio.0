Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbeIPRD4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 13:03:56 -0400
Date: Sun, 16 Sep 2018 12:41:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
 CPU usage
Message-ID: <20180916124110.4edfad9d@archlinux>
In-Reply-To: <20180913003920.30600-4-david@lechnology.com>
References: <20180913003920.30600-1-david@lechnology.com>
        <20180913003920.30600-4-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 12 Sep 2018 19:39:19 -0500
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

Hi David,

I've managed to forget why we are changing any of the endian related code
at all.  The change SPI_CS_WORD result in changes between words which is
fine but it doesn't change any ordering within words?  So as such why
do we no longer need to do the big endian conversions?

Jonathan

> ---
> 
> It was brought up in v1 that changing the endianness *could* possible break
> users who are taking shortcuts by making assumptions on the data format instead
> of using the full ABI to determine the format. Since this only *might* be a
> problem I would like to make this change anyway to avoid a bunch of byte
> swapping. If it turns out that it really is a problem instead of *might be*
> a problem, then we can fix it later.
> 
>  drivers/iio/adc/ti-ads7950.c | 53 +++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index a5bd5944bc66..0ad63592cc3c 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -51,7 +51,7 @@
>  
>  struct ti_ads7950_state {
>  	struct spi_device	*spi;
> -	struct spi_transfer	ring_xfer[TI_ADS7950_MAX_CHAN + 2];
> +	struct spi_transfer	ring_xfer;
>  	struct spi_transfer	scan_single_xfer[3];
>  	struct spi_message	ring_msg;
>  	struct spi_message	scan_single_msg;
> @@ -65,11 +65,11 @@ struct ti_ads7950_state {
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
>  	 */
> -	__be16	rx_buf[TI_ADS7950_MAX_CHAN + TI_ADS7950_TIMESTAMP_SIZE]
> +	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2 + TI_ADS7950_TIMESTAMP_SIZE]
>  							____cacheline_aligned;
> -	__be16	tx_buf[TI_ADS7950_MAX_CHAN];
> -	__be16			single_tx;
> -	__be16			single_rx;
> +	u16 tx_buf[TI_ADS7950_MAX_CHAN + 2];
> +	u16 single_tx;
> +	u16 single_rx;
>  
>  };
>  
> @@ -108,7 +108,7 @@ enum ti_ads7950_id {
>  		.realbits = bits,				\
>  		.storagebits = 16,				\
>  		.shift = 12 - (bits),				\
> -		.endianness = IIO_BE,				\
> +		.endianness = IIO_CPU,				\
>  	},							\
>  }
>  
> @@ -249,23 +249,14 @@ static int ti_ads7950_update_scan_mode(struct iio_dev *indio_dev,
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
> @@ -281,7 +272,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto out;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
>  					   iio_get_time_ns(indio_dev));
>  
>  out:
> @@ -298,13 +289,13 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  	mutex_lock(&indio_dev->mlock);
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
>  	mutex_unlock(&indio_dev->mlock);
> @@ -378,6 +369,14 @@ static int ti_ads7950_probe(struct spi_device *spi)
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
> @@ -398,6 +397,16 @@ static int ti_ads7950_probe(struct spi_device *spi)
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
