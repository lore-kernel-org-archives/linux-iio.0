Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508683;
	b=jlGvKG0jLVnT4KHQRBJ6URYgpGp8D2O9GjOM3SSPqdYwFn56Witu9i+CPGk92xWbOgVS
	 24DS54YgKxGY5C9nwFwqQFDSlDHHYgtDUH1Hf/0EKGCsZDiJjYQOGLn9+T8YiJGu6lhmB
	 0EBLI0lMojKXAsPai6tT/xO0hR8xkxpBG7emS5ZHskehcG7mcq3MNUYWGX+l7HEzlS0CK
	 QR8Gq9zrWVvIptRmFUl0SaILstdRb1Pwglrb3CySEshCzKqd7+1G+yRVk6JPQXXpV35Oo
	 bUTT8oPKd5wYNsSdnXR6HYJiMhUnfymjXCkDbd9PPPFO6bYl+ORTnasOxuoGtEjKmTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508683;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ktOgwAOwraZXdSGGmxZU7N961zTx7X8/XnU772S4DbI=;
	b=izy/AmmpZkZsJotEcjbhNSfjIzk6i/XEfrN4VZTahiqc9DkwC32tD9P5BpaLK4F/SEYG
	 OELO3R4jNJVoy6iZqx8p9rOaCo2vU3iy/HSWKRWVwtgkY3Sux06A88EVpqBvmnrrtb9QW
	 06Q0dBTm0/N+/U0x4ZpJzq3+ke9zM3tl9AXWOh+OBbZkpyoFyxlXC984MadTYgcIHGIqH
	 OG4r/gJ3F0ZvvAPvdIcjgdx+Qn9+ckz8Afz5sc+DXP5LdtpYO7dejuPHY9JYo6PViZc8p
	 xvFKSOR+P8kis+miq76vCcjGCTipT1bRipICVD1hQIIGR4ZU0jpmYzMrDNAv6jHKTKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Mm/G4KYV";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF6606A31E;
	Tue, 24 Nov 2026 08:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3EF6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mm/G4KYV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795508683; x=1827044683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/HI6vt5Le6CJlsERF+xfPnIykjrxGbGfzT/4rhuNbZo=;
  b=Mm/G4KYVzKY+z2BupmKr8ciL+/axD3REC68e4XQhJ4ulWPTHWgrfp4QA
   dT56vvKAHhlHGTYksmlPCQ/kCk+6ufJVKlENNIPBWimY62jvG30sXr5M6
   7NfJyY49XnPCpUl4/O6QUYOnEBWWh0txkfVKlYQJdcKyRfHYNYNEFsOy6
   SSqgofjuVKGvt62fOUNRSYlNP7RqS/dRmrjCDABbCEpzcR5olX0ulzMEe
   KlcOcc33KNtIWx1U6h/5eySOB2V4rN+q+qUNTwMtdIncQF5/lrexdU+Sm
   DgEzx/S4mx0A5udfd+/SA/U+mzioarQV0vT8PSkcNImuNozI9KZvkaVhx
   g==;
X-CSE-ConnectionGUID: TwwuITSFSzKFyow2kMEeDw==
X-CSE-MsgGUID: 3GeqzSc0R+OuMVxIAEJ3Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4441054"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4441054"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:13:14 -0800
X-CSE-ConnectionGUID: nMrFpLm4S9Wu/8/TQPDPNA==
X-CSE-MsgGUID: F7ghSV7rRjylVtskDX8lgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11836178"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:13:12 -0800
Date: Tue, 24 Nov 2026 10:13:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: pressure: dps310: sort register field defines
 low to high
Message-ID: <awVHFUVYPE6W4izB@ashevche-desk.local>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
 <20261123220649.36887-2-zoone.rupert@gmail.com>
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
In-Reply-To: <20261123220649.36887-2-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 12:06:43AM +0200, Rupesh Majhi wrote:
> Some field defines run from the high bit down, others from the low bit
> up. Sort them all low to high.

Have you checked which change is less invasive? Can you do it locally and
provide diffstat

> ---
>  drivers/iio/pressure/dps310.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

^^^ like this to see the impact?

-- 
With Best Regards,
Andy Shevchenko


