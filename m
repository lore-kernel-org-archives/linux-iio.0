Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAB3A4510;
	Wed,  2 Sep 2026 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347083; cv=none; b=e8ZwoX7fLkrvruZ5kSftfck55a8a/83j94KPC+8OL229aMaEgOMbExpJp8MFZBaeoyM4nwEsHxZxL/2C31TPrtkhr+5SkIJ15TyMDgYcDKuFJ3SEFGJoHQcksxGtQyg6mOpjsAxipOcBlXuj9m9pkokao35n3x9x1hUvRe4iaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347083; c=relaxed/simple;
	bh=qwetBkwPV/BecwdCTylobCVUO79rqCxrXRGVs48GO2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPe1YSUiPRVLqKWTZLQ0TpgQldH9WogfLqU7NefInfsjcbjgEkHSHbf+44cTUfs7koYTTATFQlsB1D4faXQ56ZZr1EMnwpsI7LKk6unFH2p+LF6KNRYmRGLRe4KDMHUO6KSC4vOx0r2R6HY3JOcWEotnxyTtcAlNGTkH96Dx7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVB2Uv86; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVB2Uv86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788347082; x=1819883082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qwetBkwPV/BecwdCTylobCVUO79rqCxrXRGVs48GO2k=;
  b=JVB2Uv866HkddZg3JX68/yZPfA0yeECFMtM4O9gTKMINE+xkK6fvh30y
   0TfatIrkOM9yuNt5hC9hl8barxzHurVVZSYPUaoHsOxzZCdP+ijDoALje
   3QjXd1I9r1g616o2FD7YnXRFyBEcC1tDd4F7mOaFa7Fb8bOM8XfF3ecl+
   Z5tRT84VqNJUpIsMwFxwBkjGIAW5h2xFFQp/8UEH/+703v65P7fziN9OX
   y95eea1Avd+X7oYR+lEdOfzHV6OQ6rAyyY4Y1l5UoRvfOT/vSqEJeUPTZ
   S2Htl1co7Vu4jqViqVKEjgyPlHL9rJCwINFCD9qPXL0RUAQmmHNiLZaTD
   w==;
X-CSE-ConnectionGUID: KOPgmAkRQXimLPgVZFMQzw==
X-CSE-MsgGUID: 0nzeCE4QS9yfGvcwZ2QeMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92622160"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="92622160"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 04:04:42 -0700
X-CSE-ConnectionGUID: RVAaSA4TTtiVRlj5QwQTEA==
X-CSE-MsgGUID: umDBro+NTf6a89hob7PZLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="268837578"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.118])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 04:04:35 -0700
Date: Wed, 2 Sep 2026 14:04:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <apgCwKB3QA2uKD1e@ashevche-desk.local>
References: <20260902-ad5529r-driver-v11-0-301c491a0719@analog.com>
 <20260902-ad5529r-driver-v11-3-301c491a0719@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-ad5529r-driver-v11-3-301c491a0719@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 11:26:17AM +0200, Janani Sunil wrote:
> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf
> 

No blank line in tag block.

> Signed-off-by: Janani Sunil <janani.sunil@analog.com>


Wait a bit more to settle things down before sending a new version!
This one still contains issues that were noticed in v10.

-- 
With Best Regards,
Andy Shevchenko


