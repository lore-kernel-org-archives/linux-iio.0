Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A192475E3;
	Mon, 16 Feb 2026 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225825; cv=none; b=oAljoGPC8S2cmLaOAEDpXtcswOaNqLwgnTQFLj5LdJZNTfODeGxtq5egfQTIL2EVcHnCQPMc3x9fMfkU9BftEzMleIbJoow9g6hzBoBHrFg8yoWa7x141LOYLLvPLh4Q5ra1oUsbG/Po7g5ADgfZP364PPLkSfxlzNlpXDbMO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225825; c=relaxed/simple;
	bh=UHwUM26VhnFTaAiMMJDkTpejDnGXr+iz9zK9Fu/a/fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErPooM0BAVhWdsYpN5TeEibs1Oxn1ZACVDuPUT0Y/+RCrx3cy4yItD9UbHkvHUA2h8vCsH38ty6dl35NtgIs0jodbw3UBhF6ucRvN6undtuMrvN59IJbf5ermuMvZqGSOnmsN6fEzmgPVK4BdeTgJf0YlAOqWci4GMsbF7UQQvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb2PnR3T; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb2PnR3T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771225825; x=1802761825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UHwUM26VhnFTaAiMMJDkTpejDnGXr+iz9zK9Fu/a/fo=;
  b=Wb2PnR3TjwQShEIXQ9VNornniDvhmS7I6LZ2YIcmAa7Ke6IMjkaB7N7i
   yw9CiHOI1Tbsj1UCN7ijlbad9nafOXva5NheaYXvfgkYg5Vdg5zXk+3/G
   f7ZeopgBtfwWn2jYS/sr5PbR23mSg/0oIxfI2m0qDmk6I74B+nq7L1u2m
   X9NMglpNxwfG26ZxRRaT4/Holzj7B8oGpThkytLgmjlMC5tYBfn6OM8Cc
   BdkdI/76FJaKkF+g9mC2CAlEb4yTF4S+CIC3LvegzoqcpBvBUSJrcSWY7
   FBO8pg8Mc9kCVtUElsFdhO6j1idf2iZblc8+ZI25mddm+ylOyoM9IaagW
   Q==;
X-CSE-ConnectionGUID: j29ghzqoThWr9bN/NDPcdg==
X-CSE-MsgGUID: 38tAJlLDQHmzxArBpkTsMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="89715112"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="89715112"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:10:24 -0800
X-CSE-ConnectionGUID: 1KJrpWCxT1WwmN4v5xsA7A==
X-CSE-MsgGUID: 27oCxnpQTZmySWqi29PE8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="213365343"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:10:23 -0800
Date: Mon, 16 Feb 2026 09:10:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: gp2ap020a00f: correct return type to
 int
Message-ID: <aZLC3PPhEa65Fu5S@smile.fi.intel.com>
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
 <20260216005317.11763-3-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216005317.11763-3-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 15, 2026 at 06:53:17PM -0600, Ethan Tidmore wrote:
> The function gp2ap020a00f_get_thresh_reg() can return -EINVAL in its
> error path. Yet, the function has return type of u8. Added error
> checking for gp2ap020a00f_get_thresh_reg() return value.
> 
> Detected by Smatch:
> drivers/iio/light/gp2ap020a00f.c:1013 gp2ap020a00f_get_thresh_reg() warn:
> signedness bug returning '(-22)'

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


