Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EC36D4F3;
	Thu,  4 Jun 2026 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601522; cv=none; b=SCmUDIe5Z5BemlY+lcGbtyCH0au1ADCTlwtSmLbcMkyjj1I15Zxg92E22rnacIa25YCwNsvyt1uoXfouVuEUfgf9vEmeXo7p9tw/HtjlOpGR9i8gcrJRAfpB87S2dnGFS0Vg810yLN+/bbTATZEkVcesM7Gb4owm4Fpy7s4e/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601522; c=relaxed/simple;
	bh=iMMAQvPxNEWlnkLuJvQOuzv1ru/2NJCbJjNi+ji5mg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f50EH5JbG9l5WBzG/UWYnfzKySPVxdVQOeRRw/QPnc7Xhnuho3+jijG602xwWY9VpnB+7w0P0gb1ud2VTkyaL2uJ/W9sTVp/pC5rKdxbvswS9F7HEeUA4bovsyygTtphlS/LBfp/BOTpsjhN5A5potGg2ChxCiI/hn5Zl2syo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klPFdHxm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klPFdHxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780601520; x=1812137520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iMMAQvPxNEWlnkLuJvQOuzv1ru/2NJCbJjNi+ji5mg4=;
  b=klPFdHxmOZJ1U5y7JAfzH+Q9sNJJJdosoCWpQeX/xd1F6QAJWx+OZDrD
   3qvckc34Bzbd5jo5W/3mEzf1IQXUFdk5qHdTRlQJkQzcZWjUzwIOdKBdR
   P9vqTW0fkjCo85Q+92HPr+QDWKRRNjMInSDBfXwa0GeKaj+dEIZagxVdI
   mczlechI9qcFbLCHdmZgQia9sc2RT1pQCfiCYwJrCXwGN+V28XRngAsrQ
   7+PgTPkVUh8kq/jSSmPMiIAnpKPAgPUPRp/Bc1txo+bIBnDzxS5XBd5ao
   oqACQitmpoY55P4Yn+0UCKghKZGVS4TXFOhR5QuY7wGio0aq1W0vqYVG2
   Q==;
X-CSE-ConnectionGUID: LljzOLwvQYCJ4++8SD6+zQ==
X-CSE-MsgGUID: O9IxYB08QGi59dclARR1yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81560043"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81560043"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:31:59 -0700
X-CSE-ConnectionGUID: 1hRLyh+7S+Gonhwv4Nkz8w==
X-CSE-MsgGUID: tjoiB2CtSnW7l+hmVdDyrA==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:31:55 -0700
Date: Thu, 4 Jun 2026 22:31:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux@analog.com, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v16 04/14] lib: kstrtox: add initial value to
 _parse_integer_limit()
Message-ID: <aiHSqI_lL4s9s9_w@ashevche-desk.local>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
 <20260604-adf41513-iio-driver-v16-4-1a7d09143bc2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adf41513-iio-driver-v16-4-1a7d09143bc2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 10:58:58AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add init parameter to _parse_integer_limit() that defines an initial
> value for the accumulated result when parsing an 64-bit integer. The
> new function prototype is adjusted so that the _parse_integer() macros
> stay consistent allowing for one more argument, which defaults to 0.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


