Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA93AB299;
	Thu, 28 May 2026 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978647; cv=none; b=LHkCUCSkgn05dZhWVLyABnL2dYo8JYU8iSUJFvkxS6i4v3saaiAWxHUd3KCRtTScMe3NoZzIByOWbyD7itduSsV1sHLmw9Za4z+HlqqGi5qyn9zNWM5+/EBf1Mdri1wODEl2B+3hZLh8bfn2UhyHJwdray6G4BxV0m3Yg19s4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978647; c=relaxed/simple;
	bh=SAW/pHIb3sgm7DLvgIV/zCIWVKeBh1pGRLCUoqfBCyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTTWdggdoIM4Wfkmb9GAGqHg1GJpYnGDkqRHm5a6ZdzzsZWXnUK5NqJ48nofmgTXewNipGsbrfzJOleP5shO5573QhkN2nXZy7ZwsjSDKfNv0IC46izgo6nvE4t2EQ7fK8GViOHblCavdFrumhV4aNfh3zefUmeT2PX27Rf0l5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbfdG8Vo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbfdG8Vo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07CC1F00A3A;
	Thu, 28 May 2026 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978645;
	bh=XQ2+cFxcJMIapE1cgZCh/reJaFPCKPosigAEDRey0Sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DbfdG8VoyQQZeQMaRjCyzNMHnnRA8HvL3a7uVjJ1WqzVCyjqvBVifHBw2mExZ2yjo
	 rVoYZE7wWFAFu5jF9xvL3otuf9JIdXb5PNCuGUvC9Om243iMStz6P6b3EjrJCWY34b
	 1X7h80jYgDuR44mU5tccMS97OmYCk5QF2G6aE4MsaPwgXgRD9QGjdUWsyo72K1yM60
	 g/VZGX/JfYvTn2/Ag+5D02sdK8Jag0H2iaS3v4F+ujElbbuf1MGhMGzLP+eyhVIavd
	 C1doT0YzJjbfD6MSzw/3durO9GoKjJirxYNMao6QvLLQH1PnDqVXerAdqcrmAGQqJA
	 wcUSZZWURlXNQ==
Date: Thu, 28 May 2026 15:30:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 6/7] iio: osf: register IIO devices from
 capabilities
Message-ID: <20260528153036.3fe67c85@jic23-huawei>
In-Reply-To: <20260524085312.15369-7-kimjinseob88@gmail.com>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
	<20260524085312.15369-7-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 17:53:11 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Register supported IIO devices from the first valid capability report.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Various things inline.


> diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
> index c867b3158..a1e20ede9 100644
> --- a/drivers/iio/opensensorfusion/osf_core.c
> +++ b/drivers/iio/opensensorfusion/osf_core.c
> @@ -5,7 +5,7 @@
>  #include <linux/types.h>
>  
>  #include "osf_core.h"
> -#include "osf_protocol.h"

Why?

> +#include "osf_iio.h"
>  
>  #define OSF_RESERVED_MSG_FIRST		0x7f00
>  #define OSF_RESERVED_MSG_LAST		0x7fff

> +
> +static bool osf_core_capability_duplicate(const struct osf_capability_cache *cache,

This sounds like it makes a duplicate.  Rename to _isduplicate() or something like that.

> +					  unsigned int index)
> +{
> +	const struct osf_capability_entry *entry = &cache->entries[index];
> +	unsigned int i;
> +
> +	for (i = 0; i < index; i++) {
> +		if (!osf_iio_sensor_supported(cache->entries[i].sensor_type,
> +					      cache->entries[i].channel_count))
> +			continue;
> +
> +		if (cache->entries[i].sensor_type == entry->sensor_type &&
> +		    cache->entries[i].sensor_index == entry->sensor_index)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int osf_core_register_capabilities(struct osf_device *osf,
> +					  const struct osf_capability_cache *cache)
> +{
> +	struct iio_dev *indio_dev;
> +	unsigned int i;
> +	int ret;
> +
> +	if (osf->capability_cache.valid)
> +		return 0;
> +
> +	for (i = 0; i < cache->capability_count; i++) {
> +		if (!osf_iio_sensor_supported(cache->entries[i].sensor_type,
> +					      cache->entries[i].channel_count))
> +			continue;
> +
> +		if (osf_core_capability_duplicate(cache, i))
> +			return -EEXIST;
> +	}
> +
> +	for (i = 0; i < cache->capability_count; i++) {
> +		if (!osf_iio_sensor_supported(cache->entries[i].sensor_type,
> +					      cache->entries[i].channel_count))
> +			continue;
> +
> +		ret = osf_iio_register_sensor(osf->dev, &cache->entries[i],
> +					      osf, &indio_dev);
> +		if (ret)
> +			goto err_unregister;
> +
> +		osf->iio_devs[osf->iio_dev_count].sensor_type =
> +			cache->entries[i].sensor_type;
> +		osf->iio_devs[osf->iio_dev_count].sensor_index =
> +			cache->entries[i].sensor_index;
> +		osf->iio_devs[osf->iio_dev_count].indio_dev = indio_dev;

Another place a designated intializer makes sense I think. See below for
other examples.

> +		osf->iio_dev_count++;
> +	}
> +
> +	return 0;
> +
> +err_unregister:
> +	osf_core_unregister_iio(osf);
> +
> +	return ret;
>  }
>  
> -static int osf_core_validate_sensor_sample(const struct osf_frame *frame)
> +static int osf_core_handle_sensor_sample(struct osf_device *osf,
> +					 const struct osf_frame *frame)
>  {
> +	struct osf_latest_sample *latest;
>  	struct osf_sensor_sample sample;
> +	struct iio_dev *indio_dev;
> +	unsigned int i;
> +	int ret;
>  
> -	return osf_protocol_decode_sensor_sample(frame, &sample);
> +	ret = osf_protocol_decode_sensor_sample(frame, &sample);
> +	if (ret)
> +		return ret;
> +
> +	if (sample.channel_count > OSF_MAX_SAMPLE_CHANNELS)
> +		return -E2BIG;
> +
> +	latest = osf_core_find_latest_sample(osf, sample.sensor_type,
> +					     sample.sensor_index);
> +	if (!latest)
> +		return -E2BIG;
> +
> +	for (i = 0; i < sample.channel_count; i++) {
> +		ret = osf_protocol_sensor_sample_value(&sample, i,
> +						       &latest->values[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (; i < OSF_MAX_SAMPLE_CHANNELS; i++)
> +		latest->values[i] = 0;
> +
> +	latest->sensor_type = sample.sensor_type;
> +	latest->sensor_index = sample.sensor_index;
> +	latest->channel_count = sample.channel_count;
> +	latest->sample_format = sample.sample_format;
> +	latest->scale_nano = sample.scale_nano;
> +	latest->sequence = frame->sequence;
> +	latest->timestamp_us = frame->timestamp_us;
> +	latest->valid = true;

Maybe reorder so yo ucan use a designated initializer.
Technically it will zero the values before you then fill them, but the
code is a fair bit simpler.

> +	osf->last_sequence = frame->sequence;
> +
> +	indio_dev = osf_core_find_iio_dev(osf, sample.sensor_type,
> +					  sample.sensor_index);
> +	if (indio_dev) {
I'd flip
	if (!indio_dev)
		return 0; /* Nothing to do */

> +		ret = osf_iio_push_sample(indio_dev, latest->values,
> +					  latest->channel_count);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  
> -static int osf_core_validate_device_status(const struct osf_frame *frame)
> +static int osf_core_handle_device_status(struct osf_device *osf,
> +					 const struct osf_frame *frame)
>  {
> +	struct osf_status_cache cache = { };
>  	struct osf_device_status status;
>  	int ret;
>  
> @@ -40,12 +194,22 @@ static int osf_core_validate_device_status(const struct osf_frame *frame)
>  	if (status.reserved)
>  		return -EPROTO;
>  
> +	cache.uptime_s = status.uptime_s;
> +	cache.status_flags = status.status_flags;
> +	cache.error_flags = status.error_flags;
> +	cache.dropped_frames = status.dropped_frames;
> +	cache.sequence = frame->sequence;
> +	cache.valid = true;
> +	osf->status_cache = cache;
	osf->status_cache = (struct osf_status_cache) {
		.uptime_s = status.update_s;
	};



> +	osf->last_sequence = frame->sequence;
> +
>  	return 0;
>  }
>  

>  
> @@ -81,27 +265,47 @@ int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
>  
>  	switch (frame.message_type) {
>  	case OSF_MSG_SENSOR_SAMPLE:
> -		ret = osf_core_validate_sensor_sample(&frame);
> -		break;
> +		return osf_core_handle_sensor_sample(osf, &frame);

Seems like these changes belong in the earlier patch? Can you refactor
that to avoid having to modify it here.

>  	case OSF_MSG_DEVICE_STATUS:
> -		ret = osf_core_validate_device_status(&frame);
> -		break;
> +		return osf_core_handle_device_status(osf, &frame);
>  	case OSF_MSG_CAPABILITY_REPORT:
> -		ret = osf_core_validate_capability_report(&frame);
> -		break;
> +		return osf_core_handle_capability_report(osf, &frame);
>  	default:
>  		if (frame.message_type >= OSF_RESERVED_MSG_FIRST &&
>  		    frame.message_type <= OSF_RESERVED_MSG_LAST)
> -			ret = 0;
> -		else if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
> -			ret = 0;
> -		else
> -			ret = -EOPNOTSUPP;
> -		break;
> +			return 0;
> +		if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
> +			return 0;
> +		return -EOPNOTSUPP;
>  	}
> +}
>  
> -	if (!ret)
> -		osf->last_sequence = frame.sequence;
> +int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
> +				u16 sensor_index, unsigned int channel,
> +				s32 *value)
> +{
> +	const struct osf_latest_sample *latest;
> +	unsigned int i;
>  
> -	return ret;
> +	if (!osf || !value)
> +		return -EINVAL;
> +
> +	for (i = 0; i < osf->latest_sample_count; i++) {
> +		latest = &osf->latest_samples[i];
> +		if (latest->sensor_type == sensor_type &&
> +		    latest->sensor_index == sensor_index)
> +			goto found;

I'd put the found block here rather than a goto. That simpler
flow is worth the cost of indent. You can also flip the condition
giving

	for(unsigned int i = 0; i < osf->latest_sample_count; i++) {
		latest = &osf->latest_samples[i];
		if (latest->sensor_type != sensor_type ||
		    latest->sensor_index != sensor_index)
			continue;

		if (!latest->valid)
			return -ENODATA;
		if (channel >= latest->channel_count)
			return -ENODATA;
	
		*value = latest->values[channel];

		return 0;
	}

	return -ENODATA;

> +	}
> +
> +	return -ENODATA;
> +
> +found:
> +	if (!latest->valid)
> +		return -ENODATA;
> +	if (channel >= latest->channel_count)
> +		return -ENODATA;
> +
> +	*value = latest->values[channel];
> +
> +	return 0;
>  }
> diff --git a/drivers/iio/opensensorfusion/osf_core.h b/drivers/iio/opensensorfusion/osf_core.h
> index 3680c8c9b..e5c0d5081 100644
> --- a/drivers/iio/opensensorfusion/osf_core.h
> +++ b/drivers/iio/opensensorfusion/osf_core.h
> @@ -4,15 +4,64 @@
>  
>  #include <linux/types.h>
>  
> +#include "osf_protocol.h"
> +
> +#define OSF_MAX_SAMPLE_CHANNELS	3
> +#define OSF_MAX_CAPABILITIES	16
> +
>  struct device;
> +struct iio_dev;
> +
> +struct osf_latest_sample {
> +	u16 sensor_type;
> +	u16 sensor_index;
> +	u16 channel_count;
> +	u16 sample_format;
> +	u32 scale_nano;
> +	s32 values[OSF_MAX_SAMPLE_CHANNELS];
> +	u64 sequence;
> +	u64 timestamp_us;

Some of each of these comes from an existing structure reflecting what we
read from the device, can we use that structure embedded her instead of having
to copy field by field?

> +	bool valid;
> +};
> +
> +struct osf_capability_cache {
> +	u16 capability_count;
> +	struct osf_capability_entry entries[OSF_MAX_CAPABILITIES];
> +	u64 sequence;
> +	bool valid;
> +};
> +
> +struct osf_status_cache {
> +	u32 uptime_s;
> +	u32 status_flags;
> +	u32 error_flags;
> +	u32 dropped_frames;
> +	u64 sequence;
> +	bool valid;
> +};

> diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
> new file mode 100644
> index 000000000..1f82ec063
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_iio.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/kernel.h>

Neither device.h nor kernel.h should be included in a driver, unless you
are using one of the few definitions that need them. Typically there are more
focused include like dev_printk.h which should be used instead.

> +#include <linux/types.h>
> +#include <linux/units.h>

> +
> +#define OSF_SCAN_TYPE_S32						\
> +	{								\
> +		.sign = 's',						\
> +		.realbits = 32,					\
> +		.storagebits = 32,					\
> +		.endianness = IIO_CPU,					\
> +	}
> +
> +#define OSF_MOD_CHAN(_type, _mod, _idx)				\
> +	{								\
> +		.type = (_type),					\
> +		.modified = 1,					\
> +		.channel2 = (_mod),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = (_idx),					\
> +		.scan_type = OSF_SCAN_TYPE_S32,			\
> +	}
> +
> +#define OSF_CHAN(_type, _idx)					\
> +	{								\
> +		.type = (_type),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = (_idx),					\
> +		.scan_type = OSF_SCAN_TYPE_S32,			\
> +	}
Only seems likely to be used once. So why have an macro?
Maybe it is useful just to put it next to the others for visual comparison.



> +
> +static const struct iio_chan_spec osf_temp_channels[] = {
> +	OSF_CHAN(IIO_TEMP, 0),
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
> +static const unsigned long osf_3axis_available_scan_masks[] = {
> +	GENMASK(2, 0),
> +	0,

As below.

> +};
> +
> +static const unsigned long osf_temp_available_scan_masks[] = {
> +	BIT(0),
> +	0,
0 is a terminating entry so no trailing comma.
> +};


> +
> +static int osf_iio_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct osf_iio_state *state = iio_priv(indio_dev);
> +	s32 raw;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!state->osf)
> +			return -ENODATA;
> +
> +		if (chan->scan_index < 0)
> +			return -EINVAL;

If this isn't needed to silence a compiler or similar warning: we control
that value in the driver so should know if this can happen or not.
So probably not needed.

> +
> +		ret = osf_core_read_latest_sample(state->osf,
> +						  state->spec->sensor_type,
> +						  state->sensor_index,
> +						  chan->scan_index, &raw);
> +		if (ret)
> +			return ret;
> +
> +		*val = raw;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = state->scale_nano / NANO;
> +		*val2 = state->scale_nano % NANO;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +void osf_iio_unregister_sensor(struct iio_dev *indio_dev)
> +{
> +	struct osf_iio_state *state;
> +
> +	if (!indio_dev)

If you are unregistering something that is null something went wrong
probably.  Seems unlikely we need this defence.

> +		return;
> +
> +	state = iio_priv(indio_dev);

Then this can be done at declaration above.

> +	iio_device_unregister(indio_dev);
> +	iio_kfifo_free(state->buffer);
> +	iio_device_free(indio_dev);
> +}
> +
> +int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
> +			unsigned int channel_count)
> +{
> +	s64 timestamp;
> +
> +	if (!iio_buffer_enabled(indio_dev))

Add a comment on what the race is (I assume) that gets us here with that not set.

> +		return 0;
> +
> +	timestamp = iio_get_time_ns(indio_dev);
> +
> +	return iio_push_to_buffers_with_ts_unaligned(indio_dev, values,
> +						     channel_count * sizeof(*values),
> +						     timestamp);
> +}

