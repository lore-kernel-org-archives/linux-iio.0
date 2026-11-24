Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541173;
	b=OTevO35PhraOei9mr6PYaP0S6tKB0FiVXjqZqUMiXhVqbddbP45lsc7krm8v8P1tZWf8
	 f2/N6I9Iz7ZQFEV1qWefJe89K2b1bLRXrPScIySrXOBXswN/JxiUBwcg5b+C8xAhBBedG
	 3PkvKQluJn3dprXmAJNqx1By1FW6fQOkrGmK9skA6XhshK2KInhFJ1bU4u1SoyfRntvtH
	 OFO/eDJjpFXn6LlU59Z1tRZfo13l+xX7FDMtcAy4IZP8YL7etC/hOxa/MLSSolskVg6+G
	 3FfH1YbIbXP20HvLpPuEQ1vTVOhAAM8Wc+XyTZ/oyMeHzL0+we1Z5DBu8RIlB1njnuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541173;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6VZrzcsQi8k3zpdbfofVMybmQDhK3GqBlZKfamS3780=;
	b=UG7Vu4sIF8iNE9KtjZNiwOdNNGqgQFtYHHcxqSDqUz0qshojpXazr7AOU71Rr583pYuM
	 Gkdku135Nok83BrKaizpETqQX1m9FJGP06jK9RLYW3ZCrGaQT79Q63qVpT0Ss1vciKBvI
	 ZE08nozqGHqlFqzKNvWSMS3nJFltT4CdN6ylKIh8qhwRc0mdmjsena+CFUFlof8bEzQ08
	 c/qnIXmJcBGB0dgzstTDuTHfOEhYUXKp9kBSzeoX//jTJSFh1MZnRZwKYIyDShBYsie81
	 3zmk3kHGQ7SkJk2601x95c18P+GePBxLU8WdD8LCEeVQ3p5W4N14pmbIRLOHP6ZxkVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jiekmIRP;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA2606A332;
	Tue, 24 Nov 2026 17:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27FA2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jiekmIRP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795541173; x=1827077173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SzT0csSgnqvDnoV3RleMeqvxldVFfB4PdCbmLd/qpxc=;
  b=jiekmIRPvdaD0DuN7/76CVDFb3UBCqyn47WV+bTHiN8o/ceUGe/r0H8l
   GyX5l1c39sZ/zr4OY7+RqmmanVSlSiWEBVDZW0bEGZ9bxzzeoSUvMbcW3
   xzpm/ML0s8SZDijLilERgCJLe+Elf6GmopP6XFymNtKeFqtsgoU9kyaTg
   uFZF8obo4S+liWFG2guPxu0HCtoL47/rIqJEWS7a8HUUeW1O4IHUdE8hj
   uMqp62/UY3Wd7C/QW47sSlhPsK/phSCBcQyjkmsqWvUYjRMthwsuFBez9
   Lq62aKQTEw+zMLfNmXoo10ALc87nttbi2lc3t5K0Rx5NIxtAgP1Fyyq+1
   Q==;
X-CSE-ConnectionGUID: GI5PixiRSl+5nYAm9AeoGQ==
X-CSE-MsgGUID: qi+2SmJISraCRkeOx6VQXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4289538"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4289538"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:24:11 -0800
X-CSE-ConnectionGUID: UfVXggqrSuWpspkfSqBQIw==
X-CSE-MsgGUID: rIT4lxKyQdyAT/3W9GUPrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12034050"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:24:07 -0800
Date: Tue, 24 Nov 2026 19:24:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Nagavarapu, Dileep Kumar" <dnagavar@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 12/16] iio: adc: xilinx-xadc: Refine Zynq read/write
 error handling on timeout/interrupt
Message-ID: <awXINQWDns96Ngwi@ashevche-desk.local>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-13-dileepkumar.nagavarapu@amd.com>
 <avNEpH6KGJkeI7dX@ashevche-desk.local>
 <c3a7df9c-e337-47ac-9a6d-6bb81177affa@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3a7df9c-e337-47ac-9a6d-6bb81177affa@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 10:24:59PM +0530, Nagavarapu, Dileep Kumar wrote:
> On 11/10/2026 9:51 PM, Andy Shevchenko wrote:
> > On Tue, Nov 10, 2026 at 10:31:57AM +0530, Dileep Kumar Nagavarapu wrote:

...

> > >        ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
> > > -     if (ret == 0)
> > > -             ret = -EIO;
> > > -     else
> > > -             ret = 0;
> > > 
> > >        xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
> > > 
> > > -     return ret;
> > > +     if (ret == 0)
> > > +             return -ETIMEDOUT;
> > > +
> > > +     if (ret < 0)
> > > +             return ret;
> > 
> > First check for generic errors, then for exclusive conditions ( == 0).
> > 
> > > +     return 0;

...

> > >        ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
> > >        if (ret == 0)
> > > -             ret = -EIO;
> > > +             return -ETIMEDOUT;
> > > +
> > >        if (ret < 0)
> > >                return ret;
> > 
> > Ditto.
> 
> This patch does not fix any behavioural issue; it only changes the
> error codes.

Yes, it changes potential behaviour of the callers (which probably none) but my
comment is tighten to the code that is being changed.

> Sashiko suggested adding a Fixes tag. Is it OK to ignore this comment, or do
> you have any other suggestions?

If comment is okay to ignore it would mean the comment has no value. I don't
think so. Otherwise, please justify that.

-- 
With Best Regards,
Andy Shevchenko


