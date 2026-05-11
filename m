Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC842DB7A3;
	Mon, 11 May 2026 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497305; cv=none; b=kyVxwzzq3/EKvTTNPzGoozWYVZF2NFeuQAQfPYsHs8uonMq35Szg3qbNxYr0FB9K8EXjx9ELUAeKul6VQliI+AJUyXuWvrmkayamneUtB0n8Yw/PEpPjmIV7k4YNJOVZxjbUmOGuZJEpm8TTVQ4b9e3bN+BFRV3QP0dIXB0iR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497305; c=relaxed/simple;
	bh=GABsa1heAjzBDDPf78OwxpSPfhgJ0rNj52mwj3mE658=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hcjefx98oRHM1j92HKvXmnshy2rhtcPTwApBJKVqOqxV9RM6vw2ji6k2eghc3doT6xC7e3eIimUCu1L8hVRFgYLlpccP5FZ0icFIopHmUgwsiJcDlu3CC6XfvVCw86yj0KYgp5pcfWJc2/LP/knw38WpkyvMcBVRSOTJ9yQOsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgcDp7K2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgcDp7K2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778497303; x=1810033303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GABsa1heAjzBDDPf78OwxpSPfhgJ0rNj52mwj3mE658=;
  b=EgcDp7K2FV6IPKnNTpOdg3jBezfnobim5eWpqOsznWYMsUJwduZZkdi6
   h/paZnYL5+zv4SVNvRdV4AZz3GYWaxWicYdW20fPAPfxFYkwHHmH6uAXk
   zabQhTTm2bSfwOpEajkFACAodjoS84uiSIJb2NhhnZNSGTPgzvpq0rvr7
   OfAOkVp+up+jn/QKXP3RUU4puCoGILNHO3CGdR9L3YdRxkpoHDpVpWWBu
   tNTljXFit8qP8YjrdBAuc95Sy4kHubqQaZ/jOdclPnzZAm55D8EDmy/D5
   VxYzxWvZx2jwIVhXClLTcDiAOglWqRpMUir7W4UKzxfXRKPQmbV0wZxWO
   w==;
X-CSE-ConnectionGUID: 4nUv/PdASxqKgRRpEu06vg==
X-CSE-MsgGUID: GHhgWVQtR4O8k4yNl+sN7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79561435"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79561435"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:01:42 -0700
X-CSE-ConnectionGUID: z9KQr6gITeebuMWgzhWlFw==
X-CSE-MsgGUID: HEMCXRfLR1KsZNa7o7I62Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="237514359"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:01:40 -0700
Date: Mon, 11 May 2026 14:01:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] iio: light: opt3001: use macros from bits.h header
Message-ID: <agG3EdSotUAyHeI9@ashevche-desk.local>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-2-f7879dc3455c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-opt3001-cleanup-v1-2-f7879dc3455c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 12:04:07PM +0200, Joshua Crofts via B4 Relay wrote:

> Use GENMASK() and BIT() macros from bits.h header where it makes
> sense. While at it, remove unused macro.

...

>  #define OPT3001_CONFIGURATION_M_SHUTDOWN (0 << 9)
> -#define OPT3001_CONFIGURATION_M_SINGLE	(1 << 9)
> +#define OPT3001_CONFIGURATION_M_SINGLE	BIT(9)
>  #define OPT3001_CONFIGURATION_M_CONTINUOUS (2 << 9) /* also 3 << 9 */

No to this and similar changes. It's clear that this is a shifted plain value,
it's not a bitfield. If in doubt, always consult with datasheet, if there is
no such publicly available, ask driver author/maintainers of the subsystem.

(The rule of thumb, whenever you see `0 << (x)` in the group of definitions,
 the above applies.)

-- 
With Best Regards,
Andy Shevchenko


