Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B1392C2F;
	Wed,  3 Jun 2026 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483235; cv=none; b=hQBXYbaNyyws3ECRl19Mq4HzdDWOx2MyeQQdhaKvxG3vB23I75UEutZHgNkQLmII6AmZnFiwN/UT3xT4I0M9wnOmNNXuToQ/QHaQjqKfEDIP7QJ0obdJ2aaTWMy9U3u18aAoSfNMbgEK7Ss5GVtWeDNHt0SSHRf1dgY84C573Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483235; c=relaxed/simple;
	bh=H9Y4CGDa4uJHRTCOdiJKq9IP7qzjATIYMHaGm1TLUwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh+Z7NdW/7cRi6Gbk30Dt/LwZR5+zmqjSitdkT6ziQkgQflqJnnjB/xqbxZxc1Hzul94rFAGpO/dNIUPVXwDLojLbGkgMR4HMADoZscwg2P1fuWhveb93i0jKEamrgKvAHSyP1EcmTBM/iCr/2Q2y5aZAGNTL7wWUxuD241ag14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAotgp1M; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAotgp1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780483233; x=1812019233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H9Y4CGDa4uJHRTCOdiJKq9IP7qzjATIYMHaGm1TLUwU=;
  b=JAotgp1MELJ+9Cu9bkAEpxqphJt46ioMLtLkswwHR4NO2Z3poCoYDrRi
   NwWlcjioxizHwW3cQkb2aYMo9jUevKP/k5UU38Ng07lLEjcURVWCBS1xp
   837ehsBuMM/a5W3xqLSEoUZ0jmJTId7Jf+KpCOFwRqctVzcKj8omXeHpP
   Jn3AOnmh+IZb+KYPO2wPhB4jXBtUQGgTqXyL3svO36z3bpDsuUhpUoVFY
   XHlzIlWlXqMcWhdvwDCM0sxWC8NMot70B/8hRk0WdtI2LxWMKckcjPAtl
   TY4J3iHxbKS04Qt4JA52qAeJH92oVjiO+55mJljPNRefbofY58Qcek8qE
   Q==;
X-CSE-ConnectionGUID: kJ0QV0QWQGSZDbJI4eGxSQ==
X-CSE-MsgGUID: MTXGwLM7Q7WGjJObnMjpcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80428937"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="80428937"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:40:32 -0700
X-CSE-ConnectionGUID: KNp61SvLSfqZlUW+cu6fYA==
X-CSE-MsgGUID: RqnmA0PHTZWL/X+BWEdfPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="237832611"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:40:27 -0700
Date: Wed, 3 Jun 2026 13:40:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <aiAEmS7aa5p1Fi7g@ashevche-desk.local>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
 <20260531-adf41513-iio-driver-v15-2-da09adf1c0dd@analog.com>
 <ah8yR3Os8NDNll27@ashevche-desk.local>
 <r54csg73lsafo6rff7gew2eardfag3zmwjbm4jl54pjbqf6w7y@axnfog5wpney>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r54csg73lsafo6rff7gew2eardfag3zmwjbm4jl54pjbqf6w7y@axnfog5wpney>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 11:27:11AM +0100, Rodrigo Alencar wrote:
> On 26/06/02 10:43PM, Andy Shevchenko wrote:
> > On Sun, May 31, 2026 at 09:30:45AM +0100, Rodrigo Alencar via B4 Relay wrote:

...

> > > +static unsigned int _parse_integer_limit_init(const char *s, unsigned int base,
> > > +					      unsigned long long init,
> > 
> > Why not name it res...
> 
> "res" is short for result and this is an init value. I suppose the compiler
> can optmize towards that kinda of efficiency. I thought of "p" itself to
> carry the init value, and the function would just accumulate, but that would
> change expectations on the function behavior.

> > > +					      unsigned long long *p,
> > > +					      size_t max_chars)

In any case I hope you saw my mini-series:
20260602203706.103449-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko


