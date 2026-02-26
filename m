Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80824392809;
	Thu, 26 Feb 2026 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092877; cv=none; b=dg57owtmHLoYNb6ncQUxEC3CdJAiPVLFi4rrEvD9OckwzdFdl4/+I8IXkLDlK+Rke6z6bXaiFoCe1Kf5nAnXUGiK2HGB3zfQMddHTAcvi34yGG5VSTSSA033sUQpzTKFCop8vW7UdmuLJW4fqApg9Merzv2Bqp7XnCWEg0sBobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092877; c=relaxed/simple;
	bh=C7wJ3xKBXtTV/XHFOkx7gf7Dnj6Ahn7IdFRqP6dUgRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCg/ZEQY1F7RC0SbXYdtpPFVoHgM2IDIDkzI60xuBDDH6PGOG//9C1xlGXf71WNcsyhOC6IgQ3TeAZ8fVaa7lhJmn7sLyFfzhCfXB4Nej0r9naXPkV2xtRoZnDBqGSGgXUi/S1FqHhgDRu3dtRfS+IuRB70GLwgA+NuGz8nhtC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+V8DOwb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+V8DOwb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772092877; x=1803628877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C7wJ3xKBXtTV/XHFOkx7gf7Dnj6Ahn7IdFRqP6dUgRQ=;
  b=E+V8DOwbiSXpDMUTMKeWDPB0ruTYKh6xSt1EE+J0vhB89x/MRusSRMaw
   VrtHlKfcwyJpLTJMDTLlhq86pdGfzaz29z3GO8bz13a4FRTt8UpmJG0gd
   4MJXfKTCWpH1soTQELdYa2EnKNuqLEPIdnE4r4twPw2r6zrbSEe10ThzO
   96MWrSCg1UzUH/n3V7PorFWCpwKZQUVbyNhc91OC753Oz+C0GxCocF8Bn
   RAgnYbmNYdZNWJFIYzlKSwqqq0K1M8BpEJxDrkGrA4KQnWqOt14n1RGDF
   KtTjb7Zm2dPNmmR9ENETw8O7R7o/zwabeB0p1DYrlpuPZq/3eyUYHgoRA
   g==;
X-CSE-ConnectionGUID: hiPEydjdTJi3G2YAKlBIQw==
X-CSE-MsgGUID: SlH/B+PyRyaPROI5XMYMJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="84602444"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="84602444"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 00:01:16 -0800
X-CSE-ConnectionGUID: tEq2Eog0Ta6cRieIkggsXw==
X-CSE-MsgGUID: uYopnubcSFW/onm9MOYlIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="221471129"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 00:01:14 -0800
Date: Thu, 26 Feb 2026 10:01:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7816: add timeout to busy-wait loop
Message-ID: <aZ_9x4q5BZRJi3ue@smile.fi.intel.com>
References: <20260226052615.65734-1-linuxoid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226052615.65734-1-linuxoid@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 26, 2026 at 05:26:15AM +0000, Ruslan Valiyev wrote:
> The ad7816_spi_read() function polls the busy GPIO pin in a tight
> loop without any timeout. If the hardware fails to deassert the
> busy signal, the kernel hangs indefinitely in an unbounded
> busy-wait.
> 
> Replace the open-coded while/cpu_relax() loop with
> read_poll_timeout() which polls every 5 us and returns -ETIMEDOUT
> after 1 ms. Per the AD7816 datasheet the maximum conversion time
> is 27 us (temperature channel), so 1 ms provides generous margin.
> 
> Also handle the case where gpiod_get_value() returns a negative
> error code, which the original loop silently treated as not-busy.

...

> -		while (gpiod_get_value(chip->busy_pin))
> -			cpu_relax();
> +		int val;
> +
> +		ret = read_poll_timeout(gpiod_get_value, val, val <= 0,
> +					5, 1000, false, chip->busy_pin);
> +		if (val < 0)
> +			return val;
> +		if (ret)
> +			return ret;

Have you able to test this?

Have you investigated the code? It was an atomic, now it's sleeping.
This is a huge behavioural change. See my first Q.

-- 
With Best Regards,
Andy Shevchenko


