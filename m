Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C53F88B8;
	Mon, 15 Jun 2026 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533852; cv=none; b=bZOYXj9yCS9tBKT+tCnqYR6Al+mjdT0xZ4obE7LaLt4f/wdeCc9F35CSTBcSVWJVoYxhegO3I1lMrWZqBQK5qjRCf2GobchJD2QzU6fgUYfWwzxkfto7PNPQ3T6imYMtnAeR5cAppvhD0AkZEQ1bPHh9uyER5arjxU6yhUhmacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533852; c=relaxed/simple;
	bh=eeKfuNDktYjoBS3dmFiTkel/+BwxgBfVU25t5KzqhsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSSiSwB/J9UCXEnw3rdfeGfwPG8wNXwV+KM2JQUnGx3s/G24Gw4md+iMhQBv4GkPd3o7aR+0cvekauVW7lG8FhRyRYfQmEfxK739emFe3Phsw4Fpmy8tNAW0VfJKk3rEkTMijDzJqSG20pJtXvtKIJgalqP/HOnx4KzAddTlgYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7MOjS2i; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7MOjS2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781533850; x=1813069850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eeKfuNDktYjoBS3dmFiTkel/+BwxgBfVU25t5KzqhsU=;
  b=k7MOjS2iO3QQ4JdonELUcxOr+bR0mSvGa9tSoIiILGjkzon5riOF779p
   PizU6HLQm3sWL3TAsdfA+FbY7/uWiV/dMgYUu5NB4NIlyIdKfnJB+f507
   HySfeMMmW2ErzyGzh/gmbJ14sIl9mbGrnR+kuPFZKZYubYS3NBwQa1Uxi
   /r7jmXOBbEnNVsYw/RrKJ06E2NUx7XhTdLuEKnckDckTQhpjAmWVpEKMa
   PgZfWk562bH16gkTO1SAtr10hpGGleFeVfJZJ57Yy3pvuR+H22JnAO8Cp
   WfewZB1cRKtF4hgI7GqJ71B285BjbUBJRHpM4tWSFGpybzAJRTuZ2uPMm
   A==;
X-CSE-ConnectionGUID: HQ+usF8kT7CZnhZxpX+RRw==
X-CSE-MsgGUID: o7OdfnndSLaZ0IjXjf207A==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82312242"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82312242"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:30:43 -0700
X-CSE-ConnectionGUID: 8O33OnCSSiaC1yGI5gSpng==
X-CSE-MsgGUID: 0zr5w2RgRNOnZZ+ge9rOZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="251410643"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:30:40 -0700
Date: Mon, 15 Jun 2026 17:30:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/5] iio: adc: versal-sysmon: add I2C driver
Message-ID: <ajAMjZzfTqplts_B@ashevche-desk.local>
References: <20260614233722.2603459-1-salih.erim@amd.com>
 <20260614233722.2603459-4-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614233722.2603459-4-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 12:37:20AM +0100, Salih Erim wrote:
> Add an I2C transport driver for the Versal SysMon block. The SysMon
> provides an I2C slave interface that allows an external master to
> read voltage and temperature measurements through the same register
> map used by the MMIO path.
> 
> The I2C command frame is an 8-byte structure containing a 4-byte data
> payload, a 2-byte register offset, and a 1-byte instruction field.
> Read operations send the frame with a read instruction, then receive
> a 4-byte response containing the register value.
> 
> Events are not supported on the I2C path because there is no
> interrupt line and the I2C regmap backend cannot be called from
> atomic context.

...

> +static const struct regmap_config sysmon_i2c_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = SYSMON_REG_STRIDE,
> +	.max_register = SYSMON_MAX_REG,
> +	.reg_read = sysmon_i2c_reg_read,
> +	.reg_write = sysmon_i2c_reg_write,
> +};

No cache?

-- 
With Best Regards,
Andy Shevchenko


