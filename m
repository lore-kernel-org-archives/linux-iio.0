Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52342765D4;
	Thu, 29 Jan 2026 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702009; cv=none; b=Xw2hH8RUgIp7n0XUZ3Du68RSu9rPhkOELDR29UlZyx1pvdXvTDgcYm6L3pr6njtGj6QsCX3KpcTrLNSdfTAiHcTTJ/wk73hEVQrxVsmte3x4lw8wA5WZRpWtSfTKvndf18kXlKCpoVRfLlarDWrVSC6nLfp4PBfVCoCk9VHv+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702009; c=relaxed/simple;
	bh=mZnHFSnq8BuUzjDY+AjUa2+Dh+XCT+1VfceQR/XpCrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnHAvirLPkn94yoL3nZSEAUHVrOdUTBaByxM3L8m5TlzaPQJGWvHM4IO43Sl9g3QC3qCnwGsva/tYihj5WKh7ScYo8DnDHCHfJKXFlxegzSeyo3PS9UnMJIYJajzi1Vo7RPy+aOj3Ysx2epwQYs+l81d/xoqL+LwKoS4yCgQlwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ao2iaK5j; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ao2iaK5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769702007; x=1801238007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mZnHFSnq8BuUzjDY+AjUa2+Dh+XCT+1VfceQR/XpCrs=;
  b=ao2iaK5jnK823lx1r/AczzY36WbrDkhmEwor0Zsw7ePOtlxuijz3iGFm
   To96sxgK1WFAcRU64/gqnMdr4AqLeRzqEWobrBtKumH1XPPrpvvIJ5KtG
   7It4GugGv5dQbjpyz3EqeH+APskQrIYEYy1rtb0aL4okD/t2kwBamnLW9
   sRxBW0mBCeC+nBHfGDmmJlNqrpfgcgX3Rp4RxN76D/oiTVy/G2k1JCjwC
   iNzYLlZiPecte6ZmhKbfcyj8FroVtQAd0jXGuzsShEWyI4br9Zj4PJANT
   LhW1ym1buCl353BZR1+FApErL1E7y7G6LUEGbHXcijxwwAHdpsM8AnqdM
   w==;
X-CSE-ConnectionGUID: Zs+MKdqdSU6kV6EHOWJYbw==
X-CSE-MsgGUID: AQmNhvI/RAes5/Dw9xya/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="73538376"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="73538376"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 07:53:27 -0800
X-CSE-ConnectionGUID: CcF71iNcRwCyVImrV9Qkgg==
X-CSE-MsgGUID: 6qbFhrroT9q2muJzMgqL/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="239340752"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.155])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 07:53:24 -0800
Date: Thu, 29 Jan 2026 17:53:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: itg3200: Fix unchecked return value in
 read_raw
Message-ID: <aXuCclfJWLYkfF4Y@smile.fi.intel.com>
References: <20260129150151.127713-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129150151.127713-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 05:01:45PM +0200, Antoniu Miclaus wrote:
> The return value from itg3200_read_reg_s16() is stored in ret but
> never checked. The function unconditionally returns IIO_VAL_INT,
> ignoring potential I2C read failures. This causes garbage data to
> be returned to userspace when the read fails, with no error reported.

> Add proper error checking to propagate the failure to callers.

Yeah, but when it's not a series do not use --thread!
(P.S. do not resend, it's for the future now)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


