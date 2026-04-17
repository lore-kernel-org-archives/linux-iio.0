Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19224677B;
	Fri, 17 Apr 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414923; cv=none; b=fpIpUcE7SdIhdn7wHqHNuOPraHQhS6i7MwDsiJz3mrzC0ozHhwzl/2Y1huhvOAM62L10+wSaZPTmGgYSVGdKpZv441Xo2k1gYn8V0gH/1seOGfJGXZ14J2lAOkJ0z7lcWVDBk0UxuFx1L3o+kB8iRMPha3dieIswbEaA5mvKHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414923; c=relaxed/simple;
	bh=zR7+9dP1+DpJDiJ+XcPLqbQViv2kqXUxCxZip6yFEbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NidxuCEjBC5KsQuOQYC5DCvACYRFW//UadbgobptkJDetSeWo+cdZg49cODWYkUfIrgska0YrVXvsUlVIKZrwWg5KrTQHy+UA4zwgBmh6CeJ2DAyNYqphCHtDqkrs1rsuloDvL9FU9IUtZ00azrl97AzEVUt9uNCftdTZBVWYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGWMutRO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGWMutRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776414922; x=1807950922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zR7+9dP1+DpJDiJ+XcPLqbQViv2kqXUxCxZip6yFEbM=;
  b=MGWMutRO8myc52lPtJS7WBgfdLbPg5QjruhzEqIDirTcIu8Je8WPeVu+
   r3vHkE1PWXe9LsoVHI06tNjFT7XzdPEhEwXsQqcoFu8NxXyywbAxsMPJK
   bL/YP5NPbCesDoARANSNASmdOo0XF7OJazT7fBYRBRKMboCuWgxgmbQtr
   YfAiTgo2NbwXBE+Znc2eTnOgR5HiDoxhk5FOYtTOjeVpRcNk3Q0JsR3ug
   cyzm+WWbhsTDMJpLGmMgZ+0AOr8tmM0AzidzK3APeNH3YnbkLTzs1bCRe
   niO5+KBnSFzEugYunW4thjGKedlVtwENWcwppCX5FtjOgOgkQBqLWa71A
   g==;
X-CSE-ConnectionGUID: 91wb8fFWSfWs1nfHtA2WvQ==
X-CSE-MsgGUID: haUKPwr/SuqreDaggpA7Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81299419"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81299419"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:35:18 -0700
X-CSE-ConnectionGUID: oqV0CzeQTJiR7fXjMAW4nw==
X-CSE-MsgGUID: R/rTHQ0PQrCKfpJ0fTwNEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="232728804"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:35:15 -0700
Date: Fri, 17 Apr 2026 11:35:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <aeHwwN2sFJBzQ21H@ashevche-desk.local>
References: <20260417-dev_ad5706r-v8-0-ef87dff62b57@analog.com>
 <20260417-dev_ad5706r-v8-2-ef87dff62b57@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-dev_ad5706r-v8-2-ef87dff62b57@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 04:27:16PM +0800, Alexis Czezar Torreno wrote:
> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 
> Features:
>   - 4 independent DAC channels
>   - Hardware and software LDAC trigger
>   - Configurable output range
>   - PWM-based LDAC control
>   - Dither and toggle modes
>   - Dynamically configurable SPI speed

...

> +#define AD5706R_DAC_RESOLUTION		16
> +#define AD5706R_DAC_MAX_CODE		GENMASK(15, 0)

I know Jonathan asked for this, hence it's comment for him.
I think that BIT() notation in a form of (BIT(16) - 1) is
also appropriate here as it gives the relationship to the
resolution of the given register / bitfield in HW.

GENMASK() works for me, but it might require an additional
operation to deduce the above.

(Note, there is no request to change or resend for you, Alexis. It's just
 a remark to make Jonathan to think about which one suits better. He might
 change that whilst applying.)

-- 
With Best Regards,
Andy Shevchenko


