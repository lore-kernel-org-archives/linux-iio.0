Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4953AA1A9;
	Thu, 16 Jul 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224608; cv=none; b=WRARRWsr+fRbbpdBzge23OUQ2eB61tc4FcBCO65vMd3DmFiUk4SrsV4+PBYzYHYwgGBI1z3+6wHIDvPWtjqemJdKn+YAYGWU8J6d0mnYfLxB1+gaqo+56h/Scrzp02lNYrjuyzU18kZiKJbAiro98vTGNwIfWM5YlK6w9G3V1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224608; c=relaxed/simple;
	bh=JOhrs1OFvboDcLOeh8gPY/kmKk14v0E8LAeuat6Eybc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUa2sztQqEIGVDOHaDqWiUha+3Df1Xs7RgjUL6F9gS2jtWdi4ibeF24pyr01McT4Q1Q8zRjbKfBnZWCpjTzNRXiMCspoqnysf8aAn+GAc9ff/4X6Pn8t/EqVYSnkDNzDfM53e5BVtlNXhaUH2EIZRcbB2xOa5RRqyC41FMMeC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3QQioGr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3QQioGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784224607; x=1815760607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JOhrs1OFvboDcLOeh8gPY/kmKk14v0E8LAeuat6Eybc=;
  b=N3QQioGrTSDloysBhVhyIN3cOQkH7KtemlGcFh8tqhlgKiIgjEX6VUUb
   F04crWcoFVlhiilPb3zUQEGUDt7PNDZkriFXTWfN2rAVXvJKKIfGqUg4S
   oHObyIN8KG0I7qUbNIsAkSy53Hv2w09Wu0Y/FHhlFC8K2R9ObDTBvDWU1
   w9jxwjhjJinghVpv94sdNSzAOp9MGxvC2cnnNjPvhL8p5bx2Q48bqBl9k
   sd1hPBLK83YyIgpXY5vLOKg9V5GlrFasNOYvpS85PS/tPVxLHMJWe8r75
   dPLyAwDlBstRKEbxAvILdcQk85FyYAJqVmJyNy79/zi3vq4NpIRrO+avL
   A==;
X-CSE-ConnectionGUID: uLGBj/ynQeKZkv/QU2Cfwg==
X-CSE-MsgGUID: yUu7GqxkSRmTmlp69bhLZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96029970"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="96029970"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:56:47 -0700
X-CSE-ConnectionGUID: o44G+L4dSBaDIU9Jshoh0g==
X-CSE-MsgGUID: dUnJTDUlRJ2uULcA2u/yFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="260160330"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:56:40 -0700
Date: Thu, 16 Jul 2026 20:56:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Yu-Chun Lin <eleanor.lin@realtek.com>, Michael.Hennerich@analog.com,
	afaerber@suse.com, andy@kernel.org, brgl@kernel.org,
	conor+dt@kernel.org, cy.huang@realtek.com,
	devicetree@vger.kernel.org, dlechner@baylibre.com,
	james.tai@realtek.com, jic23@kernel.org, krzk+dt@kernel.org,
	lars@metafoo.de, linus.walleij@linaro.org, linusw@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-realtek-soc@lists.infradead.org,
	mathieu.dubois-briand@bootlin.com, nuno.sa@analog.com,
	robh@kernel.org, stanley_chang@realtek.com, tychang@realtek.com,
	wbg@kernel.org
Subject: Re: [PATCH v3 3/7] gpio: regmap: Add gpio_regmap_operation and
 write-enable support
Message-ID: <alkbVkB5KNNR7ffN@ashevche-desk.local>
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
 <20260716062614.1507243-1-eleanor.lin@realtek.com>
 <aliV4u6_xzx9D9Aq@ashevche-desk.local>
 <DJZVLZ4LLD9E.3MPLYYXT1VQ9R@kernel.org>
 <alim_HGTD5RCupav@ashevche-desk.local>
 <DJZXVOGZ3ZTH.20P8NY7DON0X7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJZXVOGZ3ZTH.20P8NY7DON0X7@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 12:55:37PM +0200, Michael Walle wrote:
> On Thu Jul 16, 2026 at 11:40 AM CEST, Andy Shevchenko wrote:
> > On Thu, Jul 16, 2026 at 11:08:55AM +0200, Michael Walle wrote:
> >> On Thu Jul 16, 2026 at 10:27 AM CEST, Andy Shevchenko wrote:
> >> > On Thu, Jul 16, 2026 at 02:26:14PM +0800, Yu-Chun Lin wrote:

...

> >> > From the above list I tend to the approach 2, but this might require to have
> >> > GPIO regmap level of locking. I'm a bit lost in the context, though. I assume
> >> > we need a fresh start, id est issue a v6 with approach 2 or 3 in place and
> >> > summarize the choices in the cover letter, so we can understand what has been
> >> > considered.
> >> 
> >> I don't really like approach 3. You'd need to check if the regs of
> >> both xlate calls are the same. With the sample code above, you
> >> silently drop the first xlate'd reg.
> >
> > If I rank the proposals, the worst is #1, the best is #2.
> >
> >> And honestly, it really seems like a one-off. What controllers, are
> >> there that need a write enable bit. The real problem seems to be
> >> the assumption that we operate on just one bit. IOW we either set
> >> mask or don't set mask in gpio_regmap_set().
> >
> > Yes, we should KISS.
> 
> But IMHO #2 and #3 are not KISS. Approach 2 is just a way of adding
> some kind of pre op to a gpio set. Just tying it to a write enable
> feature. That kinda bothers me. It might also be useful for other
> things, too. So don't tie it to just write enable. And who is doing
> a write disable if it's not self clearing for example. Probably Some
> kind of post op :)
> 
> Approach 3 is a way to change the value of the written value - in
> a restricted way, as is is just doing a OR with both values.
> 
> Also approach 2 might not even work if the hardware requires the
> write enable bit set in the *same* write as the gpio set bit. Thus,
> we might need both anyway in the future.
> 
> >> For a more generic solution, we should be able to control the
> >> written value. We could add another .value_xlate().
> >
> > Maybe not now?
> 
> But if not now, then when? I wouldn't add the write enable feature
> and later a more generic solution which also covers the write enable
> feature.

Taking into account how it's done in HW, I think the whole approach can
be folded to just a boolean flag  (or a simply bit shift) in the config.
Wouldn't it work?

> > As per IPs, Synopsys IPs (not exactly GPIO) likes to
> > have that kind of "protection". So, from HW perspective it's kinda
> > pattern, and it might be possible to see more IPs (including GPIO)
> > that follow it in some cases.

-- 
With Best Regards,
Andy Shevchenko


