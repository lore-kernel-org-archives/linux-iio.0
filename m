Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C13043A4;
	Fri, 23 Jan 2026 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156003; cv=none; b=mdSZIqMD4MOvLQZOeUV7b+4nCBVsZN/eY1iOJhz9souyrTi+2zFhoZ/WcjXQ8pA16LDDbcaBjLVv35gnhcNwq9+ebosG2W0MnluGLRzMqeDco7ndRfUxUXsNPOXZ3lgUHfpA7iqPwVRvMpdkV1kjN5s3S+/7ZGfH7m94nx7RCVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156003; c=relaxed/simple;
	bh=0dx2I9IANgLM6sQ/ypTM8nBAX14iTyBswtJPSpfZscA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrHCgSdP/eAojF2GYK8sp4UxEnATBVeUOpwMaJQSm75nPJUKJYxscPlCY72MwBATUohfDyIxy+QynoqfIB8fjtDeDT7XZFeOgH21V7tQ+7hCADZ0o/uXh0WQTWqKNelsI/hQxt/U+pAourP+5Gr21S/ZFQGu5+xVrGWNjK0NN4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qs6U47Yp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qs6U47Yp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769156002; x=1800692002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0dx2I9IANgLM6sQ/ypTM8nBAX14iTyBswtJPSpfZscA=;
  b=Qs6U47YpfY0DjIj/iTAjFW8uxFOtxiFhdjdxTtYNArFdf0IPuSZcmRiT
   s3sWMdhBPKhQI9UIGC3Emh0Z81gvPfDpgxb8riEdHhAgH/iWU1eq2LCp5
   w4G75LM2QcWt3PgxWFo2KtxKCBDcpw/Kx6Y7tAGpbiHJVNH61MbJUybVP
   TvKdcN0/amLa/WRVXe2QFD+gD3p6ukl+RbDgxFiCAD9rezBDBdV8EvMKz
   HC/uG0FdrNXvTbGMDQVBoHIpHjq+2BXODCpnkGnJJHlARH4OF2w8ZBZrT
   5PxcZ8QsJnqZbeeGA5wQH91cUR4agKzb/XqWZCGgzMrmSq6sz4lhSD53a
   g==;
X-CSE-ConnectionGUID: wA3kDQ9lT/GpUNkm5R17kQ==
X-CSE-MsgGUID: 70IHnmBQSaee0ARd+r4BBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74039241"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="74039241"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:13:21 -0800
X-CSE-ConnectionGUID: Lj20tS4uS9imjQ7D85J3gw==
X-CSE-MsgGUID: oDHeeQzNSliOlEb0BU22xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="244580909"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:13:18 -0800
Date: Fri, 23 Jan 2026 10:13:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl380: Optimize reading of FIFO
 entries in interrupt handler
Message-ID: <aXMtnCnTXq96efmH@smile.fi.intel.com>
References: <20260119102317.1565417-1-flavra@baylibre.com>
 <20260119102317.1565417-3-flavra@baylibre.com>
 <20260122195313.53fde73c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122195313.53fde73c@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 07:53:13PM +0000, Jonathan Cameron wrote:
> On Mon, 19 Jan 2026 11:23:17 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
> 
> > In order to minimize the time required for transferring FIFO data from the
> > sensor to the host machine, perform the read from the FIFO in a single call
> > to regmap_bulk_read().

> It's a call to regmap_noinc_read()  not regmap_bulk_read()
> I'll fix it.

This is interesting, does it mean the patch was never tested on the real HW?
Or maybe noninc is intentional?

-- 
With Best Regards,
Andy Shevchenko


