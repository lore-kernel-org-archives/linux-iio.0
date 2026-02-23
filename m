Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3DF361DB2
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858992; cv=none; b=XJhQ9mNq6avUUBcHQP7Vqr/Izl9fbY4FyuiL4VfzfbfeVgwnvd7/Gv5QoZY0H6N8lLi1eH4nCIhxz6i95vm8pLwnA16+rmQEfdK+SRFQsz4woF3LEW8EleRreQxRBKwmdb/P9yp+l8BFRv10ouTUVNEZvSS2RWBo+u+Yvx0MpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858992; c=relaxed/simple;
	bh=pn+rpUJIKeXi+YrPzLehJJgfIVEmZzFiakrrlP6LgS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDuZefr8cT9bpLhqvhAOdwRA1Bh3Mbp3HgSXHS1P67ATFvjHZhnCRbtI9Gq6Q/B6Lp+qHGKFyukDoXtmFSoJNdSxbYWrhwubRYfby6XELbqsOQ6VGbKiybXD8lF01fHAy7hXczKdpR1Or4wJGrftiUSO/ERgifSFBy1GFZ8C+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gu1T0cVs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gu1T0cVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771858992; x=1803394992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pn+rpUJIKeXi+YrPzLehJJgfIVEmZzFiakrrlP6LgS4=;
  b=gu1T0cVsxGbhd9mWA1fh7M4Ukzm5mDq7Sz7byOMTU9hjmwwnDJjznYY4
   phYOP5uEXX+wMRw2mk7Z5as8KYhdmXjTGZCFq2bJM3rHRB+cJOcH7qPmX
   hJNsHGoc4O/yDdQjaT5BjfWO813aEjrOQaDItXJ3NjXKRTSO1zMeKDdvt
   x+Z7FiWp91aYu1+Qfz9h553k74pnu3iM6/97rhn3ojLtpVRgdJ0/WjVUT
   nxsS84WT0eHo1t7SUaTh0Jc2qzAbuo/gETbHzV+BvZT/V38gCH6u90Upg
   9MSTX0bmpo/i21TGGhjLG6+NTeaWDUzcZbmpE/JTck2x90gvG7AbRiuqv
   A==;
X-CSE-ConnectionGUID: a1qomPmXQdmFxm2Z+lw0LA==
X-CSE-MsgGUID: 2gmzgg03R3a/vdHNmxrm1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72756380"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72756380"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:03:11 -0800
X-CSE-ConnectionGUID: OeCZyrtOS1ybSy/s1gA1VQ==
X-CSE-MsgGUID: utcy5WK7RQOsyBDDz1Co2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="220583740"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:03:09 -0800
Date: Mon, 23 Feb 2026 17:03:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harpreet Saini <sainiharpreet29@yahoo.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging:iio:impedance-analyzer rename camel case text
Message-ID: <aZxsKlQXkB4or9-d@smile.fi.intel.com>
References: <20260221091424.56822-1-sainiharpreet29.ref@yahoo.com>
 <20260221091424.56822-1-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221091424.56822-1-sainiharpreet29@yahoo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 21, 2026 at 04:14:24AM -0500, Harpreet Saini wrote:
> Rename camel case text. This was reported by checkpatch.pl

CamelCase
:-)

Missed period.

...

> -#define AD5933_CTRL_RANGE_2000mVpp	(0x0 << 1)
> -#define AD5933_CTRL_RANGE_200mVpp	(0x1 << 1)
> -#define AD5933_CTRL_RANGE_400mVpp	(0x2 << 1)
> -#define AD5933_CTRL_RANGE_1000mVpp	(0x3 << 1)
> +#define AD5933_CTRL_RANGE_2000_M_VPP	(0x0 << 1)
> +#define AD5933_CTRL_RANGE_200_M_VPP	(0x1 << 1)
> +#define AD5933_CTRL_RANGE_400_M_VPP	(0x2 << 1)
> +#define AD5933_CTRL_RANGE_1000_M_VPP	(0x3 << 1)

No, these all are pretty much fine, they are for physical units.

...

> -#define AD5933_INT_OSC_FREQ_Hz		16776000
> -#define AD5933_MAX_OUTPUT_FREQ_Hz	100000
> +#define AD5933_INT_OSC_FREQ_HZ		16776000
> +#define AD5933_MAX_OUTPUT_FREQ_HZ	100000

These are okay, as it's historical suffix for Hz in capital letters.

-- 
With Best Regards,
Andy Shevchenko


