Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-130.synserver.de ([212.40.185.130]:1068 "EHLO
	smtp-out-120.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752847Ab2F1I1o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jun 2012 04:27:44 -0400
Message-ID: <4FEC165D.7050209@metafoo.de>
Date: Thu, 28 Jun 2012 10:31:25 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add adjd_s311 I2C digital color sensor driver
References: <1340839004-15731-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340839004-15731-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/28/2012 01:16 AM, Peter Meerwald wrote:
> sensor has 4 channels (10-bit each, R/G/B and clear), sensitivity
> and gain is controlled in the driver by ext_info integration_time
> and CHAN_INFO_HARDWAREGAIN
> 
> driver supports triggered buffer and IIO_CHAN_INFO_RAW to get the
> sensor data
> 
> patch depends on IIO_MOD_LIGHT_RED etc, the patch providing that
> (http://permalink.gmane.org/gmane.linux.kernel.iio/4354) has not been
> merged yet
> 

Looks pretty good, couple of comments and suggestions inline.

> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  drivers/iio/light/Kconfig     |   12 ++
>  drivers/iio/light/Makefile    |    1 +
>  drivers/iio/light/adjd_s311.c |  400 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 413 insertions(+)
>  create mode 100644 drivers/iio/light/adjd_s311.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index f3ea90d..4504ef2 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -30,4 +30,16 @@ config VCNL4000
>  	 To compile this driver as a module, choose M here: the
>  	 module will be called vcnl4000.
>  
> +config ADJD_S311
> +	tristate "ADJD-S311-CR999 digital color sensor"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	depends on I2C
> +	help
> +	 If you say yes here you get support for the Avago ADJD-S311-CR999
> +	 digital color light sensor.
> +
> +	 This driver can also be built as a module.  If so, the module
> +	 will be called adjd_s311.
> +
>  endmenu
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 06fa4d3..740cfd6 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -4,3 +4,4 @@
>  
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
> +obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o


I'd prefer alphabetical order for both Kconfig and Makefile, makes it easier
to maintain on the long run.


> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> new file mode 100644
> index 0000000..8aafa18
> --- /dev/null
> +++ b/drivers/iio/light/adjd_s311.c
> @@ -0,0 +1,400 @@
> +/*
> + * adjd_s311.c - Support for ADJD-S311-CR999 digital color sensor
> + *
> + * Copyright (C) 2012 Peter Meerwald <pmeerw@pmeerw.net>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * driver for ADJD-S311-CR999 digital color sensor (10-bit channels for
> + * red, green, blue, clear); 7-bit I2C slave address 0x74
> + *
> + * limitations: no calibration, no offset mode, no sleep mode
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/bitmap.h>
> +#include <linux/err.h>
> +#include <linux/irq.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define ADJD_S311_DRV_NAME "adjd_s311"
> +
> +#define CTRL		0x00
> +#define CONFIG		0x01
> +#define CAP_RED		0x06
> +#define CAP_GREEN	0x07
> +#define CAP_BLUE	0x08
> +#define CAP_CLEAR	0x09
> +#define INT_RED_LO	0x0a
> +#define INT_RED_HI	0x0b
> +#define INT_GREEN_LO	0x0c
> +#define INT_GREEN_HI	0x0d
> +#define INT_BLUE_LO	0x0e
> +#define INT_BLUE_HI	0x0f
> +#define INT_CLEAR_LO	0x10
> +#define INT_CLEAR_HI	0x11
> +#define DATA_RED_LO	0x40
> +#define DATA_RED_HI	0x41
> +#define DATA_GREEN_LO	0x42
> +#define DATA_GREEN_HI	0x43
> +#define DATA_BLUE_LO	0x44
> +#define DATA_BLUE_HI	0x45
> +#define DATA_CLEAR_LO	0x46
> +#define DATA_CLEAR_HI	0x47
> +#define OFFSET_RED	0x48
> +#define OFFSET_GREEN	0x49
> +#define OFFSET_BLUE	0x4a
> +#define OFFSET_CLEAR	0x4b
> +
> +#define CTRL_GOFS	0x02
> +#define CTRL_GSSR	0x01
> +
> +#define CAP_MASK	0x0f
> +#define INT_MASK	0x0fff
> +#define DATA_MASK	0x03ff

I'd like to see these defines namespaced. I.e. add a ADJD_S331_ prefix.

> +
> +struct adjd_s311_data {
> +	struct i2c_client *client;
> +};
> +
> +struct adjd_s311_channel_regs {
> +	u8 data_reg;
> +	u8 int_reg;
> +	u8 cap_reg;
> +};
> +
> +enum adjd_s311_channel_idx {
> +	IDX_RED, IDX_GREEN, IDX_BLUE, IDX_CLEAR
> +};
> +
> +static const struct adjd_s311_channel_regs adjd_s311_regs[] = {
> +	[IDX_RED] = { DATA_RED_LO, INT_RED_LO, CAP_RED },
> +	[IDX_GREEN] = { DATA_GREEN_LO, INT_GREEN_LO, CAP_GREEN },
> +	[IDX_BLUE] = { DATA_BLUE_LO, INT_BLUE_LO, CAP_BLUE },
> +	[IDX_CLEAR] = { DATA_CLEAR_LO, INT_CLEAR_LO, CAP_CLEAR },
> +};

Since the register layout seems to be regular, I wouldn't bother with a
lookup table and just calculate the register address. Something like

DATA_REG(chan) (DATA_RED_LO + (chan) * 2)

But that's just an suggestion and either solution should be fine.

> [...]
> +static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adjd_s311_data *data = iio_priv(indio_dev);
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	int len = 0;
> +	u16 *buf;
> +
> +	int ret = adjd_s311_req_data(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);

You could do this allocation in the update_scan_mode callback. So it doesn't
have to be redone for each set of samples.

> +	if (buf == NULL)
> +		return -ENOMEM;
> +
> +	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {

I know that this check is in other drivers as well, but I think the upper
layers will already error out if there is no real data to capture and we'll
never reach this point.

> +		int i, j;
> +		for (i = 0, j = 0;
> +		     i < bitmap_weight(indio_dev->active_scan_mask,
> +				       indio_dev->masklength);
> +		     i++, j++) {
> +			j = find_next_bit(buffer->scan_mask,
> +					  indio_dev->masklength, j);
> +

Just for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength)

Currently buffer->scan_mask and indio_dev->active_scan_mask will point to
the same address. But just using indio_dev->active_scan_mask will also work
once multi-buffer support has been added.

> +			ret = i2c_smbus_read_word_data(data->client,
> +				adjd_s311_regs[j].data_reg);
> +			if (ret < 0) {
> +				kfree(buf);
> +				return ret;
> +			}
> +
> +			buf[i] = ret & DATA_MASK;
> +			len += 2;
> +		}
> +	}
> +
> +	if (indio_dev->scan_timestamp)
> +		*(s64 *)((phys_addr_t)data + ALIGN(len, sizeof(s64)))
> +			= iio_get_time_ns();
> +	buffer->access->store_to(buffer, (u8 *)buf, pf->timestamp);

iio_push_to_buffer

> +
> +	kfree(buf);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> [...]
> +
> +	err = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
> +		adjd_s311_trigger_handler, NULL);

I think you can set the hardirq handler to NULL. iio_pollfunc_store_time
just stores the current time in pf->timestamp, but you never use it.

> +	if (err < 0)
> +		goto exit_free_device;
>[...]
> +
> +static int __devexit adjd_s311_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_buffer_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);

iio_triggered_buffer_cleanup already calls iio_buffer_unregister

> +	iio_device_unregister(indio_dev);

iio_device_unregister should be called before
iio_triggered_buffer_cleanup

> +	iio_device_free(indio_dev);
> +
> +	return 0;
> +}
> +

