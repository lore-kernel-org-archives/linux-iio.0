Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76673563DD;
	Mon,  6 Apr 2026 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775503014; cv=none; b=fZt79escevFSapG+CxsOT83rHSo2VRCRQBtlaVeWziFofsdV3+nfD7Xc4K47ZL1MvPmWsUXjL8sq4j6S3RB4vXO287sF1Hsn70TXbN6kEhUek2pfEv7PfEdlavBZBqZ/Oz+VKkK/vByTrdlRqVPv0GtEANk6KJwcPFn57gNX9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775503014; c=relaxed/simple;
	bh=fRtZK14s4RtAHBuJCQCK+NbkdOScCwStGi/7YrfguDA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsSx6qWEG5BeB0z3DzRbBThzkjl1FYzDB2KJlWRznYnOSiqHcv3m8HPZdlMjPJ8kYmGsr3n22EzIEq5B9IX/wWtH+JAqSUIBGjGI+jvK3nauKXCgUmtNMlz+dujSBcE6Ra2SdUlZCXCESLSJ4FCWxI0HNvhmAJaZBVbBgLZCUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+tx58Xv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+tx58Xv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775503013; x=1807039013;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=fRtZK14s4RtAHBuJCQCK+NbkdOScCwStGi/7YrfguDA=;
  b=V+tx58XvgbjzuzEPP9FQrDxuBNNfcRmAu0Hvp5ZVlXyWkHioqDFpeggt
   Xyx5q2LRkEvgu9nYofpswWLkvgsexNgqiUwbzyfjxsnBMsiuyHP4kRngB
   VZ3MpodKnw7lc2v4l4EbDn3AE1jEvB3wWLZXpRUHHA+I0RB1qJeR/E40I
   TuWU0HUlBtlIyfRAezBz3WxctTCGP7hLW9c44p83FVsnmtQnN11aibD9h
   HWo+h4E4f8exx9KA21FDvlfDlGfVa0ltAxnMWMhKPjRueKG5R/yltLWa+
   HRDLD1p84j+jeEnToftiCh+QE0k69GVcMcpnHgH8aDb2gNOWXLE8rMr++
   Q==;
X-CSE-ConnectionGUID: t1SepqRLTWWAADoCSZDoKQ==
X-CSE-MsgGUID: QtyfokoPT/SY2Lnqw/WRtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="87913604"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="87913604"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 12:16:53 -0700
X-CSE-ConnectionGUID: YHbCbRsdR4S4ngxF+dm7hg==
X-CSE-MsgGUID: By4Ayw4yR5SJAZKVi4bwEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="223161877"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 12:16:49 -0700
Date: Mon, 6 Apr 2026 22:16:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] iio: imu: inv_mpu6050: control vdd supply using
 devm-helpers
Message-ID: <adQGn5cymv3Xz6So@ashevche-desk.local>
References: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
 <20260401082737.781018-3-andrej.skvortzov@gmail.com>
 <ac01WETv_jIcYvRL@ashevche-desk.local>
 <adNYWgzZFmoBW7cj@skv.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adNYWgzZFmoBW7cj@skv.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 06, 2026 at 09:53:14AM +0300, Andrey Skvortsov wrote:
> On 26-04-01 18:10, Andy Shevchenko wrote:
> > On Wed, Apr 01, 2026 at 11:27:36AM +0300, Andrey Skvortsov wrote:

...

> > > -static void inv_mpu_core_disable_regulator_action(void *_data)
> > > +static void inv_mpu_core_disable_regulator_vddio_action(void *_data)
> > 
> > You can rename now _data --> st...
> > 
> > >  {
> > >  	struct inv_mpu6050_state *st = _data;
> > 
> > ...and drop this.
> > 
> > >  	inv_mpu_core_disable_regulator_vddio(st);
> > >  }
> 
> thanks for the review.
> You are right, but this variable will be added in patch 3. Do you
> think it's still worth removing variable here and add it back in patch
> 3? If yes, I'll change it in v2.

Yes, we do not add a dead code. Add it when it's really being used.

-- 
With Best Regards,
Andy Shevchenko


