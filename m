Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0937B41F;
	Thu,  5 Mar 2026 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704320; cv=none; b=jOvctLZkPMvYF5C9+An0ueDJW16ReNqnlMQTFQR/n6ElSSCeeanTN4g1eZSZLiqJPG28iNk7eyaR0lhP1qtRSXb5KqFMJrNhU4f3bAGC7Pw8oR4j7tJ4VAAraan92G5ZTo+1yvsfQ49/2CxDNsNQgK029GEJQVTPSExHSraMXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704320; c=relaxed/simple;
	bh=nHBskueiE3gLY5mo/YyZcYcBLhpEuC8zs9gd0IlecEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjNqFkOTokBXQ2iQJjDIZ/Mvxcrin9Xim0dzPiClGraQxRM78FOqez70ViDlb1xn77a5e4GSInkigX42cgrWSe7lpAGVenXruL1+JugJiZoXIw1FnMcw/4nUkIwjf/r9aAUEk+QGXcgmueWoyZL7TIqWSX/+bDzFFU31S9kbUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAsXqLcu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAsXqLcu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772704318; x=1804240318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nHBskueiE3gLY5mo/YyZcYcBLhpEuC8zs9gd0IlecEs=;
  b=YAsXqLcu/QGexyik7mPMArx31M5jt0wuOxFs5DOrGQAucGC37ZyrCKhf
   mfG5hkTJJ9nWGXItZrJb6q1jUPK0v1EdD0306egrUG5t3FjwMNO8QR6HF
   YQUAU7zuyDpzMZmqAVsFZgAjWV5rkQAOaYRT46qKzJyCI4Wch6VQQLSem
   4HLhJ3PC94RNKCugaYZh3L2qF5l+MQf/DOYNxD7bA9eHXxgyXGux7UE7Y
   rKDlreNsOYm1wZ/y/wXekmhreCB28jrzA4RbEcCr/vP6f9PK9Rzc8SP6h
   on3SFVcYhjR3VPESOw5vHNEPwMZzYS3hYKhAN5kfoa8Lz1Aet9YIdahQ7
   g==;
X-CSE-ConnectionGUID: JRw7rpEpTfalJ0OVez9sLg==
X-CSE-MsgGUID: KTzjC7lMTneueUztBuMIgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="91178469"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="91178469"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 01:51:57 -0800
X-CSE-ConnectionGUID: Loufc/uDQjqGIb3z6cDnKA==
X-CSE-MsgGUID: iFupuJ4JREC6WG2kobSOmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="256513023"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 01:51:54 -0800
Date: Thu, 5 Mar 2026 11:51:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: frequency: admv1013: fix NULL pointer
 dereference on str
Message-ID: <aalSN21HiRi9g8x6@ashevche-desk.local>
References: <20260305091448.32052-1-antoniu.miclaus@analog.com>
 <CAHp75VdHz4SSyA78VYRvHrgUxGFAC6HeMmAuoxjS1twsTNTHkw@mail.gmail.com>
 <CY4PR03MB3399F7FB4FE82A606CCC333D9B7DA@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR03MB3399F7FB4FE82A606CCC333D9B7DA@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 05, 2026 at 09:44:35AM +0000, Miclaus, Antoniu wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Thursday, March 5, 2026 11:36 AM
> > On Thu, Mar 5, 2026 at 11:15 AM Antoniu Miclaus
> > <antoniu.miclaus@analog.com> wrote:

...

> > > static int admv1013_init(struct admv1013_state *st, int vcm_uv)
> > 
> > > -       data = FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, st-
> > >quad_se_mode);
> > > +       switch (st->quad_se_mode) {
> > > +       case ADMV1013_SE_MODE_POS:
> > > +               data = 6;
> > > +               break;
> > > +       case ADMV1013_SE_MODE_NEG:
> > > +               data = 9;
> > > +               break;
> > > +       case ADMV1013_SE_MODE_DIFF:
> > > +               data = 12;
> > > +               break;
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > 
> > Oh, I haven't realised that it can be done like this. I have in mind
> > just to have a switch in the probe, so we don't need to do that again
> > and again. Otherwise looks good to me.
> 
> Hmm, the _init() function is called only in the probe.

Ah, missed that. Then we are good.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> I think it makes a bit more sense to be here where we handle all the initial
> register configurations.

Agree.

-- 
With Best Regards,
Andy Shevchenko


