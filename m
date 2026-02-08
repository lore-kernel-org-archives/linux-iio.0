Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AE296BBF;
	Sun,  8 Feb 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770557734; cv=none; b=lnNar+wjAEpvSxIsJ4w21SLOdNCtzsOwhsM7vCkdQTePRbBu3f+nxy6WbU8zcJM85+kG4TaAb/Q5mcrwjrewlij1CO1yg+NiI4j9VXXSXNc9GJZiwZwPMS8WfduHniQ4jXvXWz3pX9DdUqSQvSBTjArXs3IQCkKyjlv7bQU4n/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770557734; c=relaxed/simple;
	bh=Rx8GsJbge18Yz1CsNIPBr247lNZh+rO9aULoGuySodA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PORAlxTHQ3amCj/RyavAVdwISjrd1YJrhsjfwIrwzTJI89/WNSTJTJy8XToaPZHzdQU0WoIoB8e6xpMGVKE3wdvqebf6RsNdfB7CEYBXbTb3qnTgXJBgpYvHEGcboecfBgS7bOBEmewsM8TAI+64V4DUkam/i7Zg4EUDxXKOj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JO1I+kK7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JO1I+kK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770557733; x=1802093733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rx8GsJbge18Yz1CsNIPBr247lNZh+rO9aULoGuySodA=;
  b=JO1I+kK75DF3SQ9nhmj/naSnoVdWz/QLgNjkV1jA6PHXDpMKWdHYVYvS
   e6k3tVC8olIRLyT0ICUcr/iRpkTbEPXABvUd0+weZK+WNnjNEYn4vkLhT
   39WS78U5N+v+fQtowdGQ+Pta7HhlVfQoDOI8d5YaItdK69eUSB9OG/WHa
   soINixDoEfMDogPPtUTN8dH64tntS8+SNtwgHJ9JBM0VMuj9zVaVOZqGN
   3OMUbXcNWY4Bb7pdxOniwa4F1YcvG13dr/RUfUWA9fIx8+J04IDmmzHrg
   jatSgmEgBMB47iAGZiC4F7p9P5+uWIU9lI2ZFemKxrQ2+o2mnWmLaGmlm
   w==;
X-CSE-ConnectionGUID: NBerXnhqQXKTOByZdtxK2w==
X-CSE-MsgGUID: IlU2qFhMQpypLYQTI28xPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83065027"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="83065027"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:35:33 -0800
X-CSE-ConnectionGUID: nErsZsTGRByEYiJdTtkHRw==
X-CSE-MsgGUID: bpVV3LFFQQyqO4GuZWes1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="210567573"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:35:31 -0800
Date: Sun, 8 Feb 2026 15:35:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: magnetometer: bmc150_magn: minor formatting
 cleanup
Message-ID: <aYiRIawCbuto7Pch@smile.fi.intel.com>
References: <20260208011659.53722-1-neelb2403@gmail.com>
 <20260208011659.53722-3-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208011659.53722-3-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 07, 2026 at 08:16:59PM -0500, Neel Bullywon wrote:
> Add spaces inside braces for initializer lists in the sampling
> frequency and preset tables for consistency.
> 
> Fix indentation of bmc150_magn_scan_masks array and add trailing
> comma. No functional changes.

...

> +} bmc150_magn_samp_freq_table[] = { { 2, 0x01 },
> +				    { 6, 0x02 },
> +				    { 8, 0x03 },
> +				    { 10, 0x00 },
> +				    { 15, 0x04 },
> +				    { 20, 0x05 },
> +				    { 25, 0x06 },
> +				    { 30, 0x07 } };

While at it, fix the style, the above is weird one.

} bmc150_magn_samp_freq_table[] = {
	{ 2, 0x01 },
	{ 6, 0x02 },
	{ 8, 0x03 },
	{ 10, 0x00 },
	{ 15, 0x04 },
	{ 20, 0x05 },
	{ 25, 0x06 },
	{ 30, 0x07 },
// also mind a comma
};

OR alternatively

} bmc150_magn_samp_freq_table[] = {
	{ 2, 0x01 }, { 6, 0x02 }, { 8, 0x03 }, { 10, 0x00 },		/* 0 - 3 */
	{ 15, 0x04 }, { 20, 0x05 }, { 25, 0x06 }, { 30, 0x07 },		/* 4 - 7 */
};

...

>  static const unsigned long bmc150_magn_scan_masks[] = {
> +	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> +	0,

No comma for the terminator, please.

> +};

-- 
With Best Regards,
Andy Shevchenko


