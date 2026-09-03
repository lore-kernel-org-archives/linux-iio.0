Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FC3F3288;
	Thu,  3 Sep 2026 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417939; cv=none; b=V66WGhAdlEHXA/fHncVGx5TGrugAvTvwWRRbnCbRol+qyXPevBxB+cflolzWH/RSkkRICj9IIdjfXJCV/fPoK52uAcwCSuk2PdsTiWchfE68l4d122Ek7s4QkFXIo2sizsqZmthtZ0gYKyUdqwzdpSNL4JWYFO4NQk5lojJmKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417939; c=relaxed/simple;
	bh=niLGgFuOlcgZCs0x3Efeu+NaKy9qbFZnkFrBvOrKHmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DypJYp+pgeZ90KHSaH/o/t7mN05VQtVKLX7rsV3YfHBZ4phqKcovb92f7iKJyEmLxNdBlHwx9e5AgNJqRdJTMdRapm3/ER3Phs/IghsLtnHEFkBnZKtTSkGuZ9vYsa9MkCB5efwRrBCZGzCEytcyo45PA1V36ZQ2Bfei8U8MQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VW9UEptl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VW9UEptl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788417937; x=1819953937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=niLGgFuOlcgZCs0x3Efeu+NaKy9qbFZnkFrBvOrKHmg=;
  b=VW9UEptlxqSA4HhEKnu1Uf8mONncVL/bjvMI5gYFBcsLqHLX2QsxJ0LM
   4Ui/zKn4ChonwMIOCatWc5w/hxOnOB1CF7uTc3jqIkJ5imm21YA4OPxxA
   jtx1qtqAM2n377DSgCJ851E+Ro+w4P5QIXq5RKWjWH6enA1mnFo1y5qzO
   rfWXG2XAFuzrawVTnZVAuTT78wnhtiXipB3HEhwYuiAVY6BE2eT4s7T6Y
   4VFOmcjB0rL39NFXwEb3/PRMc+H6kJb80adhr9VJjBw2CVAaDdHmxiAb1
   cWlkdT456o8JmNOzMcslBDmnIEM5pxEn8LMvyOuPwETlF9lwUp1P9jQs+
   A==;
X-CSE-ConnectionGUID: +NWYescKSMmdGLv6osIeAA==
X-CSE-MsgGUID: zY5AMGESQ4CoqnG3CTJ3og==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88764629"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88764629"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:45:27 -0700
X-CSE-ConnectionGUID: Hk35I+GbS3+ym2HqwISfkA==
X-CSE-MsgGUID: A0m+rinMSu2a64X9OH7Ncg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="274915729"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:45:24 -0700
Date: Thu, 3 Sep 2026 09:45:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: ltc2497: add LTC2499 internal
 temperature channel
Message-ID: <apkXgcoYFiR4d0w9@ashevche-desk.local>
References: <20260902064415.132588-1-andrei.stancovici@analog.com>
 <20260902064415.132588-3-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902064415.132588-3-andrei.stancovici@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 09:44:11AM +0300, Andrei Stancovici wrote:
> The LTC2499 has an internal PTAT (proportional to absolute temperature)
> sensor that is activated by a second I2C configuration byte (EN2 | IM).
> Expose it as an IIO_TEMP channel providing raw, scale and offset so the
> standard IIO formula
> 
> 	T[m°C] = (raw + offset) * scale
> 
> reconstructs the temperature.
> 
> The PTAT sensor yields the absolute temperature as
> 
> 	T(K) = DATAOUT24 * Vref / 1570		(Vref in volts)
> 
> The raw value exported here is sign-extended and normalised to
> 2^(resolution + 1) == 2^25, i.e. raw = 2 * DATAOUT24, so on the IIO
> milli-degree-Celsius convention
> 
> 	scale[m°C/LSB] = Vref_uV / 3140000
> 	offset         = -273150 * 3140000 / Vref_uV
> 
> The scale and offset are derived from the reference voltage returned by
> regulator_get_voltage(); its error is propagated as before, so a board
> that fails to describe vref-supply gets a clear read error instead of a
> silently wrong temperature. No board-specific reference value is assumed
> in the driver.
> 
> The single temperature channel is appended as the last entry of the
> shared channel array and excluded via num_channels for parts without an
> internal sensor, so the existing LTC2497 channel layout and device name
> are unchanged.
> 
> The LTC2499 latches its converter configuration from the second command
> byte and only re-evaluates it when that byte has EN2 set. EN2 | IM
> selects the internal temperature sensor. Because a single-byte command,
> or a second byte with EN2 = 0, means "keep previous", a one-byte channel
> select cannot pull the device back out of temperature mode: after a
> temperature read every subsequent voltage read would keep returning the
> PTAT result instead of the selected input. Temperature support is
> therefore only correct if the voltage path also emits a second command
> byte that re-selects an external input.
> 
> Send two-byte commands for all conversions on parts that have the sensor
> (has_temp):
> 
> 	temperature:	EN2 | IM
> 	voltage:	EN2			(IM = 0 -> external input)
> 
> The LTC2497 and LTC2496, which lack the second-byte mechanism, keep using
> the original single-byte channel select and are unchanged.

Looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  struct ltc2497_chip_info {
>  	u32 resolution;
> +	bool has_temp;
>  	const char *name;

While `pahole` probably has found no issues with this layout, I would still
move boolean to be the last member here.

>  };

-- 
With Best Regards,
Andy Shevchenko


