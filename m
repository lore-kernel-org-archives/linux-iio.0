Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46037 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeILXls (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Sep 2018 19:41:48 -0400
Date: Thu, 13 Sep 2018 00:05:51 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Song Qiang <songqiang1304521@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, andriy.shevchenko@linux.intel.com,
        matt.ranostay@konsulko.com, ak@it-klinger.de, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: Re: [PATCH v3] iio: proximity: Add driver support for ST's VL53L0X
 ToF ranging sensor.
Message-ID: <20180912183551.GA13425@himanshu-Vostro-3559>
References: <20180912022034.25972-1-songqiang.1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180912022034.25972-1-songqiang.1304521@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Sep 12, 2018 at 10:20:34AM +0800, Song Qiang wrote:
> This driver was originally written by ST in 2016 as a misc input device
> driver, and hasn't been maintained for a long time. I grabbed some code
> from it's API and reformed it into a iio proximity device driver.
> This version of driver uses i2c bus to talk to the sensor and
> polling for measuring completes, so no irq line is needed.
> This version of driver supports only one-shot mode, and it can be
> tested with reading from
> /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> 
> Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>

Very minor comments below that I missed in previous revisions.

Major reviews will come from Jonathan later...

> ---
> Changes in v2:
> 	- Clean up the register table.
> 	- Sort header files declarations.
> 	- Replace some bit definations with GENMASK() and BIT().
> 	- Clean up some code and comments that's useless for now.
> 	- Change the order of some the definations of some variables to reversed
> 	  xmas tree order.
> 	- Using do...while() rather while and check.
> 	- Replace pr_err() with dev_err().
> 	- Remove device id declaration since we recommend to use DT.
> 	- Remove .owner = THIS_MODULE.
> 	- Replace probe() with probe_new() hook.
> 	- Remove IIO_BUFFER and IIO_TRIGGERED_BUFFER dependences.
> 	- Change the driver module name to vl53l0x-i2c.
> 	- Align all the parameters if they are in the same function with open
> 	  parentheses.
> 	- Replace iio_device_register() with devm_iio_device_register
> 	  for better resource management.
> 	- Remove the vl53l0x_remove() since it's not needed.
> 	- Remove dev_set_drvdata() since it's already setted above.
> 
> Changes in v3:
> 	- Recover ST's copyright.
> 	- Clean up indio_dev member in vl53l0x_data struct since it's
> 	  useless now.
> 	- Replace __le16_to_cpu() with le16_to_cpu().
> 	- Remove the iio_device_{claim|release}_direct_mode() since it's
> 	  only needed when we use buffered mode.
> 	- Clean up some coding style problems.
> 
>  .../bindings/iio/proximity/vl53l0x.txt        |  12 ++
>  drivers/iio/proximity/Kconfig                 |  11 ++
>  drivers/iio/proximity/Makefile                |   2 +
>  drivers/iio/proximity/vl53l0x-i2c.c           | 184 ++++++++++++++++++
>  4 files changed, 209 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
>  create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> new file mode 100644
> index 000000000000..64b69442f08e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> @@ -0,0 +1,12 @@
> +ST's VL53L0X ToF ranging sensor
> +
> +Required properties:
> +	- compatible: must be "st,vl53l0x-i2c"
> +	- reg: i2c address where to find the device
> +
> +Example:
> +
> +vl53l0x@29 {
> +	compatible = "st,vl53l0x-i2c";
> +	reg = <0x29>;
> +};
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index f726f9427602..5f421cbd37f3 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -79,4 +79,15 @@ config SRF08
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called srf08.
>  
> +config VL53L0X_I2C
> +	tristate "STMicroelectronics VL53L0X ToF ranger sensor (I2C)"
> +	depends on I2C
> +	help
> +	  Say Y here to build a driver for STMicroelectronics VL53L0X
> +	  ToF ranger sensors with i2c interface.
> +	  This driver can be used to measure the distance of objects.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called vl53l0x-i2c.
> +
>  endmenu
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 4f4ed45e87ef..dedfb5bf3475 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -10,3 +10,5 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
> +obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
> +
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> new file mode 100644
> index 000000000000..0f7f124a38ed
> --- /dev/null
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Support for ST's VL53L0X FlightSense ToF Ranger Sensor on a i2c bus.
> + *
> + *  Copyright (C) 2016 STMicroelectronics Imaging Division.
> + *  Copyright (C) 2018 Song Qiang <songqiang.1304521@gmail.com>

Datasheet link + i2c slave address can be put here.
Look at other iio drivers.

> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#define VL53L0X_DRV_NAME				"vl53l0x-i2c"
> +
> +#define VL_REG_SYSRANGE_MODE_MASK			GENMASK(3, 0)
> +#define VL_REG_SYSRANGE_START				0x00
> +#define VL_REG_SYSRANGE_MODE_SINGLESHOT			0x00
> +#define VL_REG_SYSRANGE_MODE_START_STOP			BIT(0)
> +#define VL_REG_SYSRANGE_MODE_BACKTOBACK			BIT(1)
> +#define VL_REG_SYSRANGE_MODE_TIMED			BIT(2)
> +#define VL_REG_SYSRANGE_MODE_HISTOGRAM			BIT(3)
> +
> +#define VL_REG_SYS_SEQUENCE_CFG				BIT(0)
> +#define VL_REG_SYS_INTERMEASUREMENT_PERIOD		BIT(2)
> +#define VL_REG_SYS_RANGE_CFG				0x09
> +
> +#define VL_REG_SYS_INT_GPIO_DISABLED			0x00
> +#define VL_REG_SYS_INT_GPIO_LEVEL_LOW			BIT(0)
> +#define VL_REG_SYS_INT_GPIO_LEVEL_HIGH			BIT(1)
> +#define VL_REG_SYS_INT_GPIO_OUT_OF_WINDOW		0x03
> +#define VL_REG_SYS_INT_GPIO_NEW_SAMPLE_READY		BIT(2)
> +#define VL_REG_SYS_INT_CFG_GPIO				0x0A
> +#define VL_REG_SYS_INT_CLEAR				0x0B
> +#define VL_REG_GPIO_HV_MUX_ACTIVE_HIGH			0x84
> +
> +#define VL_REG_RESULT_INT_STATUS			0x13
> +#define VL_REG_RESULT_RANGE_STATUS			0x14
> +#define VL_REG_RESULT_RANGE_SATTUS_COMPLETE		BIT(0)
> +
> +#define VL_REG_I2C_SLAVE_DEVICE_ADDRESS			0x8a
> +
> +#define VL_REG_IDENTIFICATION_MODEL_ID			0xc0
> +#define VL_REG_IDENTIFICATION_REVISION_ID		0xc2

Make all capitals: 0xC2, 0xC0, 0x8A ...

> +struct vl53l0x_data {
> +	struct i2c_client *client;
> +};
> +
> +static int vl53l0x_read_proximity(struct vl53l0x_data *data,
> +				  const struct iio_chan_spec *chan,
> +				  int *val)
> +{
> +	u8 write_command = VL_REG_RESULT_RANGE_STATUS;
> +	struct i2c_client *client = data->client;
> +	unsigned int tries = 20;
> +	struct i2c_msg msg[2];
> +	u8 buffer[12];
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					VL_REG_SYSRANGE_START, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	do {
> +		ret = i2c_smbus_read_byte_data(data->client,
> +					       VL_REG_RESULT_RANGE_STATUS);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & VL_REG_RESULT_RANGE_SATTUS_COMPLETE)
> +			break;
> +
> +		usleep_range(1000, 5000);
> +	} while (tries--);
> +	if (!tries)
> +		return -ETIMEDOUT;
> +
> +	msg[0].addr = client->addr;
> +	msg[0].buf = &write_command;
> +	msg[0].len = 1;
> +	msg[0].flags = client->flags | I2C_M_STOP;
> +
> +	msg[1].addr = client->addr;
> +	msg[1].buf = buffer;
> +	msg[1].len = 12;
> +	msg[1].flags = client->flags | I2C_M_RD;
> +
> +	ret = i2c_transfer(client->adapter, msg, 2);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret != 2)
> +		dev_err(&data->client->dev, "vl53l0x: consecutively read error. ");
> +
> +	*val = le16_to_cpu((buffer[10] << 8) + buffer[11]);
> +
> +	return 0;
> +}
> +
> +static const struct iio_chan_spec vl53l0x_channels[] = {
> +	{
> +		.type = IIO_DISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),

Not required since no buffer/trigger support!



Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
