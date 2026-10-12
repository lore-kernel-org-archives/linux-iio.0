Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5F2BFC7B
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840125; cv=none; b=oLnb8qtD7zx2LNM2CfwJ6bjGDsc7c6fPOhLMYteRohjH4Qo7nktj8GquQfP+kfV2oIPI1SCcGKXSCk2Bywt1ynDywSX57nihKkeaDbzvfhrvfBtpJ3KtaRqJx6BAfZYln81hSGeRS3JupmnGicAbS2NlpIyxTRfv2Yp0cfdkIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840125; c=relaxed/simple;
	bh=a2cJKgfgrw6Vb7gi+DN/yGqYqI9wnvP7N45VgPx+e5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmUtXVN85ad6nMztObv9xdEq/JCcKwtJy1PXNmaYUWnyCdgMYv1JxWknBP69CUlNdGtlwlv4k2rL04pLADqJYAzMTDeAzkjPmWoG2T/UlnVIT7BzJnQ0yl+XKyfC7gkdVjK4difxgK9oNW5NwzGfEqH1XSMlPmHUhVuY19h80Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZ1hmR4z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZ1hmR4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791840124; x=1823376124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2cJKgfgrw6Vb7gi+DN/yGqYqI9wnvP7N45VgPx+e5w=;
  b=ZZ1hmR4zvpmYyzCphEITrfnawDdBmy5KmUHe3aAoMKdEf7+K2qMDLvTq
   MRb+aCy6BlzxBOtKi/oclG8kyVzx7kR+aGYD/nAIq5l6IFcucxlK81vvM
   HwxFCGiBY/y22azxGqL+PjW7LOIk8iHcnwFDzAh3WGPxdpUAsujA3WzWP
   xTS4CM+IWZRSgRzRowb5YS746jmwl+L80UDyeVgHg3LH1t09JLL02HjTL
   dAo5Kd9Gw2/aMpx3xsPF6BoBeWP+DvxBj7rFlYMk4guDHNFI5h/rJ/BGc
   PhHyF9MAfA+KumACNdtDJR8QFei8eY8X03NTzeXXUnPOkq3PU8LjEXERn
   Q==;
X-CSE-ConnectionGUID: sQxvDGPyS/mKkRnYGOqr5A==
X-CSE-MsgGUID: PTLwsN3NRl+oWsd3jpXTzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="655587"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="655587"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:22:03 -0700
X-CSE-ConnectionGUID: PlalEGn+S96XefT+NoQXBw==
X-CSE-MsgGUID: V6BhJzGNR/Gmau9BP3oBdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1107204"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:22:01 -0700
Date: Tue, 13 Oct 2026 00:21:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zixin Wang <ywp1023456@foxmail.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v2] iio: light: cm32181: add support for the CM32183
Message-ID: <as1Pd9blvwNg3IF0@ashevche-desk.local>
References: <tencent_27A2DA110A464EC41673E7C2217844837C09@qq.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_27A2DA110A464EC41673E7C2217844837C09@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 11, 2026 at 05:03:00PM +0000, Zixin Wang wrote:
> Add the device ID for the CM32183. The device has the same register
> layout as the CM32181.

...

> -/* CPM0 Index 0: device-id (3218 or 32181), 1: Unknown, 2: init_regs_bitmap */
> +/*
> + * CPM0 Index 0: device-id (3218, 32181 or 32183), 1: Unknown,
> + * 2: init_regs_bitmap
> + */

Make it more readable

/*
 * CPM0 Index
 * 0: device-id (3218, 32181, or 32183),
 * 1: Unknown,
 * 2: init_regs_bitmap
 */


-- 
With Best Regards,
Andy Shevchenko


