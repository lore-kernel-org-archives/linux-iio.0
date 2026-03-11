Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4E2DCF6C;
	Wed, 11 Mar 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244493; cv=none; b=QmCU4jmyImDCZFTesUWPCqaYKQfNRUjPbPBE0teCXv4KKL4TjJJhFBTySzqqX/Vr53I2TcqO3ebCkOcnSAQJU97uWAKi0CKm6nmMPEf+Qzh53bVKpX+W7zRE655wKin72uasnK/FWGGg8ldBm+3ZVGxq8JTOqZR70ZI1aELg/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244493; c=relaxed/simple;
	bh=xcSvTOO0GXndR/GwQixypGrHYhD11o2aTKZ3MudGlyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8gHhPed29lpjSi6QDasWkeMolzBm1pVm35BUuqQt8v9un+Z2+vC0UvgyeMdFXFpqY9RuLSbu2OhRAbNSsa5bn+NaWwoYQlxyu5LICAAZiqa/yuIcIxMJRvktmdudXdS+7wkDKLWljrkIRD/9addqCXhWm6Z30aArfFwn0p4Hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6GhNtbX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6GhNtbX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773244492; x=1804780492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xcSvTOO0GXndR/GwQixypGrHYhD11o2aTKZ3MudGlyM=;
  b=f6GhNtbXgRet+JX89BgC0PYT06WdeBe7yVXTXjYT6AwSsX1sO2Rq7Cgr
   ZXFvTpzE4t9MMpdt+T/Y4IKiVkRSK/au6ez5DusZlE8xwf4M0AjA/lpSg
   ajCcibuPDl00UREUxWp7MWvNFH2MZXfj2RHBRq2DcVkg/DmmvQDLmgKe2
   hDcmYilrDuBd9eaG6sPruQBWzt54kGKTQ7CEW8m6Z1SCaZnjtHWTExh3P
   918oEK6UpjQdneDlhOi6F10zr7OgtiBvRL5HMqyodP2WISrI4RA4juP5a
   SwRNqMqYktXippjBlgn752X0M0vipPATiCdb+qV0DwGgXE5xDFkqoPG1B
   A==;
X-CSE-ConnectionGUID: BVwGYS4TRViP5+MWgKj1Cg==
X-CSE-MsgGUID: KYIy7QDRSP+q7sT43WV2Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="61895632"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61895632"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 08:54:51 -0700
X-CSE-ConnectionGUID: 4IR9kl8jRJyuA20Wlfcv9Q==
X-CSE-MsgGUID: g4bCuECHRcWKpTbTS8oMmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="251022426"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 08:54:47 -0700
Date: Wed, 11 Mar 2026 17:54:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Raymond Hackley <raymondhackley@protonmail.com>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: add regulator support
Message-ID: <abGQRYxnJiEXXTiq@ashevche-desk.local>
References: <20260311-vcnl4000-regulators-v1-0-66b6038ce563@gmail.com>
 <20260311-vcnl4000-regulators-v1-2-66b6038ce563@gmail.com>
 <abFejMb3uLbg4fiu@ashevche-desk.local>
 <9e5babd2-3e11-4c79-9192-379b11392a58@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e5babd2-3e11-4c79-9192-379b11392a58@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 11, 2026 at 02:40:00PM +0200, Erikas Bitovtas wrote:
> On 3/11/26 2:22 PM, Andy Shevchenko wrote:
> > On Wed, Mar 11, 2026 at 01:38:03PM +0200, Erikas Bitovtas wrote:
> >> Add supply, I2C and cathode voltage regulators to the sensor and enable
> >> them. This keeps the sensor powered on even after its only supply shared
> >> by another device shuts down.
> > 
> >> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> >> Reported-by: Raymond Hackley <raymondhackley@protonmail.com>
> > 
> > Where was it reported? Do you need Closes tag?

> The report was done outside of LKML, in a Matrix channel.

Good, next time don't forget to add this type of information in the comments
block, so we will know why Closes is not accompanied with the Reported-by.
But if that channel has web-available archives, it will be good to have a link
to it in the Closes tag.

-- 
With Best Regards,
Andy Shevchenko


