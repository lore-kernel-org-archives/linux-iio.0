Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFB280A5C;
	Wed,  4 Feb 2026 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214448; cv=none; b=JwMAvhZJ16FIh+hEyTe11HDBXIWq5VsrJXM6vNT9uzt0IAWEwXtl2Up1oItObyv2itKDdtzKln3JHn5Jzi/IxdgFvT0E6pHf8Pm630LzHVq/mH8UU2S5HK1HA75WQA755TlbMYShpBRmzQR+6GLelUbE5VNCy6fjBVJkD6a/D34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214448; c=relaxed/simple;
	bh=DO/NUVL/AFlBtBzwy54pdC8LSgnO7nOvWqq2kHuP68g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4kl8PSwZKnt+UMYPMq68psTUZIpY7aPVP+IcDAv2iqxY/m/NmwIEJYRdt+yBshycJVF6M7U4DlmVkMDWQna98rZknHvLQEH7T0lnfndB1hIiFR2Lpf8l9nDyMZQkLP1NTD9VSXpSxHRmLBSds5tfVkocbyACTfUvqb4gKIMfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0xQFPhU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0xQFPhU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770214447; x=1801750447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DO/NUVL/AFlBtBzwy54pdC8LSgnO7nOvWqq2kHuP68g=;
  b=k0xQFPhUWi4lu/dpr5IVo8zstBWFmJKSG2FqghyYTGur1ozlf+t55wHY
   9/d/5NvCdE3uKlcNC4PGwrTOtpk65tL5vZHNpiLtfLTIDp4n7F54DGYPY
   tTq8TCJ9v80Z4fopsWil1VnVcOEyPE7CaI0uc5BnDcCdGqCjlvY2ISVFl
   H0vwFxakUhA5ABniCvx1tUoE95+umcR569u92Bxxa3LFd1mkZWQ3T62cW
   XN73hWPvbSPB3lASQ9Tmq4T2lQ8HwJXb9uI1m68FH488QTkmxA/KldjIe
   h2FX5PanaktptfSZMSrKg2wqAy0p+tw6Or3qDCoFvOt34pRkI7JN4JyR5
   A==;
X-CSE-ConnectionGUID: Y+lz1fU3QSO38yUGe3aOXA==
X-CSE-MsgGUID: wyZ1w1icQa+Uc9pz4TZIYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71297567"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71297567"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:14:05 -0800
X-CSE-ConnectionGUID: QY1wsCCtQCq4GPOCBMf+OQ==
X-CSE-MsgGUID: TIrmLjZvRwmuc4W6O3FrKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="240856365"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:14:02 -0800
Date: Wed, 4 Feb 2026 16:13:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 01/13] iio: dac: ds4424: reject -128 RAW value
Message-ID: <aYNUJyASwD67oOcN@smile.fi.intel.com>
References: <20260204140045.390677-1-o.rempel@pengutronix.de>
 <20260204140045.390677-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204140045.390677-2-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 04, 2026 at 03:00:33PM +0100, Oleksij Rempel wrote:
> The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented
> in hardware (7-bit magnitude).
> 
> Previously, passing -128 resulted in a truncated value that programmed
> 0mA (magnitude 0) instead of the expected maximum negative current,
> effectively failing silently.
> 
> Reject -128 to avoid producing the wrong current.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

(as agreed to use S8_* limits for now)

-- 
With Best Regards,
Andy Shevchenko


