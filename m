Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746465;
	b=MgtYZ+TrU24laWvSsQLYGGcaGmI1ix0+UhXs8sUT/aFigZ1LrV0ed+ZeZ7Uo1YfSlT62
	 IB0OegAfcOSuoMlvTa2gtdcND7pMBZ27CE/amb5ri7WcciRxEcXfoZWwgRw3jPFVoAVnw
	 rDOsDRQkq/0VIV0SQvZp7MidGhj737IaWwButGzv0++AjG1SPvsCbWMuIs94NPJ45eGYE
	 QRcFoxwb2oSlMaoCZ92Zg8r0OddyGBF3hiN3au6gx5lbLJuFYN6L6Yqx/2ziZHEqxaVyM
	 edr+fxS77WHF6ifGKvRff1xVVrTTChRnz/3zUojsDGOCkMvFtxiGpFPEnvhTsBppKrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746465;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ryxLfqZ2x3zEOQBJHsQdFgr4b5y+v6O3GMf3NIHFJAg=;
	b=1rk7Qt3kPJhgebaYS0mG+zQvznDQ2dlijDved1Fra6JS8RnlPl6pyI3hE+3H1JBotf/Z
	 7lCn7cxgunud+RDuQkasdxk8oMTQd4a1u27Hm1lmRPSwO0hlXN2EI3rBsHH82t0XpYse+
	 IWRb869bqd+hcOKHWibwagU2Nw9a3J9cahOmIRPKT/dDbu99aw1QTs2TjytSc14H4ICSO
	 ChHUJMwg0DkmAHcUihAs0buACf8A8Im95FCBkAletdNSTDICA35sMDa7wwL3r4FK/oQy5
	 eUCwHHpgVXpwp17up5HQJF+YYVzUjw3C3AVqpEulCOyeKOhH/Es4rZFtuuTS37/cjFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EDawJKzN;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08478606A31A;
	Fri, 23 Oct 2026 09:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08478606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EDawJKzN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792746464; x=1824282464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mZSMbbSHC7P3bGXH792fq383zLv84L1V8vnl08O21d4=;
  b=EDawJKzNhU0UAz1fM9Rpnn4hRu8bU/IHKBg3bAwLVgZP/E6JJsvILjYT
   8LRINAtHq9oU7knmuGNy5ikpHbbPj8qDBL2ETzluaqjeB+r5sm0H5KI6L
   wh99PQ5QkTCM2LFuReK/AKlJ29+lwaQxsGMGDix11rcqYSN4t2M0yp7rv
   MxO+Us7/y29P17yUVk7xdBBmgDaG1ewA+3rMnd/XefMODo1y3WlDOW20b
   vfAK6Mct0rcyL/ppMWMjO5spRQHfQu4xM8QPIE4tsV0g3z0K+BI2x13i1
   3tjp9sZtBHKgHlE5raKn2PJvxdfWBottiDPlVi3ajGvYPpZatVFsZyeha
   A==;
X-CSE-ConnectionGUID: KKoIxESoT+ua+sTEcU2gNg==
X-CSE-MsgGUID: QhRwH/r6TtWt452h79Kz+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1393170"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1393170"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:07:44 -0700
X-CSE-ConnectionGUID: 539xFK+GQdaYZUhYbNUjFA==
X-CSE-MsgGUID: JOY0Zqv6TWKyk/y8bMn7mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3535770"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:07:41 -0700
Date: Fri, 23 Oct 2026 12:07:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 2/3] iio: light: opt4001: refactor driver to prepare to
 support more devices
Message-ID: <atsj2tE357ZvUuCm@ashevche-desk.local>
References: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
 <20261023-opt4041-v1-2-45227f82d05c@axis.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-opt4041-v1-2-45227f82d05c@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 09:48:14AM +0200, Jesper X Nilsson wrote:
> Prepare opt4001 driver to be able to support OPT4041. Extend struct
> opt4001_chip_info with fields channels and device_id because OPT4041 has
> two channels and another device id.

...

> Assisted-by: LLM

Drop this tag.

...

> +static const struct iio_chan_spec opt4001_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.address = OPT4001_LIGHT1_MSB,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)

While at it (and I see it was in the original code), add a trailing comma here.

> +	},
> +};

...

>  	u8 count;
>  	u8 crc;
>  	u8 calc_crc;
> -	u64 lux_raw;
> -	u32 rem;
> +	u32 mantissa;

Try to put it to make more of reversed xmas tree order.

>  	int ret;

...

> +	chip->chip_info = i2c_get_match_data(client);

For now it requires

	if (!chip->chip_info)
		return -ENODATA;

-- 
With Best Regards,
Andy Shevchenko


