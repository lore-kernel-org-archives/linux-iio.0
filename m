Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3F2E7377;
	Tue,  2 Jun 2026 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442785; cv=none; b=DfEvSkEbIV19pSfxYnEMJX2ScnGEM37M836jd4g6ychr9qq73GnDUnGIYThVMsvSGOd0/jFR7GbJadtzIiAet3ybpoZzoxgPwE9UJlHC8wkIiqF044cP0VoO8m7zlQ/AnIZlCEKSqbVapsMZ4XlYvbBGXpmlFudDbzJ4xbylej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442785; c=relaxed/simple;
	bh=QGQl6PrxfpFW7oYOLRcgzqLW2On5b2Tn6RWF+qE5paQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJIsonfwZN1ZeMcIzR3b90rvOImzSd5FdC8WLxYMRRF50RAj5wXBzWs+BC2/wDsTtI+VpR1fOMQCm75N8SkZOCbc0YxsqsJDqCxJYsc7f4vdv8C6RRuW93Ou5GJI8e0NOJh1AnEZM4Q37wjdvbcs2GY+hlZnBO9k0I/QBZ6Mn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZ1bwulk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZ1bwulk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780442784; x=1811978784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QGQl6PrxfpFW7oYOLRcgzqLW2On5b2Tn6RWF+qE5paQ=;
  b=jZ1bwulkppKtpO/BlwIlolN2N67plfbxCW2idhWRGpmqS4erz+0meeZ5
   mqL5AtKTMcwpRYBxdxui4EU1yZXXtXdiOFs3jS5yFEjoN/uehJ31XhGgP
   2oWDKAs17Xapykn6yD3zKhkwPloqxxDcM2rbZ93tnZb5uSglC425xAIOZ
   ySNSp4OEhU4nnITrvvCiFghnWgrz1MO88aAtR2dnqeORbLxPaBiQAFZSW
   o6aV9y7SWvJgZ4t2QxglZXtdLDgfGrcBzzCdBC1yajQq7e8slS7ZO2h7m
   IaNThmMRM4zBSWy+WDHDou+I/4qW/8UnSurDQIcq+IWoCH6rIfemSmEGW
   g==;
X-CSE-ConnectionGUID: R4jU2UscTDemzNqRVypqow==
X-CSE-MsgGUID: NZDpcPuTRqiEdTkd026uyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81216465"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81216465"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:26:23 -0700
X-CSE-ConnectionGUID: lNGt+u/6SYaLIHZiFi7fIg==
X-CSE-MsgGUID: 0+Sh8CmDT1Cid81i68sUTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="244158327"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:26:19 -0700
Date: Wed, 3 Jun 2026 02:26:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Liviu Stan <liviu.stan@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Francesco Lavra <flavra@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 6/9] iio: temperature: ltc2983: Use
 fwnode_property_present() for optional properties
Message-ID: <ah9mmYljbmNNR4YO@ashevche-desk.local>
References: <20260525164013.118614-1-liviu.stan@analog.com>
 <20260525164013.118614-7-liviu.stan@analog.com>
 <20260527171945.152279fa@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527171945.152279fa@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 27, 2026 at 05:19:45PM +0100, Jonathan Cameron wrote:
> On Mon, 25 May 2026 19:39:33 +0300
> Liviu Stan <liviu.stan@analog.com> wrote:
> 
> > Checking fwnode_property_read_u32() return value with if (!ret)
> > silently swallows meaningful error codes when a property is present
> > but malformed. Use fwnode_property_present() first so that absence
> > uses the default while a present but unreadable property returns
> > a proper error.
> > 
> > Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> Applied,

With const char *propname defined this all may be made much shorter.

-- 
With Best Regards,
Andy Shevchenko


