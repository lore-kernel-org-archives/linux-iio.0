Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231BC2E7377;
	Tue,  2 Jun 2026 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442622; cv=none; b=Owjk8cjEqVA1NzSZPnnXb7A1rdXR4VMDTn9Msb8Tp4CFKdWL/qRfLyAKJkUCC0wXq0koujo/FfoJkUcuqgSrUZTQWYFlijQS410Lsu2NK1sNgKMMhLwgFpL5EyIqa1rlxEETU29ztGzfnnCfXH/bCMBm82MFnR8HSeUaOnlRiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442622; c=relaxed/simple;
	bh=vOvX7l5jSCxBldZwWZz76ew5UCADIwTdLW9dmKcTGGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9548g6o5lh7dsRYz2h5dlchITbHvQxYxFPu3dmWsPAWjVdIG3ORZiQ3z/f8qd+fNRT5QrRodq7Eu0Jtfm6s52ap0exSFnYgnragQuFvsIPjjizP21E90meaMc/8Gv/lnV6Ax9d8QBNu3Ho+MHPLW/68J5/rd5oCz9oYTA0Q3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBBgDWQm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBBgDWQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780442621; x=1811978621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vOvX7l5jSCxBldZwWZz76ew5UCADIwTdLW9dmKcTGGc=;
  b=nBBgDWQmj8V4TShN91LRBdgWPGF+ko5Fq/ioJi2P0hAMCSb3WTMnH3Bc
   /nYG2CH4OVMdVcetBESG27LJWxMDtOFps9Sq/FOUtXn4hXmuWnnj7azpY
   wyxp9MNmhA4v9uSKYuk8WvWG6DWldTj8ceYwn0G0Te6zC7IpFhv+kNrFU
   ZZdOL7GbpNFmAzv2hUalEEYmv51Gx5se3U55VS1MssroYvMFi2wlMN11i
   6mf/T1kxGSW1Q65Md3ZybNuk01yfYJDFHENfTNpheUn3gOpy0Wp7xyGoT
   +5/SWCXqM63+yozZC0ltGWDSNw4ev0Z3jpBFNZVkmLMAY0yWOe3S417ZX
   A==;
X-CSE-ConnectionGUID: 47bGc4ASTD+W23LG5toCfg==
X-CSE-MsgGUID: CnL3+kHhTRihxME4KzN83A==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81368693"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81368693"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:23:40 -0700
X-CSE-ConnectionGUID: je4lPa3ISMaqv2vfRQZE9w==
X-CSE-MsgGUID: AmLCDcleR4ycDvp3AJCdpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241067010"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:23:37 -0700
Date: Wed, 3 Jun 2026 02:23:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Liviu Stan <liviu.stan@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Francesco Lavra <flavra@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/8] iio: temperature: ltc2983: Use
 fwnode_property_present() for optional properties
Message-ID: <ah9l95gb8LV6ZzD4@ashevche-desk.local>
References: <20260521164323.770626-1-liviu.stan@analog.com>
 <20260521164323.770626-5-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521164323.770626-5-liviu.stan@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 21, 2026 at 07:42:57PM +0300, Liviu Stan wrote:
> Checking fwnode_property_read_u32() return value with if (!ret)
> silently swallows meaningful error codes when a property is present
> but malformed. Use fwnode_property_present() first so that absence
> uses the default while a present but unreadable property returns
> a proper error.

...

	const char *propname;

	propname = ...;

> +	if (fwnode_property_present(child, "adi,sensor-oc-current-microamp")) {
> +		ret = fwnode_property_read_u32(child,
> +					       "adi,sensor-oc-current-microamp",
> +					       &oc_current);

	if (fwnode_property_present(child, propname)) {
		ret = fwnode_property_read_u32(child, propname, &oc_current);

> +		if (ret)
> +			return dev_err_ptr_probe(dev, ret,
> +						 "Failed to read adi,sensor-oc-current-microamp\n");

			return dev_err_ptr_probe(dev, ret,
						 "Failed to read %s\n", propname);

In the same way below may be amended.

-- 
With Best Regards,
Andy Shevchenko


