Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687047;
	b=hFUqMGQDjuRqxDBv9DZsxM9xhxHF8eAwSAuxKxvSv3WGr5hWWuLC/lONuxhWC6HA7zik
	 uYQxhoxp/IAGGi0rJVnjrFI+7YfrfXjt/LJVwVt9KV/bH+GGbLRj7SGxKYGdEAonK0AEK
	 4CEYp0eOSlcIH9TkCFqZjOD4Xk1MtURpIkKqFgT1YQkebTyWS96aNfCtLmhc14FslpxlN
	 kxI9BAU5jNRe7ov6iK9yav6n5nfS3ImQKTIibq4ByA06IxSoD2uU6xssQneahw7iqw48R
	 OvYe5y6tsRL+vKNxNDMFmVvoINegIW77+j+52+H5EbEDXezmYYVFkQrY8WeWJT27sew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687047;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=bvcmVD1sUQbK5xPKMU225rA7IaPtKD1enV8qr1Y7JII=;
	b=dYSkEV6J3QSkcLU9iTPEF66PkmLW+VcPEDoZaaSZxsZLZbwiLr9vkdm8VyLsWFEbxEb0
	 sryB+CzPhhx9fzZzmszLVOmqjBkHuoIQj4WzEXObfe4XZkFDicenaPQj7YwPbHG795/oL
	 5hSpfkqMYBJibEAwpeIs/KaQU99ZRN/yAXqX4RxNkQvTw6lXsdRTHoX2cHZqO6trItsEv
	 XSgzyc3S/ekrvmm2zgOhD01CraheoaesQ178YCTay76Rjm9Gvjdu6UNTE3VABREoXQu8h
	 jyT91UaA45slP8YamjOBSHInFysyn388WtFDrvxvoZXUlsscnykR3lCirEGCRifUCIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PCdQ5L+I;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F4606A31D;
	Thu, 22 Oct 2026 16:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE9F4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PCdQ5L+I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792687045; x=1824223045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dHkUONcFRwNs8564YnpQ3UExvjh0fHy79c7uxbfPXd8=;
  b=PCdQ5L+IXp01DieSuAr6TCKvFuLnGUpHEPQJyb3TunnWCwAzR/23WJAa
   cfd7t8kfW35x3sKmL7HLZoZBdojA+SGRrrtVSANS7rzkiix9fG/EhNKh5
   oojEEEmQPjL649APdsjQlxMSOrYxMacXUMhhqcnSOSc667NhphNGdPbF8
   +7ckhPWbxPS6Xi20x0DpmRSGBurqHBgObOvb9gr/v6U6zRVyXHRvimiZc
   3WK2lpv5AAm23F8NBDzug4M3/1lTD/IPmuzBj37lvwo+pPIQgrxvlUQdB
   YACb6b6oEF6AObORCDAlAu2d+JpjRaHCp15/wXk5cWtNnPTlJwFfZgYNS
   A==;
X-CSE-ConnectionGUID: E1+USnR6RMKcYoGGBuPWIw==
X-CSE-MsgGUID: F1ZM2Oi7Ss6/Q9Txzrjlhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1316253"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1316253"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:37:25 -0700
X-CSE-ConnectionGUID: DkuPoQevQxyACK2df7JvCg==
X-CSE-MsgGUID: wmqnUGbpSpeqzOE2k91fdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3351086"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:37:21 -0700
Date: Thu, 22 Oct 2026 19:37:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: check the return value of the
Message-ID: <ato7vgweOlpMA9eE@ashevche-desk.local>
References: <20261021225450.628499-1-kapoorarnav43@gmail.com>
 <atoyD5GpW-4uWKjq@SMW015318>
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
In-Reply-To: <atoyD5GpW-4uWKjq@SMW015318>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 10:55:59AM -0500, Frank Li wrote:
> On Thu, Oct 22, 2026 at 04:24:45AM +0530, Arnav Kapoor wrote:

> > The driver ignores the return value of all the regmap accesses. If one
> > of them fails, e.g. because the memory mapped registers can't be
> > accessed, the driver just continues with an undefined state.
> 
> MMIO never return failure. if write register fail at irq, it will cause
> irq storm.

Strictly speaking it may lead to some CPU exceptions in some cases, but that's
different level of failures and not related to the error codes from regmap IO
accessors.

-- 
With Best Regards,
Andy Shevchenko


