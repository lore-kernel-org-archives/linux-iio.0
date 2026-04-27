Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C339A075;
	Mon, 27 Apr 2026 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277990; cv=none; b=upUypOYAcSyL6rt8SCGbHJIQiRI6bMRRtmgjQPwkTTMeRkSH3Ti1JCOKPPPh/3dBWq3L1Z8p3n7WvRgCj4DD6Hdf0cmSVXC8JjBXiWcWCEn8kTupF+ALB3AFqAGkn4TID/gXbutGHMv7uU39tIF23A8fu/gEcHJfi05pi/Tfl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277990; c=relaxed/simple;
	bh=zSTUQMFQJPKi+FQrzszpHUaPPQDHtBJI69q7X9gW2Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1kf0MEFz7H84UrNPoyjcwpobNh+ZpakdpMYUu4BiBVQsrQhv86jcc9ANjtpF+cM24BLaxZif9r0Ln22FBe3BdVv5iNwRZar/o2TyL00vmJhw9ATtfaNz3fimNzguB+3wPNOyXGaZfDLhFJPiBjSYObcX7oNcMiEdADTwX0+mqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqzLPp4u; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqzLPp4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777277989; x=1808813989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zSTUQMFQJPKi+FQrzszpHUaPPQDHtBJI69q7X9gW2Rc=;
  b=SqzLPp4ugNrNfOsilu6U3xvkZKRZcMjkDUBbiCHr8T+QrwdsP3CJNAQt
   Bu/gs4/8DRhmU7ka474DQ9hvhO/QBlK8F5DZVR4fyQ8zBVkkyBW65y8BZ
   11WBA5rrMUoxDAS3DOAQFeXMUcqIXe0sIb65BkPZh3T2QT6UQO4QIYyCo
   iM2HQa+ByEkxcWQ8VmjPjKjAuR14lqqQIZk2Up3+U2rgQIcbuhN83YAE1
   VMcc3L1HDCb2kYRY23kX1imVY2NhVVJds0yjpwg6hQxM860n2fAjkglc2
   qdZ0w225kjaCb6htpmRINE5uMzah0sclV+Fyzw1IRbAKdAgKJOjBH/jCc
   g==;
X-CSE-ConnectionGUID: BnRh469UQyuiz+Nf00q1fQ==
X-CSE-MsgGUID: 4YvPjQTgRK2S7JOa/DKKEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78144392"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78144392"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:19:48 -0700
X-CSE-ConnectionGUID: H9hcpxxmSh+tPy927P8VEA==
X-CSE-MsgGUID: PXZloVtdRiKNMBgoxbWt3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="235346685"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:19:45 -0700
Date: Mon, 27 Apr 2026 11:19:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, mingo@kernel.org, christophe.jaillet@wanadoo.fr,
	nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
	kyungmin.park@samsung.com, k.wrona@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/9] iio: ssp_sensors: Use dev_err_probe
Message-ID: <ae8cHyDYFTZd0a6A@ashevche-desk.local>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
 <20260426091710.3722035-9-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426091710.3722035-9-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 02:47:09PM +0530, Sanjay Chitroda wrote:

> dev_err_probe() makes error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).

...

> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> -				   sensorhub_sensor_devs,
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, sensorhub_sensor_devs,
>  				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);

This change can be done when converting to devm, it doesn't belong here.

> +

This is stray blank line now...

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "mfd add devices fail\n");

-- 
With Best Regards,
Andy Shevchenko


