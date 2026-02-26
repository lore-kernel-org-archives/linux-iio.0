Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADE39E6C6;
	Thu, 26 Feb 2026 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097330; cv=none; b=Wora6Zne1cMK292vKiiD8vBcjWrDy1XntDAeaqKM12MRT3/Xq/TN+ZrdbTDyx3IsGwB/LOb4Rs7mOQu5RD2YTaB+pBeMfayUJEhsUBl9edUacbirhnHNQl4848dzzPogvA/EwbX8xZGY/vcwrsyGkTnqDeyJYYS/fxpPHtCKArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097330; c=relaxed/simple;
	bh=SODohucfs/XWZ5ghq6XnVoPIJwJQO+N07jl9Qry3Ask=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcJabnEr2FsfpFzf9YVQlusMwl8Lq6dMs7u+AoZGy8TVcpy3uBT47KtajL9qUJmZGFJip712H/CVlLuQyRFA2yO9NDjltFjBPJzrfu46hD1nEGxLNgUl1pnPlIyifFrDPVdXU1McXM749wFIKkiYykWJYzW9tUWCO2OkfW7ZpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGmiCcjg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGmiCcjg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772097328; x=1803633328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SODohucfs/XWZ5ghq6XnVoPIJwJQO+N07jl9Qry3Ask=;
  b=RGmiCcjg9yoKiLOROPrWbOBOmBSgpwAcShOH0Qei4KV7wvvQuWlqWA/H
   nq1TzJHJE90KJUMd8tDCWF40BGKe6tFe9ClDe28hvpkLi+xzu0LEcOIRJ
   ZFLYaM6bfxNv4+kP0icv+Z2NyiKbXkntU0C7llX5dv0wsos1sN1RWVM1T
   i/RdCsogaLQrqd1EBbqfKUdQELrGemlO9SwBYA9VS8xGzcd9nIGESElsg
   mXXpu1ye0SciqM97Ldnhr7ObyEks27s7ZpzzSEBrHAhPy4oG+u+lTIe0K
   3a4mWybGQmwRQe4OU3BJ2cpFivW07XS8mmwfvtiNf95ARnhl9mnd5+uIy
   g==;
X-CSE-ConnectionGUID: HuvFVWplSZ6M+TPlhPVg2A==
X-CSE-MsgGUID: S2XJj0uvSdaPfWQYGBEFhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="75756031"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="75756031"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 01:15:27 -0800
X-CSE-ConnectionGUID: kSadl8LfRcqLbeETw66lfg==
X-CSE-MsgGUID: hJhdZG8zQj6glUceBSp43w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="247046055"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 01:15:24 -0800
Date: Thu, 26 Feb 2026 11:15:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: add timeout to busy-wait
 loop
Message-ID: <aaAPKiwCiGtys-P-@smile.fi.intel.com>
References: <aZ_9x4q5BZRJi3ue@smile.fi.intel.com>
 <20260226082547.69616-1-linuxoid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226082547.69616-1-linuxoid@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 26, 2026 at 08:25:47AM +0000, Ruslan Valiyev wrote:
> The ad7816_spi_read() function polls the busy GPIO pin in a tight
> loop without any timeout. If the hardware fails to deassert the
> busy signal, the kernel hangs indefinitely in an unbounded
> busy-wait.
> 
> Replace the open-coded while/cpu_relax() loop with
> read_poll_timeout_atomic() which polls every 5 us and returns
> -ETIMEDOUT after 1 ms. Per the AD7816 datasheet the maximum
> conversion time is 27 us (temperature channel), so 1 ms provides
> generous margin.
> 
> Use the atomic variant to preserve the existing busy-wait semantics
> of the original loop.
> 
> Also handle the case where gpiod_get_value() returns a negative
> error code, which the original loop would treat as busy and keep
> spinning on indefinitely.

First of all, start a new email thread for a new version of the patch.

Second, give at least 24h between the versions to have a chance being
reviewed by more people.


>  	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> +		int val;
> +
> +		ret = read_poll_timeout_atomic(gpiod_get_value, val, val <= 0,

While val <= 0 is technically correct, semantically it's harder to read,
it's better to use val < 0 || val == 0.

> +					5, 1000, false, chip->busy_pin);

This has an indentation issue now.

> +		if (val < 0)
> +			return val;
> +		if (ret)
> +			return ret;

-- 
With Best Regards,
Andy Shevchenko


