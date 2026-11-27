Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793528;
	b=qc4GWXh9nQfV0OjjM0oh5QV/SQjkqPrGyJyS1oRUKZtYHl1jAa+mqiib6gGRqcbfOfYW
	 sXcB9HmOxI4YpORxRCla9hgSk3rdfyGbwMePhin6RbX8APnoJyFk/wbRl1Owtn4jMUDWV
	 wA3/YFOpg/srILihxCiCmYYUoIybDQpZdBLtsiBy0ADKaGZUr03IJCCbK9st1yLHSonfF
	 fTIMSKH3BmrlBGIl/A7gMMY4/lJEuKekHO1Hn9vgmChaHALPs1y5ge7MVSXs22cxfZrU3
	 Lj2ImZEuj8iwJaGpNRb1EEzXlXQNR5zbM9QZV7S8U95PkaS2aCnAWT4vh0H2dVG/SiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793528;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=S8SIjn5jhpWrO4H0i18sVftbBxRoyw9+zah7CQ51v2M=;
	b=UL8cEu+pSh50JG4lx/vNDDnR0d6jRu/CMh2P9SE7OGpUvFHF354UOhtMWIFC5R2pPOMu
	 VVhk85f+DS0kMd5rPIyTOo1bt6Z1lpvfH7waPwxBslOD+Exw0PeFkNQOh4ARbx2jj6UFp
	 liwxAz6FAHLLHveHcwQrPWV1AX+5JxFAOIQetFZvnB3pI3BM256vCvPpItojscE6Zeyl/
	 UHGaGqIeWs4eJYRYIjVW6lf7Zg4Zjs0tPo8WmBJToZW47OG9F+VqoHkBK7fZg/Y0fDLin
	 5rf8aSqzVcEvrV7cPAQa3byFL6i6XDAVtS/9fFrjw8OEP8JWYWBfnG8wCwsx34hM+hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="fdh/WF5S";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C79606A326
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 15:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C79606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fdh/WF5S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795793528; x=1827329528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lClgaioM6X/vpnkOdTOvJo7RDPggy8ZlNTMehLTbj0c=;
  b=fdh/WF5SfwaFQU61YfKGmXfYCjQpMi9ASaO3r0Re7YXFQ62EJjV3o9ky
   42waxS8l696mJQfOhlxeIRjTDTkFmcB1e3usmu9UNlqCJJ6lPdAFD18+r
   7LMmf7fBxmUh0DcHS/qqztN2+PjtqLZcEIuqBm7oNJgud8G3hQoNnREAR
   ZxjgB7PcpyUMghvyJ+LebE7Y/FyiagfZerYxzOi8pxCyinZsyozT5Dtu5
   BMrNpDTlCtWBd3kUyY9zy5RYpvkMPqMPCKuSSXivB/yRG9heia2VKF3dp
   bK9/8HWp1BkTBoBlv84evTLhrMRb/yMD5OtiRURc80GbWihgvVaChy0yf
   w==;
X-CSE-ConnectionGUID: dpv+ukbITy+3GW7HBkUlKA==
X-CSE-MsgGUID: iarix6p7QeK2vKBLBG/ySA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4618616"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4618616"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 07:32:07 -0800
X-CSE-ConnectionGUID: b+8pwmFSTjSKCG8MEl237w==
X-CSE-MsgGUID: fcpE+hmFRUqX2pZ5MJ1f7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="12744811"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 07:32:01 -0800
Date: Fri, 27 Nov 2026 17:31:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Punnay Sharma <punnaysharma805@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux@analog.com
Subject: Re: [PATCH 2/4] staging: iio: impedance-analyzer: ad5933: reject
 frequency code overflow
Message-ID: <awmibz0Q3bVMMq0M@ashevche-desk.local>
References: <20261127123303.144052-1-punnaysharma805@gmail.com>
 <20261127123303.144052-3-punnaysharma805@gmail.com>
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
In-Reply-To: <20261127123303.144052-3-punnaysharma805@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 06:03:01PM +0530, Punnay Sharma wrote:
> With a 500 kHz external MCLK, writing 30000 to
> out_altvoltage0_frequency_start succeeds, but the chip starts at
> 14374 Hz. The attribute then reads back 14374.
> out_altvoltage0_frequency_increment has the same problem.
> 
> The start and increment registers hold 24 bits. ad5933_set_freq()
> turns the frequency into a code, freq * 2^27 / (MCLK / 4), and writes
> only the low 24 bits. A bigger code silently loses its top bits.
> ad5933_store_frequency() only checks the fixed 100 kHz limit. With an
> MCLK of 3.2 MHz or less, 100 kHz already overflows. The datasheet
> suggests a 500 kHz MCLK for measurements between 100 Hz and 1 kHz.
> 
> Move the conversion into a helper, ad5933_freq_to_code(), and call it
> from both ad5933_set_freq() and ad5933_store_frequency(). Make
> ad5933_store_frequency() return -EINVAL when the code does not fit in
> 24 bits. With one helper, the check and the value sent to the chip use
> the same math.
> 
> Keep the 10 kHz probe default, because a probe failure breaks boards
> with a very low MCLK that work today.

...

> +	if (ad5933_freq_to_code(st, val) > GENMASK(23, 0))

Perhaps >= BIT_ULL(24) ?

Then it will be in align with the commit message and BIT_ULL(27) already used
in the code.

-- 
With Best Regards,
Andy Shevchenko


