Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176533;
	b=Yi6aInLcKCKJxYLNdsV/FcVPYfxqb3mWhIru0uGgtSJZv/MuHSKWNknqqcO6r8MiVduP
	 vnXVOdWsV6EDBqPrFsMUJDIiXMXKoddb57LeLhS8HZklYaVpHThzjAbX8drsrMzU4OzbA
	 2yZqTGGhshtF3Mk+rL10W7PD5wWMYumrGfK92xgqVYcy+L9WCAf0M8VMy2wBPnwSZ1VDS
	 lwZ40tRrWBzWDHIebC49yVYcoHUCrRtUNwJ20u9OgWTmvhXQncLYdyS3+O4DS0CERorMn
	 IzTxKMGNxkiYaOCFFSIP/UvH9ZQYZx7mguKMWLhlgXxg6kCDBN3EwFdN1ixwuuV7CsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176533;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=WCa9strBroiKVUqch3GLe3AjqpnhMC9WI7cX056Q3dg=;
	b=YBZEp/NUnLMCmjbmDHTcfFre/7GjRt6OK3g8Tu8BH6Iq6oEl0AwO0ZssEOy68KafhkEu
	 dFoeYdnKEDe7hFZb1ywCmMrTyeNBx3VEzgXEw7ypNMsXUuT+kiJh4/pS2a4W7bpX3XaKM
	 5R2E4mKwSSAVWMei2MC6v/b7mQqJfPI4h2WqQF2CvK4VB3KoXaGSzefd6lm8hsL30bqf5
	 v6/OdCcXXgRIoPckJowsyoxwQcGXVUky9fc1J4U/qLzwrwjO4+X4TyUllj9hx9MEFUDZq
	 nuXbYH2zDbgk4WCnFGLgDE/v46DvR4em6v5j86lrfs7WuXqxKGRDUTqC/sGWUbqBJJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bFEqrnSh;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98D606A320
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 12:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC98D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bFEqrnSh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795176533; x=1826712533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MYmMVVEJb6bEFRdDnp1vgCqNj3M/j/4blcvKO+s13y0=;
  b=bFEqrnShY4zep1Udn/5iWY565u6nY00ZaUdifBsfZ26tfZmXq0hdN2eN
   KhJVLk8ochIXmHieYN8Rywq5xD7LvThXI+IapZ/KFtMnv4O2BfbUGgCIF
   BHF8V7Fj2RMPNzY/zegKGxKYvQzROOVIHlOzPePo2ilb8amjs8B4MEZFo
   Y2c8ZXRFKtGiKves7lH8ucYX/T99aiZYCJKfMvEPkwzn6iyl9WJ+GV5pl
   lvzfy/DPxQMYfgMjRZAI1hQu+5z7UMS0wMl5zcIBWIVP2ZNoZUslU7NAq
   LzJmlayDdqH9nYpY/nte9h6Ywnme+pID9A0jyEZmovAn6TEHsNYTIAA4M
   g==;
X-CSE-ConnectionGUID: ZWvVWK9dT02zDN1Eawh4xQ==
X-CSE-MsgGUID: 0i4Zl9zHTTWzqxT3j3Iu6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3944067"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3944067"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:08:53 -0800
X-CSE-ConnectionGUID: 01wPI1I0Sjip3EnO8kF5ow==
X-CSE-MsgGUID: 47aEvR5KSrmoJdlZcBsSjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10577554"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:08:50 -0800
Date: Fri, 20 Nov 2026 14:08:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oscar Alejandro =?iso-8859-1?Q?S=E1nchez?= Lucero <aleszlucero@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcin Malagowski <mrc@bourne.st>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: pressure: abp060mg: Fix max pressure value
 for abp001pg
Message-ID: <awA4UGByqJ1OMxWb@ashevche-desk.local>
References: <20261120-b4-abp060mg-fixes-v2-0-89a274d68a9a@gmail.com>
 <20261120-b4-abp060mg-fixes-v2-1-89a274d68a9a@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120-b4-abp060mg-fixes-v2-1-89a274d68a9a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 04:28:26AM -0600, Oscar Alejandro Sánchez Lucero wrote:
> According to the Honeywell ABP Series datasheet (Document 32305128,
> Issue 2, Figure 3 "Nomenclature and Order Guide" and Table 7 "Pressure
> Range Specifications"), the 001PG gage variant has a pressure range of
> 0 psi to 1 psi (1 psi = 6894.76 Pa, rounded to 6895 Pa).
> 
> Fix the transposed digits (6985 -> 6895) in the ABP001PG configuration
> entry so its scale is calculated properly.

Much better now!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


