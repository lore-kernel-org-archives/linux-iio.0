Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD32D47F4;
	Sat, 14 Feb 2026 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093871; cv=none; b=ftD2h/+raphJOcPT1/ocDN9QsE0zZE7zo3PBzQE+73PyrASIHnKdwMZsi4enVHjQ/f3qSv4X8/n+Vdv7umIIH9N3lR9BcBGZjAkhHShNTYvIj0VhT6uGecaHO4rzUoultLdf5arqfo7b9VgaotLx46L32ozxSlC3rrYQbE0mrbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093871; c=relaxed/simple;
	bh=yzm3ai97SgwFktRFZQ+h0tpIzz3c+Zmid+Neym99VOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjf+dATtRujaMhkmux5pwPNIObhv8HnJFfk/qhwWeMA4znrVGrBv0h/wSH79RgCBxFkGriLwFVN+7OnyQbBxZl7H6S8B789vfTx+otIreK6lBgVu25bNXf1ASWJZFYHuT9yf+8/KyTs5EHrxThsXyTiafyGeRvIJxw0nrIKDmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdkEdB84; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdkEdB84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771093870; x=1802629870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yzm3ai97SgwFktRFZQ+h0tpIzz3c+Zmid+Neym99VOY=;
  b=cdkEdB84R8bVaMWRioLPRVhsdG0DZGt8cGNV3g9XbhSC4AUq642IOG3F
   YANBddjglVC7k32JEPB+JVHbgn374EJ7ypNDO0xY+1fwH7FME3T7kj83B
   cKlaBM+x+lNGvBVD/h00NUD3px/YKdzTEaz2OEiz1T+CTR3FeT1rGIo3E
   DvM0XH1hy7mxQ0hTiErGBDxbbi/0fXl3zW1aD/pU8X/h+8CLdsifrE9OQ
   6Jwm74asJa2N6vQFkoikQ92txYfevzFnhZHRn594myNWS/6H2rtoUyew4
   QBgRLadGMVdoqllseZMgM2ujzcyWcsG29IcUQVPgDWYgEVjx/9hld2nk8
   g==;
X-CSE-ConnectionGUID: kaa4L91xQla9/en2OBVoPQ==
X-CSE-MsgGUID: G001VPVfTzi9ksgRTuE3Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="83611078"
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="83611078"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:31:09 -0800
X-CSE-ConnectionGUID: Hs/TplpCQq+CXLBg3LpggA==
X-CSE-MsgGUID: rRyIqCVNQ0+QTFzo0sAQdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="250880277"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.136])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:31:07 -0800
Date: Sat, 14 Feb 2026 20:31:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: max5522: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <aZC_ab454PTqFPsO@smile.fi.intel.com>
References: <20260210175137.44178-1-antoniu.miclaus@analog.com>
 <aYuIftCDo5O0IF9F@smile.fi.intel.com>
 <20260214182052.14c6f8ee@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214182052.14c6f8ee@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 06:20:52PM +0000, Jonathan Cameron wrote:
> On Tue, 10 Feb 2026 21:35:26 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Feb 10, 2026 at 07:51:27PM +0200, Antoniu Miclaus wrote:

...

> > > +	state->vref_mv = ret / 1000;  
> > 
> > "1000" --> "(MICRO / MILLI)" ?
> > (yes, this way with the parentheses).
> 
> I know I've argued against proliferation of the X_PER_Y macros
> but this one does seem to be very common. Maybe it's time to bring in
> 
> MICROVOLTS_PER_MILLIVOLT even if it's longer than the open coded version?
> 
> Andy, what do you think?  I do worry that people will see it as fine
> to add many many others if we start with this one though. So maybe not.

IIRC (sorry, if I am wrong) it was you who objected in the first place
and I proposed that from day 1 discussing the "(MICRO / MILLI)" approach
a year (?) or so ago. Answering to the Q: I am in favour of having that
definition.

> Anyhow, doesn't need to be in this series.

True.

-- 
With Best Regards,
Andy Shevchenko


