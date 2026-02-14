Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35D2E2EEE;
	Sat, 14 Feb 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093349; cv=none; b=umwdeBcSn+0fVtfvjKbmFFckjgCdLOPDzGfcAaDVaz1cSDRRwdz95UIRhNYhtuYIXeAnjrB/bMDXNSa/Jtq81sRs7OGI2M0C9297QDBh3buN4Pfx0r/ndQ0/zAB2tJFFwvvEPnc6TBrVdsBnIdeZRYeZrcK6+NAcUVFP1J6KJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093349; c=relaxed/simple;
	bh=lNKIcGPNqRgGXmuKJP+Hf+FMA5ivSd9ABI5saGRhjLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TS9b3tnTGdD12YoI77XNvoFboDusAl07D7Y1f24xN4pdBDv5k54rcCcbKxq77+rp5RqgXi5ftoIDv2g2/bkJZFRih4MpLuD3g8TUhSp5MO6UgtiPEXLngkPxoeTT4RbAMZz9KrmUer8H3Nj+YAuqE9CcLDwD9X/hOfAxVV7wJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCDS3PFb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCDS3PFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771093349; x=1802629349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lNKIcGPNqRgGXmuKJP+Hf+FMA5ivSd9ABI5saGRhjLM=;
  b=PCDS3PFb1nhniX9FT0BzTb4ncI8p4enslMzYs8yetRONZ56mCRnUDzoW
   tk++74KmA9JVcKQSxrxuwqYepBumMS+bUGxhuF9NAYQxvvKg7TmOWBnsz
   sArDjYz7vDamwItgbENeD5iDO9rP2KhNSJAPau1tgkV7792fWarrsHXf5
   +Sa7ObseBPTHGUWqkgaYLRL804Woi6EDRs3UkcMsQgv5Sdgqp9twOyosT
   7dwYVFBjUH0CZSL/EV+ltrZnu1YOBqFOUS4spS8o4ld3NL2dlbwIlTTp3
   qv2/0GEc3GmxZ58U8UOEZGPdbjFVPhoZqbahk+0vmI9q5a+0DvpWYfdgp
   w==;
X-CSE-ConnectionGUID: uVpw7W70RHSNVutI9LpFvw==
X-CSE-MsgGUID: bEVLyrRHQOeaQfjvqQmeAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="71273631"
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="71273631"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:22:28 -0800
X-CSE-ConnectionGUID: SHjIc7TxTI2FzLUjWV4bgg==
X-CSE-MsgGUID: Ii2aTK8xR7eliHo1dzkskg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="236196327"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.136])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:22:25 -0800
Date: Sat, 14 Feb 2026 20:22:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Taha Ed-Dafili <0rayn.dev@gmail.com>, jic23@kernel.org,
	rdunlap@infradead.org, skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: accel: adxl345: Implement event scaling for
 ABI compliance
Message-ID: <aZC9Xurq1KcVHuMT@smile.fi.intel.com>
References: <20260208150515.14798-1-0rayn.dev@gmail.com>
 <20260208150515.14798-4-0rayn.dev@gmail.com>
 <af774bb9-817d-4d88-9fe3-54468949ea54@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af774bb9-817d-4d88-9fe3-54468949ea54@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 11:02:22AM -0600, David Lechner wrote:
> On 2/8/26 9:05 AM, Taha Ed-Dafili wrote:
> > The ADXL345 uses a fixed threshold resolution of 62.5 mg/LSB for
> > event-related registers. Previously, the driver reported raw
> > values without a scale factor.
> > 
> > Implement IIO_EV_INFO_SCALE for all event types to provide the
> > conversion factor (0.612915 m/s^2) as required by the IIO ABI.

...

> > -			BIT(IIO_EV_INFO_ENABLE) |
> > +			BIT(IIO_EV_INFO_ENABLE)	|

What's the difference here?

> > +			BIT(IIO_EV_INFO_SCALE)	|
> >  			BIT(IIO_EV_INFO_VALUE),
> 
> Would be nice to be consistent and put scale after value as the ones
> at the end.

Would it be better other way around to avoid unneeded churn with touching
the last line?

-- 
With Best Regards,
Andy Shevchenko


