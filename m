Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168491;
	b=Hevfq+/poAf1N1koE/FMnAgHyV68+2uhPkplv1xj+ekeAW8epuqTSS4jHRUvj8hTtJ00
	 SHlx8yYFko7TbjFZysadmQEnhyTmjXiTcFQOKvPBGPOM+KCpxWASlIZbF8bzlbB752w/O
	 j0v6gSIjra/gzV9ml9cc3fGR/3+sXScjIbMQMeu5mqLVRgNTsgiU2MeKQBONOPxDb5jqg
	 Fn9wQylZrlpR5ctZ78pgoEZvECQIkaZsztMwGO9dPx+bFQz1lYpvVHuTt5K2Zk6uftAaz
	 Onw9oqCSMviaWceli9+msDKuQipT2xDc1fKTHPpXKKfUd0hK/g3J4y7m6n1d+VsNleA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168491;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=1yPKoraN/U69kT7YwQ42gCWawcavrR5NAFkT6eUnIXk=;
	b=hP/5H5iIV3sBJySF1j20Jc1fMpOH7BfRiaDMQccU5Y5qcxrRF0VfhY6jkomgTNRJq5BR
	 IXrL7+qrdg0sFsDrwcvN8dL1Q2vIu+BZ4DreAfxBBsCELUj7ATZn9XKTNCPN79aruikWd
	 VPi0fbjdy0ZT4ScrOd29ge5JItkfV1YzsS/sMFcwrR9Sjs9AsLWzkKRX/IYoAJ0C7tKfN
	 hXdsmJK7EgAXp4CpMGIw+qZiKzRzrbdxYJGkZbG4SN1K2wY9V7sCx7jBHGS5TZ8/uv7KB
	 0b5yX1s3F70yzdiRN5qwjxl7urHxcZ8HO9Uugs+QawgAF31e+xAxp0UWs2BCEb1gVxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VP4UGr0q;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4A606A32A
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9A4A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VP4UGr0q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795168491; x=1826704491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xDCHAsK1g2UEK9JyJ+czP9lIEqCzeJEeV/YLI5nBwbM=;
  b=VP4UGr0q+TJoxWRwFO97X5nfr2cKa3KazzjoV/wOIi3R9M8ALATsTIvN
   kHvKhgc9etmpIMkUJkz830IP2ZMgK4Md9irzUnfRVxSva88CGfWtYfDZg
   OZdqwgDNjOoAR4O+CStSZuisiqaFj3IW92VNULyzoMEQOc7y85eWRA260
   +43uDVqZ26K2KcSbRh9dSL3x6eUhoxRwTnwAPhb6g8tqo8JtMTcEtqgLx
   put3ReLkG85nGEsfuqD73mIxcj/Sox84Wakoj9pBP8TIkqbtIyo4xbNDH
   Drg1DGVfyEdCt2qJX1u6JgE7BCEO0m3aloAFiHaqy5lTvi+4kHimg7Bkp
   g==;
X-CSE-ConnectionGUID: EeK0vzHYQ8WdiG9JBNdsDA==
X-CSE-MsgGUID: 4CkdQJhrQh6ou1QEvpj+3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4088466"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4088466"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:54:51 -0800
X-CSE-ConnectionGUID: IS+s/TSGRzeDeQADPADawg==
X-CSE-MsgGUID: owGFH1VbTx+8HC19GVHqkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="11237300"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:54:48 -0800
Date: Fri, 20 Nov 2026 11:54:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oscar Alejandro =?iso-8859-1?Q?S=E1nchez?= Lucero <aleszlucero@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcin Malagowski <mrc@bourne.st>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: pressure: abp060mg: Use msleep() instead of
 msleep_interruptible()
Message-ID: <awAY5umCN-RiP2Iy@ashevche-desk.local>
References: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
 <20261120-b4-abp060mg-fixes-v1-3-2baf026cde47@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120-b4-abp060mg-fixes-v1-3-2baf026cde47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 01:11:39AM -0600, Oscar Alejandro Sánchez Lucero wrote:
> The return value of msleep_interruptible() is ignored. If a signal
> arrives while waiting for the sensor conversion, the thread wakes up
> early and reads the sensor before the 40 ms response time has elapsed,
> resulting in stale data or an -EIO error.
> 
> Use msleep() to ensure the full conversion delay is respected.

It should clarify better why uninterruptible call is better.
Do you have any datasheet reference that states that this time has to
be at least 40 ms?

Also we have tons of the IIO drivers doing the same. Have you studied
the history to understand when it started and what the motivation was?
Perhaps it may shed a light on this.

-- 
With Best Regards,
Andy Shevchenko


