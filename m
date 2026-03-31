Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046F38E5D4;
	Tue, 31 Mar 2026 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982257; cv=none; b=mdl7CujTS8R+TQ79NZLJd61kzgnB+a6rDT32TEJNsjejD2QXAJY6T6N8DOf506KEcnbi1P7MGtO9NoZm6dN/6CG9MwJQrF8ajYZ0hdcaqulc0B4/EmrjImqX2YRUXxo4iAZrjLL9SkBMc3u82KJ1oeqPn/lo3LItDIILsxZ/WD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982257; c=relaxed/simple;
	bh=4nkwZOWLXDBhSAvMDiYt0C+LSDBc79ZirD/LbAm5D00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM6MYLDAjenRRgPY96HPpwf+bwpvsi5GDOauHKr/0mECQ0B3cLluhXXUzakEZVGT9Q94x1aLBF+fMT8+lkQWbUADGzvuXHKWA0qboo6e+t8L66uuxhuBTmUwKnjSl+pjGvxE+GKd+p0/2TQElaFqM0gW6FopslYau40IAIsVi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQ3jn9EJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQ3jn9EJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774982255; x=1806518255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4nkwZOWLXDBhSAvMDiYt0C+LSDBc79ZirD/LbAm5D00=;
  b=MQ3jn9EJGDU0RW2rryv2OyMFELMXvrUsgt1XuXFKRs33rjB0eZOukvsv
   WVLNwrh8Be730hPtrhPnNlqyf8kwD/JtdoV8p69aRqEKUtS8zvFq8WH4n
   bNWRWOneoUonAXZtxJajJiwOewPEQ25XP9ZSP6zSxBfQmP5ccaeEESQ0A
   pvNFm4IlAHbJt4wGczMS+kcMyDYslgUtCpPBjul6FvV4LBPVc4yJlKhMM
   kBTNnCVDm96ebO8ZEzkmaXpzR/qxNI7m0Gf5w3w9Rp5cJGIPL5NIQwrlG
   AwS7CMEf664WQaDosmtRCO6YG+h/ahK7BmbWbpTYYrDSUm4mMyxVY1jJk
   g==;
X-CSE-ConnectionGUID: CgXm3ZkuRl+aqkWXbIQ0CQ==
X-CSE-MsgGUID: 2Qi2T3zTRZikgdGXyoA3YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="93588866"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="93588866"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 11:37:34 -0700
X-CSE-ConnectionGUID: guomIn0/SUODnU4qBpUflg==
X-CSE-MsgGUID: BJTp+qNeRTa6LiVip/TlLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="223567384"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 11:37:31 -0700
Date: Tue, 31 Mar 2026 21:37:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: Avoid risky abs() usage in
 iio_multiply_value()
Message-ID: <acwUaHWRqscMLPJN@ashevche-desk.local>
References: <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
 <acuT8oTnaYujC0k6@ashevche-desk.local>
 <acudGrFiD7TcAs3S@ashevche-desk.local>
 <12864533.O9o76ZdvQC@fw-rgant>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12864533.O9o76ZdvQC@fw-rgant>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 02:13:29PM +0200, Romain Gantois wrote:
> On Tuesday, 31 March 2026 12:08:26 CEST Andy Shevchenko wrote:
> > On Tue, Mar 31, 2026 at 12:29:22PM +0300, Andy Shevchenko wrote:
> > > On Tue, Mar 31, 2026 at 10:49:59AM +0200, Romain Gantois wrote:

...

> > > > -		*result = multiplier * abs(val);
> > > > -		*result += div_s64(multiplier * abs(val2), denominator);
> > > > +		*result = multiplier * abs((s64)val);
> > > > +		*result += div_s64(multiplier * abs((s64)val2), denominator);
> > > 
> > > Right, but here we get val and val2 from either static values from the
> > > driver (when it is SCALE channel), or when channel has PROCESSED support.
> > > In the latter one it might theoretically be possible to go till the
> > > INT_MIN, but practically I don't know how, except for the broken driver
> > > code in the first place. With that being said, I think it's better to
> > > validate somewhere the multipliers (when it's SCALE or PROCESSED
> > > channel). I also noted that for the _PROCESSED some drivers keep a
> > > garbage in val2. That probably needs to be addressed as well (exempli
> > > gratia: bmi270_read_raw() does that).
> > 
> > Actually the data in the val and val2 should be aligned with the returned
> > type, hence the potential bugs might only come from the untested drivers.
> > Which means that this patch doesn't improve the situation.
> 
> I'm a bit confused: when you say "the returned type" what returning function 
> are you referring to?

_read_channel(). It returns the type of the value in IIO namespace.

> Also, doesn't the patch still fix the bug for potentially 
> untested drivers which use PROCESSED?

No it doesn't. It just makes it different, but not necessary working.


-- 
With Best Regards,
Andy Shevchenko


