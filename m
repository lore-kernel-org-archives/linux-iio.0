Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7F38B13B
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261066; cv=none; b=afLTjPFI0V25A7iGsgGwG2M1h/BZlSejZPtzoYqQXjM/j4kjXbPvo7YTpmXcdxs+r4kj0BKYhClkqTGxn7kvM1yPVCtmwHTT3BdmSD8vY5zvi5CpceAt+81p5twlIUFHnk+11YzucrYxuybdfEThjb1LUUIJiHHmc+8LZ6+nEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261066; c=relaxed/simple;
	bh=WiVth/Yjk8WsTmM5K+WAVbXUtSAaNgBoNpNL7H+Lk2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX7ZXOIdi+L1g/cLk0QyOf0yKB7GLgE0RYLz4AjngKFxC797Fw5WE5mHYBrv6FXV5g2pahBVB7F31/z4u0/EPtub7nUzhe49nZOgftjiad070ifLcl/b5l8d7QBV3q3at0RnU6apouIsMn3M0Lp4trIBwb6ZP1lg4ayY6qWUy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEf22lce; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEf22lce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774261065; x=1805797065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WiVth/Yjk8WsTmM5K+WAVbXUtSAaNgBoNpNL7H+Lk2Q=;
  b=YEf22lceB63TDSy1s9pi0wmjF4exPlobO66boUwugorDGAPu0RHLHLq7
   geRd/6g0DOgw6a+ZpqSuq6zpWoyJ7o9BgT++Q+ZNdswf1PAayGEt9q2VF
   3hv+Mh69XUZtMona4UjX5CgmtvbEEix4nZakj9/fOeuZvvIRypLFVltBd
   60eIEoNYULRMxp1RPYqtHPoGifXQNK5bICvW8Ty9KSZLs2EzZU0gCRcEz
   OLkWG+AFmwIOyt25vldM3XGft4TIvYE5YBjTI1t5rE8MO6bLyl4+uaF+D
   OjW3KxVX9Vby1l7Phjh21IhCjborD+LceJfblQ8aNHv5tn9MrgIdzawVE
   g==;
X-CSE-ConnectionGUID: TgDfOm2kQv6ex52ONuI0YQ==
X-CSE-MsgGUID: ErQkIfkGSS2yFzgWtzwDzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75161955"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75161955"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:17:44 -0700
X-CSE-ConnectionGUID: ONSOmc0oQQqn2sVGVRrcGg==
X-CSE-MsgGUID: 41fun+r6RjKVZzNTqdCXBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223054102"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:17:43 -0700
Date: Mon, 23 Mar 2026 12:17:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/3] staging: iio: ad5933: use sysfs_emit() in show
 functions
Message-ID: <acETRAk28PwZtfW_@ashevche-desk.local>
References: <ab0BHU8zNOUIAcJf@ashevche-desk.local>
 <ab7NEIlXcg3BMmE8@MacBookPro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7NEIlXcg3BMmE8@MacBookPro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 21, 2026 at 04:53:36PM +0000, Gabriel Rondon wrote:
> 
> Thanks for the review.

You're welcome, but...

> I didn't tackle the switch resplit or the modern _avail patterns since
> those would be a larger effort toward graduating the driver to
> read_raw/write_raw/read_avail.

...please, do not send private emails, answer directly to the ML.


-- 
With Best Regards,
Andy Shevchenko


