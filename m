Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6D30EF77;
	Mon, 22 Jun 2026 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146600; cv=none; b=KxoEyz3uYCpaf2cMZ09kLjpzft2dzbNusmFx4Pne9co/xk0gZ9W4E0HaiG+g0mBGZfwTWkLRDSEWEx4UX9WqYBrfvg9WohO2rsc/GMcR+1/4zMFiUxyOn/VOL7o/SHN855Iyma2lqo0EDkGY/9+rIfZVNDrVqz2JP5eJzltSmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146600; c=relaxed/simple;
	bh=JfUfVlp1q5Sx8xOkUr7zjRv4+KKQP318DZBVbbWXjv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5epWcH+ZMYhdb+KJ0Uv/+JZV4YwTCJQ8qBjsQOgsbHR4y2GJq5GKaXRu8f5esp7u274h+bb27Pq2uQpS60GQ7C8zDnVrOyZrrMFLtqagArFCoIS/Ihf7bgdl8BOdVrpRyVClc59NTzgI0dN4bz6ltsZ9zlec1jJ5y5e2qaI40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCtKujVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCtKujVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E10A1F000E9;
	Mon, 22 Jun 2026 16:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146598;
	bh=U+Zp+zSEV717V8WStKNxZNZGPjCrFr18PbH75OwVmQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fCtKujVJ0DaUxWhBYsY7iB/Lbino8ntCRghxj6VwFifvL4hU0IGxPUEpEZZH0TQJQ
	 ZJzKJ2it5GZoxvJGEUfXKpIl8oHwHQcL0vheq8yyd+o+4EA4xtpGMXOHZEI0RqLAJl
	 QXchL0Hu7CtkNp/QOJl0erZB9973ugf7T8OPL5kbbjOBAvMcin4HHOzCuHubyz8xct
	 u3dXdYeyx1RUeQ6K6Ry/RLYVaDFyY5PDZ6dH4v9bjyhH1aIctoyCOARWxkL2IyHsSW
	 cTc6kYgsgWNvhXdkHfeDXJZLpqMzJ9GGpcQkFm8SxAwEvtemuXDV44LbIKRkjqguET
	 unHq2UT/mZk5g==
Date: Mon, 22 Jun 2026 17:43:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v5 3/6] iio: osf: add protocol decoding
Message-ID: <20260622174309.35904c86@jic23-huawei>
In-Reply-To: <20260616072242.3942-4-kimjinseob88@gmail.com>
References: <20260616072242.3942-1-kimjinseob88@gmail.com>
	<20260616072242.3942-4-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 16:22:39 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add helpers for validating and decoding Open Sensor Fusion frames and the
> message payloads used by the initial receive path.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
A few things inline.

> ---
>  drivers/iio/opensensorfusion/osf_protocol.c | 249 ++++++++++++++++++++
>  drivers/iio/opensensorfusion/osf_protocol.h |  97 ++++++++
>  2 files changed, 346 insertions(+)
>  create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h
> 
> diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/opensensorfusion/osf_protocol.c
> new file mode 100644
> index 000000000..5bee545f3
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_protocol.c

> +int osf_protocol_decode_frame(const u8 *buf, size_t len,
> +			      struct osf_frame *frame, size_t *frame_len)
> +{
> +	u32 expected_crc;
> +	u32 actual_crc;
> +	u32 payload_len;
> +	size_t total_len;
> +	u8 major;
> +
> +	if (!buf || !frame || !frame_len)
> +		return -EINVAL;
> +
> +	if (len < OSF_FRAME_MIN_LEN)
> +		return -EMSGSIZE;
> +
> +	if (get_unaligned_le32(buf) != OSF_FRAME_MAGIC)
> +		return -EPROTO;
> +
> +	major = buf[4];
> +	if (major != OSF_PROTOCOL_MAJOR)
> +		return -EPROTO;
> +
> +	if (get_unaligned_le16(buf + 6) != OSF_FRAME_HEADER_LEN)
> +		return -EPROTO;
> +
> +	payload_len = get_unaligned_le32(buf + 10);
> +	if (payload_len > len - OSF_FRAME_MIN_LEN)
> +		return -EMSGSIZE;
> +
> +	if (get_unaligned_le32(buf + 34))
> +		return -EPROTO;
> +
> +	total_len = OSF_FRAME_HEADER_LEN + payload_len + OSF_FRAME_CRC_LEN;
> +	expected_crc = osf_crc32_ieee(buf, OSF_FRAME_HEADER_LEN + payload_len);
> +	actual_crc = get_unaligned_le32(buf + OSF_FRAME_HEADER_LEN + payload_len);
> +
> +	if (actual_crc != expected_crc)
> +		return -EBADMSG;
> +
> +	frame->protocol_minor = buf[5];
> +	frame->message_type = get_unaligned_le16(buf + 8);
> +	frame->payload_len = payload_len;
> +	frame->sequence = get_unaligned_le64(buf + 14);
> +	frame->timestamp_us = get_unaligned_le64(buf + 22);
> +	frame->flags = get_unaligned_le32(buf + 30);
> +	frame->payload = buf + OSF_FRAME_HEADER_LEN;
> +	frame->crc = actual_crc;

Same as below wrt to to using designated initializers for these
structure fills

> +	*frame_len = total_len;
> +
> +	return 0;
> +}
> +
> +int osf_protocol_decode_sensor_sample(const struct osf_frame *frame,
> +				      struct osf_sensor_sample *sample)
> +{
> +	u16 channel_count;
> +	u16 sample_format;
> +	u16 sensor_type;
> +	size_t expected_len;
> +	const u8 *payload;
> +
> +	if (!frame || !sample || !frame->payload)
> +		return -EINVAL;
> +
> +	if (frame->message_type != OSF_MSG_SENSOR_SAMPLE)
> +		return -EPROTO;
> +
> +	if (frame->payload_len < OSF_SENSOR_SAMPLE_BASE_LEN)
> +		return -EMSGSIZE;
> +
> +	payload = frame->payload;
> +	sensor_type = get_unaligned_le16(payload);
> +	channel_count = get_unaligned_le16(payload + 4);
> +	sample_format = get_unaligned_le16(payload + 6);
> +
> +	if (!osf_sensor_type_valid(sensor_type))
> +		return -EPROTO;
> +
> +	if (!channel_count)
> +		return -EPROTO;
> +
> +	if (sample_format != OSF_SAMPLE_FORMAT_S32)
> +		return -EPROTO;
> +
> +	if (get_unaligned_le32(payload + 12))
> +		return -EPROTO;
> +
> +	if (channel_count > (SIZE_MAX - OSF_SENSOR_SAMPLE_BASE_LEN) / sizeof(s32))
> +		return -EOVERFLOW;
> +
> +	expected_len = OSF_SENSOR_SAMPLE_BASE_LEN + channel_count * sizeof(s32);
> +	if (frame->payload_len != expected_len)
> +		return -EMSGSIZE;
> +
> +	sample->sensor_type = sensor_type;
> +	sample->sensor_index = get_unaligned_le16(payload + 2);
> +	sample->channel_count = channel_count;
> +	sample->sample_format = sample_format;
> +	sample->scale_nano = get_unaligned_le32(payload + 8);
> +	sample->samples = payload + OSF_SENSOR_SAMPLE_BASE_LEN;
See below. Designated initializer would help readability a little here.

> +
> +	return 0;
> +}
> +
> +int osf_protocol_sensor_sample_value(const struct osf_sensor_sample *sample,
> +				     unsigned int index, s32 *value)

Given channel count is a u16 and we can't be equal or bigger than it, perhaps
use a u16 for index as well.

> +{
> +	if (!sample || !sample->samples || !value)
> +		return -EINVAL;
> +
> +	if (index >= sample->channel_count)
> +		return -ERANGE;
> +
> +	/* Samples are little-endian two's-complement signed values. */
> +	*value = (s32)get_unaligned_le32(sample->samples + index * sizeof(s32));

sizeof(__le32) slightly more appropriate given that is what you are treating it
as.

> +
> +	return 0;
> +}
> +
> +int osf_protocol_decode_device_status(const struct osf_frame *frame,
> +				      struct osf_device_status *status)
> +{
> +	const u8 *payload;
> +
> +	if (!frame || !status || !frame->payload)
> +		return -EINVAL;
> +
> +	if (frame->message_type != OSF_MSG_DEVICE_STATUS)
> +		return -EPROTO;
> +
> +	if (frame->payload_len != OSF_DEVICE_STATUS_LEN)
> +		return -EMSGSIZE;
> +
> +	payload = frame->payload;
> +	if (get_unaligned_le32(payload + 16))
> +		return -EPROTO;
> +
> +	status->uptime_s = get_unaligned_le32(payload);
> +	status->status_flags = get_unaligned_le32(payload + 4);
> +	status->error_flags = get_unaligned_le32(payload + 8);
> +	status->dropped_frames = get_unaligned_le32(payload + 12);
Similar to below. I'd use a designated initializer for status as it
is all written in one place.

> +
> +	return 0;
> +}

> +
> +int osf_protocol_decode_capability_entry(const struct osf_capability_report *report,
> +					 unsigned int index,
> +					 struct osf_capability_entry *entry)
> +{
> +	u16 sample_format;
> +	u16 sensor_type;
> +	u32 flags;
> +	const u8 *payload;
> +
> +	if (!report || !report->entries || !entry)
> +		return -EINVAL;
> +
> +	if (index >= report->capability_count)

Neater to size index to match capability_count.  Not that
important though.

> +		return -ERANGE;
> +
> +	payload = report->entries + index * OSF_CAP_SENSOR_ENTRY_LEN;
> +	sensor_type = get_unaligned_le16(payload);
> +	sample_format = get_unaligned_le16(payload + 6);
> +	flags = get_unaligned_le32(payload + 12);
> +
> +	if (!osf_sensor_type_valid(sensor_type))
> +		return -EPROTO;
> +
> +	if (sample_format != OSF_SAMPLE_FORMAT_S32)
> +		return -EPROTO;
> +
> +	if (flags & ~OSF_CAPABILITY_FLAGS_MASK)
> +		return -EPROTO;
> +
> +	if (get_unaligned_le32(payload + 16))
> +		return -EPROTO;
> +
> +	entry->sensor_type = sensor_type;
> +	entry->sensor_index = get_unaligned_le16(payload + 2);
> +	entry->channel_count = get_unaligned_le16(payload + 4);
> +	entry->sample_format = sample_format;
> +	entry->scale_nano = get_unaligned_le32(payload + 8);
> +	entry->flags = flags;
neater as designated initializer I think.

	*entry = (struct osf_capability_entry) {
		.sensor_type = sensor_type,
		.sensor_index = get_unaligned_le16(payload + 2),
etc
	};
> +
> +	return 0;
> +}
