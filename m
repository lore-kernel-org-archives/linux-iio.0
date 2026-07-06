Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622E3BE65F;
	Mon,  6 Jul 2026 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317849; cv=none; b=rOZVTGuEpnLIM+5Kg8G4HIvUcVzFnRgZkhkc3btPNjqQZyh73ZvXURV1Z+E8N9oP/xcd69MHGOYJDM2HfEl/sZbbNUjVOO23y2g0PM8SEuUWq5oGqzm6n5lCcvA408n9asbymjqaClhF+xq66BfY19e9gZBD0IEH+I/JtcDGwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317849; c=relaxed/simple;
	bh=OezIpAYj0aaFDtb85co6j9Ww816v/ppbnO3HyM4ykJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0SXQ+N0I1p0P8BlEseP1M2X0JDBDWtF+Z0ZXS82J/9wiG/HhPMbE+4vyBbgACTs/ygoEUhZ2JTfTGFx7PcHy/ceYhWOXdI7xU/LRTDgyTHwO880SKVceLRsgNhlqkgryJ4tcnZ4uC2qMh7xCS6DjTLLPE7aqiaktuYMdtosaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVJakr5o; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVJakr5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783317848; x=1814853848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OezIpAYj0aaFDtb85co6j9Ww816v/ppbnO3HyM4ykJg=;
  b=EVJakr5oBbYP+tZrmOLAe8y+0qaQ3Uo6wgswdO2eCXUYV8BlJlBS28WK
   Zq1ZWiJSnluZBAv6whpy/ccnZRxbk8yRtect9KuYOPEg0gF9MvtaVqieJ
   lHeD7RFig2C0p4/D2bJZZsnAiSLMCsYSkhG38xChhXDcEQ1xUAGllziLl
   ybBBVf4irHnoeR1x8dG2wov6F40AdSegsjqTPfAUggVsOdOwB2CtKuo1r
   wyoQiCDMPN7FdcJXuY59zMFomSsw7UmT5Lcz5+4PONphv9lsKEZsFN7Lv
   T3By3+stKwEKAmR/yQ7Qv+/GZbFxGrRN4i+rp6EK6ikTLYjp4LGJekoGf
   w==;
X-CSE-ConnectionGUID: UbwpelOlQBaJgsyR62VfCQ==
X-CSE-MsgGUID: gC7eaMqvRG+ey2YlEdP1IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="86492533"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="86492533"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 23:04:07 -0700
X-CSE-ConnectionGUID: JiXqDxAJT+2aeqs5Q0EQig==
X-CSE-MsgGUID: 49G91W0uSfWpPbweGg/SJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="251881163"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 23:04:06 -0700
Date: Mon, 6 Jul 2026 09:04:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-ads131m02: Drop redundant NULL check on
 devm_clk_get_enabled()
Message-ID: <aktFUqFUR0-Zx8uJ@ashevche-desk.local>
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260706003712.753a5870@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706003712.753a5870@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 12:37:12AM +0100, Jonathan Cameron wrote:
> On Sun,  5 Jul 2026 19:24:39 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
> > devm_clk_get_enabled() does not return NULL (only valid clock or ERR
> > pointer), so simplify the code to drop redundant IS_ERR_OR_NULL().
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> See the stub.
> 
> static inline struct clk *devm_clk_get_enabled(struct device *dev,
> 					       const char *id)
> {
> 	return NULL;
> }
> Not sure what the reasoning behind that is.  Maybe that
> clock could be already on?
> 
> We could I guess make this driver depend on one of the clk
> related configs, but today it doesn't. So to me this NULL check smells
> of protection we don't need so I think the change is fine, but the
> patch description should reflect that stub and it being considered
> reasonable to plough on regardless.

Ah, good catch! I have thought for a moment about this possibility, but I gave
tag anyway as the stub thingy should be addressed separately anyway as there
are many drivers (I think) that do not check for NULL.

-- 
With Best Regards,
Andy Shevchenko


