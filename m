Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 18 Jul 2016 09:29:37 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
    Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
    Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>, Guenter Roeck <groeck@chromium.org>,
    Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH 04/10] iio: cros_ec: Add common functions for cros_ec
 sensors.
In-Reply-To: <1468825370-20075-5-git-send-email-enric.balletbo@collabora.com>
Message-ID: <alpine.DEB.2.02.1607180908300.9730@pmeerw.net>
References: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com> <1468825370-20075-5-git-send-email-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Add the core functions to be able to support the sensors attached behind
> the ChromeOS Embedded Controller and used by other IIO cros-ec sensor
> drivers.

comments below from a quick read
there is plenty on undocumented private API
 
> The cros_ec_sensor_core driver matches with current driver in ChromeOS
> 4.4 tree, so it includes all the fixes at the moment. The support for
> this driver was made by Gwendal Grignou. The original patch and all the
> fixes has been squashed and rebased on top of mainline.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> [eballetbo: split, squash and rebase on top of mainline the patches
> found in ChromeOS tree]
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/iio/common/Kconfig                         |   1 +
>  drivers/iio/common/Makefile                        |   1 +
>  drivers/iio/common/cros_ec_sensors/Kconfig         |  14 +
>  drivers/iio/common/cros_ec_sensors/Makefile        |   5 +
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 564 +++++++++++++++++++++
>  .../common/cros_ec_sensors/cros_ec_sensors_core.h  | 155 ++++++
>  6 files changed, 740 insertions(+)
>  create mode 100644 drivers/iio/common/cros_ec_sensors/Kconfig
>  create mode 100644 drivers/iio/common/cros_ec_sensors/Makefile
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> 
> diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
> index 26a6026..e108996 100644
> --- a/drivers/iio/common/Kconfig
> +++ b/drivers/iio/common/Kconfig
> @@ -2,6 +2,7 @@
>  # IIO common modules
>  #
>  
> +source "drivers/iio/common/cros_ec_sensors/Kconfig"
>  source "drivers/iio/common/hid-sensors/Kconfig"
>  source "drivers/iio/common/ms_sensors/Kconfig"
>  source "drivers/iio/common/ssp_sensors/Kconfig"
> diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
> index 585da6a..6fa760e 100644
> --- a/drivers/iio/common/Makefile
> +++ b/drivers/iio/common/Makefile
> @@ -7,6 +7,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-y += cros_ec_sensors/
>  obj-y += hid-sensors/
>  obj-y += ms_sensors/
>  obj-y += ssp_sensors/
> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> new file mode 100644
> index 0000000..a30f41e
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> @@ -0,0 +1,14 @@
> +#
> +# Chrome OS Embedded Controller managed sensors library
> +#
> +config IIO_CROS_EC_SENSORS_CORE
> +	tristate "ChromeOS EC Sensors Core"
> +	depends on SYSFS && MFD_CROS_EC
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Base module for the ChromeOS EC Sensors module.
> +	  Contains core functions used by other IIO CrosEC sensor
> +	  driver.

'drivers' probably

> +	  Define common attributes and sysfs interrupt handler.
> +
> diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
> new file mode 100644
> index 0000000..95b6901
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for sensors seen through the ChromeOS EC sensor hub.
> +#
> +
> +obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> new file mode 100644
> index 0000000..cb3de8f
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -0,0 +1,564 @@
> +/*
> + * cros_ec_sensors_core - Common function for Chrome OS EC sensor driver.
> + *
> + * Copyright (C) 2015 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * This driver uses the cros-ec interface to communicate with the Chrome OS
> + * EC about accelerometer data. Accelerometer access is presented through
> + * iio sysfs.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/platform_device.h>
> +
> +#include "cros_ec_sensors_core.h"
> +
> +static char *cros_ec_loc[] = {
> +	[MOTIONSENSE_LOC_BASE] = "base",
> +	[MOTIONSENSE_LOC_LID] = "lid",
> +	[MOTIONSENSE_LOC_MAX] = "unknown",
> +};
> +
> +/*
> + * cros_ec_sensors_core_init
> + *
> + * Initialize core sensor strucure, fill the response are
> + * with the return of Sensor info.

rephrase please

> + *
> + * @pdev plarform device created for the sensors

platform

> + * @indio_dev iio device structure of the device
> + * @physical_device True if the device refers to a physical device.
> + */
> +int cros_ec_sensors_core_init(struct platform_device *pdev,
> +			      struct iio_dev *indio_dev,
> +			      bool physical_device)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> +	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
> +	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	state->ec = ec->ec_dev;
> +	state->msg = devm_kzalloc(&pdev->dev,
> +				max((u16)sizeof(struct ec_params_motion_sense),
> +				state->ec->max_response), GFP_KERNEL);
> +	if (!state->msg)
> +		return -ENOMEM;
> +
> +	state->resp = (struct ec_response_motion_sense *)state->msg->data;
> +
> +	mutex_init(&state->cmd_lock);
> +	/* Set up the host command structure. */
> +	state->msg->version = 2;
> +	state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> +	state->msg->outsize = sizeof(struct ec_params_motion_sense);
> +
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->name = pdev->name;
> +
> +	if (physical_device) {
> +		indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +		state->param.cmd = MOTIONSENSE_CMD_INFO;
> +		state->param.info.sensor_num = sensor_platform->sensor_num;
> +		if (cros_ec_motion_send_host_cmd(state, 0)) {
> +			dev_warn(dev, "Can not access sensor info\n");
> +			return -EIO;
> +		}
> +		state->type = state->resp->info.type;
> +		state->loc = state->resp->info.location;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
> +
> +/*
> + * cros_ec_motion_send_host_cmd - send motion sense host command
> + *
> + * @st Pointer to state information for device.

@state
opt_length is not documented

> + * @return 0 if ok, -ve on error.

what is -ve?

> + *
> + * Note, when called, the sub-command is assumed to be set in param->cmd.
> + */
> +int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
> +				 u16 opt_length)
> +{
> +	int ret;
> +
> +	if (opt_length)
> +		state->msg->insize = min(opt_length, state->ec->max_response);
> +	else
> +		state->msg->insize = state->ec->max_response;
> +
> +	memcpy(state->msg->data, &state->param, sizeof(state->param));
> +	/* Send host command. */

comment needed?

> +	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> +	if (ret < 0)
> +		return -EIO;
> +
> +	if (ret &&
> +	    state->resp != (struct ec_response_motion_sense *)state->msg->data)
> +		memcpy(state->resp, state->msg->data, ret);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_motion_send_host_cmd);
> +
> +static ssize_t __maybe_unused cros_ec_sensors_flush(struct iio_dev *indio_dev,
> +		uintptr_t private, const struct iio_chan_spec *chan,
> +		const char *buf, size_t len)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret = 0;

initialization not needed

> +	bool flush;
> +
> +	ret = strtobool(buf, &flush);
> +	if (ret < 0)
> +		return ret;
> +	if (!flush)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
> +	ret = cros_ec_motion_send_host_cmd(st, 0);
> +	if (ret != 0)
> +		dev_warn(&indio_dev->dev, "Unable to flush sensor\n");
> +	mutex_unlock(&st->cmd_lock);
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
> +		uintptr_t private, const struct iio_chan_spec *chan,
> +		const char *buf, size_t len)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret, i;
> +	bool calibrate;
> +
> +	ret = strtobool(buf, &calibrate);
> +	if (ret < 0)
> +		return ret;
> +	if (!calibrate)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd = MOTIONSENSE_CMD_PERFORM_CALIB;
> +	ret = cros_ec_motion_send_host_cmd(st, 0);
> +	if (ret != 0) {
> +		dev_warn(&indio_dev->dev, "Unable to calibrate sensor\n");
> +	} else {
> +		/* Save values */
> +		for (i = X; i < MAX_AXIS; i++)

what is X here?

> +			st->calib[i].offset = st->resp->perform_calib.offset[i];
> +	}
> +	mutex_unlock(&st->cmd_lock);
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t cros_ec_sensors_id(struct iio_dev *indio_dev,
> +		uintptr_t private, const struct iio_chan_spec *chan,
> +		char *buf)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->param.info.sensor_num);

can't we be a bit more careful with buffer sizes here (and below)?

> +}
> +
> +static ssize_t cros_ec_sensors_loc(struct iio_dev *indio_dev,
> +		uintptr_t private, const struct iio_chan_spec *chan,
> +		char *buf)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%s\n", cros_ec_loc[st->loc]);
> +}
> +
> +const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
> +#ifdef CONFIG_IIO_CROS_EC_SENSORS_RING
> +	{
> +		.name = "flush",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.write = cros_ec_sensors_flush
> +	},
> +#endif
> +	{
> +		.name = "calibrate",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.write = cros_ec_sensors_calibrate
> +	},
> +	{
> +		.name = "id",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = cros_ec_sensors_id
> +	},
> +	{
> +		.name = "location",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = cros_ec_sensors_loc
> +	},
> +	{ },
> +};
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
> +
> +const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[] = {
> +	{
> +		.name = "id",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = cros_ec_sensors_id
> +	},
> +	{
> +		.name = "location",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = cros_ec_sensors_loc
> +	},
> +	{ },
> +};
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_limited_info);
> +/*
> + * idx_to_reg - convert sensor index into offset in shared memory region.
> + *
> + * @st: private data
> + * @idx: sensor index (should be element of enum sensor_index)
> + * @return address to read at.
> + */
> +static unsigned int idx_to_reg(struct cros_ec_sensors_core_state *st,

cros_ec_ prefix please (here and below)

> +			       unsigned int idx)
> +{
> +	/*
> +	 * When using LPC interface, only space for 2 Accel and one Gyro.
> +	 * First halfword of MOTIONSENSE_TYPE_ACCEL is used by angle.
> +	 */
> +	if (st->type == MOTIONSENSE_TYPE_ACCEL)
> +		return EC_MEMMAP_ACC_DATA + sizeof(u16) *
> +			(1 + idx + st->param.info.sensor_num *
> +			 MAX_AXIS);
> +	else
> +		return EC_MEMMAP_GYRO_DATA + sizeof(u16) * idx;
> +}
> +
> +static int ec_cmd_read_u8(struct cros_ec_device *ec, unsigned int offset,
> +			  u8 *dest)
> +{
> +	return ec->cmd_readmem(ec, offset, 1, dest);
> +}
> +
> +static int ec_cmd_read_u16(struct cros_ec_device *ec, unsigned int offset,
> +			   u16 *dest)
> +{
> +	u16 tmp;
> +	int ret = ec->cmd_readmem(ec, offset, 2, &tmp);
> +
> +	*dest = le16_to_cpu(tmp);
> +
> +	return ret;
> +}
> +
> +/*
> + * read_ec_until_not_busy - read from EC status byte until it reads not busy.
> + *
> + * @st Pointer to state information for device.
> + * @return 8-bit status if ok, -ve on error
> + */
> +static int read_ec_until_not_busy(struct cros_ec_sensors_core_state *st)
> +{
> +	struct cros_ec_device *ec = st->ec;
> +	u8 status;
> +	int attempts = 0;
> +
> +	ec_cmd_read_u8(ec, EC_MEMMAP_ACC_STATUS, &status);

check return value (here and below)?

> +	while (status & EC_MEMMAP_ACC_STATUS_BUSY_BIT) {
> +		/* Give up after enough attempts, return error. */
> +		if (attempts++ >= 50)
> +			return -EIO;
> +
> +		/* Small delay every so often. */
> +		if (attempts % 5 == 0)
> +			msleep(25);
> +
> +		ec_cmd_read_u8(ec, EC_MEMMAP_ACC_STATUS, &status);
> +	}
> +
> +	return status;
> +}
> +
> +/*
> + * read_ec_sensors_data_unsafe - read acceleration data from EC shared memory.
> + *
> + * @st Pointer to state information for device.

@indio_dev? here and below

> + * @scan_mask Bitmap of the sensor indices to scan.
> + * @data Location to store data.
> + *
> + * Note this is the unsafe function for reading the EC data. It does not
> + * guarantee that the EC will not modify the data as it is being read in.
> + */
> +static void read_ec_sensors_data_unsafe(struct iio_dev *indio_dev,
> +			 unsigned long scan_mask, s16 *data)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	struct cros_ec_device *ec = st->ec;
> +	unsigned int i = 0;

init not needed

> +
> +	/*
> +	 * Read all sensors enabled in scan_mask. Each value is 2
> +	 * bytes.
> +	 */
> +	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
> +		ec_cmd_read_u16(ec, idx_to_reg(st, i), data);

no return value?

> +		data++;
> +	}
> +}
> +
> +/*
> + * cros_ec_sensors_read_lpc - read acceleration data from EC shared memory.
> + *
> + * @st Pointer to state information for device.
> + * @scan_mask Bitmap of the sensor indices to scan.
> + * @data Location to store data.
> + * @return 0 if ok, -ve on error
> + *
> + * Note: this is the safe function for reading the EC data. It guarantees
> + * that the data sampled was not modified by the EC while being read.
> + */
> +int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
> +			     unsigned long scan_mask, s16 *data)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	struct cros_ec_device *ec = st->ec;
> +	u8 samp_id = 0xff, status = 0;
> +	int attempts = 0;
> +
> +	/*
> +	 * Continually read all data from EC until the status byte after
> +	 * all reads reflects that the EC is not busy and the sample id
> +	 * matches the sample id from before all reads. This guarantees
> +	 * that data read in was not modified by the EC while reading.
> +	 */
> +	while ((status & (EC_MEMMAP_ACC_STATUS_BUSY_BIT |
> +			  EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK)) != samp_id) {
> +		/* If we have tried to read too many times, return error. */
> +		if (attempts++ >= 5)
> +			return -EIO;
> +
> +		/* Read status byte until EC is not busy. */
> +		status = read_ec_until_not_busy(st);
> +		if (status < 0)
> +			return status;
> +
> +		/*
> +		 * Store the current sample id so that we can compare to the
> +		 * sample id after reading the data.
> +		 */
> +		samp_id = status & EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK;
> +
> +		/* Read all EC data, format it, and store it into data. */
> +		read_ec_sensors_data_unsafe(indio_dev, scan_mask, data);
> +
> +		/* Read status byte. */
> +		ec_cmd_read_u8(ec, EC_MEMMAP_ACC_STATUS, &status);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_read_lpc);
> +
> +int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
> +			     unsigned long scan_mask, s16 *data)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int i = 0;
> +
> +	/*
> +	 * read all sensor data through a command.

start with uppercase as everywhere else

> +	 */
> +	st->param.cmd = MOTIONSENSE_CMD_DATA;
> +	ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->data));
> +	if (ret != 0) {
> +		dev_warn(&indio_dev->dev, "Unable to read sensor data\n");
> +		return ret;
> +	}
> +
> +	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
> +		*data = st->resp->data.data[i];
> +		data++;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_read_cmd);
> +
> +irqreturn_t cros_ec_sensors_capture(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +
> +	mutex_lock(&st->cmd_lock);
> +	/* Clear capture data. */
> +	memset(st->samples, 0, indio_dev->scan_bytes);
> +
> +	/* Read data based on which channels are enabled in scan mask. */
> +	st->read_ec_sensors_data(indio_dev, *(indio_dev->active_scan_mask),
> +			   (s16 *)st->samples);

no return value?

> +
> +	/* Store the timestamp last 8 bytes of data. */
> +	if (indio_dev->scan_timestamp)
> +		*(s64 *)&st->samples[round_down(indio_dev->scan_bytes -
> +						sizeof(s64),
> +				     sizeof(s64))] = iio_get_time_ns();
> +
> +	iio_push_to_buffers(indio_dev, st->samples);

use iio_push_to_buffers_with_timestamp()

> +
> +	/*
> +	 * Tell the core we are done with this trigger and ready for the
> +	 * next one.
> +	 */
> +	iio_trigger_notify_done(indio_dev->trig);
> +	mutex_unlock(&st->cmd_lock);
> +
> +	return IRQ_HANDLED;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
> +
> +int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	int ret = IIO_VAL_INT;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +		st->param.ec_rate.data =
> +			EC_MOTION_SENSE_NO_VALUE;
> +
> +		if (cros_ec_motion_send_host_cmd(st, 0))
> +			ret = -EIO;
> +		else
> +			*val = st->resp->ec_rate.ret;
> +		break;
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
> +		st->param.sensor_odr.data =
> +			EC_MOTION_SENSE_NO_VALUE;
> +
> +		if (cros_ec_motion_send_host_cmd(st, 0))
> +			ret = -EIO;
> +		else
> +			*val = st->resp->sensor_odr.ret;
> +		break;
> +	default:
> +		break;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read);
> +
> +int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
> +			       struct iio_chan_spec const *chan,
> +			       int val, int val2, long mask)
> +{
> +	int ret = 0;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
> +		st->param.sensor_odr.data = val;
> +
> +		/* Always roundup, so caller gets at least what it asks for. */
> +		st->param.sensor_odr.roundup = 1;
> +
> +		if (cros_ec_motion_send_host_cmd(st, 0))
> +			ret = -EIO;
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +		st->param.ec_rate.data = val;
> +
> +		if (cros_ec_motion_send_host_cmd(st, 0))
> +			ret = -EIO;
> +		else
> +			st->curr_sampl_freq = val;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
> +
> +static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +
> +	if (st->curr_sampl_freq == 0)
> +		return 0;
> +
> +	/*
> +	 * If the sensors are sampled at high frequency, we will not be able to
> +	 * sleep. Set to sampling to a long period if necessary.
> +	 */
> +	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
> +		mutex_lock(&st->cmd_lock);
> +		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +		st->param.ec_rate.data = CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY;
> +		cros_ec_motion_send_host_cmd(st, 0);
> +		mutex_unlock(&st->cmd_lock);
> +	}
> +	return 0;
> +}
> +
> +static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +
> +	if (st->curr_sampl_freq == 0)
> +		return;
> +
> +	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
> +		mutex_lock(&st->cmd_lock);
> +		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +		st->param.ec_rate.data = st->curr_sampl_freq;
> +		cros_ec_motion_send_host_cmd(st, 0);
> +		mutex_unlock(&st->cmd_lock);
> +	}
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +const struct dev_pm_ops cros_ec_sensors_pm_ops = {
> +	.prepare = cros_ec_sensors_prepare,
> +	.complete = cros_ec_sensors_complete
> +};
> +#else
> +const struct dev_pm_ops cros_ec_sensors_pm_ops = { };
> +#endif
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
> +
> +MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> new file mode 100644
> index 0000000..53e09e1
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> @@ -0,0 +1,155 @@
> +/*
> + * ChromeOS EC sensor hub
> + *
> + * Copyright (C) 2015 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __CROS_EC_SENSORS_CORE_H
> +#define __CROS_EC_SENSORS_CORE_H
> +
> +#include <linux/irqreturn.h>
> +
> +enum {
> +	X,

such short #defines scare me :)

> +	Y,
> +	Z,
> +	MAX_AXIS,
> +};
> +
> +/*
> + * EC returns sensor values using signed 16 bit registers
> + */
> +#define CROS_EC_SENSOR_BITS 16
> +
> +/*
> + * 4 16 bit channels are allowed.
> + * Good enough for current sensors, thye use up to 3 16 bit vectors.

they

> + */
> +#define CROS_EC_SAMPLE_SIZE  (sizeof(s64) * 2)
> +
> +/*
> + * minimum sampling period to use when device is suspending.

Minimum (uppercase)

> + */
> +#define CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY 1000  /* 1 second */
> +
> +/*
> + * Function to read the sensor data.
> + *
> + * Data can be retrieve using the cros ec command protocol.
> + * Some machines also allow accessing some sensor data via
> + * IO space.
> + */
> +typedef int (cros_ec_sensors_read_t)(struct iio_dev *indio_dev,
> +		unsigned long scan_mask, s16 *data);
> +
> +cros_ec_sensors_read_t cros_ec_sensors_read_lpc;
> +cros_ec_sensors_read_t cros_ec_sensors_read_cmd;
> +
> +/* State data for ec_sensors iio driver. */
> +struct cros_ec_sensors_core_state {
> +	struct cros_ec_device *ec;
> +	/*
> +	 *  Location to store command and response to the EC.
> +	 */
> +	struct mutex cmd_lock;
> +
> +	/*
> +	 * Statically allocated command structure that holds parameters
> +	 * and response.
> +	 */
> +	struct cros_ec_command *msg;
> +	struct ec_params_motion_sense param;
> +	struct ec_response_motion_sense *resp;
> +
> +	/* Type of sensor */
> +	enum motionsensor_type type;
> +	enum motionsensor_location loc;
> +
> +	/*
> +	 * Calibration parameters. Note that trigger captured data will always
> +	 * provide the calibrated values.
> +	 */
> +	struct calib_data {
> +		s16 offset;
> +	} calib[MAX_AXIS];
> +
> +	/*
> +	 * Static array to hold data from a single capture. For each
> +	 * channel we need 2 bytes, except for the timestamp. The timestamp
> +	 * is always last and is always 8-byte aligned.
> +	 */
> +	u8 samples[CROS_EC_SAMPLE_SIZE];
> +
> +	/* Pointer to function used for accessing sensors values. */
> +	cros_ec_sensors_read_t *read_ec_sensors_data;
> +
> +	/* Current sampling period */
> +	int curr_sampl_freq;
> +};
> +
> +/* Basic initialization of the core structure. */
> +int cros_ec_sensors_core_init(struct platform_device *pdev,
> +			      struct iio_dev *indio_dev,
> +			      bool physical_device);
> +
> +/*
> + * cros_ec_sensors_capture - the trigger handler function
> + *
> + * @irq: the interrupt number
> + * @p: private data - always a pointer to the poll func.
> + *
> + * On a trigger event occurring, if the pollfunc is attached then this
> + * handler is called as a threaded interrupt (and hence may sleep). It
> + * is responsible for grabbing data from the device and pushing it into
> + * the associated buffer.
> + */
> +irqreturn_t cros_ec_sensors_capture(int irq, void *p);
> +
> +
> +/*
> + * cros_ec_motion_send_host_cmd - send motion sense host command
> + *
> + * @st Pointer to state information for device.
> + * @opt_length: optional length: to reduce the response size,
> + *    useful on the data path.
> + *    Otherwise, the maximal allowed response size is used.
> + * @return 0 if ok, -ve on error.
> + *
> + * Note, when called, the sub-command is assumed to be set in param->cmd.
> + */
> +int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *st,
> +				 u16 opt_length);
> +
> +/*
> + * cros_ec_sensors_core_read/write: handler for core attributes.
> + *
> + * Handler for attributes identical among sensors:
> + * - frequency,
> + * - sampling_frequency.
> + *
> + * cmd_lock lock must be held.
> + */
> +int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask);
> +
> +int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
> +			       struct iio_chan_spec const *chan,
> +			       int val, int val2, long mask);
> +
> +extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
> +
> +/* List of extended channel specification for all sensors */
> +extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
> +extern const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[];
> +
> +#endif  /* __CROS_EC_SENSORS_CORE_H */
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
