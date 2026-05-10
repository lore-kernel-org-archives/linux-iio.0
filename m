Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751364;
	Sun, 10 May 2026 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778417767; cv=none; b=kdnvjewD+3RrVKyNVihsOeME0EQHsKgbEOaJSH3C5fPzdvC/d5vP0nHaSzPDwqcxiC3pVnmvP9fs2UUSrg3UXZz/BWn1VqFJO7Ahy5i+0Tk45/AEPH9aXRwazEU5iIR+lGKxRBjCn0r9jSiX5tAXMQcUy1tgoutC4pVdh+xlpv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778417767; c=relaxed/simple;
	bh=Iw4FfAHa+6cEg1NpV03CZ3GwXdTx4AbQSrjOHqX9b10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADyKhWNxVkIwTAtcZJJZAEHFRhoqIU/AM2d3N+GvuTWh+5thfaZPdHcBdmPyaGNf+0VcRTK8gPNLKDwJ/hAx/vIb5SpqNTE4uQjCblsExt5djCZY3tDMz5OyaRkizMuETkfrHChbFf5OifISh4OcFpfp83C3SJU0H4h+Jas8gIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaNMB34D; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaNMB34D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778417765; x=1809953765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iw4FfAHa+6cEg1NpV03CZ3GwXdTx4AbQSrjOHqX9b10=;
  b=BaNMB34DChdgRZrlhXZb3xB0T7qowCnMIAUWeqbClQokhGn01GAnRgly
   Mt0pZHptH5SlfVFhmHEdqyc8hqM4uuKbW4KZ9zSi+sXl6KqXqZroQCj1U
   DgBdNmNTTmYvt/3xQTz4yBoPVy/jDE/XVmeo3xAKlhw/30O37SqszoFHC
   vnX3LUA6/hBJrRkocOaMpI9GVb0nHq97w1IKK7J24R1seF/XDaX2WGtAw
   D+dsukHIw0vA1a1kas5300hkkhrZfxe8OA2xMK8Lhps02K+1YeZ5dueGt
   AcyN4YGveHQMsZ4cIF5Fr9k9tLnTL7emdPdm6NqPosyz7cVzEqb2NMnwo
   g==;
X-CSE-ConnectionGUID: t5E5q3bOSzm4v0zQ2RtvxQ==
X-CSE-MsgGUID: jqJxidRDSWOo19rnK3W+BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79312019"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79312019"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:56:04 -0700
X-CSE-ConnectionGUID: UX8ZkZCxTimQwR4uJDQ/Lg==
X-CSE-MsgGUID: TxEVZnF9SlGGsH8OkJTtPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="260679621"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:56:01 -0700
Date: Sun, 10 May 2026 15:55:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	alisa.roman@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7192: replace usleep_range() with fsleep()
Message-ID: <agCAXkZkTnzK_eQe@ashevche-desk.local>
References: <20260510052401.31057-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510052401.31057-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 10:24:01AM +0500, Stepan Ionichev wrote:
> The "at least 500us" wait after serial interface reset has no specific
> upper bound. fsleep(500) expands to the same usleep_range(500, 1000)
> internally and is the kernel helper for plain "about N microseconds"
> delays.
> 
> No functional change.

...

> -	usleep_range(500, 1000); /* Wait for at least 500us */
> +	fsleep(500); /* Wait for at least 500us */

This is useless comment, I can see it from the code. Better comment to explain
"why?" and ideally with a reference to a datasheet.

-- 
With Best Regards,
Andy Shevchenko


