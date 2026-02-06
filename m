Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268936C593;
	Fri,  6 Feb 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386174; cv=none; b=WFUUa0/r2eYE3mHN4BSjldgVRMFI/CGiqC6hY0OfO6asjNR3xrY6M+4sS//vnDGNwDjXsBT4NRZFuQahFj5cnZ0H8aEp5loY178q6c4B/pCwKUfnyUnuriyK0tvqLNetw+5iIhFUjtvpSMCvkHMN7S4cS4jPuQMXuj8rvscUo64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386174; c=relaxed/simple;
	bh=I00eWFunBrXqPES26Gqkr70fAVbraKO2s8fjnHb+7jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR6WO+qnIUEE4GAhRDO1aYwj7pLBZtcOSJvrdCkRIK/QyyHNvded0oYRqJuQWBQgAyxgBr88nisCGQsv/qg8aw1L6vsP+XOB0cf6wfJLWb6meQ59pWPQQaE/FkwX6qyjp7ipit/aFSXtDTjKq+qy8Y11Buw/O9TwraYkrVMwSJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbxsCK7G; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbxsCK7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770386174; x=1801922174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I00eWFunBrXqPES26Gqkr70fAVbraKO2s8fjnHb+7jg=;
  b=nbxsCK7Gt2CsEkYk7zHLGwwbRBkxHhfl6m8wLu64dvrs+ZxTa1gpY+oN
   6SQNs2X73cBO7BH2/dsF1ayGFJeCX6oGfH3kImtkwb0938KYodM5rXsX9
   cH7peIiPp++7gpvbXNA4nTPy807TBhYn+drroEqdRwDjtCHcocC1z34SG
   6iiIA4A8cx56BHqOcpGKz4411z12PFP7/Ll+kDI8NjOEprJMpRNQGlJxy
   8HYnbjsIlJfE6tyHncvCqJLAFCwDdG7E9BeZ7l09IwT1rlnbH0BvsmAfH
   bWeam/TwZRpcuTKf6vDHbvZLAQjMc1PYKaF1GBb692pdvmr/5KCLqGpkW
   w==;
X-CSE-ConnectionGUID: wrmKu2VPR0ax+eejYN2fng==
X-CSE-MsgGUID: rKPYAUZ4Rg+7cKeFQoeJFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="59164119"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="59164119"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 05:56:14 -0800
X-CSE-ConnectionGUID: Iw2MqoxrSbK6YXxD6yVpqg==
X-CSE-MsgGUID: e0LrdNdrQ0KE7RZDu6BRVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="210153369"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 05:56:10 -0800
Date: Fri, 6 Feb 2026 15:56:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: adc: ad4080: add support for AD4082
Message-ID: <aYXy-B-b9CpUKZ7C@smile.fi.intel.com>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
 <51281e19fe2955cb10ffb77b62b0d7738e9b5a93.1770382796.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51281e19fe2955cb10ffb77b62b0d7738e9b5a93.1770382796.git.antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 03:08:21PM +0200, Antoniu Miclaus wrote:
> Add support for AD4082 20-bit SAR ADC. The AD4082 has the same
> resolution as AD4080 (20-bit) but differs in LVDS CNV clock count
> maximum (8 vs 7).

> Changes:
> - Add AD4082_CHIP_ID definition (0x0052)
> - Create ad4082_channel with 20-bit resolution and 32-bit storage
> - Add ad4082_chip_info with lvds_cnv_clk_cnt_max = 8
> - Register AD4082 in device ID and OF match tables

TBH, I think this section is too much for the commit message...

> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...and just as good to be placed here.

Otherwise, LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


