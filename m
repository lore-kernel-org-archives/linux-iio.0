Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD13264D8;
	Sun, 31 May 2026 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227790; cv=none; b=ThLdfx4j0kXxVnERmQZQprfcXsqdqU6CIPwcmcVhA2BjAGeSS5IfyKYfTOd+hRO8fO0PQX3yjOlJZVJ8W2yRZmnYwH1xjAqBEKKIDyQvRuJ7c0FuC0VKnOA6SR5jHAa736f21qA2T5NLwadxaSjN20Us8PCBrr9DSVcIiBlWFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227790; c=relaxed/simple;
	bh=qlDsX22ixATQnPJZCLXBaJadQg2Mp8FzYgyXVi6f9D4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAATmvppIFTs+n1XZJc6NO38mU9xdZ/44wY/YC9UsHSapUQ0NanvnIVsA02zUeim/5rF+G/jUEh1MN8RiHOzw8x5/CHuGKtISpOzHb908QUNOfcekByCtR85Zz7OYOWWuBFgQSEJ9MU6fcXjTggh/MmrVT2hXPqvCGxn4+ea1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx3oPL6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx3oPL6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85071F00893;
	Sun, 31 May 2026 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780227788;
	bh=Udwv5iId0KXcQ8Qt92knmjHpT9C5tKvoZRkPbaL0z4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cx3oPL6RVSRUCHNtkm/8Yoyn//WlcCMo3WKbDwY/RwwaqlAdQtHKofaHHGxv2+qDH
	 Ol1XgSLm7Q0ebKSd794uOePoUk9saBL+ZO6jEkkhyafLFlpIllvVaRCjtliGLcaERL
	 d5j1kPEciQQcX14aGSuWYlZGg9b9++qVr2p6U7rTBx0m40r0wBA9Ei07hrwkrdzHXw
	 Wu6aPoYmfuZ6+wRCYz0uzmsG8wn7ihzQs2wj1AA6Frb87XdESBRvw+PEZUCnHqeoP2
	 Cx9T4sR2H0ZYwfMJmVfYJl6Many933pzbSQ3OlPWcHUQlp31yiHQzZNzWnRGpZzNDO
	 l2DvZ0rMZG4DA==
Date: Sun, 31 May 2026 12:42:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 6/6] iio: osf: register IIO devices from
 capabilities
Message-ID: <20260531124259.69941363@jic23-huawei>
In-Reply-To: <20260529121005.1470-7-kimjinseob88@gmail.com>
References: <20260529121005.1470-1-kimjinseob88@gmail.com>
	<20260529121005.1470-7-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 21:10:05 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Use the first capability report to create supported IIO devices.
> 
> Cache latest samples and push enabled buffers directly.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Sahiko spotted an uninitialized heap data leak in the one of the
IIO core functions. I've just sent a patch to fix that.

https://sashiko.dev/#/patchset/20260529121005.1470-1-kimjinseob88%40gmail.com

Thankfully that bounce buffering variant is rarely used so the bug
should affect too many systems.

A few other things inline, but mostly looks pretty good to me.

Jonathan

> diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
> index c867b3158..e0a12de01 100644
> --- a/drivers/iio/opensensorfusion/osf_core.c
> +++ b/drivers/iio/opensensorfusion/osf_core.c
> @@ -5,7 +5,7 @@
>  #include <linux/types.h>
>  
>  #include "osf_core.h"
> -#include "osf_protocol.h"
> +#include "osf_iio.h"
Did this stop using the osf_protocol.h?  Seems unlikely that changed in this
patch. So why drop it?

>  
>  #define OSF_RESERVED_MSG_FIRST		0x7f00
>  #define OSF_RESERVED_MSG_LAST		0x7fff
> @@ -13,23 +13,175 @@
>  
>  void osf_core_init(struct osf_device *osf, struct device *dev)
>  {
> -	memset(osf, 0, sizeof(*osf));

Wrong patch, push that earlier.

> +	mutex_init(&osf->latest_lock);
>  	osf->dev = dev;
>  }

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
>  
> -	return osf_protocol_decode_sensor_sample(frame, &sample);
> +	for (i = 0; i < sample.channel_count; i++) {
> +		ret = osf_protocol_sensor_sample_value(&sample, i, &values[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	mutex_lock(&osf->latest_lock);

scoped_guard() should work well here.

> +	latest = osf_core_find_latest_sample(osf, sample.sensor_type,
> +					     sample.sensor_index);
> +	if (!latest) {
> +		mutex_unlock(&osf->latest_lock);
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

I'd look at using guard(mutex) here

> +	for (i = 0; i < osf->latest_sample_count; i++) {
> +		latest = &osf->latest_samples[i];
> +		if (latest->sensor_type != sensor_type ||
> +		    latest->sensor_index != sensor_index)
> +			continue;
> +
You can easily push the following out of the loop by
just doing the test 
	if (i == osf->latest_sample_count)
		return -ENODATA;
after the loops.

> +		if (latest->valid && channel < latest->channel_count) {
> +			*value = latest->values[channel];
>  			ret = 0;
> -		else if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
> -			ret = 0;
> -		else
> -			ret = -EOPNOTSUPP;
> +		}
>  		break;
>  	}
> -
> -	if (!ret)
> -		osf->last_sequence = frame.sequence;
> +	mutex_unlock(&osf->latest_lock);
>  
>  	return ret;
>  }
> diff --git a/drivers/iio/opensensorfusion/osf_core.h b/drivers/iio/opensensorfusion/osf_core.h
> index 3680c8c9b..04dd2a367 100644
> --- a/drivers/iio/opensensorfusion/osf_core.h
> +++ b/drivers/iio/opensensorfusion/osf_core.h

> diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
> new file mode 100644
> index 000000000..5e5099878
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_iio.c

> +
> +static const unsigned long osf_temp_available_scan_masks[] = {
> +	BIT(0),

This one is a bit comic. It's not doing anything as can only
either or disable the single channel anyway before this!


> +	0
> +};

> +
> +void osf_iio_unregister_sensor(struct iio_dev *indio_dev)
> +{
> +	struct osf_iio_state *state = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_kfifo_free(state->buffer);
> +	iio_device_free(indio_dev);
> +}
> +
> +int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
> +			unsigned int channel_count)
> +{
> +	struct osf_iio_state *state = iio_priv(indio_dev);
> +	s32 scan[OSF_MAX_SAMPLE_CHANNELS] = { };
> +	s64 timestamp;
> +
> +	if (channel_count != state->spec->channel_count)
> +		return -EPROTO;
> +
> +	memcpy(scan, values, channel_count * sizeof(*values));

This is odd. You are using the unaligned push but bouncing here as well.
If you are going to bounce here then use a structure that includes the
aligned_s64 timestamp, or don't bounce here and leave it to the
push to buffer below to do that.

> +
> +	/* Buffer state can change here; IIO rechecks it during the push path. */

Add more detail on what the race is and where IIO is checking it on the
push path. Note it's not a problem to race unless the buffer we are pushing
to is not ready to receive data.  An extra sample during tear down is
fine.  If there is another race that needs this then I doubt this fixes
it as opposed to narrowing the window.


> +	if (!iio_buffer_enabled(indio_dev))
> +		return 0;
> +
> +	timestamp = iio_get_time_ns(indio_dev);

I wonder if it's worth grabbing the timestamp earlier. There is quite a bit
of code between where we know we have a sample and here and we want it as near
to the real data capture time as possible.  So perhaps grab in the caller
and pass down into here.

> +
> +	return iio_push_to_buffers_with_ts_unaligned(indio_dev, scan,

As above, if using this should pass in values, not scan.

> +						     channel_count * sizeof(*scan),
> +						     timestamp);
This is where Sashiko noticed that if we have the timestamp turned on and
a non multiple of 8 channel_count * sizeof(*scan) the hole between channels and
timestamp is never initialized.  That's a core bug so don't do anything here.
Please test the patch I just sent out though to make sure I didn't mess it up!

Jonathan

> +}


