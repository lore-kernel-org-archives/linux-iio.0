Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985278;
	b=Z4bGv7mSMxXNTaZvfQ8WacWccAenFVrt/hwsM406rDyC3ZmF1+8OhBPj8tZs8oOJ6qvQ
	 VZK79KJEmPUK0ydvgc8YV1TVaZ/zJCsUNB7O85nO1DMsqNmG795qY90uvMI8i8JAPDthp
	 /+XYPVE5Tg8hsZiytYO//g4QPK6VWcZiEiwJSRr+MxKXmmNYZgArbx2ZDa1yhMwYnhH8h
	 5MewBJM7mThVqSzmEU2nWcj6ic2U1Guyexwo2pOUWDyEEnT841gIG+RDlepIj3L6vvOhi
	 3FQ+Aj5eZjeMATeHYlNuoF5KPPf3XNoVg4EIGAqptyEyXDoZElq8dmbSZJijtqb/fYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985278;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=YXva7EGd8F985iTMEciVwc5pHMWVJLULBd5jsSYGYao=;
	b=vZOgH3RyFRhFXI77NtdZ9c71qAqBZDQLHHWuzvJoyNI3ac3KAHDFgIuHnyw72S8iU+RO
	 A8w8g5BjBrAC0sGHfPE/qMkTGv+qvNGfjsk2eUQCEIBCns5WjiWWOQWNsGPlTUT+xaZq6
	 ugeTHpK9zhkxK1BGY2LShobokmRsT3J/52fFAWWrhS9sngPaVzeasMX30EGQiEt0YZcOm
	 kAxmWndw7h86uyFRX7QPY6xyeClY3TUcbcorc/P2awYn8QtG06nQOQ4Sp/V7yiDQG6Gba
	 K2pdt/mRqLYiZMkwJOPfcYHetdlkl57UB9No4qFmaw3YiCNFxAz4UZizUdDrYs/wryA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gFLmt0PG;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1F606A31C;
	Wed, 18 Nov 2026 07:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60D1F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gFLmt0PG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794985278; x=1826521278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vtzx74U0kOq7hPwalhY5EoBjohDpaPh5xJELg+lETEI=;
  b=gFLmt0PGwW7Np/X1uW7G3jJqP1/alYHZUq3VBvOoSkIo2KaN9JiYdkns
   C758az5gePNB/sdbmF8vilJWhSOlZdYawsdZNx+QEfu9YD7IqC3KtZGkN
   4dMrIdAAVaIgymSmI0D96xbr2MwzwwAZCzZRxXuqo3se3smKmaC5ghB7D
   rx+inUmKxm0BSs3pLwAYLD4fZPcNo31xlgoEIfAdRV8fod8SmLkcJBalo
   hFt91/UB9QNlXE1zUKYqZy0oFdBWnvH9Deyo1AAnu9ZmUIq7gbWyAUUOK
   oGdvpkmEC3hxTWlnQwTLYHwdPG8v836oxBGCo4MT9XpAYxWLDR5Wkez9M
   w==;
X-CSE-ConnectionGUID: GPpo2MQGRFSc7jdWIiKt0A==
X-CSE-MsgGUID: H2EJFrhuSRG7kGw6WmDxBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3702686"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3702686"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:01:17 -0800
X-CSE-ConnectionGUID: yboI6Bw4Q96++GkrmU732w==
X-CSE-MsgGUID: 7n7SdmgJTL6+VUw/J2VFvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9847187"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:01:14 -0800
Date: Wed, 18 Nov 2026 09:01:11 +0200
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
Message-ID: <av1NN8_Y_f3xtWRo@ashevche-desk.local>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
 <20261116205320.26070-3-kapoorarnav43@gmail.com>
 <avyj-lOGvj04A_Ak@ashevche-desk.local>
 <20261117191029.83901-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261117191029.83901-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 12:40:29AM +0530, Arnav Kapoor wrote:
> On Tue, Nov 17, 2026 at 08:59:06PM +0200, Andy Shevchenko wrote:
> > > For odd r the read value is (r * r - 1) / 2,
> >
> > No, it's r²/2 but in integer arithmetics. That's why for odd number squares
> > it gives 1/2 that becomes 0.
> 
> Same value, but your wording is clearer. I'll say in v2 that r * r / 2
> rounds down for odd r.
> 
> > Yep, what we see is off-by-one for full squares. This is because division
> > by 2 in integer arithmetics makes it floor number. So, what you want
> > to have is a correction for all odd numbers.
> 
> > And here I would rather use (val % 2) instead of 1. See above why.
> 
> I don't think val % 2 works, because the correction depends on whether
> the register code r is odd, not whether val is.

Ah, yes, you are right. I was thinking about it, but got sideways and wrote
that.

> Odd codes read back as even values too, as in your table:
> 
> 	reg	read value	int_sqrt(2 * val + val % 2)	int_sqrt(2 * val + 1)
> 	3	4		int_sqrt(8)  = 2		int_sqrt(9)  = 3
> 	5	12		int_sqrt(24) = 4		int_sqrt(25) = 5
> 	7	24		int_sqrt(48) = 6		int_sqrt(49) = 7
> 
> With + 1: an odd r reads back as (r * r - 1) / 2,

Nope, this reads as usual, the / 2 makes it floor because of integer arithmetics.
While mathematically (in integer arithmetics) it gives the same result the
reasoning is wrong.

> so 2 * val + 1 is
> exactly r * r.

From value point of view, yes for the full squares, but it's wrong for other
cases.

> An even r reads back as r * r / 2, so 2 * val + 1 is
> r * r + 1, and int_sqrt() still gives r. Checking all 256 codes,

For the sake of the correctness the whole set of 64k has to be checked. And in
most cases the + 1 there will be wrong. The only correction we need is on the
edges of the full squares, id est when val == r² - 1.

> + 1 round-trips every one of them, while val % 2 still fails on the same
> 127 codes as the current int_sqrt(2 * val). For values in between,
> + 1 also picks the largest code whose threshold does not exceed the
> requested value.

At bare minimum the commit message needs to be corrected and explained
these aspects that while the + 1 gives wrong result for most of the cases,
it's still okay to use as we work only in integer arithmetics. Also the formula
(r² - 1) / 2  has to be dropped as it's incorrect from mathematics point of
view. The floor() happens on / 2 and has nothing to do with (- 1) correction.

> > For the write part (the negative is problematic only on 32-bit case IIUC)
> 
> I think it is on 64-bit too: val is an unsigned int, so 2 * val wraps
> at 32 bits before int_sqrt() sees it, whatever the size of long.

OK, thanks for checking.

> > > 	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
> >
> > This one is not used in the conditionals, so the new check may well be done
> > before it.
> 
> > > +	if (_val < 0)
> >
> > Checking _val after assigning val to it is confusing.
> 
> > > 	if (val >= 1)
> >
> > First of all, I would drop the '=' here.
> 
> Agreed on all three. In v2 the check on _val will come first, before
> val and reg are assigned, and the condition will be val > 1. I'll make
> the same changes in 5/6, which has the same code for sx9360.

-- 
With Best Regards,
Andy Shevchenko


