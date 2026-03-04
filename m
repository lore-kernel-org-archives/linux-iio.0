Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16D309DB5;
	Wed,  4 Mar 2026 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608646; cv=none; b=VVMsAaEoxlJ8mn92d9VLP1QNeXxGwCZFdSEKXeMD14XEuMER/hIpt8+d06nWMwDqooqzWujHpWmwi9exjG1rPey8Gy4NHKUE4Fb2K36KmuhlcztNzvq3MOrZwGVNnt72mcBQ7wCP7nm0NgGpog/zKx9iyXA+Js+Ti4sYo2vJ24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608646; c=relaxed/simple;
	bh=+8H30zAQTE0LO2mXt3s7jP7xEix21MB7BqkmoPEdEF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trg3Zm5GryhdTziDUHTKEbXTIkuiKQN91b/xVPNiLQ0p3kF9gxL4QZRlm3t0RtO5s+Xvax7+vdxfpjHSNxQvT8Tg5XSisGcAJKRQnOnkFsWB7osQnQgE1UEBFpsGto8P/B9JA2pYYmGD66EYD8cPNhkN4L4JjDFfak2/FbgqJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e38Hrzib; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e38Hrzib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772608644; x=1804144644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+8H30zAQTE0LO2mXt3s7jP7xEix21MB7BqkmoPEdEF8=;
  b=e38HrzibBg4NzjaYvrvmc213vF4o4YT2aXu5RuGps3Z+kYVFL5jmZYg0
   iWJueS5oJbp3/0zGx0yImYbUDe44tv7NtzlqpHfuVMDr/Wrk0IbWrzz29
   w8NoyY28kdRP4buRl78ic5YfDhU+4xTONU1K7at2WE7pC9Hl0il1yOzuc
   LFSEllgisiGD3GPcy1sNzwb+CaPhvPkhd5epPNwysGSDjbEztVdNs8KUK
   lwpFUyK3ikHRMKd+AFTAgp/rstzgSXM/5YbERUC5QN1ZNACBUmP5oVBqy
   wsDPNu4wtu5GmvW/CmYl7bTxFGytsumurpYy5qYMuAa07xk5qhtHEwEfs
   A==;
X-CSE-ConnectionGUID: 4PcWWkRDQuSBAeoYF2cL1Q==
X-CSE-MsgGUID: PXNVXQEISb6KmYsiBDUlUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="72688051"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="72688051"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 23:17:23 -0800
X-CSE-ConnectionGUID: ozu3MjkKT4SIImdJ2/N2nA==
X-CSE-MsgGUID: Gi4wT+6hQqCGbwZSTS0UHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="214450663"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 23:17:19 -0800
Date: Wed, 4 Mar 2026 09:17:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	"moderated list:ARM/Amlogic Meson SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: meson: no devm for nvmem_cell_get
Message-ID: <aafcfd20DK5dIhi4@ashevche-desk.local>
References: <20260304041716.7631-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304041716.7631-1-rosenp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 03, 2026 at 08:17:16PM -0800, Rosen Penev wrote:
> There is no reason to extend the lifetime of this post removal of the
> driver when it's only needed in one spot.
> 
> Moved tsc_regmap assignment to avoid two nvmem_cell_put calls.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


