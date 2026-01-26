Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92442D7817;
	Mon, 26 Jan 2026 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443900; cv=none; b=LL8GUlxa0mdWt8O8EGKsxSJ6PiXNQgqXqTgJEoKjQXTMA3GDjg4gQDyN/8UwjnwhM85jNDZgS6aOF0dDi8uOG2nhCwvr/qveBTHmDcvRBx6U8/WEJQ9m9TJELuD8mfsAIlwY0j4c4yuhihO6mxwTZCNbOXDV96vnddwRdJv7E4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443900; c=relaxed/simple;
	bh=Pkuiqseu2HBLtqGxHAGQMQZ50dVRu5Xif/58/CtpI4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFxG/pnk55gJy1BBE9say0514FjCEfa0vFyHrq3e/CPmDEnJzUmbGlB+3qcN17fgJt+RoyQFlFoh1vT9YG05ijHxj6RimJfLHeJ5ZzKLkCgTwH4EJQ8XboHcEVprE9eHiAxecRP6pHeQUOslSdR8/9XuNLMhA9UDIAHMivc9Wgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hd26IWzT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hd26IWzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769443898; x=1800979898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Pkuiqseu2HBLtqGxHAGQMQZ50dVRu5Xif/58/CtpI4o=;
  b=Hd26IWzTy1ObtanVIaBWbYn+JR7LWUM8+Trj5MYdi86RkesBXm7WdxwA
   xffwk47XRnQzz6ABtyxinh252x7J8P+oN0exUd7p+lr540sARLzxq85c6
   pb6nM9rUrU+KMqTxRIlMxoYJORcloqufMDRHvQ3Mv6DtIBBeDPS8OH+dv
   ig7vl1rJY5LZ0b3B8psPyytRLUm4N/uFO5yKFvsf/1VDalafBmhO3iNEH
   IGIaM4MHhs7oqT9M2QxK3zsw/CxyhMhtX/0mz8wtYf3FT81G7vtkz1Yz0
   Y/zuaViO/KCLR7J2gFp2wqLh7OCGJxEmZHEYM0d/MAngWtR1qSUUwel6Y
   w==;
X-CSE-ConnectionGUID: 8ZO9yFaFRpC8rvC2UzS79g==
X-CSE-MsgGUID: q5a6CDWAQhapiUuaxJHZcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70527766"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70527766"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:11:38 -0800
X-CSE-ConnectionGUID: 917qBI+iQXeeLelUmPL2vw==
X-CSE-MsgGUID: h2kjTGUPTxGuxmY48dia/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="238390272"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:11:36 -0800
Date: Mon, 26 Jan 2026 18:11:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shrikant <raskar.shree97@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] iio: proximity: rfd77402: Use kernel helper for
 result polling
Message-ID: <aXeSNSKqgfVwhRvs@smile.fi.intel.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
 <20260121-b4-rfd77402_v5-v6-2-5b944d0605dd@gmail.com>
 <aXCWz6O2CdU_Sp8r@smile.fi.intel.com>
 <CAHc1_P5hY6-z5s0J4SW_2GMER+NP4NsqoVVVaYFUg_gRi=31JQ@mail.gmail.com>
 <aXc3lPNFF18ygeow@smile.fi.intel.com>
 <CAHc1_P7vG4=zzTB2RWeNXzaqbXZ7zKokUJkRXnwQOXQBgJJmqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc1_P7vG4=zzTB2RWeNXzaqbXZ7zKokUJkRXnwQOXQBgJJmqg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 08:58:07PM +0530, Shrikant wrote:
> On Mon, Jan 26, 2026 at 3:14 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sat, Jan 24, 2026 at 10:26:04PM +0530, Shrikant wrote:

...

> > > > > +                              10 * USEC_PER_MSEC,
> > > > > +                              10 * 10 * USEC_PER_MSEC,
> > > >
> > > > This makes sleep shorter by 2. Why?
> > > I have considered the timeout values from the RFD77402 datasheet.
> > > The timeout values mentioned in section 3.1.1 Single Measure are as below:
> > > 1. Every Status Check = 10ms
> > > 2. Whole Flow = 100 ms
> >
> > So, you should do this in a separate change explaining this.
> In that case, I can add a small preparatory patch before the
> “Use kernel helper for result polling” patch to adjust the
> polling interval according to the datasheet.
> 
> This would mean changing the existing polling loop, for example:
> diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
> index 69cc1505b964..3e14660a4bb1 100644
> --- a/drivers/iio/proximity/rfd77402.c
> +++ b/drivers/iio/proximity/rfd77402.c
> @@ -132,7 +132,7 @@ static int rfd77402_measure(struct i2c_client *client)
>                         goto err;
>                 if (ret & RFD77402_ICSR_RESULT)
>                         break;
> -               msleep(20);
> +               msleep(10);
>         }
> 
>         if (tries < 0) {
> 
> However, this change would then be removed in the very next patch
> when the polling loop is replaced by read_poll_timeout().I just want
> to confirm that this temporary change–then–removal is acceptable?

Yes. These two will be quite different semantically.

-- 
With Best Regards,
Andy Shevchenko


