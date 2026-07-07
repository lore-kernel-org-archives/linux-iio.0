Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198A414A11;
	Tue,  7 Jul 2026 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429829; cv=none; b=L47ZSYunigfl0Sv1lxkfoX/l3UHGeDDYWCb20BjKamwpXJtfWwhvcGG/IWzHiWdz+Mfjte6JdEU8KcU9BeRAn0vMaFnI0uFvbkA0lfNlHBTqkHPmek0CwlLTBmqAyaOqvgQ35ztVjsteHqwu9+jcoQZ2RD+OG57p4zZKpSeBEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429829; c=relaxed/simple;
	bh=DWgZDWbB9020CtvFIZA3KlQkx6d0EeJL43ywPpDG4Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF5efP8dt4FG6aST4wEheRZn4wJ5TSMTft9bemOAbsJZzQV+DRdA/ifdIRZULhNSTMBQA+G8yCuPzq1mcKLhE2TwK4JQWuYTW60xS1QJpILI/Dtr0ZhaJpv+oUsER25CW+IdHfqjcZdnD+XXHUvPHwjY0jB0hr1qWBl5oJUx/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMgy7Mpm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMgy7Mpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783429828; x=1814965828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DWgZDWbB9020CtvFIZA3KlQkx6d0EeJL43ywPpDG4Tg=;
  b=VMgy7Mpm2SkuOcl+RmYz5sKX+fKIjGpHIxKDZj/6hh7M68ZjXd0Tmoha
   clJsBMCA2dWqCRvSDmAqRsJGOL4Vm5YmwVr6n+q7Er0IFNPMmEEfqiTeL
   XXYJXLddAxMVJEdhxlwO8hTyZmOl62X5u5pvZKDMYuwBOssTKkI/A43S7
   ouDkvndEgN9+F+h1mrmFXGKugN92l7pcOxI2UPvxO+pplrRjKDzCrmMht
   MfLqvWR9Yv5Vn+vz7EX4QyX4gt9Cv/im5E7v/Izrussjc0cy15y2ErBH5
   lr9LPAvgkKsshV+8hwpuEKNMxsgaKHeheiZFfgm8fKfhIfuTg8XoAZcC0
   w==;
X-CSE-ConnectionGUID: GOWt4qwcS/yr4VeBJuCmQw==
X-CSE-MsgGUID: YpoUuyxpRneZGId6qLDOVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84265240"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84265240"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:10:27 -0700
X-CSE-ConnectionGUID: GCopX8O1Tuu3aSyZ10aj6Q==
X-CSE-MsgGUID: k55CGH2+Q3WHtLZVrkOiJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="284099537"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.36])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:10:23 -0700
Date: Tue, 7 Jul 2026 16:10:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux@analog.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <akz6i9yq8ENt-0FP@ashevche-desk.local>
References: <20260707104234.1957104-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707104234.1957104-1-shofiqtest@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 01:42:32PM +0300, Md Shofiqul Islam wrote:
> Changes in v8:
> - Fold MAINTAINERS entry into the driver patch; no separate patch

All three emails were sent as standalone and not in a properly chained series.

-- 
With Best Regards,
Andy Shevchenko


