Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217E367B8D;
	Tue, 16 Jun 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594114; cv=none; b=TOLux508tE+t5O2aO7T+gQWnvM4Co/bINVp1fNXhTJohHz7kLjJTKLhaAdWWEAQPN9nRIs+oiIWA0hbRmZs9pHIrZ2ECGATTK9KLYjZk2IvGa+PMpt1wIoC59AytR/ITVhfHlOzhNycI0m/x0sQKBAUx7iQX5tq4hLrF9CI8dzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594114; c=relaxed/simple;
	bh=suM1vaBZzxEvLorQ3UANqC+a9M8bRtbGMzN7Lvb1LXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnWV5C2G0Dvn2hnHMqPcP6UEDlg8hyIZAf5Nz8nuU3+Y8I3Hizdo3x3J6P0UgJEqvByNnaj8nO3DV+wKWeEk2CeZg55Nzg/RFiFhe8zByfBse+HosV/i+ELCGTdG9piEFKdksk6fbSsrxeke2ZYS7Gytz6vSORq50FaahkfljhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yob9Z+GR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yob9Z+GR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781594113; x=1813130113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=suM1vaBZzxEvLorQ3UANqC+a9M8bRtbGMzN7Lvb1LXQ=;
  b=Yob9Z+GRum0/dwjpbDRQbeisEYcz+tLwaLZe03o2OwdUNq9oUlR59cBE
   6o5J50DTHEIjAxzX4xzDzh0HcEDu+hvZXFNUkavlVQpYDnoPGYhrx7b2d
   mQ4VrMtVUr9VmkSEbcZQXkugCnGEsuDbjOjZzdwHPcNBO//ZRqmz9IzTN
   Zhika8VzLerfmTxr3xHmNPLjYbBYUEAlBIR5fHDvVfmfmNgHw5r++ywu7
   kQYw0QATgF0craFryqispRf4MgzVcYK3uh2bUxRvh34kfsXP/Rp8Nn0Go
   +aaj17gOC3HDdwFw3R+DqYN8wGq6H3CsKQdWljbMgSmPOc4yC8wAH0Q0H
   A==;
X-CSE-ConnectionGUID: 9C96KiKORBCVNInEIt7T5w==
X-CSE-MsgGUID: J3Cu57cqTqqZenWKg2Sy0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82454972"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82454972"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:15:12 -0700
X-CSE-ConnectionGUID: Js6zgKzFS8OBjoiBuyjWtg==
X-CSE-MsgGUID: 9l4PRjvRTume6H6d4EtCeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="241314568"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:15:08 -0700
Date: Tue, 16 Jun 2026 10:15:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
Message-ID: <ajD3-tbA4TvKMj1Y@ashevche-desk.local>
References: <20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com>
 <20260609-mt6323-adc-v2-2-aa93a22309f9@protonmail.com>
 <20260614182214.65d052e4@jic23-huawei>
 <E5H72l1Cg-JQGpaYAFl5TIyITmghqMsTaHQTR8VkuFtlzmfCGTpVlceNp8c2BDW7UoheO0Fx6NLJHmu56WHRNWdPNLsaoIKMCftj_bnyvEI=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E5H72l1Cg-JQGpaYAFl5TIyITmghqMsTaHQTR8VkuFtlzmfCGTpVlceNp8c2BDW7UoheO0Fx6NLJHmu56WHRNWdPNLsaoIKMCftj_bnyvEI=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 10:52:57PM +0000, Roman Vivchar wrote:
> On Sunday, June 14th, 2026 at 8:22 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 09 Jun 2026 16:31:59 +0300
> > Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

...

> > > +/*
> > > + * The MediaTek MT6323 (as well as a lot of other PMICs) has the following hierarchy:
> > > + * PMIC AUXADC <- PMIC MFD <- SoC PWRAP (wrapper for PWRAP FSM)
> > > + *
> > > + * Therefore, PWRAP regmap should be obtained using dev->parent->parent.
> > > + */
> > > +struct mt6323_auxadc {
> > > +	struct regmap *regmap;
> > > +	struct mutex lock;
> > Locks should always have a comment on what data they are protecting.
> > I think this one is about protecting the state of a device during a channel read
> > by serializing those reads.
> 
> Nuno said kerneldoc looks unnecessary on v1 [1]. How the comment should
> look?

The comment near to the member:

	/* Why this lock? */
	struct mutex lock;


...

> After these changes, should I keep or drop Andy's Reviewed-by?

Keep it, the above mentioned changes does not affect on that.

-- 
With Best Regards,
Andy Shevchenko


