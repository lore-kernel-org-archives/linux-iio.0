Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06EF26ED35;
	Fri, 20 Feb 2026 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771573985; cv=none; b=oQCLJZ562zVv2NvscQZa1z8o6tJh0hlXHkrPgBerXU+48P7z0rcxLsGQyxMMTdrTk/cKRRXVZvloe/24XelVwd3p80hye9AAGz26J9iGsW8ythoz/ud6dFAFyKctngUuBu7lMjNWY/PUiuQwAPnp9Ra/vCWijgMIJteB7V83crA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771573985; c=relaxed/simple;
	bh=ry/SqBO4nEjBTGtqR5qvz+4VWZF+KIABLUZY2fBztRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMg4glAC0afUE7XkcdCnPTJV5i8NTTzOG7rsFou0d/2qXaNxpkVzH4lvS5l0B5wTWnVxIijVCLIyQJlM/+1LEysXRaZez1tRbodkj7MboAPzy6DMe0KXhlxaodvl7/Yvn5j5Nex11oKg9BZcXso9XtUa3gXXYW2pM6BGnBjtUfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTxNRW/y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTxNRW/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771573985; x=1803109985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ry/SqBO4nEjBTGtqR5qvz+4VWZF+KIABLUZY2fBztRw=;
  b=fTxNRW/yxz5vBBw40zbaAN2dqAEviT6RcUKkubDpcDR/EkrGxurLAQiJ
   eE/CTVsVjRVIl7UXREXR6SwRyVcK891MF7GX043gIn5o3bqnUvU8n3km6
   snBWIx2XW47t9o2K8ROMEHLPOETfXGCAKcnFGUzLX6LSvyA4wWAIBojEJ
   +FpOaJY48Pdag2WRC6RE63EbFiog3bKV8ssrk5nBAizhozFx1hlkHZTrH
   i1iPDVyn8RdaZfEEV2UeN208nK1Mt6hAy0ZLXSpYC19Ntws7d8YsPJOm+
   BxDRXlCH+vbnqI3jI4YfDJHGg6zimDR/ctn2Fb9HfdtrCgV8eutDIJQgJ
   w==;
X-CSE-ConnectionGUID: tvH6dih8TvGRIh320eClnA==
X-CSE-MsgGUID: fVPanSB6QiujcJzhkGazJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76281837"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="76281837"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:53:04 -0800
X-CSE-ConnectionGUID: NPMs+kk9SG22Lb5mvPfbAQ==
X-CSE-MsgGUID: tFvyDA7xQ3m7FlqBBA1ubw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="213891484"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:53:00 -0800
Date: Fri, 20 Feb 2026 09:52:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
	git@amd.com
Subject: Re: [PATCH 3/5] iio: adc: xilinx-xadc: Replace module macro with
 custom init/exit functions
Message-ID: <aZgS2c45nGTozHkv@smile.fi.intel.com>
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-4-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220053941.611415-4-sai.krishna.potthuri@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 11:09:39AM +0530, Sai Krishna Potthuri wrote:
> Replace module_platform_driver() macro with custom init and exit functions
> to prepare for supporting multiple bus interfaces (platform + I2C).

No, this is not how it should be done.
NAK.

-- 
With Best Regards,
Andy Shevchenko


