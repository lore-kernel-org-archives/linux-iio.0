Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254342;
	b=4skd6yaYkDZ637gxjNpsGlKTPgpwrUTx+j3I7Td3NGP8k0buWX4qg4+/QmjD1Cy6EeZP
	 1B77uzTIq5ZosFa8salq18ZYaz4elROiWX0pqgS1SkPvO8+OJVy/vTAEfWKK8fiAo0rwe
	 0rmJKfjjEfezl+3z9D6iFmNHOghB2JXh0pjZfa5ZlKlpGXyN5FfdFkaIKhOWuCRj5QJWP
	 Mx8dXw4MODc909aDSGEECp5mJlJR227Zvzpb4zqroEFgL30BWBU53r7S8p7OR6ickms50
	 altrHS7J+y2F0KaoRz25vXMOmQUB+bANbazpO9ZR9XMxsmsUhnuoytVd75vTefiIRmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254342;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FdDGiZwOOWZwJVFv4FAVfW8R7nFxQhpPA6Hk8lq1wm0=;
	b=OwwxouNg6tdIeMXiLQvWHcsk0mmjAp9s9pFbUEr1BW39XA4gemOkZMC/VypxGvPOdH1X
	 4s2YDglWHLFlpYdCu1OB1r4zkefDr/FvNWynZvzh68zCvl/c6feHnyofcTVDaLHfJBp7U
	 DY2zvUWVZA2vb3I0GWWz+ap3vffRF5Ni0ASrjywzeCFZRtCb7TyJULd8ZJPKXPLCLuHEb
	 HvKO3+g0h+K17nk2bvai2YXP0appVYdNXtoqVtJ61RwSrkUbIauDERZZm7a64TNHVW0sn
	 mwuyzP7/fvZVDxAGpMJeNYIw7u+95psVc+AnLXTqn9A+UIUvf871rvr3bim5lYUqWvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jXWW4+Jx;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D791606A325;
	Mon,  9 Nov 2026 19:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D791606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jXWW4+Jx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254342; x=1825790342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aj9k4gUMpI3/HGNdSJDijxvjc23dI4AV4AHN6M0g14Q=;
  b=jXWW4+JxAYUQoLAMiVD5kNOspERhRSur94988O1zoMInVceMIdtXvj8Z
   eLwj+JNaLvkDsllL1PaAAUpA3N+Oc9qsMXtpl42dK5iBn/7c2JXM3GH9G
   JGjWZhdlVGeL0/rvlvHz5r1ymrQCPPzG4SxkD1pUZZ19+6VZooMeId4CQ
   w1PlHRy3OrPUrPULZvDSZs9Tl7MkFxk7O3iiI/lBQyeNIfdW5ZsU7S8MM
   +G0inflGObJS1ACIO80xDPQlXT0mxWlyNLroh8+1/GC4vTvR4tQhmyWdE
   Rakpf6QwJLO4UNHZ+u/w827GxvsreiLiDccYzRaGfdl5Z6ClhtTWntnIc
   Q==;
X-CSE-ConnectionGUID: Wi55mOgwQ+qdd2WiWVczJQ==
X-CSE-MsgGUID: /jh498LcTTK48W5K8C0qXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2886299"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2886299"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:59:01 -0800
X-CSE-ConnectionGUID: KSSHuhRyR0evKU3HHjyUqg==
X-CSE-MsgGUID: yBU8TTceSqqe7toJf5BuwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7949720"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:58:58 -0800
Date: Mon, 9 Nov 2026 21:58:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raffaele.tranfaglia@gmail.com
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: adux1020: use guard() to simplify lock
 handling
Message-ID: <avImAIJxoTQJOWzf@ashevche-desk.local>
References: <20261108-adux1020-guard-v1-1-db9c582f1eea@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-adux1020-guard-v1-1-db9c582f1eea@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 08, 2026 at 08:16:13PM +0000, Raffaele Tranfaglia via B4 Relay wrote:
> 
> Use guard(mutex) in adux1020_read_raw(), adux1020_write_raw() and
> adux1020_write_event_config() so the lock is released automatically on
> return. This allows returning directly instead of jumping to a common
> unlock label, and lets adux1020_write_raw() drop its ret variable.
> 
> No functional change intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/all/20261107222957.5332237b@jic23-hlaptop/

It's not recommended to put unreferenced Link tags.

...

> static int adux1020_read_raw(struct iio_dev *indio_dev,

>  {
>  	struct adux1020_data *data = iio_priv(indio_dev);
>  	u16 buf[3];
> -	int ret = -EINVAL;
> +	int ret;
>  	unsigned int regval;

While at it you can move 'ret' to be the last in the definition block.

-- 
With Best Regards,
Andy Shevchenko


