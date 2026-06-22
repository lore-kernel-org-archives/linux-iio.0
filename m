Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C85E3128B8;
	Mon, 22 Jun 2026 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148064; cv=none; b=ADaGm/BW/kIJEF63903KOd+93oU3KY9ihjZb6NcpUqmbCv3cIB7UmOzN+bs8Jfa/+UxHvSgPHC+/3Npg030Wq1CExmosibZ3jSVbC14mk39o0iZzlmgsQwc2YqwSIsZAgXKzQ9UmbqLAZWxwJs4VRKJR0KvDiNAZwyFocn90J8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148064; c=relaxed/simple;
	bh=rk5oTXt+kPbP1v2rv76tTIYpl2VT+0stJsBPM3BPE34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmH4s+C5eXK4TtWvE+NRli8ezTlmt7I52HPigj1R5NxkbqfK++u3IcloVQU9Rn+O5lEq0IrJWN6neOeEuGYFqKontss4lK0i5EctAPaJOD68blpvrTqZeS/HUwHrkEFvzrLDkzXKhTGvSl/UckHFpJn/GonfonSkUzZ56i2xi8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv6fzCiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv6fzCiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A5C1F000E9;
	Mon, 22 Jun 2026 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148062;
	bh=TIOc4EZIcnfL8MMSPq6oZ8498vE1w7CZ5ipv3RaLpEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hv6fzCiGwPoY/UC9bzJGkpyLMQ7VWa9Q4NLhaYIb/5G8yox7OFP4CsXUX15OjCsCh
	 0F3wyu+19FyfKT5wg+LkLr/eJbUF3orFoR7LLBuvOFsL6i1geeo7z5l+oO6OMUVafM
	 NVHFrgsW5se/ewSmo5F6iUINMQ3tZUmNZfpMd+LfC7CBT0aYiiYTOycanLsLj9NiRL
	 cPGO60GXaEA6SV12CfvngYQWeg7ThxJ3TrDQEt6BIx3lmgB5MzOKUQz6EudjEeVzt0
	 8bKVFoinBNrWS50ekWXAoHqMsfScqXVLtOYisUhfxYrO9bNXLjg6Bd13Ikb55PmSPA
	 o+QM9+GDY3XUQ==
Date: Mon, 22 Jun 2026 18:07:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v5 6/6] iio: osf: register IIO devices from
 capabilities
Message-ID: <20260622180733.290ac316@jic23-huawei>
In-Reply-To: <20260616072242.3942-7-kimjinseob88@gmail.com>
References: <20260616072242.3942-1-kimjinseob88@gmail.com>
	<20260616072242.3942-7-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 16:22:42 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Register IIO devices for supported Open Sensor Fusion capability entries
> and push received samples into IIO buffers when enabled.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Sashiko had a few comments.  The last one on the unitilialized heap
memory needs a new version of the fix from me.

Hopefully I'll get to that in the next few days,

https://sashiko.dev/#/patchset/20260529121005.1470-1-kimjinseob88%40gmail.com

The one about intermediate build issues (if correct) suggests you didn't
ensure this series builds after each patch. Please make sure to do that
to avoid breaking bisectability of the kernel.

Thanks,

Jonathan

> ---
>  drivers/iio/opensensorfusion/Kconfig    |  11 +-
>  drivers/iio/opensensorfusion/Makefile   |   3 +-
>  drivers/iio/opensensorfusion/osf_core.c | 253 ++++++++++++++++++++--
>  drivers/iio/opensensorfusion/osf_core.h |  52 +++++
>  drivers/iio/opensensorfusion/osf_iio.c  | 275 ++++++++++++++++++++++++
>  drivers/iio/opensensorfusion/osf_iio.h  |  22 ++
>  6 files changed, 586 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
> 
> diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
> index d393eb3aa..8b9376d28 100644
> --- a/drivers/iio/opensensorfusion/Kconfig
> +++ b/drivers/iio/opensensorfusion/Kconfig
> @@ -5,11 +5,10 @@ config OPEN_SENSOR_FUSION
>  	depends on IIO
>  	depends on SERIAL_DEV_BUS
>  	select CRC32
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
>  	help
> -	  Build the Open Sensor Fusion UART receive path.
> +	  Build the Open Sensor Fusion UART IIO driver.
>  
> -	  The driver receives OSF protocol frames over a serdev UART.
> -	  Frames are decoded and validated before being passed to the
> -	  driver core.
> -	  This patch only adds the transport path.
> -	  IIO device registration is added separately.
> +	  The driver receives OSF protocol frames over a serdev UART and
> +	  registers IIO devices for supported capability entries.
Avoid this churn. I wouldn't worry about it being a little forwards
looking when added in the earlier patch and directly go to the final
text.

> diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
> index 137fb7166..61ef55646 100644
> --- a/drivers/iio/opensensorfusion/osf_core.c
> +++ b/drivers/iio/opensensorfusion/osf_core.c

>  
> -static int osf_core_validate_sensor_sample(const struct osf_frame *frame)
> +static int osf_core_register_capabilities(struct osf_device *osf,
> +					  const struct osf_capability_cache *cache)
>  {
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
> +		if (osf_core_capability_is_duplicate(cache, i))
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
> +		osf->iio_dev_count++;

Probably use a designated initializer for this one
		ost->iio_dev[osf->iio_dev_count++] = (struct osf_iio_binding) {
			.sensor_type = ...

		};

Not a problem if the lines are over 80 chars given this should be generally easier
to read.

> +
> +static int osf_core_handle_sensor_sample(struct osf_device *osf,
> +					 const struct osf_frame *frame)
> +{
> +	struct osf_latest_sample *latest;
>  	struct osf_sensor_sample sample;
> +	struct iio_dev *indio_dev;
> +	s32 values[OSF_MAX_SAMPLE_CHANNELS] = { };
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
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return osf_protocol_decode_sensor_sample(frame, &sample);
> +	mutex_lock(&osf->latest_lock);

This may well be better as a scoped_guard()

> +	latest = osf_core_find_latest_sample(osf, sample.sensor_type,
> +					     sample.sensor_index);
> +	if (!latest) {
> +		mutex_unlock(&osf->latest_lock);

scoped_guard() would allow you to return here without worrying
about the manual unlock.

> +		return -E2BIG;
> +	}
> +
> +	memcpy(latest->values, values, sizeof(values));
> +	latest->sensor_type = sample.sensor_type;
> +	latest->sensor_index = sample.sensor_index;
> +	latest->channel_count = sample.channel_count;
> +	latest->sample_format = sample.sample_format;
> +	latest->scale_nano = sample.scale_nano;
> +	latest->sequence = frame->sequence;
> +	latest->timestamp_us = frame->timestamp_us;
> +	latest->valid = true;
> +	osf->last_sequence = frame->sequence;
> +	mutex_unlock(&osf->latest_lock);
> +
> +	indio_dev = osf_core_find_iio_dev(osf, sample.sensor_type,
> +					  sample.sensor_index);
> +	if (!indio_dev)
> +		return 0;
> +
> +	return osf_iio_push_sample(indio_dev, values, sample.channel_count);
>  }

>  
> @@ -73,27 +260,47 @@ int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
>  
>  	switch (frame.message_type) {
>  	case OSF_MSG_SENSOR_SAMPLE:
> -		ret = osf_core_validate_sensor_sample(&frame);
> -		break;
> +		return osf_core_handle_sensor_sample(osf, &frame);
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

See if you can rework original code to reduce the churn here.

> +}
> +
> +int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
> +				u16 sensor_index, unsigned int channel,
> +				s32 *value)
> +{
> +	const struct osf_latest_sample *latest;
> +	unsigned int i;
> +	int ret = -ENODATA;
> +
> +	if (!osf || !value)
> +		return -EINVAL;
> +
> +	mutex_lock(&osf->latest_lock);

Looks like a good place to use guard(mutex)(&osf->latest_lock);
Remember to include cleanup.h

> +	for (i = 0; i < osf->latest_sample_count; i++) {
> +		latest = &osf->latest_samples[i];
> +		if (latest->sensor_type != sensor_type ||
> +		    latest->sensor_index != sensor_index)
> +			continue;
> +
> +		if (!latest->valid || channel >= latest->channel_count)
> +			break;
>  
> -	if (!ret)
> -		osf->last_sequence = frame.sequence;
> +		*value = latest->values[channel];
> +		ret = 0;
With guard, you can return directly here.
> +		break;
> +	}
> +	mutex_unlock(&osf->latest_lock);
This gets handled automatically on leaving scope

Then if you get here you can just do
	return -ENODATA;

>  
>  	return ret;
>  }


> diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
> new file mode 100644
> index 000000000..862a797f4
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_iio.c

> +
> +bool osf_iio_sensor_supported(u16 sensor_type, u16 channel_count)
> +{
> +	return !!osf_iio_find_sensor_spec(sensor_type, channel_count);
The !! is getting used a lot less in modern kernel code. Linus Torvalds
once pointed out how hard it is to read.  Maybe != 0 is clearer and
let the compiler do the optimization if it wants.

> +}
> +
> +const char *osf_iio_sensor_name(u16 sensor_type)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(osf_iio_sensor_specs); i++) {
> +		if (osf_iio_sensor_specs[i].sensor_type == sensor_type)
> +			return osf_iio_sensor_specs[i].name;
> +	}
> +
> +	return NULL;
> +}

> +}


> +
> +int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
> +			unsigned int channel_count)

As you are comparing it with the reported number of channels from spec->channel
count I would match type with that (u16 I think)

> +{
> +	struct osf_iio_state *state = iio_priv(indio_dev);
> +	s64 timestamp;
> +
> +	if (channel_count != state->spec->channel_count)
> +		return -EPROTO;
> +
> +	/* This is only a fast path; IIO rechecks buffer state while pushing. */
> +	if (!iio_buffer_enabled(indio_dev))
> +		return 0;
> +
> +	timestamp = iio_get_time_ns(indio_dev);
> +
> +	return iio_push_to_buffers_with_ts_unaligned(indio_dev, values,
> +						     channel_count * sizeof(*values),
> +						     timestamp);
> +}

