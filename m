Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3832367F21;
	Mon, 29 Jun 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742241; cv=none; b=AMWjNM5oGjjUtxxepT/3sWgNRkBrfjaIrsfJY9ORVAR/pkxjBlZVzKC1rAEj8h9M0Ck8TbjyorNYdLvmQCuyzyg7Fdt/Cjz4WLcDrnlQWECyWj9TrIo9mYoi5Yi/2pKMAPmolxsIs7WQV5SEo2Nkf/GmMLYmlz+OW6nEXmI9LWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742241; c=relaxed/simple;
	bh=LdXGeqRZm1zX38I76IbM2w6lSEul5LwMI/yoPc9QNwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6FM8Dodi9T7HBJMAYRyGCpl5D3BucnCSwed7IN7nFk8UkW3lbHeeXXf7reVNED9qKu1uc49SQo6mOd1J810DN6zBgRdIMDWbX10hE7VVNxWhUw+iZMjnNcjAGcSd1EY+i8cN35zov4r0D7uWEKwFl2up8pjm4t0TX/Qa0sG3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFAd7HZq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFAd7HZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782742238; x=1814278238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LdXGeqRZm1zX38I76IbM2w6lSEul5LwMI/yoPc9QNwM=;
  b=NFAd7HZqF14myp9dwn87anf2r1LTQrIcnGLRxNoE511Eyux3OAmdEeZb
   ouTwm60byF1vVl8qy4x3KVFgpWUgfX3VVKqqG/OCBZrtT43lFHBeZ+kiw
   iHJl1GkuC+9Q1KFn/7mQLgx/DkYEtVL2pF11quqgFxkRC5ozE7Ed7BiZO
   e0KQgpesxfi9K84uad2ztaLZX/NyEqVlLDHrbHAWHfqV7GgNgDe+daE7n
   8xgQpIQENfaLDVHDDAH6QTaU6IPiMHrQNOrwJsieK6Axe8PQZaCn/FeXC
   LzCgH0YzjCh1mg2/CNUAzvLjh3pcggSyS9AwvmvwhcFHhYrO07H2Dfw50
   Q==;
X-CSE-ConnectionGUID: V254eKMrQAusW+t/8nf8sQ==
X-CSE-MsgGUID: 5/LxCCFLS4eIENJLYfykHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83202056"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83202056"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:10:37 -0700
X-CSE-ConnectionGUID: iPAmdyPcSoamB9OOks0qKg==
X-CSE-MsgGUID: pF33BSxARYm1lMYFnHvbFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290092242"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:10:34 -0700
Date: Mon, 29 Jun 2026 17:10:31 +0300
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
Subject: Re: [PATCH RFC v6 4/5] iio: osf: add authenticated stream parser
Message-ID: <akJ818gkVzLN7HqU@ashevche-desk.local>
References: <20260628191337.937-1-kimjinseob88@gmail.com>
 <20260628191337.937-5-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628191337.937-5-kimjinseob88@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 04:13:36AM +0900, Jinseob Kim wrote:
> Add a UART byte-stream parser for Open Sensor Fusion frames.
> 
> The parser searches for the OSF0 wire magic, keeps partial frames
> buffered, checks header length and payload bounds, and passes complete
> candidate frames to the core decoder.
> 
> Rejected candidate frames drop only the current head byte before
> resynchronizing, so a corrupted unauthenticated payload length cannot
> make the parser skip later valid frames.

...

> +#define OSF_STREAM_MAGIC_LEN	4
> +#define OSF_STREAM_MAX_PAYLOAD_LEN				\
> +	(OSF_STREAM_MAX_FRAME_LEN - OSF_FRAME_HEADER_LEN - OSF_FRAME_CRC_LEN)
> +
> +static const u8 osf_stream_magic[OSF_STREAM_MAGIC_LEN] = {
> +	'O', 'S', 'F', '0',
> +};

You have already this in the header (as FourCC), use that.

...

> +static size_t osf_stream_discard_to_magic(struct osf_stream *stream)
> +{
> +	size_t old_len = stream->len;
> +	size_t match_len;

> +	size_t i;
> +
> +	for (i = 0; i < stream->len; i++) {

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

I stop here, because it's obvious that you neglected and ignored my previous
reviews. No explanation given, nothing. This is not how you should interact
with the community.

Come again when each of the given comment will be either addressed or argued.

-- 
With Best Regards,
Andy Shevchenko


