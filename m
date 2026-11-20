Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191797;
	b=Ct+X3p3ZMwlUxgjjn0YsQ4HftEc+ahRUj9EMUW73SOKvKfnCvDDvV0ROX7Aqppqs90qv
	 Yro7J/jLpOoC6RTNe4/Kh27CLWRrpkaAQAy3cE19PW8w9zd+EkdVu+OPu+CCe6p0v5Va/
	 1uRJn1azR+dSbR1IbKR8L4wwNaxrtSNJEOqdnh0F66WQBGbwS8VPnThhU2P6uPRtWtz6c
	 Oprj+1BPTyLxdqL5VX0RzyiczMTMFpJf+lzayjvPitXBRYgce5R945GOdCrEFCN1nhmTl
	 JsxxTc67L7MQT+yh5c0LJOZ95+giyoudXq9q9cRVXzuBpPEm0mU1rltWZyph/V2TRJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191797;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=pypBqt+kRGHTq/pNqIvOFpXBoTqEtQem2d/1H0qSxyY=;
	b=alvCQ7pPFBgvkiGQuvokkWXCo0cKpFoadpdpPLqCLiPsbu0umkKaX3Quhb2/8aOwHPm3
	 q2uRkjcZKTyFFSCJB2hlokE6QuTuH/1HWAGHRNFCMtssQkmMWppdI5xqFVQ4CLeHs6r4C
	 keLIndhMhiqWGG+Dsue637uK1nxKl4KTR8EMPQyVoERCtq+a/zk3Dwg3FrJmanMYEiS+E
	 CKhHDdp/wLFTGVyzvrukz5zDsrKFXvMqFyIOOS/a/5AwXbOH6+CnjpGOJyr+kes3+gM/D
	 aKEc+piJJ+fEhrYJ0r241O59SbD3FcDm1XnHnas+Fha17ow8sBO1OZsDg4rpbApXXPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VWbYSLU6;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD7606A32C;
	Fri, 20 Nov 2026 16:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17BD7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VWbYSLU6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795191797; x=1826727797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xw2S/gCEuKO8T6SmoWskkuyNZJoPqPVW/CrOvK9BetY=;
  b=VWbYSLU6MYMkKqb6j/KYB/2NIqvd8iuRJAPWMuMT/W/NltsHwA+zyZ/i
   GyeZmj6/tDQuNmu4DNuo3s9Cd4yarhle1Ll1d1XpIJ/k4DIcnGe3I7wO9
   IhaQ+ky0IcPV0bDYY+lollPvyB9uvTnVJYBYLjITTxEp4tcTo+cneUaIQ
   kbjwqH/fmWAtcwUkkFQNCgKUvG7L9bthQ2feeDI89cBVCznkoRBQFNtyd
   wfQ2ixGTDcs38Rf/FhseLnXuNbIAKU0C4mw7XsEusNLW4pkTI9pZbWbAW
   m88kVTTX0KLSXMGunUXg0phWc2TXFeRoVHCgQtEtf5LQN8PQ/rCJTnZgF
   Q==;
X-CSE-ConnectionGUID: /iHHqblkTf+Ccfpp2bu/bw==
X-CSE-MsgGUID: +xLESelgQmqWGrizW9ODZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4082305"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4082305"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 08:23:17 -0800
X-CSE-ConnectionGUID: yriir2BVQNeI87JOEN2dzA==
X-CSE-MsgGUID: HGv1M46OQX+6ao87v+Ti4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10742326"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 08:23:15 -0800
Date: Fri, 20 Nov 2026 18:23:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] iio: buffer: kfifo: reject lengths exceeding the kmalloc
 limit
Message-ID: <awBz8LVSYVBFOANe@ashevche-desk.local>
References: <20261120132129.3110-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261120132129.3110-1-25031212351@stu.xidian.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 09:21:29PM +0800, YuanZhe Liu wrote:
> __iio_allocate_kfifo() rejects lengths that would overflow an unsigned
> int after kfifo rounds them up to the next power of two, but the byte
> size handed to __kfifo_alloc() can still be beyond what kmalloc() can
> serve.
> 
> The kfifo buffer is allocated with kmalloc(), which is limited to
> KMALLOC_MAX_SIZE.  A larger request has an allocation order above
> MAX_PAGE_ORDER, so the page allocator's order sanity check fires and
> enabling the buffer ends with a WARNING instead of a clean error.
> 
> The buffer length is set through buffer/length, which accepts any value
> up to UINT_MAX.  With the voltage and timestamp scan channels enabled,
> a length of 262349 makes the rounded up size exceed KMALLOC_MAX_SIZE
> and triggers the warning on buffer/enable.
> 
> Also reject lengths whose rounded up size does not fit into
> KMALLOC_MAX_SIZE, so that enabling the buffer fails with -EINVAL.

...

>  	if (roundup_pow_of_two(length) > UINT_MAX / bytes_per_datum)
>  		return -EINVAL;

So many developers of this patch and there is no clarification
why we need to keep this check.

> +	/*
> +	 * The kfifo memory is allocated with kmalloc(), so the size must also
> +	 * fit into the largest allocation kmalloc() can serve.  Larger
> +	 * requests need an order above MAX_PAGE_ORDER and are refused by the
> +	 * page allocator with a warning.
> +	 */
> +	if (roundup_pow_of_two(length) > KMALLOC_MAX_SIZE / bytes_per_datum)
> +		return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


