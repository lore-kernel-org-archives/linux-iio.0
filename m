Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF87CA6F;
	Mon, 10 Aug 2026 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387304; cv=none; b=aUFAW3NmWbe34gX96VRYY1jyAOmBvSCD3jNEHG4r4sGDMDOEbONvzTeZwD9Jj9UO77VlBdJLzrE8Lw8i9i0Cw+Fmijt51UbjTRZIX354uIX85Vi5XPhXjaAE54YoBNMG9Fa3Mdl62kV5fgttIadYtzDMcuTm+SVavSSGIq6FVyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387304; c=relaxed/simple;
	bh=57E9cRtdfwsINd7J4tO4q+jRMsonEqxgIkInVerD7lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJx0tNkBxZhhgQquHXVgxvM65FRsxPPo77K8PVhxNVyBexqQjiiapqm4wWNlcaNt4rph/fp2G6/1bjRmXKpFbCkY2fiim413MpScK6L5n5OOHUCKMztAalXKSFUufPrEoF985vqCJ8Wu8WeeBut5lbTjVdSPy27HpKoNs15IsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOKKZXFH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOKKZXFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786387303; x=1817923303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=57E9cRtdfwsINd7J4tO4q+jRMsonEqxgIkInVerD7lU=;
  b=kOKKZXFHwFIBuWgAlJ40MkEM1jIC0rRSyWE/pV3O8x7CP8mjmUIEGrAh
   Vs/VLTDK8ukrWCf3ttGvPM0We4o22COm1jOjXh9ruVNCtm4eNpMhismPZ
   InkZaf8JOz6Phx/cZeM6IEf1yE41a6/IdqHWqKgmZEiJRp9xbsI486kbB
   tvH69WDoHnKGXo6Sdwv06vE0xOGaoKmlMRs++wQuo6Rmt727iZlpPH+Lb
   ajqly8WxSsBE3jx/r5jRH3rqMn9bVVvPx6NAc36eByhr8z1a139XWyd2A
   s7plBZubXuACZhOOfk8Gb4y4QGHx23muP6jynrVoWctYDkAIF9pROUFq7
   A==;
X-CSE-ConnectionGUID: rNCHmiECSbCSb8aAVTQelg==
X-CSE-MsgGUID: VXf7XX+WTGSMWwMcSSUQ1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="97506961"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="97506961"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:41:42 -0700
X-CSE-ConnectionGUID: ckk3Az1oSyK78n3nKIch9w==
X-CSE-MsgGUID: qZJmAYj2T3SBy0CRdzEWbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="263716389"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:41:36 -0700
Date: Mon, 10 Aug 2026 21:41:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mike.looijmans@topic.nl, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jorge.marques@analog.com,
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz,
	wens@kernel.org, sakari.ailus@linux.intel.com, linusw@kernel.org
Subject: Re: [PATCH v9 1/3] iio: adc: ti-ads1100: Fix incorrect reading when
 datarate changed in single mode
Message-ID: <anobXhtKuDZHGaa_@ashevche-desk.local>
References: <20260804192840.29121-1-jakubszczudlo40@gmail.com>
 <20260804192840.29121-2-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804192840.29121-2-jakubszczudlo40@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 04, 2026 at 09:28:38PM +0200, Jakub Szczudlo wrote:
> When device is suspended and it is in single mode then changing
> datarate doesn't make it actually wait for new measurement, so to
> be sure that read after change is correct, functions that changes
> datarate and gain will wait for a new data.

A couple of minor issues (no need to resend just for these).

...

> +static int ads1100_start_single_conversion(struct ads1100_data *data)
> +{
> +	u8 config = data->config | ADS1100_CFG_SC;
> +	int ret;
> +
> +	ret = i2c_master_send(data->client, &config, sizeof(config));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C write fail: %d\n", ret);
> +		return ret;
> +	}

> +   /* Need to wait because of change from continuous to single mode */

Broken indentation.

> +	ret = ads1100_wait_single_conversion(data);
> +	if (ret)
> +		return ret;
> +
> +	config |= ADS1100_CFG_ST_BSY;
> +
> +	ret = i2c_master_send(data->client, &config, sizeof(config));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C write fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* No need to cache it, it's status bit */
> +	data->config = config & ~ADS1100_CFG_ST_BSY;
> +
> +	return 0;
> +}
> +
> +static int ads1100_poll_data_ready(struct ads1100_data *data)
> +{
> +	int ret;
> +
> +	ret = ads1100_start_single_conversion(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1100_wait_single_conversion(data);
> +	if (ret)
> +		return ret;
> +
> +	return ads1100_set_config_bits(data, ADS1100_CFG_SC,
> +			      ADS1100_CONTINUOUS);

It's one line (81 characters which is acceptable).

> +}

-- 
With Best Regards,
Andy Shevchenko


