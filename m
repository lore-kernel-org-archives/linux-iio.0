Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43505 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdCYRBp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 13:01:45 -0400
Subject: Re: [RFC PATCH] iio: hid-sensor-hub: Implement batch mode
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        jikos@kernel.org
References: <1490220945-39624-1-git-send-email-srinivas.pandruvada@linux.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Message-ID: <abbc5695-eac9-117b-4a47-c54b89154d03@kernel.org>
Date: Sat, 25 Mar 2017 17:01:42 +0000
MIME-Version: 1.0
In-Reply-To: <1490220945-39624-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/03/17 22:15, Srinivas Pandruvada wrote:
> HID sensor hubs using Integrated Senor Hub (ISH) has added capability to
> support batch mode. This allows host processor to go to sleep for extended
> duration, while sensor hub is storing samples in its internal buffers.
> 
> 'Commit f4f4673b7535 ("iio: add support for hardware fifo")'
> implements feature in IIO core to implement such feature. This feature
> is used bmc150-accel-core.c to implement batch mode. This implementation
> is similar with one major exception.
> 
> The above commit allows sofware device buffer watermark to be used as a
software
> hint to adjust hardware FIFO as it is done for bmc150-accel-core.c, by
> introducing a new callback.
> 
> But HID sensor hubs don't allows to change internal buffer size of FIFOs.
allow
> Instead an additional usage id to set "maximum report latency" is defined.
> This allows host to go to sleep upto this latency period without getting
> any report. Since there is no ABI to set this latency, a new attribute
> "hwfifo_timeout" is added so that user mode can specify a latency.
Arguably you could sometimes backtrack to make this use the above interface,
as long as the sample rate can be read. Still a reasonable new interface
to my mind.
> 
> Similar to bmc150-accel-core, callback for flushing fifo is added only
> when usage id for flush request is present. This usage id is otional.
> 
> For specifying software buffer length and watermark the min/max fifo size
> is also presented via  hwfifo_watermark_min and hwfifo_watermark_max
odd spacing after via
> respectively.

Huh?  Why introduce min and max for something these sensors don't provide?
I guess this means some hid devices do provide direct access to the fifo
settings, but not all?
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Anyhow, it's a nice bit of logical functionality so I would be suprised
if it doesn't spread beyond hid devices going forward.

A few minor bits and bobs inline, but basically concept is sound and
how you implement it makes sense to me.

Jonathan
> ---
>  .../ABI/testing/sysfs-bus-iio-hid-sensor-hub       |  10 ++
>  .../iio/common/hid-sensors/hid-sensor-attributes.c |  83 +++++++++++++++
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    | 118 +++++++++++++++++++++
>  include/linux/hid-sensor-hub.h                     |   8 ++
>  include/linux/hid-sensor-ids.h                     |   5 +
>  5 files changed, 224 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-hid-sensor-hub
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-hid-sensor-hub b/Documentation/ABI/testing/sysfs-bus-iio-hid-sensor-hub
> new file mode 100644
> index 0000000..00950bb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-hid-sensor-hub
> @@ -0,0 +1,10 @@
> +What:		/sys/bus/iio/devices/iio:device*/buffer/hwfifo_timeout
> +KernelVersion:	4.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The HID Sensor Hub provides capability to delay reporting of
> +		samples till a timeout is reached. This allows host processor
> +		to sleep while sensor hub is storing samples in its internal
> +		buffers. The maximum timeout in milli seconds can be specified
> +		by setting hwfifo_timeout.
Hmm. Seconds preferred.  That would line up with the other timing based
elements in the ABI.

This seems generic enough to me that it'll soon turn up in some other
sensor hubs, so put it directly in sysfs-bus-iio
> +
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 7afdac42..8f1e85e 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -373,6 +373,87 @@ int hid_sensor_get_reporting_interval(struct hid_sensor_hub_device *hsdev,
>  
>  }
>  
> +static void hid_sensor_get_fifo_info(struct hid_sensor_hub_device *hsdev,
> +				     u32 usage_id,
> +				     struct hid_sensor_common *st)
> +{
> +	sensor_hub_input_get_attribute_info(hsdev, HID_FEATURE_REPORT,
> +					usage_id,
> +					HID_USAGE_SENSOR_PROP_MAX_FIFO_EVENTS,
> +					&st->max_fifo_events);
> +	sensor_hub_input_get_attribute_info(hsdev, HID_FEATURE_REPORT,
> +					usage_id,
> +					HID_USAGE_SENSOR_PROP_REPORT_LATENCY,
> +					&st->report_latency);
> +
> +	sensor_hub_input_get_attribute_info(hsdev, HID_FEATURE_REPORT,
> +					usage_id,
> +					HID_USAGE_SENSOR_PROP_FLUSH_FIFO_EVENTS,
> +					&st->flush_fifo);
> +	hid_dbg(hsdev->hdev, "Fifo attributes: %x:%x, %x:%x, %x:%x\n",
> +		st->max_fifo_events.index, st->max_fifo_events.report_id,
> +		st->report_latency.index, st->report_latency.report_id,
> +		st->flush_fifo.index, st->flush_fifo.report_id);
> +}
> +
> +int hid_sensor_flush_fifo(struct hid_sensor_common *st)
> +{
> +	int flush = 1;
> +
> +	return sensor_hub_set_feature(st->hsdev, st->flush_fifo.report_id,
> +				      st->flush_fifo.index, st->flush_fifo.size,
> +				      &flush);
> +}
> +EXPORT_SYMBOL(hid_sensor_flush_fifo);
> +
> +int hid_sensor_get_max_fifo(struct hid_sensor_common *st)
> +{
> +	int ret;
> +	int value;
> +
> +	ret = sensor_hub_get_feature(st->hsdev, st->max_fifo_events.report_id,
> +				     st->max_fifo_events.index, sizeof(value),
> +				     &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return value;
> +}
> +EXPORT_SYMBOL(hid_sensor_get_max_fifo);
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
> +}
> +EXPORT_SYMBOL(hid_sensor_batch_mode_supported);
> +
>  int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  					u32 usage_id,
>  					struct hid_sensor_common *st)
> @@ -410,6 +491,8 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  	} else
>  		st->timestamp_ns_scale = 1000000000;
>  
> +	hid_sensor_get_fifo_info(hsdev, usage_id, st);
> +
>  	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x %x:%x\n",
>  		st->poll.index, st->poll.report_id,
>  		st->report_state.index, st->report_state.report_id,
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index a3cce3a..d03b013 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -26,9 +26,125 @@
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
> +	ret = hid_sensor_set_report_latency(iio_trigger_get_drvdata(
> +						    indio_dev->trig), latency);
That line break is really ugly. Just go over 80 chars in the interests of
readability.
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
> +	latency = hid_sensor_get_report_latency(iio_trigger_get_drvdata(
> +							indio_dev->trig));
> +	if (latency < 0)
> +		return latency;
> +
> +	return sprintf(buf, "%d\n", latency);
> +}
> +
> +static int _hid_sensor_fifo_flush(struct iio_dev *indio_dev,
> +				  unsigned int samples)
> +{
> +	return hid_sensor_flush_fifo(iio_trigger_get_drvdata(indio_dev->trig));
> +}
> +
> +static ssize_t _hid_sensor_get_max_fifo(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int max_fifo;
> +
> +	max_fifo = hid_sensor_get_max_fifo(iio_trigger_get_drvdata(
> +						   indio_dev->trig));
> +	if (max_fifo < 0)
> +		return max_fifo;
> +
> +	return sprintf(buf, "%d\n", max_fifo);
> +}
> +
> +static ssize_t _hid_sensor_get_fifo_state(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int latency;
> +
> +	latency = hid_sensor_get_report_latency(iio_trigger_get_drvdata(
> +							indio_dev->trig));
> +	if (latency < 0)
> +		return latency;
> +
> +	return sprintf(buf, "%d\n", latency > 0 ? 1:0);
> +}
> +
> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> +static IIO_DEVICE_ATTR(hwfifo_watermark_max, 0444,
> +		       _hid_sensor_get_max_fifo, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
> +		       _hid_sensor_get_report_latency,
> +		       _hid_sensor_set_report_latency, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       _hid_sensor_get_fifo_state, NULL, 0);
> +
> +static const struct attribute *hid_sensor_fifo_attributes[] = {
> +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL,
Hmm. It strikes me that we may well want to have in kernel consumer
access to these fairly soon.  To do that we'll probably need to
move over to callbacks for each of these.  Ah well, will tackle that
when someone first cares.
> +};
one blank line please.
> +
> +
> +static void hid_sensor_setup_batch_mode(struct iio_dev *indio_dev,
> +				       struct hid_sensor_common *st)
> +{
> +	struct iio_info *iio_info;
> +
> +	if (!hid_sensor_batch_mode_supported(st))
> +		return;
> +
> +	/* Not all implementation has Flush implemented, so check */
> +	if (st->flush_fifo.index > 0 && st->flush_fifo.report_id > 0) {
> +		/*
> +		 * Each sensor type defines their own callbacks, which are
> +		 * specified via indio_dev->info. So instead of modifying
> +		 * every driver, change it when we need to add additional
> +		 * callback by reassigning the indio_dev->info.
> +		 */
This is somewhat ugly.  I suspect it'll come back to bite at somepoint,
but fair enough on the basis it saves a fair bit of churn...

> +		iio_info = devm_kmemdup(&st->pdev->dev, indio_dev->info,
> +					sizeof(struct iio_info), GFP_KERNEL);
> +		if (!iio_info)
> +			return;
> +
> +		iio_info->hwfifo_flush_to_buffer = _hid_sensor_fifo_flush;
> +		indio_dev->info = (const struct iio_info *)iio_info;
> +	}
> +
> +	iio_buffer_set_attrs(indio_dev->buffer, hid_sensor_fifo_attributes);
> +}
> +
>  static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  {
>  	int state_val;
> @@ -174,6 +290,8 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  	attrb->trigger = trig;
>  	indio_dev->trig = iio_trigger_get(trig);
>  
> +	hid_sensor_setup_batch_mode(indio_dev, attrb);
> +
>  	ret = pm_runtime_set_active(&indio_dev->dev);
>  	if (ret)
>  		goto error_unreg_trigger;
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 7ef111d..a790960 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -237,6 +237,9 @@ struct hid_sensor_common {
>  	struct hid_sensor_hub_attribute_info report_state;
>  	struct hid_sensor_hub_attribute_info power_state;
>  	struct hid_sensor_hub_attribute_info sensitivity;
> +	struct hid_sensor_hub_attribute_info max_fifo_events;
> +	struct hid_sensor_hub_attribute_info report_latency;
> +	struct hid_sensor_hub_attribute_info flush_fifo;
>  	struct work_struct work;
>  };
>  
> @@ -274,5 +277,10 @@ s32 hid_sensor_read_poll_value(struct hid_sensor_common *st);
>  
>  int64_t hid_sensor_convert_timestamp(struct hid_sensor_common *st,
>  				     int64_t raw_value);
> +bool hid_sensor_batch_mode_supported(struct hid_sensor_common *st);
> +int hid_sensor_get_max_fifo(struct hid_sensor_common *st);
> +int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency);
> +int hid_sensor_flush_fifo(struct hid_sensor_common *st);
> +int hid_sensor_get_report_latency(struct hid_sensor_common *st);
>  
>  #endif
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 30c7dc4..22374e1 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -142,6 +142,11 @@
>  #define HID_USAGE_SENSOR_PROP_REPORT_STATE			0x200316
>  #define HID_USAGE_SENSOR_PROY_POWER_STATE			0x200319
>  
> +/* Batch mode selectors */
> +#define HID_USAGE_SENSOR_PROP_MAX_FIFO_EVENTS			0x20031A
> +#define HID_USAGE_SENSOR_PROP_REPORT_LATENCY			0x20031B
> +#define HID_USAGE_SENSOR_PROP_FLUSH_FIFO_EVENTS			0x20031C
> +
>  /* Per data field properties */
>  #define HID_USAGE_SENSOR_DATA_MOD_NONE					0x00
>  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		0x1000
> 

