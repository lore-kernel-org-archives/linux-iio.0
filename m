Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E53E318ECF
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770162630; cv=none; b=fh3WhxYb8VMRUjdz2Lpv+twi1mS/sZcD7XVq3R7CXQPNb2syBX0UdW6ak1K7OCaa1K/Vu20MDMq8TxDc+ODlwJJ2YYpSLbCOtK2mLI7EjJW7U2D6NPwY1HTCGGFAlCpnsDPSBCe3AgYDjog+0eZRX9PkSfzpXUu9vm27wlmDYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770162630; c=relaxed/simple;
	bh=q0i/48tYYzYNIhHeVT9r8YzuHXhEVxRrCECXoNS79wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcrdaFq6RDAzWTrSDBzCOyN+C+aKgd1lJS/63hqxgMC63AjVNHt0OxwjdKgyXGTLTAnyD745SLI5nwksikLvsnr5Z/+5EEWkZLL15+WaJOBkBGmfijtHhoY2R24bBv2FOpJjor/BqerShdS2K+nna3wKGXUUkJsLQuCfK8pzdis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiBsvy56; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiBsvy56"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770162629; x=1801698629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q0i/48tYYzYNIhHeVT9r8YzuHXhEVxRrCECXoNS79wM=;
  b=iiBsvy56YwpYknqm9sVSiyr3Z6WWQkPo6DftGZb0D8dKZH+X5+ftlSOX
   io5s/V7iFmkIjak58tTThG62neCZfZ89bZuiGJpTdaBe/0xj76IZPcUeX
   3dBttISng/Bzw7gGhECFNpFVa+WwcQV98xRewGNifxoRf06ZAi9/KuJjO
   2HfZ4f79/Fcq/tG6eBFPeuEjnWot/OkJtSLTEf9ho8KtKVS3QMt4ZQpo5
   hMb4g9tD2/u1+jrS1+UhLojcvovzqlBRsyV0quqx7K4fcwHJmQVLwd392
   SO5/JPwSOKCjATYnlqTr6ujLC2h9X7d1YagqsLlJwm6EMoZUGz51ci7TW
   g==;
X-CSE-ConnectionGUID: tNI8xWBSSwuBNp3MvtS/DQ==
X-CSE-MsgGUID: 6j17lh7OTR+ZQiPk3QP/ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82776077"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="82776077"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:50:29 -0800
X-CSE-ConnectionGUID: 7TkDv5HqRq+gQKMOK60znQ==
X-CSE-MsgGUID: e8zE3pQrSrWVxY3Q4MQ1Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210099956"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:50:26 -0800
Date: Wed, 4 Feb 2026 01:50:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 6/6] iio: gyro: bmg160: add support for bmx055 gyroscope
Message-ID: <aYKJwBG-Oqj2fBtH@smile.fi.intel.com>
References: <20260129071105.389493-1-jerrysteve1101@gmail.com>
 <20260129071105.389493-7-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129071105.389493-7-jerrysteve1101@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 03:11:02PM +0800, Jun Yan wrote:
> Add the gyroscope driver for the BMX055 IMU, which is an integrated
> IMU including accelerometer, gyroscope and magnetometer.
> 
> The accelerometer can be supported by the bmc150-accel driver, while
> the magnetometer can be supported by the bmc150_magn driver.

Same comments as per previous reply.

-- 
With Best Regards,
Andy Shevchenko


