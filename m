Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063D3F8233;
	Mon, 15 Jun 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533703; cv=none; b=awBzFuv+yDiASmaMaVcvJcsVmsbBSPsh9enEvl+ZHCIctw35+zq5vAn5x0g6xZO8TIdW4qF2GtXdCrAnM9UMlHwtX/gZDsA4IPljek3F4OxQQmWsdVR7mnu8aZqLGfqieQAT5hb/L9s2jfxhZPyEvGrH1DH2DujAltPBmrc7xmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533703; c=relaxed/simple;
	bh=di8Cecoe3Fmf11lnQqBNXXiNqaQdQ8D8odDym0sxE3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm9Ay0NWT8GTVO6b1+Yjy+UPNwGNd24mF6XYa6Lu3Sa27h+/D+g/IwwwP4EhAIkVNcggD6eDuusf6l+Y82MqHBb6U1oeZi+imaaN2RDmInPGTjX7jQPwrfHftAp/ispnkYXHFkl26ghGAw1FfL4jATneE4oQ9An/jJpyhOxQQGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVB3J/sp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVB3J/sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781533701; x=1813069701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=di8Cecoe3Fmf11lnQqBNXXiNqaQdQ8D8odDym0sxE3M=;
  b=DVB3J/sp1EgSIJQbYniYKS/ZOz1O6yOq6KJXqBhU/jcdvqDjN2azwHeM
   X9Xu6OlxnaSE456iPM1mIwZTaw4bK4ZlKfjrjM88nVLm2vVlr7ZXRph/+
   3WcMQtsTSgUPF3YSwQ/XhnoiPNE4rJnPjOYvmxkxcNU42K20MSIQewuq6
   fjLKlK3aQzI1kQbyGjueN28Xq6eR2/5pMFDGqtiLz+2mV7KstSL1Yit7r
   gWgNAK0InL2bG3eEFBI5RYGRDLE9iEGP8iVgp0KIyFN0/PH9/SFVViTnF
   XYXuCbakNDGyw9ay5L3kdOS8KqGdyAdR7OJSDXTRt9W/mrXTWPl3NO83w
   w==;
X-CSE-ConnectionGUID: XjjfKdL+TxqG2ua+ujquuQ==
X-CSE-MsgGUID: T+Kl8BojTk6MCdcVeWc9qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="85908057"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="85908057"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:28:21 -0700
X-CSE-ConnectionGUID: 5XT6GlmcQiuqI8Lnzb3iEg==
X-CSE-MsgGUID: 8j9GxcZLSdGo5hoTjKc6Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="285597575"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:28:18 -0700
Date: Mon, 15 Jun 2026 17:28:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: adc: versal-sysmon: add oversampling support
Message-ID: <ajAL__3jUtSgSb7r@ashevche-desk.local>
References: <20260614233722.2603459-1-salih.erim@amd.com>
 <20260614233722.2603459-6-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614233722.2603459-6-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 12:37:22AM +0100, Salih Erim wrote:
> Add support for reading and writing the oversampling ratio through
> the IIO oversampling_ratio attribute. The hardware supports averaging
> 2, 4, 8, or 16 samples, plus a ratio of 1 (no averaging).
> 
> Temperature and supply channels share oversampling configuration at
> the type level (all temperature channels share one ratio, all supply
> channels share another), exposed through info_mask_shared_by_type.
> 
> The hardware encoding uses sample_count / 2 in a 4-bit field within
> the CONFIG register. Per-channel averaging enable registers must also
> be updated to activate or deactivate averaging.

...

> +static int sysmon_osr_write_temp(struct sysmon *sysmon, int val)
> +{
> +	/*
> +	 * HW register encoding is sample_count / 2:
> +	 * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
> +	 */
> +	int hw_val = val >> 1;

If, for some reason, val happens to be a small negative number, here might be
a surprising behaviour.

> +	unsigned int readback;
> +	int ret;
> +
> +	ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
> +				SYSMON_CONFIG_TEMP_SAT_OSR,
> +				FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR, hw_val));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Readback fence: the SysMon CONFIG register resides in the
> +	 * PMC domain behind the NoC. A posted write may not reach the
> +	 * hardware before the next MMIO access. Reading the register
> +	 * back forces the interconnect to complete the write, preventing
> +	 * a bus hang on the subsequent access.
> +	 */
> +	regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
> +
> +	return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
> +				     SYSMON_TEMP_EN_AVG_COUNT,
> +				     hw_val ? ~0U : 0);

Is the last parameter > 32-bit? If not, drop 'U' as it might have a nice
side-effect in case this become actually > 32-bit. Same for other cases.
In other words, using ~0U should be quite cautious.

> +}

-- 
With Best Regards,
Andy Shevchenko


