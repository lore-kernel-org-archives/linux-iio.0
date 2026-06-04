Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A5384CC4;
	Thu,  4 Jun 2026 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601669; cv=none; b=rrPdrIsDsd0GbIAxaWE1ifnvQ411yL95W3j9EQpdOZ9pIvFSe6dDMy3gZIXejbSncs7zt2XJn1Q8AqvoR+csbugUFVm7HTIOLzPGflnjcViNLpsN5Nhj9xF5fD/TLfxiO6SM7sKl47WVlG1fJCHMLUUb1wNpbpxGj/+V03E9PkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601669; c=relaxed/simple;
	bh=12DkrUFEEAAtOum6+3gFzi79Ed1Qv0TIjS/Hzgl1lm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2Lpj4w3DRQoVbUqxSrGKpO1iPtSe1iTBporgQmrj3S+lub9EWfHY9RkHJKUwXvcnhxK4pZiaFpbacMMYOfTpCcR5q+JSL4myBxplaPIyK7oxcilbPUpkJwN7WVPdhiHGtjEQynRnRg30VaMOYf/5ZZdlLX/zMZd4B24XkgF9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMHoEVth; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMHoEVth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780601668; x=1812137668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=12DkrUFEEAAtOum6+3gFzi79Ed1Qv0TIjS/Hzgl1lm4=;
  b=IMHoEVth7USEmMr6PQ9Wvv6TroefSWoOCUHI0i8cVsTpH23PrOVGx5aS
   Kgz6VCAOnjbjApxORU0PsXzyn0DH4Pn8E4RG2pBYUbE6odT72oJOURAIr
   2gOmMIaUgvOPAIkGJnhPrpD+hWz8T1K7P0zCcLVJRH5mNw0NpAES7uLt5
   Y1vVgfrZlwmNEwQY9AUzlboC7okVJmb6w6G4LuqntjDsYQGzPLM7HabWl
   vpptytJLZZ54WlHVa7jiGVc1qXR+8zuYfJhZNOI0ZXDsMI0zT7EQDCQF+
   r4VjrfumQ9QxBP/lQynj2KsUV4SHPiV9ZQ5vhYJeqC6aVcHnltkNy7h8W
   g==;
X-CSE-ConnectionGUID: ynqHUVtQQXmluos1pNiFBw==
X-CSE-MsgGUID: dH0iL1p/Ta2VUO7BuoJCwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="104097763"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="104097763"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:34:27 -0700
X-CSE-ConnectionGUID: CLVe/pXJQnKVtpdUr0ErLQ==
X-CSE-MsgGUID: 0U7Sd7sRSoq1E465xy3W2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="241649693"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:34:22 -0700
Date: Thu, 4 Jun 2026 22:34:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux@analog.com,
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
Subject: Re: [PATCH v16 03/14] lib: vsprintf: use _parse_integer() instead of
 _parse_integer_limit()
Message-ID: <aiHTPPGVHqWrGcSc@ashevche-desk.local>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
 <20260604-adf41513-iio-driver-v16-3-1a7d09143bc2@analog.com>
 <a5nlyycxfhwpzczlmud3gjh5qxlugwkow4dyqhtgtjrzjf5q5x@mnmcic2da75r>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5nlyycxfhwpzczlmud3gjh5qxlugwkow4dyqhtgtjrzjf5q5x@mnmcic2da75r>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 11:06:55AM +0100, Rodrigo Alencar wrote:
> On 26/06/04 10:58AM, Rodrigo Alencar via B4 Relay wrote:

...

> >  #define _parse_integer0(s, base, res, ...)						\
> >  	_parse_integer_limit(s, base, res, INT_MAX)
> 
> removed the semicolon here...
> 
> > +#define _parse_integer1(s, base, res, max_chars, ...)					\
> > +	_parse_integer_limit(s, base, res, max_chars)
> 
> and here, as per sashiko's feedback:
> https://sashiko.dev/#/patchset/20260602203706.103449-1-andriy.shevchenko%40linux.intel.com?part=1
> https://sashiko.dev/#/patchset/20260602203706.103449-1-andriy.shevchenko%40linux.intel.com?part=2

Legit, thanks for updating!

-- 
With Best Regards,
Andy Shevchenko


