Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46942EEB4;
	Tue, 20 Jan 2026 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916339; cv=none; b=jqs31Sp+YqYBGjq7orOJlHVuzP+BQGjUB+KaGoMUFjlJeaR/jkQwyhd+5Ka8TPJQntB1ljz/qMhtHyUbd7y/I8OiXylq0halShXWjl2mcFcSN3TgGs/KqbkJ/SVGfy0lfGhSTVOS5ZTJFcMIG7OoAt9Ss8ljz8yiNiy+ijmqvZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916339; c=relaxed/simple;
	bh=qC6gcyxP5iZxSOjmlhJmhYzV5a8Gk31qQnhXH+ickNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARBmGsSScuY5ikAtDqlCRIHD7BNEBdiszFEgrQYUryk64kdl7Eo64AZ7ImKuzqPw+aEVKvx5PD+f19PrWdJbieLPlUgIiTJQzXGCfAn6opR/7FYmQzga29tWb/sbXHrZYDmuobgZBgJ4byHICjNzJiNYSJaVaVQcYJKDpPIcQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOVqSe/M; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOVqSe/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768916338; x=1800452338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qC6gcyxP5iZxSOjmlhJmhYzV5a8Gk31qQnhXH+ickNs=;
  b=gOVqSe/Mo3tIbDIow9k6uqsguup3MeyBv4AR3kfusQ/eo2zHnjUmLPNt
   WTX3MJEKqP9zjjaCraSKFwYsFCKoPSK6gcnaCTbq+f7Eou4tY38QCHnGl
   b1RbnCPDnILlTvaS8SBFdCrz683Yqa4nQ3rIHvKnjVJkSBBs7Bs3d5y6x
   MCyuEtqKCUpUASaGoCobSjlGivuNM8fGMNrqXiNHXwgVEBrMADm457szM
   /xVhWPg3tNY1PLKBxWMNl/PX8k/VUZPUVBRok0F1iafUpdTHPH5CMbarF
   N1T6Hb2jlSKHNNhsdSNPjz7ZNZk4ehH56sbPxhpgfU3GhDOwxbQ0ONUw/
   Q==;
X-CSE-ConnectionGUID: jI0Y7zfVTJWfas6YrzhZEQ==
X-CSE-MsgGUID: cN0u5ITsQRWNy61s7tQAUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81495339"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81495339"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:38:57 -0800
X-CSE-ConnectionGUID: ox7eLJ2rTp224DpAWErhfQ==
X-CSE-MsgGUID: CtISb7XES8CO3g4/6cKeFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210273207"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:38:52 -0800
Date: Tue, 20 Jan 2026 15:38:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, rodrigo.alencar@analog.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/7] iio: frequency: adf41513: driver implementation
Message-ID: <aW-Fai68pk1tAeyY@smile.fi.intel.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
 <20260116-adf41513-iio-driver-v4-3-dbb7d6782217@analog.com>
 <aW3dxuelYDM67pqZ@smile.fi.intel.com>
 <texwv5s2tvcy34bwr4iruj5xofmea663pwletmpqpuh66zulmv@m7qvjgqbhalv>
 <aW40ylvMwVhqNQMw@smile.fi.intel.com>
 <hgy3bcrqqsvt7pobhnzuvwzhb2taetpxltkaxpigmmlvmlirod@v6anhmrsvv2r>
 <aW5kk6K30Izckvg5@smile.fi.intel.com>
 <e5lcg5kkey3c6u2l4rlzzpolp7qkudhcofyzcx5s2tjbh2iwkg@js3fisv23zyj>
 <CAHp75VepcSZo_E4_UxhKRfHrMFDd7huJg14m8=6zVo4ENKFXkA@mail.gmail.com>
 <vvdk3whhwua73g63eetnmn46t2cpbpkzzkx7m6wsbverp7gcvs@mi7cipis3i4t>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vvdk3whhwua73g63eetnmn46t2cpbpkzzkx7m6wsbverp7gcvs@mi7cipis3i4t>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 01:07:49PM +0000, Rodrigo Alencar wrote:
> On 26/01/20 01:24PM, Andy Shevchenko wrote:
> > On Tue, Jan 20, 2026 at 12:43 PM Rodrigo Alencar
> > <455.rodrigo.alencar@gmail.com> wrote:
> > > On 26/01/19 07:07PM, Andy Shevchenko wrote:
> > > > On Mon, Jan 19, 2026 at 04:37:09PM +0000, Rodrigo Alencar wrote:
> > > > > On 26/01/19 03:42PM, Andy Shevchenko wrote:
> > > > > > On Mon, Jan 19, 2026 at 11:21:59AM +0000, Rodrigo Alencar wrote:
> > > > > > > On 26/01/19 09:31AM, Andy Shevchenko wrote:
> > > > > > > > On Fri, Jan 16, 2026 at 02:32:22PM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > > > > > The current implementation is kind of a stripped version of
> > > > > > > __iio_str_to_fixpoint(). Would you prefer something like this, then?:
> > > > > >
> > > > > > Do they have most of the parts in common? If so, why can't we use
> > > > > > __iio_str_to_fixpoint() directly? Or why can't we slightly refactor
> > > > > > that to give us the results we need here?
> > > > >
> > > > > __iio_str_to_fixpoint() only parses "int" chunks, adf41513_parse_uhz
> > > > > was modified to accomodate the u64 parsing removing unnecessary stuff.
> > > >
> > > > But why? The fractional part most likely will be kept int (it's up to 10⁻⁹).
> > > > The integer can be bigger than 10⁹?
> > >
> > > Correct, integer part of the frequency value goes up to 26.5 GHz
> > > (uint_max is approx 4.3 GHz). Also, with the dual modulus, the PLL can
> > > achieve micro Hz resolution.
> > 
> > µHz is not a problem since it's up to nHz.
> > So, the difference so far is the integer part that can be 64-bit.
> > Again, can we factor out something to be used for this and for the
> > __iio_str_to_fixpoint() cases?
> 
> I am not sure what you are suggesting,

To make changes to reuse the code.

> but I am avoiding changes to iio core at this point.

Why?

> If any other user needs similar behavior,
> I'd say we would need to have __iio_str_to_fixpoint() implementation
> modified, so to create a version of iio_str_to_fixpoint() that handles
> long long variables. Possibly consuming simple_strtoull instead of
> doing the manual parsing.

That's the problem here. With Yet Another Cool Parser this all becomes
unmaintainable very soon (basically as you said when new comer needs a third
variant of it). This is not good. Instead better to create (amend, expand)
existing test cases, split out a foundation API that parses 64-bit parts
(maybe even for fractional as well, dunno) and evolve a needed (sub)API
from it.

-- 
With Best Regards,
Andy Shevchenko


