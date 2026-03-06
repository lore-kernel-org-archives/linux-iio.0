Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB0367F5E;
	Fri,  6 Mar 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809531; cv=none; b=IrgQIERmxu5NjAOeDHLahi4xyv9BCjWa5gvuabES6ys9PKFAQ66CHqHmbBQCigZmTzhPI7JEsBj0GB8IsJ0zya53dnYlVoIpXOradtrM0ihNz3Cpzj60J+yzsX3+MBuRYUt8qfuU7emICTIzU4GgxYAiHszJxnOitVeBmEMlPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809531; c=relaxed/simple;
	bh=EheX1CIMS0cyCBflap3f6cGnc4ftoUOUViVLD0qxYvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdZ2GywAQc3fuVqWOsbWePmUkb/kWM+mQDcZNstGu+0GB3fXx6lHM61zE4nJ9DfqEA7tV2OxgEPl6ALKNOrdnd1t9tlrDRC2MJhyfpiqra6gpjAS3cV4bGGf0mfpaznq9XH8NH/i2s20ir+t7ikyWxWlL7MhGa10khECUREC+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZsHM3nY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZsHM3nY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772809531; x=1804345531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EheX1CIMS0cyCBflap3f6cGnc4ftoUOUViVLD0qxYvE=;
  b=LZsHM3nYMZ17fSF564OypTcEFD2ljIokxiQ21+wcl3t0DI+kDBA9RFxC
   Ex4m6o0S1afm5vJsB4E/uoBTy8R54Wv0IsCfsbwwodlk6DUPdeeX1naAS
   3zd22PvPcGnI93JajN1X57spylxiDlfRdVgdYe9MWUWae+j60RM1AydQF
   mIxsWclshz9EoqcAqOj6DpXjQWym1srKXM9+WxImo5DMPS11jL7Rp657b
   Ar0j8qsaj0UX4L3IjgsArjN9lMBFqo0gPPiXyKn+v34sPPYjQo6XttNS8
   6L6p2H00lMefgFRzz4Lc0r4RgBE/dx+DiOu5XdzLrb02PE/uXw9qiw+Jd
   w==;
X-CSE-ConnectionGUID: bLZrpCESS5S2XN8075MuQw==
X-CSE-MsgGUID: 2BHKOgWuSjmqHzIyjZ3vVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73965554"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73965554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 07:05:30 -0800
X-CSE-ConnectionGUID: 1SlPLDocR2ilp5V+gh4Wmg==
X-CSE-MsgGUID: 5FpHZL2+QUKLegjvYC5vfw==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 07:05:27 -0800
Date: Fri, 6 Mar 2026 17:05:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] staging: iio: adt7316: convert magic numbers to
 BIT_U32() or GENMASK_U32()
Message-ID: <aartNY78fP_mRIb_@ashevche-desk.local>
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
 <20260305-adt7316-correct-macros-v2-4-3702e3841c42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-adt7316-correct-macros-v2-4-3702e3841c42@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 05, 2026 at 11:17:01PM -0800, Michael Harris wrote:
> Improve readability by converting raw hex macros to use BIT_U32() or
> GENMASK_U32() instead.

Ah, cool, so one patch to rename, the other to convert to BIT/GENMASK.
Do you need to include bits.h or bitops.h (depending on the code)?

-- 
With Best Regards,
Andy Shevchenko


