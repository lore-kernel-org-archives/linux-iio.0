Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1839EF2E;
	Wed, 19 Aug 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145724; cv=none; b=NVXto5y6sM6C3lL2wS0SIYK1cCAMEwRorFftY/k2Dcl++PEIDLbELGC5Sy5/wPQu2AjjnLnHDSBYZOLxQeg99GJr5j/sguQl1L3ekWUu2XBpHgtFDAE4kL0XpPcPGvkWdS8OaOfn+9XlPhNpBk7KZNyTYZCU+5VV2bAB+09QAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145724; c=relaxed/simple;
	bh=Vdmjpn8CJfMnQfRyr/MDrWY2FC+TlXkCwh1vl6I1vr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFAqd7K8sZwvgxpRmba9rMmL0LXwOkQ0DlVRD8LZgXWlCKtO8A29KJ1mOIbRS2eryRSiY0NF7HsQB6B8OnrQ8q1wsxRGzqeggHuEaqpVDocF+JWtXzETfch0sgbOII09dNb4WyU+jgFTD2OceMNb+SC3DMZNlzArnnb0eeHLu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNw4xfsp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNw4xfsp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787145716; x=1818681716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vdmjpn8CJfMnQfRyr/MDrWY2FC+TlXkCwh1vl6I1vr8=;
  b=HNw4xfspXU5ypM5bVZZ1zjHYRdYkvGRwagpHZag/4bxRtgOfDnhsSm50
   5Nszd2W+MA+qKydGwbCt3LIZ4pXpZw0h1C5OnH/BPBiJkoBvGh6fWPdPR
   a1gDRhpyH6FkEomi1FFT5iwGwganUEuEyQoZEyk1/gRaP/uIFoP9zfCLk
   koTRSzZNMBUKTlUsGEjLfZCMbpw2MYrIOCV0IHLzsqoB0r+adfTQDYlnE
   CvvL/NQxzzFC1r0hgamDyeDV1yVzP9HS5tv43VXemG9G4CgSe/aPBoA81
   v0DMqpHS68yhGP1ehHVZ68M3Tl93AGAohgYR8FqeJUY52sRO7j6eIKYD5
   A==;
X-CSE-ConnectionGUID: aBMzzhGqTRazw45ZxbgDtg==
X-CSE-MsgGUID: hSKwgQ0HSiW01HN6Kbx1gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98251581"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98251581"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:21:49 -0700
X-CSE-ConnectionGUID: jMvKzqgVTVO1clvLqCfE1A==
X-CSE-MsgGUID: uaYxJtA5R4GHVrsSflNZxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="262296743"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:21:46 -0700
Date: Wed, 19 Aug 2026 16:21:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, nuno.sa@analog.com,
	robh@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v4 3/6] iio: dac: ad5504: remove legacy platform data
 support
Message-ID: <aoWt52LMj5qAVe3O@ashevche-desk.local>
References: <aoPjdqzHrU5j5YWz@ashevche-desk.local>
 <20260819082221.11227-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819082221.11227-1-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 04:22:21AM -0400, Taha Ed-Dafili wrote:
> > This breaks the case with dummy regulators as far as I can see.
> > Has this been discussed in the previous rounds?
> 
> Yes, David Lechner suggested in v3 to follow the pattern in
> adc/ti-ads7950.c. Patch 3 is an intermediate state. Patch 5 replaces
> this block with ACPI_COMPANION() fork.

But this is still a runtime bisectability issue.
Not critical most likely, but still...

-- 
With Best Regards,
Andy Shevchenko


