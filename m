Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D40231A41;
	Fri, 26 Jun 2026 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782468689; cv=none; b=EJRJv+tW8AkOMmjF6TPCfmY4CAxzASDbPKviMaSV1D13GurhLXnInlNKS8JR0gOU3udj0kaXDPeIhV2jIc10pkE2rG6DBayFJyBTM1TkYhsA3ft/NOSMj+EHDZSzxX1qsWZF/FYscFWSfyWNuIXfE7ONJi3tdl4WVvuu5scK0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782468689; c=relaxed/simple;
	bh=b0vr7bdoCIWFT2xGWatYmvEo/KxrViFKZCJTrdtQ8TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHpBDAKkTLK3hiGvCPmuLqgxmwXYYXVK3CqF87p/aLK9xrxNa8EIAxVxnsJEM5ODRigiM6/BdIcaK2p1OkECjAgEtXmCYusNRxQ39zSW5cMdk9Py8kVm6a2D+VmN2KphHAhq0yhACKS7L+hUDL6AQgc4rMyc/xnMDFz96ZsdcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsEBKeEq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsEBKeEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782468687; x=1814004687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b0vr7bdoCIWFT2xGWatYmvEo/KxrViFKZCJTrdtQ8TI=;
  b=jsEBKeEqhhVk0rczFO40SdJ0hi3QlBesn29CiG1TOFYtLjTep7gulQ4a
   U4kTBNGmcHo3hNjbh7QIpCCrgP7FIqLaKNSr6t02v3zi0dz6s0TaJjjor
   Ddk9Cv/eHpIU6b7dwOOyKOJb9rkJBGX8bzFkDACzaKL2dDNWhgFbc6Yyk
   X2RJxmMzLcTylEzECvtYPmLME6+Vu/zLhlJEP87NGMvBi+ljN7bjKS17j
   X7D/OSJoC7GkoX4PiQ5aNfZ0+VkzfaQnAuJWfCdQ5W0zS9PibWBylJKVk
   BEH7KD7VPbTooZL6It/aX8KCOevrAKyOR/28kHPGNjPsBJPSfyvaRRepg
   A==;
X-CSE-ConnectionGUID: QXgcl1NcRlyKlCySs88T8Q==
X-CSE-MsgGUID: /1bHjnQ3Q7iMntWUyyl7aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="87163017"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="87163017"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 03:11:26 -0700
X-CSE-ConnectionGUID: cz7qj7XfT/CjEdvkalbTaw==
X-CSE-MsgGUID: yU2MGUZsRrGZHse875TCIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="251953884"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 03:11:23 -0700
Date: Fri, 26 Jun 2026 13:11:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux <linux@analog.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: dac: ad3530r: Add support for AD3532R/AD3532
Message-ID: <aj5QSEVfazR-mTSA@ashevche-desk.local>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
 <20260615-iio-ad3532r-support-v2-4-84a0af8b83fa@analog.com>
 <ai_OeEegWavHcNF1@ashevche-desk.local>
 <PH0PR03MB7141482F87D8416DBDB90136F9EC2@PH0PR03MB7141.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB7141482F87D8416DBDB90136F9EC2@PH0PR03MB7141.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 10:06:26AM +0000, Paller, Kim Seer wrote:
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Monday, June 15, 2026 6:06 PM
> > On Mon, Jun 15, 2026 at 02:20:18PM +0800, Kim Seer Paller wrote:

...

> > > +	local_ch = chan->channel % AD3530R_CH_PER_BANK;
> > 
> > > +	reg = (chan->channel < AD3530R_CH_PER_BANK ?
> > AD3532R_OUTPUT_OPERATING_MODE_0 :
> > > +	       AD3532R_OUTPUT_OPERATING_MODE_2) +
> > > +	       local_ch / AD3530R_CH_PER_REG;
> > 
> > This is unreadable. Can you refactor it?
> 
> Would this be clearer?
> 
> unsigned int bank_base;
> 
> local_ch = chan->channel % AD3530R_CH_PER_BANK;
> bank_base = chan->channel < AD3530R_CH_PER_BANK ?
> 	    AD3532R_OUTPUT_OPERATING_MODE_0 : AD3532R_OUTPUT_OPERATING_MODE_2;
> reg = bank_base + local_ch / AD3530R_CH_PER_REG;

No. Too much voodoo arithmetics and comparisons.

> > > +	mask = AD3530R_OP_MODE_CHAN_MSK(local_ch %
> > AD3530R_CH_PER_REG);

Including this one.
I would expect to see maybe two more variables to hold
local_ch % BANK and local_ch / BANK.

-- 
With Best Regards,
Andy Shevchenko


