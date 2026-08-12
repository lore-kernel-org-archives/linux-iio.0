Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA533D4F2;
	Wed, 12 Aug 2026 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519835; cv=none; b=TXHCCRITY+mzstGQpe55WfGbTaeiLa9OJYKwbE09PuVNc2bJ1HzIuN31xWcqVThSi7FA/qZZeuWOUwINrerU74GwZeBfNTlYHAtRDYKSzNYg08TR7gvyWhyU0CV5MEl9ZEzCBiCtOi/fDU458OqNKw8561NOfM08+8Vdtw+yvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519835; c=relaxed/simple;
	bh=1q9oFkMiQHtwe4YawVM+nQSG2FrXZBey9Q2BKnaciJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3W7/2P2v7KwSi8PM+O8av5Ic9lrq/D94hf07dgQfGh9piyzdaJTTJcf+RvBX6NyZFhxLhAh+5/ZbsoG/d3z3Dfr84G0h+e/ykb3lIRhCCYj5Q2zXpU6jQozpwdIccqDzLJQcvlyCULvbJ8QZcJnuWphwZ3U5wZJdLSXvvaHJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRsoY3Oh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRsoY3Oh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786519834; x=1818055834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1q9oFkMiQHtwe4YawVM+nQSG2FrXZBey9Q2BKnaciJA=;
  b=ZRsoY3OhrNV+8puMaff5c82Qe+OzS6IINVs9T7UFTV8W28uFsCxuWdcu
   K0OCr/9SPjsTFecI7K8iLS/RPAX/73V8Uvm2fvq06wvLbVpPvophjSKnQ
   Yxnhi8UtR1PVgL8tsy4otN6qlntLRoScvaL9sBi3TzJVbhtilLmrJqjtX
   WZOSjsDzjtUoMCXlR+o5tSOP9veQPa8xkUFf3XIr0s2y2lR7Nszy2PKDi
   iz2JYm7/3lzeNqc5OLd8OzCGi8+9wjPUAJbhIr5G+hojJTt+CnWF1PBUC
   4wwcXlVM6m0mTOTgugZoQgp06sjxLv/qeh3xEoz1IXqlI+1FGlnz3iaWI
   w==;
X-CSE-ConnectionGUID: R3Br4zBpTHWc6Wd2LulEaw==
X-CSE-MsgGUID: uSm0yyksREW5icJt2ds/Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90940813"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="90940813"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 00:30:34 -0700
X-CSE-ConnectionGUID: h+xqnM5dQ6SjuvnHS6BP/w==
X-CSE-MsgGUID: K9MzD47fTzOKsysg22l6Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="267062202"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 00:30:31 -0700
Date: Wed, 12 Aug 2026 10:30:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Message-ID: <anwhFL8PeCMmT9xS@ashevche-desk.local>
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
 <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com>
 <anrt5mJBz5h-a3OL@ashevche-desk.local>
 <CAF7HswP7+79Y5M92PVoHJ_H_J6rU=Q0p5qWDm1gcA2mPfg0VDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF7HswP7+79Y5M92PVoHJ_H_J6rU=Q0p5qWDm1gcA2mPfg0VDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:58:48AM +0800, Kyle Hsieh wrote:
> On Tue, Aug 11, 2026 at 5:39 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Aug 11, 2026 at 10:48:38AM +0800, Kyle Hsieh wrote:

...

You quoted tons of comments to which you haven't replied. Are you agree with
them?

...

> > > +                     if (pair[0] == 0 && pair[1] == 1)
> > > +                             spec->address = 0x00;
> > > +                     else if (pair[0] == 0 && pair[1] == 2)
> > > +                             spec->address = 0x01;
> > > +                     else if (pair[0] == 0 && pair[1] == 3)
> > > +                             spec->address = 0x02;
> > > +                     else if (pair[0] == 1 && pair[1] == 0)
> > > +                             spec->address = 0x03;
> > > +                     else if (pair[0] == 1 && pair[1] == 2)
> > > +                             spec->address = 0x04;
> > > +                     else if (pair[0] == 1 && pair[1] == 3)
> > > +                             spec->address = 0x05;
> > > +                     else if (pair[0] == 2 && pair[1] == 3)
> > > +                             spec->address = 0x06;
> > > +                     else if (pair[0] == 3 && pair[1] == 2)
> > > +                             spec->address = 0x07;
> >
> > I would do this as a 4x4 table
> >
> >         -1, 0, 1, 2,
> >         3, -1, 4, 5,
> >         -1, -1, -1, 6,
> >         -1, -1, 7, -1,
> >
> > With that done you can even supported the swapped cases
> >
> >         -1, 0, 1, 2,
> >         3, -1, 4, 5,
> >         1, 4, -1, 6,
> >         2, 5, 7, -1,
> >
> > (but I haven't studied the code if it's toughly relies on the pair[0]/pair[1]
> >  values to be in a strong order after the address being assigned).
> I will apply your first 4x4 table for diff-channels - it maps directly to
> the MUX encoding and is much more readable than the if-else chain.
> 
> I did not apply the second (swapped) table. Entries like [2][0] would
> map to MUX value 1, which is AINP=AIN0/AINN=AIN2, i.e. the opposite
> polarity, so it would silently return negated values. Supporting swapped
> pairs properly would need a per-channel inversion flag and negation
> after conversion, which I'd rather leave out of this initial minimal
> implementation.

I see, thanks for the information. I agree with your choice.

...

> > > +     /* Requesting OUT_HIGH asserts the active-low reset pin immediately */
> > > +     reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > +     if (IS_ERR(reset_gpio))
> > > +             return PTR_ERR(reset_gpio);
> >
> > Why reset-gpio driver can't be used instead?
> David suggested the reset controller framework on v1, but after I moved
> to gpiod in v2 he suggested GPIOD_OUT_HIGH to simplify it, so I kept
> gpiod. Switching now would mean changing the binding, which already has
> a Reviewed-by - happy to do it if you both prefer.

I'm not sure how the binding might be affected by that. reset-gpio should be
direct replacement of the custom "reset" GPIO handling in the driver. If there
is a problem with reset framework (on initial state), perhaps it needs to be
addressed there?

-- 
With Best Regards,
Andy Shevchenko


