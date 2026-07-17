Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DC282F29;
	Fri, 17 Jul 2026 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311907; cv=none; b=N6/sqzXvC9rYHG/qYk0zdiihmuXhojQ0cDZEaid0OuvKoTSbRpiwR6wcL576J9wqluQmzyFWR2gu55+pQqEhzbbibYamAYGizLvO9+VNUqF5q28753wd1Qzt9TLh9tyVK75JNbrYskTamKD72q64juPBFpuDnrRgiev2kmVkF4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311907; c=relaxed/simple;
	bh=XVSVXi/J+aA3MsFvB71CmNQ6JTmVnyH3QblVg1ydcxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuKEtwPlLQ3p/nchI8hQt66h4GBv81/+DmetqgrYNiJlv7zb9X7/s0NQuNi39bxRGPjGFmkOUF7XKKzO76merbaxO2MRj2vUWec2WSXCZPvyBcPbRmgbUgus17twCjDV3WzxJphPq9guBjy8Kr/qoXRWMG4/OuOG2Hj5fh4kfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mt/8QQtB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mt/8QQtB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784311906; x=1815847906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XVSVXi/J+aA3MsFvB71CmNQ6JTmVnyH3QblVg1ydcxo=;
  b=Mt/8QQtBtiVW/q9xcLlFTMMn28iZNdRYbNeECkoLGdEhwLoqNpqYpMSZ
   3DkQZvZD8CdAmKjPlr//64y+PceBtK26i6EDaWMoGbIBEnnus9yQUW9lJ
   qxesCf/Yqc8PGdbzKqV0TMi73Icr3eS9Cz1lkH7w5FzcSfmBV2Ce0zLvE
   M/Pn4aDf0Dhl+qw8MDS9o8t7Muv8WmntUoo42jHh7vARKL8bhSMM/ClIM
   lqukJowcsUJinZwxzKv3SrYGL1ezUVtPuYooUzFruqBTNlEzU06IIpSmM
   kf6rKZw0MM2Wl7f0EEWVGWWibzikXFqoXySbPggh8lgMCovMrjlDw7+u3
   g==;
X-CSE-ConnectionGUID: EaOc4KS9RvS0JLbOOqp7Hw==
X-CSE-MsgGUID: H93GMUWFQPOmC9P+VmdaQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="84941474"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="84941474"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:11:45 -0700
X-CSE-ConnectionGUID: dV31b4u0R8KjtbgJ2OlSTA==
X-CSE-MsgGUID: SUiXW48FQz2VODOnKix56g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="250497505"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:11:40 -0700
Date: Fri, 17 Jul 2026 21:11:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yu-Chun Lin =?utf-8?B?W+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
Cc: Michael Walle <mwalle@kernel.org>,
	"Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
	"afaerber@suse.com" <afaerber@suse.com>,
	"andy@kernel.org" <andy@kernel.org>,
	"brgl@kernel.org" <brgl@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	James Tai =?utf-8?B?W+aItOW/l+WzsF0=?= <james.tai@realtek.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linusw@kernel.org" <linusw@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-realtek-soc@lists.infradead.org" <linux-realtek-soc@lists.infradead.org>,
	"mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"robh@kernel.org" <robh@kernel.org>,
	Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= <stanley_chang@realtek.com>,
	=?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>,
	"wbg@kernel.org" <wbg@kernel.org>
Subject: Re: [PATCH v3 3/7] gpio: regmap: Add gpio_regmap_operation and
 write-enable support
Message-ID: <alpwWcfHLmOdbrVF@ashevche-desk.local>
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
 <20260716062614.1507243-1-eleanor.lin@realtek.com>
 <aliV4u6_xzx9D9Aq@ashevche-desk.local>
 <DJZVLZ4LLD9E.3MPLYYXT1VQ9R@kernel.org>
 <alim_HGTD5RCupav@ashevche-desk.local>
 <DJZXVOGZ3ZTH.20P8NY7DON0X7@kernel.org>
 <alkbVkB5KNNR7ffN@ashevche-desk.local>
 <82f3f73764ac4553a8e2743bbebd90e8@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82f3f73764ac4553a8e2743bbebd90e8@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 03:38:35PM +0000, Yu-Chun Lin [林祐君] wrote:
> > On Thu, Jul 16, 2026 at 12:55:37PM +0200, Michael Walle wrote:
> > > On Thu Jul 16, 2026 at 11:40 AM CEST, Andy Shevchenko wrote:
> > > > On Thu, Jul 16, 2026 at 11:08:55AM +0200, Michael Walle wrote:
> > > >> On Thu Jul 16, 2026 at 10:27 AM CEST, Andy Shevchenko wrote:
> > > >> > On Thu, Jul 16, 2026 at 02:26:14PM +0800, Yu-Chun Lin wrote:

...

> > > >> > From the above list I tend to the approach 2, but this might
> > > >> > require to have GPIO regmap level of locking. I'm a bit lost in
> > > >> > the context, though. I assume we need a fresh start, id est issue
> > > >> > a v6 with approach 2 or 3 in place and summarize the choices in
> > > >> > the cover letter, so we can understand what has been considered.
> > > >>
> > > >> I don't really like approach 3. You'd need to check if the regs of
> > > >> both xlate calls are the same. With the sample code above, you
> > > >> silently drop the first xlate'd reg.
> > > >
> > > > If I rank the proposals, the worst is #1, the best is #2.
> > > >
> > > >> And honestly, it really seems like a one-off. What controllers, are
> > > >> there that need a write enable bit. The real problem seems to be
> > > >> the assumption that we operate on just one bit. IOW we either set
> > > >> mask or don't set mask in gpio_regmap_set().
> > > >
> > > > Yes, we should KISS.
> > >
> > > But IMHO #2 and #3 are not KISS. Approach 2 is just a way of adding
> > > some kind of pre op to a gpio set. Just tying it to a write enable
> > > feature. That kinda bothers me. It might also be useful for other
> > > things, too. So don't tie it to just write enable. And who is doing a
> > > write disable if it's not self clearing for example. Probably Some
> > > kind of post op :)
> > >
> > > Approach 3 is a way to change the value of the written value - in a
> > > restricted way, as is is just doing a OR with both values.
> > >
> > > Also approach 2 might not even work if the hardware requires the write
> > > enable bit set in the *same* write as the gpio set bit. Thus, we might
> > > need both anyway in the future.
> > >
> > > >> For a more generic solution, we should be able to control the
> > > >> written value. We could add another .value_xlate().
> > > >
> > > > Maybe not now?
> > >
> > > But if not now, then when? I wouldn't add the write enable feature and
> > > later a more generic solution which also covers the write enable
> > > feature.
> > 
> > Taking into account how it's done in HW, I think the whole approach can be
> > folded to just a boolean flag  (or a simply bit shift) in the config.
> > Wouldn't it work?
> 
> To respect Michael's perspective on keeping WREN-specific code out of the
> framework, I think adding a value_xlate callback in the config is a cleaner
> approach. It allows us to wrap this hardware quirk within the callback and let
> the consumer driver handle it entirely.
> 
> To ensure it is truly generic, I will not introduce any WREN-specific operation
> flags. Instead, value_xlate will reuse the gpio_regmap_operation enum
> (e.g., GPIO_REGMAP_OP_SET, GPIO_REGMAP_OP_SET_DIR).

OK! But don't forget add a good documentation that users will understand
the logic behind it.

> > > > As per IPs, Synopsys IPs (not exactly GPIO) likes to have that kind
> > > > of "protection". So, from HW perspective it's kinda pattern, and it
> > > > might be possible to see more IPs (including GPIO) that follow it in
> > > > some cases.

-- 
With Best Regards,
Andy Shevchenko


