Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7A261B9B;
	Sun, 10 May 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778403325; cv=none; b=Wsg31Z+/ygrDARnuEhasvb1LyaCRw+XPDbM1vfPHFAXaZfO/MnOT4T7yvBGx/1DAyae7Vl9lUDP3jaKdvhlw+IrfTPmqcu+ckhRT4GlDQ7+zVgoJj2+K+pK3FXiqNrrrl2g5dMZy8XBD2EOA1mgTySHkzgFsv/DwT+PGEZmkGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778403325; c=relaxed/simple;
	bh=36Z7bxNOr5LYjGHRIBEi05z8Vj5i2Y6FnZM3GRbXfAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsi3IrdVco628VlFJjdIXPqKcj7YPO8shY5/kyblgciU89PXkctzAuPQkvANFhPwklEoS9K35EAYNCUai/hZEvb5dPYkifmXGiEZU24wTOchd66DlQLQ85hzaj6AdRyNSdPFgvFHwdoe9dfMaP3pmANCnqaVqUUdbyv4yyhq69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1lzs/E5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1lzs/E5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778403323; x=1809939323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=36Z7bxNOr5LYjGHRIBEi05z8Vj5i2Y6FnZM3GRbXfAs=;
  b=L1lzs/E5BY9DSsmaW18M5+bQNENjB1jtlg9eOmxAxe36DAz8vGRLax4Y
   nzZ8FeFYCTXydTDQsggn40dU+lOg6ZD2SPKLp5/XMEl0vnviU1+PPeGD1
   eDcjqJvpbnHWcdROtWvcf/RyBb3ifoJ0sAnZp6XxNaPUM8ac4mXJik7l9
   9rGYDU4b4i/Z/KTrYFIo4ktyEdkFcvGUNzE2CC224Lqc46ii479Fn6yZ3
   pK8GN0Cp0+cgeYdYaUYjPgRpM65AlKezuCHIR+uI1FI9epNMv5+VZlOn0
   B1Uof7YqOj7C3jTgJ6ffWzD9OoOOxdvJrVBmsPixQEO9If+OYy7Iq/86c
   A==;
X-CSE-ConnectionGUID: BRYetLzkRXybsdrVStD7Ng==
X-CSE-MsgGUID: 70fRYAPtTYuysu7XROVqbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="104776540"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="104776540"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 01:55:22 -0700
X-CSE-ConnectionGUID: 5X9rqS4RS/iUrg1ZGL38Og==
X-CSE-MsgGUID: 9w2URnD+R/eGMVCcmAi2dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="242145801"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 01:55:19 -0700
Date: Sun, 10 May 2026 11:55:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: addac: adt7316: document SPI interface
 switching sequence
Message-ID: <agBH9QqHW-cJN0iQ@ashevche-desk.local>
References: <20260510081041.85880-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510081041.85880-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 08:10:41AM +0000, Hungyu Lin wrote:
> The device powers up in I2C mode. Switching to SPI mode
> requires sending a sequence of SPI writes as described in
> the datasheet.
> 
> During this sequence, the device may still be in I2C mode,
> so SPI transactions may not be recognized and can fail.
> Such errors are expected and are ignored.
> 
> Add a comment to clarify this behavior.

...

> Changes in v2:
> - Add datasheet reference

This is still odd. Please, put in a format

	$SNUM "$STITLE"

where $SNUM is the section number (like 2.1.4) and "$STITLE" as currently done
in this version, Ideally the datasheet also needs a versioning.

...

With that being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


