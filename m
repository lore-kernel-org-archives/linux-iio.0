Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE63AFB0C
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131944; cv=none; b=jJLEBa0MAtY7voWvN0NtjRNPK30WIbcqdQvv3EGOiiY0YJ9hv1mIz20IeJgSB2GFlJi5v/C0qZDJlNytaRhxbDtamsM99G4M6AzGIHTDdlwev4f1YfUhCNDe7F4Twcf2hprj6zhNQ6DnzusEm/UjLsCSWIZkb9+pB5V07pgNkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131944; c=relaxed/simple;
	bh=EpItVigGWbTXwqULVqC7MglXdxCjSpSg4HtfBVQEyVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwQHu+wvsINAJaVv9LkYwIzS8grTsyE2q6q6Stkz/egcErV7KwTLMxKBdpV0deLgUmdLnLdYIHJwEfjp0goCbNLN64mDKxq96HIrLMFg/PwhlONu8TwFEzXNYofP/DyrihkxEmJ97k7QjYPeViysgCrPo6AD7blcR8j6ObnCD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATQx+6o2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATQx+6o2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784131939; x=1815667939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EpItVigGWbTXwqULVqC7MglXdxCjSpSg4HtfBVQEyVU=;
  b=ATQx+6o2yxEYIP4iFlTm9dYWmyuakik6xBE1wov6cnj8WWBMFiwc0JBl
   qtgJM3KxyomjlIDnT+MpY6qKXWVmwSvz5AthCGqJKSSKRcXZ+H3OYvnHx
   VhxaoeWY2taKWWuO0lm6um/ID+fsW/yc26Lei+F2r+lcX6RRVR1b3lr2U
   w9F4NuBh6PMmOM05IDmrtqeEPeu38BgsZPMN0jN1Nn8eoGn2zAUL1gwsh
   8+xrGIRULe9foRpDIGxxG3m1GLY/xca4fq9PPl/mGbOpDYGvnhfWIt1H+
   Zh1jKIz5xLCIPRrPmDQ7wlD18JfD/ZgK/2yzsCx8Qy2geDjHnA0vkyfwI
   A==;
X-CSE-ConnectionGUID: L6zslsiaTEaI+HCoC/nFZg==
X-CSE-MsgGUID: g0dWDbwrTC2KexCiEBETLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84630016"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84630016"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:12:13 -0700
X-CSE-ConnectionGUID: mei0xxPGSgCfQPG24BLB8w==
X-CSE-MsgGUID: BuOHL7bkSLaUWbQjrb8G9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="252827716"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:12:11 -0700
Date: Wed, 15 Jul 2026 19:12:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] iio: buffer: Fix potential use-after-free in
 anonymous buffer release
Message-ID: <alexWK2znbB7AQ8M@ashevche-desk.local>
References: <20260715154245.3814378-1-lars@metafoo.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715154245.3814378-1-lars@metafoo.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 08:42:43AM -0700, Lars-Peter Clausen wrote:
> An anonymous buffer handle holds a reference to the underlying IIO device.
> The reference is dropped in the buffer handle's release function. If the
> device has been removed, either through unbind or hot-unplug, the buffer
> handle might hold the last reference.
> 
> The release function takes the mutex for the buffer using a guard, which
> means the unlock happens after all the code in the function, including
> `iio_device_put()`. If the anonymous buffer holds the last reference this
> might free both the IIO device and the buffer, which contains the mutex,
> leading to use-after-free when the mutex is unlocked.
> 
> Fix this by using a scoped guard just around the buffer dmabuf list access,
> making sure the mutex is unlocked before releasing the IIO device.
> 
> Version 10 of the patch that introduced this issue used this exact scheme
> of first unlocking and then dropping the reference [1]. During review it
> was suggested to use a guard instead, and version 11 made that change [2].

> [1] https://lore.kernel.org/linux-iio/20240605110845.86740-4-paul@crapouillou.net
> [2] https://lore.kernel.org/linux-iio/20240618100302.72886-4-paul@crapouillou.net

Make them Link tags?

Link: ... [1]
Link: ... [2]

> Reported-by: codex:gpt-5.6
> Fixes: 3e26d9f08fbe ("iio: core: Add new DMABUF interface infrastructure")

The case and fix makes sense to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


