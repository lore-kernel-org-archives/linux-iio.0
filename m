Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-073.synserver.de ([212.40.185.73]:1049 "EHLO
	smtp-out-073.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab3AWJcV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Jan 2013 04:32:21 -0500
Message-ID: <50FFAE56.4070803@metafoo.de>
Date: Wed, 23 Jan 2013 10:33:10 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio:common: Add STMicroelectronics common library
References: <1358757380-3187-1-git-send-email-denis.ciocca@st.com> <1358757380-3187-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1358757380-3187-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I guess we are almost there now. A couple of small things, which need to be
fixed though.

On 01/21/2013 09:36 AM, Denis CIOCCA wrote:
> This patch add a generic library for STMicroelectronics 3-axis sensors.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> ---
>  drivers/iio/common/Kconfig                         |   1 +
>  drivers/iio/common/Makefile                        |   1 +
>  drivers/iio/common/st_sensors/Kconfig              |  14 +
>  drivers/iio/common/st_sensors/Makefile             |  10 +
>  drivers/iio/common/st_sensors/st_sensors_buffer.c  | 115 ++++++
>  drivers/iio/common/st_sensors/st_sensors_core.c    | 411 +++++++++++++++++++++
>  drivers/iio/common/st_sensors/st_sensors_i2c.c     |  81 ++++
>  drivers/iio/common/st_sensors/st_sensors_spi.c     | 128 +++++++
>  drivers/iio/common/st_sensors/st_sensors_trigger.c |  77 ++++
>  include/linux/iio/common/st_sensors.h              | 266 +++++++++++++
>  include/linux/iio/common/st_sensors_i2c.h          |  20 +
>  include/linux/iio/common/st_sensors_spi.h          |  20 +
>  12 files changed, 1144 insertions(+)
>  create mode 100644 drivers/iio/common/st_sensors/Kconfig
>  create mode 100644 drivers/iio/common/st_sensors/Makefile
>  create mode 100644 drivers/iio/common/st_sensors/st_sensors_buffer.c
>  create mode 100644 drivers/iio/common/st_sensors/st_sensors_core.c
>  create mode 100644 drivers/iio/common/st_sensors/st_sensors_i2c.c
>  create mode 100644 drivers/iio/common/st_sensors/st_sensors_spi.c
>  create mode 100644 drivers/iio/common/st_sensors/st_sensors_trigger.c
>  create mode 100644 include/linux/iio/common/st_sensors.h
>  create mode 100644 include/linux/iio/common/st_sensors_i2c.h
>  create mode 100644 include/linux/iio/common/st_sensors_spi.h
> 
> diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
> index ed45ee5..0b6e97d 100644
> --- a/drivers/iio/common/Kconfig
> +++ b/drivers/iio/common/Kconfig
> @@ -3,3 +3,4 @@
>  #
>  
>  source "drivers/iio/common/hid-sensors/Kconfig"
> +source "drivers/iio/common/st_sensors/Kconfig"
> diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
> index 8158400..c2352be 100644
> --- a/drivers/iio/common/Makefile
> +++ b/drivers/iio/common/Makefile
> @@ -7,3 +7,4 @@
>  #
>  
>  obj-y += hid-sensors/
> +obj-y += st_sensors/
> diff --git a/drivers/iio/common/st_sensors/Kconfig b/drivers/iio/common/st_sensors/Kconfig
> new file mode 100644
> index 0000000..84b2dca
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/Kconfig
> @@ -0,0 +1,14 @@
> +#
> +# Hid Sensor common modules
> +#
> +
> +config IIO_ST_SENSORS_I2C
> +	tristate
> +
> +config IIO_ST_SENSORS_SPI
> +	tristate
> +
> +config IIO_ST_SENSORS_CORE
> +	tristate
> +	select IIO_ST_SENSORS_I2C if I2C
> +	select IIO_ST_SENSORS_SPI if SPI_MASTER
> diff --git a/drivers/iio/common/st_sensors/Makefile b/drivers/iio/common/st_sensors/Makefile
> new file mode 100644
> index 0000000..9f3e24f
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/Makefile
> @@ -0,0 +1,10 @@
> +#
> +# Makefile for the STMicroelectronics sensor common modules.
> +#
> +
> +obj-$(CONFIG_IIO_ST_SENSORS_I2C) += st_sensors_i2c.o
> +obj-$(CONFIG_IIO_ST_SENSORS_SPI) += st_sensors_spi.o
> +obj-$(CONFIG_IIO_ST_SENSORS_CORE) += st_sensors.o
> +st_sensors-y := st_sensors_core.o
> +st_sensors-$(CONFIG_IIO_BUFFER) += st_sensors_buffer.o
> +st_sensors-$(CONFIG_IIO_TRIGGER) += st_sensors_trigger.o
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> new file mode 100644
> index 0000000..f4a5adc
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -0,0 +1,115 @@
> +/*
> + * STMicroelectronics sensors buffer library driver
> + *
> + * Copyright 2012-2013 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/irqreturn.h>
> +
> +#include <linux/iio/common/st_sensors.h>
> +
> +int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> +{
> +	int i, n = 0, len;
> +	u8 addr[ST_SENSORS_NUMBER_DATA_CHANNELS];
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	for (i = 0; i < ST_SENSORS_NUMBER_DATA_CHANNELS; i++) {
> +		if (test_bit(i, indio_dev->active_scan_mask)) {
> +			addr[n] = indio_dev->channels[i].address;
> +			n++;
> +		}
> +	}
> +	switch (n) {
> +	case 1:
> +		len = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> +			addr[0], ST_SENSORS_BYTE_FOR_CHANNEL, buf,
> +			sdata->multiread_bit);
> +		break;
> +	case 2:
> +		if ((addr[1] - addr[0]) == ST_SENSORS_BYTE_FOR_CHANNEL) {
> +			len = sdata->tf->read_multiple_byte(&sdata->tb,
> +					sdata->dev, addr[0],
> +					ST_SENSORS_BYTE_FOR_CHANNEL*n,
> +					buf, sdata->multiread_bit);
> +		} else {
> +			u8 rx_array[ST_SENSORS_BYTE_FOR_CHANNEL*
> +				    ST_SENSORS_NUMBER_DATA_CHANNELS];
> +			len = sdata->tf->read_multiple_byte(&sdata->tb,
> +				sdata->dev, addr[0],
> +				ST_SENSORS_BYTE_FOR_CHANNEL*
> +				ST_SENSORS_NUMBER_DATA_CHANNELS,
> +				rx_array, sdata->multiread_bit);
> +			if (len < 0)
> +				goto read_data_channels_error;
> +
> +			for (i = 0; i < n * ST_SENSORS_NUMBER_DATA_CHANNELS;
> +									i++) {
> +				if (i < n)
> +					buf[i] = rx_array[i];
> +				else
> +					buf[i] = rx_array[n + i];
> +			}
> +			len = ST_SENSORS_BYTE_FOR_CHANNEL*n;
> +		}
> +		break;
> +	case 3:
> +		len = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> +			addr[0], ST_SENSORS_BYTE_FOR_CHANNEL*
> +			ST_SENSORS_NUMBER_DATA_CHANNELS,
> +			buf, sdata->multiread_bit);
> +		break;
> +	default:
> +		len = -EINVAL;
> +		goto read_data_channels_error;
> +	}
> +	if (len != ST_SENSORS_BYTE_FOR_CHANNEL*n) {
> +		len = -EIO;
> +		goto read_data_channels_error;
> +	}
> +
> +read_data_channels_error:
> +	return len;
> +}
> +EXPORT_SYMBOL(st_sensors_get_buffer_element);
> +
> +irqreturn_t st_sensors_trigger_handler(int irq, void *p)
> +{
> +	int len;
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	len = st_sensors_get_buffer_element(indio_dev, sdata->buffer_data);
> +	if (len < 0)
> +		goto st_sensors_get_buffer_element_error;
> +
> +	if (indio_dev->scan_timestamp)
> +		*(s64 *)((u8 *)sdata->buffer_data +
> +				ALIGN(len, sizeof(s64))) = pf->timestamp;
> +
> +	iio_push_to_buffers(indio_dev, sdata->buffer_data);
> +
> +st_sensors_get_buffer_element_error:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +EXPORT_SYMBOL(st_sensors_trigger_handler);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics ST-sensors buffer");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> new file mode 100644
> index 0000000..661cc2b
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -0,0 +1,411 @@
> +/*
> + * STMicroelectronics sensors core library driver
> + *
> + * Copyright 2012-2013 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/unaligned/le_byteshift.h>

Never include that file directly. Use asm/unaligned.h, it will provide the
best suited implementation of the unaligned functions for the current
architecture.

> +#include <linux/iio/iio.h>
> +
> +#include <linux/iio/common/st_sensors.h>
> +
> +
[...]

> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> new file mode 100644
> index 0000000..9c62c6a
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -0,0 +1,77 @@
> +/*
> + * STMicroelectronics sensors trigger library driver
> + *
> + * Copyright 2012-2013 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/interrupt.h>
> +
> +#include <linux/iio/common/st_sensors.h>
> +
> +
> +int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> +					struct iio_trigger_ops *trigger_ops)

const

> +{
[...]
