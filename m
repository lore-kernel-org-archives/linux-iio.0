Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8830C161;
	Thu, 15 Oct 2026 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071485; cv=none; b=fFR8R9xifgOQyeglVSJ7Qik+UKZYMAwHByGtpWmHNuaTGFRO5JobvCXE3T57c6+TVQer/Agxt4kV+gJuT1WNEGcqpspTdPWMCy41zPugAW2eElF5EJ7Q6cgbAxMn7PEy27xo77+fo+EjVebdB2ULMtXgc/I/zPMCn6rQGLt3uik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071485; c=relaxed/simple;
	bh=2bSX/afT8upvE6f0z7KxsTDZDnKrXrn1LCc3xDdR6z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpycwMP8a5YpvsjvJ/XcixCfcpk1rT+16UFchP+1yIl0oAHmtzMuMXQ1qRBe5A63brkfSrCU/wPIbr+SeYyhVT1yIbH1Fp4qM1IpBH90InAZSUimT1DmPeZWbXWJy594u5ltbZg9k5ayX1H92niTbpv9uSvJsW8DDKLx766oOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oH/j6Ajn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oH/j6Ajn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792071484; x=1823607484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2bSX/afT8upvE6f0z7KxsTDZDnKrXrn1LCc3xDdR6z8=;
  b=oH/j6AjnkMfuf428L6bWzgGgATBh2Y6KVgJTDcq2+7qT6MlddQK54wqG
   4GyTIltNYk9hjx8GudASLnlaXDLBB5mNSLnDep3hRMfgV932RL5MnaAYi
   pvy7LeYT3WIVwHFjIlC8IR+j0PyJWheWVvuXcSjgCviYR26hRmZQ920oo
   uJWBZI8ih+DmgII0+XtPBp8tOi9yZRHcgA/BX0sDlkPmSJbX4g4yIIgCt
   REn6+H7XPURELcBfzq1LdPD/YSgwuhHUpvHkbq+Co4QtGJ6jfdwkqygH2
   wgMf7XC17MJ6iyFCPTf4Mylk1XrHHa0TaJJHh7blO0pEYGmPusjIPGL7f
   Q==;
X-CSE-ConnectionGUID: 8vrAMCqfTyC16QzEw2mzKg==
X-CSE-MsgGUID: BuqXa2fPRO+Vy2akWSTqZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="740468"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="740468"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 06:38:04 -0700
X-CSE-ConnectionGUID: gx8g/HnUSzG/hP/PFgGokw==
X-CSE-MsgGUID: ILk8Ge9rR+CiOhACODXXLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2051168"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 06:38:01 -0700
Date: Thu, 15 Oct 2026 16:37:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
	Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add gpio support
Message-ID: <atDXNlsDIAzOpgFg@ashevche-desk.local>
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
 <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
 <CAMRc=Mfn7+uQYvLjGLxU9wMOnRwx5pyPgaLp6oNx+ZcFXyXL=A@mail.gmail.com>
 <cde9d00a-bfe4-4093-b03d-f76a122e4ded@baylibre.com>
 <as46xFp-3fXvWPlm@ashevche-desk.local>
 <ca27a15c-5b21-4381-a82f-e80bb0ae488a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca27a15c-5b21-4381-a82f-e80bb0ae488a@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 08:01:14AM -0500, David Lechner wrote:
> On 10/13/26 9:05 AM, Andy Shevchenko wrote:
> > On Sat, Oct 10, 2026 at 08:46:30AM -0500, David Lechner wrote:
> >> On 10/10/26 4:00 AM, Bartosz Golaszewski wrote:
> >>> On Sat, 10 Oct 2026 01:25:52 +0200, "David Lechner (TI)"
> >>> <dlechner@baylibre.com> said:

...

> >>>> +	if (device_property_read_bool(dev, "gpio-controller")) {
> >>>
> >>> I think the right one to use is device_property_present().
> >>
> >> I thought this was the one case where device_property_read_bool() is
> >> actually correct because gpio-controller property is a
> >> /schemas/types.yaml#/definitions/flag.
> >>
> >> Otherwise, we should just remove device_property_read_bool() from the tree
> >> because there would never be a reason to use it.
> >>
> >> My understanding is we should use device_property_present() for non-boolean
> >> properties when we want to know if it is present or not before reading the
> >> value of it.
> > 
> > That's not true. The _property_present() checks any type of property, while
> > _property_read_bool() returns an actual value of the flag, while they might
> > overlap in the behaviour, they are semantically completely different.
> 
> That is exactly what I said.

But you made a code different. As I read it it checks for "is the
gpio-controller property present?" For the question that you may
think off "is the gpio-controller flag is true?" I consider rather
if-else branch as we *either* option.

So, when we do

	if (...check_flag...)
		do_smth();

I assume we check the presence of the property (flag). If we do

	x = ...read_flag...;

OR

	if (...read_flag... == true)
		do_smth();
	else
		do_smth_else();

I consider the appropriate is reading the property.

-- 
With Best Regards,
Andy Shevchenko


