Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8869352FAF
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546206; cv=none; b=X43M4ILoYcF8dFle18Mm37Hu3CJ+HIU64Pso/Hqu16kaSue4wzRqeP/CXHyw6r1grLksOG0/9mw1yTd6B3ssCgjshqTAqbLexuCsEzfZRfZcMDmK7OsYNYF5whJW1uFnqmol30PVCYBmg0mbiI8I4zOP+0iBhdGDFqpbomvygBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546206; c=relaxed/simple;
	bh=mX3K05MwrLNBdzykO3qy+4r6dNJo4go0QzbuAUYm6UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC55AORyyDH0nUdKAO2wS/MFlg2la+e39tyKuBnF4XP8G5yQOkFMjc6Y/fOWTE7z4p954RPLGTsf7XPS6IyGyiSVddIdzDMomea8C33oMeoXxK9zeQ3vlLsiZtxBXz6vuhsV5Vrv0STZbI/wT81bnq7AcrvGnMqvXy3F/mdvZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bz6Sklw1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bz6Sklw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772546204; x=1804082204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mX3K05MwrLNBdzykO3qy+4r6dNJo4go0QzbuAUYm6UA=;
  b=bz6Sklw1PYVBWe8NggJTDl690FeaZmhTPkHhXfdjc6W6ZUF2OEzDLK2n
   2j1jyDEbqepOy2YE9OqTiMnfhl1+hYfo4P8t4KkPucQxtU3kgp0nOd03L
   OnSCWCbik3PeKVs9SFHMPTL3Y7JARkGy2gZ2azvD0kvhL66ZLWHG3BFWy
   LPpYZrLXVDJqtkPDnOfPiw8tyBFR2UVoM2Zc/Dmyy+XGeauvQzTJdWW11
   18Yxwzn32fHITIY/8rfSVngpEB+sHuCYKBoc94mNXRXYf19VENjrLHEeo
   1Rkfdja21bbsHtiV72bbWMfnuHLo3m/01O9yfFohAoKq0gtMPPwK+101Z
   Q==;
X-CSE-ConnectionGUID: U4tr/5IzSQaAf8JrPRJfSw==
X-CSE-MsgGUID: muwmfUbqTR+pjvBjRjN3Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="76181393"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="76181393"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 05:56:44 -0800
X-CSE-ConnectionGUID: EcDHw2RtRBG0p56Q1sD6zw==
X-CSE-MsgGUID: ckGuRw0wQIaYNkGj9pSyRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="255881054"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 05:56:42 -0800
Date: Tue, 3 Mar 2026 15:56:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer: hw-consumer: remove redundant scan_mask
 flexible array
Message-ID: <aabomFELXIHGZ4TV@ashevche-desk.local>
References: <20260303-iio-improve-hw-consumer-v1-1-1a19b41977b1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303-iio-improve-hw-consumer-v1-1-1a19b41977b1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 03, 2026 at 11:50:44AM +0000, Nuno Sá via B4 Relay wrote:

> The scan_mask flexible array member in hw_consumer_buffer duplicates
> the scan_mask pointer already present in struct iio_buffer. Remove it
> and allocate the bitmap directly with bitmap_zalloc(), assigning it to
> buf->buffer.scan_mask. This simplifies the code and there's no need for
> the flex array allocation.

Makes a lot of sense, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +	buf->buffer.scan_mask = bitmap_zalloc(iio_get_masklength(indio_dev),
> +					      GFP_KERNEL);

TBH, I would place this on one line (but I leave it to Jonathan).

-- 
With Best Regards,
Andy Shevchenko


