Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B332C33C;
	Tue, 10 Feb 2026 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753798; cv=none; b=ojDgaqEUOlzv5pxliVbhTjjdBWU2T5xt53KA318W6JYbd8VE7gNbBIvRCaqcNTC6hVqpwwmfesNy4MuU18YBMMKk0X+FiTPcnM4tFeTEItZvgys1HPCIhMqg1CDN8tIr1oCQW2izM9HWwAhw+HE4Uv48KKXsWcvT93C8iZ1+XWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753798; c=relaxed/simple;
	bh=y4F/y6D5AFvy0zqZ8NnIuBIvrOWxnBA2C2j8AD9KPy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVn/nlgqjIDQlr9kUuXC8O4XlhMopKzG0ZbdLFccRbBAdRJvEC60ZXOWCW+kpymZzEiIMe6so3fUZBKMCJsShVsa+h/ooa+lOFNw5LTJSZkFcWNGVcDRDwyp+kYp+hsxusp92fK8MAu9EjTAuX/vynKV2VZNHNjRI5vBjhiePWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/NTGlXF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/NTGlXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770753797; x=1802289797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y4F/y6D5AFvy0zqZ8NnIuBIvrOWxnBA2C2j8AD9KPy4=;
  b=c/NTGlXFwP19B3h8jqtTPZf4jjKHehU+o+xcwk1u8Iny38R++y79Lt5G
   0coFTTBYPp2UHR2JZd6xCyF5VMSkMIgb1sjPiaI8zs6WSipKsyddHDISj
   0N6cWg42piBipXABCTZr/l5apSyp6Nbjb4K5zuarcJlnYt9dLgjl5nDKW
   Eck5+g2IcPtVZ68JLfrkFCLOFMbKk2Qz2tMKK60zwVV5zD2X+wXH7WRaJ
   YfzMSKxyNR4dhdiSCYtzwWy5xtCh6KEYuIEB+Ey2ohAaOz9crlu2HkfoR
   lmZHAUHJV4irWRXSMJJghAGWpVZbDiv62CYztxEKzMMz/2Vv5BpNqYBjY
   w==;
X-CSE-ConnectionGUID: XHTjkMJ3QtO92VhtsCQgcQ==
X-CSE-MsgGUID: jJTCwd+hTjKhqQRBSS4XtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89306809"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89306809"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:03:17 -0800
X-CSE-ConnectionGUID: KCVAWijXQWyM/ZTwrqHyCw==
X-CSE-MsgGUID: I+cYhgZ4RzKNnIpOg79DRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211483520"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.131])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:03:14 -0800
Date: Tue, 10 Feb 2026 22:03:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 04/11] iio: amplifiers: ad8366: add local dev pointer
 to the probe function
Message-ID: <aYuO_7cot_MAVyPh@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
 <20260210-iio-ad8366-update-v4-4-15505f7b15b4@analog.com>
 <aYuN_Myx3FhmyQf0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYuN_Myx3FhmyQf0@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 09:58:52PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 10, 2026 at 07:42:04PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Create local device pointer in the probe function to shorten lines,
> > making the code easier to read.
> 
> Only a single place to convert?

*Yes, I understand the intention, you need to explain that in the cover letter
and/or here in the comment block.

-- 
With Best Regards,
Andy Shevchenko


