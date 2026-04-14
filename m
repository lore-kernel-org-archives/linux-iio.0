Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620F258EE9;
	Tue, 14 Apr 2026 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776184272; cv=none; b=Vm6rDZfQGAIJRl/mPo51YzLcgaUwLuBTkQ0tme8j3xH58Pk/Mcg4u7+Mw0l/iEnIIN399GNGgPNpH3kA1u+Ao0IHoXFDhynaS4thQFfksCKFoOCb81DeH4I/KwQeWAeNiFHocjAgRMR6wr2BEmlyI4eZO/9BPzroweBmnZjRv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776184272; c=relaxed/simple;
	bh=rjrXG/fVyY6byz0kt1CWhNqhaRn96R9C0pVAAtPPUVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce0YI8GSdpD+GRXt1NS/pPwNpdBuuw0RU+m0zz9KWmOugvkg4B3AVabyLqG8ou/sNejerm3HM4e+w1F4M2dhmbS3B97H0vIYzvOq+xaARvERv4H6sJ5PkTsl9FrRr8CDgrepUuiaHQSRbgoXrWQejA6PYQDRaFyY7ekIBEgmTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOMirWGD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOMirWGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776184271; x=1807720271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjrXG/fVyY6byz0kt1CWhNqhaRn96R9C0pVAAtPPUVU=;
  b=JOMirWGDe7xJMRNAcn8k2GfEtLh5eErzdXSeL78RY2Ks3XZxpD0UWfK/
   2zWJHj64Vk+Zn6kutxg0C+HSI4hF8l191DQtH6dGOhm1/i/pNz3ujem5m
   PmIY4ov3eMsAGi8tWIm5xsu+jMFPKGHd/m0LgWAr7pLLATSAsh73zVdKL
   egV4uXZXV8Y8xQ5OQGwpEnhl9bds7eEPSWkSsPAEzZG/iUHVRtZuNZm+T
   9dcxbRHADvyhrSir6m/Tv1UkSe5UtEINUN3sLBxXt0+5XJ6DFKGn3Gg8I
   Dd8GhhJQWDOP4kNnHplOvAaAS68WQHX2TwyObhtE9q4nE9YokgChsB2hw
   w==;
X-CSE-ConnectionGUID: ecRuRvZPRkOsNGD25coo/g==
X-CSE-MsgGUID: 4a+yRhbuQbSitpcEOPmiBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="81011781"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="81011781"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:31:11 -0700
X-CSE-ConnectionGUID: CO1JMd6SQNGxj5tg4k+akg==
X-CSE-MsgGUID: iBZSd8JMQyuyeHBeMdOAsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234185885"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:31:10 -0700
Date: Tue, 14 Apr 2026 19:31:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: use spi_optimize_message()
Message-ID: <ad5ry4i6OPOS156E@ashevche-desk.local>
References: <20260411-iio-adc-ti-ads7950-spi-optimize-msg-v1-1-617766ef2e38@baylibre.com>
 <ad4OywqHDC7aYapD@ashevche-desk.local>
 <d14d23df-0fad-4b87-8e57-67241b29fc30@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14d23df-0fad-4b87-8e57-67241b29fc30@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 08:29:29AM -0500, David Lechner wrote:
> On 4/14/26 4:54 AM, Andy Shevchenko wrote:
> > On Sat, Apr 11, 2026 at 05:13:33PM -0500, David Lechner wrote:
> >> Use spi_optimize_message() to reduce CPU usage during buffered reads.
> >>
> >> On hardware with support for SPI_CS_WORD, this reduced the CPU usage
> >> of the threaded interrupt by about 5%. On hardware without support, this
> >> should reduce CPU usage even more since it won't have to split the SPI
> >> transfers each time the interrupt handler is called.
> >>
> >> The update_scan_mode callback hand to be moved to the buffer preenable
> 
> s/hand/had/
> 
> >> callback since the SPI transfer mode can't be changed after
> >> spi_optimize_message() has been called. (The buffer postenable callback
> >> can't be used because it happens after the trigger is enabled, so the
> >> SPI message needs to be optimized before that.)
> >>
> >> The indent of ti_ads7950_read_raw is changed since there is no longer
> >> anything else in the struct to align with since we removed
> >> ti_ads7950_update_scan_mode.
> > 
> > Some of the func() are mentioned w/o parentheses and I got lost which one is
> > which. Also callbacks usually mentioned as .callback() (with a leading dot).
> 
> I didn't put () in the last paragraph because I was talking about the function
> pointer, not the function. I guess I missed update_scan_mode() though.

Then probably spell it as "pointer to func()" ?

> > The second paragraph doesn't tell me clearly if there is a behaviour change
> > from user perspective.
> 
> It is not clear that the difference the user can notice is that there are
> some CPU cycles freed up for other tasks?

He-he :-)

I asked more about possible behaviour changes in ABI (note, that [significant]
delays moved around might affect ABI if some user's program times out due to
that). But I think it's not the case here.

-- 
With Best Regards,
Andy Shevchenko


