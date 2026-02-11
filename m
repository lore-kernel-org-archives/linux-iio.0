Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920334846D;
	Wed, 11 Feb 2026 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799325; cv=none; b=uohcfh5zYNHzNpM4S/EilSXy5W7IfPQchx6fnMsQqoOFYO8TPK3rgVOe4L8km101rHfVLkhGKYgBFZEuKQ7OBO6AQkgzMeVLiYCkrQbzoVkB3xBhWxEbPSADkIvYlxLg6eDDIsRaU/ctzRWO7wdnUiKy8aIPrUdwj194i/RW5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799325; c=relaxed/simple;
	bh=vcIzvShRLaqkuHTFo+QNUP60lAiouVBve4USEzwoEu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2eVSvOdtRdjwFevVWv+v8kDUY5US52tP1wkB0aBo6oLtmBSXbGsW4XmTKYqCwCfEJgYfwmKah3G9cb0V0zWBZilaujsq+Tw8gQ+ZXtjBbXgoOIgbNfyRdwX4BxlNS0qsunPXXqBBUr9Rqt7lDRK/RXlrKNkbSroz4bw7Ndidjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3S5VHaq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3S5VHaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770799323; x=1802335323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vcIzvShRLaqkuHTFo+QNUP60lAiouVBve4USEzwoEu0=;
  b=K3S5VHaq2LoUynQfehX6cvS0Yd5bE2zDHeBE4amlHALcoIZuonq4Nj9y
   2+1Rld8zCURpSzUvHCwmifvR2tGIHstbL+qN3EXOhmIUKOFNW9iaqXabw
   oa0uqhJcCd2vtnUXpvt8dLc68MHZXYUM05Tys+k53RvYcFoeLD0H3QTz6
   sBDIhtt5DKJtY8Gs4MAhfprav254R3qo7q43f0nf8sH28dXuPT0wXkz8C
   SWrSaHa/HBrmj2ORWVI5VewS4TggaMg52+TEYp89KVL0kojud3/Ff5Au8
   dUBa8z4X2W8AO29a5uw+lDpJwbLSrzVLCEj0y4OvDeGfgiNEUvLzHbkoO
   w==;
X-CSE-ConnectionGUID: zTRx0PswT6CHQ4SjMVSiCQ==
X-CSE-MsgGUID: 9GTbbKA7S1KwmUpQAn7lZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72014305"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72014305"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:42:03 -0800
X-CSE-ConnectionGUID: s6nQqkxAQ3WaDfTOJ63fQQ==
X-CSE-MsgGUID: NuqCBydjRyezhx1GYZJU3Q==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:42:00 -0800
Date: Wed, 11 Feb 2026 10:41:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] iio: magnetometer: bmc150_magn: minor formatting
 cleanup
Message-ID: <aYxA1lBOluYHYjCv@smile.fi.intel.com>
References: <20260210233945.40975-1-neelb2403@gmail.com>
 <20260210233945.40975-4-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210233945.40975-4-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 06:39:45PM -0500, Neel Bullywon wrote:
> Improve initializer list style for bmc150_magn_samp_freq_table by
> moving the opening brace to its own line and grouping four entries
> per line with index comments.
> 
> Add spaces inside braces for initializer lists in the preset table
> for consistency.
> 
> Fix indentation of bmc150_magn_scan_masks array. No functional changes.

...

> +} bmc150_magn_samp_freq_table[] = {
> +	{ 2, 0x01 }, { 6, 0x02 }, { 8, 0x03 }, { 10, 0x00 },		/* 0 - 3 */
> +	{ 15, 0x04 }, { 20, 0x05 }, { 25, 0x06 }, { 30, 0x07 },	    /* 4 - 7 */

Problem with indentation of the comment in the last line.

> +};

Otherwise, LGTM.

-- 
With Best Regards,
Andy Shevchenko


