Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B77627707;
	Thu, 25 Jun 2026 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368341; cv=none; b=Uam8Td/YxWcYsVEqBY/T1iQMzi9UIwjZBJ9JlCeSFiM4xNPA05m8zGA4lnHAUSLF9bMuEgaV3e/o29lI0yaLqAJXxjRXDMDvkt2kbzKdo8I+mjk2Jv9x0W73NgDXL3g1xfuP5wOkkvvxu/FNgqGvEWyUSQd/abcH5w57cD+tswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368341; c=relaxed/simple;
	bh=5UfdcDkrQQMoT8TQhTuG8JX5EnuIVJaZQF9+WaJbFto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFfZheo809ISzDjZCcQA2DwEj6SSfvzw4T6hBHnByn/hAb4ahyP+tAHtWufxFqad7Qol+koQrTBFhkUz3lfSc38xJskyobZWNZBbhWroWcfR/ouZ7Gs0OmnBnzwD97QP3lcF+/95nsUFAY9HdhadliLd7MJih1sJnD7nynWVLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJTIBxY4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJTIBxY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782368340; x=1813904340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5UfdcDkrQQMoT8TQhTuG8JX5EnuIVJaZQF9+WaJbFto=;
  b=HJTIBxY4Es7NmRKsHDjlO6/JkK4/fpk9biiXD8IC3cbih6thpZlQdzsT
   VRtGfjPKb24muHlFoi4AlE/db0v80+wBfAzfXHplUSORPbg47DccVFTUr
   u7XGfGdnk11RO/mEkIbR3f69njNggiMBSnAKe9dsqFjHzouBbsHeLMxOy
   sl6st/QaeXsMFHGEyPpTh3KPJ1sd0oLpub7oY9zpLyi2KGmmmcyabAHv4
   zqoRlb10EHBXyhUlukiyl6C2yxZnYRjkyoRP8I+gKGCg+PPQiW32p8ASN
   MoE0xSNN+87GwJa4/36cNvByIsRPcmF3g4t6od7gxmSl0+DfJt+0rtFDj
   w==;
X-CSE-ConnectionGUID: eU7uxNLBTGuhFK40LIe7oA==
X-CSE-MsgGUID: TduIY0tzTl2WAYK2/WsHug==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83330836"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83330836"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:18:59 -0700
X-CSE-ConnectionGUID: JgNMyVBiQT2EbX7G2VXNiQ==
X-CSE-MsgGUID: 9Z1xO8g3RhmLiZkqmVAnVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="247277739"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:18:56 -0700
Date: Thu, 25 Jun 2026 09:18:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lukas <lukas.metz@gmx.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <ajzITsIHJAWYMCLv@ashevche-desk.local>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
 <ajrg62FtXNObGkmc@ashevche-desk.local>
 <ajvt5J5Cs5cOdTLt@berta-MS-7693>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvt5J5Cs5cOdTLt@berta-MS-7693>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 04:47:00PM +0200, Lukas wrote:
> On Tue, Jun 23, 2026 at 10:39:23PM +0300, Andy Shevchenko wrote:
> 
> > > +		dev_dbg(dev, "%s: val=%d val2=%d\n", __func__, val, val2);
> > 
> > No. Is it RFC? PoC? Or production-ready? If not the latter, come when it will
> > be production-ready.
> 
> I will remove the debug print. I tried my best to make this driver production-ready.
> I saw that other drivers also have similar debug messages so i didnt
> remove it after my first tests and thought it is ok to leave it in
> there.

Debug messages are different. And in IIO we don't have them (perhaps some
historical leftovers or corner cases, dunno). If you have an example, share
the pointer, I will check that. Perhaps we can drop them in that driver.
(The debug prints like above are fine in the drivers in staging, but staging
 is not really accepting much nowadays, so it's not the point.)

> My intention was to try to apply the suggestions and comments i
> get and send a second revision. Do you think thats the right way?

That's the way how it goes. You address all or almost all comments,
send a new version where in the comments you need to explain the
non-addressed pieces ("why?" they haven't been addressed).

-- 
With Best Regards,
Andy Shevchenko


