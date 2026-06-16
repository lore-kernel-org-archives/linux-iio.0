Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE082F7EE5;
	Tue, 16 Jun 2026 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608608; cv=none; b=bjLAu6Ryst+3P3ji1tJEdh1FM1rJjpjUJjnD+j/GzsLhJ03Iy4tOhdyRnabnMIqis3ynZ73i24zc2694LSCNbZOkwDZyoURWF6GbsV+6bjnNe6sEixa4qIqrtwzjd+W6S4uaSuFLOTclixOfRcsURpyvMxjdXnjVYdGXozyxl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608608; c=relaxed/simple;
	bh=oDxOtVrOzDh6MvwAYljgCU2APhYTV/mMaD2dgqtmdiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKDw7gw1Hz7zqhyH+NqQxXFR+0dyf8tPhKrxjPThQwuKVUt0EvpsPe+G1MWTzC+H6nqLAC9FC30DZngcMgljHpTmJQLyuT4ypKP3ticlDHSrczeU+2MzqutaxTQFWIumx/++3qa+JBmEuKuCSdLj8nFtGJDYyNbiVBeOMp4x0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZF1oxy3x; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZF1oxy3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781608606; x=1813144606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oDxOtVrOzDh6MvwAYljgCU2APhYTV/mMaD2dgqtmdiY=;
  b=ZF1oxy3xjWCUVwRbuWEfOfUoaHveC/GaU5Bum4cEHT1bw/Gop7FfT6mr
   0Vn8dj6+VO4FXCtm3flz44Qd+lNYv30cEOJ3hhnsWJQEAPf+cGuZGStv6
   Zgpv2eUgwhEOAcr5jWNG8C6tjc1n8cV+cc7VpTtdMwm452GmQXDYOh6CM
   vaJ0lpNug+1lSJt5rNNLv1dfMMzbDcK8dNIEVyDN13p+BtfqJZ1c6VQX8
   B9/0RX5e2xUxfHX1MLJ7uUBFvbciw2otMw13bYXEmU1MnxT8PQ++P8wk2
   +W46eSr6IrAR6FiP+QklKcLfJbHi01z71ts3aXELes/Ygc0mOywbdG+6w
   g==;
X-CSE-ConnectionGUID: F+nZxR1VS3mk6+NRohnxBg==
X-CSE-MsgGUID: TuObY2fpTXCcrXGY0oO17w==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86272005"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86272005"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:16:37 -0700
X-CSE-ConnectionGUID: Ym9Sqpc4QZyxM79Wc1Oerg==
X-CSE-MsgGUID: 6bl6RVMkTEi8oTpoqraQ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247617556"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:16:34 -0700
Date: Tue, 16 Jun 2026 14:16:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v5 4/6] iio: osf: add stream parser
Message-ID: <ajEwj390mBxc9tfs@ashevche-desk.local>
References: <20260616072242.3942-1-kimjinseob88@gmail.com>
 <20260616072242.3942-5-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616072242.3942-5-kimjinseob88@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 04:22:40PM +0900, Jinseob Kim wrote:
> Add a byte-stream parser that resynchronizes on OSF frame magic, validates
> complete frames, and forwards decoded frames to the OSF core.

...

> +static const u8 osf_stream_magic[OSF_STREAM_MAGIC_LEN] = {
> +	'O', 'S', 'F', '0',
> +};

Why?! You have already a definition, use it instead.

...

> +static size_t osf_stream_discard_to_magic(struct osf_stream *stream)
> +{
> +	size_t old_len = stream->len;
> +	size_t match_len;

> +	size_t i;
> +
> +	for (i = 0; i < stream->len; i++) {

In current form it's as simple as

	for (size_t i = 0; i < stream->len; i++) {

> +		match_len = stream->len - i;
> +		if (match_len > OSF_STREAM_MAGIC_LEN)
> +			match_len = OSF_STREAM_MAGIC_LEN;
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

...

> +static int osf_stream_process(struct osf_stream *stream)
> +{
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
> +		if (stream->len < OSF_FRAME_HEADER_LEN)
> +			break;

> +		if (get_unaligned_le16(stream->buf + 6) !=
> +		    OSF_FRAME_HEADER_LEN) {

Make it a single line for readability.

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
> +		ret = osf_core_receive_frame(stream->osf, stream->buf, frame_len);
> +		if (ret) {
> +			if (ret == -EBADMSG) {
> +				stream->stats.bad_crc_frames++;
> +				stream->stats.dropped_bytes++;
> +				osf_stream_drop_invalid_head(stream);
> +			} else {
> +				osf_stream_discard(stream, frame_len);
> +			}
> +			if (!first_err)
> +				first_err = ret;
> +			continue;
> +		}
> +
> +		stream->stats.valid_frames++;
> +		osf_stream_discard(stream, frame_len);
> +	}

> +	return first_err;

Why do we continue on the error and then still return an error?
Same Q for the receive part.

> +}

...

> +void osf_stream_init(struct osf_stream *stream, struct osf_device *osf)
> +{
> +	if (!stream)
> +		return;
> +
> +	stream->osf = osf;
> +	stream->len = 0;
> +	memset(&stream->stats, 0, sizeof(stream->stats));
> +}
> +
> +void osf_stream_reset(struct osf_stream *stream)
> +{
> +	if (stream) {
> +		stream->len = 0;
> +		memset(&stream->stats, 0, sizeof(stream->stats));
> +	}

As per above

	if (!stream)
		return;

> +}

...

> +struct osf_stream_stats {
> +	u64 valid_frames;
> +	u64 bad_magic_resyncs;
> +	u64 bad_crc_frames;
> +	u64 partial_frames;
> +	u64 dropped_bytes;
> +};

Don't you want to use linux/u64_stats_sync.h APIs?

-- 
With Best Regards,
Andy Shevchenko


