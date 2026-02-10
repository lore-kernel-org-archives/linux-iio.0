Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485A2F9D98;
	Tue, 10 Feb 2026 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752319; cv=none; b=cYf/rXTdBz2wnzS/kppef2CQDab1Ah5ln3pNUUoU1lvcQ3Cpl/dPdCe3iR3Tinqmrmg6S9B3EqPIk38mntkeCiz7teIG0pEfb58OSKmAzSry8KdI4kTrz5WegqHclQUTLQJzRnDl2+dw1r853I6aC6isQOFZZNrVE7xolASDKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752319; c=relaxed/simple;
	bh=0TLLGJqfB8OuvgVbtHS7IkPt9IeB8+3GCLZakOZ58Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwvOIOyzffaEP4q89eWN7A4c29MyBOBJT5PFbaPBon+814dhlbOqkWNiMQn2cwf2kffPuOooIfMppql0u3JEvilRTmLfXy0tyGTZke1K3PxYn+HLRQOPPSmulypdJafeIw7PN/jp2ZSdrdqbS+HfZx42jalbNyEvEfyt4XXFMiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfhesE42; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfhesE42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770752318; x=1802288318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0TLLGJqfB8OuvgVbtHS7IkPt9IeB8+3GCLZakOZ58Rc=;
  b=mfhesE42aRTtQz+GZcf8W5T1oxChBkiIuN6ehRRJc0tiGlXqrYdlBUIB
   eZUHEgc4hNH4V6YowXDHZc+TOsuAH3nvMwqkbtMkaEo1h+kKUfSHtMbLH
   7501gRIjdD7ywaA/2rLy2t/cjQ+izv6ams33CnKRvMpYxDaywbDDUtKCl
   i53l2mF+b5u2mcY7QxRbBgkca5KA4+0CRMc5R69u289+wOjQo3QPYjw2a
   Ahmjm8nhkd6/5IlwYHUcpZx9IZq03vrEEsqQ6+uSNsJPC+DCtw4lTqiqH
   WMOTHLUKG2/G4gS/+8VeXIEEs1FoVElGXj5bVeXak5hXAdIctfn2yDpsu
   A==;
X-CSE-ConnectionGUID: nXgNSZ+wTnOCJU/p3xdlQw==
X-CSE-MsgGUID: XDUAUnbUQ9GVE+K/KCm+Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83329225"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="83329225"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:38:38 -0800
X-CSE-ConnectionGUID: Myb1yFYkRiihnhPKd3ebpA==
X-CSE-MsgGUID: fM68XHhTTZyPA1NgkRbqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211151779"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.131])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:38:36 -0800
Date: Tue, 10 Feb 2026 21:38:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: si7210: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <aYuJOXmxZVtiBHsE@smile.fi.intel.com>
References: <20260210175137.44178-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210175137.44178-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 07:51:28PM +0200, Antoniu Miclaus wrote:
> Simplify probe by using devm_regulator_get_enable_read_voltage() to
> get, enable and read the regulator voltage in a single call, caching
> the value at probe time.

...

> +	unsigned int vdd_uv;

vdd_uV // now wondering if we can even use unicode variable name µV :-)

...

> +		temp -= 222 * div_s64(data->vdd_uv, MILLI);

Not sure why this is 64-bit division now.

-- 
With Best Regards,
Andy Shevchenko


