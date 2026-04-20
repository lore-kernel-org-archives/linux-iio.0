Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7B3CF02B
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716358; cv=none; b=mzBjEuXItn3GIudxTeW+FqhSrcwViXFUIrvyYqQvWHztUtVbNhYMFS4fNYqRPPTbKGR2Fc4NdS74c5198M9AekwIq00KTeLn629sJ4MPWxI1DXa0TS/785REV4a7ClGtqhnQ1HgAK0SFBpxC+56p99o7YT51P9q9HZmCpoiCaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716358; c=relaxed/simple;
	bh=/6fQLOVjdPsdFYsIDPkwpOCz+0qyPtKIBriaabz30j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liVZKDv9OQpx+P4IeddhwqVvZOnkI651IuYQ2zxdzci9rpIdHoR9qrAtBqCKRI9fk6Z/g7qcyu9vFNkfD2ufCkKo0i3j7SMHTHhhmnrjjqyfd/SG0CMDjZe4PLrOPk4aIP5192ia12Naz/OOR53QgRInMU0CEULEJfHCz3cjzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iALKxaxz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iALKxaxz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776716357; x=1808252357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/6fQLOVjdPsdFYsIDPkwpOCz+0qyPtKIBriaabz30j8=;
  b=iALKxaxzkiSkwqqAZ3PzUuLJP5UiT29KUGhPGU2AqVD0X4Ezdbe/V3AS
   y7IXgyLYETJwf2dMVzaOSzSk4UAVg61a6WZTp/2gJDun6CAMbRf61l6BW
   j76ayKmtR9/2D83G96dbBH+seZA/bK7MkRsHX7ZhuGZTjmc2ogofGQ9El
   +MNnMKSXwOJLq+LuOS4UhCibPpXmhsdt+9nwvXWUFPxN4kCKANIZbIdl9
   feeR05XdKcspCmiEBJaHU2IBjAXQ/R4VuK2Ftlhbw8SD+ULZkr4wJhBP+
   K6K7YZgfExapEJcO7VP0pGZ2afjePkUIiY4qC2GsWRLEPOq4zlDt5Anlg
   A==;
X-CSE-ConnectionGUID: hry441XoT3mfvQT8WRDXmw==
X-CSE-MsgGUID: EU97x1RdS7SQn3ECl1/U5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="80233313"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="80233313"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:19:15 -0700
X-CSE-ConnectionGUID: XEVmF0lSQTuZ8f2lJ0FKdg==
X-CSE-MsgGUID: boNXojjaQTy8VRu0GrzeGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="235828392"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:19:14 -0700
Date: Mon, 20 Apr 2026 23:19:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Raffael Raiel Trindade <raffaelraiel@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: vcnl4000: use lock guard()
Message-ID: <aeaKP2vARF-Bv1-2@ashevche-desk.local>
References: <20260420200047.102159-1-raffaelraiel@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420200047.102159-1-raffaelraiel@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 04:59:33PM -0300, Raffael Raiel Trindade wrote:

> Use guard() for handling mutex lock instead of manually locking and
> unlocking. Remove gotos in error handling logic. This prevents forgotten
> locks on early exits.

...

>  	regval = (ret & ~VCNL4040_PS_CONF2_PS_IT) |
>  	    FIELD_PREP(VCNL4040_PS_CONF2_PS_IT, index);

Side note: This can be simplified with FIELD_MODIFY().


-- 
With Best Regards,
Andy Shevchenko


