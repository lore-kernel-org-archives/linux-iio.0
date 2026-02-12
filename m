Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495B284672;
	Thu, 12 Feb 2026 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904127; cv=none; b=g4FQ0IZAMyU0gtjkfzg4Zrpjl1+BieOLpl4m1TI451lx96bMo+3oZX0IsJFaGKPdrEQVXEYjFNOC2Ry3uJOlRVs3ITMBKfwZH3MZqPHLCs8Y3+h5ZvNTDghXYJmMHHBYtf8yjNqSge0GKWUq9W/QU3QIBuZWCzGkMI/eBJvmfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904127; c=relaxed/simple;
	bh=G6CewyQM0iyQBtz+5m+6B7XFVTgo6HLMvUfuGTCRy9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJiYwS8Q5eaSdoBNrj12/vTKCJ3TFDIm6gLHra1eyR4T/ekzAc5FjHB1tOQMSxZq1vCElTkzHSEwOJTR4LFN0N6jzpP0ipYYCw2W1M58A5L0CBc6JgplbABltY3+ICVsxFCYzQqyvJNWezwfpoR0T6bL9wxlT/qEB049f7jJn+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXCfm8Q6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXCfm8Q6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770904124; x=1802440124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G6CewyQM0iyQBtz+5m+6B7XFVTgo6HLMvUfuGTCRy9g=;
  b=AXCfm8Q6asGp2IgjuwF7+wOqZ4H8aIzmmHbNLr3ET9uzTAaM2jds5efG
   BCzDxNLWbMAdkft5J7uOPxao9LCXNDFQM5XNsy3pRVACGkqlyfkPHLDL3
   AA8tr9IAo+6nwV7zHki5htm/LwGmoExwZCFcOmvGQgb2lgkBAVGhgCHPX
   at4XGOaX8Gpe5MSXoo+A2Iizv3Fk4AKpI0YxdHO0f15cZ5ljNceU3Xwr7
   Jqx5YvLvzz31Bn8ESbNpknkbE7rdBWpgdRthzu8FgvMVBp8cYKokndu5c
   S6LtROmZR0XVQMSWUcE/pHjn/lWzYzqBMTUlgptrtLnAr08n+2UhOd+tS
   Q==;
X-CSE-ConnectionGUID: fnrw4WgQTyOTUkqLpNJ5LA==
X-CSE-MsgGUID: pMLrbwEdS1yEq38hZ4GXzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71977919"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="71977919"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:48:44 -0800
X-CSE-ConnectionGUID: w+OZq9+vSnKTbpUFab5EHQ==
X-CSE-MsgGUID: VWNV2VzaSL6tVekUWgRxwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="212707836"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:48:40 -0800
Date: Thu, 12 Feb 2026 15:48:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yasin Lee <yasin.lee.x@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: proximity: hx9023s: fix out-of-bounds access
 when copying firmware
Message-ID: <aY3aNubqU4_41ohi@smile.fi.intel.com>
References: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
 <20260212-upstream-20260219-v2-1-2b28fce5d09e@gmail.com>
 <20260212-lush-monumental-grouse-e3903d@quoll>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212-lush-monumental-grouse-e3903d@quoll>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 12:25:54PM +0100, Krzysztof Kozlowski wrote:
> On Thu, Feb 12, 2026 at 02:26:52PM +0800, Yasin Lee wrote:
> > Initialize fw_size before copying firmware data into the flexible
> > array member to match the __counted_by() annotation. This fixes a
> > potential out-of-bounds access that could lead to a kernel crash.
> 
> I don't think so. Code is equivalent and this was just false positive
> because compiler could not deduce that in this case counted_by can be by
> fw->size.

In accordance with [1]:

   When finding the element count assignment, it must be reordered
   to before any accesses of the PTR->ARRAY itself, otherwise runtime
   checking will trigger (i.e. the index of ARRAY will be checked against
   COUNTER before COUNTER has been assigned the correct COUNT value).

[1]: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci#L3

-- 
With Best Regards,
Andy Shevchenko


