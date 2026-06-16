Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133FE41C314;
	Tue, 16 Jun 2026 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605857; cv=none; b=LSblAqpcutiqjBWphQ3ZsK+Ro8aSU38BGZrr1WwFVR96vMQ7Z9zCS9yyXtzqzhKyufPeL5H6D+fqjtYfFQ11JgVOHWRMMG+DAWv4jWoW+7/hV6SFKBd9pghznJN/KSdXZYUgI9zd07/nUnPHeC/TpEjj9Y02C++qvL4UoOXpjXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605857; c=relaxed/simple;
	bh=B7ujG2wAtwBoI8EMEA7TCT+Lnm2XPa8/9lhYLUhPF+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh0488y3g3qht+Gfye6GuP5VViw+XJb+hi/N+0jToeUqwPuAv8U2saYzpku+k6gMTOdp95gSN06IKyISTFFGWgP6kJhUap0jDlI5Kmk0sCyajfNVXE2waENulzucxzuA2YhqrdlyQ1GdKpBFuWGy8TZ8pBV/Gdxcftx9LBv7K/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvBe1hqa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvBe1hqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781605856; x=1813141856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B7ujG2wAtwBoI8EMEA7TCT+Lnm2XPa8/9lhYLUhPF+o=;
  b=EvBe1hqa0d0IsCFD6yJ/5K+yIDwoiJ3hHfLdSNoCbJmMVYaHiGdV7sZD
   bxreC0jsUefhYRujPu9E5n1Dpg/6PhN9YpPwsX4vbnQHTKKZfpEyQvoe3
   e4UmXJM1AWySnrTJVfbBEkpEcIxSHCDbXQndg174Akf9cQ0gVTxJipZvd
   oLEqj68YAlLPPvdsUd9Eryqd2aHGquu5Iummnb2r6RxuoCSjQBNEKjGwX
   wZAWvbCkKaozL2iG6koYUaXbrzAsyUPMKVBrHLPdanRzzjcgaiEQklZW8
   GWLAZJ2wkxicnI50aErkxnNbsrXSlhAknqd2SECzHjKlSvd9EO+3KMMdr
   A==;
X-CSE-ConnectionGUID: hBD60iRQT4qbavnwhzUHZw==
X-CSE-MsgGUID: VcUkJXOSS1S2FiZKGd9NTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93038765"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="93038765"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:30:55 -0700
X-CSE-ConnectionGUID: AM4MX+q9TFW+IWr7nIj58w==
X-CSE-MsgGUID: 8xN9SZuxRaGYSzVvxbmmLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="252038246"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:30:52 -0700
Date: Tue, 16 Jun 2026 13:30:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 06/12] iio: dac: ad5686: consume optional reset signal
Message-ID: <ajEl2ZHlLixttNoN@ashevche-desk.local>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-6-f829fb7e9262@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-ad5686-new-features-v3-6-f829fb7e9262@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 09:21:12AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add RESET pin GPIO support through an optional reset control, which is
> local to the probe function. A reset pulse is manually generated after
> the device is powered up.

...

> +	fsleep(1); /* reset pulse: comfortably bigger than the spec */

What spec? Same comment basically, extend with the reference to the datasheet.

-- 
With Best Regards,
Andy Shevchenko


