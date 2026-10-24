Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792837322;
	b=fYnIzDnR8oDzCelXiDbV/aj5U3REHA/51VNpDXgdQPpNJ4HtYASwKLIDfhyzGtc7xMML
	 vfX8H8yTHUiV8toEq7WliGHTWrWWQE/TyO3Ke+QQx65nNgTvMbSlblD0gVOaotaDkjnKf
	 ltC0oENxbQuEAawaNZ1f5qHAx6IeaDBkcYEt2UBV5cyaarUeLgc+nzWRxCak8dX2hYYst
	 g0kfQVEMiozAO9oLRnyAxkiJJBzdpXRs9+/zTxIE0vDPgcg7RrsWJet9FAecFXrRA24iT
	 egPBPS3mkDosPqlvrSmOM8XM2ystIDm24OmW6T5SHDsfXw+FXX9eruhcIP3+VnjlfZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792837322;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=v9YehrfjY//klgwdtppepwoMT0xnKqZFEvM1cQ7p8bU=;
	b=WhtVlCFBjkAoSWoynU2rIfQoajol7xntw9QZyOvpo5gWncZg/tZBEmwALDZzokGVED+v
	 9TgNxGCLvuiHh3HWJyoqKSOmXtDEKxvJA+YX8oJnXVKHYo8f2rhKKadZH9k6TsGFcfSxS
	 sSv09DyL89UWO0vFXG42w1reJJ/7QtILqhAwl+lsOwXTpkWiBTvwlHEyAz4AcBpD0D1dt
	 Tao0I4Rw0/4sc9uQw2sU7hYN0qopHbunHO1QNSxXImYEKAbl64OyWk+SWyN2bgMlLCmos
	 vvbblw4By4ZKtjrWVg7xfYDCjRr++jxSjPspjNcwC/k6EoUrgeIOSyu1fJrxOx6y+Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DHstR9Q3;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4E606A31A;
	Sat, 24 Oct 2026 10:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C4E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DHstR9Q3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792837321; x=1824373321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2es87lOnL79NVkGC8eLeB9vLHMcY+HO1ORvjOcGsNow=;
  b=DHstR9Q3QN1W3cmI548+xkuuG2xcsTkRgi01d4TinF7iHmFEOszRSH/d
   M9llEt05DN/HyGsmkt7WkbVugxyzAnAemXqaL+Yxtp9ltDqLjV60aBnKl
   2EryadHqzUak/OeFUdxQr6IpqDvR689Lrd/GMYNJydnpxgHqCTIxehExW
   qOnJp3CPH+S4pcDAos4d1IMenDvUSjXwwo3+isDS61qRUEDEfeuQca9es
   VRFmXUiIBf1EhdAsflTs+jg+GOFF6giG0y2ioJSeiO8GPAq6n13l6SdFB
   2R4wzpDvoLivgrVeqQR11bbUsev1FeDHbnKhezwX1ZW/vYXXYUX6j56es
   A==;
X-CSE-ConnectionGUID: lkcNjS5DTO2/hABL2g8amA==
X-CSE-MsgGUID: uJhU5MmvS96Lbav4IVU3Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1591649"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1591649"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:22:01 -0700
X-CSE-ConnectionGUID: ooKUZP17QcmrM6XeSKCSgw==
X-CSE-MsgGUID: g5mUuDcvTzCyFd3K/0e7/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="3852337"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:21:58 -0700
Date: Sat, 24 Oct 2026 13:21:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <atyGxFmgv85JUTls@ashevche-desk.local>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB25288BF227D6555AEE60DF73A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <20261023040143.2e7043bc@jic23-hlaptop>
 <SN1PR12MB25283EB260FD897BFE29C603A5632@SN1PR12MB2528.namprd12.prod.outlook.com>
 <atyGJD4ebU6Sq8MW@ashevche-desk.local>
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
In-Reply-To: <atyGJD4ebU6Sq8MW@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 01:19:20PM +0300, Andy Shevchenko wrote:
> On Sat, Oct 24, 2026 at 12:13:08AM +0000, Victor Chernyakin wrote:
> 
> > > I'd look at using regmap even though you only have a single bus. It provides
> > > a rich set of helpers and the caching functionality that will save a bunch
> > > of bus traffic.
> > 
> > Ah... is that a strong preference in new drivers? That would be quite
> > a bit of rewrite work...
> 
> Yes, usually drivers start being looked cleaner. On top you got a few benefits
> of regmap for free (cache, debugfs, tracing, maybe even more).

The types in the software is a result, but what is the cause? Do you have
ranges with a sign?

-- 
With Best Regards,
Andy Shevchenko


