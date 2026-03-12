Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F040855;
	Thu, 12 Mar 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329043; cv=none; b=cDEbAmaASha9Lot/DhTlrWoKDTenPpQLegy+DClc0jRF+WlV5C/D7POD+kx4xBQg+PaWr0N63ymroikyQAtE1wnnPTBMWMJKftpcLQdw4Y8J5wmTciNMIelxxUbM0SuECZltq6/gfDAgjkGRxbVbiXGdIUMbyavyhNl+rAX2zrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329043; c=relaxed/simple;
	bh=aHTAW72ZKefmTpviiVXKSev0YQ8StKXZewiWINqaIV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o14U/NL/R1Z09Vn2m0UBsvmKnAXjkVPF+pIuevR9ys5KfAqSO9ceAyMceLed8lWCH8Bwd5crLG4b1ZofDV4rZ80sC5xMWTQqyU3afG2alwH8yPDUbhng4lCJgMh1wyF0c2scxwnp6rhZzhZRTDd2NmTeu0wsjVKou81GF+7chtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLaw6RyS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLaw6RyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773329041; x=1804865041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aHTAW72ZKefmTpviiVXKSev0YQ8StKXZewiWINqaIV8=;
  b=HLaw6RySOgRoXyzfUIAi15a/bowPWoFKiCBHc1oL8oX2MPA+zph0Jhlp
   IHQgAcxoAzkjxKcxgiZEoBYbbD/jXUAdfhd0hTQOgfpT6CsB7SVqAvWa0
   n0V7VBVTz4Br3zENV6PnSNQF8f0+iL0GpCAVocH2nJlkz7DUYkM6fie8U
   QixdpSS9FmGwzNgSBLWisnyTKhp6eeGxHzshaw4dfpFqcGq8BdYrE1a1R
   6Rn10O0sVH7+Cmio1QS2dDzZtwGGh8XCw5234cuh0EWA6+cNK0Q2VZY3o
   xRZKzhPAIZ43VrQEajcT61jrVMBgBPDPJLgW6gb7kP0pMYTftE/heRMpj
   w==;
X-CSE-ConnectionGUID: US4MpECzT9GLtHZMOukO0w==
X-CSE-MsgGUID: zQY9vFduR0S0quqfIUuqzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74303308"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74303308"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 08:24:01 -0700
X-CSE-ConnectionGUID: iakPvGO+SR+rBnwobszu1Q==
X-CSE-MsgGUID: IXkY5uTsS1WKwvwFKSLiWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="225548053"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 08:23:58 -0700
Date: Thu, 12 Mar 2026 17:23:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sirat <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <abLaiwjU2NjFiIR3@ashevche-desk.local>
References: <20260311224044.21480-1-email@sirat.me>
 <abLNbGUmaA7K0s68@ashevche-desk.local>
 <CANn+LW+F2bVMAGwoF8q9yBpF3x5r_hWDqvE3_JYjcLd16A_cEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn+LW+F2bVMAGwoF8q9yBpF3x5r_hWDqvE3_JYjcLd16A_cEA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 09:12:30PM +0600, Sirat wrote:
> On Thu, Mar 12, 2026 at 8:28 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Mar 12, 2026 at 04:40:35AM +0600, Siratul Islam wrote:

...

> > > ---
> > > Changes in v3:
> > > - Merge DT binding into existing st,vl53l0x.yaml (per Krzysztof).
> > > - Use "reset-gpios" in the binding but xshut_gpio in the driver since that's the actual pin name.
> >
> > But why is it "reset" in the bindings? If it's a power rail or enable pin, why
> > not call it as a such in the bindings? The connection on PCB level is different story.
> >
> In v2, I actually used a separate st,vl53l1x.yaml binding with
> `xshut-gpios` and a required `vdd-supply`.
> But Krzysztof pointed out that they share the same pins so the
> existing st,vl53l0x.yaml should suffice,
> using reset as the xshut pin.

> I think a choice has to be made here:
> 1. Either I use the st,vl53l0x.yaml binding with wrong pin name and
> optional vdd-supply to not break existing code.
> 2. Or use a separate binding st,vl53l1x.yaml with 1. correct pin name,
> and 2. require vdd-supply
> 
> Krzysztof, do you have a preference on how we should handle this?

I am not a DT guy, I only know (?) that the DT should describe HW.
In HW this pin seems like power enable which can roughly be considered
as reset. So from SW point of view it probably makes little to no
difference.

-- 
With Best Regards,
Andy Shevchenko


