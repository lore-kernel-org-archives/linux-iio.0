Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E9136351;
	Sun, 20 Sep 2026 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867663; cv=none; b=L46bYt4gIj0IkHZ8ktH7/fnDgnvAXapekf/2M5t7bpKKdmYJZ9P8Q68qycO6wPy+RZONHv+yEqtRD3NYRCXkmawHSJFssO2ZD87dFrcSwQC5zHBePNzSK/y04CTg3Fcbu0urjKrhH4eMVxsIOX1wWRa2x1+nitKj7dFh06PibEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867663; c=relaxed/simple;
	bh=hSixfOcSOH718RKyF42SBNi+d4rYgSdKn03sbGKClVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCGmeXMSSV950i2k63UPUENeqUUSxWsS7Hz0XMf3t5EAGiBpn6r0T5OmEiNyO7Xv7C8aeRGhHzXyl7E493Wnq9wR6pEgAhJH/lzFBppjiwti3SQKfl5hIca3Ew/b54S778dysBl45YrxgwE3ezFYcvHLLIJVGSq41KghhJ0WeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHmIqVJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHmIqVJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AF71F000FF;
	Sun, 20 Sep 2026 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789867662;
	bh=Iuz4uAh99RAU1UDPY/s09AD7260WayUVZGFc1NHzpB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eHmIqVJDZKzSX3NtRudB5uCdgHr5zT9q/3fWS8HoX5RlLFxMlJux2NP/nuosZvqo4
	 rCSNg7bojlcfXgRuaO+DWhysyPTO0GvX5lhud2MhdxWnBkp74HT9TKd5Ei3adVNlBR
	 JDS9LIVmkkWjatuB37nsmZNGTvc8rIQRxwwXF9O7d88iyvsDPfPBQHyzu7w2pJUBeY
	 aWTlq2LVOBZo6x14F0cejiI9w58JRy218PHELW2VhMoLqVSw7oIALh2YdzjqP34dCT
	 Tso4WGbARdmBBInD9Fd5zff8zZSpanBmJdMIwQHpt3Bg8o4PuhTMZj4oihx9Q83uwT
	 G7g1iiZAW5UnA==
Date: Sun, 20 Sep 2026 02:27:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 3/8] iio: osf: add protocol decoding
Message-ID: <20260920022737.4403fc6d@jic23-hlaptop>
In-Reply-To: <a00b004a7ac283e1d6e307421292757004f09e62.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<a00b004a7ac283e1d6e307421292757004f09e62.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 03:24:41 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add helpers for decoding Open Sensor Fusion frame headers and supported
> message payloads.
> 
> Validate the fixed OSF0 envelope, payload bounds and CRC before exposing
> decoded frame contents. Require exact known payload lengths and decode
> capability entries structurally so the core can apply support policy.
> Tolerate reserved padding as required by the fixed protocol contract.
> 
> Use explicit little-endian wire storage sizes and designated
> initializers for decoded output structures.
> 
> Assisted-by: LLM
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Hi Jinseob

A few things inline. Some are about what I'd kind of expect from
how specs are often defined to leave a bit of flexibility and reduce
the need to update drivers for new stuff being added.

If you don't want to go that way I don't really mind.

Otherwise main thing here is why carry reserved data to next layer
given it is meant to be ignored. Drop it down here in the protocol decode.

Thanks,

Jonathan

> diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/opensensorfusion/osf_protocol.c
> new file mode 100644
> index 000000000000..e0d7c7a9ebd7
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_protocol.c

> +
> +int osf_protocol_decode_frame(const u8 *buf, size_t len,
> +			      struct osf_frame *frame, size_t *frame_len)
> +{
> +	u32 expected_crc;
> +	u32 actual_crc;
> +	u32 payload_len;
> +	size_t total_len;
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
> +	if (get_unaligned_le16(buf + 6) != OSF_FRAME_HEADER_LEN)
> +		return -EPROTO;
> +
> +	payload_len = get_unaligned_le32(buf + 10);
> +	if (payload_len > len - OSF_FRAME_MIN_LEN)
> +		return -EMSGSIZE;
> +
> +	total_len = OSF_FRAME_HEADER_LEN + payload_len + OSF_FRAME_CRC_LEN;
> +	expected_crc = osf_crc32_ieee(buf, OSF_FRAME_HEADER_LEN + payload_len);
> +	actual_crc = get_unaligned_le32(buf + OSF_FRAME_HEADER_LEN + payload_len);
> +
> +	if (actual_crc != expected_crc)
> +		return -EBADMSG;
> +
> +	frame->protocol_major = buf[4];
> +	frame->protocol_minor = buf[5];
> +	frame->message_type = get_unaligned_le16(buf + 8);
> +	frame->payload_len = payload_len;
> +	frame->sequence = get_unaligned_le64(buf + 14);
> +	frame->timestamp_us = get_unaligned_le64(buf + 22);
> +	frame->flags = get_unaligned_le32(buf + 30);
> +	frame->reserved = get_unaligned_le32(buf + 34);

As below. I'm not sure what benefit of keeping reserved around is.

> +	frame->payload = buf + OSF_FRAME_HEADER_LEN;
> +	frame->crc = actual_crc;

The above fully assigns frame so I'd do similar to you have elsewhere
	*frame = (struct osf_frame) {
		.protocol_major = ...
...
	};
Both makes it more readable and makes it clear you aren't leaving
any existing data in place.


> +	*frame_len = total_len;
> +
> +	return 0;
> +}

> +
> +int osf_protocol_decode_capability_report(const struct osf_frame *frame,
> +					  struct osf_capability_report *report)
> +{
> +	u16 capability_count;
> +	size_t expected_len;
> +	const u8 *payload;
> +
> +	if (!frame || !report || !frame->payload)
> +		return -EINVAL;
> +
> +	if (frame->message_type != OSF_MSG_CAPABILITY_REPORT)
> +		return -EPROTO;
> +
> +	if (frame->payload_len < OSF_CAP_REPORT_BASE_LEN)
> +		return -EMSGSIZE;
> +
> +	payload = frame->payload;
> +	capability_count = get_unaligned_le16(payload);
> +
> +	expected_len = OSF_CAP_REPORT_BASE_LEN +
> +		       capability_count * OSF_CAP_SENSOR_ENTRY_LEN;
> +	if (frame->payload_len != expected_len)

I don't hugely mind as it's your code + spec to maintain but generally
for a spec with records like this I'd expect it to be possible to extend
the structure without it being a breaking spec change.   As such
I'd kind of expect the check to be that the payload_len was at least
as big as expected len. Larger would be fine but we'd ignore anything
there.

> +		return -EMSGSIZE;
> +
> +	*report = (struct osf_capability_report) {
> +		.capability_count = capability_count,
> +		.entries = payload + OSF_CAP_REPORT_BASE_LEN,
> +	};
> +
> +	return 0;
> +}
> +
> +int osf_protocol_decode_capability_entry(const struct osf_capability_report
> +					 *report, u16 index,
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
> +	*entry = (struct osf_capability_entry) {
> +		.sensor_type = get_unaligned_le16(payload),
> +		.sensor_index = get_unaligned_le16(payload + 2),
> +		.channel_count = get_unaligned_le16(payload + 4),
> +		.sample_format = get_unaligned_le16(payload + 6),
> +		.scale_nano = get_unaligned_le32(payload + 8),
> +		.flags = get_unaligned_le32(payload + 12),
> +		.reserved = get_unaligned_le32(payload + 16),

Entirely correctly I think you don't do any checks or reads of reserved values.
As such why copy them around?  I'd just drop that field from your decoded
structures.  Not a huge saving but why carry irrelevant data around!

Jonathan

> +	};
> +
> +	return 0;
> +}
