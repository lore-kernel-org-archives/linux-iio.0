Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A3330313;
	Tue, 17 Feb 2026 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331678; cv=none; b=YlzoSteRbDbG6qlfQXqtWclmkC4NNrAXnEdnOghWLQEP45HBTwf5L0kvbrr4QZ0AlKTbGS/XgC3ztZC1pGWONfSmjYFhHw95NGBDsLcjvZ3nNU97DBsIFDyytb6FwF+YDPPBXes0nY5Qt0OKG40b3k+yGzQ1zpwBKKsXg/YTpqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331678; c=relaxed/simple;
	bh=ps2JQbMMBe7HNeNKMtaXs+psEO5BlW34P2MtxOKEKlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhQaPZR7B/Qr2waHz4z/OxdBm+euCWg8B5o9UtEMIxCScfb+PEwrqfokxBwMj3d9eE3z+kPR3yDo/g5iIVXn1GcOjmQ2bqfWF9M5gR3Lkoiy3jLSd/dhHdIXLoUu8H+5S4lHm/MDIeuigsqY70ytVP1VpLJx3Dp1YgHIoF2oi4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2Ap+dpp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2Ap+dpp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771331676; x=1802867676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ps2JQbMMBe7HNeNKMtaXs+psEO5BlW34P2MtxOKEKlA=;
  b=L2Ap+dppoxjLlu16R9Ou+elUObcx7FOZjvqPml8gjFGC2Ty/jEKTqXeq
   zRlXDc2mbbpzyMe2CkJ4zsfQGPKFzjcFE+aLyyAbBOQlR5ZxAhte64wXq
   HKS96/9v0eIOOlpY+puQddjpAHIGQmaJufgOuigTd70qmKT+DSE4rk6Bm
   0nmmXvle1cC7vnINqlZAZhkoHp+h/grOYQI9t84f1n0TfurPK/9HVyf8a
   W5DEdibRdmaoOTNHmrEbB3IKk5PtTAIYoO+aczVtOfLna51s8gtkXqtOl
   i3Y8553OMGEKO1bDWTUu9TVfwqDSgpSY/UFas3DSOVh1odXkitfv5ReOe
   Q==;
X-CSE-ConnectionGUID: EEGsQMQ0Rm2+A5nVprSiDg==
X-CSE-MsgGUID: /YzHGQNyT6O1laLk1G2EAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="97858347"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="97858347"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 04:34:35 -0800
X-CSE-ConnectionGUID: Jg4Otk/uQmiIDyReM6qF0Q==
X-CSE-MsgGUID: t6sdRDg/QFaEe5DeEUegpg==
X-ExtLoop1: 1
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.123])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 04:34:31 -0800
Date: Tue, 17 Feb 2026 14:34:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v9 5/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <aZRgVGJXN-EFsYLY@smile.fi.intel.com>
References: <cover.1771253601.git.marcelo.schmitt@analog.com>
 <20f1dc8eb6bb692eb6eb814a49e54309d973a9e4.1771253601.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20f1dc8eb6bb692eb6eb814a49e54309d973a9e4.1771253601.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 12:00:39PM -0300, Marcelo Schmitt wrote:
> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve such
> high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates. Add SPI offload support for AD4030
> and similar ADCs to enable data capture at maximum sample rates.

...

> +	depends on PWM

Seeing this without being mentioned in the commit message is confusing.
Would be nice to add a sentence explaining that "The offload is initiated by
pulses from PWM..." (or in your own words, but make it clear).

...

> +static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, int freq_hz)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	if (!in_range(freq_hz, 1, st->chip->max_sample_rate_hz))

Hmm... Isn't it a off-by-one issue here (because the start == 1)?

Maybe

	if (freq_hz == 0)
		return -EINVAL;

	if (!in_range(freq_hz, 0, st->chip->max_sample_rate_hz))
		return -ERANGE;

> +		return -EINVAL;

?

> +	return ad4030_update_conversion_rate(st, freq_hz, st->avg_log2);
> +}

-- 
With Best Regards,
Andy Shevchenko


