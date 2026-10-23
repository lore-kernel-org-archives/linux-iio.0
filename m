Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739359;
	b=G0nofefmw/cQcPHUNfq5/Ec63J6JGWDP1CN9BdvT2HtRDzijOCWYgd2VxE0vKGwZ2Mx9
	 elgmmF7q1DPBf+ewc6fTfm0rwLCEXxvbtOVuFG5ZIeqi+J6bRVxDBuvzyifXP/1YkgS2+
	 HwOXuVtg/xp058hNEFVXgFrJPAJTv7j6ZNky25qJImAWCTyz0HGRtNkXWhs01zoPyfDT+
	 KOQmHNn0hNzOtGxSJyDzgdhs/X/wQaJt3FqGc8gLtbnDSBAf7KMa7UXMXYT8JyTxwv7h5
	 M0jJHV1HqQT7Hb78E7mZQmk4W2qf5BgYE5FDvHqUYr6z0gmYKTnXfaJFN1TBlIAJ3ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739359;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=fryR7TShWyRGfmcbGBMnCv1zdg1vaXZ91wtZko9wv+M=;
	b=I3Eb6K9zdN9+UCKUIPSomioarxK7d+0+ga/vknN3SPoPPBoSb15uZmTDdd5kz6tItF4W
	 a5Sc7OzFIfyeeF4/3zdVpY2aytuOkPht00UbbDXCsgBD2ReDhm0uFzsFJI0pqAbiMf6bN
	 PnrZ+iIwE7YQ5/lpTrLe8BcWWSEkmkiGM8GZ2GsOB1Ly6fCTRj66GIIsXdjoYJE9uDA+I
	 2w30iInOTroXtNdUftn0gkX3Yrv3mkY+kQ5i6YANW9uoiAQugmIhGlniubHm/54Ce0Yik
	 +lUcObwC8E3f8/9+dnIqVhmMAJLvle6/pmTeE32Z3Jh3gzNaUHoca1opRgG0VOX0nmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LUGH1ITp;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E7606A31D;
	Fri, 23 Oct 2026 07:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F0E7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LUGH1ITp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792739358; x=1824275358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9NnRZS6LEK7Silm5AD22OSuoubgtxOudaP6IRQWO+I8=;
  b=LUGH1ITp9nFu5gxxCWgR2oqt+wTD1dlfTCA0UcqaoinoJNKqs3WT6yct
   5pq+Cqmws0AedEHbYoYHQCVejw73rYRHA6klucDAnVLlWsq+UZpGmsFHA
   THpdRyhWHkH3WzwhPjOuCakoqOsfblxF3Lbmca9mbzeVOoL2zGL4bmlST
   DqVr2A1Or+cqGP0Pq/YX+izOYBODpF910ySInmDsBn3f1uSjQCeV0v20s
   RaWkQ7+IBVmera+DhLa9WXRVYLbP9VdNGH2jXrBjFR1CMzPW5FyP4eZOf
   0kU5IeVm/R1PKI35f3NPOA8H7PVbcTCfMZ8cF8S0DFZs/4CgHllqwYGKu
   A==;
X-CSE-ConnectionGUID: 2ABj6mMxRn+mI09JKslT8w==
X-CSE-MsgGUID: 0J3u+2YjRQqSKcco9pPmFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1372154"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1372154"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:09:17 -0700
X-CSE-ConnectionGUID: rnwaRayNTMWN5EXfaqvHPg==
X-CSE-MsgGUID: GzaK/VyNRtuDXp4AzSJRfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3513444"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:09:16 -0700
Date: Fri, 23 Oct 2026 10:09:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <atsIGZswWCjXlNSX@ashevche-desk.local>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 06:40:29PM -0500, Victor Chernyakin wrote:
> This series adds support for the FDC1004 I2C capacitive sensor.

Tell us more. Why do we need a brand new driver?

> Patch 1 adds higher-precision IIO_VAL_DECIMAL64_* formats,
>         needed for the driver.
> Patch 2 adds the devicetree bindings.
> Patch 3 adds the driver itself.
> 
> Tested with the sensor connected over an i2c-tiny-usb adapter.

-- 
With Best Regards,
Andy Shevchenko


