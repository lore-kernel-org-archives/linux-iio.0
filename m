Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C73A5436;
	Thu, 16 Jul 2026 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194823; cv=none; b=DUMM1Q3CVTknRjKGgDnUsqSRzr/ruHQHdaFRrE1PTI2r23mKMV+CoD4L/mKm2jyc6kzGUOYTiL3yj+PkbCFV1azZa+ubQgzTjSf+6O/yXX9tE4Sb7dLpv0Iv9Mtm9nEwkFVRMBVVLQmk0jSDmi3NRTGtoYlQlJ3FNlz+ooG/hVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194823; c=relaxed/simple;
	bh=AjNabPt8KbtTKqTuT9NoOhSbqcJ/OKIChvyCnG26SUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEWMhCVgKhLC4BsQ6xfr2KGJG59wW7x4rN8zF3J86OIHhv6f6CWX9k3jQKglUz9iwbYT9xcpFuCAMkImCiETnTHPsfZpQO/5mVvQa4PEtWXGvh6omru6YWuen/i+16OpMzyGwOetxsKWaem7VcG1wAKV9f5uhuv3E5K0lSz6qKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tl38Fiyx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tl38Fiyx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784194821; x=1815730821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AjNabPt8KbtTKqTuT9NoOhSbqcJ/OKIChvyCnG26SUc=;
  b=Tl38FiyxDzGGVDSIQGKoHR+WEtesjrsmMDYU8o7pvdETmiUgwmxhQcAD
   mDA+DH22I30AU0f4ABU/dD5hcVzn2pug3Q1j9AgxlakRINdD0nbEQvfeC
   Z7PnThRBTiz1qU23+DOtrJbeoomYDWkHLWHxXahU/4maqQPGw8iut4aRO
   WHC/HQyCH1vWzhp2dP+2tNrFMnbk198ybEp9Ii3fPPsmIl9uCDtX2SC7x
   l/xJ3FDWSdqOToNkrTO8FM2QeVkGPnQ4ewT+hZytfJDQntottGc6jwZh/
   dXizACqYuBkcP63oYjg/4nXcuK37gBl8dSXurN1LsBTAaNYc3EauKJaSL
   A==;
X-CSE-ConnectionGUID: AmVuV7QERwKi+684erWRNA==
X-CSE-MsgGUID: 7fZBsbuiT0+IyXJ6hJb+Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963035"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84963035"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:40:20 -0700
X-CSE-ConnectionGUID: IbA0Hh1qRaKPeq90gKjMig==
X-CSE-MsgGUID: bmffYRkeTyaR1Xcw/JN6WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="254696847"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:40:15 -0700
Date: Thu, 16 Jul 2026 12:40:12 +0300
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
Message-ID: <alim_HGTD5RCupav@ashevche-desk.local>
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
 <20260716062614.1507243-1-eleanor.lin@realtek.com>
 <aliV4u6_xzx9D9Aq@ashevche-desk.local>
 <DJZVLZ4LLD9E.3MPLYYXT1VQ9R@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJZVLZ4LLD9E.3MPLYYXT1VQ9R@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 11:08:55AM +0200, Michael Walle wrote:
> On Thu Jul 16, 2026 at 10:27 AM CEST, Andy Shevchenko wrote:
> > On Thu, Jul 16, 2026 at 02:26:14PM +0800, Yu-Chun Lin wrote:

...

> > From the above list I tend to the approach 2, but this might require to have
> > GPIO regmap level of locking. I'm a bit lost in the context, though. I assume
> > we need a fresh start, id est issue a v6 with approach 2 or 3 in place and
> > summarize the choices in the cover letter, so we can understand what has been
> > considered.
> 
> I don't really like approach 3. You'd need to check if the regs of
> both xlate calls are the same. With the sample code above, you
> silently drop the first xlate'd reg.

If I rank the proposals, the worst is #1, the best is #2.

> And honestly, it really seems like a one-off. What controllers, are
> there that need a write enable bit. The real problem seems to be
> the assumption that we operate on just one bit. IOW we either set
> mask or don't set mask in gpio_regmap_set().

Yes, we should KISS.

> For a more generic solution, we should be able to control the
> written value. We could add another .value_xlate().

Maybe not now? As per IPs, Synopsys IPs (not exactly GPIO) likes to
have that kind of "protection". So, from HW perspective it's kinda
pattern, and it might be possible to see more IPs (including GPIO)
that follow it in some cases.

-- 
With Best Regards,
Andy Shevchenko


