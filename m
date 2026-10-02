Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44194A1E1A;
	Fri,  2 Oct 2026 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946735; cv=none; b=FoRm2WWJHeZKRW6UVvYVw0OwxaJa/8DIJi7lsP2h9eBpSCNFADhjqgAxFL5SKdEA1QbwchTzFSBlDwWsC9fYwhK32FZ5vvItigKy6LToAU/FQOgRL8ZB2srERb6b/elClyNcNOf7WXGTW8PzGA8h1sqezaQCO/WO29r1MXbUMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946735; c=relaxed/simple;
	bh=w9Tdxz3qXRMH0n6P51NuGcil7cjfx6Iej+vE1aJVBNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8oPVtrUIxi7XPw84+qS0hJpoCINasybW5LMCw/Q5NhmZ4nvPLn1wcE420c93GogfjXrQ1ABr8uWWXpYdVjK+MP5tBQV5Uh4D2/ZSOik75N9QmzXjgezBPrhPIG+JlIpcKhD2tNcEDml8HvYtj9W/jIKdJ2pTrDvAtVaK+AI63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bplbYo/F; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bplbYo/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790946733; x=1822482733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w9Tdxz3qXRMH0n6P51NuGcil7cjfx6Iej+vE1aJVBNY=;
  b=bplbYo/FeAVr9eINRefVRGtJWyzDrnad65EX6ClDIe/BcJCEBVFla7Ma
   9UyRrJk8LPJsoRfY0Z98MwM2bqsqb9GLMOmYd0a99dQsEO0BBn8DWtfka
   gA1wE3jvwyv2O7ED8Bi8PFCvoGdJwn4ZP6ply3sYOz3bCE3AhARBOdahV
   5Q+yJ+WtuDtKU8sEt69HABOQyP69gwtpHLxsUClXboAwyMJi5f/eH3RmM
   gylNMGVVLPdHO17DMQku46noUBEUF5+BDwVFn1MA5cKmExh6uCBKlzQdi
   XZsuLCbjz2RU5C881RLTb94u7351CtvKar/oLkAycfibHGihLXqLVh0s9
   w==;
X-CSE-ConnectionGUID: G0gwFJcCRtyVqo0Gi1tA5w==
X-CSE-MsgGUID: q/n/ZDQBRJ6aXOtik1/EAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="108090198"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="108090198"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:12:13 -0700
X-CSE-ConnectionGUID: K37AlmLuRC28xkGBpsh4/g==
X-CSE-MsgGUID: zENkJHo2Tc+wWNYhkJGxJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275783525"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:12:08 -0700
Date: Fri, 2 Oct 2026 16:12:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] iio: imu: inv_icm42607: Implement MREGx register
 access
Message-ID: <ar-tpjenoxMloYq1@ashevche-desk.local>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-5-c65281b745c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-b4-inv_icm42370p-v5-5-c65281b745c9@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 01:54:29PM +0200, Kanak Shilledar wrote:
> The device supports indirect register access to different banks. A
> specific routine needs to be followed when accessing the registers in
> another bank as documented in the datasheet (section 13). This is
> required for accessing registers configured via the user and
> implementing buffer support. The implementation is inspired from the
> icm45600 driver. The banks are defined based on their initial bank
> access code which are written to the BLK_SEL_* regs. However, there is a
> variation for MREG1 as User Bank 0 and MREG1 both share the same 0x00,
> so User Bank 1 has 0x00 and MREG1 has 0x01. When MREG1 register is
> accessed, then BLK_SEL_* is written with 0x00 instead of 0x01. All the
> register access goes through the 16 bit virtual regmap layered on top of
> the 8bit bus regmap. Bank id in the upper byte and the register address
> in the lower byte. Bank 0 accesses are forwarded to the bus regmap with
> the bank field stripped, while MREG accesses are forwarded to bank
> switching sequence.

...

> +	unsigned int val;
> +	int ret, ret2;
> +
> +	*idle_set = false;
> +
> +	ret = regmap_read(map, INV_ICM42607_REG_MCLK_RDY, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & INV_ICM42607_MCLK_RDY_BIT)
> +		return 0;

Why not regmap_test_bits()?

> +	/*
> +	 * Clock isn't running: we're either in Sleep mode or in Accel LP mode
> +	 * running on WUOSC. Force the RC oscillator on via IDLE and wait for
> +	 * MCLK_RDY. Datasheet gives 10us (accel startup) to 200us (accel
> +	 * transition from OFF) for this to complete.
> +	 */
> +	ret = regmap_set_bits(map, INV_ICM42607_REG_PWR_MGMT0,
> +			      INV_ICM42607_PWR_MGMT0_IDLE);
> +	if (ret)
> +		return ret;
> +
> +	*idle_set = true;
> +
> +	ret = regmap_read_poll_timeout(map, INV_ICM42607_REG_MCLK_RDY, val,
> +				       val & INV_ICM42607_MCLK_RDY_BIT, 10, 200);
> +	if (ret) {
> +		ret2 = regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0,
> +					 INV_ICM42607_PWR_MGMT0_IDLE);
> +		if (ret2)
> +			dev_err(regmap_get_device(map),
> +					"failed to clear IDLE after MCLK timeout: %d\n", ret2);

Broken indentation.
Is it really important message?

> +		else
> +			*idle_set = false;
>  	}

...

> +static void inv_icm42607_mclk_put(struct regmap *map, bool idle_set)
>  {
> +	if (idle_set)
> +		regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0,
> +				  INV_ICM42607_PWR_MGMT0_IDLE);
> +}

What about

	if (!idle_set)
		return;

	regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0, INV_ICM42607_PWR_MGMT0_IDLE);

?

...

> +static int inv_icm42607_mreg_read(struct regmap *map, unsigned int reg,
> +				  u8 *data, size_t count)
> +{
> +	unsigned int val;
> +	bool idle_set;
> +	u8 blk_sel;
> +	int ret;
> +
> +	/* MREG access is one byte per transaction, no burst support. */
> +	if (count != 1)
> +		return -EINVAL;
> +
> +	ret = inv_icm42607_blk_sel(reg, &blk_sel);
> +	if (ret)
> +		return ret;
> +
> +	ret = inv_icm42607_mclk_get(map, &idle_set);
> +	if (ret)
> +		return ret;

> +	ret = regmap_write(map, INV_ICM42607_REG_BLK_SEL_R, blk_sel);
> +	if (ret)
> +		goto out;

So, can we use regmap ranges instead?

> +	ret = regmap_write(map, INV_ICM42607_REG_MADDR_R,
> +			   FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg));
> +	if (ret)
> +		goto out;
> +
> +	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
> +
> +	ret = regmap_read(map, INV_ICM42607_REG_M_R, &val);
> +	if (ret)
> +		goto out;
> +
> +	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
> +
> +	*data = val;
> +out:
> +	/* Restore direct access. */
> +	ret = regmap_write(map, INV_ICM42607_REG_BLK_SEL_R, 0);
> +	inv_icm42607_mclk_put(map, idle_set);
> +
> +	return ret;
>  }

...

> +static const struct regmap_config inv_icm42607_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,

No cache? Why?

> +};

...

> +static const struct regmap_config inv_icm42607_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};

Ditto. And why they can't be deduplicated?

-- 
With Best Regards,
Andy Shevchenko


