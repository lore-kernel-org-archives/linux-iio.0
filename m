Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909653F8EB5;
	Mon, 10 Aug 2026 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387536; cv=none; b=VfpVJDpF2xhV6XA1AMijo4IPxxZjR/eY15SniF/PT7Ur9Nd99wMZmecfjbL08QkOVfph0AGNgOt8VsAzNjyALYxqdpRds26PSUCPhK6W2Z2pcU4vqx4nbmoRpc5g2Jmw0HHfeugn4EiWOaqc3WXArtmCNeKxNKwrK+dJW0idEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387536; c=relaxed/simple;
	bh=iyksqf6hP/i598AEwpx/oTleKKGNDx5lZsaduDVY8AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRaLOegIV4Px07rNJL3BmY58kW5SzY8lIFiPS36JEBpu4RTOSEyQRo/a6xoQMrzomdYQm1uMCRjE84jQMPnDIbCoLuO7gxmmJCpCUusfYZ5DnZyScogJSCkxAAwvC8b0XGfg0txrf+4LzG2XWCbQjvfHhmBS+DU/7oaz57OLDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhGMpPRq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhGMpPRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786387534; x=1817923534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iyksqf6hP/i598AEwpx/oTleKKGNDx5lZsaduDVY8AY=;
  b=dhGMpPRqnAI1UMHMPsbrQptx6mNrOo1uWD9eByjedi5FqRhLZvo0sbjv
   MUCESC6a+4k6k7t9nLy9mE/GAHELOLAiQmzDMROhMwp2FSt8PszHk7WjX
   rCUrLOXq3DUadD73W/xSI008Pv3L0QV5MbVV8G6YI37oL+twOpWOoeqjg
   4Uf8mt2qFyXgV/iWDz8mhLjuenYlGug9gAF0oqVCEBbvfidBoAd3p8UFI
   grHmZsWgmT5YNPtH5L55rBZj3s0GlabR1tJiyDhsOYdlrluCT+tBpvmj/
   q+wTXq5wnSttZnMArmVcKZgqRbyesbxo4/rSuAwYZALlcClZukBXKgvnj
   Q==;
X-CSE-ConnectionGUID: R6mKxn3ZR4mTlFEBsAjRXQ==
X-CSE-MsgGUID: FnWTg0qJRPuDWtoFwfgoBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86671947"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86671947"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:45:34 -0700
X-CSE-ConnectionGUID: cRHsUUlmSsKFvZFNE/E1xA==
X-CSE-MsgGUID: zzwFvRsLTXKkgYhIjFapQg==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:45:29 -0700
Date: Mon, 10 Aug 2026 21:45:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mike.looijmans@topic.nl, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jorge.marques@analog.com,
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz,
	wens@kernel.org, sakari.ailus@linux.intel.com, linusw@kernel.org
Subject: Re: [PATCH v9 0/3] iio: adc: ti-ads1100: Add support for TI ADS1110
 to ti-ads1100 driver
Message-ID: <anocR1F6uCdh4e1V@ashevche-desk.local>
References: <20260804192840.29121-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804192840.29121-1-jakubszczudlo40@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 04, 2026 at 09:28:37PM +0200, Jakub Szczudlo wrote:
> Add support for the TI ADS1110 to the existing ADS1100 ADC IIO driver.
> The ADS1110 is pin-to-pin compatible with the ADS1100 while providing
> higher resolution and an internal voltage reference. This patch series
> extends driver support for ADS1110, updates device tree bindings and
> Kconfig text, and improves the overall hardware description for the
> TI ADS1100 family.
> 
> Tested on: Raspberry pi 3b+ with 7.0 stable kernel

Pi

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

A few minor comments that Jonathan hopefully may tweak whilst applying.

-- 
With Best Regards,
Andy Shevchenko


