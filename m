Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008583;
	b=WBJrLYylyF+sSQLXZM7rB0qdPxdY5d+0ZkVGesrjeeLQaq4RU4dtg6a0DuyakXR7bG6M
	 6S85A2bk8JFqZxXY/J6AnUQjXkRa2b4oZU9vr13dFEseOUwD1gRMiKNmAciEtyfXVOHbU
	 Rp6fZqBIIReqZjxtoyiLwtLLF5hC7NY97DBMiKvTG3bWLao0HuEsUTNKf5gjquKCEnoso
	 O7rSGr8uW9F+HzzRKDnesbJalD8gRFi+9KhzN1kt58Z9v6p8Zxe06iYvq3jXMR+ybSUul
	 UIH55ObOUeRk+xu7K/BMCQk6luJf17FLQckTL7vlRRkUrAC2K7eIKa0iYi9ZgXM1HNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008583;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=BdxCPPslQcmvYdJGtevC2n5MYTSoaR3pZTkf/Mo77KI=;
	b=iyWUytdpHbEZcJa11WTek5SWbI68Rtq0Z6BA2kLWEBnCZd1hXABuigYgWpx6B+LgJeAr
	 6E9nZ08s3/rxu26ADo5b7arY44t4gH9FIxvpPip4aI486PoCm1R9a/2oFs7VD3NN3sIpb
	 hFN4n3J1V38UZA+7kWFCokMe28EPVwdqJsRo8WrabbN7VXyJv2I4Bkw9ErmBTbBcYFToy
	 w+7idpszolAv8k4YJHdzZbZrchlTfMNC5YWY4y8HtgEKdvpHFStr78Cr3lpVEf+xzDO/f
	 Ax1IOCQFTHnHN/TbwqySfgndIDX3VJKt0mJXQpYj3fdmgY3YlcdbohflOIxVD/GfUYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ZkxGvdz/";
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C387606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 09:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C387606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZkxGvdz/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793008583; x=1824544583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mKAiqUOxwUlnoDtPPUmHppSDZgcmbuogMYMfyjNE4zU=;
  b=ZkxGvdz/X8mHD7wE2Bt8nacXN0h7URSAm+DEDn3bctRwyVwGzYEwRsdU
   bhjZIqLoRrGDl8CJ4GVeiM4YOHiePnysNw2IXLSuR97YJirw9JoPXX0Xh
   Q3z3tnTNxF1GfITDwHE0VNnWf7O2AwS4Jwv+yIXt5BpNcfOC7kvwC5RNe
   YnKXVjSGyOneE8nkdaWJQy6RAYgQjIZILkFyUTx6oDXWLqhDTrKqIXMJ+
   Z4g2ANmWuZJzTZbsfN2HeFNeVfyc5LkGkK0G5G3BdAFPF6uKzGWeUIW1H
   eR/GUewVqfOCXrtfEitEGUozrF8Hauj5KwW/KfxhOWDJ8WxNQ27vDS3YN
   A==;
X-CSE-ConnectionGUID: TGK1GaHvRNamgEsTJl16SA==
X-CSE-MsgGUID: 3aIyaDX9SDS6++7lrdM47A==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1554200"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1554200"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:56:22 -0700
X-CSE-ConnectionGUID: IeU8jphoSAKHMXcXdu2Brg==
X-CSE-MsgGUID: 9bQjQ6yPSReeEW6g2B6Wuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4171872"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:56:20 -0700
Date: Mon, 26 Oct 2026 11:56:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] iio: gyro: fxs210002c: Use guard(mutex)() for
 remaining simple cases.
Message-ID: <at8jwktzrbADAh6i@ashevche-desk.local>
References: <20261026032051.1004536-1-jic23@kernel.org>
 <20261026032051.1004536-3-jic23@kernel.org>
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
In-Reply-To: <20261026032051.1004536-3-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 03:20:51AM +0000, Jonathan Cameron wrote:

> With the exception of the more complex flow in the trigger handler,
> all uses of the data->lock are switched to using guard()()
> simplifying various error flows.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


