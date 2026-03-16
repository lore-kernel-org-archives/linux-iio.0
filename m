Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA533DB633;
	Mon, 16 Mar 2026 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691206; cv=none; b=nHOkpIUw1yIfi3auGSD+8u4l2/GwasIEOIuzsxxtZa35RWhIwmWca1yWwIEdFuT/PsEwhpX6tIBP4PEib5v4s1BGOj0K/c4vvXqW2YMDL2Nl8tOvvA8RUggSFpnsCttpdRzHVcBGcDjvTEzgKiHLu5hKxzdeT9D23mR9wglZlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691206; c=relaxed/simple;
	bh=XycmtXf6s5yJpYLA0r/E8CR3T+eRVs6dashP3F2rahE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOaDPJrWt+zps4udwjpcDen3G9ACMBRqOJ0KLoANXjm9AuiCLTA59gDNsr2r94+Qc3B8HEZoTQXZvfWpDjoHGMjGnxjWYgdOSoqqrmPDHUMd0s43Dk/dm0pZzN0VOFb0KrRzQbEA8oQb/8pwlUD1HRzTsZz0+pP9XA65quz8sKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNsveiyR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNsveiyR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773691204; x=1805227204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XycmtXf6s5yJpYLA0r/E8CR3T+eRVs6dashP3F2rahE=;
  b=DNsveiyRxQJRmRByThUq+1bdIW3NqiULfznuSBSymvab5P1VU/kFC2VR
   vpWeDpvuFayKjXuDy4i5KK3LmFAaRJVp9hZZ+24BUr/cIKuO8Q++3TvcM
   dDyNORieqBdxCi/euWHUewQZmYoehVLHX8jYrEKl5NO/Jv39VcRZbXJdS
   R5om1IyZNB5BSjyWjIuuN861kpteduQdN6v6G6zmZOQaqjBH38LH8AE2G
   sbeuENh5ONMyRLuqCJKfezsTsVJgBA9t0/JktCJAJNrQlwuB2osLwSI7b
   sXwJ/GAWgB1q6nRvrMXOLRWYQQiatoh6QbC7fMqWgOWYQlrI7vZdqRu39
   w==;
X-CSE-ConnectionGUID: O7Kc4BwCR5qMDe6ybeFKIg==
X-CSE-MsgGUID: vIuFm26tQsi78b+LnqUKBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85414240"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85414240"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:00:04 -0700
X-CSE-ConnectionGUID: 22EiZE7iSTmvGCzjb5wyIg==
X-CSE-MsgGUID: 1YBTKR13TwGCEhCZsUDykg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217808849"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:00:01 -0700
Date: Mon, 16 Mar 2026 21:59:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Raymond Hackley <raymondhackley@protonmail.com>
Subject: Re: [PATCH v4 0/7] iio: light: vcnl4000: add regulator support
Message-ID: <abhhPnvQwpZozHPe@ashevche-desk.local>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 07:19:44PM +0200, Erikas Bitovtas wrote:
> This patch series introduces support for voltage supply, I2C and cathode
> regulators. This fixes an issue where if a regulator is shared between
> the proximity sensor and some other device, and the other device is
> powered off, the proximity sensor would be powered off as well.
> 
> One of the commits includes a Reported-by: tag without a Closes: tag -
> the report was done outside of LKML.

You mean outside of public web access?


-- 
With Best Regards,
Andy Shevchenko


