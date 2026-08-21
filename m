Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5316352C5B;
	Fri, 21 Aug 2026 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787281412; cv=none; b=LXl9IXWMMiLTC9kEtpxmRKh5aO2jIMBTSgJxyW/M/T3BMVMspWNIRk/9YAGGkkSaTwDE1GDVnK9iBbzDsi+e6R7j2d6lgwwmtELGXLGtSRuO8B2PhdRdIjX+wClSsxyzY7tfkTHn4MiEbnim+dusLI25HwnQAwFww7zmvbm9Hdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787281412; c=relaxed/simple;
	bh=eQPR8yeLkebYYyf1ebT+uB4vrThIpOQ5PP4n6th7bFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwmK8SIqkj8gMMSrmCliMVT2j043J3mbcKhHeQWkStK/iBo7sl/9WUL5CkyMRHXci1immVy66KeXpJHaH1x5k5rkLCHGaZfKWOO6bqpMn2+zi63S7MilFztGwyYsUUPXkoOqkiF/r2RQ5yCzYw0k94vL5AYP9ZQs/nLNVOBFEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNx7vNbB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNx7vNbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411751F000E9;
	Fri, 21 Aug 2026 03:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787281410;
	bh=wkAXRc77UaQs7Z+zl3fDecTnghTKWwHH9OjKWmqCO4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WNx7vNbByNanhXw2sJlzk1ggRYrmXvHaFzUowjQcYpEb+ibdE9iqPdHZ7T9RY83zg
	 5WMs6gPF3+5pbjj5krurgH0yoXCIfBrbmozEmYn6AIyfpGYX+OTdTtvVTAyIf1IMHF
	 wGbF0iY7PzkxGgj9xQNXG4iYsSYf2XR6nR166F81Bn5VX1AXvO7l2562MM/pRNBy2O
	 uB7GDQpIMvoHv70b3i9RQ0hPyJ00o/u9Z/tB8lwcGFYSb+hO34Dmqm+3jYaPex8qeI
	 VMgD2x3XeJYJsR3mudnzy/lu2lLVn68oQpf5vC9PjDHQRr+1A/07hml1p+b+NM1anr
	 eMT/VHMdc+9VA==
Date: Fri, 21 Aug 2026 04:03:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org,
 joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com,
 julianbraha@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, grondon@gmail.com, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 5/5] iio: osf: add UART IIO driver
Message-ID: <20260821040324.14cbac9a@jic23-huawei>
In-Reply-To: <20260820050608.5440-6-kimjinseob88@gmail.com>
References: <20260820050608.5440-1-kimjinseob88@gmail.com>
	<20260820050608.5440-6-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 14:06:08 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add the Open Sensor Fusion serdev transport, driver core, and IIO
> registration path as one complete driver patch.
> 
> The driver enables the required vcc regulator, receives OSF frames over
> UART, registers IIO devices from capability reports, supports direct raw
> reads from the latest sample cache, and pushes buffered samples into
> software kfifo buffers.

Too much info.  We definitely don't need mention it turns on the power
or that the data goes standard paths.

> 
> Wire the stream parser frame callback to the OSF core, use final Kconfig
> and Makefile contents from the start, check iio_buffer_enabled() before
> pushing samples, and use zero-initialized scan storage with explicit
> timestamp alignment.
> 
> Classify authenticated application outcomes as handled, ignored, or
> rejected so the parser consumes every CRC-valid frame in full. Decode
> capability entries structurally, skip unsupported entries individually,
> and register the supported entries from the same report. Allocate latest
> sample cache slots only for sensors with registered IIO devices.
> 
> Deliver sensor samples to IIO before committing the latest-sample
> cache, so a frame rejected by the registered channel layout or buffer
> path cannot change direct-read state or the last accepted sequence.
> Add focused KUnit coverage for rejected, valid, ignored, and malformed
> sample paths and cache-slot exhaustion.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

A couple of minor things inline. 

Thanks,

Jonathan

> diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
> new file mode 100644
> index 000000000000..56030b4d6a9f
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_iio.c
> @@ -0,0 +1,304 @@

...

> +
> +#define OSF_MOD_CHAN(_type, _mod, _idx)                         \
> +	{                                                               \
> +		.type = (_type),                                           \
> +		.modified = 1,                                             \
> +		.channel2 = (_mod),                                        \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),              \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),      \
> +		.scan_index = (_idx),                                      \
> +		.scan_type = {                                             \
> +			.sign = 's',                                         \
> +			.realbits = 32,                                      \
> +			.storagebits = 32,                                   \
> +			.endianness = IIO_CPU,                               \
> +		},                                                        \
> +	}
> +
> +#define OSF_CHAN(_type, _idx)                                     \
> +	{                                                               \
> +		.type = (_type),                                           \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),              \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),      \
> +		.scan_index = (_idx),                                      \
> +		.scan_type = {                                             \
> +			.sign = 's',                                         \
> +			.realbits = 32,                                      \
> +			.storagebits = 32,                                   \
> +			.endianness = IIO_CPU,                               \
> +		},                                                        \
> +	}

Tidy up the \ as there doesn't seem to be any standard arrangement going on here.

> +int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
> +			u16 channel_count)
> +{
> +	struct osf_iio_state *state = iio_priv(indio_dev);
> +	s64 timestamp;
> +
> +	if (channel_count != state->spec->channel_count)
> +		return -EPROTO;
> +
> +	if (!iio_buffer_enabled(indio_dev))
> +		return 0;
> +
> +	timestamp = iio_get_time_ns(indio_dev);
> +
> +	switch (channel_count) {
> +	case 1: {
> +		struct osf_iio_scan_1axis scan = { };

Similar to below - you might as well initialize the one value.

> +
> +		scan.value = values[0];
> +		return iio_push_to_buffers_with_ts(indio_dev, &scan,
> +						       sizeof(scan), timestamp);

Check for bits of alignment of code that have become wrong over time.

> +	}
> +	case 3: {
> +		struct osf_iio_scan_3axis scan = { };
> +
> +		scan.values[0] = values[0];
> +		scan.values[1] = values[1];
> +		scan.values[2] = values[2];

Might as well do
		struct osf_iio_scan_3axis scan = {
			.values[0] = values[0],
			.values[1] = values[1],
			.values[2] = values[2],
		};
Similar for other cases.

> +		return iio_push_to_buffers_with_ts(indio_dev, &scan,
> +						       sizeof(scan), timestamp);
> +	}
> +	default:
> +		return -EPROTO;
> +	}
> +}
