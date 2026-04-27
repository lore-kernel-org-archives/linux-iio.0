Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338D3B6C16
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283948; cv=none; b=Dl4YjdRPaxWbhT+Paw9d5UWmicz8x3KAx5+CRgScDRcJG0y1JNrrIl4reH8Jb8ZGxBpxftKI7eLTkyHVK+ZgHUE2OELRR4oFYSJmOdlE5fDPDx5XAXgQqu0Q85wYQTfamNrzJrXRFmSqknE4w0NQTM/5t34yFnA9eF7gGOUMqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283948; c=relaxed/simple;
	bh=mn4cjarikRtny3FJMZFSoB4LrzsPQzAV548uIkJF+HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwLBmQHLzLUWdQUKuYuf9uYnIhf8NHv5+9Shnt2ejNTuJDjnGrNXoltuq89NnsrH2sbmkHfBbR0fNRQ8ZxFPb7CTGSwj6gAyKAS8b7kAawhjK+VPb6ILVDXNCcGC+hbOYB1LdqtBDeYUOMI3ok9cVvSaLDgM505aIOqxBgv9Lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aujlQ+7e; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aujlQ+7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777283947; x=1808819947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mn4cjarikRtny3FJMZFSoB4LrzsPQzAV548uIkJF+HM=;
  b=aujlQ+7eFIfNXbXEhkDgZouPkpyfWYKemJbh9qHcnX44/jWC64MQENFI
   +v2XXb3wKu81LBYTLaGYAol+L+R7R1wZsO5o9EI5VRsAjl4hJxXcaWB5X
   z58s8jrSnbSjNwXUAsdF1Gaf1h7F/uyu/3CtvaQwBVW7D0B2Zj31BaN2V
   bXLhJA9sOLl3UVCvQqCRFZe3zoK68qC60jLAw7DFhRv6tMrUd7jMVz9/a
   4Zwgp5UWx/X3DqelogNpmOGHCeFnURTLJ/04VM7yYKnOdHzQN4wMWgu+l
   QY3WKBtPbGIAUNrL3F9d4Scdu/KP8JptLz0Pr1p2rk+itG4uifoE568is
   w==;
X-CSE-ConnectionGUID: Ub3vU3ufRLaiS2JQuTUA9A==
X-CSE-MsgGUID: WXLZAmw9SVy4jdggOrixNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88481103"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88481103"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:59:06 -0700
X-CSE-ConnectionGUID: T/jc5r4fTByTlTQst1Rl6g==
X-CSE-MsgGUID: FMW/KOI1S1KR8QDuxVCqXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="229268558"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:59:03 -0700
Date: Mon, 27 Apr 2026 12:59:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Caio Morais <caiomorais@usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	michal.simek@amd.com, nuno.sa@analog.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: buffer: industrialio-triggered-buffer: fix
 includes with IWYU
Message-ID: <ae8zZU5WR8umynef@ashevche-desk.local>
References: <20260426211834.3318306-1-caiomorais@usp.br>
 <20260426211834.3318306-3-caiomorais@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426211834.3318306-3-caiomorais@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 06:18:01PM -0300, Caio Morais wrote:

...

> -#include <linux/kernel.h>
> -#include <linux/export.h>
> +#include <linux/errno.h>

> +#include <linux/linkage.h>

Hmm... This one rarely appears in the drivers. What do we get from it here?

>  #include <linux/module.h>
> +#include <linux/stddef.h>

This one for NULL, for example, which is fine.

-- 
With Best Regards,
Andy Shevchenko


