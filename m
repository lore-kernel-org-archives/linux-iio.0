Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422035;
	b=wh/r/jzQ9rMPfgXecIjkik3rn3TG3BiIIpFWD14GNqd2ZEUQcLgEyVBFYaZmO+m4Y9EP
	 QnJZbN7MsDTrXIS6VsS8I9E8FKQUGyvYNNAIiKj9uU0sJ4gAqzPsW3xBZ11hUoL6zKe/l
	 AKG2gFNiZpfQBdpuueyoeN/3nNqHBoOxYOJ8Zlh6mEV5noL6goV4hgq+R0g+A+x3+Lmo8
	 fYG1z+j2MFjVyTeHmH88UNoCiQJj86RKUa3V2ochGtvD+kWisastsMsIU4BY1e5BJhq9d
	 sdgLKnix4hR17Mv3xpyupPKJTcbbGBc9Cc1Nm5107JNQ2PQV+c6CNl63LmcdM530JgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422035;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=wsEcgXfj9n5cKtSmRUN8e0rqAtethx6ykpM7vqF5ukk=;
	b=zZhSqbE0qIabcuz4pz6NoSSgvvqVZsT2izy7bvABYYWzE5IQ4ynTqI0BirCgIeSNob2+
	 oXiUVwvoZ6yu1tQEkVtLS4HCVqxEdkaSf+9B0UAneA/x2LfKO+HQSnEicZwnjv1G4dOH1
	 6nf4jQD8ekVMj9LLh9g7CRFexl6BBq1MOYb9RwzTHuTJnCoRP7o0zy2jDOBJqzhrb5XFj
	 RXvrFix2K0Q2GFoOBnMwYSKv6O8J3SkbsuIv7dD61xkBIofq3E+/3m+pA4gWY3vJDMua2
	 WrhFxIUH099dBVRKqoNbXtpaylIBsF7v9sScvgWLogORUbA1mJOoi4nK5Mx27nVmPrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hUsu8sJq;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC69606A31E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFC69606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hUsu8sJq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795422035; x=1826958035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HlpxXhvHS5WeAUsVxjEkCMX6Ihhis6aQUmdoEEtVPTE=;
  b=hUsu8sJqfdnkUWiE91q8+JR2NPs6PAFWvgp1Gpa01qZ++JqPpxEsgOBJ
   Nqe4TQPfouuVNwUdUfwBk6iB3HQv5tyBuTqP7C9X9MKXdT9oV0CbxQO0w
   +Y41EC3eZOifW+yTfOr5uNYLfbOHIzNSSx090dg5MJmnC5p0ZQJNEGv0K
   gHhNBQ9DvPnPDLU2lfOmSZE21HIXQ93FfSkvQVwsHD1X8YCdbhEC/zTZv
   uMiBeBUJV5k6ED2/GliD4uFIjELMXW5q9t/Rkv9M82CYGOuwdzBOPUNmU
   NJ+GIOst5jMNHPpUm+aaQgxDOnsu796KPij+gGDZfcyJh6EJZN7p/E458
   g==;
X-CSE-ConnectionGUID: pz2Lq5PkR2KlrCl/CPrG/g==
X-CSE-MsgGUID: TUPmvN16QwK4cf8FfKEbxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4209251"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4209251"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 00:20:34 -0800
X-CSE-ConnectionGUID: RCd4YdAGTGCmxQl2PZDbsw==
X-CSE-MsgGUID: rVCp4JV/SqO7a1vmgrJoVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="13048814"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 00:20:31 -0800
Date: Mon, 23 Nov 2026 10:20:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Wanhui Fu <fuwh1120@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, dakr@kernel.org, kees+treewide@kernel.org,
	giorgitchankvetadze1997@gmail.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: twl6030-gpadc: Add error handling path in
 twl6030_gpadc_probe()
Message-ID: <awP3TR9tvPAQ84Fe@ashevche-desk.local>
References: <20261121082419.376423-1-fuwh1120@163.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121082419.376423-1-fuwh1120@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 21, 2026 at 04:24:19PM +0800, Wanhui Fu wrote:
> Add an error handling path to call twl6030_gpadc_disable_irq(),
> as twl6030_gpadc_remove() does.

No. The probe uses devm_*() approach, you should do the same (and fix missing
devm calls, such as devm_mutex_init() instead of non-devm one).

-- 
With Best Regards,
Andy Shevchenko


