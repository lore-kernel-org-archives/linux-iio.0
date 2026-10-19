Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91CC403B1E;
	Mon, 19 Oct 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399817; cv=none; b=sRMoiY155AU/SS/n64zD8jAcZk6WGn1522uMlfeuhmuPcUP/5fIkGgoRr6zzjnKN2TUou3oWNEKApc0s9+hzheqUvkIzbgMVT92/wvwegkASKURFiiNOejqDDn5LPyp9pORVF2xTFQCfB0UT1fuxUqzOW8j9ogJbLQRGk9ZBvFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399817; c=relaxed/simple;
	bh=0y39RKJg9wRPWVS7IBh4yczKd99HKBlPQSVpmMN2wLI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHlwhtpn/6htg2WxI4fh5/2WqevdHK4DERkboJsvu5OmWUvOLsQ0eyM/CtHwD2JadasKqPNZY8abuGwcGJqPUzFbb4Yc9WdztOukRvs6VO2pUWfeZh/mBEJwb7FMERMqiCpGEp1uGlZjFp1rBfojU9CDxpNlxR8OvaBBpapCKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWavpKey; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWavpKey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399816; x=1823935816;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=0y39RKJg9wRPWVS7IBh4yczKd99HKBlPQSVpmMN2wLI=;
  b=RWavpKeyfuZHC7TZCU4CHAEocd7VoCR5jdpMSsai5T7b+LZ1+ifSqiUn
   v4koGvaFUDEVwa7Xovi/fNeUGLbTaEnCsxnGBlZcfN0A4mLVzdKMEQiFW
   mvx7C+wI/odGZq+Mejkk2LJGrNnZYYhz7CLM3m6VTPZNviyBkajzlBlNe
   OhiDISlOWj1cINvv6t6h1hhOiexU8NfMa6MYndYYU2qD4pWGwgcOmNiwF
   br3xY0LZ2X1p0gKE32Obzgyxk+Qbu6aYgVcIMwAuLEsGVlbu2mSMF23nZ
   zjgDeeQmhHsEiR83UvtEzfxqQ8sgkrfEy9v57ljbgpwhAN57mpu6yirOC
   Q==;
X-CSE-ConnectionGUID: YSeKMQVeR2Krhq2vdKfKMA==
X-CSE-MsgGUID: j0eHuf0ZTfePvWvdhUDJKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1183342"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1183342"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:50:15 -0700
X-CSE-ConnectionGUID: 02o1WNSmTsOGWc/6NoIJDA==
X-CSE-MsgGUID: pphS7pB1SdWCIJVimDhaew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2430897"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:50:13 -0700
Date: Mon, 19 Oct 2026 11:50:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH v2 0/4] iio: light: tsl2591: fix lux calculation and
 precision, add I2C ID table, report saturation
Message-ID: <atXZwm5DzCK8S0_K@ashevche-desk.local>
References: <20261014141650.259929-1-ciakval@gmail.com>
 <atEdM6wi_FAGFjrr@ashevche-desk.local>
 <20261017031411.05dee323@jic23-hlaptop>
 <atXSBHbOPYYltHUW@mm-ntb-00805>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atXSBHbOPYYltHUW@mm-ntb-00805>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 10:17:08AM +0200, Jan Remes wrote:
> On Sat, 17 Oct 2026 03:14:11 +0100, Jonathan Cameron wrote:
> > On Thu, 15 Oct 2026 21:36:35 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >
> > > From my view (haven't checked the calculations, though) this looks good,
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > >
> > I'm guessing not huge urgency on patch 1, so to keep things simple I've
> > applied the lot to the testing branch of iio.git. That will get rebased
> > on rc1 once available in a couple of weeks.
> >
> > If you want the fix to go in faster, shout and I'll do that at risk
> > of slowing down the rest.
> >
> FWIW, I don't think it to be very urgent, as people probably don't use
> it on x86-64 (seeing both as it had only DT probe support and that
> impacted users are likely to have noticed the oops).

What do you mean by the second part of the sentence? It's as easy to use on
ACPI platforms as on DT, we have so nice trick called PRP0001, which allows to
enumerate "OF-only" drivers on ACPI platforms via SSDT overlays (or other means
of DSDT/SSDT provisioning).

> And on Arm, the net result is getting false illumination reading of 0.0,
> which isn't great, but isn't terrible either.

-- 
With Best Regards,
Andy Shevchenko


