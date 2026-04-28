Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC5313273
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363667; cv=none; b=qvO66d5hJ4QmSgxVoH5J5ZrdIwqcIAp+090iG2niZANtN9D4nnQEWb7cxJybJYjoGe6TNHmADfWtFCy1VHtHxqOofCR9NcktPSQLR6SeIAu91GAWSyyDK2HWB06EzzC3gKY7PM23onhJRxW1Uxg7w3RSfoaZQC6CyghDVVUGSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363667; c=relaxed/simple;
	bh=Q6Dy2dKeOCbQQwW5kuBj8/LJawyzheFjxKd1jyg0z38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBfKGHs4XrQ9GueItLLICRzFKOU6Hz9AeHBRsRFwreWW/e6wF5hk1awZPmYKca/VWTEx3TjFZJPWzHF522wkgcehotozwUwr11HgUQ7R7zFMz7bWrWR0+swoCGO4U6Y4qk8rhXb/zI0HgbYb5lreRhLVsJ2hlclrc2w4BxAFwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEGZ/SSY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEGZ/SSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777363665; x=1808899665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q6Dy2dKeOCbQQwW5kuBj8/LJawyzheFjxKd1jyg0z38=;
  b=cEGZ/SSYeGDPJlv/mu9PQSoN6OWonVWUONArZ5CIDIjwYkc9sAMSr/qe
   Dg8HIclVUyfFs5N/lg7Q1ASLNk5cQ/6YKYG9Jb815qCYIpqvv6mSZfrUD
   VDQg9GbD2p4I+W1XDS79GDg5Ru74Tu7OKCNzm2sysd5EKaRik1i+GFfw6
   JAjl7q3ij8B6DPFOdJDFaZuq6feEu3kruAax1r0dQaAULCluBGWKGIngy
   ZnBSvzDHlyABBVCmm3uzUm21FAhecjLk5LEWF7FCAX4KeyabsrvLnZP8/
   zOHOP/74cqm3ceWm4bTmflyZXy/SNAHiCdfVblwEixwvGGx1KKkfrg995
   g==;
X-CSE-ConnectionGUID: W+Mlr37IRVCHWDi+aGQlcg==
X-CSE-MsgGUID: zWppiH/fSDmZPXn5J8Nqqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77429100"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77429100"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:07:45 -0700
X-CSE-ConnectionGUID: JxEcUlRjRcq6gfR5je8Zag==
X-CSE-MsgGUID: hum4sr4eSFiGn6J0FpvvuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="272012998"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:07:42 -0700
Date: Tue, 28 Apr 2026 11:07:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Braga Lagrotaria de Oliveira <gabrielblo@ime.usp.br>
Cc: David Lechner <dlechner@baylibre.com>, javier.carrasco.cruz@gmail.com,
	jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	Ricardo H H Kojo <ricardo.kojo@ime.usp.br>,
	Ellian Carlos <elliancarlos@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6030: Generalize hw_init for veml6030
 and veml6035
Message-ID: <afBqyxeBa0hl3ILr@ashevche-desk.local>
References: <20260420201441.18055-1-gabrielblo@ime.usp.br>
 <26330121-79bd-4273-b8e4-17efa19454eb@baylibre.com>
 <CAOmGE-1108GJobu8nNc=WnV-+WFeW-LF2j0fQ+aMv9Ke27HOqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOmGE-1108GJobu8nNc=WnV-+WFeW-LF2j0fQ+aMv9Ke27HOqw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 08:32:49PM -0300, Gabriel Braga Lagrotaria de Oliveira wrote:
> Thank you for the feedback! We have one remaining question regarding the
> naming conventions: while adding the init_config pointer to the chip
> structure, we noticed the structure name itself (veml603x_chip) includes
> the 'x' wildcard. Should we rename this to a specific model or keep it
> as-is for the v2 submission?

Stop top-posting!

> Em seg., 20 de abr. de 2026 às 18:00, David Lechner <dlechner@baylibre.com>
> escreveu:
> > On 4/20/26 3:14 PM, Gabriel Braga Lagrotaria wrote:
> > > Add a new veml603x_hw_init() function to deduplicate the setup logic
> > > for veml6030_hw_init() and veml6035_hw_init().
> > >
> > > Additionally, introduce struct veml603x_hw_init_config to store and
> > > pass the custom configuration values specific to each device variation.

-- 
With Best Regards,
Andy Shevchenko


