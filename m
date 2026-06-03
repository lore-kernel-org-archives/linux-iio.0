Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189C386440;
	Wed,  3 Jun 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496402; cv=none; b=IomFkmtpF+h6KsTM3XpcBwvSmI2gohtG9AlPwGaxoZPIVT1li1em+/cfHE4+rMtlmX+Pcd0cNHV0zrM9okgnXnIuFxCOAgt8cVpousyVpLku10R6Ugp13VWKJfDCKvynJe8xBAXyEDXwZhNEENjv7ML9EtcICtj3BKz26x3LvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496402; c=relaxed/simple;
	bh=vwsFzcfP/4JAioQo/Nb7KCVYo0sn23L12Vil+WJYSDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC74Mf1aA24XVEmVOSFuntDikBoIYyB0ucQz4sK+SYMVJAgCOA+I0SI7X1pwcF9C7T0corzvG5pJolccxSdd3vlxCz0pQzolaZBZ5SIvXYyAkBk+QkZ1VHPqV/aDZKFLbP5wCMeE0pVTvDwIHUVkBnq8XnPQX8tV9vdgG99Mlh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHVVnnKS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHVVnnKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780496400; x=1812032400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vwsFzcfP/4JAioQo/Nb7KCVYo0sn23L12Vil+WJYSDQ=;
  b=lHVVnnKSMZymsGPguGHUkG4XAkpk7z0eE6+I1pXBFOnMqaXE+jBtuHIi
   7osHWh7+42LG/Ki4b4ZcibHb6tkWpCDHlwa/9EakUDAudbOQ/9wnjrLQr
   LU/D2tfTnHP8CcMpe0laxe9I+z4qjOgLhHWrL2uj0hTBuIm64ZYqYxSoY
   OvRGx36QVER4c1PjDID7pCT/+mfajdYwOS0h2qX3OtvX/tcQBj+c6Sv3t
   LbC+tEUVKgnz/rfqlZLhFUw121hLima5P0zKqEi6Rxb/YvR2X/Ue5Q+3e
   mujE6igxLlBIcmsO+cur057qx28q9MN69+T/S5kxwZ7ToQ6ZjZM8rzIYX
   g==;
X-CSE-ConnectionGUID: F/LbJyOGQGeQE51/me2x9w==
X-CSE-MsgGUID: gZVCcrxkRlKrpu6il28uRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85162025"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="85162025"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:20:00 -0700
X-CSE-ConnectionGUID: LoSveQ9VTW+tmjlePSRlKg==
X-CSE-MsgGUID: 5Nn22IyPSTyv6aezcUX4uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="239778637"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.250])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:19:56 -0700
Date: Wed, 3 Jun 2026 17:19:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Subject: [PATCH 0/3] iio: adc: Add Axiado SARADC
 driver
Message-ID: <aiA4CocrAmUCKDKn@ashevche-desk.local>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 28, 2026 at 01:10:22AM -0700, Petar Stepanovic wrote:
> This series adds support for the SAR ADC controller found on Axiado
> AX3000 and AX3005 SoCs.
> 
> The controller is a 10-bit ADC. AX3000 has sixteen input channels and
> AX3005 has eight input channels. The driver uses SoC match data to
> select the number of available channels for each compatible.
> 
> The driver supports single-shot voltage reads through the IIO subsystem
> and uses the reference voltage regulator for scale calculation.

Always explain:
- why do we need a brand new driver?
- where can we read the datasheet (Link)?

No need to resend for that right now, just reply here
(also do not forget to include in a new version).

-- 
With Best Regards,
Andy Shevchenko


