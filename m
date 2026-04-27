Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD73D349E;
	Mon, 27 Apr 2026 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299250; cv=none; b=ZJrbC+7VkNFwGbFHQPC2bC9KFPSHwXDRP/IgW1vstCzgFS332EbhONhcxrZv4hrqH2w2lHZiRaYHWXVYnuoZw6EU3P2un4GDlk/NXpONj0Um3JNAV5q4eO+LQi8CuRAAGPjZDIhdUt1XwZ3uI0xJYga0VpID4ebbAfm8X6u41Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299250; c=relaxed/simple;
	bh=1BJomOx+rEGcBLIKzl5QlP1e2eXraYalEuBN2hz9NF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyM+9wr0iIE16WxUwht9QZ7kvoaxwXm3hnbW8gw8YBfXTGzLKSr9srn06FGDZO1VU0H5m64o59HXTjjFSh6009HisBE+P/gcQgehEBKirigOM1f/RZYGFTKcPXLgBFh0Fx3kJvz5FsZa0BTYkANqRVsmO0bICJbQylKHeDI478g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvufYrk2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvufYrk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777299249; x=1808835249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1BJomOx+rEGcBLIKzl5QlP1e2eXraYalEuBN2hz9NF0=;
  b=cvufYrk2ADD9DPlpH7/8EqmT3MvMbehm4HD0pwyy8yQWyuLESkQ1M0l+
   oygBpzUb7IgFHxppvVnMU6SkSa8DSfPQ6L8bUzM2nxKcb5QhTBBmeHBcU
   k9nllX7+dV0VluXacEnDGaS95nda1vPBlkgQljD7O75u0CKLNPLuLx149
   w7axMllxQFm6KsQ4U+q4cMK31vrZHuPRiM6WUAfxg/D6T9/DpuKbhwAms
   +YQSKgQwXlzyqhatXVSkCa8DVfOi0NPq3DxsOuSiaxtb9mb0TU1fWbdOK
   2g6SWdLbSfLvEnYk/yFVPcHY6VKZXjOZ6MOca4NecOO1+0KWmCJNppMfE
   Q==;
X-CSE-ConnectionGUID: z7j6lM8ERzSVq76zvHOf/A==
X-CSE-MsgGUID: N2fOWkJwRwOmoS95HtDBkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="95749409"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="95749409"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:14:08 -0700
X-CSE-ConnectionGUID: II3et7/pRveqtETa6dbDAQ==
X-CSE-MsgGUID: 5KJeUa6XSqG75gycdWRrZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="264063504"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:14:06 -0700
Date: Mon, 27 Apr 2026 17:14:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] iio: adc: hx711: introduce hx711_chip_info
 per-variant structure
Message-ID: <ae9vKxTrqe90OsCN@ashevche-desk.local>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-5-piyushpatle228@gmail.com>
 <ae9t0WuhKgcPkfIt@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae9t0WuhKgcPkfIt@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 05:08:17PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 27, 2026 at 03:39:35PM +0530, Piyush Patle wrote:

...

> > +	chip_info = device_get_match_data(dev);
> > +	if (!chip_info)
> > +		return dev_err_probe(dev, -ENODEV, "missing match data\n");
> 
> Since we are here, it's not match data, it's driver data. "missing driver data".

And does it need property.h to be included?

Also check if dev_printk.h and errno.h are there (it may be that driver already
uses device.h and err.h that cover these two).

-- 
With Best Regards,
Andy Shevchenko


