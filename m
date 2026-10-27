Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086161;
	b=44OVKGyf96vNY46r4Dxg5y2fSaKqs/zPcVMh5Y/CwhTsBasGu1wOqrl+6bYqo3JenheB
	 jnVDQbJcgpZh6MEW1GiZci7uiOPaBDtsUOOlGWJ9fE38ytCqbINBnlDbVy2F+9rBNBpxu
	 6eevBYJFzlijOfUaVLjcPHXcjoraZIdrkXl2Xy2YI79ZNpsah8NN29o/WnyELjbMy0As0
	 p05cSSM9i0MbSnK+FZKnoyA2W+AM5X+HOLdqMuHakU3FCGRavwrHSdLxK9D6F04Vfa4OV
	 6b6P4JvsyQrbGl6F1T1sVxDRUREihL0i5R+6shp/73B6uB2X85Twyo7qMvqEKLmgVeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086161;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=mYwiHk4SQRcR9vDEiR0IB5KVdkiv1Ufl8yFcHjj59lQ=;
	b=Sc16Dk9lwZwGRvovvHklG5j1Z5G6k9EElqfYrZDge3T2GUflG+debLlICCtg4u396Z4z
	 IrVV7rWOOVW9hamAu8e9k2FRqVuoMCAZxbfQ6hzcu1hh9sb0q7igeZMx0toRNsInzmmwB
	 wNY5YOi/IFDydfnyLp/3FeN+x/h7OxB2bkEYXLghCGbtSF5oWHqJIQqYGM0tfRu7Loxtk
	 wq3ieVBTlpV+GFI/fiUbdNg9W/AuQqxp1SxJaviJl7n0yzHTEd3hTQLHq523fRQF1C5KH
	 p3zT2rFRiYbtpXJ0iFzSSTCBDpWAgbkis/nHREL74tLeJ0NPUgXK1k1KJXVdNzIO+Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FycC8dxg;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E880606A31B;
	Tue, 27 Oct 2026 07:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E880606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FycC8dxg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793086161; x=1824622161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Lna6JxOHJF8dEx7Ba/sSk5PMI13DNrHYZsp1gBXi78=;
  b=FycC8dxgQk3Fl+N4BL0q9cidvWA5l6IPg5VXMwCNEdt+jRa8nPWpss8Y
   LEYIhS1DcfB+XA/VcN2lBfL8xU3Dm+KzleUrb3Sg8RGWALjvHCWZ8Ym+O
   OI/LzdSeWdWQvsC5MGYAx4DMUsnlXqyey/HTkBNQtBaPQUrUoMFwnegSz
   WWHq7QZLG93UfAFUdlO9evh9sMMnxfBVx41LAftwvXLCCRXmzzG/pEqrC
   F6nbRJW0bAsHAA0zhJSM09CYt6blKThpv65qxDE7y3HWLpUVHduPQKUb6
   AT8S8bBErk3d2Oy76RJS+pxAkglFUNLNMOVMQu2fmJiLA3/9yzcPcrNqm
   g==;
X-CSE-ConnectionGUID: N7DEaw0VSnOui69/NNiqqQ==
X-CSE-MsgGUID: qLR33nX0SBOF0MRCKkBoow==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1681084"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1681084"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 00:29:20 -0700
X-CSE-ConnectionGUID: EROoaNXcTl+tQ2GnXEjISw==
X-CSE-MsgGUID: J4kLHh00Q0yW8vMQ1DPPnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4350643"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 00:29:18 -0700
Date: Tue, 27 Oct 2026 09:29:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 1/4] iio: prepare iio_format_value to handle
 higher-precision IIO_VAL_DECIMAL64_* formats
Message-ID: <auBSyu-G98vfAi8H@ashevche-desk.local>
References: <at-1SGe6xnObPqPG@ashevche-desk.local>
 <SN1PR12MB25288ACCA8FC85EFBE08CD3CA5602@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB25288ACCA8FC85EFBE08CD3CA5602@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 08:51:53PM -0500, Victor Chernyakin wrote:
> > > +#define GREATEST_POWER_OF_10_THAT_FITS_IN_S64 18
> > 
> > It's an interesting name for log10(2^63).
> > 
> > This, along with log10(2^64 - 1) should be added as definitions at least
> > IIO-wide. There is a series that wanted similar for u64.
> 
> In that case, might as well go all the way and add them to linux/limits.h?

Only if you have existing users outside (which has to be shown
by the respective patch and then it makes the series cross the
subsystem boundaries, much harder to get in :-).

-- 
With Best Regards,
Andy Shevchenko


