Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789813;
	b=tBsunS0WmTnV1ePF8uwatkkg3L69C03qV2CMqKiT7kN/2p4VReqSBRg4BJnNooNBbqUa
	 jC3YOz9bKh5RnPZQvFNd5Kt5yA6QW2ZY8PKUEmoewmfulEdXpj2eOE4s553WIHmaBcaNv
	 qglUJokNlic8D+kVVHccFR9TM87GsleF/xnBC8tPtYt0qTxKDrBNzK/vRH+ENKagoQnwj
	 I4LR0ejZ4haWNnuQkWos4WjzOtgWuMaAY2Y21Vec7Idi3XelFtToScozprOWJVHauLXID
	 FWlEOv8QO6eyCsEGINwPZ79Zy0xx/q39W3i5CMjDkaDT3jGJahwhQk6z8LJ03g72+fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789813;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6X8o6iEFFcnsdHbRylyuLRGu+Wz62mnb9O0cwqf8yFk=;
	b=EB3GH8i5QX51HQ5TOal1x5KKdN4YIlviPBPH+UEISN1NRaK9DUJY+lUfU0q5jlXWngF6
	 osnxMN6+ISl+qSYB1UwF3ezHjfEhCbG9IwRibBcm9qhXVHN3eGaxnmaJwJOOmUNmdCeqf
	 i8MZzbc913wuPJEnr3NOPHWQhDW1VpMC5ITQXgOw5MTO/QcCbFMltJdZth8QgWftqg92I
	 8gyW5cmzk/dij/8izUruW8x3Jqyste9I3Pr4h7BgciiulhbOVKaRGnweg6em6EJlckmAP
	 4wSoqMuBpwtgm3QEJ0Tpiuw1FoLhJJ9H3sb5TmeDwodk+lEAKWG0dpZfoUJQgsdkcPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QS+eyF1U;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C8606A31B;
	Wed,  4 Nov 2026 10:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 157C8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QS+eyF1U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793789812; x=1825325812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GXFt87iQcoBIPFau0Ln10BxVNADSYEjW1p+3DmS/GUA=;
  b=QS+eyF1UMTJub48nUl+RUL2ofTwc5F7di4V2s4B/fwIpwUUJb3qvoFaO
   ObZ6JvQlUgKEmsCWm2X/xFxdvmevRt1KRhMA8NKq8FquFsG+RvDIYJWWl
   B3h5uZJImkbC1JfZwgzkTGWgYlV+m+1BV0mBDWshrVZCh6xDC6xF9Y+mB
   IS4KS6vgjEvn/hQbEEICyoGwCFTNl7CMhR5VtPaucZbN1X/r54SXUrDlZ
   4WEhym+Wt7Xs+8KXolxpneFJ9HJp4ekJsq/TmabrEvA0mk1ZhiZ9L1Du1
   UTvS+u60ulztL8kGF54Hnp7TWGExkw6Pka5lzrKkhx+c+rPZxOWCjCsuL
   g==;
X-CSE-ConnectionGUID: oS+8Rz0YTMi01ZBnHcaE3Q==
X-CSE-MsgGUID: NAZYygLKT4m7xR0WTtuCjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2570503"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2570503"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:56:51 -0800
X-CSE-ConnectionGUID: LsAw7edvR6OqXGBMxL3/MQ==
X-CSE-MsgGUID: Gv1t+y+nTeqd3rz11tQYGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6695247"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:56:49 -0800
Date: Wed, 4 Nov 2026 12:56:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 2/7] lib: kstrtox: round to nearest, ties to even in
 kstrto[u]dec64()
Message-ID: <ausPb3rf9X4FNHtI@ashevche-desk.local>
References: <20261102-e-notation-v5-0-d399e544a982@analog.com>
 <20261102-e-notation-v5-2-d399e544a982@analog.com>
 <auof_hMbsbFq3MYj@ashevche-desk.local>
 <7qc3geup2edufde3wbx5wsyhjz6tcnekoa4c4alxudqb7buvmf@lijbrfhachls>
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
In-Reply-To: <7qc3geup2edufde3wbx5wsyhjz6tcnekoa4c4alxudqb7buvmf@lijbrfhachls>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 06:04:38AM -0300, Rodrigo Alencar wrote:
> On 03/11/26 19:55, Andy Shevchenko wrote:
> > On Mon, Nov 02, 2026 at 07:41:00AM -0300, Rodrigo Alencar via B4 Relay wrote:
> > 
> > > kstrtoudec64() and kstrtodec64() drop the digits beyond the requested
> > > scale, which truncates the result toward zero. The error is up to one
> > > unit in the last place and is always in the same direction.
> > > 
> > > This is easy to hit with values produced by userspace floating point
> > > formatting. Printing 0.3 with "%.17g" gives "0.29999999999999999",
> > > which is parsed as 299999 with a scale of 6 instead of 300000. With E
> > > notation a negative exponent can also drop integer digits, so "19e-1"
> > > with a scale of 0 gives 1 instead of 2.
> > 
> > To avoid unneeded brain work it would be nice to add an example for negative
> > input, like -19e-01. And I hope (and it seems the case) we have test cases
> > for that.
> 
> We do have the tests:
> 
> 	/* E notation: negative exponent rounds integer digits */
> 	{"-27e-4",		3,	-3LL},
> 	{"-125e-1",		0,	-12LL},
> 	{"-135e-1",		0,	-14LL},

Thanks! What I meant is to elaborate in the commit message, that the reader can
easily understand how it works for either of the sign of a value.

> > > Round the result to nearest instead, with ties to even. This is the
> > > IEEE 754 default rounding mode, as used by strtod() and printf(), and it
> > > does not bias results in either direction. The first discarded digit is
> > > known from where parsing stopped, so no extra pass over the string is
> > > needed: the remaining digits are only checked when the first discarded
> > > digit is a 5. Since round-half-even is symmetric, kstrtodec64() keeps
> > > rounding the magnitude and negates it.
> > > 
> > > Inputs that fit within the scale are parsed exactly as before. An input
> > > that rounds up past the type limit, such as "18446744073.7095516155"
> > > with a scale of 9, now returns -ERANGE.
> > > 
> > > Update the existing truncation test cases and add cases for ties and
> > > for rounding at the type limits.

-- 
With Best Regards,
Andy Shevchenko


