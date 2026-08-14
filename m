Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C81456E19;
	Fri, 14 Aug 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697113; cv=none; b=L0TGjaZQgh9jM3UghXAzU3gD2g79UWl1ql4BQncxV2odwN8Vxzlny7pWGu2lMv5KD6IPxW5ivq4N9RtQeEvTEH+cFSvaPAAw9xSdqucYkHI28kIo2I0Q5NL+fso42Ovo715mGMm6Qpoqw1MMRVXqFDFfXG3ZPALa5hMbeRQVF/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697113; c=relaxed/simple;
	bh=02GCKdl+4caKPV47L7dD6vJAkQbS9I9BYEv+tXUl/lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0OYFKbvtbuyPXKwkrI/PQSJH0ehgtXlRTulHfuxUYqO1w4i2TuyE8EUeZT2a3hcEEj0PEkv8FxIxXNXDlvB2GZC1sV11t2SV9/SmVU65jcJAtiO2VD2MhCOzT0D7BhXS4f3lk2VvwJ+uWeMoWIRSTvpZlrgT8skVtFWmkoKp3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkuVu537; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkuVu537"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786697112; x=1818233112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=02GCKdl+4caKPV47L7dD6vJAkQbS9I9BYEv+tXUl/lQ=;
  b=GkuVu537BoSosgPwMgZow2TJnSbnJa3UlVtPquQYnpnUNyRBDG81Z1B9
   gqRY/arvMWQ5ux6s9rgKJq9Gmy++MtWs6ZvfFNNC4zQTLXMbcttZFxxK3
   4U3bIynaUdk8ywMz/+Y37b3XcbKArZM4KJ6uTTRb7FRGI/BEFIYsC+uIC
   jWv8DNj1xVXpjaBDcCltr2RLMBYVZ5bIVtWd6GXDexqR0tLLg5vE0S6/v
   IlEam2AI5FwzmNoL7lys+qLRsYfhx6uJCdDwcIha4UmiEkhxx+5lVQI3G
   nvsWo4ixlaYFfT0c6g+zg1LQwTDPXU7/u2j7U55jWPiFgZ5tlMrFkJzDo
   g==;
X-CSE-ConnectionGUID: lflkE7/bR/WiMoZRLn0+GA==
X-CSE-MsgGUID: N/NWRAPBQ1K/x5OizoNPqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87038888"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87038888"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:45:11 -0700
X-CSE-ConnectionGUID: 8vQJPTKRRSCLpJfB6rG1Yw==
X-CSE-MsgGUID: +GRaxc2CRSG+FAOVxmRsoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="294096857"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:45:06 -0700
Date: Fri, 14 Aug 2026 11:45:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 00/14] iio: adc: Add AD7768/AD7768-4 ADC driver support
Message-ID: <an7VkAg_MIc8HneT@ashevche-desk.local>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 03:56:53PM +0200, Janani Sunil wrote:
> Add support for Analog Devices AD7768 and AD7768-4, 24-bit simultaneous
> sampling Sigma-Delta ADCs with automatic power mode selection.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768.pdf
> 
> **Device Overview:**
> The AD7768 is an 8-channel, 24-bit simultaneous sampling ADC. The
> AD7768-4 is a 4-channel variant. Both support configurable power modes,
> programmable decimation filters, and a high-speed serial interface with
> 1, 2, 4, or 8 data output lines. Per-channel offset, gain, and phase
> calibration registers are available.
> 
> **Features Implemented:**
> - Support for AD7768 (8-channel) and AD7768-4 (4-channel) via device
>   match data.
> - Automatic low-noise power mode selection (fast, median, low power)
>   with associated decimation rate and output data rate tables.
> - Per-channel offset, gain, and conversion delay via IIO attributes.
> - SPI communication with custom regmap bus for the device's protocol.
> - IIO backend integration with adi-axi-adc for high-speed data capture.
> - CRC data integrity verification over the serial interface.
> - GPIO auxiliary driver to expose the 5 on-chip GPIO pins.
> - VCM common-mode output exposed through the regulator framework, with
>   runtime PM management while the output is enabled.
> 
> **Patch Summary:**
> 1. Add the AD7768 and AD7768-4 devicetree binding.
> 2. Add the IIO backend CRC operation.
> 3. Initialize the AXI ADC state mutex.
> 4. Implement CRC control in the AXI ADC backend.
> 5. Add core AD7768 and AD7768-4 capture support.
> 6. Add configurable sampling rates, power modes, and filters.
> 7. Add per-channel offset and gain calibration controls.
> 8. Add per-channel conversion delay.
> 9. Expose the VCM output through the regulator framework.
> 10. Register the GPIO auxiliary device from the parent driver.
> 11. Use regmap_test_bits() for single-bit gpio-regmap reads.
> 12. Add optional runtime PM support to gpio-regmap.
> 13. Add the AD7768 GPIO auxiliary driver.
> 14. Add driver documentation.
> 
> **Testing:**
> The driver was compiled and tested on the EVAL-AD7768FMCZ using a
> Zedboard with a mainline kernel.
> 
> **Driver Rationale:**
> The AD7768/AD7768-4 warrants its own driver due to several
> device-specific characteristics:
> 
> 1. A custom SPI framing protocol: register reads and writes use 16-bit
>    frames with embedded read/write bits and register address fields,
>    requiring a custom regmap bus implementation rather than the standard
>    SPI regmap backend.
> 
> 2. A coupled power mode / sample rate model: available output data rates
>    are not a flat list but depend on the active power mode (fast, median,
>    low power), each with its own set of valid decimation rates. This
>    relationship must be managed in the driver.
> 
> 3. Simultaneous sampling across all channels with per-channel calibration
>    registers (24-bit offset, gain, and phase) that are laid out
>    differently between the 8-channel AD7768 and the 4-channel AD7768-4,
>    requiring device-specific register mapping.
> 
> 4. IIO backend integration for high-speed data capture via adi-axi-adc,
>    including CRC data integrity verification over the serial interface.
> 
> 5. On-chip GPIO: 5 general-purpose I/O pins exposed via an auxiliary bus
>    driver, sharing the parent's regmap and runtime PM.

The GPIO driver looks nice, but regmap API should use cleanup.h instead of
custom (legacy) approach.

-- 
With Best Regards,
Andy Shevchenko


