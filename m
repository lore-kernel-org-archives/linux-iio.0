Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A734FF4D;
	Mon, 23 Feb 2026 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847687; cv=none; b=inV+MApSUF8qPCJjx15BOlUeuIjyWKx83LTHaLBaTuZdswovkWlX6sb2IGzk6DT88tNII/5ZxQ6GK8+dBwodzzpElQRgzL1XE+hNyQf51hqMWQrJsgAWTeOPkE+GVCPVEBI3UGJwK1p1xZItD0+eTh1oUmOclDm8lx6Ob/+CPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847687; c=relaxed/simple;
	bh=LZx/FKetZqU2z8AuV0ulP7/xEc62JVvuL45JY/s6JXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwAtWqdhoLZysaDVZYROBcadEJR6b68iwwpBYpad1XUDyE0G6MhPPM3QwOpfUVXSK8tn+40WABqgWcXtjLohrYutOFOb92HwtbRk9y8BYxK69qjfEhfRGTrb9VLsp71YC5de4km8S0ZxFu6FaW0jgbmNdGfjIeL1yZLVL1UF3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3zFtYyK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3zFtYyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771847686; x=1803383686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LZx/FKetZqU2z8AuV0ulP7/xEc62JVvuL45JY/s6JXY=;
  b=P3zFtYyK7JRILFNPrHpg9PRIzSENByL7bT3rhz5wfC+1eGcpyAgC6V0b
   dWHOlbIJPynexVbQGUor6PBCHv0m0H6S1xDBNf0BrXEZNPmRwno5g6bLx
   0vedeXFELOVjEKHDoJ3U5df8uZmMt69/kM7+uH7Ve0lOtmnZIWXulDZHD
   axkKvwnSw1Nu0vUhjuTHwfFx/ecv7AZOzKTF0ocjOL0xpT6utmIO4Hi8Q
   n3kL7ZwvL//ncLG9pViVB+hmCFA8vdqIc17UTmkHi4SG69ASBiuPH3xCU
   0TnMDWdMLw1D4RuEwpfKhxi7VO0AXvjzbcu1IF4U5wyqZ9Of4x2S8mMdS
   w==;
X-CSE-ConnectionGUID: RMWZkXg3RSqqWAhe2hk+yw==
X-CSE-MsgGUID: EODWlbIwQouW8vNWIH1eWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="90424056"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="90424056"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:54:46 -0800
X-CSE-ConnectionGUID: iNITO4zeTGWfA4VmtY18yQ==
X-CSE-MsgGUID: 0hVdWvSmQ/+fmCt6LIixUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="212940844"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:54:43 -0800
Date: Mon, 23 Feb 2026 13:54:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] iio: light: gp2ap020a00f: simplify locking with
 guard()
Message-ID: <aZxAAfO-NkK--foY@smile.fi.intel.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
 <20260223034020.27625-2-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223034020.27625-2-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 22, 2026 at 09:40:11PM -0600, Ethan Tidmore wrote:
> Use the guard() cleanup handler to manage the device lock.
> This simplifies the code by removing the need for manual unlocking
> and goto error handling paths.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
> v5:
> - Integrate with Andy Shevchenko's cleanups.

Bingo!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


