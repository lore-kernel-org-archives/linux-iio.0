Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AED39F17E;
	Fri, 13 Mar 2026 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411428; cv=none; b=bSExclSHh1yemQFE+5vQg9zlKjGR7I2pNn/NdFH8vtgxMGZ/Yit83Lhq+JFiTnLiBduhGWryE4pOnrRuwQGZII84/kWONaDVcEEKtKSA+NxcRpdAmrBk/S9npXCM721/6R0c/qKqBcBAn/9d4/nfGPIBi0t7G+vEjWTagppm93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411428; c=relaxed/simple;
	bh=uhmLaHGXNGo1Mx+Le7cGtlKBqG589HShcozxvGMtrTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCFaOEXdtof0nhWsTq3TciZCTLfFUVyI350rRuE/UJljhmGPqXI78Gc+wSh21GDUTr6vJgaaeknkMC8j9eugnwvuQ8YNHI1EHwGDR1EOQISVbdJaHjv7bjUkF6Wy5Z2hpnRwQh/VOWZuoRsZSScKmZYnV7D2ICDVeOuUPCQEKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOyvaYAN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOyvaYAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773411425; x=1804947425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uhmLaHGXNGo1Mx+Le7cGtlKBqG589HShcozxvGMtrTY=;
  b=ZOyvaYANgj5kheb6w0WQSmv8ZLnCwjdqktr16xyXwJLoTpLbj2YTJJ3L
   9sqMT4zsLI6df4aNnCoUju/jrSEEITcywppeaZzWAEQreOAoetR5YHNs6
   GZknFuwedIGed+7mLocXvmNq1kEXwT05PDS/g6ogpyDjaFqGo9m3PL2IR
   zO47EMhtZu/nPXE4nsTHsD869fk2Hzg0EwmcPHD7O911XlUBsaN8btrA4
   AXWRPtsxHsQYETSdYFWz169iK2QFSpkE4KVhYPzqaLEVQZTAe8NE8KE3X
   upnmsNpE9CCEpTmV8eNiIFPyhuKbn5pextCU18p7ms37siIbV/BawmKKN
   Q==;
X-CSE-ConnectionGUID: MDzgOoq6SWWUyEu2AIVAEA==
X-CSE-MsgGUID: ajll4jdrRi+3Do64efApkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="85603957"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85603957"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:17:04 -0700
X-CSE-ConnectionGUID: WPqdKllDQfug6ySb4G8PwA==
X-CSE-MsgGUID: INmGjbElQby4rrzOw8AD8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="259071504"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:17:01 -0700
Date: Fri, 13 Mar 2026 16:16:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] iio: backend: use __free(fwnode_handle) for
 automatic cleanup
Message-ID: <abQcWmPl0Mwin8JI@ashevche-desk.local>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260313115856.87763-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313115856.87763-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 01:58:50PM +0200, Antoniu Miclaus wrote:
> Convert __devm_iio_backend_fwnode_get() to use the __free(fwnode_handle)
> cleanup attribute for the fwnode_back variable, removing the need for
> manual fwnode_handle_put() calls. Move the declaration closer to its
> first use, narrowing its scope.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


