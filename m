Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF931A56D;
	Thu, 27 Aug 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856935; cv=none; b=eoCMnpDv8JyOeMKys6d+mv0UdV1DSfpSKZUnvh38smwoSHq755zKfM7yM3ec8V0ZeKFgllHt5uSZbA1Qi5cwdCAOJMFBNTaZHo+oblIbItQlR8yvYnecojYplERoaoXGsDIDAb5tbXZt4qWgnqmfdgd/sDsV14EIKExm1MBd77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856935; c=relaxed/simple;
	bh=QIPnUrxLHSJChVpNWFpBJnFhuBxr1RAWDgDJ2mh9duE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yuvmy36+TJa3kZyaICe+xu3xecl1dEk14E5C5ZJOh6oCo0+HbBMy2f0N4JE8Qnxfe5LAFrI3SQBTC2sGvPA1XoUY4odFFmOsspElKeNelTpmWdxP81QQjSL5oBZ2smHbC5wmtXXxkbXPAVLyP+mdFwQEpNiiZOfc3BFZxQ04yqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/TO/7yM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/TO/7yM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787856921; x=1819392921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QIPnUrxLHSJChVpNWFpBJnFhuBxr1RAWDgDJ2mh9duE=;
  b=C/TO/7yMXdXsFZ6WyjC21eO2Y5FL4Cx5q9+8IMge7RmCEIzIKS7izP9R
   kCXfMSKIaliEirEr9CTsQuC2zq6naGiljI433LMu7ecEDNgLRFD7hILm4
   Q+JIJs0/d9c1+i6m+GLWEh4hkQsdF9RCYHd99DpC12AeSRqtEJmIV1K1T
   6JdsAUKXcATGlwVIpLSP2fz0n+dqm4Twi6C18MyPsxv1gyEN9L2zb97Oa
   Tuu2lZi637mLOgXvc1A6Auriu/698xCzOSMF4nofhAZNJ3XEd+RN9xNRS
   k/etMwnyxNzJPo41jtqI3yEWB7oZt37F48btqYgBdvk10UHByIqs9oCGO
   g==;
X-CSE-ConnectionGUID: tfM8quZMSPq7yuYInkjCkA==
X-CSE-MsgGUID: RWGUsucPQ7CLj4Gr1AXrqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88389544"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="88389544"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 11:55:17 -0700
X-CSE-ConnectionGUID: r7M1w5qLRzSpHuXdFdw9AQ==
X-CSE-MsgGUID: hTkYuOAJQN+BQwaMUoAunA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="291442783"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 11:55:14 -0700
Date: Thu, 27 Aug 2026 21:55:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/8] iio: adc: ti-ads1015: use local device pointer in
 probe
Message-ID: <apCIENLJk6jKD0fC@ashevche-desk.local>
References: <20260827172100.39176-1-architanant5@gmail.com>
 <20260827172100.39176-4-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827172100.39176-4-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 27, 2026 at 10:50:55PM +0530, Archit Anant wrote:
> Introduce a local device pointer 'dev' in ads1015_probe to

ads1015_probe()

> avoid accessing &client->dev repeatedly.

...

>  	chip = i2c_get_match_data(client);
>  	if (!chip)
> -		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
> +		return dev_err_probe(dev, -EINVAL, "Unknown chip\n");

Please, add a patch that converts EINVAL to ENODATA here.

-- 
With Best Regards,
Andy Shevchenko


