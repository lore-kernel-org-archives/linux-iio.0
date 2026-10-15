Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498871D63E4;
	Thu, 15 Oct 2026 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071105; cv=none; b=N9ThNtJh3BZ2tJ0KLvJ1euzjvmKd447az7UJ58IOUGwPHl0GQ2o55eQ4rwbVlj37pTom74tSS66VgrvPgl4QbfHlb1oTggEYEzH8z9q0F7GU6NjfMauqwGIm7Z1FAe2EZ7vMYMsP9HVyLUoLRZO/0+ojl2c2pN7acRt+qIAyFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071105; c=relaxed/simple;
	bh=WciRm7bG5cSSqysZI3bBaHarO2QnG/xez1Atr9R2C+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAHnQfrMhDuzPwEIvJsDHab1aYs9X9td3X3Je5EaLx4XlhWlhAgs7G0PSH+VGpesEbaBZv2nZvg47KslSYwLnS4f/96OTeZsKoUoGLTesj4zO3lx7Q3gIk0YjYMzFSMDld+5eYBtML7/75qE069ltkA+bTwwtr4RGTfJseZKgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+SIr/AM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+SIr/AM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792071105; x=1823607105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WciRm7bG5cSSqysZI3bBaHarO2QnG/xez1Atr9R2C+A=;
  b=A+SIr/AMVU9HG+lnNbwL6nxJrpDNhCZMjICwK7U2q+ovjNzZX453n+85
   RZ4RqL7K+9I1u6aP/i44yyLlMJq2/37HC34NMhCAlLnkbHCSkKFI/rXZb
   hOzqWxOX/xHm4VDQJOBETRK1dLjcpoLq2Oa7rWy3FIOX6OA6N/FpA518X
   /2AsJsviMdqh0luRvfYCldrF23uybfwNYrPX5rbJWbn4HjQ+fPiK49SEU
   SzX9zjOE7AsYiwqCN2pIpIZcdkoptoPCeClWWBX8k+EbjZVtgNkbnPDvG
   IcncQHLLOH53vHy2E3NLyUNaRKtsMY4zg7FAb+0MLJN6bakqwLW3JsEgL
   Q==;
X-CSE-ConnectionGUID: sB6D9lCTS2SebrIhnx/NXg==
X-CSE-MsgGUID: OJHyVZYkSlWWa/xyI2/QOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="835889"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="835889"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 06:31:44 -0700
X-CSE-ConnectionGUID: s534FMPgR9atlNiizCTwgQ==
X-CSE-MsgGUID: m1cQv2e1SNygZeGv+emjuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1578785"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 06:31:40 -0700
Date: Thu, 15 Oct 2026 16:31:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iio: pressure: dps310: add Zilltek ZTS8032 support
Message-ID: <atDVud25tkoN58rF@ashevche-desk.local>
References: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
 <20261015104945.2687162-6-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015104945.2687162-6-paulius.zaleckas@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 01:49:45PM +0300, Paulius Zaleckas wrote:
> The Zilltek ZTS8032 has the DPS310 register map, scale factors and
> compensation, with these differences:
> 
> - two more pressure coefficients, c31 and c40 at 0x22-0x25, adding
>   c40 * Praw_sc^4 + c31 * Traw_sc * Praw_sc^3 to the polynomial
> - TMP_EXT is MEAS_CFG bit 3, and the temperature coefficients are for
>   the internal sensor (COEF_SRCE reads 0x06). TMP_CFG bit 7 is the top
>   bit of a 4-bit TMP_RATE, so the DPS310 TMP_EXT write would select a
>   25/16 Hz background rate instead of the external sensor.
> - product ID 0x11 instead of 0x10, the driver does not check it
> 
> Add its chip data, reading 22 coefficient bytes and leaving TMP_CFG at
> 0, a Horner step for each of c40 and c31, and the I2C and OF IDs.
> 
> Tested on a ZTS8032 over I2C: in_pressure_input is within 1 Pa of the
> datasheet formula evaluated from the raw and coefficient registers at
> every oversampling rate from 1 to 128, and TMP_CFG reads 0x00 after
> probe.

...

>  #define DPS310_COEF_LEN		18
> -#define DPS310_MAX_COEF_LEN	18
> +#define ZTS8032_COEF_LEN	22
> +#define DPS310_MAX_COEF_LEN	22

I probably was unclear. What I meant is the agnostic name for that.

After the first patch:

#define DPS310_COEF_LEN		18

#define MAX_COEF_LEN		18

After this one

#define DPS310_COEF_LEN		18
#define ZTS8032_COEF_LEN	22

#define MAX_COEF_LEN		22

...

Everything else looks good to me.

-- 
With Best Regards,
Andy Shevchenko


