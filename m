Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41484 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbcHOP2F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 11:28:05 -0400
Subject: Re: [PATCH v4 1/4] iio: cros_ec_sensors_core: Add common functions
 for the ChromeOS EC Sensor Hub.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <1470045278-18161-1-git-send-email-enric.balletbo@collabora.com>
 <1470045278-18161-2-git-send-email-enric.balletbo@collabora.com>
Cc: Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <87db03db-2fa6-1b8c-08fd-57065ea0b1f0@kernel.org>
Date: Mon, 15 Aug 2016 16:28:02 +0100
MIME-Version: 1.0
In-Reply-To: <1470045278-18161-2-git-send-email-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/08/16 10:54, Enric Balletbo i Serra wrote:
> Add the core functions to be able to support the sensors attached behind
> the ChromeOS Embedded Controller and used by other IIO cros-ec sensor
> drivers.
> 
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
Reviewed-by: Jonathan Cameron <jic23@kernel.org>

Thanks,

Jonathan
> ---
> 
> Changes since v3:
>   - Convert structure to a simple array
>   - Remove PM declarations
>   - Remove unnecessary initializations
>   - cros_ec_sensors_cmd_read_u16: Conversion should only be done if ret >= 0
>   - Remove unnecessary else
> 
> Changes since v2:
>   - Rebased and fix build error.
>   - Include a list of possible values in the description of location attr.
>   - Fix some typos.
>   - Remove id sysfs entry.
> 
> Changes since v1:
>   - Check kernel-doc documentation.
>   - Bring this in as an when you need it in the rest of the series.
>   - Fix some spelling mistakes.
>   - Include ABI documentation.
>   - Be more careful with buffer sizes (sprintf -> snprintf)
>   - Add cros_ec_sensors prefix to all function.
>   - Check return values on some functions.
> 
>  Documentation/ABI/testing/sysfs-bus-iio-cros-ec    |  18 +
>  drivers/iio/common/Kconfig                         |   1 +
>  drivers/iio/common/Makefile                        |   1 +
>  drivers/iio/common/cros_ec_sensors/Kconfig         |  14 +
>  drivers/iio/common/cros_ec_sensors/Makefile        |   5 +
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 450 +++++++++++++++++++++
>  .../common/cros_ec_sensors/cros_ec_sensors_core.h  | 175 ++++++++
>  include/linux/mfd/cros_ec.h                        |   9 +
>  include/linux/mfd/cros_ec_commands.h               |  99 ++++-
>  9 files changed, 767 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-cros-ec
>  create mode 100644 drivers/iio/common/cros_ec_sensors/Kconfig
>  create mode 100644 drivers/iio/common/cros_ec_sensors/Makefile
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> new file mode 100644
> index 0000000..297b972
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> @@ -0,0 +1,18 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/calibrate
> +Date:		July 2015
> +KernelVersion:	4.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Writing '1' will perform a FOC (Fast Online Calibration). The
> +                corresponding calibration offsets can be read from *_calibbias
> +                entries.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/location
> +Date:		July 2015
> +KernelVersion:	4.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute returns a string with the physical location where
> +                the motion sensor is placed. For example, in a laptop a motion
> +                sensor can be located on the base or on the lid. Current valid
> +		values are 'base' and 'lid'.
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
> index 0000000..24743be
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
> +	  drivers.
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
> index 0000000..a3be799
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -0,0 +1,450 @@
> +/*
> + * cros_ec_sensors_core - Common function for Chrome OS EC sensor driver.
> + *
> + * Copyright (C) 2016 Google, Inc
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
> +
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
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
> +
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
> +
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
> +		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> +			st->calib[i] = st->resp->perform_calib.offset[i];
> +	}
> +	mutex_unlock(&st->cmd_lock);
> +
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t cros_ec_sensors_loc(struct iio_dev *indio_dev,
> +		uintptr_t private, const struct iio_chan_spec *chan,
> +		char *buf)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", cros_ec_loc[st->loc]);
> +}
> +
> +const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
> +	{
> +		.name = "calibrate",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.write = cros_ec_sensors_calibrate
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
> +/**
> + * cros_ec_sensors_idx_to_reg - convert index into offset in shared memory
> + * @st:		pointer to state information for device
> + * @idx:	sensor index (should be element of enum sensor_index)
> + *
> + * Return:	address to read at
> + */
> +static unsigned int cros_ec_sensors_idx_to_reg(
> +					struct cros_ec_sensors_core_state *st,
> +					unsigned int idx)
> +{
> +	/*
> +	 * When using LPC interface, only space for 2 Accel and one Gyro.
> +	 * First halfword of MOTIONSENSE_TYPE_ACCEL is used by angle.
> +	 */
> +	if (st->type == MOTIONSENSE_TYPE_ACCEL)
> +		return EC_MEMMAP_ACC_DATA + sizeof(u16) *
> +			(1 + idx + st->param.info.sensor_num *
> +			 CROS_EC_SENSOR_MAX_AXIS);
> +
> +	return EC_MEMMAP_GYRO_DATA + sizeof(u16) * idx;
> +}
> +
> +static int cros_ec_sensors_cmd_read_u8(struct cros_ec_device *ec,
> +				       unsigned int offset, u8 *dest)
> +{
> +	return ec->cmd_readmem(ec, offset, 1, dest);
> +}
> +
> +static int cros_ec_sensors_cmd_read_u16(struct cros_ec_device *ec,
> +					 unsigned int offset, u16 *dest)
> +{
> +	__le16 tmp;
> +	int ret = ec->cmd_readmem(ec, offset, 2, &tmp);
> +
> +	if (ret >= 0)
> +		*dest = le16_to_cpu(tmp);
> +
> +	return ret;
> +}
> +
> +/**
> + * cros_ec_sensors_read_until_not_busy() - read until is not busy
> + *
> + * @st:	pointer to state information for device
> + *
> + * Read from EC status byte until it reads not busy.
> + * Return: 8-bit status if ok, -errno on failure.
> + */
> +static int cros_ec_sensors_read_until_not_busy(
> +					struct cros_ec_sensors_core_state *st)
> +{
> +	struct cros_ec_device *ec = st->ec;
> +	u8 status;
> +	int ret, attempts = 0;
> +
> +	ret = cros_ec_sensors_cmd_read_u8(ec, EC_MEMMAP_ACC_STATUS, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	while (status & EC_MEMMAP_ACC_STATUS_BUSY_BIT) {
> +		/* Give up after enough attempts, return error. */
> +		if (attempts++ >= 50)
> +			return -EIO;
> +
> +		/* Small delay every so often. */
> +		if (attempts % 5 == 0)
> +			msleep(25);
> +
> +		ret = cros_ec_sensors_cmd_read_u8(ec, EC_MEMMAP_ACC_STATUS,
> +						  &status);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return status;
> +}
> +
> +/**
> + * read_ec_sensors_data_unsafe() - read acceleration data from EC shared memory
> + * @indio_dev:	pointer to IIO device
> + * @scan_mask:	bitmap of the sensor indices to scan
> + * @data:	location to store data
> + *
> + * This is the unsafe function for reading the EC data. It does not guarantee
> + * that the EC will not modify the data as it is being read in.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
> +			 unsigned long scan_mask, s16 *data)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	struct cros_ec_device *ec = st->ec;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Read all sensors enabled in scan_mask. Each value is 2 bytes. */
> +	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
> +		ret = cros_ec_sensors_cmd_read_u16(ec,
> +					     cros_ec_sensors_idx_to_reg(st, i),
> +					     data);
> +		if (ret < 0)
> +			return ret;
> +
> +		data++;
> +	}
> +
> +	return 0;
> +}
> +
> +int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
> +			     unsigned long scan_mask, s16 *data)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	struct cros_ec_device *ec = st->ec;
> +	u8 samp_id = 0xff, status = 0;
> +	int ret, attempts = 0;
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
> +		status = cros_ec_sensors_read_until_not_busy(st);
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
> +		ret = cros_ec_sensors_read_data_unsafe(indio_dev, scan_mask,
> +						       data);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Read status byte. */
> +		ret = cros_ec_sensors_cmd_read_u8(ec, EC_MEMMAP_ACC_STATUS,
> +						  &status);
> +		if (ret < 0)
> +			return ret;
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
> +	unsigned int i;
> +
> +	/* Read all sensor data through a command. */
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
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_read_cmd);
> +
> +irqreturn_t cros_ec_sensors_capture(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->cmd_lock);
> +
> +	/* Clear capture data. */
> +	memset(st->samples, 0, indio_dev->scan_bytes);
> +
> +	/* Read data based on which channels are enabled in scan mask. */
> +	ret = st->read_ec_sensors_data(indio_dev,
> +				       *(indio_dev->active_scan_mask),
> +				       (s16 *)st->samples);
> +	if (ret < 0)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
> +					   iio_get_time_ns(indio_dev));
> +
> +done:
> +	/*
> +	 * Tell the core we are done with this trigger and ready for the
> +	 * next one.
> +	 */
> +	iio_trigger_notify_done(indio_dev->trig);
> +
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
> +
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
> +MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> new file mode 100644
> index 0000000..8bc2ca3
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> @@ -0,0 +1,175 @@
> +/*
> + * ChromeOS EC sensor hub
> + *
> + * Copyright (C) 2016 Google, Inc
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
> +	CROS_EC_SENSOR_X,
> +	CROS_EC_SENSOR_Y,
> +	CROS_EC_SENSOR_Z,
> +	CROS_EC_SENSOR_MAX_AXIS,
> +};
> +
> +/* EC returns sensor values using signed 16 bit registers */
> +#define CROS_EC_SENSOR_BITS 16
> +
> +/*
> + * 4 16 bit channels are allowed.
> + * Good enough for current sensors, they use up to 3 16 bit vectors.
> + */
> +#define CROS_EC_SAMPLE_SIZE  (sizeof(s64) * 2)
> +
> +/* Minimum sampling period to use when device is suspending */
> +#define CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY 1000  /* 1 second */
> +
> +/**
> + * struct cros_ec_sensors_core_state - state data for EC sensors IIO driver
> + * @ec:				cros EC device structure
> + * @cmd_lock:			lock used to prevent simultaneous access to the
> + *				commands.
> + * @msg:			cros EC command structure
> + * @param:			motion sensor parameters structure
> + * @resp:			motion sensor response structure
> + * @type:			type of motion sensor
> + * @loc:			location where the motion sensor is placed
> + * @calib:			calibration parameters. Note that trigger
> + *				captured data will always provide the calibrated
> + *				data
> + * @samples:			static array to hold data from a single capture.
> + *				For each channel we need 2 bytes, except for
> + *				the timestamp. The timestamp is always last and
> + *				is always 8-byte aligned.
> + * @read_ec_sensors_data:	function used for accessing sensors values
> + * @cuur_sampl_freq:		current sampling period
> + */
> +struct cros_ec_sensors_core_state {
> +	struct cros_ec_device *ec;
> +	struct mutex cmd_lock;
> +
> +	struct cros_ec_command *msg;
> +	struct ec_params_motion_sense param;
> +	struct ec_response_motion_sense *resp;
> +
> +	enum motionsensor_type type;
> +	enum motionsensor_location loc;
> +
> +	s16 calib[CROS_EC_SENSOR_MAX_AXIS];
> +
> +	u8 samples[CROS_EC_SAMPLE_SIZE];
> +
> +	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
> +				    unsigned long scan_mask, s16 *data);
> +
> +	int curr_sampl_freq;
> +};
> +
> +/**
> + * cros_ec_sensors_read_lpc() - retrieve data from EC shared memory
> + * @indio_dev:	pointer to IIO device
> + * @scan_mask:	bitmap of the sensor indices to scan
> + * @data:	location to store data
> + *
> + * This is the safe function for reading the EC data. It guarantees that the
> + * data sampled was not modified by the EC while being read.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev, unsigned long scan_mask,
> +			     s16 *data);
> +
> +/**
> + * cros_ec_sensors_read_cmd() - retrieve data using the EC command protocol
> + * @indio_dev:	pointer to IIO device
> + * @scan_mask:	bitmap of the sensor indices to scan
> + * @data:	location to store data
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev, unsigned long scan_mask,
> +			     s16 *data);
> +
> +/**
> + * cros_ec_sensors_core_init() - basic initialization of the core structure
> + * @pdev:		platform device created for the sensors
> + * @indio_dev:		iio device structure of the device
> + * @physical_device:	true if the device refers to a physical device
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int cros_ec_sensors_core_init(struct platform_device *pdev,
> +			      struct iio_dev *indio_dev, bool physical_device);
> +
> +/**
> + * cros_ec_sensors_capture() - the trigger handler function
> + * @irq:	the interrupt number.
> + * @p:		a pointer to the poll function.
> + *
> + * On a trigger event occurring, if the pollfunc is attached then this
> + * handler is called as a threaded interrupt (and hence may sleep). It
> + * is responsible for grabbing data from the device and pushing it into
> + * the associated buffer.
> + *
> + * Return: IRQ_HANDLED
> + */
> +irqreturn_t cros_ec_sensors_capture(int irq, void *p);
> +
> +/**
> + * cros_ec_motion_send_host_cmd() - send motion sense host command
> + * @st:		pointer to state information for device
> + * @opt_length:	optional length to reduce the response size, useful on the data
> + *		path. Otherwise, the maximal allowed response size is used
> + *
> + * When called, the sub-command is assumed to be set in param->cmd.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *st,
> +				 u16 opt_length);
> +
> +/**
> + * cros_ec_sensors_core_read() - function to request a value from the sensor
> + * @st:		pointer to state information for device
> + * @chan:	channel specification structure table
> + * @val:	will contain one element making up the returned value
> + * @val2:	will contain another element making up the returned value
> + * @mask:	specifies which values to be requested
> + *
> + * Return:	the type of value returned by the device
> + */
> +int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask);
> +
> +/**
> + * cros_ec_sensors_core_write() - function to write a value to the sensor
> + * @st:		pointer to state information for device
> + * @chan:	channel specification structure table
> + * @val:	first part of value to write
> + * @val2:	second part of value to write
> + * @mask:	specifies which values to write
> + *
> + * Return:	the type of value returned by the device
> + */
> +int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
> +			       struct iio_chan_spec const *chan,
> +			       int val, int val2, long mask);
> +
> +/* List of extended channel specification for all sensors */
> +extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
> +
> +#endif  /* __CROS_EC_SENSORS_CORE_H */
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index d6539c1..7769ea6 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -151,6 +151,15 @@ struct cros_ec_device {
>  	int event_size;
>  };
>  
> +/**
> + * struct cros_ec_sensor_platform - ChromeOS EC sensor platform information
> + *
> + * @sensor_num: Id of the sensor, as reported by the EC.
> + */
> +struct cros_ec_sensor_platform {
> +	u8 sensor_num;
> +};
> +
>  /* struct cros_ec_platform - ChromeOS EC platform information
>   *
>   * @ec_name: name of EC device (e.g. 'cros-ec', 'cros-pd', ...)
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 76728ff..8826e0f 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -1315,6 +1315,24 @@ enum motionsense_command {
>  	 */
>  	MOTIONSENSE_CMD_KB_WAKE_ANGLE = 5,
>  
> +	/*
> +	 * Returns a single sensor data.
> +	 */
> +	MOTIONSENSE_CMD_DATA = 6,
> +
> +	/*
> +	 * Perform low level calibration.. On sensors that support it, ask to
> +	 * do offset calibration.
> +	 */
> +	MOTIONSENSE_CMD_PERFORM_CALIB = 10,
> +
> +	/*
> +	 * Sensor Offset command is a setter/getter command for the offset used
> +	 * for calibration. The offsets can be calculated by the host, or via
> +	 * PERFORM_CALIB command.
> +	 */
> +	MOTIONSENSE_CMD_SENSOR_OFFSET = 11,
> +
>  	/* Number of motionsense sub-commands. */
>  	MOTIONSENSE_NUM_CMDS
>  };
> @@ -1335,12 +1353,18 @@ enum motionsensor_id {
>  enum motionsensor_type {
>  	MOTIONSENSE_TYPE_ACCEL = 0,
>  	MOTIONSENSE_TYPE_GYRO = 1,
> +	MOTIONSENSE_TYPE_MAG = 2,
> +	MOTIONSENSE_TYPE_PROX = 3,
> +	MOTIONSENSE_TYPE_LIGHT = 4,
> +	MOTIONSENSE_TYPE_ACTIVITY = 5,
> +	MOTIONSENSE_TYPE_MAX
>  };
>  
>  /* List of motion sensor locations. */
>  enum motionsensor_location {
>  	MOTIONSENSE_LOC_BASE = 0,
>  	MOTIONSENSE_LOC_LID = 1,
> +	MOTIONSENSE_LOC_MAX,
>  };
>  
>  /* List of motion sensor chips. */
> @@ -1361,6 +1385,31 @@ enum motionsensor_chip {
>   */
>  #define EC_MOTION_SENSE_NO_VALUE -1
>  
> +#define EC_MOTION_SENSE_INVALID_CALIB_TEMP 0x8000
> +
> +/* Set Calibration information */
> +#define MOTION_SENSE_SET_OFFSET	1
> +
> +struct ec_response_motion_sensor_data {
> +	/* Flags for each sensor. */
> +	uint8_t flags;
> +	/* Sensor number the data comes from */
> +	uint8_t sensor_num;
> +	/* Each sensor is up to 3-axis. */
> +	union {
> +		int16_t             data[3];
> +		struct {
> +			uint16_t    rsvd;
> +			uint32_t    timestamp;
> +		} __packed;
> +		struct {
> +			uint8_t     activity; /* motionsensor_activity */
> +			uint8_t     state;
> +			int16_t     add_info[2];
> +		};
> +	};
> +} __packed;
> +
>  struct ec_params_motion_sense {
>  	uint8_t cmd;
>  	union {
> @@ -1378,9 +1427,37 @@ struct ec_params_motion_sense {
>  			int16_t data;
>  		} ec_rate, kb_wake_angle;
>  
> +		/* Used for MOTIONSENSE_CMD_SENSOR_OFFSET */
> +		struct {
> +			uint8_t sensor_num;
> +
> +			/*
> +			 * bit 0: If set (MOTION_SENSE_SET_OFFSET), set
> +			 * the calibration information in the EC.
> +			 * If unset, just retrieve calibration information.
> +			 */
> +			uint16_t flags;
> +
> +			/*
> +			 * Temperature at calibration, in units of 0.01 C
> +			 * 0x8000: invalid / unknown.
> +			 * 0x0: 0C
> +			 * 0x7fff: +327.67C
> +			 */
> +			int16_t temp;
> +
> +			/*
> +			 * Offset for calibration.
> +			 * Unit:
> +			 * Accelerometer: 1/1024 g
> +			 * Gyro:          1/1024 deg/s
> +			 * Compass:       1/16 uT
> +			 */
> +			int16_t offset[3];
> +		} __packed sensor_offset;
> +
>  		/* Used for MOTIONSENSE_CMD_INFO. */
>  		struct {
> -			/* Should be element of enum motionsensor_id. */
>  			uint8_t sensor_num;
>  		} info;
>  
> @@ -1410,11 +1487,14 @@ struct ec_response_motion_sense {
>  			/* Flags representing the motion sensor module. */
>  			uint8_t module_flags;
>  
> -			/* Flags for each sensor in enum motionsensor_id. */
> -			uint8_t sensor_flags[EC_MOTION_SENSOR_COUNT];
> +			/* Number of sensors managed directly by the EC. */
> +			uint8_t sensor_count;
>  
> -			/* Array of all sensor data. Each sensor is 3-axis. */
> -			int16_t data[3*EC_MOTION_SENSOR_COUNT];
> +			/*
> +			 * Sensor data is truncated if response_max is too small
> +			 * for holding all the data.
> +			 */
> +			struct ec_response_motion_sensor_data sensor[0];
>  		} dump;
>  
>  		/* Used for MOTIONSENSE_CMD_INFO. */
> @@ -1429,6 +1509,9 @@ struct ec_response_motion_sense {
>  			uint8_t chip;
>  		} info;
>  
> +		/* Used for MOTIONSENSE_CMD_DATA */
> +		struct ec_response_motion_sensor_data data;
> +
>  		/*
>  		 * Used for MOTIONSENSE_CMD_EC_RATE, MOTIONSENSE_CMD_SENSOR_ODR,
>  		 * MOTIONSENSE_CMD_SENSOR_RANGE, and
> @@ -1438,6 +1521,12 @@ struct ec_response_motion_sense {
>  			/* Current value of the parameter queried. */
>  			int32_t ret;
>  		} ec_rate, sensor_odr, sensor_range, kb_wake_angle;
> +
> +		/* Used for MOTIONSENSE_CMD_SENSOR_OFFSET */
> +		struct {
> +			int16_t temp;
> +			int16_t offset[3];
> +		} sensor_offset, perform_calib;
>  	};
>  } __packed;
>  
> 

