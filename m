Return-Path: <jkosina@suse.cz>
Date: Wed, 5 Sep 2012 11:40:21 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 4/9] HID-Sensors: Sensor framework
In-Reply-To: <1346082597-768-5-git-send-email-srinivas.pandruvada@intel.com>
Message-ID: <alpine.LNX.2.00.1209051126400.11079@pobox.suse.cz>
References: <1346082597-768-1-git-send-email-srinivas.pandruvada@intel.com> <1346082597-768-5-git-send-email-srinivas.pandruvada@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Mon, 27 Aug 2012, srinivas pandruvada wrote:

> Adding processing for HID Sensor usage table as defined by HID 1.12, 
> Request #: HUTRR39, dated 05 May, 2011. This driver uses HID driver 
> framework to register, send and receive events. This uses MFD framework, 
> so that actual processing for a specific usage id can be done in a 
> different driver. For example an accelerometer driver can be a separate 
> driver and use the interface provided by this driver to register for 
> events.

Also, please change the summary/subject line of this commit to

	HID: sensors: introduce sensor framework

> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
> ---
>  drivers/hid/Kconfig            |   14 +
>  drivers/hid/Makefile           |    1 +
>  drivers/hid/hid-sensor-hub.c   |  682 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/hid-sensor-hub.h |  160 ++++++++++
>  include/linux/hid-sensor-ids.h |  111 +++++++
>  5 files changed, 968 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hid/hid-sensor-hub.c
>  create mode 100644 include/linux/hid-sensor-hub.h
>  create mode 100644 include/linux/hid-sensor-ids.h
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 034c80a..3138c26 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -660,6 +660,20 @@ config HID_ZYDACRON
>  	---help---
>  	Support for Zydacron remote control.
>  
> +config HID_SENSOR_HUB
> +	tristate "HID Sensors framework support"
> +	depends on USB_HID
> +	select MFD_CORE
> +	default n
> +	-- help---
> +	  Support for HID Sensor framework. This creates a MFD instance
> +	  for a sensor hub and identifies all the sensors connected to it.
> +	  Each sensor is registered as a MFD cell, so that sensor specific
> +	  processing can be done in a separate driver. Each sensor
> +	  drivers can use the service provided by this driver to register
> +	  for events and handle data streams. Each sensor driver can format
> +	  data and present to user mode using input or IIO interface.
> +
>  endmenu
>  
>  endif # HID_SUPPORT
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index ca6cc9f..08f9d8f 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
>  obj-$(CONFIG_HID_WACOM)		+= hid-wacom.o
>  obj-$(CONFIG_HID_WALTOP)	+= hid-waltop.o
>  obj-$(CONFIG_HID_WIIMOTE)	+= hid-wiimote.o
> +obj-$(CONFIG_HID_SENSOR_HUB)	+= hid-sensor-hub.o
>  
>  obj-$(CONFIG_USB_HID)		+= usbhid/
>  obj-$(CONFIG_USB_MOUSE)		+= usbhid/
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> new file mode 100644
> index 0000000..60e78fb
> --- /dev/null
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -0,0 +1,682 @@
> +/*
> + * HID Sensors Driver
> + * Copyright (c) 2012, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/usb.h>
> +#include "usbhid/usbhid.h"
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/core.h>
> +#include <linux/list.h>
> +#include <linux/hid-sensor-ids.h>
> +#include <linux/hid-sensor-hub.h>
> +#include "hid-ids.h"
> +
> +/**
> + * struct sensor_hub_pending - Synchronous read pending information
> + * @status:		Pending status true/false.
> + * @ready:		Completion synchronization data.
> + * @usage_id:		Usage id for physical device, E.g. Gyro usage id.
> + * @attr_usage_id:	Usage Id of a field, E.g. X-AXIS for a gyro.
> + * @raw_size:		Response size for a read request.
> + * @raw_data:		Place holder for received response.
> + */
> +struct sensor_hub_pending {
> +	bool status;
> +	struct completion ready;
> +	u32 usage_id;
> +	u32 attr_usage_id;
> +	int raw_size;
> +	u8  *raw_data;
> +};
> +
> +/**
> + * struct sensor_hub_data - Hold a instance data for a HID hub device
> + * @hsdev:		Stored hid instance for current hub device.
> + * @mutex:		Mutex to serialize synchronous request.
> + * @lock:		Spin lock to protect pending request structure.
> + * @pending:		Holds information of pending sync read request.
> + * @dyn_callback_list:	Holds callback function
> + * @dyn_lock:		spin lock to prevent callback list

I guess 'prevent' should be 'protect' here, right?

Also, I'd prefer some more descriptive name ... it took me a while to 
figure out what this lock is actually protecting. Perhaps 'callback_lock' 
would work better?

> + * @hid_sensor_hub_client_devs:	Stores all MFD cells for a hub instance.
> + * @hid_sensor_client_cnt: Number of MFD cells, (no of sensors attached).
> + */
> +struct sensor_hub_data {
> +	struct hid_sensor_hub_device *hsdev;
> +	struct mutex mutex;
> +	spinlock_t lock;
> +	struct sensor_hub_pending pending;
> +	struct list_head dyn_callback_list;
> +	spinlock_t dyn_lock;
> +	struct mfd_cell *hid_sensor_hub_client_devs;
> +	int hid_sensor_client_cnt;
> +};
> +
> +/**
> + * struct hid_sensor_hub_callbacks_list - Stores callback list
> + * @list:		list head.
> + * @usage_id:		usage id for a physical device.
> + * @usage_callback:	Stores registered callback functions.
> + * @priv:		Private data for a physical device.
> + */
> +struct hid_sensor_hub_callbacks_list {
> +	struct list_head list;
> +	u32 usage_id;
> +	struct hid_sensor_hub_callbacks *usage_callback;
> +	void *priv;
> +};
> +
> +static int sensor_hub_check_for_sensor_page(struct hid_device *hdev)
> +{
> +	int i;
> +	int ret = -EINVAL;
> +
> +	for (i = 0; i < hdev->maxcollection; i++) {
> +		struct hid_collection *col = &hdev->collection[i];
> +		if (col->type == HID_COLLECTION_PHYSICAL &&
> +		   (col->usage & HID_USAGE_PAGE) == HID_UP_SENSOR) {
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static struct hid_report *sensor_hub_report(int id, struct hid_device *hdev,
> +						int dir)
> +{
> +	struct hid_report *report;
> +
> +	list_for_each_entry(report, &hdev->report_enum[dir].report_list, list) {
> +		if (report->id == id)
> +			return report;
> +	}
> +	hid_warn(hdev, "No report with id 0x%x found\n", id);
> +
> +	return NULL;
> +}
> +
> +static int sensor_hub_get_physical_device_count(
> +				struct hid_report_enum *report_enum)
> +{
> +	struct hid_report *report;
> +	struct hid_field *field;
> +	int cnt = 0;
> +
> +	list_for_each_entry(report, &report_enum->report_list, list) {
> +		field = report->field[0];
> +		if (report->maxfield && field &&
> +					field->physical)
> +			cnt++;
> +	}
> +
> +	return cnt;
> +}
> +
> +static struct hid_sensor_hub_callbacks *sensor_hub_get_callback(
> +					struct hid_device *hdev,
> +					u32 usage_id, void **priv)
> +{
> +	struct hid_sensor_hub_callbacks_list *callback;
> +	struct sensor_hub_data *pdata = hid_get_drvdata(hdev);
> +
> +	spin_lock(&pdata->dyn_lock);
> +	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
> +		if (callback->usage_id == usage_id) {
> +			*priv = callback->priv;
> +			spin_unlock(&pdata->dyn_lock);
> +			return callback->usage_callback;
> +		}
> +	spin_unlock(&pdata->dyn_lock);
> +
> +	return NULL;
> +}
> +
> +int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
> +			u32 usage_id,
> +			struct hid_sensor_hub_callbacks *usage_callback)
> +{
> +	struct hid_sensor_hub_callbacks_list *callback;
> +	struct sensor_hub_data *pdata = hid_get_drvdata(hsdev->hdev);
> +
> +	spin_lock(&pdata->dyn_lock);
> +	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
> +		if (callback->usage_id == usage_id) {
> +			spin_unlock(&pdata->dyn_lock);
> +			return -EINVAL;
> +		}
> +	callback = kzalloc(sizeof(*callback), GFP_KERNEL);
> +	if (!callback) {
> +		spin_unlock(&pdata->dyn_lock);
> +		return -ENOMEM;
> +	}
> +	callback->usage_callback = usage_callback;
> +	callback->usage_id = usage_id;
> +	callback->priv = NULL;
> +	list_add_tail(&callback->list, &pdata->dyn_callback_list);
> +	spin_unlock(&pdata->dyn_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_register_callback);
> +
> +int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
> +				u32 usage_id)
> +{
> +	struct hid_sensor_hub_callbacks_list *callback;
> +	struct sensor_hub_data *pdata = hid_get_drvdata(hsdev->hdev);
> +
> +	spin_lock(&pdata->dyn_lock);
> +	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
> +		if (callback->usage_id == usage_id) {
> +			list_del(&callback->list);
> +			kfree(callback);
> +			break;
> +		}
> +	spin_unlock(&pdata->dyn_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_remove_callback);
> +
> +int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> +				u32 field_index, s32 value)
> +{
> +	struct hid_report *report;
> +	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> +	int ret = 0;
> +
> +	if (report_id < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
> +	if (!report || (field_index >=  report->maxfield)) {
> +		ret = -EINVAL;
> +		goto done_proc;
> +	}
> +	hid_set_field(report->field[field_index], 0, value);
> +	usbhid_submit_report(hsdev->hdev, report, USB_DIR_OUT);
> +	usbhid_wait_io(hsdev->hdev);
> +
> +done_proc:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_set_feature);
> +
> +int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> +				u32 field_index, s32 *value)
> +{
> +	struct hid_report *report;
> +	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> +	int ret = 0;
> +
> +	if (report_id < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
> +	if (!report || (field_index >=  report->maxfield)) {
> +		ret = -EINVAL;
> +		goto done_proc;
> +	}
> +	usbhid_submit_report(hsdev->hdev, report, USB_DIR_IN);
> +	usbhid_wait_io(hsdev->hdev);
> +	*value = report->field[field_index]->value[0];
> +
> +done_proc:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_get_feature);
> +
> +
> +int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
> +					u32 usage_id,
> +					u32 attr_usage_id, u32 report_id)
> +{
> +	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> +	unsigned long flags;
> +	struct hid_report *report;
> +	int ret_val = 0;
> +
> +	if (report_id < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	memset(&data->pending, 0, sizeof(data->pending));
> +	init_completion(&data->pending.ready);
> +	data->pending.usage_id = usage_id;
> +	data->pending.attr_usage_id = attr_usage_id;
> +	data->pending.raw_size = 0;
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	data->pending.status = true;
> +	report = sensor_hub_report(report_id, hsdev->hdev, HID_INPUT_REPORT);
> +	if (!report) {
> +		spin_unlock_irqrestore(&data->lock, flags);
> +		goto err_free;
> +	}
> +	usbhid_submit_report(hsdev->hdev, report, USB_DIR_IN);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +	wait_for_completion_interruptible_timeout(&data->pending.ready, HZ*5);
> +	switch (data->pending.raw_size) {
> +	case 1:
> +		ret_val = *(u8 *)data->pending.raw_data;
> +		break;
> +	case 2:
> +		ret_val = *(u16 *)data->pending.raw_data;
> +		break;
> +	case 4:
> +		ret_val = *(u32 *)data->pending.raw_data;
> +		break;
> +	default:
> +		ret_val = 0;
> +	}
> +	kfree(data->pending.raw_data);
> +
> +err_free:
> +	data->pending.status = false;
> +	mutex_unlock(&data->mutex);
> +
> +	return ret_val;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_input_attr_get_raw_value);
> +
> +int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
> +				u8 type,
> +				u32 usage_id,
> +				u32 attr_usage_id,
> +				struct hid_sensor_hub_attribute_info *info)
> +{
> +	int ret = -1;
> +	int i, j;
> +	int collection_index = -1;
> +	struct hid_report *report;
> +	struct hid_field *field;
> +	struct hid_report_enum *report_enum;
> +	struct hid_device *hdev = hsdev->hdev;
> +
> +	/* Initialize with defaults */
> +	info->usage_id = usage_id;
> +	info->attrib_id =  attr_usage_id;
> +	info->report_id = -1;
> +	info->index = -1;
> +	info->units = -1;
> +	info->unit_expo = -1;
> +
> +	for (i = 0; i < hdev->maxcollection; ++i) {
> +		struct hid_collection *collection = &hdev->collection[i];
> +		if (usage_id == collection->usage) {
> +			collection_index = i;
> +			break;
> +		}
> +	}
> +	if (collection_index == -1)
> +		goto err_ret;
> +
> +	report_enum = &hdev->report_enum[type];
> +	list_for_each_entry(report, &report_enum->report_list, list) {
> +		for (i = 0; i < report->maxfield; ++i) {
> +			field = report->field[i];
> +			if (field->physical == usage_id &&
> +				field->logical == attr_usage_id) {
> +				info->index = i;
> +				info->report_id = report->id;
> +				info->units = field->unit;
> +				info->unit_expo = field->unit_exponent;
> +				info->size = field->report_size/8;
> +				ret = 0;
> +			} else {
> +				for (j = 0; j < field->maxusage; ++j) {
> +					if (field->usage[j].hid ==
> +					attr_usage_id &&
> +					field->usage[j].collection_index ==
> +					collection_index)  {
> +						info->index = i;
> +						info->report_id = report->id;
> +						info->units = field->unit;
> +						info->unit_expo =
> +							field->unit_exponent;
> +						info->size =
> +							field->report_size/8;
> +						ret = 0;

This looks ugly. Filling of the info structure is the same in both 
branches, so how about just factoring it out to something like 
fill_info_struct() and use it in both this block and the block above?

> +						break;
> +					}
> +				}
> +			}
> +			if (ret == 0)
> +				break;
> +		}
> +	}
> +
> +err_ret:
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_input_get_attribute_info);
> +
> +#ifdef CONFIG_PM
> +static int sensor_hub_suspend(struct hid_device *hdev, pm_message_t message)
> +{
> +	struct sensor_hub_data *pdata =  hid_get_drvdata(hdev);
> +	struct hid_sensor_hub_callbacks_list *callback;
> +
> +	hid_dbg(hdev, " sensor_hub_suspend\n");
> +	spin_lock(&pdata->dyn_lock);
> +	list_for_each_entry(callback, &pdata->dyn_callback_list, list) {
> +		if (callback->usage_callback->suspend)
> +			callback->usage_callback->suspend(
> +					pdata->hsdev, callback->priv);
> +	}
> +	spin_unlock(&pdata->dyn_lock);
> +
> +	return 0;
> +}
> +
> +static int sensor_hub_resume(struct hid_device *hdev)
> +{
> +	struct sensor_hub_data *pdata =  hid_get_drvdata(hdev);
> +	struct hid_sensor_hub_callbacks_list *callback;
> +
> +	hid_dbg(hdev, " sensor_hub_resume\n");
> +	spin_lock(&pdata->dyn_lock);
> +	list_for_each_entry(callback, &pdata->dyn_callback_list, list) {
> +		if (callback->usage_callback->resume)
> +			callback->usage_callback->resume(
> +					pdata->hsdev, callback->priv);
> +	}
> +	spin_unlock(&pdata->dyn_lock);
> +
> +	return 0;
> +}
> +
> +static int sensor_hub_reset_resume(struct hid_device *hdev)
> +{
> +	return 0;
> +}
> +#endif
> +/*
> + * Handle raw report as sent by device
> + */
> +static int sensor_hub_raw_event(struct hid_device *hdev,
> +		struct hid_report *report, u8 *raw_data, int size)
> +{
> +	int i;
> +	u8 *ptr;
> +	int sz;
> +	struct sensor_hub_data *pdata = hid_get_drvdata(hdev);
> +	unsigned long flags;
> +	struct hid_sensor_hub_callbacks *callback = NULL;
> +	struct hid_collection *collection = NULL;
> +	void *priv = NULL;
> +
> +	hid_dbg(hdev, "sensor_hub_raw_event report id:0x%x size:%d type:%d\n",
> +			 report->id, size, report->type);
> +	hid_dbg(hdev, "maxfield:%d\n", report->maxfield);
> +	if (report->type != HID_INPUT_REPORT)
> +		return 1;
> +
> +	ptr = raw_data;
> +	ptr++; /*Skip report id*/
> +
> +	if (!report)
> +		goto err_report;
> +
> +	spin_lock_irqsave(&pdata->lock, flags);
> +
> +	for (i = 0; i < report->maxfield; ++i) {
> +
> +		hid_dbg(hdev, "%d collection_index:%x hid:%x sz:%x\n",
> +				i, report->field[i]->usage->collection_index,
> +				report->field[i]->usage->hid,
> +				report->field[i]->report_size/8);
> +
> +		sz = report->field[i]->report_size/8;
> +		if (pdata->pending.status && pdata->pending.attr_usage_id ==
> +				report->field[i]->usage->hid) {
> +			hid_dbg(hdev, "data was pending ...\n");
> +			pdata->pending.raw_data = kmalloc(sz, GFP_KERNEL);
> +			if (pdata->pending.raw_data) {
> +				memcpy(pdata->pending.raw_data, ptr, sz);
> +				pdata->pending.raw_size  = sz;
> +			} else
> +				pdata->pending.raw_size = 0;
> +			complete(&pdata->pending.ready);
> +		}
> +		collection = &hdev->collection[
> +				report->field[i]->usage->collection_index];
> +		hid_dbg(hdev, "collection->usage %x\n",
> +					collection->usage);
> +		callback = sensor_hub_get_callback(pdata->hsdev->hdev,
> +						report->field[i]->physical,
> +							&priv);
> +		if (callback && callback->capture_sample) {
> +			if (report->field[i]->logical)
> +				callback->capture_sample(pdata->hsdev,
> +					report->field[i]->logical, sz, ptr,
> +					callback->pdev);
> +			else
> +				callback->capture_sample(pdata->hsdev,
> +					report->field[i]->usage->hid, sz, ptr,
> +					callback->pdev);
> +		}
> +		ptr += sz;
> +	}
> +	if (callback && collection && callback->send_event)
> +		callback->send_event(pdata->hsdev, collection->usage,
> +				callback->pdev);
> +	spin_unlock_irqrestore(&pdata->lock, flags);
> +
> +err_report:
> +	return 1;
> +}
> +
> +static int sensor_hub_probe(struct hid_device *hdev,
> +				const struct hid_device_id *id)
> +{
> +	int ret;
> +	struct sensor_hub_data *sd;
> +	int i;
> +	char *name;
> +	struct hid_report *report;
> +	struct hid_report_enum *report_enum;
> +	struct hid_field *field;
> +	int dev_cnt;
> +
> +	sd = kzalloc(sizeof(struct sensor_hub_data), GFP_KERNEL);
> +	if (!sd) {
> +		hid_err(hdev, "cannot allocate Sensor data\n");
> +		return -ENOMEM;
> +	}
> +	sd->hsdev = kzalloc(sizeof(struct hid_sensor_hub_device), GFP_KERNEL);
> +	if (!sd->hsdev) {
> +		hid_err(hdev, "cannot allocate hid_sensor_hub_device\n");
> +		ret = -ENOMEM;
> +		goto err_free_hub;
> +	}
> +	hid_set_drvdata(hdev, sd);
> +	sd->hsdev->hdev = hdev;
> +	sd->hsdev->vendor_id = hdev->vendor;
> +	sd->hsdev->product_id = hdev->product;
> +	spin_lock_init(&sd->lock);
> +	spin_lock_init(&sd->dyn_lock);
> +	mutex_init(&sd->mutex);
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed\n");
> +		goto err_free;
> +	}
> +	if (sensor_hub_check_for_sensor_page(hdev) < 0) {
> +		hid_err(hdev, "sensor page not found\n");
> +		goto err_free;
> +	}
> +	INIT_LIST_HEAD(&hdev->inputs);
> +
> +	hdev->claimed = HID_CLAIMED_INPUT;
> +	ret = hid_hw_start(hdev, 0);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed\n");
> +		goto err_free;
> +	}
> +	ret = hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "failed to open input interrupt pipe\n");
> +		goto err_stop_hw;
> +	}
> +
> +	INIT_LIST_HEAD(&sd->dyn_callback_list);
> +	sd->hid_sensor_client_cnt = 0;
> +	report_enum = &hdev->report_enum[HID_INPUT_REPORT];
> +
> +	dev_cnt = sensor_hub_get_physical_device_count(report_enum);
> +	sd->hid_sensor_hub_client_devs = kzalloc(dev_cnt *
> +						sizeof(struct mfd_cell),
> +						GFP_KERNEL);

In theory there is nothing preventing buggy device, which will cause very 
large dev_cnt, to cause overflow here and cause kernel memory corruption, 
right?

So I'd like to see some boundary check on dev_cnt.

These all are rather minor comments, overall it looks fine to me. Once the 
feedback above is handled/discussed, I will add my Signed-off-by and you 
could push it through Greg then.

Thanks for all the work!

-- 
Jiri Kosina
SUSE Labs
