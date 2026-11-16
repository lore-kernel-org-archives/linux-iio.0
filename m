Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822842;
	b=IFc3WkhPLi+SXQ2pRcDOocERcNwpIYjuOMb+DnXaUD587lFmOVW+X1/2yExam02E8P1y
	 eSg6v9hevR+gl8gF1+8CgctxMs5QKxc25Jq4ypxhwM6B2c0SjzrCQZ47YHBAHVsjutddB
	 CvNvXbbdGHLqy4cH/xMvmhzzgEIaYTEnuqUTgGWVLig5HnolStUjzQJBxCmO8hpYaZvHd
	 UaEcDXrDbyNEUnAQhOjrz8mK6Y7Q8ilZuh6u1ejIRuCTR1RJGwdkbnzoi9eXgf4vtlF4G
	 ovjcLxYJ2Ad+PPeKH7VxncSz1XLmSQ18eYihHmUo631RZ/BZcmFefGKhq1XvodAVObQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822842;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=cr07oHssbLWlJlBi/NoZz/TL0z6F2KfdhBGAB1tmrfM=;
	b=DsZ7u1W/J/TLFzrneHHr146Yz+hRLudP90ajsbQ1j0OK8y8cfvOoXycqNg6bGmFpYgyu
	 8EHhQBmT6bpVt4GlQ1uxNima+QR6MjLsYFY6c7Efmfq7392Td6r9ZEuWCADKz58q7/Tke
	 /d/K47xCp3WTUS4GA7tVgsO1o96UrbAbuxrLZhga3KDhbOsF3x/evbJqh1iNoeOcyTPl0
	 7kuLdXqtZS5+DiFvmgyCrTOEnfDS5LhZ7iq82OGbRo+XgZW1XuKYfvHka7fRxlJwNelgK
	 eeN7/xr0Uhe3LtcBHmFSskZU9dlZtboeondqC07Pq/oBvC6EYHt8cROH+2YuuAkQINA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WELHRHmT;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59F606A31C;
	Mon, 16 Nov 2026 09:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B59F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WELHRHmT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794822841; x=1826358841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Uoy1KllQGtfzXAFPSLxBDqpTsuB6y9sJz6MprUKpRkI=;
  b=WELHRHmTrKUpV5r/e0QIY7uTxNz+W1TPbkWuHmtGqbv/KTBJqY7ASQZU
   co6nmyNg0wGX8nfghJs/DBR+OPsGSWddt6lpbeoyi4A4ea4V32yT5TxA1
   ilUpYXIMkBuy9b85JN1qbb3ExDefonjrNw5JDmpLV32+KAjzH/Mf9bjS1
   1S0g9J0TMmQBR2Y2R2k2v/3rg38xxC0GHLPhIv9Pqezo6KlwbPH9wswUk
   +kD87Zr1nubXImtEo1BOU3Sif9wLsOqMtkx/uxECSpz/s071q9nOW+3no
   si66ID+WA+bYdNvx8/VoSr00NzbMDZJM4VgiuZLqkJmvJ5irQmfTyj8CP
   w==;
X-CSE-ConnectionGUID: rjpBbpXaQG6g3vo+7mK00g==
X-CSE-MsgGUID: 06DUTP3CTy2mvIGcAOVBVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3585593"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3585593"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:54:01 -0800
X-CSE-ConnectionGUID: HwjSJmAtQROdybNRcNO+uQ==
X-CSE-MsgGUID: vyXX0qsSTqOzZA3GAZi+Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9567827"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:53:58 -0800
Date: Mon, 16 Nov 2026 11:53:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Zhu Jun <zhujun2@cmss.chinamobile.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: potentiostat: lmp91000: Handle configuration
 write errors
Message-ID: <avrStKkcvUApPMDb@ashevche-desk.local>
References: <20261113082546.176582-1-zhujun2@cmss.chinamobile.com>
 <CAHp75VeOjqWoEM36OMgtiiwu3XWiu5wfJf59vYFuGSApbWpPaA@mail.gmail.com>
 <CAHp75Vfy97JHMaURigbF92z7Eypfuny8PUk94=-43S6p6PhknQ@mail.gmail.com>
 <20261114014149.21dbc4d2@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261114014149.21dbc4d2@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 14, 2026 at 01:41:49AM +0000, Jonathan Cameron wrote:
> On Fri, 13 Nov 2026 10:47:32 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Nov 13, 2026 at 10:41 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Nov 13, 2026 at 10:25 AM Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:  

...

> > > > Check the configuration writes and return the first error. After a
> > > > successful unlock, attempt to restore write protection even if a
> > > > configuration write fails. Return a relock error when both configuration
> > > > writes succeeded.
> > > >
> > > > lmp91000_probe() returns either error before registering the IIO device,
> > > > so the caller does not need to distinguish their source. Preserve the
> > > > configuration error if restoring write protection also fails.  
> > 
> > Btw, this is still unclear. See below.

...

> > > > -       regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
> > > > -       regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> > > > -       regmap_write(data->regmap, LMP91000_REG_REFCN,
> > > > -                    LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
> > > > +       ret = regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       ret = regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> > > > +       if (ret)
> > > > +               goto relock;
> > > > +
> > > > +       ret = regmap_write(data->regmap, LMP91000_REG_REFCN,
> > > > +                          LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
> > > > +       if (ret)
> > > > +               goto relock;
> > > > +
> > > > +       return regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
> > > > +
> > > > +relock:
> > > >         regmap_write(data->regmap, LMP91000_REG_LOCK, 1);  
> > >
> > > What's the point of duplicating this?
> > > Before label you can easily do
> > >
> > >   ret = 0;
> > >
> > > relock:
> > >   ...  
> > 
> > Ah, okay, I see that the relock error is returned only on success of
> > the configuration update. Why is this inconsistency? Really, you need
> > to elaborate first on what the caller is suppose to do when
> > 1) unlock failed;
> > 2) unlock was successful, but configuration was failed;
> > 3) unlock and configuration was successful, but relock failed.
> > 
> > In all of these cases the user gets an error, but it doesn't know
> > which stage was failed. What is the caller supposed to do?
> > 
> > No need to send a new patch, let's keep discussion here to understand
> > the code flow better.
> 
> I think I requested this flow.  I didn't like v1 doing some dance
> with ret2 and only return that if ret wasn't set.  Argument of the patch is
> that we must make sure to unlock even on error.

Right, but I think this is a slippery slope to leave device in the inconsistent
state and caller will not know if the locking failed or actual configuration.
How is HW being recovered from the inconsistent state(s)? That's basically my
main concern.

Note, I haven't checked with datasheet, so I have no clue how critical those
erroneous states are. If it's natural flow on the next iteration that clears
this problem, then we may relax on the error checking to begin with.

> > > > -       return 0;
> > > > +       return ret;
> > > >  }  

-- 
With Best Regards,
Andy Shevchenko


