Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04E3B7767;
	Thu, 26 Mar 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514164; cv=none; b=SyH/jvOd0PDaBMeBMduGI1Sp3pNGq6lhkVlCmQG/xAa5s0afqvyH8PDtjg1g7ifcK7LrFZO2aaLUejLQQeSMyMBpcI3YqZZ3dA6U26QUSuXq9mcf8pa+ijj9nY6ZgqpyNKBJBerKzuCxmn0WJE0v7dsKNNDWez8bFrJEylzAQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514164; c=relaxed/simple;
	bh=tw0hkbX7T+R4yf6F39ZSAKLfdvx8h74vIHmlYTacV2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rif+2CERZIqlcQr7iH0VQlnhlxwaYiSTCkACHkARiZEuNN9w+Tbp3ZL4OHTCE1DcR+30W8CxGUv6K3tRzon9NzU7rM1FB5z3H7EsIPrRGyrQytMbFsw6Q8onyVYuBtbjAdzo+EF/8dHXHFvTNGMqA0+3MyGyDDxiDY/XKTaYNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIj43aCO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIj43aCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514163; x=1806050163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tw0hkbX7T+R4yf6F39ZSAKLfdvx8h74vIHmlYTacV2I=;
  b=MIj43aCO1vRAAmm4qOHzd1QzRsbvkKILe8IsKstOJmTubkO5Bo26K/kC
   wVlrMGETrUuZzMbpskLql5cDwQPFSSPHtGOFfhqKZnMiK30Zez54NUoG1
   yygMa9HNZSY1zPmroJD3XrTvY9kY+rRoGgM3PX20Eb1HFg+3mRyCQ4zLL
   6GczjSPip8k4cZ+ANPjcAYM1Y0UMu/EmAKH8MKRHIixoDszr7YeH5o7LA
   C96sXIUvcEkH4Fc7POW/Tp9TRXRJL1KBs6dw3TEafhHggFqvibOWflMO0
   uWoawWnBp81xWIih7pmS7+fjZxDCUCkl4u0sjjX4axEOMWe3AHKqLamk0
   g==;
X-CSE-ConnectionGUID: GoQ7GIdJRD+WuFX/yJgVcA==
X-CSE-MsgGUID: 1mMobJJ7SLyJxe39QnWOTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87041274"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87041274"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:36:02 -0700
X-CSE-ConnectionGUID: 4kgQWgZISwO7qyYkhdpZDA==
X-CSE-MsgGUID: bncX8UGESIyL6btUwhrGAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224123654"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:35:58 -0700
Date: Thu, 26 Mar 2026 10:35:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kyle Hsieh <kylehsieh1995@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] iio: adc: ltc2309: add support driver for ltc2305
Message-ID: <acTv64TrwxQlpp3F@ashevche-desk.local>
References: <20260325-add_ltc2305_driver-v5-0-e0d29daa54f9@gmail.com>
 <20260325195035.26214c91@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325195035.26214c91@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 07:50:35PM +0000, Jonathan Cameron wrote:
> On Wed, 25 Mar 2026 10:24:19 +0800
> Kyle Hsieh <kylehsieh1995@gmail.com> wrote:
> 
> > The series add support for ltc2305 controller from 
> > Linear Technology Corporation(lltc).
> > This is low noise, low power, 2 channels 12-bit successive
> > approximation ADCs.
> > 
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> Applied to the togreg branch of iio.git.

With this version I also noticed a clash, but I forgot to reply yesterday...
TBH, I prefer the approach in the other series. But this can also do it
by splitting the chip_info introduction to the separate change.

Anyway, if it's applied, in the case of _this_ work it's not a big deal as
the result looks sane.

> To hussle things along a touch I skipped the normal pushing
> it out as testing first (what could possibly go wrong ;)

-- 
With Best Regards,
Andy Shevchenko


