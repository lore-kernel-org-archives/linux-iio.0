Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55230D3FA;
	Tue, 16 Jun 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595430; cv=none; b=RLt+8gwXf1+zaOXfmukNBkS1ZlAwBJGG+Atf5C9j5CJJbzh2EZguV5GEjMuaAzohEMVGVmS6Cgp++BT06hUfxa6JOOEOGkMkYMglrrg7imM7Y9xpEanxKRGx0jHaRokrCgbIW9PSt16R1H4hT1mhCN/J4wRVxlH064WDaXHdawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595430; c=relaxed/simple;
	bh=Mimes273NlePGc1KQ8rbHs2k0c0Lh1J+Ft+IcKWx8OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPL/SHvJfEyZHypPe2hLqL4BBOP4COpF52bAQDDtsu88WbnpRJISnckSDSAzZus8yY/Ctzx0mm7lJaPVzeWxdckVaROCVYjpMzS/o5e5I6LEagKGzmCgEiLnVZfMO+0PzaTaf1vFGYXMSO1PY8d3ba405JudH081GNHVODZR5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLn4HQUc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLn4HQUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781595430; x=1813131430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mimes273NlePGc1KQ8rbHs2k0c0Lh1J+Ft+IcKWx8OU=;
  b=QLn4HQUcg6LUZkuMweIsfFZeK0QHXszGHmOUz6efTq7j1JQFci+ln6V/
   SFELklRZhcYxRy4qbM4xfaQmUxXr7o9S/gQX27tp/BsBVQDYNp9mts4kG
   lpZ5Gj+P3dKzYLAv0RVWOHJxNNdfQoVH/KwOcWMN5CruE7bhXOcM8xt5N
   ikLIvxsHtDvniCr5P1wHKMP5GxHfOV3A/OvXTNeQ6ANDH1F/Mg9b20Or/
   QDKcqhPFZa/KEo/pZtjANjfldaFNjegLDcjmDEoGz9J2XzW/yFmbo5s1a
   sgH0Ih4W4es8iza1M//43TR/MDTwlUiqVglGDvJMouZYGPnWnzWAahf46
   A==;
X-CSE-ConnectionGUID: /hVpqpD8SFqDGtkw1kEePQ==
X-CSE-MsgGUID: 49J3lEh1SzCC/5ih98hGww==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="84915793"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="84915793"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:37:09 -0700
X-CSE-ConnectionGUID: Zh2UvrssRXagsoUBospBEA==
X-CSE-MsgGUID: GZtz0qD+T0+NiArOPTxh4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="285809268"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:37:07 -0700
Date: Tue, 16 Jun 2026 10:37:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bm1390: replace short msleeps with
 usleep_range
Message-ID: <ajD9IJw0U_hUhRU1@ashevche-desk.local>
References: <20260607140018.59586-1-dennylin0707@gmail.com>
 <20260608184154.72a88788@jic23-huawei>
 <aieu-h2a1qqAzHnX@ashevche-desk.local>
 <29343d3a-38db-4f28-aed2-59e36d4354f8@gmail.com>
 <CAGEkeHfoNiwSD2g+uzOiW0OJTjvNyNW_RtJz0BiEMMn0dugkRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEkeHfoNiwSD2g+uzOiW0OJTjvNyNW_RtJz0BiEMMn0dugkRA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 01:51:55PM -0700, Hungyu Lin wrote:

,,,

> > I don't see the value either, unless there is a real problem the patch
> > author has encountered. If there is a real world problem this is solving
> > - please state it. My stance on fsleep() Vs. msleep() in ASYNC probes
> > can be read from discussion (bikeshedding) between me and Nuno ;)
> >
> > https://lore.kernel.org/all/14a23df0e1828b72b8b03c358980fe08a12bb216.camel@gmail.com/
> 
> My motivation was based on the BM1390 datasheet specifying a 1 ms
> reset cancel wait time (tSC1).
> 
> For additional context, I contacted ROHM regarding the timing
> requirement and received the following response from their sales
> representative after consulting with their engineering team:

Wow! Thanks for doing that. I would appreciate the contributors will do like
you have done in this case and consult with a vendor in case of doubt.
(Yeah, some vendors are unresponsive, but it's not our issue.)

> "The engineer confirmed that setting a delay longer than 1 ms does not
> have any significant impact on subsequent operation."
> 
> Given this feedback and the comments in this thread, I agree that I do
> not have evidence of any real-world issue caused by the existing
> msleep(1) usage, nor a clear functional benefit from this change.

-- 
With Best Regards,
Andy Shevchenko


