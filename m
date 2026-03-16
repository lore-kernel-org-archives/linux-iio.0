Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E632D0DE;
	Mon, 16 Mar 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677411; cv=none; b=Zf9wNtaW8lynJ7pGLPtPle78pr6DTkZgOgT3AUVxAeVKq5AiNVUx6ievszYm/Nz/CCRQaisnZCGJqjkO0Taz6N/mxZWp3e+Ic0jlHMfIg5cxHCDv28MRXyC+mOHvorEgEfNcw06B2FfHrBRpjAiLZk7z8kBSKS3wdX8l5pd3Its=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677411; c=relaxed/simple;
	bh=RX9iOQVOaMgT3jEoEgSmL92sFlNGtvLW0tCJoT+uQvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjzfFm55faSEdnBOxYrz0zNKLErRE4kmyH5ceF337ph4oQxmlAGBvmkhGCaLMCc2mvul0oNulDc6xNAEc3xLeRQSBgEZB4XFIw/sYK4QnIE/ONIbtlXTqihWaMl7w58EAkpIK6OP6KMpa9RCPXlKOReUEZLKAzrT95CNncbAyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9+Rr/RT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9+Rr/RT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773677410; x=1805213410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RX9iOQVOaMgT3jEoEgSmL92sFlNGtvLW0tCJoT+uQvg=;
  b=M9+Rr/RTs/skMFGUIMHiSNmQi5eX3HtMOzP9Pzf5hqmZOsmRE0pLSiGo
   7nVEcrlUIlwoYy4ob2BG6T4tQ4mLgEa/MsKO7sEVgPXFQKx8T0yWMAUWm
   fz+5ykRUXXWg/M5+1rIURMzRjyd99Y/6SALOZerUIRdHBDjUzSK0+LpFr
   vMW33suLrmOYqOxJG8jaGtyuAFbzO6xVJgMqmkx80/XmFIqv21QKbcQny
   W8mxLz5T/l1cHSf3DGgGXO502MmFNZWKdXJf7zVUi9W2MMDV877xAqGNm
   9vnVKADLcZxBh5hZeFhWRhrjp1I7XMldNMtCpGvtguvzUSp586wyujPT2
   A==;
X-CSE-ConnectionGUID: HOyGrRO0SiC6UPqgQytGgA==
X-CSE-MsgGUID: Ag1knrODQR6Gzz8nl3ZxAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85327127"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85327127"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:10:09 -0700
X-CSE-ConnectionGUID: 2MpOEOUTSwWeerr2D0shsQ==
X-CSE-MsgGUID: 4zJDYfF1T5SGEAdwFBEMjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221002234"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:10:05 -0700
Date: Mon, 16 Mar 2026 18:10:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, cosmin.tanislav@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v2 5/5] iio: adc: ad4130: add new supported parts
Message-ID: <abgrWnV8G47W2_Mi@ashevche-desk.local>
References: <cover.1773311639.git.Jonathan.Santos@analog.com>
 <9295ce0b3376481bf8530d1c53bb77a70e8761d1.1773311639.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9295ce0b3376481bf8530d1c53bb77a70e8761d1.1773311639.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 08:45:45AM -0300, Jonathan Santos wrote:
> Add support for AD4129-4/8, AD4130-4, and AD4131-4/8 variants.
> 
> The AD4129 series supports the same FIFO interface as the AD4130 but with
> reduced resolution (16-bit). The AD4131 series lacks FIFO support, so
> triggered buffer functionality is introduced.
> 
> The 4-channel variants feature fewer analog inputs, GPIOs, and sparse pin
> mappings for VBIAS, analog inputs, and excitation currents. The driver now
> handles these differences with chip-specific configurations, including pin
> mappings and GPIO counts.

...


> +/* Map logical pins to register value */
> +static const u8 ad4130_4_pin_map[] = {
> +	0x00, /* AIN0/VBIAS_0 */
> +	0x01, /* AIN1/VBIAS_1 */
> +	0x04, /* AIN2/VBIAS_2 */
> +	0x05, /* AIN3/VBIAS_3 */
> +	0x0A, /* AIN4/VBIAS_4 */
> +	0x0B, /* AIN5/VBIAS_5 */
> +	0x0E, /* AIN6/VBIAS_6 */
> +	0x0F, /* AIN7/VBIAS_7 */
> +};
> +
> +/* Pin mapping for AIN0..AIN15, VBIAS_0..VBIAS_15 */

Perhaps making the above also consistent with this?

/* Pin mapping for AIN0..AIN7, VBIAS_0..VBIAS_7 */
static const u8 ad4130_4_pin_map[] = {
	0x00, 0x01, 0x04, 0x05, 0x0A, 0x0B, 0x0E, 0x0F, /* 0 - 7 */
};


> +static const u8 ad4130_8_pin_map[] = {
> +	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0 - 7 */
> +	0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, /* 8 - 15 */
> +};

-- 
With Best Regards,
Andy Shevchenko


