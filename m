Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E122550A4;
	Fri,  6 Mar 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808700; cv=none; b=nEb/J7szyGJGuJ4vcOcWKIA3V2qb/Hx7qu6HrPaL2x9XnVw8RbgZClcuIUtAZfpRH3bC4Du0GMQfmIWWwVldatpdFBU8Qax5ww2GooA7zmKU8+fSYY6GbRfisUYmlJlZRya4qBnLx0cMuNEag9f2PPM8IhTOJt1MZiyj+eaaDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808700; c=relaxed/simple;
	bh=slJs+ylmLcgl4zbvwwuNJA8VWpgdTbbWP4d2VJGhW9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbE+O/tbGUW/Ny0NWAk9CLqULNfj6OcuGf58l8ArM8Jv426AbIIbbvDr7MV/XDUwysKGAmTSNONfzEjE+pPsvzBy9JueD8kfGoZ3g3KrrJz7xVvER6NSphLHQSmydijEZydKhcvSvLWbdTd9db6LT6aSr+xgnWKW/8CAxiHz1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIPUx4fW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIPUx4fW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772808699; x=1804344699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=slJs+ylmLcgl4zbvwwuNJA8VWpgdTbbWP4d2VJGhW9w=;
  b=mIPUx4fW/Ih4Dol2D2oJyL86HvvdvPJgQMj7C2YBQcFVmmGS35nQX7Dj
   VbL7U4tY/RTpFBLOGymg1yUcuAFV97PY7+Ai8MXbYl6u/7EKEePzRwjnJ
   Jzoi1Z/0OZy6QafBKQPXVW9vOHIygPMK7wdcotpWAlKodjlqt2SLxuWHV
   L2KZNLJvhPhB17KeiwmtEfBSGVWgBru4XiEvstKUXDkKoUDBNTURIcte/
   T4QinaNwnxdX7kWZnXs9etoI4r05oPRQg+oVlz7YWWezdv+Ke4Ql9hqRZ
   LaYgrShAqUBHiXBqEKBCpJXebMBdMCA8oKn/GytKm4sLGyVOMczLiBGPB
   w==;
X-CSE-ConnectionGUID: WPrhd3daTHmTxyd0prXseQ==
X-CSE-MsgGUID: oGygpdVmRbmhZscUdA74nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="85000676"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="85000676"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:51:39 -0800
X-CSE-ConnectionGUID: aDrfpjoTSFG6aRA706TwxA==
X-CSE-MsgGUID: M6r7oJWTTqazSC6LEGP4vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="256955027"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:51:35 -0800
Date: Fri, 6 Mar 2026 16:51:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] staging: iio: adt7316: refactor temperature
 calculation logic
Message-ID: <aarp9BARVxWELZY9@ashevche-desk.local>
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
 <20260305-adt7316-correct-macros-v2-1-3702e3841c42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-adt7316-correct-macros-v2-1-3702e3841c42@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 05, 2026 at 11:16:58PM -0800, Michael Harris wrote:
> Replace the manual sign manipulation with sign_extend32() and change the
> affected variable from u16 to s32 to properly handle negative values.
> 
> Resolve a logic error where the sign bit was being checked at bit 10
> instead of bit 9 for a 10-bit value.
> 
> Convert the data variable to be in centidegrees celsius (0.25 C per bit)
> so we can use simple division and modulo for sysfs_emit() instead of the
> convoluted bit shifting and masking.

Sounds like a candidate for Fixes tag.

...

> -	return sysfs_emit(buf, "%c%d.%.2d\n", sign,
> -		(data >> ADT7316_T_VALUE_FLOAT_OFFSET),
> -		(data & ADT7316_T_VALUE_FLOAT_MASK) * 25);
> +	return sysfs_emit(buf, "%s%d.%02u\n",
> +			  (data < 0 ? "-" : ""),
> +			  abs(data / 100),
> +			  abs(data % 100));

Hmm... If you create a temporary variable for abs(data), this might give
slightly different code generation, presumably better on (some) architectures.
/ % combined maybe a single assembly instruction.

Or keep sign in a char as it was in the original code and just move data to be
abs(data).

-- 
With Best Regards,
Andy Shevchenko


