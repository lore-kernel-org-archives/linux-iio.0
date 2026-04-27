Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640B9374E5C;
	Mon, 27 Apr 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315365; cv=none; b=hRbulHAZ1Hc8vox/9WjXEcXsivfXCHaZb4S8fiBEiuu3V6hoqiCufKGul3O8xduzsp7ZPJUBJGJLQfsfz8l1/9o6sOu713/f2VRhB3kjVVYX3ms0/PFrsHg/yaOoRQEud5gzXh86uOsNgQqRNsnrSCj7E2V4MFH2eEqNGKGr7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315365; c=relaxed/simple;
	bh=wYJUfXwTRZWzF7sqvdMgSEJ+NZILuc0s+LJtZTxYru8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHf733Q84wjgl6hkhHx2nyjGUw9H9hNyopbybixhRWwnU8GtKDFnt3VLpGet+H7WCzP/cUp+BPa9XhAnwFlTWE/QhNSuzprciHrHejXRukpxxAABCiGVHYRYrRbS5/hjIDbE51AtMQBGPuAyurfP5SLQkgYIJ7pKXSvb7CzVoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSIGwZBz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSIGwZBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777315364; x=1808851364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wYJUfXwTRZWzF7sqvdMgSEJ+NZILuc0s+LJtZTxYru8=;
  b=KSIGwZBzOvl1ZIGI62tI67xmQy5nOtT1x97awYPdpYXDlYfsQwq/T47H
   eeWf5+bDNlaTYQHVXLk0L7EoxCG7xxuYIuygqnxptKiToIQgKcrPcg76o
   pneyxM/jd6Jb61r1eiWdsMOzCu0eYGHGx9OLCviyHFy8yat65z60PGFVs
   y6TimQLdYBHPhmGEDeQYzWo2wKhuDnkDAd1Kk2pKc7sbOgpSyL2N7Ql6B
   GW/Gxn9Hi21DzBBOPbFWrGXEyONp1vDl+A6ui/ArkJxIhGV2ZqcgO3Mvn
   NIOJ1pEcSG0HpW/GuoTNxeL2u6n2jiqxFYB5awVL7euUdWlpl5OUUImDj
   Q==;
X-CSE-ConnectionGUID: UC7QcW6yTa+2TQgK2zlfQA==
X-CSE-MsgGUID: 6GZUfidcQdmA/RoVgwe2oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78233396"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78233396"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:42:43 -0700
X-CSE-ConnectionGUID: AR/NygY8QzigFaSDvST2gg==
X-CSE-MsgGUID: Hkn6LNPHRF+w05T5F9GZRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="271841254"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:42:40 -0700
Date: Mon, 27 Apr 2026 21:42:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: si1133: prefer complex macros enclosed in
 parenthesis
Message-ID: <ae-uHt1c_3-xR_WN@ashevche-desk.local>
References: <20260427-si1133-checkup-v1-1-20f5f11eba6c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-si1133-checkup-v1-1-20f5f11eba6c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 04:08:37PM +0200, Joshua Crofts via B4 Relay wrote:

> Enclose complex macros in parenthesis per checkpatch.pl error to
> improve code style.

...

> -#define SI1133_ADCSENS_NB_MEAS(x)	fls(x) << SI1133_ADCSENS_SCALE_SHIFT
> +#define SI1133_ADCSENS_NB_MEAS(x)	(fls(x) << SI1133_ADCSENS_SCALE_SHIFT)

Wow, this is used with bitwise OR, which probably works fine due to operator precedence.

...

> -#define SI1133_CMD_TIMEOUT_US		SI1133_CMD_TIMEOUT_MS * 1000
> +#define SI1133_CMD_TIMEOUT_US		(SI1133_CMD_TIMEOUT_MS * 1000)

Is it used at all?

I would drop unused macros (that are Linux only, not directly related to HW) in
a separate patch.

-- 
With Best Regards,
Andy Shevchenko


