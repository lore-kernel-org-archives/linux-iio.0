Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A182FE05B;
	Mon, 27 Apr 2026 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321156; cv=none; b=A14uMtoq3WqHAhqSIcbmdR05K5ldqqwmthxpvt9+v3xWypbfYALIVcn+8Gefa5HZITOXMPv6x6oO5WJeDFK56gV90yk2B8fzwP7fKXkYA2oHP+wBWV35Ok3kfa3qPBeY04Y3QRoT6/uF/9iw0LXnbRHVz7+1C+Ev7+q+v++Gm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321156; c=relaxed/simple;
	bh=vuyY32Xz98zEStT0oUhg9f2SPP6xzCpf1TVVMPGuUjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6FrQpyzWuZidRxL/7AkQklq7Z2CPTVGxPefmrn7lGrknYu0IWe69+9ZbzgYUJ/1MLToVvOYEes1rm/YWOfUQToCpoRQUWZaBbaGEvbo61p6NIi2beZHTvBJTwOGf+5qAtA+jxHpbRTrfrP7A8XLNVQFBGOGHm9sAKLaYgK8xnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0DkA+xf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0DkA+xf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777321156; x=1808857156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vuyY32Xz98zEStT0oUhg9f2SPP6xzCpf1TVVMPGuUjE=;
  b=W0DkA+xfTxivhbHltxXsObhWYtK68IGocCknHlccEXhv7txI4oxgUjhq
   gYZCIH7eg62oZAKtO7x3cObpaJOlvhfDaMGl/ygnm+LsZfZvCRj7JwBxc
   Gm04c9KwYzYIsrR5U0bhbMdlFQ+OPeuwguusJAlebpHmcF1l4CwIAzlcH
   GGpTcBTcc8+SlyQmjHPzOq1Qbmx5RfEZtdB0YsbRUVW/Cn5E7r/ishrCr
   FOhruNYbcHNuwm7PYg2223odu0JY7TjSxlTpZl4LR1kufw4nUv+9yPvnT
   f9sNvQOo/Qr6pUcOjCgVjgAfVyHaHwluU3WwpxoQLmi4DlCzbgNq8LuUM
   Q==;
X-CSE-ConnectionGUID: skqd4dl2RdCYM7/ni2t/gQ==
X-CSE-MsgGUID: NMuTrIkDRACLjuL+Q6rXrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78138960"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78138960"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:19:16 -0700
X-CSE-ConnectionGUID: Ehr1vV1SSLmxVfKNbU8QxA==
X-CSE-MsgGUID: +jvh5HUfS12Kvbm0slvAkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238075423"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:19:13 -0700
Date: Mon, 27 Apr 2026 23:19:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes
 to the driver
Message-ID: <ae_Evz18JHprDPi_@ashevche-desk.local>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 10:09:45PM +0200, Andy Shevchenko wrote:
> This series is an attempt to make the driver less a rabbit hole.

FWIW, the more refactoring and cleaning up may be
- moving to guard()() - requires preparatory refactoring
- splitting chip_info array to individual data, getting rid of .type field

When I looked into them, I understood that my time slot for this driver
is fully consumed (and even more) already, so I leave it to the motivated
people.

> It's a continuation of what Joshua Crofts started doing. Hence
> it is based on his work and first three "patches" here are supposed
> to be folded to his series accordingly.
> 
> I have compile-tested them, but I haven't done full double check of
> the correctness from functional point of view. Joshua, please do that
> before incorporating into your series. Yes, my patches are assumed to
> become the part of Joshua's whatever next version of the series, that's
> why mine is marked as v0.
> 
> Should not be taken directly by the maintainers, but any comments, review
> are highly appreciated.


-- 
With Best Regards,
Andy Shevchenko


