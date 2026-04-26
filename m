Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E5131E49;
	Sun, 26 Apr 2026 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777182401; cv=none; b=cDOB4clBUIEy9eCsPc62BtTZBQksmj+F9zvxHNNjXLhyKpy1FKvOmbiIjGE/26oPKxOSrWHVrG4vzSqpDDX0xUwGZ8tD0WliUmYC7Ny9hGZbT9fShqJuCjuxY1HTFQVvzlC/sQU6DoY9Df6w8TUBgwgPYLZPl1uRx8xuHedRaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777182401; c=relaxed/simple;
	bh=u6vaGKZdOxeAmRLptS1nBMgfUDv507Juz66HEgeEj5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipWeui3JeC40CoBvNepaqFW38odOXg1093fZoTUt12DYahpWA4AhYTFZ1/oR8H56FDy3wAgPqz/bgsE1b++1I9h0cLrn1xuommqqf50SdXn1iMaJ0QqmHWzALIJG9hFAQ1hHERGDDghzB+PaodYQvdcBRJK0ocI07ldbsn/B+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXrZHSMP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXrZHSMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777182400; x=1808718400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u6vaGKZdOxeAmRLptS1nBMgfUDv507Juz66HEgeEj5g=;
  b=RXrZHSMPASs64Cw4lY/mXhYwcKJVYfyA+VBlgd4PMcbuF83BSDQpl/1c
   WLLoFdX43a1ESqpkRpOr+iKJ/yJcLiRGr+onvhDgPR8LRcOfT6IrJ+cnt
   7K8Q8q+kh/cMjThOZ0bZ2eBWPXYKaXyddo2TdG8thtM4br2fk37KE5JLS
   OnYFv0NtJar7OUPP3euqVoIRMzZ6fCk7v7Q3rdTZFe322aKV3FGKf+v0H
   1cn57zaIJ0G1Tl48gEBLb+mmlEyEnGHILu4VgrQKjzdR6E5chjJKzJtYF
   RJW9BMncKHQsOVTtkKg3dgxRte5k7v46P2St4YT7Qhp/flJGqscMT9Q91
   A==;
X-CSE-ConnectionGUID: uDJmuFgAQkSCpiCGajWhSQ==
X-CSE-MsgGUID: nSBgOptORD6sAPFkI4bSKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11767"; a="78218382"
X-IronPort-AV: E=Sophos;i="6.23,199,1770624000"; 
   d="scan'208";a="78218382"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2026 22:46:39 -0700
X-CSE-ConnectionGUID: 7TtvjtydSaKyKulH7CfW+g==
X-CSE-MsgGUID: TEwbvmH7S6+Z0mvH8QmOjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,199,1770624000"; 
   d="scan'208";a="232339433"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.227])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2026 22:46:37 -0700
Date: Sun, 26 Apr 2026 08:46:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: accel: mma8452: Use dev_err_probe()
Message-ID: <ae2mus8lO0TO80Cb@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
 <20260422165643.2148195-5-sanjayembedded@gmail.com>
 <aekjfPR7JksBESxX@ashevche-desk.local>
 <20260424181919.62e2e6bd@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424181919.62e2e6bd@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 06:19:19PM +0100, Jonathan Cameron wrote:
> On Wed, 22 Apr 2026 22:37:32 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Apr 22, 2026 at 10:26:41PM +0530, Sanjay Chitroda wrote:

...

> > >  	ret = regulator_enable(data->vddio_reg);
> > >  	if (ret) {
> > > -		dev_err(dev, "failed to enable VDDIO regulator!\n");
> > > +		dev_err_probe(dev, ret, "failed to enable VDDIO regulator!\n");
> > >  		goto disable_regulator_vdd;  
> > 
> > Before doing these patches, please fix the mess with the devm/non-devm ordering.
> > There shouldn't be goto after any devm calls.
> > 
> I briefly wondered what you meant here.  Key is you are referring to
> devm_request_threaded_irq() much further down.

Yes, that one.

> Absolutely agree that's wrong.  Rule is devm until you stop doing devm and
> then no more devm.
> 
> Here it looks like we can take the whole thing devm but it will need
> some custom callbacks and we may run into corner cases with runtime_pm()
> messing with the supplies and devm cleanup doing so (that applies even
> without devm being involved)

> > >  	}  

-- 
With Best Regards,
Andy Shevchenko


