Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D581FDA61;
	Wed, 14 Oct 2026 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974338; cv=none; b=SXkWPCiCTVhBzBKdBEh4i8DLX2J2RsUzthj7/o5xAgKJxv9E7zgR0QcWbpZsZwKsi/Amj+LUTb6JGiqnAIMqkC32KIntNBwbXbzzDZm6v9y03C7kdEeeS8PBj07CQ6m3fzcq9EZJ/nScWy9g4RForFqUWmRuLIwQUUPSDY3kzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974338; c=relaxed/simple;
	bh=Vg2PxUQ8bGcoL3oeVt9mjPu5Gp2Bd6S6AuX8Qp1dhCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtFgcEFpuKqIWG3fZ/rPT85ZgpVpGPmHAbCmBcgP/+Uy3sI5iP7flcXhOq1PT/HEsIirj1IyKrRM28I/cvTnh3J+Giv6tGpfW1kXRMsvtVfhXRSZSuhgSfKgI7aYeqUZ9WrBDHvVawmrFtQ8+/qlazIyKAtUUbYuT7jmB7tVdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJaRTNQt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJaRTNQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791974337; x=1823510337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vg2PxUQ8bGcoL3oeVt9mjPu5Gp2Bd6S6AuX8Qp1dhCM=;
  b=lJaRTNQtTaNsujk3DMZMeuFmbpvOrwWu3HZGpFw7Gtqfkgu3aiIYDIOI
   +T4vZFSV+3dr963n1f1L1o7HJA3jz9i3zh3m0IvoMPE+36LoCZinhR8le
   /GLD2vzW38L88EDoilSo809IYCL+jl9ij/ovxh9ZX+/XsnbZjCSkbsTer
   6MW1ofkfJR4daAbvFR/9BJobeCXemj6RK6frgm1d3RMVfBylkXgFMOREF
   dPMZ0P+MIJ/RLt8jVKZ87JUsQYi5WGe8AZfcyhPwl+1zmZ7C4V6mquF85
   nzhSjG3ZorYtTsFuMEk/NSSi4o8tsQgloDNtyIiEfE2zOEOp7IhPfjDwC
   g==;
X-CSE-ConnectionGUID: sCFjVO6eRu+XHD23CaWKDA==
X-CSE-MsgGUID: SRF1hchQQWujKu4/1Y+pMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="618829"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="618829"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:38:55 -0700
X-CSE-ConnectionGUID: mVhHvavDQUWiKKT3r6iSSQ==
X-CSE-MsgGUID: n1UQME/0TDuENCinSMORpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="3161230"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:38:52 -0700
Date: Wed, 14 Oct 2026 13:38:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <as9bueoY_elkSPdB@ashevche-desk.local>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
 <20261013115639.167433-3-marcus.yu.56@gmail.com>
 <as5b_jzx5CG_UoZS@ashevche-desk.local>
 <as70Y0biw0XMjwL6@zephyrus-g14.localdomain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as70Y0biw0XMjwL6@zephyrus-g14.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 14, 2026 at 11:17:55AM +0800, Chang Yu wrote:
> On Tue, Oct 13, 2026 at 07:27:42PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 13, 2026 at 07:56:39PM +0800, Chang Yu wrote:

...

> > > +/*
> > > + * Integration time is calculated as (ATIME + 1) * ((ASTEP + 1) * 2.78us).
> > > + * ATIME must be between 0 and 255, inclusive
> > > + * ASTEP must be between 0 and 65534, inclusive
> > 
> > Haven't noticed before, but is it indeed 65534 and not 65535 here (or 255 and
> > not 254 above)? Haven't checked datasheet, please double check.
> > 
> Per the datasheet 0 <= ASTEP <= 65534 (65535 was explicitly marked as "do not
> use"), and since ASTEP = n - 1, we have 1 <= n <= 65535. Similary
> 0 <= ATIME <= 255, ATIME = step - 1, so 1 <= step <= 256.
> 
> So I think the numbers here are correct.

Thanks for checking! In case you need a new version, just add that into the
above comment, like

 * Per datasheet, do not use 65535 for ASTEP.

-- 
With Best Regards,
Andy Shevchenko


