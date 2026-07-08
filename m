Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD253E6DD9
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493551; cv=none; b=Ys9bAqNc/dWdA86bCeaheQ4lN52OpB2yBg2AicBH56E1TOq2O2vvDdF5fUGe5YcWdxZ2F7zIoF2a4pldxF83ewx/ihQK71IZajOTYXgR2zv8A2VRrKX5ca22pTEZE1jCDflnlWLcH4QVuzEQZXPDuWHhDYamJ8uHI1m7xZMaIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493551; c=relaxed/simple;
	bh=N6V+6OIh+O0ZNZXgD80n5sF5nr+/4dbCor+I3fFKNGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjXM4geigQmdkfbQQ20q+FjUE7CMMoMdqSROa+Zs7wthz/CTJv59tsSaC2HaAJdn65Z1whFwK60SB4n+6/CqAH0dm0ooqyxQn1RJ9LadMaaIgjKykkcYxBjw2GRLSiaIIs0CxSeVoyY9Uq6CFqS+VBCWe8NAcfNMZCy5pHjBWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qz2S3znY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qz2S3znY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783493548; x=1815029548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N6V+6OIh+O0ZNZXgD80n5sF5nr+/4dbCor+I3fFKNGc=;
  b=Qz2S3znYsoArj+A7z3wyJPv74zXZ701VVKHW1w6S9hyn28mC/umeEB0A
   qeS+MKI1yV5MZB5LTipROr3kicITB/lhx0sluqjYfBTBjOgmL4teE5MfS
   JqLQfRo66fSUUecQqKGsGRIfEpHSLUZRThghXN+PYRjNB05NjX5p1Bg5v
   AXlRb8tuSv2B7HWP8L/9+fpwsTYIxxXZhARVD8dydjcZwCYpXYu1MKx8w
   RE21UtfKmLtPy64LyehnvvBFUqxEjTV7mA98t47CMH91xZW3pR/rdrruW
   5LCG2EDExYuwBSeDF8MiQtztgfRR9Dv6iOlChGYNdmfocR8BpMsXAF6o/
   g==;
X-CSE-ConnectionGUID: oBRJMjjbRL6oPnC2He4tIA==
X-CSE-MsgGUID: MElMBajQRe6iH5HUXBz5cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94790458"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94790458"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 23:52:23 -0700
X-CSE-ConnectionGUID: UZP0ESV3Q4ipsFXjzgsixw==
X-CSE-MsgGUID: bNcpTRidQLCy3ksusk5buQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258083636"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 23:52:20 -0700
Date: Wed, 8 Jul 2026 09:52:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Caio Groff <caio.groff@usp.br>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: adxl372: replace manual bitfield ops with
 FIELD_GET()
Message-ID: <ak3zoqWgYy2aHsqP@ashevche-desk.local>
References: <20260708030727.1378063-1-caio.groff@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708030727.1378063-1-caio.groff@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 12:06:11AM -0300, Caio Groff wrote:

> v2: add missing blank line after reg_val_l assignment
> 
> Replace manual bit shifting and masking with FIELD_GET()
> macros for clarity and consistency with kernel coding style.

All what Maxwell said plus the same comments as per v1 by me.

-- 
With Best Regards,
Andy Shevchenko


