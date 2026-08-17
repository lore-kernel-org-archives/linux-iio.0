Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087C3B6347;
	Mon, 17 Aug 2026 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951405; cv=none; b=EiiVjl2av0xDS8kgCbcFNvkzegcmFV7zZYlYQIAOjWa5U/lOxLYDHovLmr0PRVvb6YARPlSL0OMwsAZiukPBFAMJOv2B+FiBgX8RI3abiM1zmqR6Q2JclpTzzaQ1gzd4mG4rjKBzaLuiPgnE5dgYT7MBvi7oPgg7WoBPVgE7MZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951405; c=relaxed/simple;
	bh=VIIivbvauYE/rMIf78/gcHSKi3AMaEN8PkiK841Z2Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf3P/XR1u14Jx2gGOckgpkFhn/tAYgCSJUT9qcMZKzSnGaGNejvpEKIhHn/Mg/L/bj41GGRtlPsgwlEYPhAnHX/v6Z9Jbqe8PcgKSdjDVSUDwPNvri5q8YSdd/7Bi2PKuCEJpHcZJdzG3Fh5v/QtsgBR0zUgI6zjFDQvD7BqEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ee2QSbwd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ee2QSbwd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786951403; x=1818487403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VIIivbvauYE/rMIf78/gcHSKi3AMaEN8PkiK841Z2Vc=;
  b=Ee2QSbwdo6QxERBloWIp+BeVIMj5oBMRORsbXy+3EgfkKq6nli6Jg7Ol
   bK5kVKqJL42gAo4M3w/MaCBQehrkjz/WYCzAnlpUyE6GAKEWtAE5Eu7ZF
   RvZN8BOOhc5lp4z8KuXI5LqWkw1lcy4POcWRBIij4jzZaGFsqN0VCM2n4
   6DcEImCeGq6GCgd8zaPOIAjPzQ0mY68YxseGCH5aXbQunReldlxES2DMg
   l/HCh22tmjvdX475sBcpiX++ET0faNHdb74we7h8Nv2yLdxPq5yJ5aweE
   J7ypoguRJBLetflpjrZq80TnhST/mipBr4klEkAyRf03qujYZf9JUINQy
   g==;
X-CSE-ConnectionGUID: 02fxHvz7SV6sIT3CHAJYVA==
X-CSE-MsgGUID: ddpILKhpTkiEsj7K7C6GjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104954620"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="104954620"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:23:23 -0700
X-CSE-ConnectionGUID: t4lD34MnSpCo635Ffmeizg==
X-CSE-MsgGUID: RegrtuosRZOLoPiH2kuAKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="262204950"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:23:21 -0700
Date: Mon, 17 Aug 2026 10:23:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 0/5] iio: humidity: hts221: update probe and logging
 implementations
Message-ID: <aoK25pW-4Sxr2yh5@ashevche-desk.local>
References: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 11:31:24PM +0800, Adi Nata wrote:
> HTS221 is an older driver. This series groups a few small modernizations
> based on current development practices.
> 
> - Report available values via read_avail()
> - Add a blank line after variable declarations (style)
> - Allow unknown whoami for DT fallback instead of erroring out
> - Use dev_err_probe() in probe paths
> - Reject calibration data that would cause division by zero
> 
> No HTS221 hardware was available. Verified with checkpatch --strict and
> builds of hts221, hts221_i2c and hts221_spi. Probe and calibration
> error paths were exercised against i2c-stub with register contents
> pre-loaded via i2cset.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


