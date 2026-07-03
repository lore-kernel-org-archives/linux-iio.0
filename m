Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036B3C3C12;
	Fri,  3 Jul 2026 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081775; cv=none; b=tyZ1IQh39znWO1esf4tMBX3034YrBhT0QvxPXWFaHng5q30oPWKutNjbfHT7m3sIiCUZeDv38StdN6vG+Nu8bVJbZ9Jgf13pFAz6NlidKDRsvqkRTrALcRyS/D4RVUPj8/5aIkhL0IRAZMuQj14ujcF3lonBRBYzn1oXK5FJn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081775; c=relaxed/simple;
	bh=AvEFJx1K49gBul7l1YRiCTeIyGbWFEMJ9eXJZuZm4Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mt/ZV1+zLMFcH1E6597W0nOHYpoRMrgMvIInIy1c/vG2ZSAA9wSOXouUKMRXmHlbG2E5jH4VSRE7MyKhTFgO0h+2prtLi1Qe00pJJGDuU30REbvhnYE0ac6Q1y8CeVyDZyAY+ZVjyy/svOMTvyFJ/DZaHmVVxUDVKp7R4LbB2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFpXNr25; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFpXNr25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783081774; x=1814617774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AvEFJx1K49gBul7l1YRiCTeIyGbWFEMJ9eXJZuZm4Xw=;
  b=KFpXNr25KMbvJHacJg0jv5XX8/4soBLkngZQLVVuNDM2ySxTxZwsBrV2
   gfD+a5W+BWSP9L4fTDNHHizSAggh4w7u1Q3RYet/xsEfwhZY6+Ud3T4xc
   8oz70xQNKT42G4xlTKjsQLPvPlYo4PSCvx4MtsWAtxQ7tznf7804paikE
   0tDbhtuCA8wZ2XZ5UMRYlKlJMNPtjgk0opi93wjJ7Wv9C3boL5JhOWPMc
   2P1SY1gfpnSGhMaj9lAw9+lfyhtmwvzt0IOQET9FWEUzPHzlCGNE8myKZ
   bWPGT2wBoyyErstQkqFd3ATlXZh2c3624Jdpnb6FrHE8OSsIGf17SBfCS
   A==;
X-CSE-ConnectionGUID: r2mj/csPT4OGVHrSxb22sw==
X-CSE-MsgGUID: UgqVaECNToe6Cbd9DLZ2HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="84025802"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="84025802"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:29:33 -0700
X-CSE-ConnectionGUID: 1sQ6Sz7uQx6LZqojg09lvg==
X-CSE-MsgGUID: 3omoCZqySQ20/aHzsfuZzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="255020829"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:29:30 -0700
Date: Fri, 3 Jul 2026 15:29:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iio: dac: ad3530r: Make regmap_config selectable
 per chip
Message-ID: <akerJ5qn0ohj9NVx@ashevche-desk.local>
References: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
 <20260703-iio-ad3532r-support-v4-5-69d9a336f4e8@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-iio-ad3532r-support-v4-5-69d9a336f4e8@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 06:10:10PM +0800, Kim Seer Paller wrote:
> Devices with a larger register map need their own regmap_config so
> debugfs register access stays within each device's address range.
> 
> Move the config into the chip_info table and let probe pass the per-chip
> config. All current devices share the same config, so no functional
> change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


