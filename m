Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14F34FF62;
	Tue,  3 Mar 2026 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545766; cv=none; b=HTtQfsr6WPPZ1n1omJEXgiRrc0qnN2Yo0dkuPrHuybA73i1b+Ko45nZnw6yOuF0D9P27Nr0vw1bQLk98WgJpWGdHqCF5R/t+/HB1D+j2Z/GSOGkeXjt7wDvQEXZ2fEk4Z+YiILW3tmt8/84tcCwqfRoW1PXx2rezsR+6bmFvOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545766; c=relaxed/simple;
	bh=+AJ2/PIieuQuxzYACUS/CrkUU9oo9mrVsUn+s7f40FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpasXz0eV5uqb0SI4A5ou5La6w7fayLPy3kvuOn77HV2dG9gZ8r5cdmO/Pzb2/IqCooGehK6ubUTrGu55OqhVgcAgLPtmk0nzncOMSm0JRHvDpLtZyw+ugWqEVuKwLnEnmyhX4LCKSEAn56Wgl/zly0YbMdX91JwLya5x+edSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgnqM2I+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgnqM2I+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772545762; x=1804081762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+AJ2/PIieuQuxzYACUS/CrkUU9oo9mrVsUn+s7f40FA=;
  b=YgnqM2I+Nrjs69Pmewj/v3xgzFyZd2mCb6jAWYsFiYJ8Rmqc4NIoLV4G
   nJHobt9N8k0xSpC55Hoo4nPL4jYezrleuEctYlcD1uiND7iOv5O3+cvI6
   Oxr9D9is1xRhTVngrxpnXlQ4AdynUpmtzwk2EL2JhSlf+wZ9arxE2pVTj
   lNq8KnNIv7b4Gw6oWhZXkvObKLHF4gs//ohbINsfaRq+se5Z0i5cC7Wak
   D1oxK5bM6xCMzgTLqgjtk7H6XObZR1yqxA8DgtesxHgPr5gMFIoshJ5Px
   sG5X/kK/qwJASJS0FEzs6d7A+cjRTWIqS/4H69lAqFZv24QXisr8o7KmS
   A==;
X-CSE-ConnectionGUID: VFnTYrc3QjuxJpp0Udp3GQ==
X-CSE-MsgGUID: W/SwgMlyQKmfSoQ+v1Hqkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="90978706"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="90978706"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 05:49:22 -0800
X-CSE-ConnectionGUID: jUnCN3x+QfeUHFCXAIVMeQ==
X-CSE-MsgGUID: p5Bzx/P2RSSBlAoGOrN0Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="248498513"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 05:49:18 -0800
Date: Tue, 3 Mar 2026 15:49:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 02/10] lib: kstrtox: add kstrntoull() helper
Message-ID: <aabm23jCikXs1l6F@ashevche-desk.local>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
 <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 03, 2026 at 01:27:07PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add kstrntoull() function, which converts a string to an ULL with a max
> character limit. The function is an alternative integer parsing function
> that does not require a null-terminated string. It becomes a better option

null -->  NUL

> over simple_strtoull() or kstrtoull() when parsing integers from a buffer
> with custom delimiters without having to create temporary copies.
> The function is consumed inside the implementation _kstrtoull(),
> promoting reuse.

But this will not properly convert 0000000000000000000000000000000000000000100,
for example, if the max_chars say set to 20.

Also kstrto*() have a common idea behind to consume the only \n and allowed
digits. This (naming) doesn't fit into the kstrto*() category.

-- 
With Best Regards,
Andy Shevchenko


