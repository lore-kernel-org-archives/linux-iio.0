Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A899186284;
	Sun, 10 May 2026 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778436630; cv=none; b=EihQW5o7wfYrfIeI1hCOyAG30z3GX8lJxdGOtRwYq6XDINfkX0ptWf+s9irKlE53tl5LuMbZ9mz7G1913eB8bBOHXal0B5ggcDT3cQ+tO+RIvwPoiau6wX0Gagoa9lC22HJGCuxT5OpII8zVyiYblrtU0CwWlUo+wHf/KiLIyfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778436630; c=relaxed/simple;
	bh=qNCObYREkWP1aC0DVoG4mw6EjGVKDCvRQr6r6cxo57s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bA7xqu/uQpy8vUJZtQr9mcSUPCIHOHaKGni0gWl9P+LJJWvlrA1cN4F6a45/LnvqNQb5ve4FW+P6UGGdFahx0rZQuVHAJ+EhVFKKl7DnqAW6Y6LCtkiBmlzH6/8XOGxcs0vBEAPrW+pW9ARWEEz9IFaWIxQCzwgDnvGF8qI8BE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lM6akRw3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lM6akRw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778436629; x=1809972629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qNCObYREkWP1aC0DVoG4mw6EjGVKDCvRQr6r6cxo57s=;
  b=lM6akRw3zCNT/GWUtA97xseOMsSrnXef+79tbtz5gpnc5qXKOSue4fQq
   aiTtO1hg3RCiNeWn4F1SPgtnR64LohLYewB5Uj6TkIwWCExgLYQPqPadz
   mm9UhJh/jyLVtvVjRUe4gROH4b4Qitp3lfXWJ6mQmc4EJkNgnYQrhaoxl
   d0RmQlAyIZ+UDwVRXbMpSTZyBglHrFRfmjJezpKzEFNwFFreWcjcS2vuK
   IBAVqyNl1n/BvD7F3AF7IQpm7eUP74fAr1g206YjusG0GTi2eQTEGFRg4
   fafdt+5KA1jiyCza/2jZ6gh4Gr+oAS9HtUjrSRakktPKyuqojuP3cKr6b
   A==;
X-CSE-ConnectionGUID: qFvN/reZTOq91eNPXr4WvQ==
X-CSE-MsgGUID: NnF+lyvVRru+07IfFn/N2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79196836"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79196836"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:10:28 -0700
X-CSE-ConnectionGUID: 8eJQzMjZQ2q3jYMR7Iip8Q==
X-CSE-MsgGUID: jx470zvnSUiwEiJ+toGV3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="236283998"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:10:25 -0700
Date: Sun, 10 May 2026 21:10:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	alisa.roman@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7192: replace usleep_range() with fsleep()
Message-ID: <agDKDimVZc_hcSO7@ashevche-desk.local>
References: <20260510052401.31057-1-sozdayvek@gmail.com>
 <20260510055417.37519-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510055417.37519-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 10:54:17AM +0500, Stepan Ionichev wrote:
> The "at least 500us" wait after serial interface reset has no
> specific upper bound. fsleep(500) expands to the same
> usleep_range(500, 1000) internally.
> 
> Drop the trailing "/* Wait for at least 500us */" comment which
> just restated the previous arguments.
> 
> No functional change.

> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---

You missed a changelog here.

>  1 file changed, 1 insertion(+), 1 deletion(-)

...

> -	usleep_range(500, 1000); /* Wait for at least 500us */
> +	fsleep(500);

Have you checked the datasheet? What does it say about this sleep?

-- 
With Best Regards,
Andy Shevchenko


