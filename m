Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B061A6838;
	Fri,  2 Oct 2026 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946210; cv=none; b=fTksVOrIdB1T8grv6eE6YAhfQtLpbMqp4gOs2CGhatPskxTl5F4KXaFmJDMQkorkwNwZDkAJhM2IlFaXWNQ8OALS395eeh4T9QUPRxBcbJu9JGAlFTItO2fOERodcM9E61efA2AySkLvVrc93Ua2owck3tXaU6tgtkqtXNYyyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946210; c=relaxed/simple;
	bh=F6PVcADhNKYWkVKrCpCx0RVsVZrpMQIVuFfdNv+iofY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDXihF+moBAoZFMc9D/ocGLJ39ff/ktgvpdQ/JUISrWipKUYXccJ3+kDbgurG6WPptQDtdixJek8SOaeVnHXDpJom98geUbgLNZjzhvLFJeHmaJvL15NkRGuMrxWw9IqF5BwEqVtJFqiY8ubE1/D2IaX4AnDoqJBe9x5Y5szKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmuQqRZe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmuQqRZe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790946208; x=1822482208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F6PVcADhNKYWkVKrCpCx0RVsVZrpMQIVuFfdNv+iofY=;
  b=ZmuQqRZeUC6yGVhyomM0KIKosGY+VRwaaT/MMYu/JCB6OCgyGQWbTfUw
   MIU4jC/6UjaL1Gn1xdHJBPI04jQJEY2+SfoMTA5RUK2wDodgbAri7SR5G
   GBPXT0taoYoltxR6PqcsCMvWYfFBPMOt01DrfHcT2NzCYJESAzpvupNMw
   aOvskxXp++96T8ehKO4H3ZZpHuifh1lUuiPnOC2PU6YSC+bibl0tnvSwr
   FYlDNRZ+Za0tT0dRILginLb5T5H1dWv8geG5ZTslHTIEViTQZWo0N4HHh
   pt7aeq8XbXup3usj/i+q9+Mg+H9PntnCuFOIRTnVVqk+hxBcV2tWwVCGn
   w==;
X-CSE-ConnectionGUID: Ga/xjx16Qf+XwXZ3yONdqA==
X-CSE-MsgGUID: E/WK/lBcQ7iJUJNzHgL/pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="109196199"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="109196199"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:03:25 -0700
X-CSE-ConnectionGUID: 1s+OGAL1RmaJguyTMdfi6A==
X-CSE-MsgGUID: pXJQnoCUQIWINzoW2rzCjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275797199"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:03:21 -0700
Date: Fri, 2 Oct 2026 16:03:18 +0300
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
Subject: Re: [PATCH v5 3/6] iio: imu: inv_icm42607: Initialize gyro based on
 chip_info
Message-ID: <ar-rljceYiSEzU_z@ashevche-desk.local>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-3-c65281b745c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-b4-inv_icm42370p-v5-3-c65281b745c9@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 01:54:27PM +0200, Kanak Shilledar wrote:
> Update the chip_info struct with a new `has_gyro` property to support,
> devices which do not have gyro functionality. This is a precursor to the
> next commit which adds support for the Invensense, ICM-42370-P. It is
> similar to the existing device except it only has accelerometer. Check
> all operations related to gyro with the boolean.

...

>  	int ret;
>  
> -	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);
> -	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
> +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
> +	if (st->hw->has_gyro)
> +		val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);

Personally I found if-else slightly better as one needs no detour to understand
the whole value.

	if (st->hw->has_gyro)
		val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode) |
		      FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);
	else
		val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);

>  	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
>  	if (ret)
>  		return ret;

...

> +	if (st->hw->has_gyro) {
> +		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->gyro.fs);
> +		val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);

No need to have two assignments, do it at once.

> +		ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
> +		if (ret)
> +			return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko


