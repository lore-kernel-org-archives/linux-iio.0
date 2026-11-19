Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083429;
	b=NFp6KGbBsVyuNKyiqAvD3Z3EBAWP/Jp+GU2oEh9EXL2qwCggDzRKZORGWCi3Jtw5eaQK
	 bVJGJ1SMaQomCeQQejK93hE9UE12QguZdImODSFnmenRkQ8vEx/ngdW1voxYsgPKB9X4R
	 01p0FSClWlmb/ufPXSf9OMUktFtXzxqmymGbiQDq1HRZtjanpsxz0VN5/0Qzjvg2RWe5O
	 J0GVJ3Iu42TZeKd1w0Jpp6SWZzU60hLYtN5iCQfF5R/4gZIUQC2lqDUjcCCZQ2YX6DocE
	 hT/575bxgAaOOBv6xolwL8C7S5a/GWZbaz0rNuSgsKxvAncqS/Rue0kTjgC0ZHlYmyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083429;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=6CudCDFEzBuYkIYRn7R857Mxi/zBeCHzdGpY6yNojK0=;
	b=fOWaCdPvOXaC9QMwX/RICsnDVWdEhWfhbf//DwG/W8YoCSnhv6VKrJfxaHw9PWJrpXwf
	 ovZsm/QJxZc/jf8zTxe6fevJ3TjErszsU2ilQ+5Xnugitr8dPRJFQUjyNJke1enWtyVc/
	 Qe3evwgIvkKke4CoydSB8xOkguYCTbrTisl7hwqr3pG0DGX3iJ+wnMsrNyaFO8qIuZAX7
	 Of/zzo8H0uqO0vX3fkxF05BKPoLnCAKTYz4tj3/cyCyY99DnH8c7K852BLyY0nz5+x5V9
	 OoFDi+qcKkYUpvOwItIMMyAzGL012wus0HEWlKDMYdxhYmaIcHwIHL8EepPAcSUlpwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fGC49KEP;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A7606A320;
	Thu, 19 Nov 2026 10:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D0A7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fGC49KEP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795083429; x=1826619429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/rU3oyGGODDYoR4QkB/LEIV0Iw5QHvOg7E5r2WJaQwY=;
  b=fGC49KEPMmwkNKIbgkN6hQa1vcDbDnoETDb7Vq66BxF7uAzGdKCfNMCi
   Y8cmIJMI4KteKJAPpQOUc9YAIu7qLIh23KGbLT9LeCiefSC/qeVB+TEyi
   2fHrFU+9wE5jZsMMYqv2tYDUf7YkosDkE1d5yUsRJI9NEQhOldVPE9l/I
   cqhi/TGH4dC62+mXDaRYCFBsRpavxLfa1OsBIrEUbP2lI1WuJPeu9tvCQ
   5ubGqiD3ivW1xKbBhzbIkbHeincy7oM+as0iEBoGk3d+7BuQyI4S95QgG
   D7UJiG+S5eh0+493sdIM4R1YkeA58/Ukdy2zXMZUbGwnt4VIYZU7gDnqp
   w==;
X-CSE-ConnectionGUID: 9cnzEhXyR4mIpIYCTzKWPg==
X-CSE-MsgGUID: ogbXtoaHSVeKHIcQ+2265A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3845759"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3845759"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:17:08 -0800
X-CSE-ConnectionGUID: QJmfJdBBT0+uRL20CzgI1g==
X-CSE-MsgGUID: aQ11iNKHSleNCCrS/JwhcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10774767"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:17:06 -0800
Date: Thu, 19 Nov 2026 12:17:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: proximity: sx9324: fix proximity threshold
 writes
Message-ID: <av7MoMqutd2-lftk@ashevche-desk.local>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
 <20261116205320.26070-3-kapoorarnav43@gmail.com>
 <avyj-lOGvj04A_Ak@ashevche-desk.local>
 <20261117191029.83901-1-kapoorarnav43@gmail.com>
 <av1NN8_Y_f3xtWRo@ashevche-desk.local>
 <20261118100605.34002-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118100605.34002-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 03:36:05PM +0530, Arnav Kapoor wrote:
> On Wed, Nov 18, 2026 at 09:01:11AM +0200, Andy Shevchenko wrote:
> > For the sake of the correctness the whole set of 64k has to be checked. And in
> > most cases the + 1 there will be wrong. The only correction we need is on the
> > edges of the full squares, id est when val == r² - 1.
> 
> I ran the v2 logic (reject val < 0, int_sqrt(2 * val + 1) for val > 1,
> reject results above 0xff) over every val from 0 to 65535. Values up to
> 32767 are accepted, and for each of them, apart from val == 0:
> 
> 	code = largest r such that r * r / 2 <= val
> 
> val == 0 stays at code 0, which reads back as 0 like code 1 does.
> 
> The + 1 only changes the result where you say the correction is needed.
> int_sqrt(2 * val + 1) differs from int_sqrt(2 * val) for 127 values of
> val, and those are exactly the ones with 2 * val == r² - 1 for an odd r
> (val = 4, 12, 24, ..., 32512). For every other val both give the same
> code, so the + 1 has no effect there.
> 
> The reason is that, in integer arithmetic:
> 
> 	r * r / 2 <= val  <=>  r * r < 2 * val + 2  <=>  r * r <= 2 * val + 1

Yes, for r > 1.

> > At bare minimum the commit message needs to be corrected and explained
> > these aspects that while the + 1 gives wrong result for most of the cases,
> > it's still okay to use as we work only in integer arithmetics. Also the formula
> > (r² - 1) / 2  has to be dropped as it's incorrect from mathematics point of
> > view. The floor() happens on / 2 and has nothing to do with (- 1) correction.
> 
> Agreed on dropping the formula. For v2 I plan to replace that part of
> the commit message with:
> 
>     read_thresh() reports code r as r * r / 2, and the division rounds
>     down for odd r. write_thresh() inverts that with int_sqrt(2 * val),
>     which is one code too low when 2 * val == r * r - 1, so writing back
>     the value read from an odd code lowers the code by one.
> 
>     Use int_sqrt(2 * val + 1), which gives the largest code whose
>     threshold does not exceed val: in integer arithmetic,
>     r * r / 2 <= val is the same as r * r <= 2 * val + 1. The result only
>     differs from int_sqrt(2 * val) on those edges.

s/code/value/g ?

> The same goes for 5/6. Does that cover what you had in mind?

Yes. This is much clearer, thanks!

-- 
With Best Regards,
Andy Shevchenko


