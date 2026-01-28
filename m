Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724DD1E3DCD;
	Wed, 28 Jan 2026 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594957; cv=none; b=Y0xPoR9jGLDW3Lm5feJ2jsMARUd5R9uO/wnVrGU0719b/qPb6L7v16w54BDW46UgCn35K3u0ECnJtXzlhfD7UAEaav4mJnItsdWIMwKFiLRioz9jE443kFeuwfrBT+OClEJMzKmm6KTtC5nmKwA7zLyma81A+eqGGXbUI2UlfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594957; c=relaxed/simple;
	bh=fQR2+fRKPKr1SPYT7Dye2OabwpjQcbGHOv0mQ8n+MAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/vZ/10IDUw4hc7q36hRWakkMtcgFXiuRJrichROoWvn7S7vdEBz/m/h7LH5Tszn0rvYxNVcRLGrZs0OoUlBmghL2b9JpXcNaYpdiXzxK4kxV9jcB6bJCAgFN6QvMz+FPcswkUG+Bp5NnkMSgx8BWqOULeoHmA/npanJs4hZr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRcA0V6J; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRcA0V6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769594957; x=1801130957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fQR2+fRKPKr1SPYT7Dye2OabwpjQcbGHOv0mQ8n+MAE=;
  b=fRcA0V6Je6p9pHI7L9+CvcK8FBYmMnZeL47k3BEDfeG3fQhPIgk+yD5G
   qBz9dfbe//6gLbfrKg5e9QMfHQccFqYLYULzLR96O8PCMW3r0wkUmgwaA
   U8kx/ZM8kr0ltGFtoASzMszf4BrpCijbxA6+pQzOhNDwJX0dGZYKtz/yi
   CesGeDqLnE7QdGiH236TeLG0UzJ2ILokjBN/OGz9h6IxsKeqggvhtG2+z
   L0sAZlB8uxe4HOh60nin49scoeGJ5VUtnVdaWJ9iyz47W+KTvsfUe1iMx
   cqfKxlq2H8p358REMO3NJ2IinJWklVHf90cl1udR0t2ktrHVSQlOR4cm7
   w==;
X-CSE-ConnectionGUID: 35rxvDaeSsSDjfXRTtfmng==
X-CSE-MsgGUID: zR82WaP6Qty79AP1UuXEDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70703242"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70703242"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 02:09:16 -0800
X-CSE-ConnectionGUID: NPOPfa6JTsmz5qiDQpa+Cg==
X-CSE-MsgGUID: enJd1VjrT/agPs45kcsqOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212778403"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 02:09:12 -0800
Date: Wed, 28 Jan 2026 12:09:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] iio: amplifiers: ad8366: add device tree support
Message-ID: <aXngRcVMj18tryGT@smile.fi.intel.com>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-4-c9a4d31aeb01@analog.com>
 <aXksSjsyNn6if3eQ@smile.fi.intel.com>
 <b6pzhwmfranyhuetv65movfqzubvbjasl6ruxiym2ehuch2hov@r56lgzgf4us5>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6pzhwmfranyhuetv65movfqzubvbjasl6ruxiym2ehuch2hov@r56lgzgf4us5>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 09:55:16AM +0000, Rodrigo Alencar wrote:
> On 26/01/27 11:21PM, Andy Shevchenko wrote:
> > On Mon, Jan 26, 2026 at 01:51:05PM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > +static size_t ad8366_pack_code(struct ad8366_state *st)
> > > +{
> > > +	u8 ch_a = bitrev8(st->ch[0] & 0x3F);
> > > +	u8 ch_b = bitrev8(st->ch[1] & 0x3F);
> > 
> > GENMASK() in both cases? But I don't see why ch_a needs this at all,
> > isn't the 2 LSBs are not used anyway?
> 
> Yes, I can adjust with:
> 
> u8 ch_a = bitrev8(st->ch[0]) >> 2;
> u8 ch_b = bitrev8(st->ch[1]) >> 2;
> 
> st->data[0] = ch_b >> 2;
> st->data[1] = (ch_b << 6) | ch_a;
> 
> so no need for masking both.

This is better, but let's think a bit more. The data we put seems to be
__be12 (yeah, we don't have the exact type for that) and can be put slightly
differently.

So, something like

	put_unaligned_be16((ch_b << 6) | ch_a, &st->deta[0]);

should be better, no? (Note, you would need linux/unaligned.h).

> > Also missed header inclusion for this? And also perhaps sorting headers first
> > to see what's there and what needs to be updated (ideally another patch to move
> > to IWYU principle).
> 
> linux/bitrev.h is there, but indeed header includes are not sorted.
> I will create a separate patch for that.

Ah, good!

> > > +	st->data[0] = ch_b >> 4;
> > > +	st->data[1] = (ch_b << 4) | (ch_a >> 2);
> > > +	return 2;
> > > +}

-- 
With Best Regards,
Andy Shevchenko


