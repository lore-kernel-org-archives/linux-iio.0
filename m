Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B66342C8B;
	Tue, 27 Jan 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510556; cv=none; b=BSE5Uy/LrVEXvfK45nMJFaeuXlHjh8A0XpS+SZ4CrtRsRx3qE9VkyPVEmHrLia4fQnCsy8sTpgHIIvc/gRj21cwVUFGyDidr703GGH91/T6WcosKqQIZ/2RDL0gY/pASGnHOqaeSb5UCzQ2EaYjfbvH3tzHHbc0mJtrNSUlm0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510556; c=relaxed/simple;
	bh=geF5sj/jmwdPWTxyB3iA1a2JfJu4BPJEE1G2d4A9lHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRgl29BP/3D7EGCxiyWEzkjajZe3hwTXESxCVolYrWq3yYVxoEL34fJlwS0xXC6TTnMHvUig624eQH8Rk7DXoNB7d6Qpe4ll8cZSGxHBwg5p7wHP2A7mEfzkrxx8n4aRJsQ5j/BzT4aaS+48gYIXSpiyhnVwiTl6J+XX8+PNafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/jfU2uz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/jfU2uz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769510554; x=1801046554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=geF5sj/jmwdPWTxyB3iA1a2JfJu4BPJEE1G2d4A9lHk=;
  b=F/jfU2uzPeliUumg/v5cvqcJ8LdbFp7oCGi9bTh6bHxsJRzjzhgZW9nL
   qyiAcCk02simYgUxDqukchVuVUFac6+9tA6UFJXZlmcNx+p+9vNb6KPtL
   ncPjA0FHH3n1S6bgrQHYIiiqarTiP1yjFvm6xrGaqMICejQDo1k5uL/FG
   nLLgy/SSpeNhPOD/z6Fu9FyWgnDvI+RTMshhE6i9FXkDlGT9P/xlJkw21
   hp9fboibowNsGMvdSgiHrj5k4yGQX+lWB3HQ+rLXE6Rz1tbVYO0pzOv9n
   HD6OnDVyEotcHS1munlvTuf5Yv92OivjCguZNozazygGTJRXFp9y8CBTG
   Q==;
X-CSE-ConnectionGUID: 3fkg44pbSaCCXbbyh7IPmA==
X-CSE-MsgGUID: 20TewNRKR7qkbB7s9ctDcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="74325558"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="74325558"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:42:31 -0800
X-CSE-ConnectionGUID: pqlJ3fqBTeCsCl+BiiaO5w==
X-CSE-MsgGUID: ct7ZOaZuQmG0IivPMXplNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="212056489"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:42:26 -0800
Date: Tue, 27 Jan 2026 12:42:24 +0200
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
Subject: Re: [PATCH v2 6/8] iio: dac: ds4424: fix -128 rejection and refactor
 raw access
Message-ID: <aXiWkF04r7FkLPRx@smile.fi.intel.com>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127060939.3914006-7-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 07:09:37AM +0100, Oleksij Rempel wrote:
> The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented.
> Previously, passing -128 resulted in a truncated value that programmed 0mA.
> 
> Fix this by validating the input against the 7-bit magnitude limit.
> Additionally, refactor the raw access logic to use symmetrical bitwise
> operations, replacing the union structure.

> Fixes: d632a2bd8ffc ("iio: dac: ds4422/ds4424 dac driver")

Usually fixes go first in the series...

...

> +#define DS4424_DAC_MASK			GENMASK(6, 0)
> +#define DS4424_DAC_SOURCE		BIT(7)

+ bits.h ?

...

>  	case IIO_CHAN_INFO_RAW:
> -		if (val < S8_MIN || val > S8_MAX)
> +		abs_val = abs(val);

> +

Redundant blank line.

> +		if (abs_val > DS4424_DAC_MASK)
>  			return -EINVAL;

...

> +		/*
> +		 * Currents exiting the IC (Source) are positive.
> +		 * Canonicalize 0 to sink; datasheet treats sign as don't-care.
> +		 */
> +		if (val > 0)
> +			abs_val |= DS4424_DAC_SOURCE;

Hmm... Maybe 0 should be excluded as invalid?

-- 
With Best Regards,
Andy Shevchenko


