Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71DF390CBA;
	Tue, 23 Jun 2026 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243641; cv=none; b=OFBBZyq18QaI20QqHLkirCCD7XSgtO1Kml2a/RVN7FASPqmxnrr1Es1wNO7gJe76/eq3llIQW37zn2uCEnXTP3hS8t25ipnaZymYZfmmi9mGIIgXc4ryff6E2NKbXbeDf02ZVIRKOmaf1q0afl4oQMvfO/xF1xpsxQK9mTPrtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243641; c=relaxed/simple;
	bh=Ftp4hGYQdUsQfOVlCYxq2IfTSvVjZdn/meAYku+9QdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cArR1DwxQHYaS01dg6bZBdmYkklAJAx2WgSriLipl8YYpQz8LUE40aQjanSb0XADEjSfEEC6cD5JKbGEB2MfaRBZqoLgizem2rT5B4oL7Udyhr5bqMlg5qEJ+eendoDjEWGME+qZLyfRWrQqsC1khPNQtHP7gTCX4lJGxzpYhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3whJ5ts; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3whJ5ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782243641; x=1813779641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ftp4hGYQdUsQfOVlCYxq2IfTSvVjZdn/meAYku+9QdU=;
  b=N3whJ5tsli2T+4xYQZx51Tm+3XKttp22r0jiM/m93P7cgd2j4r7g//0V
   Z34zsIsYoCqPb4ZmBuAokcSDv105EIMyV0cPkSwLOgmsKvj328HIN1h0E
   jgwMd7WffL4rP9gQEr46eO/TdkgsbyWU7APOt2HzUDieFF/d+Bf1adO3F
   nFnLqzBecBSij9g1n9orSEMxZU1nIRmcJ6ipCT1psiOJAnbM8/baYQ4f8
   YEshWlQIvA9r8g44Q+9Eqz6BbNP3v1ZMFlg+71tB6bm8vXgjL92zLiwm4
   z8QjBZrwagD44b/36XnPPeNvJByuDYmJWDX43mE0TaCD2jkMJaBW8m3SE
   A==;
X-CSE-ConnectionGUID: caMSxjDaSP2Y6NdhjOLA1A==
X-CSE-MsgGUID: IKHo/cNIQ1ObbngnXWiC0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="86834146"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="86834146"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 12:40:40 -0700
X-CSE-ConnectionGUID: xAfCMTqnQSOcr5aCmn0TRw==
X-CSE-MsgGUID: 9VSOFY/mQYiufou+p97JqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="273300251"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 12:40:37 -0700
Date: Tue, 23 Jun 2026 22:40:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukas Metz <lukas.metz@gmx.net>, Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Add driver for DAC8163:
Message-ID: <ajrhM7ka4NeH9rnF@ashevche-desk.local>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <ajrR1jlkggGq_rrj@ashevche-desk.local>
 <9176e97e-c92c-4d9a-a0b3-da2e7983d9e1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9176e97e-c92c-4d9a-a0b3-da2e7983d9e1@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 01:50:27PM -0500, David Lechner wrote:
> On 6/23/26 1:35 PM, Andy Shevchenko wrote:
> > On Tue, Jun 23, 2026 at 06:07:26PM +0200, Lukas Metz wrote:
> >> This series adds an IIO driver for the Texas Instruments DAC7562, DAC7563,
> >> DAC8162, DAC8163, DAC8562, and DAC8563 dual-channel voltage-output DACs.
> >>
> >> These devices are pin-compatible 12-, 14-, and 16-bit variants sharing the
> >> same 24-bit SPI command interface. Each device provides two independently
> >> addressable output channels and includes a 2.5 V, 4 ppm/°C internal
> >> reference that can be enabled via device tree, or an external reference
> >> supplied through a regulator. The register and command structure differs
> >> from already existing drivers which makes adding a new driver a
> >> reasonable choice in my opinion.
> >>
> >> The driver supports:
> >>  - All six device variants via a shared chip info table
> >>  - DAC updates in synchronous mode
> >>  - Configurable internal or external voltage reference
> >>  - Optional LDAC GPIO which has to be asserted permanently when using
> >>    synchronous updates.
> >>  - IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_SCALE attributes per channel
> >>
> >> Datasheet (DAC8163):
> >>   https://www.ti.com/lit/gpn/dac8163
> > 
> > Why do we need a brand new driver? Do we have an existing one that may be
> > expanded to support this HW? (Note, not all existing drivers are under IIO
> > folder, some of them might be found in hwmon, input, or drivers/misc.)
> 
> I thought the statement above is clear that there are not any compatible
> drivers already. And I would not expect a DAC to have a driver in hwmon
> or input since it is an output device.

Ah, my bad, I haven't read carefully. Fair point, I see the answer is already
here.

> >> The driver was tested with a DAC8163 on a custom STM32MP157F board with
> >> external reference enabled.

-- 
With Best Regards,
Andy Shevchenko


