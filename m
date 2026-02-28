Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBAA3D7D9E;
	Sat, 28 Feb 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772275854; cv=none; b=BNf0DjjS0jqstl0Ud6zDSunq7WMeo1NxYX0oHSacdi9w4a2dFKodNHNjGiptoQxclPKB2mTyam6VCznSPNRjl3ABVEK7G/l+TvFNcnKxz7UasuHRxXIez3vSnl1NWt6BTkLYNA0rxxNGQ4TBARyV2eYyCYz37QqijHoC2nkYw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772275854; c=relaxed/simple;
	bh=uwvZwCB3Vp/FxlpN6HgUQ3BdXcmuGyPGjZmWitt8bqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOdyXaPMStalrrabpt1WTFkmUWXxoTDDe2wscVih0WXBXpL8FikJwqgmtKO42o9bdbBytGnRIEoe8rpg96hg31zvynQd61BvvqQI/UBfp9oS4J8UcHbL2iWl3+HKnCDN7bUZ4UD6/mZdi/bJgkzjgAyGBnGe3sR7412aDZbIg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtwYKyFA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtwYKyFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772275852; x=1803811852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uwvZwCB3Vp/FxlpN6HgUQ3BdXcmuGyPGjZmWitt8bqc=;
  b=YtwYKyFAB4SPKTX3yhF4adI/GvLrW2ZyWOXdu6958y1ccAgHZ/5GrIA/
   x4QeLuY88pekLNtZXv3L06j57kpdUHX3g5nVXB0gOOfz94sGTUAgXR73V
   FA6DZ/2XBd29n/dGL24HEO4zb83FcPKmww5fSA5JKyq+LIAHeneDHwVPD
   xbTNNIr2t8uuO3o0m0KmmxGqxsjneDK7PKxx/4FaAtbM399wMKFmgEKMI
   dNSUQAJF0V2rq9rQG++bTWLNMcvhbE6Cx9wUeCGDp+JxvKGjq8QV9y5ua
   nzh34o8MCg9Sjm9L6sASN7EcQHpiP+DXNnCzcYaY7qKQ9ZzIAwrOth22H
   A==;
X-CSE-ConnectionGUID: 44RKb2XAQDSVOlwuf1l37w==
X-CSE-MsgGUID: eUlL4kHsQU23KobqZiNQtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="90926338"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="90926338"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 02:50:52 -0800
X-CSE-ConnectionGUID: WM5ztWMIQz2OiDYBjeOoiw==
X-CSE-MsgGUID: aEZ23wz4RN+2y2Q+MQfljw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="240157971"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.224])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 02:50:49 -0800
Date: Sat, 28 Feb 2026 12:50:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ammar Mustafa <ammarmustafa34@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Docs: iio: ad7191 Correct clock configuration
Message-ID: <aaLIhgJjrNlp3oTy@ashevche-desk.local>
References: <aaHrsTS9iG-PEfue@ammar-VM2>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaHrsTS9iG-PEfue@ammar-VM2>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 02:08:33PM -0500, Ammar Mustafa wrote:
> Correct the ad7191 documentation to match the datasheet:
> - Fix inverted CLKSEL pin logic: device uses external clock when pin is
>   inactive, and internal CMOS/crystal when high.

high --> active

Thanks, this part looks good in the below documentation update.

> - Correct CMOS-compatible clock pin from MCLK2 to MCLK1.

I haven't checked driver yet, but is it only for a single component?
Can you double check that _all_ supported by the driver have the same
in their datasheet(s)?

...

> +- When CLKSEL pin is ACTIVE: Uses internal 4.92MHz clock (no clock property
>    needed)
> -- When CLKSEL pin is tied HIGH: Requires external clock source
> +- When CLKSEL pin is INACTIVE: Requires external clock source
>    - Can be a crystal between MCLK1 and MCLK2 pins
> -  - Or a CMOS-compatible clock driving MCLK2 pin
> +  - Or a CMOS-compatible clock driving MCLK1 pin and MCLK2 left unconnected
>    - Must specify the "clocks" property in device tree when using external clock

-- 
With Best Regards,
Andy Shevchenko


