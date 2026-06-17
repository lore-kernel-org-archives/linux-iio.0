Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8293E8C56;
	Wed, 17 Jun 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691447; cv=none; b=dAdmkNobFfStcbMNG1qGH5kZuJ8SxsKfI/Aa1EgeNgoHvuUkOHF0afQC2UFtMEKznozKXo4AyeRV5sCrHwzxHdSnkfJu1GVE9bLSQkJ6FzGkIU6ndx+gLAYR+3sdCEfLuNjoDcjK1Xdgqp6i2v9RflmGHOEutBE7E2x/dGiLVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691447; c=relaxed/simple;
	bh=7DtXNB6dJxPrKC+/q1ctMbexUQmsZq81FVmAWr2YWP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az8aPgOltihFJDe52u0HeyIqbKlgee5fhSW+FpaR6zzHJQ927Ps+wU9jHzQ/FvcriVVM32P5LFS3xn3aQRIGk5xTOC0gcGp4ynA/4bVXBCZybk9D+s684jZsdtjOaBU8VrwvJotQREAwfMd7+SufS/zJK5dikwfJ4HpWtbbZ83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McTSi807; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McTSi807"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781691443; x=1813227443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7DtXNB6dJxPrKC+/q1ctMbexUQmsZq81FVmAWr2YWP8=;
  b=McTSi807juJw3rWDApporRMvfiYmA8GKe8VtDOjXurfYT5lzkTLV7NMI
   GB22r/ZbtpX+OCytm2pRSqOjqqssAgo3tY+0PGxnpnWXCxbQ1SHKt80uR
   kC6WdhOu9i6GqsvYjX5duSHvMae52fOXr1SAbWFLB9lzeAfkK7SV/oguQ
   b67Z1vC88N/QGWXnWIECqQKYa5h3qNfF76HJATcANeskvwO4mPobE28V0
   9g5m0Q5NGN7S8H3FekafMjkyb4GjW6dQuaILuqXm8xlqRtZ89h7mbK7ps
   D0ZXBl/YKJ59IZbqkYxD3xGOAqhOP79nP3V2h2afu9T5YxQZ/Oaa0he5D
   w==;
X-CSE-ConnectionGUID: NvMfp7BrTgmHp5ILZA5T9A==
X-CSE-MsgGUID: 7QLKDpfLS1mKEJC19Wh3mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="86407461"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="86407461"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:17:22 -0700
X-CSE-ConnectionGUID: YMv36j2DTteT5bSnU/BGbg==
X-CSE-MsgGUID: YQtAPfYzSDSQ631tOqT5kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="278219245"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:17:20 -0700
Date: Wed, 17 Jun 2026 13:17:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: hexlabsecurity@proton.me
Cc: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	Sean Nyekjaer <sean@geanix.com>, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3] iio: accel: fxls8962af: clamp the device-reported
 FIFO sample count
Message-ID: <ajJ0LSXQmuOhj8Pr@ashevche-desk.local>
References: <20260616-b4-disp-2e8d94cf-v3-1-c4e092eef3a2@proton.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-b4-disp-2e8d94cf-v3-1-c4e092eef3a2@proton.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 08:56:15PM -0500, Bryam Vargas via B4 Relay wrote:
> 
> fxls8962af_fifo_flush() transfers the sample count the device reports in
> BUF_STATUS into an on-stack buffer sized for FXLS8962AF_FIFO_LENGTH (32)
> samples, but the count is a 6-bit field (0..63) that is only checked for
> zero. A device, or an attacker on the I2C/SPI bus, reporting 33..63
> overflows the buffer by up to 186 bytes: a stack out-of-bounds write.
> 
> Clamp the count to FXLS8962AF_FIFO_LENGTH before the transfer, mirroring
> the clamp already applied in fxls8962af_set_watermark(). Conforming
> hardware reports at most that many samples and is unaffected.

OK!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


