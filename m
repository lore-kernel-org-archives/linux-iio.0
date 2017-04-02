Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48134 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbdDBK7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 06:59:15 -0400
Subject: Re: [PATCH] iio: hid-sensor-hub: Implement batch mode
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        jikos@kernel.org
References: <1490738130-54272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Message-ID: <3c5824ca-e56b-f1c2-2fda-42f4b4bafa61@kernel.org>
Date: Sun, 2 Apr 2017 11:59:13 +0100
MIME-Version: 1.0
In-Reply-To: <1490738130-54272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 28/03/17 22:55, Srinivas Pandruvada wrote:
> HID sensor hubs using Integrated Senor Hub (ISH) has added capability to
> support batch mode. This allows host processor to go to sleep for extended
> duration, while the sensor hub is storing samples in its internal buffers.
> 
> 'Commit f4f4673b7535 ("iio: add support for hardware fifo")' implements
> feature in IIO core to implement such feature. This feature is used in
> bmc150-accel-core.c to implement batch mode. This implementation allows
> software device buffer watermark to be used as a hint to adjust hardware
> FIFO.
> 
> But HID sensor hubs don't allow to change internal buffer size of FIFOs.
> Instead an additional usage id to set "maximum report latency" is defined.
> This allows host to go to sleep upto this latency period without getting
> any report. Since there is no ABI to set this latency, a new attribute
> "hwfifo_timeout" is added so that user mode can specify a latency.
> 
> This change checks presence of usage id to get/set maximum report latency
> and if present, it will expose hwfifo_timeout.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Basically looks good to me.  A few little things to tidy up inline though.

Jonathan
> ---
> Changed compared to RFC:
> - Removed min/max Fifo size attributes
> - Removed flush callback. Since this usage id is not present in any hubs,
> we can add later when we have some HW to test. This was causing some
> ugliness.
> - Moved the hwfifo_timout documentation to sysfs-bus-iio
> 
>  Documentation/ABI/testing/sysfs-bus-iio            | 11 ++++
>  .../iio/common/hid-sensors/hid-sensor-attributes.c | 48 +++++++++++++++
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    | 70 ++++++++++++++++++++++
>  include/linux/hid-sensor-hub.h                     |  4 ++
>  include/linux/hid-sensor-ids.h                     |  3 +
>  5 files changed, 136 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 530809c..b09f373 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1424,6 +1424,17 @@ Description:
>  		guarantees that the hardware fifo is flushed to the device
>  		buffer.
>  
> +What:		/sys/bus/iio/devices/iio:device*/buffer/hwfifo_timeout
> +KernelVersion:	4.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A read/write property to provide capability to delay reporting of
> +		samples till a timeout is reached. This allows host processors to
> +		sleep, while the sensor is storing samples in its internal fifo.
> +		The maximum timeout in seconds can be specified by setting
> +		hwfifo_timeout.The current delay can be read by reading
> +		hwfifo_timeout. A value of 0 means that there is no timout.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark
>  KernelVersion: 4.2
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 7afdac42..e4d335c 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -373,6 +373,52 @@ int hid_sensor_get_reporting_interval(struct hid_sensor_hub_device *hsdev,
>  
>  }
>  
> +static void hid_sensor_get_report_latency_info(struct hid_sensor_hub_device *hsdev,
> +					       u32 usage_id,
> +					       struct hid_sensor_common *st)
> +{
> +	sensor_hub_input_get_attribute_info(hsdev, HID_FEATURE_REPORT,
> +					    usage_id,
> +					    HID_USAGE_SENSOR_PROP_REPORT_LATENCY,
> +					    &st->report_latency);
> +
> +	hid_dbg(hsdev->hdev, "Report latency attributes: %x:%x \n",
> +		st->report_latency.index, st->report_latency.report_id);
> +}
> +
> +int hid_sensor_get_report_latency(struct hid_sensor_common *st)
> +{
> +	int ret;
> +	int value;
> +
> +	ret = sensor_hub_get_feature(st->hsdev, st->report_latency.report_id,
> +				     st->report_latency.index, sizeof(value),
> +				     &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return value;
> +}
> +EXPORT_SYMBOL(hid_sensor_get_report_latency);
> +
> +int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency_ms)
> +{
> +
Odd blank line snuck in here. Get rid of it.
> +	return sensor_hub_set_feature(st->hsdev, st->report_latency.report_id,
> +				      st->report_latency.index,
> +				      sizeof(latency_ms), &latency_ms);
> +}
> +EXPORT_SYMBOL(hid_sensor_set_report_latency);
> +
> +bool hid_sensor_batch_mode_supported(struct hid_sensor_common *st)
> +{
> +	if (st->report_latency.index > 0 && st->report_latency.report_id > 0)
> +		return true;
> +
> +	return false;
    return st->report_latency.index > 0 && st->report_latency.report_id > 0;
    
> +}
> +EXPORT_SYMBOL(hid_sensor_batch_mode_supported);
> +
>  int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  					u32 usage_id,
>  					struct hid_sensor_common *st)
> @@ -410,6 +456,8 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  	} else
>  		st->timestamp_ns_scale = 1000000000;
>  
> +	hid_sensor_get_report_latency_info(hsdev, usage_id, st);
> +
>  	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x %x:%x\n",
>  		st->poll.index, st->poll.report_id,
>  		st->report_state.index, st->report_state.report_id,
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index a3cce3a..ef06541 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -26,9 +26,77 @@
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/sysfs.h>
>  #include "hid-sensor-trigger.h"
>  
> +static ssize_t _hid_sensor_set_report_latency(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int latency, ret;
> +
> +	if (kstrtoint(buf, 10, &latency))
> +		return -EINVAL;
> +
> +	ret = hid_sensor_set_report_latency(iio_trigger_get_drvdata(indio_dev->trig),
> +					    latency * 1000);
> +	if (ret < 0)
> +		return len;
> +
> +	return len;
> +}
> +
> +static ssize_t _hid_sensor_get_report_latency(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int latency;
> +
> +	latency = hid_sensor_get_report_latency(iio_trigger_get_drvdata(indio_dev->trig));
> +	if (latency < 0)
> +		return latency;
> +
> +	return sprintf(buf, "%d\n", latency / 1000);
Seems to me that you'll be wanting latencies of sub one second sometimes...
hence I'd make this fixed point.  The core IIO functions should be available
to help with conversion if you want to use them.
> +}
> +
> +static ssize_t _hid_sensor_get_fifo_state(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int latency;
> +
> +	latency = hid_sensor_get_report_latency(iio_trigger_get_drvdata(indio_dev->trig));
> +	if (latency < 0)
> +		return latency;
> +
> +	return sprintf(buf, "%d\n", latency > 0 ? 1:0);
Personal preference is for !!latency but doesn't really matter.
> +}
> +
> +static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
> +		       _hid_sensor_get_report_latency,
> +		       _hid_sensor_set_report_latency, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       _hid_sensor_get_fifo_state, NULL, 0);
> +
> +static const struct attribute *hid_sensor_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL,
> +};
> +
> +static void hid_sensor_setup_batch_mode(struct iio_dev *indio_dev,
> +					struct hid_sensor_common *st)
> +{
> +	if (!hid_sensor_batch_mode_supported(st))
> +		return;
> +
> +	iio_buffer_set_attrs(indio_dev->buffer, hid_sensor_fifo_attributes);
> +}
> +
>  static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  {
>  	int state_val;
> @@ -174,6 +242,8 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  	attrb->trigger = trig;
>  	indio_dev->trig = iio_trigger_get(trig);
>  
> +	hid_sensor_setup_batch_mode(indio_dev, attrb);
> +
>  	ret = pm_runtime_set_active(&indio_dev->dev);
>  	if (ret)
>  		goto error_unreg_trigger;
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 7ef111d..a045940 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -237,6 +237,7 @@ struct hid_sensor_common {
>  	struct hid_sensor_hub_attribute_info report_state;
>  	struct hid_sensor_hub_attribute_info power_state;
>  	struct hid_sensor_hub_attribute_info sensitivity;
> +	struct hid_sensor_hub_attribute_info report_latency;
>  	struct work_struct work;
>  };
>  
> @@ -274,5 +275,8 @@ s32 hid_sensor_read_poll_value(struct hid_sensor_common *st);
>  
>  int64_t hid_sensor_convert_timestamp(struct hid_sensor_common *st,
>  				     int64_t raw_value);
> +bool hid_sensor_batch_mode_supported(struct hid_sensor_common *st);
> +int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency);
> +int hid_sensor_get_report_latency(struct hid_sensor_common *st);
>  
>  #endif
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 30c7dc4..d7caf8c 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -142,6 +142,9 @@
>  #define HID_USAGE_SENSOR_PROP_REPORT_STATE			0x200316
>  #define HID_USAGE_SENSOR_PROY_POWER_STATE			0x200319
>  
> +/* Batch mode selectors */
> +#define HID_USAGE_SENSOR_PROP_REPORT_LATENCY			0x20031B
> +
>  /* Per data field properties */
>  #define HID_USAGE_SENSOR_DATA_MOD_NONE					0x00
>  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		0x1000
> 

