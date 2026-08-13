Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5941167C;
	Thu, 13 Aug 2026 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609845; cv=none; b=kdsRAr746ajbVY88eJAveNWIwsPSm4pR9KV+vgb2PT985dISxUbAG9K6VCXj7wAgpPdWCRBqaTt3iOphKItQ6Q1Tw3Y9Bev5T0W/1PFjNnpUakPPcJpIf5iOS7h90VQd5c4uYOTSW8+bxse5hC2VFc9Vrauyc928lZ3N9FgjcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609845; c=relaxed/simple;
	bh=ccpN4Fj2+5sfgkXH5vIPl5vdlGlW7WqYaqVJNi5FoJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJH0Fub2L7R26zrGwtQtGziMrkCRdVKunA3oEwE7Zj+0Hsjdr9JoRdowIPL7JAytYUPZluA+YJcHNRUm5B0xYkYPFOv25E9YtpGtAQoBvJ0KDu3nfpMMbhZ/YvRZjFUwsveQU5LChSfJXR+1otni0/69zFpkpIZAXm02kcUTuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVLT0Zlb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVLT0Zlb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786609843; x=1818145843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ccpN4Fj2+5sfgkXH5vIPl5vdlGlW7WqYaqVJNi5FoJs=;
  b=AVLT0ZlbHxMTNy5E8ArCRLRa01vaICWwNZ7+21hLh06fZDb1bf1cgJ+0
   qPNqrPnGzsWg0aPnZM1of+a88Vbd1IkvBlGNlRX6T8p/wRQfx0geU8xws
   K03m6FytxFL+5uc44WvpUAuRPpH+EUKdaj8Fun6c8MsKDgmNCGgEg6eUz
   89T5kAEn8C0s45XUaWI2yu+RScaRA5vaeO8sV1D+aICJN2H/dNXshxJxn
   rXD0qAwJnuzOrO6ftVBReI647FKBxl9sOfj9qj3tkQC8/tBfTrt/p7h56
   YMnb0zu1Yf5CHkcK5saLmDwVVINm6HtHEpl+mGHskDbQLnb1jN9RahK31
   w==;
X-CSE-ConnectionGUID: qaNRjoYGRi+b4tpfZvz1FA==
X-CSE-MsgGUID: ODcIZd+xQ86fPZ5XWj1dnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="74715941"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="74715941"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:30:41 -0700
X-CSE-ConnectionGUID: HBEfSfD6RiyIyWmGh/06MQ==
X-CSE-MsgGUID: pqdZdEbQQ7eAubI9Beloeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="302139464"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:30:39 -0700
Date: Thu, 13 Aug 2026 11:30:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: add shared IRQ support
Message-ID: <an2Aq-wKsIZPvJx_@ashevche-desk.local>
References: <anrwMci5d2VW56-X@ashevche-desk.local>
 <20260812044941.6f28cfb7@jic23-huawei>
 <an0jTpda_06HUZcw@fedora-1>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an0jTpda_06HUZcw@fedora-1>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 12:37:57PM +1000, Tsz Shan Chan wrote:
> On Wed, Aug 12, 2026 at 04:50:02AM +0100, Jonathan Cameron wrote:
> > On Tue, 11 Aug 2026 12:49:37 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Aug 11, 2026 at 05:07:25PM +1000, Tsz Shan Chan wrote:

> > > > Use the IRQ trigger type set by firmware instead, and fall back to
> > > > IRQF_TRIGGER_FALLING if no trigger type is specified to maintain current
> > > > behaviour.
> > > > 
> > > > Support IRQF_TRIGGER_FALLING and IRQF_TRIGGER_LOW, which match the open
> > > > drain active low interrupt output. Reject unsupported trigger types.  
> > > 
> > > Can you elaborate with the reference to datasheet if the HW support this
> > > type of IRQ? In such a case, how does HW know which type to trigger?
> 
> In the vcnl4010/vcnl4020 datasheet:
> - Page 5 (Application circuit Notes): The interrupt pin is an open drain
>   output.
> 
> In the vcnl4040/vcnl4200 datasheet:
> - Page 7 (Fig. 11 - Hardware Pin Connection Diagram) shows INT pin
>   connected to V_Pull_up with an 8.2k resistor
> - Page 13 (Interruption Section): the level of INT pin (pin 6/8) is pulled
>   low once an interrupt event has been triggered.
> 
> This confirms that the interrupt line is an open drain active low
> output, so both IRQF_TRIGGER_LOW and IRQF_TRIGGER_FALLING (on a
> dedicated unshared INT line) are both valid parent trigger type.
> The sensor doesn't know about the parent trigger type and simply
> pulls the INT line down when an event happens.

I see, so why do we even bother with the _FALLING then? Make it trigger LOW
when it's not defined and always enable sharing.

> > > > Request the interrupt with IRQF_SHARED, and return IRQ_NONE in the irq
> > > > handler when there is no interrupt pending.  

...

> I agree that edge triggers should not be shared. My goal was to support
> level triggers for shared interrupt line without silently changing the
> trigger type for other setups that do not share irq line.
> 
> In my understanding, IRQF_SHARED does not force sharing, only enables
> the capabilities. IRQF_TRIGGER_FALLING was kept for existing setups
> using dedicated irq line. IRQF_TRIGGER_LOW was added so shared lines can
> work reliably without missing interrupts.
> 
> Or would it be better to completely drop the trigger type check? Simply
> pass IRQF_SHARED | IRQF_ONESHOT and let the kernel use whatever trigger
> type the firmware configures.

You can't avoid possible regressions for the cases when firmware neglected to
set the trigger type completely.

-- 
With Best Regards,
Andy Shevchenko


