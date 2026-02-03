Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109030EF83;
	Tue,  3 Feb 2026 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119192; cv=none; b=MCxQuOopUZgQqCbPvOkXUXKpUzTHlWB8UL2oB1H0+tlrdlCmGFBXCIo6a8FNX95Kvd+Jl2PE7vMPco+A3Z5yLmF3+FrNQs3mufV5Ps4aqXNA0+tQgNq1M5/Vi+WaYVklLr13d5EROG0L5XAyehIDWl6q3HYAbxyAlzDNMLSQZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119192; c=relaxed/simple;
	bh=sawoagXNx0vY8naaQB4gU8SI69oULHo02DjaHpOcXbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP6VRqouDzrSBur2eD+yaKTpl77polWkNT2+vk89V147WVX3w4PgX6TPnO/Rjfds5kKmFFFvJr4frxpLInLfX5Fv9x7UAuHfj/L7uAwSCC3W7BY0tvM6nW6ddBfXhLSN1CFf0KIgpmL+K6COFt4lzcITMp6v78MhxlQmgzvf8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cGT6l29u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGT6l29u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770119191; x=1801655191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sawoagXNx0vY8naaQB4gU8SI69oULHo02DjaHpOcXbE=;
  b=cGT6l29uXixD3x0IR/xVTIuCmPJ3gL2+Drc9LVrd7oHPMUtUNm6kE0bR
   rwMfDW+SdfulrfQuUdmd4OQy5iOSa5445Xib3FdUY0vaaOnPT1LENjy7d
   xDum5v70SyeQqiTbE3RGnJDZErRceEqpnJvbWdDDL/apMzRapxYeF23x9
   WR9DQ0eLst2ZChUSzM/HF7tnCz2olfEWYCd8koGkczAgj/puTHcWN7QOk
   CS6E/UlGV8CsR+92G7v1KD57lOVXMTiDbFl1i6B0bGWqxfDCU2cs5nCsE
   VUvC38jD2K0K1/dsvQB8ymuD+GIgljY5Uu1Q/O+voy4ONrvfw6ZhDrJ7r
   w==;
X-CSE-ConnectionGUID: zlY0WYcyTwyuRFJTmr8abg==
X-CSE-MsgGUID: VP9ikqhUTIyvkkcxG7eDuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82660658"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="82660658"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:46:31 -0800
X-CSE-ConnectionGUID: 2gX5Y6KuToyfK7icvv95UA==
X-CSE-MsgGUID: a7qnNXKsTSWugETBx1CD+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209118526"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:46:27 -0800
Date: Tue, 3 Feb 2026 13:46:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 10/13] iio: dac: ds4424: support per-variant output
 range limits
Message-ID: <aYHgEXRd76F8AnMU@smile.fi.intel.com>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-11-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203093434.2548978-11-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 10:34:30AM +0100, Oleksij Rempel wrote:
> The DS4402/DS4404 variants operate with a 5-bit resolution (31 steps),
> whereas the DS4422/DS4424 support 7-bit (127 steps).
> 
> Previously, the driver enforced a hardcoded 7-bit mask (DS4424_DAC_MASK)
> for all variants. This allowed users to write values exceeding the 5-bit
> range to DS4402/DS4404 devices, resulting in silent truncation or
> undefined behavior.
> 
> Add a `result_mask` field to the chip_info structure to define the valid
> data range for each variant. Use this mask to:
> 1. Correctly mask register values in read_raw().
> 2. Return -EINVAL in write_raw() if the input value exceeds the
>    variant's capabilities.

Makes sense.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


