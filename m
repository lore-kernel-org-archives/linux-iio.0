Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250191;
	b=JAvHcK8k+EnJbbVP60y+JAr6pHnlX6TbkkZAoP8sox+SPSm0eSArjHA1f+Mkjmm79/pW
	 8b+AzDHAprjP7oQhvOXzb2369i4AkvxJBGIpQN+HaFWSsrgNhsOErOPlyYs+FLYOq3Axy
	 jD/x1XeCgEvxxla6GgHOiQ0injuJ3CD+kxXTJVJplq6G317YygvESUw9rzAPm0nx2B1A+
	 dK2NF+IQeGpc3wClBmF9Trk68zzYhEVx6snLCLE2xWqY+DieCuz4c/6R60gfrCDp/yCgS
	 IxKZ/7JhA3SEkUih+63MTr5W7cO8rODj2YKqm9ZkwwuV+8qzjuS/D+eluHVwh/gaZ2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250191;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=7fnUah1bZX3XHKfwoEOEzV7p3d20TcOz5QMfYxwzzJg=;
	b=ioKPzNJMKsnSX2sTKyXuszCH6JsEkboaizjCygqov50JJWhEDZYZMiPf07lcGBU28Sua
	 DPQ4NRVFtTyjQ6JoEzXUHU8ItDoS6njM0KIa1iaV/pmqJQLjmKT0gcTcTxs24A1zyWOq+
	 9wy+itLqv5+zySkeacW0YmEH+oXEw9rrYTFL8b5bgsfRUQS4zHVQcSe/NGtNgd2rreMBT
	 H4pHOUBXDEPBYPs8ka1kZyDE2Rk87c+45fdEc+E1hj4SIA4o8nMpRYstOBO/JMqf7o4Yd
	 W8QPFqKKcbf4o2xLsz89zpfModLA4O5zMrVhJs91vSRdXVM0tMbkAX7JVZzKP3XevSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kp6LZyqr;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CA606A321;
	Mon,  9 Nov 2026 18:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 882CA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kp6LZyqr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794250188; x=1825786188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vs/XZYC77i2kEXa4qi6awQfogjarhrCpKrtlhvk7XuY=;
  b=Kp6LZyqrEWKa8UL+BkMtky05aDZ3LP7BHtMkjgO3mt0W6x9OXfP84oyI
   WEBP1yZo0UIBQN+zwE6TgqiEvhEcLo2tXoSicA/Ased/9drD56MIh2PWL
   3eof7XuQOVGgre6uWBa1SiEO8P3R2by9AZvqTeTBV8m0y0Lvvl6A8XQB2
   cojYH0+khAnKohHkFs6tHnQunEorHOS174U5Mc8TbhNIk7YvId/ytNzU7
   DAP3iZcGcmtnPu9ADJAvzg5P3IctAxl9vhK6RSfjUyslwGEDnRFfLfxcq
   1F0gRDqJzc2K9jGaQaMbmS+qcWXLXAHMcdRgYC8vbvILedQeIZP7SRBfi
   Q==;
X-CSE-ConnectionGUID: XxeN7cq1T7SmBOCfp6+9vQ==
X-CSE-MsgGUID: vuFUHRxNTquj04khOR0r7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2871188"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2871188"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:49:48 -0800
X-CSE-ConnectionGUID: hUA5GC7fSJmJc686mgnxIg==
X-CSE-MsgGUID: SjRqjosLTeOzV9JIAgipuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8125992"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:49:45 -0800
Date: Mon, 9 Nov 2026 20:49:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com
Subject: Re: [PATCH v6 07/11] iio: adc: ti-ads1015: drop unneeded < 0 error
 checks
Message-ID: <avIVx26ptPBz_tR0@ashevche-desk.local>
References: <20261109165805.31160-1-architanant5@gmail.com>
 <20261109165805.31160-2-architanant5@gmail.com>
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
In-Reply-To: <20261109165805.31160-2-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 10:28:01PM +0530, Archit Anant wrote:
> The devm_iio_triggered_buffer_setup() function returns 0 on
> success and a negative error code on failure.
> 
> Use a simple boolean check instead of explicitly checking
> for a negative return value.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


