Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700649;
	b=3IRAmOw+o8hVHwYQg2D5s4Y0IzUS8pJCOfOuABuZXtuM18Vg+AfRjsjy/MASYq5g3xzE
	 by4WrD5SYzEIfTP+ydfJKAPkcUMIjl52pHSJuDoCMBSg0HNVsm/bZ4O0FvB5MDxi8vyaS
	 +rhBvf41wfARrQw60mA3EUB/KZVjFqegwxs/IcjamuRh6lzMPe5nlM3TUSQdodYKc9eQI
	 Ou8HohVZiAzmF87RRGBOqIk7ONefqUWPU5aDagHn1JabB+tkBhg3sbOCSl9lNL1CXkZY5
	 1niB3MkSCEPQw4jk30yBGAwgayCY4aRX+BRFTJK4HU/geymiaO/DnYaXzT3w4Nd16yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700649;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=KKjRcMgA2od1JAUQ3NDEJd+3pJ6utv9HJwQINe7Cudo=;
	b=n95Nj7933JKjVcytJxJiz1GD0sIh6fkWVVJ1fhShDu7PEGCTstd5VlcrIridrmj7ryPR
	 2JVRjmL83klwpDEVuJORKVCF2FJTp5K70BGa5auN7/fal0X1A//D7kWJeG8XVhouImcwc
	 fRd/jBs12tFeWMFgBUhmfFfrWa7qXo1K/jQwBgdDT8sXH0dlIDCT2VMbY8YQbmjE6nY07
	 VaYXijopzXEXR5ZvVrFuYKwUyov4i2mZuuSHlpqfSasGD4CZA4Nif8u5kkwQIeMJWjwtT
	 DKUOgBM816nrE/IatXxOeQpdiLVkY6DrRVZ8M51/UUB+LeFtEFy0kycs6tJEuy+ypTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nK64mHTD;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D76082BD2;
	Tue,  3 Nov 2026 10:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 524D76082BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nK64mHTD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793700648; x=1825236648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qLeNMV9ESxS4vfP26Q6ujH3mVp4IAYKlMBiwJ2rztyc=;
  b=nK64mHTDuRqNfCDxuCrjiRkMWyv0Hy70+2pKQeXqd8MDkYJHPH713aB2
   Kg+WT9rxP5X6QkzQDfsxwM040eByk7GlkG9a+t+OGZHPu5FeAh/Tr2pHX
   ELNB2G8TMSeG57r9EoZEpaSJNpl50aVnt52MyKJjgUe/zSIUtr/YOhl9l
   ltdaLyt/IXjN8CX+3GzYLkfUy05MjB9sTxJXWjwtaLFO7ollfK/imFcdP
   eBGB2hHM8djbEQcR0nYEu9nrc1bGDVURSS641WGy6FvyU4pYUQAgfOzqM
   t91VQpRI866ZRnQU81SMa7o8CIrMi4f6B3f+Pu9ccXqp23M0NmYQbW0FN
   Q==;
X-CSE-ConnectionGUID: /PD3c7YoSwOFAb74OzsHvg==
X-CSE-MsgGUID: ktY+/j/CQvuz67T4vyuX8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2415067"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2415067"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:10:47 -0800
X-CSE-ConnectionGUID: cVqWb3x6TMefkE/gQOoIFQ==
X-CSE-MsgGUID: kl2DLb2fTzeQYxqtxFEZLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6400206"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:10:43 -0800
Date: Tue, 3 Nov 2026 12:10:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, amitrkcian2002@gmail.com
Subject: Re: [PATCH 3/6] iio: adc: versal-sysmon: disable interrupts on
 shutdown
Message-ID: <aumzIdkwp_jVcTTs@ashevche-desk.local>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
 <20261102122112.1723130-4-amit.kumar-mahapatra@amd.com>
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
In-Reply-To: <20261102122112.1723130-4-amit.kumar-mahapatra@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 05:51:09PM +0530, Amit Kumar Mahapatra wrote:
> Interrupt teardown is registered with devm_add_action_or_reset(), so
> sysmon_disable_interrupts() runs when the driver is unbound but not when
> the system shuts down: device_shutdown() invokes only the driver's
> .shutdown callback, which this driver does not implement.
> 
> The device is therefore left with its alarm interrupts enabled in
> hardware once Linux has stopped servicing them.
> 
> Add a .shutdown callback performing the same teardown, so the device is
> quiesced before control is handed on. The helper lives in the core
> module, so it is exported for the platform front-end. It skips a
> device described without an interrupt, which never set up interrupt
> handling.
> 
> Disabling the interrupts at shutdown is safe to have and not a must have
> requirement for shutdown.

...

> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct sysmon *sysmon = iio_priv(indio_dev);

Side Q to Jonathan: How do you see having a helper that unites these two?
Something like void *iio_priv_from_drvdata(struct device *dev)

-- 
With Best Regards,
Andy Shevchenko


