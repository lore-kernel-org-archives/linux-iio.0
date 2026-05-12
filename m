Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDB3C8C7F;
	Tue, 12 May 2026 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603132; cv=none; b=odU6Zuy+z1FeUGUpVWTy23YcjojvPAgkknRTkK3OF/7hVPYm4ZMssBdmnFhKqjdFSNqi7/uIM2Ga45zF3Pzeu3gW9oRQPS06i4/UB/84hgSYKC+F7+LMXFMj/yw7ruHHRNJ4q/IYUekxRr+NGKAp0C15hNe0n+tVi1g5fwgrEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603132; c=relaxed/simple;
	bh=oir8Xd9oD43H5F3IMnJJwoY7frrXw8F4veSRLwJxO2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gtv3Qr7BzXZ2BwYnaH504kBPxdedOTpW+DERrpZfXgmiMZWHMQ+JYHkccB1UIR4fF8hD9xDe8bbckuEJV15KdVlBqxB/vwuxLliqdNzzYyT2ms9MmFCNtc8lR2qvetejqM7IVYuIbr3s+rVFbVf4wXcuHPE1aDlxhW0HKfKJwNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnKhFonF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnKhFonF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778603131; x=1810139131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oir8Xd9oD43H5F3IMnJJwoY7frrXw8F4veSRLwJxO2M=;
  b=HnKhFonF1Ax++uMTZCHyI/wItxMwt1sLwv+xVoHHDQj+lCTY/aiKsBmv
   9uIBoSkzMxEn5C1ULJ5/+6Ic/BggveRNjOxG2MPzd2jGNLEKl/y9Tl3bS
   VUDL793ILQN0QUMzlvRz5A/8OFqgRSVhrt2VWqWC79NeJmP17V9nm7RWp
   7IKdwLF27FqBCDXw6TeYBlSifNjkq/87GsDxOm9cZr100HA8CpqQCgUHX
   5sPP+xRNgznDN9ukE7N8r+9oPSj/+dhKnsJ5QDUEVDQx0d/q5Qvh9tiis
   gU0CtVjWyZr4LUQQAn7FUpmAjXpXp1/h/SjPjVQ8xMAOQ866Zx8E9H/Y0
   g==;
X-CSE-ConnectionGUID: cJVjcPFvTByy35DST4uzzw==
X-CSE-MsgGUID: vpc6kGX+TGuNDZCfQ8IIvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79696666"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79696666"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:25:31 -0700
X-CSE-ConnectionGUID: bbSZ9Gh+QaarnnhXUXCHIg==
X-CSE-MsgGUID: wIPmzgcpToOI/gmUhKx6cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="236830654"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:25:28 -0700
Date: Tue, 12 May 2026 19:25:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Stan, Liviu" <Liviu.Stan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <agNUdXTTzXq5M4ST@ashevche-desk.local>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com>
 <ae-pvxKhqmkWwXdX@ashevche-desk.local>
 <SA5PR03MB837776014440C2594B811BF7F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af2UQ7ZLA2DL4FWY@ashevche-desk.local>
 <SA5PR03MB8377DB8F5136CC7BF9594B64F6392@SA5PR03MB8377.namprd03.prod.outlook.com>
 <agLdhvre_WrLDP3Y@ashevche-desk.local>
 <SA5PR03MB83774C631680E4E48B5655CAF6392@SA5PR03MB8377.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA5PR03MB83774C631680E4E48B5655CAF6392@SA5PR03MB8377.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 09:37:57AM +0000, Stan, Liviu wrote:
> On Tue, May 12, 2026 Andy Shevchenko wrote:
> > > > >  #define LTC2983_CHAN_START_ADDR(chan) \
> > > > >  			(((chan - 1) * 4) +
> > > > LTC2983_CHAN_ASSIGN_START_REG)
> > > > > -#define LTC2983_CHAN_RES_ADDR(chan) \
> > > > > -			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
> > > > > +#define LTC2983_CHAN_RES_ADDR(chan, base) \
> > > > > +			((((chan) - 1) * 4) + (base))
> > > >
> > > > For the sake of consistency I would see (base) also to be in the
> > _START_ADDR()
> > > > macro.
> > >
> > > I said I would change this in v2, but on second look, I think it would be better
> > > to keep LTC2983_CHAN_START_ADDR without a (base) parameter. The base
> > > parameter in LTC2983_CHAN_RES_ADDR exists because the ADT7604 adds a
> > > second result register bank, so the base genuinely varies. For channel
> > assignment
> > > there is only one bank, so adding a base parameter would make the macro
> > look
> > > configurable when it isn't and force callers to always pass
> > > LTC2983_CHAN_ASSIGN_START_REG.
> > 
> > Do the names of the definitions _START_ADDR and _RES_ADDR come directly
> > from
> > the datasheet?  Also, given the above explanation I would see rather (bank)
> > than (base) there. With this it makes less attractive for a change that I
> > suggested earlier.
> > 
> > > Happy to change if you still prefer consistency.
> > 
> > With current names they sound like they are semantically tighten, when in
> > practice it's not so. There are options:
> > - move to (bank) and leave as currently done
> > - synchronise them and use (base) in both cases
> > - rename one or the other to be different by the name, so less confusion is
> > added
> > 
> > Your choice needs to be based on the datasheet explanation for these
> > registers.
> 
> The datasheet calls the memory regions "Channel Assignment Data"
> (0x0200-0x024F),  "Temperature Result Memory" (0x0010-0x005F) and
> "Resistance Result Memory" (0x060-0x0AF). Each region is a flat array of
> 4-byte slots, one per channel, so LTC2983_CHAN_ in both macro names
> refers to the offset of a specific channel's slot within the enclosing region.
> But I agree that it can easily create confusion.
> 
> Given that, I think it would be best to rename
> LTC2983_CHAN_START_ADDR(chan) to LTC2983_CHAN_ASSIGN_ADDR(chan),
> which aligns it with the existing LTC2983_CHAN_ASSIGN_START_REG
> constant and LTC2983_CHAN_RES_ADDR(chan, base) to
> LTC2983_RESULT_ADDR(chan, base). I would also keep (base) rather than 
> (bank) for the parameter name, since the macro expects the base address 
> of the memory region.
> 
> So, in the end we would have:
> #define LTC2983_CHAN_ASSIGN_ADDR(chan) \
> 			((((chan) - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
> #define LTC2983_RESULT_ADDR(chan, base) \
> 			((((chan) - 1) * 4) + (base))

This is better. Thanks!
Maybe others can propose even better ones, dunno, but these work for me.

-- 
With Best Regards,
Andy Shevchenko


