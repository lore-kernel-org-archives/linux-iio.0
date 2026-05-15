Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440B3290B8;
	Fri, 15 May 2026 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830711; cv=none; b=pCN7g1Epx8iU3dqTubypp9IaIOyAWjRISnA28MITCDBDUDaCaupzDJZ/TaT6WVy/yso1mvb7DkiEw0JAVfC2b/SoRdLQ84J0tL5O34Ao1vq1JsdM19zsObBwt2wRFWLsv0mYS6Z4SSo6BsUiEm07zm9BuQ1QlSZsGLS4UPVIYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830711; c=relaxed/simple;
	bh=lP9tVmtwzbLQRudPjuo1zfBP9p5/3imREIYkZ6AvAmw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSH/YqHuv3uYtUcY+s/x3Rtndmkox8r85IFVN7CfgwmIOOczjd0u5MngKNOLC0fDpdl/Qb/OUjQspt0qXQS4Vhg01uW6ti2GtUIBOcircx6rM7PYuSeuXRs5OHrh6BJFGx8vtfP3AbCL1+/h/6LPA7clkOfe9OTXG3NsUF4k62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2GkP+tF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2GkP+tF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778830710; x=1810366710;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=lP9tVmtwzbLQRudPjuo1zfBP9p5/3imREIYkZ6AvAmw=;
  b=B2GkP+tFn7j7a43xrY8LREGnKGBaphuVlXfkhAGEf5ioO5urhW4M2yCH
   1MffeMYsv2cReqU40KJqxQD2OU64C9UydP8GAImZyQZhOxjMw+VYB3jAH
   0doi+MEtk3+1qAwt/N0yLg6cfAKFtmCvkhJ8h6gmy5d+vc9HwJqwK6/5G
   BR/KHMM9UWJj9bLRMPjlUCPofAS5sTvXuENCxyBEYaAcLqsCD9mK7PZS2
   Pj20WLCDrV36mXfluoa0KfxflI0LL0K81+KMryRCLoGmjgBVLeN+Vvp6Y
   Ubi4Wjkiwlkk+VT3ov4roj0v+JJieQX9DAjj2FwH3/bHu9FL/+7Mr79kj
   g==;
X-CSE-ConnectionGUID: tqnymOhqR/CL/Dr3k4TklA==
X-CSE-MsgGUID: Qe9yG5EjQPO2NfDBoaOK7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79956071"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79956071"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:38:30 -0700
X-CSE-ConnectionGUID: KzgjRThqSPG4EwBrKnmLxw==
X-CSE-MsgGUID: EIw5Ob1JRaKbZTPEx77eBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="242618938"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.33])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:38:26 -0700
Date: Fri, 15 May 2026 10:38:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 09/11] m68k: stmark2: use ioport.h macros for resources
Message-ID: <agbNbzD__8IDk5UA@ashevche-desk.local>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-9-fcdae50cf51a@baylibre.com>
 <agTcoVbImqMgfQy5@ashevche-desk.local>
 <cabngw2wuxh7cfx4cw4ik46dmxs72u47jyo6hcwgdd7a5whny2@dsp4cysetarw>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cabngw2wuxh7cfx4cw4ik46dmxs72u47jyo6hcwgdd7a5whny2@dsp4cysetarw>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 14, 2026 at 09:20:38AM +0200, Angelo Dureghello wrote:
> On 13.05.2026 23:18, Andy Shevchenko wrote:
> > On Wed, May 13, 2026 at 11:14:33AM +0200, Angelo Dureghello wrote:

...

> > This conversion drops hard indices, would it be a problem (for example,
> > some code modifies the fields based on the [hard coded] index...)?
> > 
> > If not, perhaps good to mention in the commit message and move IRQ to be the
> > second one?
> 
> i can't see any directly-related code accessing these resources by index,
> so would not change this if there isn't any risk. 
> Also i see DEFINE_RES_() stuff widely used in other arch, so thios make me
> think accessing by index is something wrong.

OK, thanks for confirming.

-- 
With Best Regards,
Andy Shevchenko


