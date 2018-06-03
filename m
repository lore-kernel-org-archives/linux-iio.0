Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeFCP2k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Jun 2018 11:28:40 -0400
Date: Sun, 3 Jun 2018 16:28:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads8688: use the auto sequence feature
Message-ID: <20180603162835.59676a01@archlinux>
In-Reply-To: <20180530211821.8496-1-sean.nyekjaer@prevas.dk>
References: <20180530211821.8496-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 30 May 2018 23:18:21 +0200
Sean Nyekjaer <sean.nyekjaer@prevas.dk> wrote:

> The TI ADS8688 have a auto sequence feature that allows
> to continuesly reading new values from the chosen channels.
> Lets enable it and we will be able to sample at the double speed
> vs the old implementation
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>

hmm. Technically it's an ABI change as someone may be relying on the
ability to do sysfs reads whilst we are also using the chardev interface.
However, I doubt anyone is so lest see if anyone notices ;)

One comment inline. Otherwise looks fine to me.

With care, we could gotten the speed up without using autosequencing
but that doesn't really matter as that isn't what we were doing previously.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads8688.c | 60 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index 184d686ebd99..8e18c0caa1d7 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -25,10 +25,12 @@
>  #define ADS8688_CMD_REG(x)		(x << 8)
>  #define ADS8688_CMD_REG_NOOP		0x00
>  #define ADS8688_CMD_REG_RST		0x85
> +#define ADS8688_CMD_REG_AUTO_RST	0xA0
>  #define ADS8688_CMD_REG_MAN_CH(chan)	(0xC0 | (4 * chan))
>  #define ADS8688_CMD_DONT_CARE_BITS	16
>  
>  #define ADS8688_PROG_REG(x)		(x << 9)
> +#define ADS8688_AUTO_SEQ_EN		0x01
>  #define ADS8688_PROG_REG_RANGE_CH(chan)	(0x05 + chan)
>  #define ADS8688_PROG_WR_BIT		BIT(8)
>  #define ADS8688_PROG_DONT_CARE_BITS	8
> @@ -210,6 +212,39 @@ static int ads8688_reset(struct iio_dev *indio_dev)
>  	return spi_write(st->spi, &st->data[0].d8[0], 4);
>  }
>  
> +static int ads8688_start_autoseq(struct iio_dev *indio_dev)
> +{
> +	struct ads8688_state *st = iio_priv(indio_dev);
> +	u32 tmp;
> +
> +	tmp = ADS8688_CMD_REG(ADS8688_CMD_REG_AUTO_RST);
> +	tmp <<= ADS8688_CMD_DONT_CARE_BITS;
> +	st->data[0].d32 = cpu_to_be32(tmp);
> +
> +	return spi_write(st->spi, &st->data[0].d8[0], 4);
> +}
> +
> +static int ads8688_read_autoseq(struct iio_dev *indio_dev)
> +{
> +	struct ads8688_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u32 tmp;
> +	struct spi_transfer t = {
> +		.tx_buf = &st->data[0].d8[0],
> +		.len = 4,
> +	};
> +
> +	tmp = ADS8688_CMD_REG(ADS8688_CMD_REG_NOOP);
> +	tmp <<= ADS8688_CMD_DONT_CARE_BITS;
> +	st->data[0].d32 = cpu_to_be32(tmp);
> +
> +	ret = spi_sync_transfer(st->spi, &t, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return be32_to_cpu(st->data[0].d32) & 0xffff;
> +}
> +
>  static int ads8688_read(struct iio_dev *indio_dev, unsigned int chan)
>  {
>  	struct ads8688_state *st = iio_priv(indio_dev);
> @@ -251,6 +286,10 @@ static int ads8688_read_raw(struct iio_dev *indio_dev,
>  
>  	struct ads8688_state *st = iio_priv(indio_dev);
>  
> +	/* Block raw reading when in triggered mode */
> +	if (iio_buffer_enabled(indio_dev))
> +		return -EBUSY;
> +
>  	mutex_lock(&st->lock);
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -299,6 +338,10 @@ static int ads8688_write_raw(struct iio_dev *indio_dev,
>  	unsigned int scale = 0;
>  	int ret = -EINVAL, i, offset = 0;
>  
> +	/* Block setup when in triggered mode */
> +	if (iio_buffer_enabled(indio_dev))
> +		return -EBUSY;
> +
>  	mutex_lock(&st->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -374,10 +417,25 @@ static int ads8688_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int ads8688_update_scan_mode(struct iio_dev *indio_dev,
> +	const unsigned long *active_scan_mask)
> +{
> +	int scan_count;
> +
> +	scan_count = bitmap_weight(active_scan_mask, indio_dev->masklength);

What is scan_count for?

> +
> +	ads8688_prog_write(indio_dev, ADS8688_AUTO_SEQ_EN, (int)active_scan_mask);
> +
> +	ads8688_start_autoseq(indio_dev);
> +
> +	return 0;
> +}
> +
>  static const struct iio_info ads8688_info = {
>  	.read_raw = &ads8688_read_raw,
>  	.write_raw = &ads8688_write_raw,
>  	.write_raw_get_fmt = &ads8688_write_raw_get_fmt,
> +	.update_scan_mode = ads8688_update_scan_mode,
>  	.attrs = &ads8688_attribute_group,
>  };
>  
> @@ -391,7 +449,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
>  	for (i = 0; i < indio_dev->masklength; i++) {
>  		if (!test_bit(i, indio_dev->active_scan_mask))
>  			continue;
> -		buffer[j] = ads8688_read(indio_dev, i);
> +		buffer[j] = ads8688_read_autoseq(indio_dev);

>  		j++;
>  	}
>  

