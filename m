Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B93B227EB9;
	Fri, 20 Feb 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597019; cv=none; b=bWqi7iAvOnBy6Bd+fwUfhtiIGUWwhGb5KPkOYCWtf+gpCwPXYA6o/xsNwnLs6TjS1q0c7L1XDuWUfcg2bbcZfyfGbPxSwlxLO9NSBsauLo59hgYa4/m1KJUagELV23l6VNa376OcHXzGkoSe8yTwC8gAVrWfYUbwAwipufxpkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597019; c=relaxed/simple;
	bh=l+sOo5t9bxdIxZAr/Ylp+JWnpziXkpFBxsv9S+fIBQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYt0ZcEdXB7Kn7FPBTaNiL1H1Lo0GZveeq5R8QMTj4kW2OAS33FJvmIJlAZT+ospFBfm+d34CP2ancCjO8PwXg7xAnd1RLx+jd8oays5KjH3KKY9S0rgLA0mIV62LhbFpIPBLpBtN7N+g4ltD8PNoHFYVxwFR90RsTb4sRf4JXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WW/5E3Dr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WW/5E3Dr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771597018; x=1803133018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l+sOo5t9bxdIxZAr/Ylp+JWnpziXkpFBxsv9S+fIBQI=;
  b=WW/5E3DrBEWFiJn/ZRHq8nL83o+HjF6udgVxqyjOFr9czdI7flJ1sJRo
   vOFBY6qb1APp+zyabSAiRASe8TeEi6t8yJmPh+uKs0CMQnfaHqM1+c2Sg
   zG3ki8Wc6l1XzuN8s5LCQkoljP/rBmkktGzyKEE8o9A2r3BfiwdFtTeo5
   dXdSDyp+0gHaxiHEIYGIjW5aJeNEsf8Nr+QKcQ90E6Rx+gYoAF6SgVCk3
   VCA1I1eTQ6+00ObnYzgl0Wu0CwRSitzAOK2Y8Qryd7z1rd9I0KI4BXPfw
   +UgbQF3TN4b7LD69YXD9ztXRWmkRa42mTMHvxl6A7vIZwqvzuj4fxF+go
   g==;
X-CSE-ConnectionGUID: 9QsH6GPoS4eP/zJsmnWCLQ==
X-CSE-MsgGUID: tyUWYdtcRLa1+A3h/vrNEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72672433"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72672433"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:16:58 -0800
X-CSE-ConnectionGUID: 2Fg0gNFcTuS8P1BRmNha3A==
X-CSE-MsgGUID: 7JzA8/RiS8GPCppPp4J5Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214083557"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:16:55 -0800
Date: Fri, 20 Feb 2026 16:16:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: remove redundant else after return
Message-ID: <aZhs1XSOP1FMXzi5@smile.fi.intel.com>
References: <20260220133337.85216-1-antoniu.miclaus@analog.com>
 <aZhsCm4W5ZjLHh0J@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZhsCm4W5ZjLHh0J@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 04:13:35PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 20, 2026 at 03:33:29PM +0200, Antoniu Miclaus wrote:
> > Remove redundant else branches after return statements across several
> > IIO drivers (ad7298, ad7606, ad5592r, ad5758, admv8818) to simplify
> > control flow.
> 
> While technically you are correct, the only patch 5 makes sense to me.
> The rest might be better with 'else' be present. It depends on the logic
> between the lines, if they are of the same semantics and it's not about
> returning error code vs. 0 (success), it may be better to read them
> if they are started on the same column.
> 
> TL;DR: I am not going to NAK, but patches 1-4 is an unneeded churn to me.

For the record you may look at my patches in the Git history on the same
matter, they do not kill all 'else':s in such cases.

git log --no-merges -p --author="Andy Shevchenko" --grep "redundant 'else'"

-- 
With Best Regards,
Andy Shevchenko


