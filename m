Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F2374E7B;
	Thu, 12 Mar 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326065; cv=none; b=sOwpwrVqBJ1alc8RNSQ///cbP1SCMYW+v5QVf4oolh4KKIptMWNGDXQszDny979DcmUB37yt5SbJ3GP3iep3tomTiISNbd8zgf8oQpKr9aJbbYxRZkdIezlMPr5uu0ODc2aAWRDA9q3zhJiZaAOPm+E+i0bYhFtD8znDSyd2Iyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326065; c=relaxed/simple;
	bh=50UlWdpo4UwffLN54xOigvqnJA64XuPRf4Pt6HP7vM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzXGaO9GL4dCuBqv0xbwsQ7OqmgSgmhNmQvN8IgSUDOImJSRJp8n4GDro0ZfsZMqU58zggODLCb6+ICIlOB1zi5KwM0CLN8aq9MLLiOgq5qImR0UK5jNuf3QHMsoIvCVEKc/8sqm60XrCRyOkZ7lVX9L6VY4B4G3DTuz/bK0I38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xww4WkPw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xww4WkPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773326063; x=1804862063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=50UlWdpo4UwffLN54xOigvqnJA64XuPRf4Pt6HP7vM4=;
  b=Xww4WkPw+swtnqTQGPv4MxX657CDqF6qg5D7cOlIHHFyEc53Jah0QVKc
   lpD1UKEhByP1/+fngxi0T43D7X1jc7II1BD+K42aaY/emlNpiiCNo9m9x
   VFEm4BVCtcA/nAEVdaAtFaT1m6B0+uzA5xqWuNTHhUXdnOyXb23CcXOyL
   y5liZNWY5eY00S/6T20sEGFor6xL20DnMQ04uuHWNc/y6PwwetiBVCofp
   EiohpQwi3ryf6URPoY1VPbsX/wCbSunO2Kd9zrr1biZ6wnTg6Qc26VGhd
   YV+dH4o5yf5Hr6+kC4dN50UyqR2qZ6a8CCvwcDEXEvKznG/MX6UUWMNLe
   w==;
X-CSE-ConnectionGUID: TOpOAP4WSqejU0fLnQL1rQ==
X-CSE-MsgGUID: i5vcPBf9TQShP5wRHEsZgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74333739"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74333739"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:34:22 -0700
X-CSE-ConnectionGUID: 5MYE1Ln5SJGuW9hA4OG8Kg==
X-CSE-MsgGUID: 9KEmiLlnS9i3uMbLaDV5jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="216949108"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:34:19 -0700
Date: Thu, 12 Mar 2026 16:34:17 +0200
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
Subject: Re: [PATCH v2 0/3] iio: light: vcnl4000: add regulator support
Message-ID: <abLO6fztE9Tng1EU@ashevche-desk.local>
References: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 01:53:11PM +0200, Erikas Bitovtas wrote:
> This patch series introduces support for voltage supply, I2C and cathode
> regulators. This fixes an issue where if a regulator is shared between
> the proximity sensor and some other device, and the other device is
> powered off, the proximity sensor would be powered off as well.
> 
> One of the commits includes a Reported-by: tag without a Closes: tag -
> the report was done outside of LKML.

...

> - Removed double quotes in includes.

> - Reordered includes alphabetically.

Yes, but should be done in a separate change.


> - Enabled regulators before the mutex is initialized.

Why?

> - Replaced direct usage of &client->dev with a variable.

...

TL;DR: this has to be series out of 6 patches.

-- 
With Best Regards,
Andy Shevchenko


