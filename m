Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7971A682C;
	Wed,  8 Jul 2026 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473613; cv=none; b=S4/ubc4rbr2fdKjoMkq12+a5HbRnC48/TLJNiVDjLc0Jh8EqscWAOP4SQrDoPxHtbx6vaiCrX8mg1wN3mGNbMRX9bu8QwXx0pfIjOaWTXc4Kuu3htaSdncvKI4gdB3j777MTga08QBQ7l/a4qzzYs8Wb94rBzmdW98JeqiDEuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473613; c=relaxed/simple;
	bh=XM1bybuEUQXVIOe5wXVKhlGyx+y2XnhpF5/mPGKtW7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHSdbFpOpR4WbjVHytvNQubLqr9fvGPp0FWLf5ww3YzfcxR9wrue8ge7SmI/wPsRhtgoq1W71Y84cMPExAovyrE/uFswMnjE0LFv8uOVcUm3U4CUrPZu9oGilyLkH4agtQwJI6mEsJvrmyyvZZpzCksU853S+xZZ+SUgAiWP8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiYAH5+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiYAH5+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02C21F000E9;
	Wed,  8 Jul 2026 01:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783473612;
	bh=VbX6s7G6h8i7p7kkOF9orThc4zMg04n130BwpfOEfQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WiYAH5+vJN1uIIPQ32Gd8GFrG+SQzLeIsIGYLXP0hvdObhGuNaO51i14EgRhm3hyE
	 aSkUkvOycYwhSVxgpCS9IsjankLJvDQAaZ71JPypqMiH0EGRFTgtxr+DXV3TVyRB1j
	 W0PMUZzKfz51waIQ/idWGMecfthJZrbRugeM17qSu9XtzgwOTZ5apAhqFndNIJ5NTj
	 YY3hctICeKck9aPR9S0RgCVEpZS3I0YmcOcIMtzAIIiRIuNoRL4lbgJqSId+eQYwsq
	 3v8H+JyBfSPh1iITak4JQTgtRQcdRg29oKYtHCFv7IHUPLkWkAFs4RajnFdp+3IonT
	 VIS8YZfb+nuqg==
Date: Wed, 8 Jul 2026 02:20:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: osf: add UART IIO driver
Message-ID: <20260708022006.4276fc99@jic23-huawei>
In-Reply-To: <20260707014525.1015-6-kimjinseob88@gmail.com>
References: <20260707014525.1015-1-kimjinseob88@gmail.com>
	<20260707014525.1015-6-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jul 2026 10:45:25 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add the Open Sensor Fusion serdev transport, driver core, and IIO
> registration path as one complete driver patch.
> 
> The driver enables the required vcc regulator, receives OSF frames over
> UART, registers IIO devices from capability reports, supports direct raw
> reads from the latest sample cache, and pushes buffered samples into
> software kfifo buffers.
> 
> Use final Kconfig and Makefile contents from the start, claim IIO buffer
> mode while pushing samples, and use zeroed scan storage with explicit
> timestamp alignment so the driver does not depend on IIO core
> bounce-buffer padding behavior.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

A few things inline.

> diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
> new file mode 100644
> index 000000000..02d55a201
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_core.c

> +
> +int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)

This is only defined in this patch but is used in patch 4.  Make sure your
code builds after each patch so as to avoid breaking code bisection.

> +{
> +	struct osf_frame frame;
> +	size_t frame_len;
> +	int ret;
> +
> +	ret = osf_protocol_decode_frame(buf, len, &frame, &frame_len);
> +	if (ret)
> +		return ret;
> +
> +	if (frame_len != len)
...


> diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
> new file mode 100644
> index 000000000..91afcf3b8
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_iio.c

> +
> +#define OSF_SCAN_TYPE_S32						\
> +	{								\
> +		.sign = 's',						\
> +		.realbits = 32,					\
> +		.storagebits = 32,					\
> +		.endianness = IIO_CPU,					\
> +	}

This feels like going too far to deduplicate just this.  Put a copy inline
in each of the other macros where it is used and drop this one.

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


> +int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
> +			u16 channel_count)
> +{
> +	struct osf_iio_state *state = iio_priv(indio_dev);
> +	s64 timestamp;
> +	int ret;
> +
> +	if (channel_count != state->spec->channel_count)
> +		return -EPROTO;
> +
> +	if (!iio_device_try_claim_buffer_mode(indio_dev))
> +		return 0;

Looking at this again, why do we care about holding the device
in buffered mode for this?  Races should be safe without that
big hammer. A simple check on iio_buffer_enabled() should ensure
data is only pushed when it is enabled, or just after it is disabled
(which should always be safe).

> +
> +	timestamp = iio_get_time_ns(indio_dev);
> +
> +	switch (channel_count) {
> +	case 1: {
> +		struct osf_iio_scan_1axis scan = { };
> +
> +		scan.value = values[0];
> +		ret = iio_push_to_buffers_with_ts(indio_dev, &scan,
> +						  sizeof(scan), timestamp);

With change above direct returns here

> +		break;
> +	}
> +	case 3: {
> +		struct osf_iio_scan_3axis scan = { };
> +
> +		scan.values[0] = values[0];
> +		scan.values[1] = values[1];
> +		scan.values[2] = values[2];
> +		ret = iio_push_to_buffers_with_ts(indio_dev, &scan,

here 

> +						  sizeof(scan), timestamp);
> +		break;
> +	}
> +	default:
> +		ret = -EPROTO;

and here should be fine as no need to release it.

> +		break;
> +	}
> +
> +	iio_device_release_buffer_mode(indio_dev);
> +
> +	return ret;
> +}
