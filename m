Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937B30170F;
	Sat, 14 Feb 2026 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092681; cv=none; b=utaYSvPDs7VXHpDn8p49QUbNSCNY//Nb/1fhGM/L1lESG0GEi88ToByYYWGp6mYySC/egkE0V/G51yt1LAAHwqZxFf47XmiDQPb4RHoR5yKaGC0L9/CzJ6av4fb76bDU03eGCRSeif77Q9bqaJgaW1Y52oyD2pB/96xmMfv7j58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092681; c=relaxed/simple;
	bh=Rtw6jHf5uaxID1paObRpVDjR0hX7pGocbXMcSLXJo9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j57syLZd1h1cjMCGcsyQXozAFof1/dSvR0EJD1yX3BoHZQthTXK6+OUUSkyAJNM//JTO8SWuY8HcCs957Iai0nZcjxkiAc+tqFY9ZBhDPZZylggdQo7pzu1nh+faVIUL2b0aevLW6qMLKFzJJ9xZpN/YxhBPVZyNOJgbTeObj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZngNJRc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZngNJRc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771092680; x=1802628680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rtw6jHf5uaxID1paObRpVDjR0hX7pGocbXMcSLXJo9g=;
  b=VZngNJRclUQa1gHi4dtTXjaSYm/s1b+cClIsFY6kUb1GV92EQXDWXXLg
   3IpRtdDQCO0f9tWunO9bUOVU0pWw3SXiddBCKOAoYGUaVpj4SRKHMJo/v
   qG8KiGIywyvbshZ++RfZm7TJKMTTdbqo++ZvIIp0Kaemdp6qSrOYeyGqG
   u9jQiCSYVADpya3xIfx8ANZSp6nyraWtNZu9KdgfnpLAW0/vjnn8XE7pn
   f7EvJt1h1WL4llWrLjZfdE0KFdiJ0ktin7MmE7RRWPdIftT0ADM/P0Aq+
   JpRQiw+XTfrUrZ38zbTSuoMvZnIKmoC8W98E1h97MDrU5D1M6f4Uthiyw
   Q==;
X-CSE-ConnectionGUID: bqMbN+oBTLOFTUvq/PSUFw==
X-CSE-MsgGUID: R3bdZsphQOGvpMpdFW2GfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="72148254"
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="72148254"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:11:19 -0800
X-CSE-ConnectionGUID: BzTRWHiLQeWUU57Ns6MZIA==
X-CSE-MsgGUID: RxBwjV0BTL+Mh7+SaKa+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="212462021"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.136])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:11:15 -0800
Date: Sat, 14 Feb 2026 20:11:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <aZC6wIWDdS8J_1eJ@smile.fi.intel.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <aYiGj_TYelvJdVaR@smile.fi.intel.com>
 <20260214160852.6862b58d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214160852.6862b58d@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 04:08:52PM +0000, Jonathan Cameron wrote:
> On Sun, 8 Feb 2026 14:50:23 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Fri, Feb 06, 2026 at 06:07:12PM +0200, Antoniu Miclaus wrote:

...

> > I believe there is a better approach, what you need is rather a flag
> > to SPI core to tell that this is the device with shared CS.
> 
> Antoniu, this comment from Andy needs addressing before we move
> on. It seems fairly fundamental and I'm not seeing a reply to it on list.
> 
> I'm not entirely sure what Andy is suggesting will work but this
> is perhaps a mismatch in really understanding what is going on here.
> Andy, how would a flag work given they seem to be separately addressable
> SPI buses. I think this isn't a shared SPI CS, but rather a device
> with two entirely separate SPI buses. I think the only reason
> we are bothering to implement it as a single device at all is the
> shared backend.

My understanding that there are two devices that for whatever reason share
the same CS line. Yes, I probably misread the idea behind, but I meant
some flag for SPI device that tells SPI core that the CS it wants is shared
(maybe a high bit in the cs field or so), then CS core won't complain on
validation about using the same cs number which is "already in use".

> There is an argument that maybe we should be looking at how
> to do data muxing backends to support the more general case of two
> separate chips feeding into a single buffer, but that's a complex
> beast and I'm not sure if it is something we actually need.

Yeah, if possible I prefer to look at the (ASCII art) schematics
on how the HW looks like (connections with busses and CS lines).

-- 
With Best Regards,
Andy Shevchenko


