Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0B1E8337;
	Sun,  8 Feb 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770559281; cv=none; b=DyJr2vGeLo3j2aGKh8Asjq0aRrtrvgRDbobKdh8sx/Lv1espX5/UjBL2f0R7ytY4mBPKgFJXnXnQwJFt6+I88Eb8wt8BWnFBaveGD9+mQ24V7qeWS9C0o5lsJEjb5g/PluCQnnH9LBnCbg+kLM2uFlVu0s8gAmlRIcBmVDtW4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770559281; c=relaxed/simple;
	bh=U5YjNoN/Y1XoV8wcLH5ilJ4O+3pjuV3Hbxqj3EqnvPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSziDsS6Jr4PpwlXBm1q97vzNiSsIq0Q4b4Q37evGKWI9siU/7pRoQARrIsJwk5MAjOrd4kgYnnBrC3gWLxloHiKz7zdcmIhx3k9kEV450+7kSE2pu0kTcw9rWLEP+naUmCA6eZYzT56TVVRFS0zgaEA2iY2E+AIMRxyGpzUPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYgQjdVT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYgQjdVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770559280; x=1802095280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U5YjNoN/Y1XoV8wcLH5ilJ4O+3pjuV3Hbxqj3EqnvPw=;
  b=ZYgQjdVTuXii/tuXRgCp1HI2jyvOIehfVrKvCHzyOXVxYkpF8lNyg+za
   RpU8UpNTWv5BKETclixIiOlZLEpJ6OYkAkoi/pAppHGeUGBJiukAAVGqi
   Cir3lmM/sb0PZJB/xVcE6gPxZRMDAVDTOraoO+mpfzH5OkSxEhGrcw/qm
   7JcVzaHFEOFsh3qIfEInWnQOiwddsUO1SR+f+F0CRrFOLAU9M/pGaLdEP
   ObBeK5q3eVOEIte7n4DQHRGuNUJ5UQr5f7l75+w0RHLdacxU2EsNQyEbl
   mUzSIprgPM3enjsqH2pGGLJgKxbYg2zt2pDSlcSR9c5rEjUGfy2nppoL/
   w==;
X-CSE-ConnectionGUID: N/sb9vhYS5qo7Xtk+dvKSg==
X-CSE-MsgGUID: N6WrWBw1Qd2V8JM2S+Mp7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71757871"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="71757871"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 06:01:20 -0800
X-CSE-ConnectionGUID: JzWppQohR8ukSShvgjdq7g==
X-CSE-MsgGUID: 8he0z+aGQIa5yNmSt9yZRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="211034047"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 06:01:16 -0800
Date: Sun, 8 Feb 2026 16:01:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v8 7/8] iio: adc: ad4030: Add support for ADAQ4216 and
 ADAQ4224
Message-ID: <aYiXKq5SJ3wNl8DA@smile.fi.intel.com>
References: <cover.1770403407.git.marcelo.schmitt@analog.com>
 <b437e4ca90df98220f2cabc514c201743e269889.1770403407.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b437e4ca90df98220f2cabc514c201743e269889.1770403407.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 04:02:19PM -0300, Marcelo Schmitt wrote:
> ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
> that scales the analog input signal prior to it reaching the ADC. The PGA
> is controlled through a pair of pins (A0 and A1) whose state define the
> gain that is applied to the input signal.
> 
> Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
> through the IIO device channel scale available interface and enable control
> of the PGA through the channel scale interface.

...

> +/*
> + * Gains computed as fractions of 1000 so they can be expressed by integers.
> + */
> +static const int adaq4216_hw_gains_vpv[] = {
> +	1 * MILLI / 3,		/* 333 */
> +	5 * MILLI / 9,		/* 555 */
> +	20 * MILLI / 9,		/* 2222 */
> +	20 * MILLI / 3,		/* 6666 */

In case you would need a new version, or Jonathan is okay to tweak, I think
it's better to use float in the comments. The above comment explains the
MILL multiplier for the values.

	1 * MILLI / 3,		/* 0.333 */
	5 * MILLI / 9,		/* 0.555 */
	20 * MILLI / 9,		/* 0.2222 */
	20 * MILLI / 3,		/* 0.6666 */

> +};

Btw, if this true (if I am not mistaken in the gain values), the question is
why 0.2222 is much higher than 0.555.

-- 
With Best Regards,
Andy Shevchenko


