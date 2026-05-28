Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F627FD75;
	Thu, 28 May 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976729; cv=none; b=XEAIXbX1+VwBvNXUktlsRim0FPXISZn/Z53fQnXdDMhhY+EUWFTIgWIBHlBe7rDbFg7+fK/W5/Uq4u7oivaBOY8k58WBS1KCppwlGvQsCW5+cxzGYggyZM61fwNx50xb82ikj0JJHaCLSMfmqkPJw+2H/GdGCQOE/tNDKx9U0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976729; c=relaxed/simple;
	bh=s2zaJYjA8Fab+S3yJ81RhP+40MvXt9tOYFIR4j0SiI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvWboEKG5G1wcNFdBkdAKrGkgSP4KR2rCxSw4/iw9DCn9hCrNFkOzqStbY4VWbrFJOP0b+N51FaVGchvCMN1WIuHBfB3NXptDXaqaGApQrL7zS1nezFE1uFjRU9gDxA7Ahr5WMQKZhy3IgfxoQVahbSgTjxwkA99vApygkqKEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlrD3vm7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlrD3vm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6694E1F000E9;
	Thu, 28 May 2026 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779976727;
	bh=NI9Ul55Unla6xze6UzfujDwhIzNsj/9R8m7oU0vkEqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AlrD3vm73LXaQxkbDGWLrm9uhnXlkke35/X3PdlK1t/eeQNyskZHApdnvfSS9ImHL
	 xKW0fkZdgSfExKBGCJGMHCc5fjTwjgD/Vc7kTd/q7MnceaMHDl31B+19B3ii4+ei76
	 O+IwsQTlymkK5JQDCuerw2RGap8GVx5DzWorD1/+mUozmVFOrY2kmZlsN22yvu+X+a
	 7ftMA/ZYwFSqWundIlhBo+BtPqZY77lWN3dfjFcMP+gCNXZxsDhROdMVTeUXJvgTJE
	 nGCICy85NMqt7x6jKQZru6YUENkikvplaIpRsplvOMzcFyIOYMt/gshcm8yr596wjV
	 8INT2h0vdGu9w==
Date: Thu, 28 May 2026 14:58:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 4/7] iio: osf: add stream parser
Message-ID: <20260528145840.0329992c@jic23-huawei>
In-Reply-To: <20260524085312.15369-5-kimjinseob88@gmail.com>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
	<20260524085312.15369-5-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 17:53:09 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add byte stream assembly and resync for OSF0 frames.
Various minor things inline.

> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  drivers/iio/opensensorfusion/osf_stream.c | 207 ++++++++++++++++++++++
>  drivers/iio/opensensorfusion/osf_stream.h |  31 ++++
>  2 files changed, 238 insertions(+)
>  create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_stream.h
> 
> diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/opensensorfusion/osf_stream.c
> new file mode 100644
> index 000000000..a2739c987
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_stream.c
> @@ -0,0 +1,207 @@

> +
> +static size_t osf_stream_discard_to_magic(struct osf_stream *stream)
> +{
> +	size_t old_len = stream->len;
> +	size_t match_len;
> +	size_t i;
> +
> +	for (i = 0; i < stream->len; i++) {

	for (size_t i = 0; i < stream->len; i++)

> +		match_len = stream->len - i;
> +		if (match_len > OSF_STREAM_MAGIC_LEN)
> +			match_len = OSF_STREAM_MAGIC_LEN;

		match_len = min(stream->len - i, OSF_STREAM_MAGIC_LEN);

> +
> +		if (osf_stream_magic_match(stream->buf + i, match_len)) {
> +			if (i)
> +				osf_stream_discard(stream, i);
> +			return i;
> +		}
> +	}
> +
> +	stream->len = 0;
> +	return old_len;
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
> +		discarded = osf_stream_discard_to_magic(stream);
> +		if (discarded) {
> +			stream->stats.bad_magic_resyncs++;
> +			stream->stats.dropped_bytes += discarded;
> +			if (!first_err)
> +				first_err = -EPROTO;
> +		}
> +
> +		if (!stream->len)
> +			break;
> +
> +		if (stream->len < OSF_FRAME_HEADER_LEN) {
> +			stream->stats.partial_frames++;
> +			break;
> +		}
> +
> +		if (get_unaligned_le16(stream->buf + 6) !=
> +		    OSF_FRAME_HEADER_LEN) {

		if (get_unaligned_le16(stream->buf + 6) != OSF_FRAME_HEADER_LEN) {

is fine. We are a bit flexible on line length when it helps readability.

> +			stream->stats.dropped_bytes++;
> +			osf_stream_drop_invalid_head(stream);
> +			if (!first_err)
> +				first_err = -EPROTO;
> +			continue;
> +		}
> +
> +		payload_len = get_unaligned_le32(stream->buf + 10);
> +		if (payload_len > OSF_STREAM_MAX_PAYLOAD_LEN) {
> +			stream->stats.dropped_bytes++;
> +			osf_stream_drop_invalid_head(stream);
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
> +			osf_stream_drop_invalid_head(stream);
> +			if (!first_err)
> +				first_err = ret;
> +			continue;
> +		}
> +
> +		if (decoded_len != frame_len) {
> +			stream->stats.dropped_bytes++;
> +			osf_stream_drop_invalid_head(stream);
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

> +int osf_stream_receive_bytes(struct osf_stream *stream, const u8 *buf,
> +			     size_t len)
> +{
> +	size_t copy_len;
> +	size_t space;
> +	int first_err = 0;
> +	int ret;
> +
> +	if (!stream || !stream->osf || (!buf && len))

As in previous patch, how do we get here with any of those being possible?
The last one might make sense as it's about coupling between parameters, but
I'm not seeing the first two as useful unless you clear stream->osf in remove
path or similar.  If you do maybe a comment.

> +		return -EINVAL;
> +
> +	if (!len) {
> +		ret = osf_stream_process(stream);
> +		if (ret && !first_err)
No way for first erro to be set, so same as:
		return osf_stream_process(stream);

If this changes later in this patch series then fine to keep it like this.

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

		copy_len = min(len, space);

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
>
