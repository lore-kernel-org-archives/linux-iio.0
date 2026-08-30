Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8F1E51E0;
	Sun, 30 Aug 2026 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788073972; cv=none; b=KS4i3MXmW1EuKB2W1UIrPclWS/yZRoACzFGGaboMqjOzXxdOaHuHXgKUUYufqtgRF5/zVw5gZV4dgtIID8lWvIVrZ4prtAKPlgutT5YxYe5pQo9XjaQlxjY3cCs9YRGohLeDCx9JW9Q180rkJwrplgudDQy2QaM5TefttNwEH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788073972; c=relaxed/simple;
	bh=iazp0KDG9XO8tNOtwqgDz8WtQg1nj0t2IAFOstoA9/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imnDZDI2wVDGegc1//0w6dwi2oUDIrgWtc54S21w5W3cAXeJJ0Cez6n5aSWLOZZnpTUQzmNac20Ju2cmRUAxIcG1/RAKgc78tmUeS3Kk0gPNpkk+N0z05Sln/buk3SrVfdljFdtPcCGDyEdwwLtEAFEJ2JFvRi3lmbpb/K3lDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNkYkutc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNkYkutc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788073969; x=1819609969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iazp0KDG9XO8tNOtwqgDz8WtQg1nj0t2IAFOstoA9/k=;
  b=ZNkYkutcT5Ppb/vmRYPAY43wadBKyCzBA0BL+1jFoou941l6jkqFI5fe
   b5syLEVT2eKqJW3OD/AKDZhAE0a0DE8hjPL55YySNY1ZkiZfkAZ42N/8v
   l+/b4wHTGF1A9cuQxeYNNUK/sZbT4cbxoJeC6JD/5v49HeGrODMUSyz5H
   goRBI2jx6LsmtmHmlWSg/bgKRYhxyhsXh55Lh3xC6C/qkYZavol9OoKrM
   Lzum2Tq+ofOEJUfuTLdt3i21JYgmUrvF2hSyRPqW5lHgkLNe5HjirzYea
   pZQmXkiLeZ8t7KZWZ3AmKQtP42Lm7PsmjA7SqIRLyAfCRvSpbBGU8dHgg
   g==;
X-CSE-ConnectionGUID: hi67F+nyTOe78bFGqoNR1w==
X-CSE-MsgGUID: QC/cj4nkRUC/ghDIpFajZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="92200426"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="92200426"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:12:49 -0700
X-CSE-ConnectionGUID: IxVKxOtaSNCL6aggQofF+A==
X-CSE-MsgGUID: 2Ag3hX7cRYC1ynJibEgjHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="262412193"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.243])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:12:44 -0700
Date: Sun, 30 Aug 2026 10:12:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v5 00/20] iio: adc: Add AD7768/AD7768-4 ADC driver support
Message-ID: <apPX6ZeomgPd4WPU@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260829191954.7a5f1875@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829191954.7a5f1875@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 29, 2026 at 07:19:54PM +0100, Jonathan Cameron wrote:
> > ---
> > base-commit: b75697ef53e435d894833dad2a8c2fa882cb9b19
> 
> Where is this commit?  I tried the various IIO trees, GPIO and linux-next.
> None of them seem to have it.  That means automated tooling is failing
> to apply this including sashiko (and I'm starting to use b4 review which
> has similar problems)  Please fix up and send a v6.

> Choices for base - and say in text which it is as well as the
> commit id.

Hmm... I usually find the text is redundant, especially in the case like this
where it may add ambiguity. If, say, text refers to vX.Y-rcZ and base can't
be found, this will rise even more questions (at least to me). Having the only
one source of info helps (in my opinion). And in the case like this it's simply
wrong base and we see it immediately without any text description required.

> Latest mainline release
> rc1 of the new release - occasionally rcX but then you must call that out
> with reasons
> 
> These first two are the strong preference.
> 
> An immutable branch that others have created to allow some cross subsystem
> work in a single cycle.

> togreg branch of iio.git - but call that out and say why.

I agree that for the special cases the text might be needed to explain
the choice of the (non-standard) base.

> Anyhow, given I have a long queue today and this base commit thing has
> been going on for a few cycles (as seen by sashiko not reviewing it)
> I'm going to give v5 a skip and wait for v6.

-- 
With Best Regards,
Andy Shevchenko


