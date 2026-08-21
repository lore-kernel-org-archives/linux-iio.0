Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3F34A78E;
	Fri, 21 Aug 2026 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280476; cv=none; b=tcrVCtohZ8x41d4WM6U9faIUgvBTi7H4FVrKwLs7VBs+wSvMtjYOL5OhEaQHP/q01US8a/Pnb0q4XtCu9hB+ae7Yev8OYpdSjXDdw6Mf+fPWXOjoAr6e6GBr4kfDs+GYlgEtxRo0tJvYbj4/ckhcWO3O0qTnYTzK2YlNLnYMako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280476; c=relaxed/simple;
	bh=cLMvOab7VCT935nwNYZArRxMbEGpQZ+qA8E03/h4q+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvInAqNpd/B2tzhgT+IISBvgd/i8p/wW8B8faoxbLCS3A8LVXo6K8xmw8UxpJUitpkprT4PbgM426wrwtXvTF5UlFmVqKznM6Ol/Aq1RyQlck/Br6hofIbNjnz1fv/N1ueBFQM16LjtS4LZ0Ap2WHMtjwoPe5WAF5hvvgjp3QSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G70x7bJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G70x7bJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D2E1F000E9;
	Fri, 21 Aug 2026 02:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787280475;
	bh=HhDcVF3YLSOQzbVQVYStJysYCm3wmpe/klfl+CQCWDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G70x7bJTIC5v+ArcUEmwyt1GpL7g4bmijl5SmaJsJDyk2VpsvFj10yBWRI62VVtiU
	 Kd4RYGplUN7QW94JCdeocc6NRZMGNq1ipzYLXre3JaUBOJfZdC/djuX+KCI/QJP+pI
	 w7a0vfSwOIw4iYGwF7EE0RdCr4vTVtvw1K2Pu5sn5HNMrnPOdd/sEWrE61c61GTU38
	 Hqk0yGbZ0UHwx/2YP6l78L3osktij8fka+hQOxafuX3w4sVBP2RD4v7sQ7g01zbF8L
	 izxavCk3om2TLNyvODAeoUUxvWxVvY5DxZxA9KCpbxlv600wyzVIsqvbj9AVS239nj
	 TVlJ5IfE5zoRw==
Date: Fri, 21 Aug 2026 03:47:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org,
 joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com,
 julianbraha@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, grondon@gmail.com, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 4/5] iio: osf: add authenticated stream parser
Message-ID: <20260821034748.5049aca0@jic23-huawei>
In-Reply-To: <20260820050608.5440-5-kimjinseob88@gmail.com>
References: <20260820050608.5440-1-kimjinseob88@gmail.com>
	<20260820050608.5440-5-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 14:06:07 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add a UART byte-stream parser for Open Sensor Fusion frames.
> 
> The parser searches for the OSF0 wire magic, keeps partial frames
> buffered, checks header length and payload bounds, and passes complete
> candidate frames to a registered frame callback.
> 
> Candidates rejected before authentication drop only the current head
> byte before resynchronizing, so a corrupted unauthenticated payload length
> cannot make the parser skip later valid frames. CRC-valid authenticated
> frames are consumed in full and classified as handled, ignored, or
> rejected.
> 
> Use a direct callback member with an opaque context and keep explicit
> statistics for authenticated outcomes and framing failures.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

One really trivial thing inline.  Please check to see if other areas
of code alignment would benefit from a bit of a reorg.

> diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/opensensorfusion/osf_stream.c
> new file mode 100644
> index 000000000000..7ce45e631648
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_stream.c
...

> +
> +static int osf_stream_process(struct osf_stream *stream)
> +{
> +	size_t discarded;
> +	size_t frame_len;
> +	u32 payload_len;
> +	int frame_result;
> +	int first_err = 0;
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
> +		if (stream->len < OSF_FRAME_HEADER_LEN)
> +			break;
> +
> +		if (get_unaligned_le16(stream->buf + 6) != OSF_FRAME_HEADER_LEN) {
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
> +		if (stream->len < frame_len)
> +			break;
> +
> +		frame_result = stream->receive_frame(stream->frame_context,
> +					     stream->buf, frame_len);

Align after (

> +		if (frame_result < 0) {
> +			if (frame_result == -EBADMSG)
> +				stream->stats.bad_crc_frames++;
> +
> +			/*
> +			 * Decoding failed before the frame was authenticated;
> +			 * payload_len is still untrusted. Drop only the current
> +			 * head and resynchronize.
> +			 */
> +			stream->stats.dropped_bytes++;
> +			osf_stream_drop_invalid_head(stream);
> +			if (!first_err)
> +				first_err = frame_result;
> +			continue;
> +		}
> +
> +		/* Count exactly one outcome for every authenticated frame. */
> +		stream->stats.authenticated_frames++;
> +		switch (frame_result) {
> +		case OSF_STREAM_FRAME_HANDLED:
> +			stream->stats.handled_frames++;
> +			break;
> +		case OSF_STREAM_FRAME_IGNORED:
> +			stream->stats.ignored_frames++;
> +			break;
> +		case OSF_STREAM_FRAME_REJECTED:
> +			stream->stats.rejected_frames++;
> +			break;
> +		default:
> +			/*
> +			 * Preserve the authenticated boundary without scanning the
> +			 * payload for another magic value.
> +			 */
> +			stream->stats.rejected_frames++;
> +			if (!first_err)
> +				first_err = -EPROTO;
> +			break;
> +		}
> +		osf_stream_discard(stream, frame_len);
> +	}
> +
> +	return first_err;
> +}
