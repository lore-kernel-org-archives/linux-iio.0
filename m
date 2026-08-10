Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8349620;
	Mon, 10 Aug 2026 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347465; cv=none; b=N9uHe7tWjxsIdkcxEWdvVZEC+IR9VX283YAm4gLUaGnq1NiRxx83EApaoOv0XPYwobEn3FqrwxBJt63LGRt9aTLUYpvetO6caFSQSETY/UWUVtjgKP9WTQZXi2Bly0CXXq72840jQbpzRbnXU2rS6y5Lt+k336MqWwkRUPjEDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347465; c=relaxed/simple;
	bh=TgQQzWCJY/JrfSUkJZttCW7uCDWksy2HvntTzshU1uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2is3LVaLLEfm7QaHI4PS/T5VZYyVgBAT3bNc/RVrhysbuvumVAnHduB6FaFr1ZD3ym+qyItnYYZPia7Ub2tluDFMhNvpSd/5OmjGiUq6JhrzylLXie5LhBpMaz4ZwIwnq4fyBay5Ifa6/tOrBeiJjbvOPuo8NdD841o+LFlB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU6tjC+9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU6tjC+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786347464; x=1817883464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TgQQzWCJY/JrfSUkJZttCW7uCDWksy2HvntTzshU1uQ=;
  b=PU6tjC+9FjdZk46f9jUctLUJwJMEXgfYBztiYIcIKuZgtG8f5jGgRALn
   BKeu1Ju5e578YS/7IjElI98sqfL3AiX0oF9lB6KTTFq6bYZOQLoHPUQ4/
   KFbW14P7ymMjLWnwv+ZuwTAuP+VosLM+vX9MoQCrcKzP1nvJ291A33WGI
   pq7b/IABE0ZXAK91Zh60H+Mnqpwv2OCIZxmxlYvKkrPGZ6iq+8nfcuhwt
   nW+6GxVOnKZbsZP4DyV8aqEOODOCcEpaGbgKDDrkz5NB5iRQkLwRt4Phq
   wKsSfsCH4jgb8cmZiOJZwdgW9RfbuDYC1xtiZlFQ+7WtbAxeIvU4GjpEF
   A==;
X-CSE-ConnectionGUID: U+y1RxEsQ4OM16KsmuBSAA==
X-CSE-MsgGUID: 1mcFdv4MTOKxwhoZCNuppQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="90532105"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="90532105"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 00:37:42 -0700
X-CSE-ConnectionGUID: AFE0Rqc9SB24tkx4bn4xhQ==
X-CSE-MsgGUID: WdxuH6KFQlGpo/Iy5X4jqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="266453289"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 00:37:38 -0700
Date: Mon, 10 Aug 2026 10:37:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, julianbraha@gmail.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v9 5/6] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <anl_v428aTL6waBK@ashevche-desk.local>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
 <39f2ff86cf736ff97286d6451fcc45fdba6732f9.1785186980.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f2ff86cf736ff97286d6451fcc45fdba6732f9.1785186980.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 27, 2026 at 06:31:58PM -0300, Marcelo Schmitt wrote:
> LTC2338-18 is similar to LTC2378-18, differentiating from the already
> supported part mainly on the embedment of an internal voltage reference and
> addition of a resistor divider network connected to the input signal path.
> Extend the device driver, handling the internal reference and input signal
> attenuation, enabling it to also support LTC2338-18.

...

> +static int ltc2378_refin_setup(struct device *dev, struct ltc2378_state *st)
> +{
> +	int ret;
> +
> +	/*
> +	 * The internal reference buffer amplifies both the internal reference
> +	 * and REFIN by a factor of 2.
> +	 */
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> +	if (ret == -ENODEV) { /* refin is optional */
> +		st->ref_uV = st->info->internal_ref_uV * 2;
> +		return 0;
> +	}
> +
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> +
> +	st->ref_uV = ret * 2;
> +
> +	return 0;

I'm not sure about others' preferences, but I would do it as if-else-if and
remove dup return 0.

	if (ret == -ENODEV) /* refin is optional */
		st->ref_uV = st->info->internal_ref_uV * 2;
	else if (ret < 0)
		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
	else
		st->ref_uV = ret * 2;

	return 0;

It also makes code shorter (in amount of LoC).

> +}

-- 
With Best Regards,
Andy Shevchenko


