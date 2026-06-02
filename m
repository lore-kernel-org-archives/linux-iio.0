Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032441DF73C;
	Tue,  2 Jun 2026 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429392; cv=none; b=mhhiRBS/5wfJRey8u95cWq1AMF2wV4IpmF5sEaIS7iE+4MjgUBgOzogWOVxcTGCEdJkgaqj+9XsplC86TaXeL9L9Ikp7IDQxCVzprvttkoTgA3Kd9/UiL45eUZyxQ173CTfoG2TbfkuVWmX0Tqb3dxYUpicbbviPjZTvT21NSYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429392; c=relaxed/simple;
	bh=gMr1z32Fe9bVRotM8G9d9TWLVOlwDGCHucb/wxnUKM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2yq1hla4rw9TMauHijLXc8yKMr8aeKDi6G7Snr5n8cmrv+fpN2cAgtRvM4v8+zrBPpMA3mFO/UAivegB1onumzGWNYLfNv/XAiIAhJZedTatmf+5KP4BTXTDPg2ZISVf7LFsu9FcPMnzz9fP7DQvd+D2sN03p8JwXwXvBhOX9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hn99b9IT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hn99b9IT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780429391; x=1811965391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gMr1z32Fe9bVRotM8G9d9TWLVOlwDGCHucb/wxnUKM0=;
  b=Hn99b9ITzX0ObLjo5WozsW6o9ppzYWABGwLdywzUjQzIKTk+DhRtMbnJ
   IkvTZWwsdhT8wq30x3FK+3iyvtxWkgUypluBVjsLLBO0VuN6/Uh3whSwX
   a8VPJi3w8acFp3l6ptO6BzkyB2Yf6C8e3Me6/20AL/tV+VRyk6xvO+uGG
   y4cEQ+B2cOlwqFlEnWjTZWDpZyngnafcR4WftLXT7uRnzTp/ba5Rf13KD
   wW/tXA8kL3uBQp2I1Luy00815yFWGBpmk3G/P/GvD0jQwxUlw2eWyJtIp
   V8UG/difCz/ALDzgeeOE/9d1LjP1Pb0KRIPiRM9zlFJxAYEMRMCe1zGO5
   g==;
X-CSE-ConnectionGUID: d7w8yqpoQkWXOTTkJ8NPAA==
X-CSE-MsgGUID: mhdcstt9Sr+BWBNnj8A8kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92712200"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="92712200"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:43:10 -0700
X-CSE-ConnectionGUID: dHMUEn4ITCSkBb4SIKHeaw==
X-CSE-MsgGUID: D6zO8JWPTAy8dvwBtEzkoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="244107628"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:43:06 -0700
Date: Tue, 2 Jun 2026 22:43:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH v15 02/12] lib: kstrtox: add local
 _parse_integer_limit_init() helper
Message-ID: <ah8yR3Os8NDNll27@ashevche-desk.local>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
 <20260531-adf41513-iio-driver-v15-2-da09adf1c0dd@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-adf41513-iio-driver-v15-2-da09adf1c0dd@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 31, 2026 at 09:30:45AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add parsing helper that accepts an initial value for the accumulated
> result when parsing an 64-bit integer. It reuses current implementation
> for _parse_integer_limit(), which now consumes the new function with
> init = 0. The diff algorithm would have the documentation header and
> prototype of _parse_integer_limit() moved around so it is adjusted
> according to guidelines.

...

> +static unsigned int _parse_integer_limit_init(const char *s, unsigned int base,
> +					      unsigned long long init,

Why not name it res...

> +					      unsigned long long *p,
> +					      size_t max_chars)
>  {
>  	unsigned long long res;

...and drop this one...

>  	unsigned int rv;
>  
> -	res = 0;
> +	res = init;

...and this one?

-- 
With Best Regards,
Andy Shevchenko


