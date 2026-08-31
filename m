Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02814439F90;
	Mon, 31 Aug 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184622; cv=none; b=GJDrwiGJvJYpeEp+Ix/W/HD9HJ1zdo+IfF3oi1V+gDl1JpMc7AKaoI3s/muc5c8J7V89UYa+F/2PLLxGevxdGgMUcgQfqSSEptKKT+eXv2G4MIgcDeVmNzcXcivJ78bpa65XVm+KXfWMLJLbUQOOhb1D+06Re9q6Wk2+qsNX96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184622; c=relaxed/simple;
	bh=5ZaeNi3I+M3yj83MTf5PA5QSYQvPclKRNKRGZhp1k6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syZ7vUCI0Vfkb5oI/S7YaUBYruyuLThOYBowaY+i+X6dV4uGCpoEoNbFV4W5O/iNdz0wVFMEytsVVsKhLFQg2JFQy9wh3RaeHx8FclUxgthBKz0JX02h+9xnh33mRF3E3nNCqy0g6LXUYg3OfK5NEkz4KmX6G6JQ/0AxSGqlF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cW5misYX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cW5misYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788184621; x=1819720621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ZaeNi3I+M3yj83MTf5PA5QSYQvPclKRNKRGZhp1k6A=;
  b=cW5misYX2bA5u+jKxijOum1uYWEUZlD7UatTZp4ISKaXG9ec9wiDWYkX
   1iDi/kVS5E1S7unv52R3x5eawJnmFd6smIil2cScwUpcBVTjpEdEhbdZx
   PLa+Hs8HU8Q0FL74l/Te/dbIHyU2meQvEdAOZI9lY3QadxkZyoSqmuhNW
   nLkI8luEfK9z5mhRQ0fMvpUCLdaqi8Kma14k6+F3hjFsv4eG6p7YlZS7c
   mHM8ffYVTj7K/UTPhh+APBxvGM2HTIRo57tv8Bd1LZA1cxXgvm0qMTxjW
   K3Oln2j0V3gFpEn2+Dk/wh4VDOB1S4vAeqgNt4vYyVQQRhjr4mdSCIlq6
   g==;
X-CSE-ConnectionGUID: KS0ohYCJTpaB++rivtiFFg==
X-CSE-MsgGUID: P9x7fjoKSaSmEa0xOX1v/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="91104361"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="91104361"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:56:59 -0700
X-CSE-ConnectionGUID: 8aSxRWIwQum7ms8N1Uu1HA==
X-CSE-MsgGUID: saSZmLUbQcmyXMCjbZj6cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="274073751"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:56:55 -0700
Date: Mon, 31 Aug 2026 16:56:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	Christoph Muellner <christoph.muellner@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/8] iio: accel: mma8452: Support interrupt sharing
Message-ID: <apWIJfGoQLtDV4IB@ashevche-desk.local>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
 <20260831-mma8452-open-drain-v7-4-22946812c928@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-mma8452-open-drain-v7-4-22946812c928@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 02:17:07PM +0200, Esben Haabendal wrote:
> Adding handling of rutnime PM suspension in the interrupt handler allows
> sharing interrupt with other devices.
> 
> Keep in mind that the device by default is using push-pull for the irq pin,
> which might require additional hardware design to allow interrupt sharing.
> 
> The suspended flag is added together with synchronize_irq() in order to
> protect against race conditions when doing runtime suspend and device
> removal. This way we ensure that interrupt handler does not try to access
> the device while regulators are disabled.

...

> static int mma8452_runtime_resume(struct device *dev)

>  		return ret;
>  	}
>  
> +	WRITE_ONCE(data->suspended, false);
> +
>  	ret = mma8452_active(data);
>  	if (ret < 0)
>  		goto runtime_resume_failed;

>  	return 0;
>  
>  runtime_resume_failed:
> +	WRITE_ONCE(data->suspended, true);
>  	regulator_disable(data->vddio_reg);
>  	regulator_disable(data->vdd_reg);

But with this, what's the point in having WRITE_ONCE()? It can be read
just in the middle as true and be immediately changed afterwards. It
may be that I am missing something, but I think WRITE_ONCE() should be
done once in this function.

-- 
With Best Regards,
Andy Shevchenko


