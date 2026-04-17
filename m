Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C6354AF8;
	Fri, 17 Apr 2026 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450967; cv=none; b=b8Iq7BC9isPgdFcr74ZNvMuquxlgIGQ3DqapN8wIq2zGdzx2KIRxcrD92gVFrn6nfgMzVxSRi4lpHgOyyRqklDr4VVAUcg5jOv/7d46pIsA47WXU7I9uaoz2B9rI20WECazuQ3XJ3cWdJakuQsKBNNRtcsbbPw05fKY4gCwGVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450967; c=relaxed/simple;
	bh=GhaMXEbQp0JwIqOvWrMIM5Qmw3fgXbBIpJz+EHGdFBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMYCatZ9UhVI0o4kJw5/vsytdLfKj5cH/MrVmU7jHFO/W+55WM9JwN20sTeb5HGwlPdzqOGGOnvZlZEq00PnbUsNMl7OgAIW88tOpxcS0WFBE6rGEcfeUU3f2GJehqVmfz/Px9V2ruJrNMBrfaTm5qNd+SJri/HY2XEsTvGukX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gREOGmxC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gREOGmxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776450966; x=1807986966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GhaMXEbQp0JwIqOvWrMIM5Qmw3fgXbBIpJz+EHGdFBw=;
  b=gREOGmxCrMtI2x3qTgo/gkch8qS7nUWfD/kc3FCYasasQIsAXlRW9+ua
   sMEILXErsnVCc/hd0ADgdXFa3WLld8N9CalwVUhuIj74fXkX4GvKLdEBD
   MgBb+pCtVUHczGsvR++ri7GXeYEnYgsTl+OrxHjZDVibF4BJIUE+7bJll
   m4YCpZ3eIfQwr2docN4gSH4yIJAPR7VRFu3b77JdbU5LK0T+JmqRhDSQL
   R0yDRcBYRIUwZct0UgiFEGFh+8BR9hHayin3hB2Dw1/L2DL2PfXJZbnl0
   IJc7QaC5+tCvpRPmzhVQz63sqV5l/BNuc8+rXUjN3JbvSCC/9+OfE8aN4
   Q==;
X-CSE-ConnectionGUID: C1uVjU8PQNiunH1u7Aph6A==
X-CSE-MsgGUID: 0ZXDne2RRx+WXuS6ciGCrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="76634664"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="76634664"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 11:36:05 -0700
X-CSE-ConnectionGUID: 1AeHJcpXTruo4CBbqZti4Q==
X-CSE-MsgGUID: +GTOWz1ZSIO2H/LLGSyMfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="227973256"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 11:36:01 -0700
Date: Fri, 17 Apr 2026 21:35:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, puranjay@kernel.org,
	cosmin.tanislav@analog.com, marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com, ramona.gradinariu@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iio: accel: adxl313: Use dev_err_probe
Message-ID: <aeJ9j6g9J7JUdg8p@ashevche-desk.local>
References: <20260417124924.353189-1-sanjayembedded@gmail.com>
 <20260417124924.353189-3-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417124924.353189-3-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 06:19:18PM +0530, Sanjay Chitroda wrote:

> dev_err_probe() makes error code handling simpler and handles
> deferred probe nicely (avoid spamming logs).

In the Subject also should be "dev_err_probe()".

...

> +	return adxl313_core_probe(dev, regmap,
>  				  chip_data, &adxl313_spi_setup);

Now it may be a single line.

-- 
With Best Regards,
Andy Shevchenko


