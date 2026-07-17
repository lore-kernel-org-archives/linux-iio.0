Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28723A0B2E;
	Fri, 17 Jul 2026 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284141; cv=none; b=UwV7xP+9SJRJg5TOXr76o9kThuVWAweliB6VpFZ6qVDkv9KfCexvAin/Z6ZHMYzOhB3QAL4sHDujpykj3njjseXT2vjpUysiXmDkkHBI5rN5+NwkXyg+jR/zi34a43l25Z32AIYeHtC2D+TZdBVXMb6fhU6fo2/JdJwz445ek04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284141; c=relaxed/simple;
	bh=Cd/VtuFBCKSyAi98W3gkxJkPrKArDgXzdstC5RR4eq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfMhydSXMvfbPypVTDygKszsvYp55WCAE6LRx09TJ8pB4iqdIGxP942xdNU7HJa6URNXZwS37KtWfDcIcd18WGPq8b7QTWCQoId1/cFtNVN5+7DHuB2tHhu9Y8S/Rxr92N4BgtnPkkvN1pznndO+7KS8HpZMoIr/TfvQ67UWHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jknpeIEk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jknpeIEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784284140; x=1815820140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cd/VtuFBCKSyAi98W3gkxJkPrKArDgXzdstC5RR4eq4=;
  b=jknpeIEkxL4LdnYGnvJegPHxQEKWxC0ZAEk08CFYNLRRaqbH/x2YP2bs
   i26y4NZn6n9d8VXCle/khWdSqq7WPHj0k1qom/Pp+X1uW6vb5RFOAM9LC
   ypaEB7nlTANvkijsr+xbaAd0VyxndqeXBo7JnzgHls7ZuA4gPmiIXNYQt
   UIRGzLaDBiS6EJGKT8cYgJZ7EqEjIbqtkqVTKCFi9AjA1Ln/JWe3Q/iED
   1+WY8pokiaiTO13r+Gzod6kDisWe/Kp4W0KgEy0BReI8H9ifBJOS6Q7wU
   35pl13B2kYYI3faUgdhuFDTlXffWjd4+1D25WtqNJvFIbZhtOmKHGPdSr
   g==;
X-CSE-ConnectionGUID: H+4QslTGTMOILzC62DhkbA==
X-CSE-MsgGUID: c2RIYpYkQquA2eRtpZixaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="88854118"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="88854118"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 03:28:59 -0700
X-CSE-ConnectionGUID: ARFOpTYCTAyMwKD86DZEdg==
X-CSE-MsgGUID: y2rwKgaDSwyOJBhdQDRtEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261036964"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 03:28:55 -0700
Date: Fri, 17 Jul 2026 13:28:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match data
Message-ID: <aloD5HdbntKu--xC@ashevche-desk.local>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
 <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
 <alkmAcDvSXr_COc_@ashevche-desk.local>
 <ondynh4kmchzugk2l24klamrcaje3qxnhgiks7gnc46wwwvo35@hysk2zaimb2e>
 <alnknz55FbyyqqlL@ashevche-desk.local>
 <gy2dn5emz7sreavy6kioz27f3sx2ip6zhkgzs2uz4qzecpkrbe@zgsortof6aqn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gy2dn5emz7sreavy6kioz27f3sx2ip6zhkgzs2uz4qzecpkrbe@zgsortof6aqn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 10:31:26AM +0100, Rodrigo Alencar wrote:
> On 17/07/26 11:15, Andy Shevchenko wrote:
> > On Fri, Jul 17, 2026 at 07:51:35AM +0100, Rodrigo Alencar wrote:
> > > On 16/07/26 21:42, Andy Shevchenko wrote:
> > > > On Thu, Jul 16, 2026 at 01:14:18PM +0100, Rodrigo Alencar via B4 Relay wrote:

...

> > > > >  	struct iio_dev *indio_dev;
> > > > >  	int ret, i;
> > > > 
> > > > Move an assignment here as well.
> > > > 
> > > > 	chip_info = ...
> > > 
> > > assignment? this is an input param validation
> > 
> > Can we make sure we always get a correct one to begin with?
> > With that an assignment and check can be coupled together.
> > Also consider use -ENODATA as it's most likely comes from
> > driver_data.
> 
> I suppose you are suggesting to move the check to the bus code with:
> 
> 	info = i2c_get_match_data(i2c);
> 	if (!info)
> 		return -ENODATA;
> 
> rather than here in the core/common code.

Yes! This avoids layering violation and makes the API contract cleaner.

> > > > > +	if (!chip_info)
> > > > > +		return -ENODEV;

-- 
With Best Regards,
Andy Shevchenko


