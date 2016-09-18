Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49312 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753976AbcIRKGT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 06:06:19 -0400
Subject: Re: [PATCH 02/15 v2] iio: accel: kxsd9: Split out transport mechanism
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
 <1472723089-25113-2-git-send-email-linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1df13476-f0fc-4859-5dc1-437276cc022b@kernel.org>
Date: Sun, 18 Sep 2016 11:06:14 +0100
MIME-Version: 1.0
In-Reply-To: <1472723089-25113-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/16 10:44, Linus Walleij wrote:
> Split off a transport mechanism struct that will deal with the SPI
> traffic in preparation for adding I2C support.
> 
> Tested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git.  Not sure if there is time
for another pull request to Greg this cycle... 

Thanks,

Jonathan
> ---
> ChangeLog v1->v2:
> - Staticize the SPI accessors to avoid noise when compiling
>   with all warnings.
> - Fix up the interim stage kerneldoc to match the movement
>   of tx, rx and the introduced transport struct.
> ---
>  drivers/iio/accel/kxsd9.c | 175 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 123 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 9d72d4bcf5e9..df8a31e84c7d 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -43,18 +43,36 @@
>  
>  #define KXSD9_STATE_RX_SIZE 2
>  #define KXSD9_STATE_TX_SIZE 2
> +
> +struct kxsd9_transport;
> +
> +/**
> + * struct kxsd9_transport - transport adapter for SPI or I2C
> + * @trdev: transport device such as SPI or I2C
> + * @write1(): function to write a byte to the device
> + * @write2(): function to write two consecutive bytes to the device
> + * @readval(): function to read a 16bit value from the device
> + * @rx: cache aligned read buffer
> + * @tx: cache aligned write buffer
> + */
> +struct kxsd9_transport {
> +	void *trdev;
> +	int (*write1) (struct kxsd9_transport *tr, u8 byte);
> +	int (*write2) (struct kxsd9_transport *tr, u8 b1, u8 b2);
> +	int (*readval) (struct kxsd9_transport *tr, u8 address);
> +	u8 rx[KXSD9_STATE_RX_SIZE] ____cacheline_aligned;
> +	u8 tx[KXSD9_STATE_TX_SIZE];
> +};
> +
>  /**
>   * struct kxsd9_state - device related storage
> + * @transport:	transport for the KXSD9
>   * @buf_lock:	protect the rx and tx buffers.
>   * @us:		spi device
> - * @rx:		single rx buffer storage
> - * @tx:		single tx buffer storage
>   **/
>  struct kxsd9_state {
> +	struct kxsd9_transport *transport;
>  	struct mutex buf_lock;
> -	struct spi_device *us;
> -	u8 rx[KXSD9_STATE_RX_SIZE] ____cacheline_aligned;
> -	u8 tx[KXSD9_STATE_TX_SIZE];
>  };
>  
>  #define KXSD9_SCALE_2G "0.011978"
> @@ -80,13 +98,12 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
>  		return -EINVAL;
>  
>  	mutex_lock(&st->buf_lock);
> -	ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
> -	if (ret < 0)
> +	ret = st->transport->write1(st->transport, KXSD9_READ(KXSD9_REG_CTRL_C));
> +	if (ret)
>  		goto error_ret;
> -	st->tx[0] = KXSD9_WRITE(KXSD9_REG_CTRL_C);
> -	st->tx[1] = (ret & ~KXSD9_FS_MASK) | i;
> -
> -	ret = spi_write(st->us, st->tx, 2);
> +	ret = st->transport->write2(st->transport,
> +				    KXSD9_WRITE(KXSD9_REG_CTRL_C),
> +				    (ret & ~KXSD9_FS_MASK) | i);
>  error_ret:
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
> @@ -96,24 +113,9 @@ static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
>  {
>  	int ret;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfers[] = {
> -		{
> -			.bits_per_word = 8,
> -			.len = 1,
> -			.delay_usecs = 200,
> -			.tx_buf = st->tx,
> -		}, {
> -			.bits_per_word = 8,
> -			.len = 2,
> -			.rx_buf = st->rx,
> -		},
> -	};
>  
>  	mutex_lock(&st->buf_lock);
> -	st->tx[0] = KXSD9_READ(address);
> -	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
> -	if (!ret)
> -		ret = (((u16)(st->rx[0])) << 8) | (st->rx[1] & 0xF0);
> +	ret = st->transport->readval(st->transport, KXSD9_READ(address));
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
>  }
> @@ -163,8 +165,8 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
> -		if (ret < 0)
> +		ret = st->transport->write1(st->transport, KXSD9_READ(KXSD9_REG_CTRL_C));
> +		if (ret)
>  			goto error_ret;
>  		*val = 0;
>  		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
> @@ -203,15 +205,10 @@ static int kxsd9_power_up(struct kxsd9_state *st)
>  {
>  	int ret;
>  
> -	st->tx[0] = 0x0d;
> -	st->tx[1] = 0x40;
> -	ret = spi_write(st->us, st->tx, 2);
> +	ret = st->transport->write2(st->transport, 0x0d, 0x40);
>  	if (ret)
>  		return ret;
> -
> -	st->tx[0] = 0x0c;
> -	st->tx[1] = 0x9b;
> -	return spi_write(st->us, st->tx, 2);
> +	return st->transport->write2(st->transport, 0x0c, 0x9b);
>  };
>  
>  static const struct iio_info kxsd9_info = {
> @@ -221,56 +218,130 @@ static const struct iio_info kxsd9_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static int kxsd9_probe(struct spi_device *spi)
> +static int kxsd9_common_probe(struct device *parent,
> +			      struct kxsd9_transport *transport,
> +			      const char *name,
> +			      struct iio_dev **retdev)
>  {
>  	struct iio_dev *indio_dev;
>  	struct kxsd9_state *st;
> +	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(parent, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	spi_set_drvdata(spi, indio_dev);
> +	st->transport = transport;
>  
> -	st->us = spi;
>  	mutex_init(&st->buf_lock);
>  	indio_dev->channels = kxsd9_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(kxsd9_channels);
> -	indio_dev->name = spi_get_device_id(spi)->name;
> -	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = name;
> +	indio_dev->dev.parent = parent;
>  	indio_dev->info = &kxsd9_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	kxsd9_power_up(st);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	*retdev = indio_dev;
> +	return 0;
> +}
> +
> +static int kxsd9_spi_write1(struct kxsd9_transport *tr, u8 byte)
> +{
> +	struct spi_device *spi = tr->trdev;
> +
> +	return spi_w8r8(spi, byte);
> +}
> +
> +static int kxsd9_spi_write2(struct kxsd9_transport *tr, u8 b1, u8 b2)
> +{
> +	struct spi_device *spi = tr->trdev;
> +
> +	tr->tx[0] = b1;
> +	tr->tx[1] = b2;
> +	return spi_write(spi, tr->tx, 2);
> +}
> +
> +static int kxsd9_spi_readval(struct kxsd9_transport *tr, u8 address)
> +{
> +	struct spi_device *spi = tr->trdev;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.bits_per_word = 8,
> +			.len = 1,
> +			.delay_usecs = 200,
> +			.tx_buf = tr->tx,
> +		}, {
> +			.bits_per_word = 8,
> +			.len = 2,
> +			.rx_buf = tr->rx,
> +		},
> +	};
> +	int ret;
> +
> +	tr->tx[0] = address;
> +	ret = spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
> +	if (!ret)
> +		ret = (((u16)(tr->rx[0])) << 8) | (tr->rx[1] & 0xF0);
> +	return ret;
> +}
> +
> +static int kxsd9_spi_probe(struct spi_device *spi)
> +{
> +	struct kxsd9_transport *transport;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	transport = devm_kzalloc(&spi->dev, sizeof(*transport), GFP_KERNEL);
> +	if (!transport)
> +		return -ENOMEM;
> +
> +	transport->trdev = spi;
> +	transport->write1 = kxsd9_spi_write1;
> +	transport->write2 = kxsd9_spi_write2;
> +	transport->readval = kxsd9_spi_readval;
>  	spi->mode = SPI_MODE_0;
>  	spi_setup(spi);
> -	kxsd9_power_up(st);
>  
> -	return iio_device_register(indio_dev);
> +	ret = kxsd9_common_probe(&spi->dev,
> +				 transport,
> +				 spi_get_device_id(spi)->name,
> +				 &indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +	return 0;
>  }
>  
> -static int kxsd9_remove(struct spi_device *spi)
> +static int kxsd9_spi_remove(struct spi_device *spi)
>  {
>  	iio_device_unregister(spi_get_drvdata(spi));
>  
>  	return 0;
>  }
>  
> -static const struct spi_device_id kxsd9_id[] = {
> +static const struct spi_device_id kxsd9_spi_id[] = {
>  	{"kxsd9", 0},
>  	{ },
>  };
> -MODULE_DEVICE_TABLE(spi, kxsd9_id);
> +MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
>  
> -static struct spi_driver kxsd9_driver = {
> +static struct spi_driver kxsd9_spi_driver = {
>  	.driver = {
>  		.name = "kxsd9",
>  	},
> -	.probe = kxsd9_probe,
> -	.remove = kxsd9_remove,
> -	.id_table = kxsd9_id,
> +	.probe = kxsd9_spi_probe,
> +	.remove = kxsd9_spi_remove,
> +	.id_table = kxsd9_spi_id,
>  };
> -module_spi_driver(kxsd9_driver);
> +module_spi_driver(kxsd9_spi_driver);
>  
>  MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
>  MODULE_DESCRIPTION("Kionix KXSD9 SPI driver");
> 

