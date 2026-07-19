Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A42C0260;
	Sun, 19 Jul 2026 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450876; cv=none; b=jVhattHIzw6/QFcT98+A004PMhwKfvn5EzNlmRnwbaaL12pIdZ4QCAoRKa1hZscOPeaaZt4oYawOZpQ/9KS3iioi9foG9tGrX+au5Qn3+V2iyVJHZ2FulavbR75fJ3F+nV59ATkfHzn98fnTlRoKGNUyRuhhzKLUf19O6DW5ubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450876; c=relaxed/simple;
	bh=CySbW7guZsMaeDMWqUfAbPyFr3Edwns9BbvtBOXALg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkoRmE+A37szGiioFkqKkFUGBm/zp6G+2iaC0bsJnlXiUqukktYznrbDBqu9eHkwIdPdSpiMgXLKVnHxYLxo6SGArCtdv6tmd8OZHM5ad/lmMNll4f2LIEYzWudbNjiOocXy6gPYwcGfV39hIrKAQ5pg2YONBXBiDlr5QNVIvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1dlyMyj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1dlyMyj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784450875; x=1815986875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CySbW7guZsMaeDMWqUfAbPyFr3Edwns9BbvtBOXALg8=;
  b=d1dlyMyjNhfAq6P4ONpIUmB1V2jvBdZ9/vO+PC8A0Wp+bJmXCwoQJp33
   WNzSfeSratOrvH3mkJfUF34PkXSrlDtn8APWg2Rb5pYHX2prHijdcX88S
   SO2oZCIeWSpg/W9vAzbPaJEd7ERC/VTyX386L+Npd1Gu09hJ/rvTzC/LM
   P50uB1COlA5edHTTQCw9LG9Nw/VuRq/aQMsxzcR33qLRjwlWYOx+sD20j
   PHR9LgTzEFNMFUPuTGxLasUEmFbECSmJLSNjJ5y+84jfAr2jncwHxJ2PD
   pAUUxJOJFIco4tIHw1i5yz8dBFoMHEt58clt3dLPn75ysnqrt+Br+imTR
   Q==;
X-CSE-ConnectionGUID: oAAQdqhvRtyWhuGyez/UHQ==
X-CSE-MsgGUID: 5cyEmytBRUKkI4/lGvT8bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="95653824"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="95653824"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 01:47:54 -0700
X-CSE-ConnectionGUID: 1Gj7sz93SXSv5IggMt/kqw==
X-CSE-MsgGUID: YwftVfGNS5W6b2jZe3ppDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="253224673"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 01:47:51 -0700
Date: Sun, 19 Jul 2026 11:47:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v3] iio: pressure: dps310: add triggered buffer support
Message-ID: <alyPNM21R2PEzkli@ashevche-desk.local>
References: <20260718224455.38acd927@jic23-huawei>
 <20260718235203.73699-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718235203.73699-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 19, 2026 at 02:51:58AM +0300, Rupesh Majhi wrote:
> Add triggered buffer support so pressure and temperature can be captured
> into a buffer instead of only through one-shot sysfs reads.
> 
> Pressure is a processed value in kPa computed from a non-linear
> calibration polynomial. To keep full resolution in the buffer without
> disagreeing with the sysfs unit, add raw and scale attributes for
> pressure (raw in Pa, scale 1/1000 to kPa), following bme680; the existing
> processed attribute is kept for ABI compatibility. Temperature is already
> a full-resolution value in its base unit (millidegrees Celsius) and stays
> a processed channel.
> 
> Pressure compensation depends on a temperature reading, so both channels
> are always captured together. The device already runs in continuous
> background mode, so no buffer setup ops are needed. Sysfs reads and
> reconfiguration return -EBUSY while the buffer is enabled, as they share
> the capture path's raw values and configuration.

Do not reply to the same thread with a new version.
Do not reply within less than 24h.

The change needs more work, See my comments below.

...

> +	/* Buffer to hold a scan; timestamp is naturally aligned */
> +	struct {
> +		s32 chan[2];
> +		aligned_s64 timestamp;
> +	} scan __aligned(8);

We have a macro for this (alignment). Or even for the entire struct.

...

> +static const unsigned long dps310_scan_masks[] = { GENMASK(1, 0), 0 };

Jonathan usually asks to provide a bit-wise definitions and use them here
instead of GENMASK().

...

> +	case IIO_CHAN_INFO_SCALE:
> +		/* Raw pressure is in Pa; scale to kPa per IIO ABI */
> +		*val = 1;
> +		*val2 = 1000;

So, we have KILO in units.h.

> +		return IIO_VAL_FRACTIONAL;

-- 
With Best Regards,
Andy Shevchenko


