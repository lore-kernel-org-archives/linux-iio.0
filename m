Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE130EF87;
	Fri,  6 Mar 2026 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809452; cv=none; b=iYFovRNKScLternUxXG5bpPk9V1Kji43z1ae3dfcOUF4U53VsImp8I8B2TKmOX1RN450sL7S3FRvpbQj0Z65XtheqUGxpcOPE7wM3X++L8q4BTUBXh5LJr5NelY8y4I/Jh2Tj/4STmwtQv/PjFi+Os/1O8NJlMGoHall4vfnh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809452; c=relaxed/simple;
	bh=SAhDBUxkXICGIXFT0B7dQT8RXO7TBcx2mqPsOeIUKhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLqn/oGkuiSwWcLT3vg0dnv8VyrNH66q/5l9PVOkbzdddq/0glvuHsIjh9/ljepYdEOMaJGT6s4EMQLlKdsr0TJlQH5Y1lsfKJvTFt73ZfgDD9Oevlf+xzpqAYPdbAq1ka+9AnoO0adQHM/lZD3rc7EH7TQYPdvY7soUQqcOB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YztM49ix; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YztM49ix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772809450; x=1804345450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SAhDBUxkXICGIXFT0B7dQT8RXO7TBcx2mqPsOeIUKhU=;
  b=YztM49ixIL4qIvlw/u2DKWfRAIbcT2jIfybuI0YphufAsS3MNjANfJoa
   9XhJDEBAARq6QPLEZFiMtTgYTd/ZOsj7bNJ+b3lSXvvnkC2/cAi2R94tG
   s0p3GC+QBJIz5NaV81vcwxjQS6BGxWWHymiqu2yqk2j+DnXsvIY0yyhit
   eWxBEXHkXLkIzZEu6gwKQDjK0qsgpCK2YQx1FzW8ouJzQNEpAeFyvJOWQ
   iR4PhH6dGH0XrZOqGHpDGBKXyXOoyMWMjOUXKFYPQ71pjzrMIOxVI29z+
   E0OCv4kwbpyONb2dEW/+YUGPwpoNntRzL6axsSFThFSkSXCd/nD915QVW
   g==;
X-CSE-ConnectionGUID: fnA4m+6aQ8OwGVKN+n25hw==
X-CSE-MsgGUID: wxdcf/nbSRqxw3oiTBwj9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="96534675"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="96534675"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 07:04:09 -0800
X-CSE-ConnectionGUID: eThrUbIkQ5W1esjHJeVdEg==
X-CSE-MsgGUID: 9GYdynhUSZ+aN2/k3SwwMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="218263460"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 07:04:06 -0800
Date: Fri, 6 Mar 2026 17:04:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] staging: iio: adt7316: add config names to
 registers and reorder
Message-ID: <aars5G53on8L_tzg@ashevche-desk.local>
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
 <20260305-adt7316-correct-macros-v2-3-3702e3841c42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-adt7316-correct-macros-v2-3-3702e3841c42@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 05, 2026 at 11:17:00PM -0800, Michael Harris wrote:
> Add config names to macros to make it more clear which register they're
> affecting. Also renamed ADT7316_EN to further clarify what
> it's enabling.
> 
> Some macros were reordered, so that mask values were below the actual
> mask.

...

> +#define ADT7516_CONFIG1_SEL_AIN1_2_EX_TEMP_MASK	0x6

GENMASK*()

...

> +#define ADT7516_CONFIG1_SEL_EX_TEMP		0x4
> +#define ADT7516_CONFIG1_SEL_AIN3		0x8

Bits? Values?

...

> +#define ADT7316_CONFIG1_INT_EN			0x20
> +#define ADT7316_CONFIG1_INT_POLARITY		0x40

These looks like bits, why not BIT*()?

> +#define ADT7316_CONFIG1_PD			0x80

A bit?

...

> +#define ADT7316_CONFIG2_AD_SINGLE_CH_MASK	0x3
> +#define ADT7516_CONFIG2_AD_SINGLE_CH_MASK	0x7

GENMASK()

> +#define ADT7316_CONFIG2_AD_SINGLE_CH_VDD	0
> +#define ADT7316_CONFIG2_AD_SINGLE_CH_IN		1
> +#define ADT7316_CONFIG2_AD_SINGLE_CH_EX		2
> +#define ADT7516_CONFIG2_AD_SINGLE_CH_AIN1	2
> +#define ADT7516_CONFIG2_AD_SINGLE_CH_AIN2	3
> +#define ADT7516_CONFIG2_AD_SINGLE_CH_AIN3	4
> +#define ADT7516_CONFIG2_AD_SINGLE_CH_AIN4	5
> +#define ADT7316_CONFIG2_AD_SINGLE_CH_MODE	0x10

...

> +#define ADT7316_CONFIG2_DISABLE_AVERAGING	0x20
> +#define ADT7316_CONFIG2_EN_SMBUS_TIMEOUT	0x40
> +#define ADT7316_CONFIG2_RESET			0x80

Bits?
And so on...

...

Are you going to have this conversion in a separate patch?

...

> +	switch (chip->config2 & ADT7516_CONFIG2_AD_SINGLE_CH_MASK) {
> +	case ADT7316_CONFIG2_AD_SINGLE_CH_VDD:
>  		return sysfs_emit(buf, "0 - VDD\n");
> +	case ADT7316_CONFIG2_AD_SINGLE_CH_IN:
>  		return sysfs_emit(buf, "1 - Internal Temperature\n");
> +	case ADT7316_CONFIG2_AD_SINGLE_CH_EX:
>  		if (((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) &&
> +		    (chip->config1 & ADT7516_CONFIG1_SEL_AIN1_2_EX_TEMP_MASK) == 0)
>  			return sysfs_emit(buf, "2 - AIN1\n");
>  
>  		return sysfs_emit(buf, "2 - External Temperature\n");
> +	case ADT7516_CONFIG2_AD_SINGLE_CH_AIN2:
> +		if ((chip->config1 & ADT7516_CONFIG1_SEL_AIN1_2_EX_TEMP_MASK) == 0)
>  			return sysfs_emit(buf, "3 - AIN2\n");
>  
>  		return sysfs_emit(buf, "N/A\n");
> +	case ADT7516_CONFIG2_AD_SINGLE_CH_AIN3:
> +		if (chip->config1 & ADT7516_CONFIG1_SEL_AIN3)
>  			return sysfs_emit(buf, "4 - AIN3\n");
>  
>  		return sysfs_emit(buf, "N/A\n");
> +	case ADT7516_CONFIG2_AD_SINGLE_CH_AIN4:
>  		return sysfs_emit(buf, "5 - AIN4\n");
>  	default:
>  		return sysfs_emit(buf, "N/A\n");

Side note:
Instead of this long switch I would rather introduce  a clear string array per
each of the possible variant. Note, that linker will eliminate string duplication,
so it won't be a problem.

...

> +	switch (chip->dac_config & ADT7316_DAC_CONFIG_EN_MODE_MASK) {
> +	case ADT7316_DAC_CONFIG_EN_MODE_SINGLE:
>  		return sysfs_emit(buf,
>  			"0 - auto at any MSB DAC writing\n");
> +	case ADT7316_DAC_CONFIG_EN_MODE_AB_CD:
>  		return sysfs_emit(buf,
>  			"1 - auto at MSB DAC AB and CD writing\n");
> +	case ADT7316_DAC_CONFIG_EN_MODE_ABCD:
>  		return sysfs_emit(buf,
>  			"2 - auto at MSB DAC ABCD writing\n");
> +	default: /* ADT7316_DAC_CONFIG_EN_MODE_LDAC */
>  		return sysfs_emit(buf, "3 - manual\n");
>  	}

Also can be just a string array with indexed access and a single call to
sysfs_emit(buf, "%s\n");


...

>  static IIO_DEVICE_ATTR(ex_temp_AIN1, 0444, adt7316_show_ex_temp_AIN1,

Side note:
Can IIO_DEVICE_ATTR_RO() be used here (and in other similar cases)?


-- 
With Best Regards,
Andy Shevchenko


