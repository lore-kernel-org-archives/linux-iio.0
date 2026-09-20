Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2581CDFCA;
	Sun, 20 Sep 2026 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867862; cv=none; b=fOWbAgX+QjPfKxJKk1yzyOBAfCNmSBSW8vQj52FCJZQ6IPXwLlM6iW4L5vMrYqLT9Wv7NxYk5FlVyc1LEgr8JXwQX712DMXnAaJWpqZjcg5IAAaeN7TXZHD/vuiaF76+XVkkMTSkMcbsaRg0GZ6Qj9tTMLEZZXgwqAJHCcF3TRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867862; c=relaxed/simple;
	bh=2rNQ6QfXOTaTp1mYT9R7/69YVRR0JqsbtTTzo+ppa5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIoimEnSI8oRZJSbBjumpPD83pFRY78q9WJY4mDGj/bvsFnwOLCmQ+WNBVhKRNeEHNzYKJ9bKwng5VSdV0RQaRUS8A915veIx+DmKG4AeqQ7pgD/CFhRXh81cnI8Kq4L761uglYrGhC/+1jqdrBRJPCKQOlaOj/fWkFIJ7UqU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LydiYBEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LydiYBEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F781F000FF;
	Sun, 20 Sep 2026 01:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789867861;
	bh=W8RfV7O/TeI+kOj2++uUsIO0ovmhDdl751yBRzW2MzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LydiYBEsjIAOI3ykeQl+U1suEva88/hF0kxmU8HVKHJs2fH8UBfFSEex+jISCueNx
	 PrfdN1Dr04zZN41kDQ4jZGKNwLdXaGBCL+WWWWLt6j8H3WDM1qCwn0kUup2Xzf2aVr
	 JQl0BpsqrhE5utXYLo1oylcULv1hAQJwS+vdd9rduZbo6xQIJB87wnpIlK55OBONzv
	 OIu4ytyI24GR/IWmQ/hCpnjs04ugF77zCFHwHrPGZvkQULJmsLN0yyRDLBN6+jIPCd
	 c2cFen/v76qKowYe0nXDNjA0SHVTqdiskd1nGIclgp/i98xWdwN/ZxiiuOTz3Rtcbr
	 6PA57hM3JjDIw==
Date: Sun, 20 Sep 2026 02:30:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 4/8] iio: osf: add validated stream parser
Message-ID: <20260920023057.71ef0eb5@jic23-hlaptop>
In-Reply-To: <e9d1f8f8d69b76797d617965f263df97b2b586e0.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<e9d1f8f8d69b76797d617965f263df97b2b586e0.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 03:24:42 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add a UART byte-stream parser for Open Sensor Fusion frames.
> 
> The parser searches for the OSF0 wire magic, keeps partial frames
> buffered, checks header length and payload bounds, and passes complete
> candidate frames to a registered frame callback.
> 
> Candidates rejected before validation drop only the current head
> byte before resynchronizing, so a corrupted unvalidated payload length
> cannot make the parser skip later valid frames. CRC-valid validated
> frames are consumed in full and classified as handled, ignored, or
> rejected.
> 
> Use a direct callback member with an opaque context and keep explicit
> statistics for validated outcomes and framing failures.
> 
> Assisted-by: LLM
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Just one trivial thing.

Thanks,

Jonathan


> diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/opensensorfusion/osf_stream.c
> new file mode 100644
> index 000000000000..e262415e69b7
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_stream.c


> +void osf_stream_init(struct osf_stream *stream,
> +		     int (*receive_frame)(void *context, const u8 *buf,
> +					  size_t len),
> +		     void *frame_context)
> +{
> +	if (!stream)
> +		return;
> +
> +	stream->receive_frame = receive_frame;
> +	stream->frame_context = frame_context;
> +	stream->len = 0;
> +	memset(&stream->stats, 0, sizeof(stream->stats));
> +}
> +
> +void osf_stream_reset(struct osf_stream *stream)
> +{
> +	if (!stream)
> +		return;
> +
> +	stream->len = 0;
> +	memset(&stream->stats, 0, sizeof(stream->stats));
> +}

You could reorder these two functions and call stream_reset from
stream_init.  Would make it clear what getting to a 'clean' state
means.



