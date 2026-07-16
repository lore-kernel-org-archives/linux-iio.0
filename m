Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC6222590;
	Thu, 16 Jul 2026 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238258; cv=none; b=S40pD1xGozGts6n4DGXsPPq9+EGjPSwC0OKF1AVgzsjJ608hDmGSG4l/VrljRkjlPGal4/p4twJ55MHhCdpBcFgcyXzLgAQIX7u9qnxHCTf3NAvoED2PExFEaVRzN1rZUFmx/lVyQcPyCac8oTZ/2O8d5L/yhwB8qo+TFN0L2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238258; c=relaxed/simple;
	bh=AULKYViUHn0EerT21KRgLC4NPD9+3p9wrJ9n+6zCKug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj8ZzFp6cnCtz6utv+zDgzSGWaMLyyxQzdpFXfLP8hS3e0j4Ywecp2Ex/PPGz7EG6qTtQyreVbXgkKBTJhJN4zcz6Zn1ry1oZ6B763XPzyK8bIwpmQNxmGqxhDp/lMrDJUYa1JekOwWGONQf/sjccuooKfdz/U2ohUj2pmiGo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aqi7Fz1y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aqi7Fz1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784238257; x=1815774257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AULKYViUHn0EerT21KRgLC4NPD9+3p9wrJ9n+6zCKug=;
  b=Aqi7Fz1yQShAL6KfrTiloMOUoGMTBF5RjOMVrQVZSxSNEVdXW1m9togY
   SBenPhRQv4dskMdXRHG1to5vpr1L2NDwKASDTx2Zvq4ZSOAdEdeI3tGUM
   pkXJLDkHxst9WVt3VtOAll8wSpP88i6BfMFPMGILNdyTJcK+trgwkETGR
   R+9vEQmPzqpDbGvgE3VOH9FjS1885hfuesdZWvf3FN9PvpyVzZOAOQHQa
   SZOXxXygGUdPkhBzRjUA/H7wUIVRlxVlgy/Lg7ApU9H55IrR/anFJ4exj
   8j2T4yUzuR1s4m64rg4yRLbFX8h2wzD6lH1/aHjLKkILlRszVuttdIRss
   Q==;
X-CSE-ConnectionGUID: rQ1kIbCjQbm9NyrxkYi2ug==
X-CSE-MsgGUID: kcpSnisBRFO6pJBKVqQOKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95564628"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="95564628"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 14:44:16 -0700
X-CSE-ConnectionGUID: 0CqQJwhGTvis7Buqh37UhQ==
X-CSE-MsgGUID: OWvpIhWTQlaoi8BVoQJVDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="286681761"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 14:44:12 -0700
Date: Fri, 17 Jul 2026 00:44:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, julianbraha@gmail.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v7 0/4] iio: adc: Add support for LTC2378 and similar ADCs
Message-ID: <allQqp039ontXNZe@ashevche-desk.local>
References: <cover.1784235595.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784235595.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 06:08:49PM -0300, Marcelo Schmitt wrote:
> This patch series adds support for LTC2378 and similar low noise, low power,
> high speed, successive approximation register (SAR) ADCs. These ADCs are similar
> among each other, varying mainly on the amount of precision bits, maximum sample
> rate, and input configuration (either fully differential or pseudo-differential).
> 
> Patch 1 adds device tree documentation for LTC2378.
> 
> Patch 2 enables single-shot sample read with a GPIO connected to the LTC2378 CNV pin.
> 
> Patch 3 enables high-speed data captures with SPI offloading.
> The setup is similar to AD4030, with a specialized PWM generator being used both
> for SPI offload triggering and conversion start signaling.
> 
> Patch 4 enables running buffered data captures without SPI offloading.
> 
> Even though these parts are somewhat similar to AD4000, the wiring configuration
> for LTC parts is different as well as the available HDL for high speed sample
> rate mode. Because of that, I propose creating a new device driver for
> supporting LTC2378-like devices.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

for patches 2-4.

-- 
With Best Regards,
Andy Shevchenko


