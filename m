Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8C3BBFD1;
	Fri,  3 Jul 2026 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078495; cv=none; b=n4kx/MdGvoPoEcEq/GTz7bfymCza90GixBI2FSJhU4Vf1K8aPFmB2qTMnFVmb2kvRMOSIy1hRUukxDqkWox51QBhGw7u/rHNyA6BywMAu7ihL9vYLRT2qdfXXwlMz0uyXBJNEiUXCAS3QhaWMojeIu1A0ahptZlxTMJIv7ziq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078495; c=relaxed/simple;
	bh=lQLGbBRoCtwqD5i51GyrHKFjFR4I/RTIEw1n6EqfcRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBFxf/p4OA0KRudHSjjNHBghWBO0jJOt7Z2/VkSgIdd68V2dvSABrfkGhH9iXToYHYp9V2cJWWz9XEhm7ZXBlwQALtRAgv2BQqmwQv9W4hTEFNyB4Iu0eVGKo1YaB8zYEDT/oJDP7ozPJigQP2Zes3+m4p6RzKvQIRjIf+KncnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgYYnX6i; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgYYnX6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783078494; x=1814614494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lQLGbBRoCtwqD5i51GyrHKFjFR4I/RTIEw1n6EqfcRs=;
  b=CgYYnX6itSmHd4wVx8R8IVm86fLtb8BqUbQw0CWbWQ0GHq9E5XSaVlSQ
   oaiA32HigAIbGv6FKPMC70iQLvKXV0nzid+CbJWRTU8DMp+3RMzOn9jZj
   uKBt1fh8hVGRbrUXOUsG0TTqjA9P9LjsVcGQF+EH2XNtsr/8skZaUZqrk
   i7NA8lSpUzGqqJaOEGhxGlfklRzSDc2Ol74I8LFy5HhtxRf9VMH68oGBp
   ktg06BkSK9MIQx+E6pJzAL8Nj2mbPuGiTDMYpHpVPOdSJMI77aSTuyeA6
   KrzJpXlCE4LKtmWkkCL/fPn1UL70FynUpS8Asm6fpxPH/ZqsvC+YRY/dw
   w==;
X-CSE-ConnectionGUID: o+9PQ2PtQl244iIFfCdXKA==
X-CSE-MsgGUID: niH4LElhSGC2QKfSFr7sfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="84022685"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="84022685"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 04:34:54 -0700
X-CSE-ConnectionGUID: 1gFmaFHbQlmkipAaKiAoKw==
X-CSE-MsgGUID: Yo/aq/KsSvi6rPeH0LrBTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="256986883"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 04:34:51 -0700
Date: Fri, 3 Jul 2026 14:34:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <akeeWMSSTDfyFAqJ@ashevche-desk.local>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703102941.1141341-1-stefan.popa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 01:29:30PM +0300, Stefan Popa wrote:
> This series adds support for the Maxim MAX40080, a bidirectional
> current-sense amplifier with an integrated 12-bit ADC and an I2C/SMBus
> interface. It measures the voltage across an external shunt resistor and
> the input bus voltage.
> 
> The driver operates in direct (INDIO_DIRECT_MODE) mode. Each raw read
> triggers a single on-demand conversion (SMBus Quick Command) and reads
> back the matched current/voltage pair, so results are always fresh. It
> exposes the current and voltage channels with raw and scale attributes,
> a configurable oversampling (digital averaging) ratio, and PEC-protected
> register access. The two selectable current-sense ranges are exposed
> through scale/scale_available (the range is chosen by writing the
> desired scale); the current scale is derived from the
> shunt-resistor-micro-ohms device-tree property.
> 
> Continuous FIFO buffering, threshold events and the alert interrupt are
> intentionally left out of this initial submission and may be added
> later.
> 
> Tested on hardware with four MAX40080 devices on an I2C bus.

For a new driver it misses two things:
- why do we need a brand new driver? (Can we extend existing one to cover
  this HW?)
- where to get a datashee? (Link?)

-- 
With Best Regards,
Andy Shevchenko


