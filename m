Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F80361DD5;
	Tue, 18 Aug 2026 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028350; cv=none; b=f9RYwagxoBAb5KiVsnDgnDZY4tTD5wf/ccFabLnLkZnzjXvGNwYK6Bq3GMVPxM/07SK07L5CY4amd6ZSRdu49IJVJz32OOOSJ27nQ9c7Y5FkUjpl6ViAIpujpSooVgjy90HRCr1XVpm3RvHO+zZ4Xx4upwEkF0QrhzXzKph4H+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028350; c=relaxed/simple;
	bh=JmRKbqVe3BPJPRAyYqhT2CIAKyTHs7Va5AWtPFVLjzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBEZVK6kiuEZ90rYMK0P0iz1OfY14u8omzSsO+9+fO/ZyThUvcd++vlSzp9zEaa/30F9hXq2bF93op8Gel7HZM0SXD0dtTsxibbn5KauwqFaVBNoeh83ygsPPLKF3y5z06v2/75+vxefqwNhCxAV6rv+5RCGBWVXRcpa+9gvokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8s7Ndmr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8s7Ndmr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787028349; x=1818564349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JmRKbqVe3BPJPRAyYqhT2CIAKyTHs7Va5AWtPFVLjzU=;
  b=n8s7NdmrTRja94+Wm0t54nJ93tWzklGamo5cts9dZVTpNPAanvv6gPsJ
   XR4G0ZxT8O1P53BldGFUqvKrWQK5heVDn3GQ1LjVqG/1w69TTpKuT29MI
   mHhoEYRCLrCy1GQIMZ5STKmjN0oH/Mn/L7vgo1nOhO4rANPpevrBDIuqW
   4hMHHPXXq9dyIdOySP/FlQWmTV81qZOIZl1h6FGSV0MXY1XeciiD+5fKr
   Gn4Y+Mut6hitnrwFYC/n2i4FyX1zFZbsAgghEXG6/7xFA108a1T6M/pU4
   rtULZ/u2yaUml4uvcZVc6cx0sv9T0iF4pTN/oBPtD8Z8rOpvCAMgS1suR
   Q==;
X-CSE-ConnectionGUID: 6uKCesdDQ7elB3S9aTnp7A==
X-CSE-MsgGUID: SwHlhjAtTDOd0kbi6nIhQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98102496"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98102496"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 21:45:48 -0700
X-CSE-ConnectionGUID: eCgMAt8tSp2SFHEVxVyL2Q==
X-CSE-MsgGUID: eFZuFMPQS9uAVktlgzht2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="303340718"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 21:45:44 -0700
Date: Tue, 18 Aug 2026 07:45:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	skhan@linuxfoundation.org, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] iio: dac: ad5504: remove legacy platform data
 support
Message-ID: <aoPjdqzHrU5j5YWz@ashevche-desk.local>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
 <20260817211118.21833-4-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817211118.21833-4-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 05:11:12PM -0400, Taha Ed-Dafili wrote:
> The AD5504 driver contains fallback logic to use legacy pdata for
> configuration. Since modern systems configure hardware exclusively
> using device tree or ACPI, and there are no in tree users for it.
> It can be safely removed.
> 
> Drop the ad5504_platform_data structure, remove the fallback logic
> from the probe function, and delete the dedicated
> include/linux/iio/dac/ad5504.h header file.

This breaks the case with dummy regulators as far as I can see.
Has this been discussed in the previous rounds?

...

> -	if (ret == -ENODEV) {

> -		else
> -			dev_warn(dev, "reference voltage unspecified\n");


This one.

...

In general it's a good change.

-- 
With Best Regards,
Andy Shevchenko


