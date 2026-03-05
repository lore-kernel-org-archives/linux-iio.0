Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5329B233;
	Thu,  5 Mar 2026 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694656; cv=none; b=QQCtYm3vi4OH0JDS0xFBJGAmeK/ZFLq6UoI57xNBzhPhdLtFSJvS0yuwvGyVi40+uyiNoVqi8FGTDE9He2zQSLssbeHeHnKFqzD4wolUt0r2kY99keRQVzLfkJsB5ocm/K2c4BfVeplHPGmjFhw+pMaJpC3iMwx20Fdz7qkbglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694656; c=relaxed/simple;
	bh=BrBsfcEwmxCSZNukAXJqgEdJ3gvsxcJ0292168bXN4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK4Frjm7ZglJEhOo/M94x9g7J/X3uvJ0y//1Vx+5ZMunOSJ+0VnSrXEmjfUS89a9P8lRnK+WND92lEzS/rb7zpJLiayMUnHRxI13w5oGfTl6/iKYCZ5uYXCDUn5Y58ASgeGOka0AKHXNIwVfx64VGqXDFDixz61ab9rT2k7zVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6UUu1RD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6UUu1RD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772694655; x=1804230655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BrBsfcEwmxCSZNukAXJqgEdJ3gvsxcJ0292168bXN4E=;
  b=Q6UUu1RDvljtcXbIJ5iFTYfrZHxV9fBV/lnyyVYJ5F3g2M6SjGLDsHmV
   Oyqm9WRm1oBBlRJYTL3PdgB4+8PbYc8VHNmplUQKIAjVvhrTHvK4N87dn
   PKB1C99zhA8zwExc647piym65TGMs0/drfPPf85ZvSe3KBblNvxzzEEJV
   TXW0UDwOvnxP9TCiJwC33LkkTQiI2yNAeGLFzBaQki5vOqU9WFHzhFUSs
   MFjVKHQxYRY5yf89Qzgw3v6FpMOA9HZNNfwFML8wG56G7SYyMZBI1zMPJ
   SkMsOzmDJ/5odlYY7uT/ZHbWg398vxjrPhWAdQcwkOaJWGdh6rf3QDEfd
   A==;
X-CSE-ConnectionGUID: OlpGE/YzTZuziRrSpCa8MA==
X-CSE-MsgGUID: XLMWZSAoT4+J05yNTL5BKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73680385"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="73680385"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:10:54 -0800
X-CSE-ConnectionGUID: GtwM292MScy7vodUxQ/Log==
X-CSE-MsgGUID: qoHORzIZTEWkjmZm8th41A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="256476371"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:10:52 -0800
Date: Thu, 5 Mar 2026 09:10:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: light: acpi-als: Convert ACPI driver to a
 platform one
Message-ID: <aakseadAuKEMAmvq@ashevche-desk.local>
References: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
 <3609079.QJadu78ljV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3609079.QJadu78ljV@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 04, 2026 at 07:33:14PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the ACPI ambient light sensor driver to a
> platform one.
> 
> After this change, the subordinate IIO device will be registered under
> the platform device used for driver binding instead of its ACPI
> companion.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.

...

> -static struct acpi_driver acpi_als_driver = {
> -	.name	= "acpi_als",
> -	.class	= ACPI_ALS_CLASS,
> -	.ids	= acpi_als_device_ids,
> -	.ops = {
> -		.add	= acpi_als_add,
> -		.remove	= acpi_als_remove,
> +static struct platform_driver acpi_als_driver = {
> +	.probe = acpi_als_probe,
> +	.remove = acpi_als_remove,
> +	.driver = {
> +		.name = "acpi_als",
> +		.acpi_match_table = acpi_als_device_ids,
>  	},
>  };

>  

You can also drop this unneeded blank line.

> -module_acpi_driver(acpi_als_driver);
> +module_platform_driver(acpi_als_driver);

Anyways, LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


