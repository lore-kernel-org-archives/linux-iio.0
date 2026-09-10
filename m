Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2E3B52EF;
	Thu, 10 Sep 2026 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020678; cv=none; b=CBRVBzKsVSTX4tOr+aw64851Fj7wvYIM/nHuZhOgXvUn1sCGPQDsHY4v+SweVU/cFVjPVGen+AMIhhxTikeTVsyJLkABlbGd4MVw7CZ784aIoGqbLDDjQEE3Tax74R2HWwE/F3Bo/xGe/xz0SdlsF1bLqMXcgK3LNWgvQnR/pG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020678; c=relaxed/simple;
	bh=QwNridbtN+uHeClq4a+JVROnQE83dx90utjc+3oG40c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCg/d2qOJlUYTfEzdKXOYEBcwVbxNfQz0p5xKLj1O7+qSO1wcDlgy08V9X5or1GyD4EjLAvhiBFpatIMgAzxTXe6PcAyna54E/R5h6KGwxI8Hczb6cgQ4ERoicjqNsxLQHwd9A2Xf7ALiyMKF8kkx9Gbc3Si0q/HURcLSMORA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPbOCxIJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPbOCxIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789020674; x=1820556674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QwNridbtN+uHeClq4a+JVROnQE83dx90utjc+3oG40c=;
  b=OPbOCxIJz0S6AqLUbPOGq3jLT/VWh9INCRZg05SK/bcQqWhzWQa04kA6
   EEUDmSytBYb2ej9FwTgG+LTvbm6ovdotr+ivxxjux5Sf3Rj4p2wvETitF
   VhVpO/g2/cV+Nc1T1ph9ovWXfVkX/g3VSDS8CM38Zh3V/hy2MUynPslzn
   EIpAV3c08QVfZktZOc7h4asGnP4iGqupLPKxdFcGZKLDKH1pjVZTxYla2
   jO8tJjKj0Sp0tkhslJxdUWwq7nXAyvAQjVdQKcwaacZ5dJWCKfuhN+te0
   YhHDZLroP7Hk2FrtPH7HGDWxlCfyCP4FZrgyIEsg2Cdsh50Hyk1PSZsDr
   w==;
X-CSE-ConnectionGUID: nV91dn9bSN2qpXXnaiISRg==
X-CSE-MsgGUID: ayE39PaBRlS36BozTsFF5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93286547"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="93286547"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:11:09 -0700
X-CSE-ConnectionGUID: /gZHSE5NRS2DWmVQk9pBqA==
X-CSE-MsgGUID: t4T+ut5mSA6TC3m5vQ+kdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="267846085"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:11:05 -0700
Date: Thu, 10 Sep 2026 09:11:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/10] iio: dac: mcp47feb02: Increase EEPROM
 Programming Write Cycle Time
Message-ID: <aqJJ95_uvUowDbMo@ashevche-desk.local>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
 <20260909-mcp47feb02_refactor-v5-4-8b67bcab93d1@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-mcp47feb02_refactor-v5-4-8b67bcab93d1@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 05:18:47PM +0300, Ariana Lazar wrote:
> Increase the EEPROM write polling timeout to prevent -ETIMEDOUT errors and
> incomplete nonvolatile write cycle, according to the time specified in the
> datasheets (11-16 ms).

...

>  	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
>  				       eewa_val,
>  				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
> -				       USEC_PER_MSEC, USEC_PER_MSEC * 5);
> +				       USEC_PER_MSEC, USEC_PER_MSEC * 1500);

While at it, make it clearer with

				       1 * USEC_PER_MSEC, 1500 * USEC_PER_MSEC);

(note that some editors marks numeric constants with distinguishable colour).

>  	if (ret)
>  		return ret;

...

>  	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR, eewa_val,
>  				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
> -				       USEC_PER_MSEC, USEC_PER_MSEC * 5);
> +				       USEC_PER_MSEC, USEC_PER_MSEC * 1500);

Ditto.

>  	if (ret)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


