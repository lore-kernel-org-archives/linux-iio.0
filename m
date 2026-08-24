Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE83EC805;
	Mon, 24 Aug 2026 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555627; cv=none; b=SF+g6bL1tYExfDOQJpQdkVQzWJ0uauvEaD0WeNsaHXWZA7GwqHRV0Tehs4T5+2qOPgnmPSCZMHtK0jyLGiQQ0WyEcJLdfKr0MldmDk+QUi4j6y1/VvmrGJkl+ml5lVwQc98IsfKAUh0brkEl2Ce6DG6oHgy3FfGdpmPSEnuFGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555627; c=relaxed/simple;
	bh=6PU9FfNeYHzIGbrTRRNz/LE3vQZvDHn59hAkw//uBjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRGJ4Rj2xE8cHf6Kfdg2Y0BLHrRs/GC4sLlYBkLIgwToMCnJRC9gr1fFV9u34osvTSeGtYDe30/ClQDoEqB3zIHCbP4qxYVDnTOp8sbbIfvNqYj4LM8ZwXHmZ47I4FT7XHRwaZwau+JtBpQMnEtTyiDYPixq/tVXghHYaoCO1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuiQ4y8s; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuiQ4y8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787555625; x=1819091625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6PU9FfNeYHzIGbrTRRNz/LE3vQZvDHn59hAkw//uBjw=;
  b=TuiQ4y8sfFb/Lp47ts1wnRKSMBOjWztsloONNswuPmwbAsQW1cR12fYG
   Y3ieSxer4Gf1cu/FS9R7XHSrUeLrUDMIADLACN157mdVZOUsonPtmhX+Y
   r458GAsWplCkhxBZ64rwo5bayoTlmwCn1NhW2De81WHG9tpsvMcLiwzKN
   Wy8Yy3imXbvXDzVbR6pKRD3H89ElyBLyyMpRES5vBk66z8BBYCcosHYhM
   JVHU9K/LPhSBYQMoeS3Uz3/jI6J43K1LUXF6zAuLNMj4vvxYTWRKNhThC
   jFCjm84mIUtJMSnq7D0SCjAgDwPN9kSukkoMi1krfDdLTLjfWi6kryPEV
   g==;
X-CSE-ConnectionGUID: 8XzuN7U3RHS8kXkDivMfqw==
X-CSE-MsgGUID: 5kFhjTIeTKq0Scg0DeXc+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88012724"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88012724"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:13:43 -0700
X-CSE-ConnectionGUID: 0am/2DcYQVe5/J8GIXDfCg==
X-CSE-MsgGUID: RHOFGeECS3SEDfvih0muog==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:13:38 -0700
Date: Mon, 24 Aug 2026 10:13:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 09/14] iio: adc: ad7768: Add VCM regulator support
Message-ID: <aovvIEv0rT95IHDD@ashevche-desk.local>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-9-bb8fbd06d4eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-ad7768-driver-v4-9-bb8fbd06d4eb@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 04:07:02PM +0200, Janani Sunil wrote:
> Expose the on-chip common mode voltage output through the regulator
> framework. Support the three fixed output levels and the
> supply-dependent AVDD1/2 setting.
> 
> Keep the ADC runtime active while VCM is enabled and release the runtime
> PM reference when the output is disabled.

...

> +#include <linux/of.h>

Why?!


-- 
With Best Regards,
Andy Shevchenko


