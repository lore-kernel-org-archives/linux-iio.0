Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30640D58C;
	Mon, 29 Jun 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741221; cv=none; b=riXNnHzffoHWigz+Wu51iCJUy0otHwUciYyXSUiaVeK2gfCKwd+iArvebJTjhe1SDw1evnqrdIqDqBABZ2obh8qr+XRhIKKMj0qfpUT4PJ44nkZcunzKdQFbO98AzjNEABoV9yf4FfQF3z02r0g8JL8q4kns37D0kqtQBjsn/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741221; c=relaxed/simple;
	bh=nhC4N/RoN3vH4H4XL5Lh4kA8NMxwTy59ncOjPdVNhdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC9MLSgIKWzYkDcusnrE7hNWYy+kqCujhU7dWGync9GHQSyLucegvHozL032KXJ19aU9FAshyct6sgnhQMPyy+9rdtTHqouTeDp0sATAs9+23KUHdJS5XPmaXfqaB3Jo26C09mbFvYDfA88dCmLOA4k86RF9388drtY5n2Ya4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTbxVPBv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTbxVPBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782741221; x=1814277221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nhC4N/RoN3vH4H4XL5Lh4kA8NMxwTy59ncOjPdVNhdU=;
  b=ZTbxVPBvvK4F8/hZ+FxuZ9NMPQC9JybbDF1NTWMWTHjVPVRbugYzaoaV
   fVVibUHfO2OOGtZuTc3GAD3J9tARFVnwbxcYpTn1QMCfWVUDV6n92Kj77
   +cKWZ4aqEO0/sWhaMlwYkH99c4njPPZBsqzP7QHY5AgKLSMAx4aoqylzZ
   05KjBxmBa63whrD1f+qKCkg5ccwUHfG7j2WhPDHFzGbTlSmH7NoqriUTe
   nGnFjRp8Yxhd7r4cGjPPFkOU196d2jPinXqh/3iiMGxG4c7Z924tbVrJH
   l9xyS4G1FQYW3PCw5dUJrqLp1bqfcaKTpdy5diJ0kz4/DYX0yJ9S7SQx6
   A==;
X-CSE-ConnectionGUID: /EsKsz87Q/yxzZz2mIruTA==
X-CSE-MsgGUID: luoYyrhhSZ25jz8YAfgWdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="106224258"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="106224258"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 06:53:40 -0700
X-CSE-ConnectionGUID: GW4mJAoRSB2hTEwgOPv0lg==
X-CSE-MsgGUID: J8UbZ21iRXaHVRr9LXBjnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="255563700"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 06:53:36 -0700
Date: Mon, 29 Jun 2026 16:53:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, u.kleine-koenig@baylibre.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: magnetometer: add support for Melexis
 MLX90393
Message-ID: <akJ43m8p06Vb5FE_@ashevche-desk.local>
References: <20260627095519.8377-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627095519.8377-1-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 27, 2026 at 03:25:17PM +0530, Nikhil Gautam wrote:
> Hi,
> 
> This series adds initial Industrial I/O subsystem support for the
> Melexis MLX90393 3-axis magnetometer and temperature sensor.
> 
> The MLX90393 supports both I2C and SPI interfaces. This series
> implements support for the I2C interface while keeping the driver
> structure transport-independent to simplify future SPI support.
> 
> The device uses a command-based communication protocol rather than a
> conventional register-addressed interface. A small transport abstraction
> layer is therefore used instead of regmap to share the common sensor
> logic between the current I2C implementation and future SPI support.
> 
> Currently supported features:
> 
> * Raw magnetic field measurements for X/Y/Z axes
> * Raw temperature measurements
> * Configurable gain/scale selection
> * Configurable oversampling ratio
> * Direct mode operation through the IIO subsystem
> * I2C interface support
> 
> The driver has been tested on Raspberry Pi 5 hardware using an
> MLX90393 sensor connected over I2C. Magnetic field and temperature
> measurements were verified through the IIO sysfs interface.

...

> v3: https://lore.kernel.org/linux-iio/20260627005843.7786-3-nikhilgtr@gmail.com/T/#u
> v2: https://lore.kernel.org/linux-iio/20260618160141.11409-1-nikhilgtr@gmail.com/T/#t
> v1: https://lore.kernel.org/linux-iio/20260510191010.155380-1-nikhilgtr@gmail.com/

No, do not issue versions so often, especially for a new driver. *Minimum* of
one week must be between two versions.

NAK. Please, go to v3, study, address, and settle down the comments given there.

-- 
With Best Regards,
Andy Shevchenko


