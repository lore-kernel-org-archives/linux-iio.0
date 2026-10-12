Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF74399375;
	Mon, 12 Oct 2026 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838144; cv=none; b=DL0+BD7W0OELWgmYIc8DK+pRLguOuSSHDHnReU/LlBhnoYvEeGqBXWqVRKeFe4mamik+xNLIKG2C36CJA3BfyxvUEZ2Bd6svMmEgZjrCbx7szyR1S5k9dOx0KFBonoE9I4dW6jwSIcCLBg+mftn6Hd24YIZsARl+sX57B4AX5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838144; c=relaxed/simple;
	bh=eVKms1OwY/OjrTvipCfGH7Enfw3b8ytga0cdN8fMY3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emrfU4ZMDYTOQZkI/Ec3QRz2z5Rv9Y4Mio0XiZBYwWXRzquqrU6F39jtxc/t36IozcpNA08SEAp+dBjddVi0aWjI+X1SXs/ii8dyn5Bnlls7+id1f8q7FR4C2dOg4LjU5ZsilVq2UkIOFldb0BF6DO+8Marq2ndpFSbDeWG00Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJr+Uf7j; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJr+Uf7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791838143; x=1823374143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eVKms1OwY/OjrTvipCfGH7Enfw3b8ytga0cdN8fMY3I=;
  b=eJr+Uf7jzXb0yLcKwGFA4vZ+WSL/PtOb6yoyCHeuafzyACtqMio1dIRu
   5KO87ygN3mpESZCPywpdYvEaBBWnSpgcoDz5Zi0JosH6lQkp1592rWZZs
   6XoES/J9HHjuru3ujPRMyneys9Wy9tGv9h7P/6BsbpqWINE+8mdUQAoAT
   j6HXg/j4RBgR7ysiUvvqNeWj6oUnqkQ8W9y7I6yul8gYvlFt/9Udb1Zkv
   azky93xVDNQauX73O5F/FrywhrF9Ts7uYXKuMq5iSiZeid4yZTg3VMnph
   yHw5BdaPO62HKQurJZsyKqqWpKD+Re1Bj55cUV3V8zYdd9VfmAYKRJGQE
   A==;
X-CSE-ConnectionGUID: YhRXArF5Qx2+djAfFfGQWA==
X-CSE-MsgGUID: dX8bORaKRWOm7bErqfPFCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="457027"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="457027"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:49:02 -0700
X-CSE-ConnectionGUID: fUhGqPK4TC2wyjaUcQU3uw==
X-CSE-MsgGUID: niL0/AvPTeCJN+2SpktBfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1045622"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:48:59 -0700
Date: Mon, 12 Oct 2026 23:48:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: pressure: dps310: add Zilltek ZTS8032 support
Message-ID: <as1HuFxMET0hnhuL@ashevche-desk.local>
References: <20261012114550.1680054-1-paulius.zaleckas@ui.com>
 <20261012114550.1680054-5-paulius.zaleckas@ui.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012114550.1680054-5-paulius.zaleckas@ui.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 02:45:50PM +0300, Paulius Zaleckas wrote:

> The Zilltek ZTS8032 has the DPS310 register map, scale factors and
> compensation, with these differences:
> 
> - two more pressure coefficients, c31 and c40 at 0x22-0x25, adding
>   c40 * Praw_sc^4 + c31 * Traw_sc * Praw_sc^3 to the polynomial
> - TMP_EXT is MEAS_CFG bit 3, and the temperature coefficients are for
>   the internal sensor (COEF_SRCE reads 0x06). TMP_CFG bit 7 is the top
>   bit of a 4-bit TMP_RATE, so the DPS310 TMP_EXT write would select a
>   25/16 Hz background rate instead of the external sensor.
> - product ID 0x11 instead of 0x10, the driver does not check it
> 
> Add a per-chip table holding the coefficient count and the TMP_CFG
> startup value, and an OF match table to select it.
> 
> Tested on a ZTS8032 at 0x76 over I2C: in_pressure_input is within 1 Pa
> of the datasheet formula evaluated from the raw and coefficient
> registers at every oversampling rate from 1 to 128, and TMP_CFG reads
> 0x00 after probe.

...

>  #include <linux/math64.h>

> +#include <linux/mod_devicetable.h>

No. This should be guaranteed by the respective bus header.

>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/unaligned.h>

...

> +	data->info = i2c_get_match_data(client);
> +	if (!data->info)
> +		return -ENODEV;

-ENODATA

...

>  static const struct i2c_device_id dps310_id[] = {
> -	{ .name = DPS310_DEV_NAME },
> +	{ .name = "dps310", .driver_data = (kernel_ulong_t)&dps310_chip_info },
> +	{ .name = "zts8032", .driver_data = (kernel_ulong_t)&zts8032_chip_info },

Using driver_data should be in a separate change.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, dps310_id);
>  
> +static const struct of_device_id dps310_of_match[] = {
> +	{ .compatible = "infineon,dps310", .data = &dps310_chip_info },
> +	{ .compatible = "zilltek,zts8032", .data = &zts8032_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dps310_of_match);

Adding OF table should be in a separate change.

...

Hence this patch should be split to three (or more if there are more logical
changes).

-- 
With Best Regards,
Andy Shevchenko


