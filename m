Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55377 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932813AbcHaTfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2016 15:35:37 -0400
Subject: Re: [PATCH 05/17] iio: accel: kxsd9: Split out SPI transport
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-6-git-send-email-linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a9ce18dc-ae30-d6e1-9ee5-745fe0fbeef5@kernel.org>
Date: Wed, 31 Aug 2016 20:35:34 +0100
MIME-Version: 1.0
In-Reply-To: <1471354423-19186-6-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/16 14:33, Linus Walleij wrote:
> This moves the KXSD9 SPI transport out to its own file and Kconfig
> entry, so that we will be able to add another transport method.
> We export the common probe and add a local header file for the
> functionality shared between the main driver and the transport
> driver.
> 
> We make the SPI transport the default for the driver if SPI is
> available and the KXSD9 driver was selected, so the oldconfig
> upgrade path will be clear.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

insmod kxsd9.ko

[  612.188999] kxsd9: module license 'unspecified' taints kernel.
[  612.197563] kxsd9: Unknown symbol mutex_lock_nested (err 0)
[  612.210046] kxsd9: Unknown symbol devm_iio_device_alloc (err 0)
[  612.220192] kxsd9: Unknown symbol devm_iio_device_register (err 0)
insmod: cannot insert 'kxsd9.ko': unknown symbol in module, or unknown parameter

Otherwise works.

Jonathan
> ---
>  drivers/iio/accel/Kconfig     |  10 ++-
>  drivers/iio/accel/Makefile    |   1 +
>  drivers/iio/accel/kxsd9-spi.c | 104 +++++++++++++++++++++++++++++++
>  drivers/iio/accel/kxsd9.c     | 140 ++++++------------------------------------
>  drivers/iio/accel/kxsd9.h     |  31 ++++++++++
>  5 files changed, 163 insertions(+), 123 deletions(-)
>  create mode 100644 drivers/iio/accel/kxsd9-spi.c
>  create mode 100644 drivers/iio/accel/kxsd9.h
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 89d78208de3f..95e3fc09f640 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -96,7 +96,6 @@ config IIO_ST_ACCEL_SPI_3AXIS
>  
>  config KXSD9
>  	tristate "Kionix KXSD9 Accelerometer Driver"
> -	depends on SPI
>  	help
>  	  Say yes here to build support for the Kionix KXSD9 accelerometer.
>  	  Currently this only supports the device via an SPI interface.
> @@ -104,6 +103,15 @@ config KXSD9
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called kxsd9.
>  
> +config KXSD9_SPI
> +	tristate "Kionix KXSD9 SPI transport"
> +	depends on KXSD9
> +	depends on SPI
> +	default KXSD9
> +	help
> +	  Say yes here to enable the Kionix KXSD9 accelerometer
> +	  SPI transport channel.
> +
>  config KXCJK1013
>  	tristate "Kionix 3-Axis Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 6cedbecca2ee..22a5770f62a9 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
> +obj-$(CONFIG_KXSD9_SPI)	+= kxsd9-spi.o
>  
>  obj-$(CONFIG_MMA7455)		+= mma7455_core.o
>  obj-$(CONFIG_MMA7455_I2C)	+= mma7455_i2c.o
> diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
> new file mode 100644
> index 000000000000..0789695c89e1
> --- /dev/null
> +++ b/drivers/iio/accel/kxsd9-spi.c
> @@ -0,0 +1,104 @@
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include "kxsd9.h"
> +
> +#define KXSD9_READ(a) (0x80 | (a))
> +#define KXSD9_WRITE(a) (a)
> +
> +static int kxsd9_spi_readreg(struct kxsd9_transport *tr, u8 address)
> +{
> +	struct spi_device *spi = tr->trdev;
> +
> +	return spi_w8r8(spi, KXSD9_READ(address));
> +}
> +
> +static int kxsd9_spi_writereg(struct kxsd9_transport *tr, u8 address, u8 val)
> +{
> +	struct spi_device *spi = tr->trdev;
> +
> +	tr->tx[0] = KXSD9_WRITE(address),
> +	tr->tx[1] = val;
> +	return spi_write(spi, tr->tx, 2);
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
> +	tr->tx[0] = KXSD9_READ(address);
> +	ret = spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
> +	if (!ret)
> +		ret = (((u16)(tr->rx[0])) << 8) | (tr->rx[1]);
> +	return ret;
> +}
> +
> +static int kxsd9_spi_probe(struct spi_device *spi)
> +{
> +	struct kxsd9_transport *transport;
> +	int ret;
> +
> +	transport = devm_kzalloc(&spi->dev, sizeof(*transport), GFP_KERNEL);
> +	if (!transport)
> +		return -ENOMEM;
> +
> +	transport->trdev = spi;
> +	transport->readreg = kxsd9_spi_readreg;
> +	transport->writereg = kxsd9_spi_writereg;
> +	transport->write2 = kxsd9_spi_write2;
> +	transport->readval = kxsd9_spi_readval;
> +	spi->mode = SPI_MODE_0;
> +	spi_setup(spi);
> +
> +	ret = kxsd9_common_probe(&spi->dev,
> +				 transport,
> +				 spi_get_device_id(spi)->name);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id kxsd9_spi_id[] = {
> +	{"kxsd9", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
> +
> +static struct spi_driver kxsd9_spi_driver = {
> +	.driver = {
> +		.name = "kxsd9",
> +	},
> +	.probe = kxsd9_spi_probe,
> +	.id_table = kxsd9_spi_id,
> +};
> +module_spi_driver(kxsd9_spi_driver);
> +
> +MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
> +MODULE_DESCRIPTION("Kionix KXSD9 SPI driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index d3e87eef2594..efa9ba665f6e 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -18,7 +18,6 @@
>  
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/spi/spi.h>
>  #include <linux/sysfs.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -26,6 +25,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> +#include "kxsd9.h"
> +
>  #define KXSD9_REG_X		0x00
>  #define KXSD9_REG_Y		0x02
>  #define KXSD9_REG_Z		0x04
> @@ -38,32 +39,6 @@
>  #define KXSD9_REG_CTRL_B	0x0d
>  #define KXSD9_REG_CTRL_A	0x0e
>  
> -#define KXSD9_READ(a) (0x80 | (a))
> -#define KXSD9_WRITE(a) (a)
> -
> -#define KXSD9_STATE_RX_SIZE 2
> -#define KXSD9_STATE_TX_SIZE 2
> -
> -struct kxsd9_transport;
> -
> -/**
> - * struct kxsd9_transport - transport adapter for SPI or I2C
> - * @trdev: transport device such as SPI or I2C
> - * @write1(): function to write a byte to the device
> - * @write2(): function to write two consecutive bytes to the device
> - * @readval(): function to read a 16bit value from the device
> - * @rx: cache aligned read buffer
> - * @tx: cache aligned write buffer
> - */
> -struct kxsd9_transport {
> -	void *trdev;
> -	int (*write1) (struct kxsd9_transport *tr, u8 byte);
> -	int (*write2) (struct kxsd9_transport *tr, u8 b1, u8 b2);
> -	int (*readval) (struct kxsd9_transport *tr, u8 address);
> -	u8 rx[KXSD9_STATE_RX_SIZE] ____cacheline_aligned;
> -	u8 tx[KXSD9_STATE_TX_SIZE];
> -};
> -
>  /**
>   * struct kxsd9_state - device related storage
>   * @buf_lock:	protect the rx and tx buffers.
> @@ -99,12 +74,13 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
>  		return -EINVAL;
>  
>  	mutex_lock(&st->buf_lock);
> -	ret = st->transport->write1(st->transport, KXSD9_READ(KXSD9_REG_CTRL_C));
> -	if (ret)
> +	ret = st->transport->readreg(st->transport,
> +				     KXSD9_REG_CTRL_C);
> +	if (ret < 0)
>  		goto error_ret;
> -	ret = st->transport->write2(st->transport,
> -				    KXSD9_WRITE(KXSD9_REG_CTRL_C),
> -				    (ret & ~KXSD9_FS_MASK) | i);
> +	ret = st->transport->writereg(st->transport,
> +				      KXSD9_REG_CTRL_C,
> +				      (ret & ~KXSD9_FS_MASK) | i);
>  error_ret:
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
> @@ -116,7 +92,9 @@ static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
>  	struct kxsd9_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->buf_lock);
> -	ret = st->transport->readval(st->transport, KXSD9_READ(address));
> +	ret = st->transport->readval(st->transport, address);
> +	/* Only 12 bits are valid */
> +	ret &= 0xfff0;
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
>  }
> @@ -166,8 +144,9 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = st->transport->write1(st->transport, KXSD9_READ(KXSD9_REG_CTRL_C));
> -		if (ret)
> +		ret = st->transport->readreg(st->transport,
> +					     KXSD9_REG_CTRL_C);
> +		if (ret < 0)
>  			goto error_ret;
>  		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
>  		ret = IIO_VAL_INT_PLUS_MICRO;
> @@ -218,9 +197,9 @@ static const struct iio_info kxsd9_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static int kxsd9_common_probe(struct device *parent,
> -			      struct kxsd9_transport *transport,
> -			      const char *name)
> +int kxsd9_common_probe(struct device *parent,
> +		       struct kxsd9_transport *transport,
> +		       const char *name)
>  {
>  	struct iio_dev *indio_dev;
>  	struct kxsd9_state *st;
> @@ -249,87 +228,4 @@ static int kxsd9_common_probe(struct device *parent,
>  
>  	return 0;
>  }
> -
> -int kxsd9_spi_write1(struct kxsd9_transport *tr, u8 byte)
> -{
> -	struct spi_device *spi = tr->trdev;
> -
> -	return spi_w8r8(spi, byte);
> -}
> -
> -int kxsd9_spi_write2(struct kxsd9_transport *tr, u8 b1, u8 b2)
> -{
> -	struct spi_device *spi = tr->trdev;
> -
> -	tr->tx[0] = b1;
> -	tr->tx[1] = b2;
> -	return spi_write(spi, tr->tx, 2);
> -}
> -
> -int kxsd9_spi_readval(struct kxsd9_transport *tr, u8 address)
> -{
> -	struct spi_device *spi = tr->trdev;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.bits_per_word = 8,
> -			.len = 1,
> -			.delay_usecs = 200,
> -			.tx_buf = tr->tx,
> -		}, {
> -			.bits_per_word = 8,
> -			.len = 2,
> -			.rx_buf = tr->rx,
> -		},
> -	};
> -	int ret;
> -
> -	tr->tx[0] = address;
> -	ret = spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
> -	if (!ret)
> -		ret = (((u16)(tr->rx[0])) << 8) | (tr->rx[1] & 0xF0);
> -	return ret;
> -}
> -
> -static int kxsd9_spi_probe(struct spi_device *spi)
> -{
> -	struct kxsd9_transport *transport;
> -	int ret;
> -
> -	transport = devm_kzalloc(&spi->dev, sizeof(*transport), GFP_KERNEL);
> -	if (!transport)
> -		return -ENOMEM;
> -
> -	transport->trdev = spi;
> -	transport->write1 = kxsd9_spi_write1;
> -	transport->write2 = kxsd9_spi_write2;
> -	transport->readval = kxsd9_spi_readval;
> -	spi->mode = SPI_MODE_0;
> -	spi_setup(spi);
> -
> -	ret = kxsd9_common_probe(&spi->dev,
> -				 transport,
> -				 spi_get_device_id(spi)->name);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static const struct spi_device_id kxsd9_spi_id[] = {
> -	{"kxsd9", 0},
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
> -
> -static struct spi_driver kxsd9_spi_driver = {
> -	.driver = {
> -		.name = "kxsd9",
> -	},
> -	.probe = kxsd9_spi_probe,
> -	.id_table = kxsd9_spi_id,
> -};
> -module_spi_driver(kxsd9_spi_driver);
> -
> -MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
> -MODULE_DESCRIPTION("Kionix KXSD9 SPI driver");
> -MODULE_LICENSE("GPL v2");
> +EXPORT_SYMBOL(kxsd9_common_probe);
> diff --git a/drivers/iio/accel/kxsd9.h b/drivers/iio/accel/kxsd9.h
> new file mode 100644
> index 000000000000..c260a54e00fe
> --- /dev/null
> +++ b/drivers/iio/accel/kxsd9.h
> @@ -0,0 +1,31 @@
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +
> +#define KXSD9_STATE_RX_SIZE 2
> +#define KXSD9_STATE_TX_SIZE 2
> +
> +struct kxsd9_transport;
> +
> +/**
> + * struct kxsd9_transport - transport adapter for SPI or I2C
> + * @trdev: transport device such as SPI or I2C
> + * @readreg(): function to read a byte from an address in the device
> + * @writereg(): function to write a byte to an address in the device
> + * @write2(): function to write two consecutive bytes to the device
> + * @readval(): function to read a 16bit value from the device
> + * @rx: cache aligned read buffer
> + * @tx: cache aligned write buffer
> + */
> +struct kxsd9_transport {
> +	void *trdev;
> +	int (*readreg) (struct kxsd9_transport *tr, u8 address);
> +	int (*writereg) (struct kxsd9_transport *tr, u8 address, u8 val);
> +	int (*write2) (struct kxsd9_transport *tr, u8 b1, u8 b2);
> +	int (*readval) (struct kxsd9_transport *tr, u8 address);
> +	u8 rx[KXSD9_STATE_RX_SIZE] ____cacheline_aligned;
> +	u8 tx[KXSD9_STATE_TX_SIZE];
> +};
> +
> +int kxsd9_common_probe(struct device *parent,
> +		       struct kxsd9_transport *transport,
> +		       const char *name);
> 

