Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79D33B6EA;
	Fri, 22 May 2026 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467106; cv=none; b=Yw4PaidGAqJeKg86TJxiniumo4uvaUjEmQNmx6NphWi18d91atTJ8v15E+XNhJlOeqWOHL1+of2Q9/f94MTKBLOxAKyvNp2zFPcU/0/iEXKMYHbVbVSlT6+nvNQKI11p/G7QeYLpr6OEomyhN/l3Z29boM7Xa13jxZxvKc1DyuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467106; c=relaxed/simple;
	bh=3A8m4L7zSETAtul1bx7ime4o3+oDmRFRfzsW1RpJwyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRAAnBWu+dgBsGzjqMAVhUHETUlnKbnw7TOYS3rTfl8sRnGAPL0Xr8lH/yLwkV/fDhhfxpmE7/huwgCp47NCDfMrYjKIMZTD/m6tnp9Ifhz0Tu2vtfxK3BtwEoSgeCgbH+zRwgZ2/L+doNVAaOYT0gMEImQqe4axoYtPQs4LL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABWGLSvm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABWGLSvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18AD1F000E9;
	Fri, 22 May 2026 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779467102;
	bh=C7nB2dPvaNLIcHSoR0v2pv4XLMFug6YdPyrw5q/eXK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ABWGLSvml96JA1hHnt3+HW5LJcLibcUXP7BYpYLtNDdxNVaY1KLy4W5jB+pkPNUWM
	 h4/59luEGKGVYzIw7LdptdkK7N0sdAheAr2GzpJsWI4n2fWpJC7u0iA18wFnGMNV4d
	 EUwO18sow5zwNl+EWUZxbH1rQQ/tuHuMP5rhzWJp0rLNTO1CL1FjHZbZeWxtrCT3M5
	 eVCARoMEGDyFVB5prF+wR2D+qfKqZHkYPOUHulidHbAjG6VTJw/oub+vOMyyiaM1va
	 qd+VCjgNyOcMVFv6Hzoipir6E0mXb/8yI0xy1R94NM4c5B36DubB4jA3YBmAlFNpbD
	 a4SwewM8eLADA==
Date: Fri, 22 May 2026 17:24:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] iio: osf: add Open Sensor Fusion UART IIO
 driver
Message-ID: <20260522172453.3564af85@jic23-huawei>
In-Reply-To: <20260520072843.3593-3-kimjinseob88@gmail.com>
References: <20260520072843.3593-1-kimjinseob88@gmail.com>
	<20260520072843.3593-3-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 16:28:42 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add the initial Open Sensor Fusion UART IIO driver.
> 
> This includes the protocol v0 parser, OSF0 stream assembler, core
> capability/sample cache, serdev UART transport, IIO read_raw path, and
> software kfifo buffer support.
> 
> The first RFC keeps the driver code in one patch to avoid intermediate
> non-buildable states. The internal files still separate protocol, stream,
> core, transport, and IIO code.
> 
> The tested path is STM32F405 test firmware OSF UART stream to Raspberry Pi
> serdev, then IIO read_raw and buffered userspace reads.
> 
> Not included here: real sensor reads, USB transport, fusion/AHRS/Kalman,
> runtime capability removal, or production timestamp correlation.
> 
There are several things in here I don't follow.  Why do we not
push the data directly to the iio devices when it shows up?
There seems to be a queue in between that I don't understand the purpose
of - that just seems to mean async handling where synchronous should
be fine.

Anyhow, as I mentioned this review is somewhat superficial given the driver
needs a lot of work to get it into a more reviewable state.
In particular break it up into more sensible sized chunks, building up
functionality from device discovery to actually registering IIO devices and then
adding additional features on that base.

> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

> diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
> new file mode 100644
> index 000000000..fd2eccefc
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_core.c
> @@ -0,0 +1,334 @@

> +
> +static int osf_core_handle_sensor_sample(struct osf_device *osf,
> +					 const struct osf_frame *frame)
> +{
> +	osf_sample_callback_t callback;
> +	void *callback_context;
> +	struct osf_latest_sample *latest;
> +	struct osf_sample_event event = { };
> +	struct osf_sensor_sample sample;
> +	s32 values[OSF_MAX_SAMPLE_CHANNELS] = { };
> +	unsigned long flags;
> +	unsigned int i;
> +	int ret;
> +
> +	ret = osf_protocol_decode_sensor_sample(frame, &sample);
> +	if (ret)
> +		return ret;
> +
> +	if (sample.channel_count > OSF_MAX_SAMPLE_CHANNELS)
> +		return -E2BIG;
> +
> +	for (i = 0; i < sample.channel_count; i++) {
> +		ret = osf_protocol_sensor_sample_value(&sample, i, &values[i]);
This converts to CPU endian. That's fine but then your channels aren't little endian.
> +		if (ret)
> +			return ret;
> +	}
> +
> +	event.sensor_type = sample.sensor_type;
> +	event.sensor_index = sample.sensor_index;
> +	event.channel_count = sample.channel_count;
> +	event.sample_format = sample.sample_format;
> +	event.scale_nano = sample.scale_nano;
> +	event.sequence = frame->sequence;
> +	event.timestamp_us = frame->timestamp_us;
> +	event.host_timestamp_ns = ktime_get_ns();

For IIO stuff we have (for weird historical reasons) rather complex clock
handling for timestamps. Please follow that.

> +	for (i = 0; i < sample.channel_count; i++)
> +		event.values[i] = values[i];
> +
> +	spin_lock_irqsave(&osf->lock, flags);
> +	latest = osf_core_find_latest_sample(osf, sample.sensor_type,
> +					     sample.sensor_index, true);
> +	if (!latest) {
> +		spin_unlock_irqrestore(&osf->lock, flags);
> +		return -ENOSPC;
> +	}
> +
> +	osf_core_store_latest_sample(latest, &sample, values, frame);
> +	osf_core_store_latest_sample(&osf->latest_sample, &sample, values,
> +				     frame);
> +	osf->last_sequence = frame->sequence;
> +	callback = osf->sample_callback;
> +	callback_context = osf->sample_callback_context;
> +	spin_unlock_irqrestore(&osf->lock, flags);
> +
> +	if (callback)
> +		callback(callback_context, &event);
> +
> +	return 0;
> +}

> +
> +int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
> +				u16 sensor_index, unsigned int channel,
> +				s32 *value)
> +{
> +	const struct osf_latest_sample *latest;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!osf || !value)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&osf->lock, flags);

Use guard() and see if you can relax to a mutex. I haven't really worked
out the flow in here yet so maybe you can't.

> +	latest = osf_core_find_latest_sample(osf, sensor_type,
> +					     sensor_index, false);
> +	if (!latest)
> +		latest = &osf->latest_sample;
> +
> +	if (!latest->valid) {
> +		ret = -ENODATA;
> +		goto out_unlock;
> +	}
> +
> +	if (latest->sensor_type != sensor_type ||
> +	    latest->sensor_index != sensor_index) {
> +		ret = -ENODATA;
> +		goto out_unlock;
> +	}
> +
> +	if (channel >= latest->channel_count) {
> +		ret = -ENODATA;
> +		goto out_unlock;
> +	}
> +
> +	*value = latest->values[channel];
> +
> +out_unlock:
> +	spin_unlock_irqrestore(&osf->lock, flags);
> +
> +	return ret;
> +}

> +
> +bool osf_core_capability_sequence(struct osf_device *osf, u64 *sequence)
> +{
> +	unsigned long flags;
> +	bool valid;
> +
> +	if (!osf || !sequence)
> +		return false;
> +
> +	spin_lock_irqsave(&osf->lock, flags);
> +	valid = osf->capability_cache.valid;
> +	if (valid)
> +		*sequence = osf->capability_cache.sequence;
use guard() above
and 	if (valid)
		return false;

	*sequence = ..
	return true;

That way the 'error' path is out of line and can be quickly ignored by readers.
> +	spin_unlock_irqrestore(&osf->lock, flags);
> +
> +	return valid;
> +}
> +
> +void osf_core_set_sample_callback(struct osf_device *osf,
> +				  osf_sample_callback_t callback,
> +				  void *context)
> +{
> +	unsigned long flags;
> +
> +	if (!osf)
> +		return;
> +
> +	spin_lock_irqsave(&osf->lock, flags);
Use guard() for these probably.
> +	osf->sample_callback = callback;
> +	osf->sample_callback_context = context;
> +	spin_unlock_irqrestore(&osf->lock, flags);
> +}
> +
> +static int __init osf_core_init(void)
> +{
> +	return osf_serdev_register_driver();
> +}
> +
> +static void __exit osf_core_exit(void)
> +{
> +	osf_serdev_unregister_driver();
> +}
This smells like code break out not making sense. I'd
expect to see the driver_structure right next to these.

> +
> +module_init(osf_core_init);
> +module_exit(osf_core_exit);

> diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
> new file mode 100644
> index 000000000..3d2674e43
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_iio.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +
> +#include "osf_core.h"
> +#include "osf_iio.h"
> +
> +#define OSF_SCALE_NANO		1000000000U
NANO is defined in the kernel headers.

> +#define OSF_IIO_SCAN_BYTES						\
> +	(ALIGN(OSF_MAX_SAMPLE_CHANNELS * sizeof(s32), sizeof(s64)) +	\
> +	 sizeof(s64))
> +
> +struct osf_iio_sensor_spec {
> +	u16 sensor_type;
> +	u16 channel_count;
> +	const char *name;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};
> +
> +struct osf_iio_state {
> +	const struct osf_iio_sensor_spec *spec;
> +	u32 scale_nano;
> +	u16 sensor_index;
> +	struct osf_device *osf;
> +};


> +int osf_iio_push_sample(struct iio_dev *indio_dev,
> +			const struct osf_sample_event *event)
> +{
> +	struct osf_iio_state *state;
> +	u8 scan[OSF_IIO_SCAN_BYTES] __aligned(8) = { };
we have macros for this. 
IIO_DECLARE_BUFFER_WITH_TS() which will give you a suitable sized
s32 array so you don't need the cast that follows.

Mind you the buffer is described as little endian so maybe
should be __le32


> +	s32 *scan_values = (s32 *)scan;
> +	unsigned int i;
> +
> +	if (!indio_dev || !event)
> +		return -EINVAL;
> +
> +	if (!iio_buffer_enabled(indio_dev))

I haven't checked, but this feels insufficient. Probably want to force the
device to stay in buffered mode.  iio_device_try_claim_buffer_mode()
(rarely used, but this may be one place that needs it).


> +		return 0;
> +
> +	state = iio_priv(indio_dev);
> +	if (event->sensor_type != state->spec->sensor_type ||
> +	    event->sensor_index != state->sensor_index)
> +		return -EINVAL;
> +
> +	if (event->sample_format != OSF_SAMPLE_FORMAT_S32 ||
> +	    event->channel_count != state->spec->channel_count ||
> +	    event->channel_count > OSF_MAX_SAMPLE_CHANNELS)
> +		return -EINVAL;
> +
> +	for (i = 0; i < event->channel_count; i++)
> +		scan_values[i] = event->values[i];
> +
> +	return iio_push_to_buffers_with_timestamp(indio_dev, scan,
> +						  event->host_timestamp_ns);

For new code iio_push_to_buffers_with_ts()   It has a bounds check that
this version doesn't have.

> +}
> +
> +int osf_iio_register_sensor(struct device *dev,
> +			    const struct osf_capability_entry *entry,
> +			    void *driver_data, struct iio_dev **indio_dev)
> +{
> +	const struct osf_iio_sensor_spec *spec;
> +	struct osf_iio_state *state;
> +	struct iio_dev *iio_dev;
> +	int ret;
> +
> +	if (!dev || !entry)
> +		return -EINVAL;
> +
> +	spec = osf_iio_find_sensor_spec(entry->sensor_type,
> +					entry->channel_count);
> +	if (!spec)
> +		return -EOPNOTSUPP;
> +
> +	if (entry->sample_format != OSF_SAMPLE_FORMAT_S32)
> +		return -EOPNOTSUPP;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	state = iio_priv(iio_dev);
> +	state->spec = spec;
> +	state->scale_nano = entry->scale_nano;
> +	state->sensor_index = entry->sensor_index;
> +	state->osf = driver_data;
> +
> +	iio_dev->name = spec->name;

What does this end up as?  Should be something close to a part number
though in multifunction parts can include something about the type.

> +	iio_dev->info = &osf_iio_info;
> +	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;

Look at devm_iio_kfifo_buffer_setup() and what it does to this.

> +	iio_dev->channels = spec->channels;
> +	iio_dev->num_channels = spec->num_channels;
> +
> +	ret = devm_iio_kfifo_buffer_setup(dev, iio_dev, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, iio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (indio_dev)
> +		*indio_dev = iio_dev;

why would you call this function without?
For kernel code we don't defined against nonsensical parameters.
Catch those in review rather than complicating the code.

> +
> +	return 0;
> +}

> +#endif
> diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/opensensorfusion/osf_protocol.c
> new file mode 100644
> index 000000000..8235d3af5
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_protocol.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/crc32.h>
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +
> +#include "osf_protocol.h"
> +
> +#define OSF_CRC32_INIT		0xffffffffU
> +#define OSF_CRC32_XOROUT	0xffffffffU
GENMASK(31, 0)

No one likes counting fs.
> +
> +static u16 osf_get_le16(const u8 *buf)
> +{
> +	return buf[0] | buf[1] << 8;
> +}
> +
> +static u32 osf_get_le32(const u8 *buf)
> +{
> +	return (u32)buf[0] | (u32)buf[1] << 8 |
> +	       (u32)buf[2] << 16 | (u32)buf[3] << 24;
> +}
Another copy?  See comments on the one in osf_stream.c

> +
> +static u64 osf_get_le64(const u8 *buf)
> +{
> +	return (u64)osf_get_le32(buf) | (u64)osf_get_le32(buf + 4) << 32;
Looks like
get_unaligned_le64()?


> +}
>

> +int osf_protocol_decode_capability_entry(const struct osf_capability_report *report,
> +					 unsigned int index,
> +					 struct osf_capability_entry *entry)
> +{
> +	const u8 *payload;
> +
> +	if (!report || !report->entries || !entry)
> +		return -EINVAL;
> +
> +	if (index >= report->capability_count)
> +		return -ERANGE;
> +
> +	payload = report->entries + index * OSF_CAP_SENSOR_ENTRY_LEN;
> +	entry->sensor_type = osf_get_le16(payload);
> +	entry->sensor_index = osf_get_le16(payload + 2);
> +	entry->channel_count = osf_get_le16(payload + 4);
> +	entry->sample_format = osf_get_le16(payload + 6);
> +	entry->scale_nano = osf_get_le32(payload + 8);
> +	entry->flags = osf_get_le32(payload + 12);
> +	entry->reserved = osf_get_le32(payload + 16);

Easier to read as
	*entry = (struct osf_capability_entry) {
		.sensor_type = get_unaligned_le16(payload),
		.sensor_index = get_unaligned_le16(payload + 2),
	....

	};

Probably can apply similar in other places.

> +
> +	if (!osf_sensor_type_valid(entry->sensor_type))
> +		return -EPROTO;
> +
> +	if (entry->sample_format != OSF_SAMPLE_FORMAT_S32)
> +		return -EPROTO;
> +
> +	if (entry->flags & ~OSF_CAPABILITY_FLAGS_MASK)
> +		return -EPROTO;
> +
> +	if (entry->reserved)
> +		return -EPROTO;
> +
> +	return 0;
> +}


> diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/opensensorfusion/osf_serdev.c
> new file mode 100644
> index 000000000..1827760c2
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_serdev.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/atomic.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>

Not seeing this used. Maybe I missed something of specific.
I wouldn't expect there to be anything in a driver like this.


> +#include <linux/serdev.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>


> +
> +static int osf_serdev_register_iio(struct osf_serdev *osf_uart,
> +				   const struct osf_capability_entry *entry)
> +{
> +	struct device *dev = &osf_uart->serdev->dev;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (osf_serdev_iio_registered(osf_uart, entry))
> +		return 0;
> +
> +	if (!osf_iio_sensor_supported(entry->sensor_type, entry->channel_count) ||
> +	    entry->sample_format != OSF_SAMPLE_FORMAT_S32) {
> +		dev_dbg(dev,
> +			"ignoring unsupported capability sensor=%u index=%u channels=%u format=%u\n",
> +			entry->sensor_type, entry->sensor_index,
> +			entry->channel_count, entry->sample_format);
> +		return 0;
> +	}
> +
> +	if (osf_uart->iio_count >= ARRAY_SIZE(osf_uart->iio)) {
> +		dev_warn(dev, "IIO registration table full, ignoring sensor=%u index=%u\n",
> +			 entry->sensor_type, entry->sensor_index);
> +		return 0;
> +	}
> +
> +	ret = osf_iio_register_sensor(dev, entry, &osf_uart->osf, &indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	osf_uart->iio[osf_uart->iio_count].sensor_type = entry->sensor_type;
> +	osf_uart->iio[osf_uart->iio_count].sensor_index = entry->sensor_index;
> +	osf_uart->iio[osf_uart->iio_count].indio_dev = indio_dev;

	osf_uart->iio[osf_uart->iio_count++] = (struct osf_serdev_iio) {
		.sensor_type = entry->sensor_type,
		.sensor_index = entry->sensor_index,
		.indio_dev = indio_dev,
	};

> +	osf_uart->iio_count++;
> +
> +	return 1;
> +}
> +
> +static void osf_serdev_iio_register_work(struct work_struct *work)
> +{
> +	struct osf_serdev *osf_uart =
> +		container_of(work, struct osf_serdev, iio_register_work);
> +	struct device *dev = &osf_uart->serdev->dev;
> +	struct osf_capability_cache cache;
> +	unsigned int registered = 0;
> +	unsigned int i;
> +	int ret;
> +
> +	if (!osf_core_copy_capability_cache(&osf_uart->osf, &cache))
> +		return;
> +
> +	mutex_lock(&osf_uart->iio_lock);
I'd use guard(mutex)(); here

> +	for (i = 0; i < cache.capability_count; i++) {
> +		ret = osf_serdev_register_iio(osf_uart, &cache.entries[i]);
> +		if (ret) {
> +			if (ret > 0) {
> +				registered++;
> +				continue;
> +			}
> +
			Then

			if (ret < 0) {
				dev_err();
				return ret;
			}

			registered++;

> +			dev_err(dev,
> +				"failed to register IIO sensor=%u index=%u: %d\n",
> +				cache.entries[i].sensor_type,
> +				cache.entries[i].sensor_index, ret);
> +		}
> +	}
> +	mutex_unlock(&osf_uart->iio_lock);
> +
> +	if (registered)
With above, this only doesn't happen if the count was 0.  Maybe check that separately
so you can then do this unconditionally.

> +		dev_info(dev,
> +			 "registered %u Open Sensor Fusion IIO devices from capability report seq=%llu\n",
> +			 registered, (unsigned long long)cache.sequence);
> +}

> +
> +static int osf_serdev_probe(struct serdev_device *serdev)
> +{
> +	struct osf_serdev *osf_uart;
> +	unsigned int baudrate;
> +	int ret;
> +
> +	osf_uart = devm_kzalloc(&serdev->dev, sizeof(*osf_uart), GFP_KERNEL);
> +	if (!osf_uart)
> +		return -ENOMEM;
> +
> +	osf_uart->serdev = serdev;
> +	osf_core_init_device(&osf_uart->osf);
> +	osf_stream_init(&osf_uart->stream, &osf_uart->osf);
> +	INIT_WORK(&osf_uart->iio_register_work, osf_serdev_iio_register_work);
> +	INIT_WORK(&osf_uart->buffer_push_work, osf_serdev_buffer_push_work);
> +	mutex_init(&osf_uart->iio_lock);
> +	spin_lock_init(&osf_uart->sample_lock);
> +	atomic64_set(&osf_uart->capability_sequence_scheduled, -1);
> +	osf_core_set_sample_callback(&osf_uart->osf, osf_serdev_sample_ready,
> +				     osf_uart);
> +
> +	serdev_device_set_drvdata(serdev, osf_uart);
> +	serdev_device_set_client_ops(serdev, &osf_serdev_ops);
> +
> +	ret = serdev_device_open(serdev);
> +	if (ret)
> +		return ret;
> +
> +	baudrate = serdev_device_set_baudrate(serdev, OSF_SERDEV_BAUD);
> +	if (baudrate != OSF_SERDEV_BAUD)
> +		dev_warn(&serdev->dev, "requested %u baud, controller set %u\n",
> +			 OSF_SERDEV_BAUD, baudrate);
> +
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	dev_info(&serdev->dev, "Open Sensor Fusion UART opened at %u baud\n",
> +		 OSF_SERDEV_BAUD);

Generally we try to avoid prints like this.  Is it useful to know the baud rate?
It's easy to tell if the rest worked.

> +
> +	return 0;
> +}
> +
> +static void osf_serdev_remove(struct serdev_device *serdev)
> +{
> +	struct osf_serdev *osf_uart = serdev_device_get_drvdata(serdev);
> +
> +	osf_core_set_sample_callback(&osf_uart->osf, NULL, NULL);
> +	serdev_device_close(serdev);
> +	cancel_work_sync(&osf_uart->iio_register_work);
> +	cancel_work_sync(&osf_uart->buffer_push_work);
> +	osf_stream_reset(&osf_uart->stream);
> +}

> +
> +int osf_serdev_register_driver(void)
> +{
> +	return serdev_device_driver_register(&osf_serdev_driver);
> +}
> +
> +void osf_serdev_unregister_driver(void)
> +{
> +	serdev_device_driver_unregister(&osf_serdev_driver);
> +}
As above, feels like the file break up is making this more complex.
These should be next to module_init and allow us of the macros
that generate that code for us.


> +#endif
> diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/opensensorfusion/osf_stream.c
> new file mode 100644
> index 000000000..e9addf70e
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_stream.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "osf_core.h"
> +#include "osf_protocol.h"
> +#include "osf_stream.h"
> +
> +#define OSF_STREAM_MAGIC_LEN	4
> +#define OSF_STREAM_MAX_PAYLOAD_LEN				\
> +	(OSF_STREAM_MAX_FRAME_LEN - OSF_FRAME_HEADER_LEN - OSF_FRAME_CRC_LEN)
> +
> +static const u8 osf_stream_magic[OSF_STREAM_MAGIC_LEN] = {
> +	'O', 'S', 'F', '0',
> +};
> +
> +static u16 osf_stream_get_le16(const u8 *buf)
> +{
> +	return buf[0] | buf[1] << 8;
We have standard functions in the kernel for this. Don't reinvent the wheel.

get_unaligned_le16()

> +}
> +
> +static u32 osf_stream_get_le32(const u8 *buf)

Likewise.

> +{
> +	return (u32)buf[0] | (u32)buf[1] << 8 |
> +	       (u32)buf[2] << 16 | (u32)buf[3] << 24;
> +}

> +
> +static bool osf_stream_magic_match(const u8 *buf, size_t len)
> +{
> +	return !memcmp(buf, osf_stream_magic, len);

Just do this inline.  If it was stand alone the length match
would belong in here not at the caller.


> +}
> +
> +static size_t osf_stream_resync(struct osf_stream *stream)
> +{
> +	size_t old_len = stream->len;
> +	size_t match_len;
> +	size_t i;
> +
> +	for (i = 0; i < stream->len; i++) {
In modern kernel code can do something like:
	for (size_t i = 0; i < stream->len; i++)

> +		match_len = stream->len - i;
> +		if (match_len > OSF_STREAM_MAGIC_LEN)
> +			match_len = OSF_STREAM_MAGIC_LEN;

		match_len = min(match_len, OSF_STREAM_MAGIC_LEN);

> +
> +		if (osf_stream_magic_match(stream->buf + i, match_len)) {
> +			if (i)
> +				osf_stream_discard(stream, i);
I'd special case 0 as that's your 'good' path.
			if (i == 0)
				return 0; 

			osf_stream_discard(stream, i);
			return i;

> +			return i;
> +		}
> +	}
> +
> +	stream->len = 0;
Whilst this is a short cut, I'd still call osf_stream_discard() as then it
is obvious that this is also discarding. Failing that add a comment 
/* Discard the lot */


> +	return old_len;
Why is it useful to return old_len if failed to resync?
That's non obvious enough I think this needs documentation on what
the return value is.

I'd be tempted to return a bool for whether it succeeded and
pass a pointer to put how much was discarded in.  That
will make the condition below simpler.

> +}
> +
> +static int osf_stream_process(struct osf_stream *stream)
> +{
> +	struct osf_frame frame;
> +	size_t decoded_len;
> +	size_t discarded;
> +	size_t frame_len;
> +	u32 payload_len;
> +	int first_err = 0;
> +	int ret;
> +
> +	while (stream->len) {
> +		discarded = osf_stream_resync(stream);
> +		if (discarded) {
> +			stream->stats.bad_magic_resyncs++;
> +			stream->stats.dropped_bytes += discarded;
> +			if (!first_err)
> +				first_err = -EPROTO;
So if we resynced but discarded a few 
> +		}
> +
> +		if (!stream->len)

This took a bit of figuring out. It's the resync failed path. I'd rather
see an explicit return bool for that. The discarded variable can be
parameter as mentioned above.


> +			break;
> +
> +		if (stream->len < OSF_FRAME_HEADER_LEN) {
> +			stream->stats.partial_frames++;
> +			break;
> +		}
> +
> +		if (osf_stream_get_le16(stream->buf + 6) !=

		if (get_unaligned_le16(stream->buf + 6) != OSF_FRAME_HEADER_LEN) {

Slightly long lines are fine in IIO as long as they aren't too much past 80
and improve readability.


> +		    OSF_FRAME_HEADER_LEN) {
> +			stream->stats.dropped_bytes++;
> +			osf_stream_discard(stream, 1);

Needs a comment I think. Not obvious to me at all why you'd drop 1 byte.
Is the idea it forces a resync?  Might as well drop the magic string
in that case.  I'd add a helper for this so you can do something like..

osf_force_resync(stream); in all these cases or something easier
to follow than a 1 byte drop.


> +			if (!first_err)
> +				first_err = -EPROTO;
> +			continue;
> +		}
> +
> +		payload_len = osf_stream_get_le32(stream->buf + 10);

get_unaligned_le32()

> +		if (payload_len > OSF_STREAM_MAX_PAYLOAD_LEN) {
> +			stream->stats.dropped_bytes++;
> +			osf_stream_discard(stream, 1);
> +			if (!first_err)
> +				first_err = -EMSGSIZE;
> +			continue;
> +		}
> +
> +		frame_len = OSF_FRAME_HEADER_LEN + payload_len + OSF_FRAME_CRC_LEN;
> +		if (stream->len < frame_len) {
> +			stream->stats.partial_frames++;
> +			break;
> +		}
> +
> +		ret = osf_protocol_decode_frame(stream->buf, frame_len, &frame,
> +						&decoded_len);
> +		if (ret) {
> +			if (ret == -EBADMSG)
> +				stream->stats.bad_crc_frames++;
> +			stream->stats.dropped_bytes++;
> +			osf_stream_discard(stream, 1);
> +			if (!first_err)
> +				first_err = ret;
> +			continue;
> +		}
> +
> +		if (decoded_len != frame_len) {
> +			stream->stats.dropped_bytes++;
> +			osf_stream_discard(stream, 1);
> +			if (!first_err)
> +				first_err = -EMSGSIZE;
> +			continue;
> +		}
> +
> +		ret = osf_core_receive_frame(stream->osf, stream->buf, frame_len);
> +		if (ret) {
> +			osf_stream_discard(stream, frame_len);
> +			if (!first_err)
> +				first_err = ret;
> +			continue;
> +		}
> +
> +		stream->stats.valid_frames++;
> +		osf_stream_discard(stream, frame_len);
> +	}
> +
> +	return first_err;
> +}
> +
> +void osf_stream_init(struct osf_stream *stream, struct osf_device *osf)
> +{
> +	if (!stream)
> +		return;
> +
> +	stream->osf = osf;
> +	stream->len = 0;
> +	memset(&stream->stats, 0, sizeof(stream->stats));
> +}
> +
> +void osf_stream_reset(struct osf_stream *stream)
> +{
> +	if (stream) {
> +		stream->len = 0;
> +		memset(&stream->stats, 0, sizeof(stream->stats));
> +	}
> +}
> +
> +int osf_stream_receive_bytes(struct osf_stream *stream, const u8 *buf,
> +			     size_t len)
> +{
> +	size_t copy_len;
> +	size_t space;
> +	int first_err = 0;
> +	int ret;
> +
> +	if (!stream || !stream->osf || (!buf && len))
> +		return -EINVAL;
> +
> +	if (!len) {
> +		ret = osf_stream_process(stream);
> +		if (ret && !first_err)
> +			first_err = ret;
> +		return first_err;
> +	}
> +
> +	while (len) {
> +		space = OSF_STREAM_MAX_FRAME_LEN - stream->len;
> +		if (!space) {
> +			stream->stats.dropped_bytes++;
> +			osf_stream_discard(stream, 1);
> +			if (!first_err)
> +				first_err = -EMSGSIZE;
> +			continue;
> +		}
> +
> +		copy_len = len < space ? len : space;
> +		memcpy(stream->buf + stream->len, buf, copy_len);
> +		stream->len += copy_len;
> +		buf += copy_len;
> +		len -= copy_len;
> +
> +		ret = osf_stream_process(stream);
> +		if (ret && !first_err)
> +			first_err = ret;
> +	}
> +
> +	return first_err;
> +}

