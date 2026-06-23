Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2E21257E;
	Tue, 23 Jun 2026 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238951; cv=none; b=lEfXSlhG+MDFaTdiVCBQKyTyw9udhSsRV0p0rvPuSMcYLgZ0sV06FNac2QdC41POy7qFSzJhGhIyiw8ti+DYqpDhrz921ckWEPD10dcMlQ/1U2VdKYGPZAYBgkEa1B0YecMleaKYHUHucbvB5VfhsBiH/i64m3UOWeWK8rVwU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238951; c=relaxed/simple;
	bh=rJMSYYrCaMpJacpqs3ZlWI5z9WqednwOmECXbXYYrQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fyolv6rkbeHPzWhcIIZdbcb0e6OQl6Nva4oZZdiJoyAegrPwuiL0x+ZBXs6ipLzgXKweb9my1lO1EtDrC9GzRJ3qOlOkDLFn3OqS++v6WsFy9DwiNvH8E/6uGUAQJTvTnGxo0adtEsroXEzXEZ9hWWRxpIFk4kkONXCdC8AwsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHwXJtqv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHwXJtqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782238950; x=1813774950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rJMSYYrCaMpJacpqs3ZlWI5z9WqednwOmECXbXYYrQw=;
  b=QHwXJtqvQa/YXi9SdBYYGRdHLqHvhAzSj/+v1gpiDNlmHTkPFeKNhrzQ
   cejRuAq7DudsnqPV7Bxnlh7Ak+RnGutt4Z3LNybbO/OYtdSN2CgGYOTq8
   3TBrOYJLgSqkUpqyxDb8y2rg203E947oCx/VeOsKlH2IjJmtOEHaCz311
   jAuWgKeBoHXpaXEPj686VnIXryExUxX55g3OSWiAZkXsVsqpMdphy4FCA
   HaKBDlE88rSu0iNoQL09CA9XayWGlVIkWAlkrZ53RiP5TlYDAHoO+waQM
   M6m0MQumgY4gG7KzxQV9Kzl0jOj0IixUbaj/oScyXqWCfR/gSwQeED7WX
   Q==;
X-CSE-ConnectionGUID: CG4ZDeEIS4+FEnBh8yuMCQ==
X-CSE-MsgGUID: XGP5lIb3T76N5xem2V//KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93352941"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="93352941"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 11:22:29 -0700
X-CSE-ConnectionGUID: HSSgHo1OSDS2vf9tHpx5KQ==
X-CSE-MsgGUID: MnJibf1HS9mcTXJZCy+dyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="273657308"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 11:22:25 -0700
Date: Tue, 23 Jun 2026 21:22:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] iio: adc: at91-sama5d2_adc: adapt the driver
 for sama7d65
Message-ID: <ajrO3-buCfS0vx1L@ashevche-desk.local>
References: <20260623105944.128840-1-varshini.rajendran@microchip.com>
 <20260623105944.128840-4-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623105944.128840-4-varshini.rajendran@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 04:29:35PM +0530, Varshini Rajendran wrote:
> Add support for sama7d65 ADC. The differences are highlighted with the
> compatible. The calibration data layout is the main difference.

Do you need to update a Kconfig help text?

-- 
With Best Regards,
Andy Shevchenko


