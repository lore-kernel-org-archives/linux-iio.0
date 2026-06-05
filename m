Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E3377563;
	Fri,  5 Jun 2026 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681944; cv=none; b=aMb4S/yQh8mDXh8S5JIw0S1HZjtf7F4PZWIPamTaE555Dh0Eqnk3f/sb+C56trnRta+Po25TS2sQvFmNPkSbJYdw3enq1OjhdG/wnHZn5N1+qSV3z2KcueN92yVrX7V0xElJcsH6rWYfWwyqbgqnE0q7KMbQMFkmOZPu+KnpUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681944; c=relaxed/simple;
	bh=UP95N0DlzO2m6BFHxSdTVRvxptLOM2N2fHvS+eCzIcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4fKWm4+65Rh7W3NQ81PRDrw45yhs8C1ZeRxmyYIQI5tzf7gCpKtN51bjGp7zj1oDjek7Z2X9ksvH/zclgOJjpLYzlvP8Euzr5Tu1c+bMlHEwUK1/vC1F0i15R2VQcuF/wriRXyunFTRIiy0O07j7qBG7fjbqLDAsHfGTEuaJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hk+M56vZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hk+M56vZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780681940; x=1812217940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UP95N0DlzO2m6BFHxSdTVRvxptLOM2N2fHvS+eCzIcA=;
  b=hk+M56vZySU8CGZJ6SVSN8ymCSQLqsZuREbbFIndkwvTYtlUFpvPlHSg
   Ccna46gOV3HZ71/mOgLYgNUdhmsDVowHzso9Ug3yWb5q0EU86/ps/kkIs
   saK5PsNDNAdxpvWhABt5ZsMb0qGon0iyZy7DUH0OrAHoLZ0dohiUgLb06
   A/FAhCJnPa1dNMXsb0pM03um0EXGQ07W+1WsTs5sySTNv86DiO7g2+57q
   q7/zIxqrA7Y3ir5WWDjF78/6Z0vkwpGWFwxzlcd6Ex/7kxNSlGt3a43i7
   Y3ctXPKOeR9g1AluwH4iqg1Pe400L2AN9mkQmHP66oainrVCLwTmvsSZR
   w==;
X-CSE-ConnectionGUID: 3Dj6T6g7TXO2I2EjsYClDQ==
X-CSE-MsgGUID: 8vQj4DjaTi28zFgzrl9AQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="92089615"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="92089615"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:52:19 -0700
X-CSE-ConnectionGUID: tKKG8e4VQsa7InrUwgs+Aw==
X-CSE-MsgGUID: 4nes/u9/TSe792NXfEUjwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="245024817"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:52:15 -0700
Date: Fri, 5 Jun 2026 20:52:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: jic23@kernel.org, linusw@kernel.org, denis.ciocca@st.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sanjayembeddedse@gmail.com, maudspierings@gocontroll.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: magnetometer: st_magn: honour st,fullscale-mg
 DT property
Message-ID: <aiMMzSf8-C9fTlWW@ashevche-desk.local>
References: <cover.1780652883.git.github.com@herrie.org>
 <a8b63f5997700aba85883816a5d7520dcb28a96d.1780652883.git.github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b63f5997700aba85883816a5d7520dcb28a96d.1780652883.git.github.com@herrie.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 12:08:43PM +0200, Herman van Hazendonk wrote:
> The ST magnetometer core's common probe hardcodes fs_avl[0] -- the
> highest-sensitivity full-scale supported by the chip -- as the
> starting range. For the LSM303DLH that is +/-1.3 G; for the
> LSM303DLHC and LSM303DLM it is +/-2 G; for the LIS3MDL it is +/-4 G.
> 
> That is the right default for "minimal noise floor at a desk", but
> it leaves no margin for boards that pick up appreciable DC bias from
> nearby PCB structures. On the HP TouchPad (apq8060 / tenderloin) the
> LSM303DLH magnetometer is mounted close enough to the surrounding
> power planes that X reads back as the chip's 0xF000 overflow
> sentinel (== -4096 raw, the value the chip publishes when the ADC
> saturates) on every sample at the chip-default range, while Y and Z
> fall well within the +/-1.3 G window.
> 
> Parse the st,fullscale-mg device-tree property (documented separately
> in dt-bindings/iio/st,st-sensors.yaml) in the magnetometer common
> probe to select the initial fs_avl entry by its mg value. The driver
> tolerates an unknown / unsupported value by falling back to the chip
> default and warning, so the property is purely additive -- existing
> in-tree DTSes are unaffected.
> 
> Per-sensor mg ranges are listed in st_magn_sensors_settings[]. For
> LSM303DLH the valid values are 1300, 1900, 2500, 4000, 4700, 5600
> and 8100; for LSM303DLHC they are 1300, 1900, 2500, 4000, 4700, 5600,
> 8100 (same code path); for LIS3MDL they are 4000, 8000, 12000, 16000;
> and so on. Sensors with a fixed full-scale (fs.addr == 0) simply
> ignore the property.
> 
> Empirical scale sweep on the HP TouchPad confirmed that on this
> board any fs_avl >= 1 produces non-saturated X readings:
> 
>     scale (0.001 G/LSB)  | X raw    Y raw    Z raw
>     --------------------+-------------------------------
>             1.100        | -4096    44       46    (X saturated)
>             0.855        |  -547    37       37    (clean)
>             0.670        |  -433    94      103    (clean)
>             0.450        |  -266    44       71    (clean)
>             0.400        |  -235    34       65    (clean)
>             0.330        |  -196    27       56    (clean)
>             0.230        |  -145    15       40    (clean)
> 
> 2500 mg is the natural choice for tenderloin: comfortably outside
> the saturation regime while keeping useful precision for compass
> applications.

...

> +	{

Oh, no. Use

	const char *propname;
	...
	propname = "st,fullscale-mg";
	if (device_property_present(..., propname)) {
		struct st_sensor_fullscale *fs = &mdata->sensor_settings->fs;
		u32 fs_mg;

		ret = device_property_read_u32(parent, propname, &fs_mg);
		if (ret)
			return ret;

		...
	}

instead.

> +		u32 fs_mg;

> +		if (!device_property_read_u32(parent, "st,fullscale-mg",
> +					      &fs_mg)) {
> +			struct st_sensor_fullscale *fs =
> +				&mdata->sensor_settings->fs;
> +			int i;
> +
> +			for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
> +				if (!fs->fs_avl[i].num)
> +					break;

This is strange. What's the point to go via the whole table? Does it have gaps?

> +				if (fs->fs_avl[i].num == fs_mg) {
> +					mdata->current_fullscale =
> +						&fs->fs_avl[i];
> +					break;
> +				}
> +			}
> +			if (mdata->current_fullscale->num != fs_mg)
> +				dev_warn(parent,
> +					 "st,fullscale-mg=%u not supported, using %u\n",

Also use %s and propname.

> +					 fs_mg, mdata->current_fullscale->num);
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko


