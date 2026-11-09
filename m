Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266271;
	b=HBqFv469ITJhOO75OYlZTpsFFM1qtsGtGqQPMXpRktzaqKEh5quS4SpgDHlE2bIULO3o
	 alzT3Xfl7fFMKl8LRN+TZMiyzIuZqnlsljVgM3/hqwlxoL8Uou0RL/f12phS1Pmg0FvBp
	 brvRd+8Yi2GrvErgOMMdlfZU4hZSKGXtapGYI/eq7wyfnQZlO4OxPKwFe0K2S63dtggOD
	 NpYcmZ0d3F01+HnZkV1CZ/vml60lBkFo3Bcb3eeYllHv+SgDms3s6DUZZKCocuGpzGkAW
	 UTygoFkfxSiZc1LYEeAjjVpMseglVYigRs0p/hyQE1UcyPZiLNOSKRMrJ8mO5r1zARg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266271;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=NkJ7nhCGtP2bfpy6xch73us18gWd5z+wC6NK90PAwJQ=;
	b=YIU7ECR+T+4HTd4YglzJnw2ryFMMgBrHZuRLjrEUpeLwpof3JJoT0C3UjhBCrNqMIbc6
	 PwAJCWfWBjB1YxdMxr/fl54LoBc35gbajYQEC7/SRgGj7zhgxABNRiCASeEjnT/nZlbys
	 FE6caVF97wUm0vFlLQG61d/+CigPla9DJlh8xJZ2deMI+BzSOSkd/UsMGey+4VUCXlGy4
	 U4z7Zl43ML584a7bEDQMrd0qocWz0Ly1WAoWQ9hEIf3GC/cpy8EOUp/HFX++CHQXyyWF3
	 wgsH/n+rEzw5orIaMs1V/R3VPtlfZeZZBGHDl/nnHHZZraPJ1jpBwiDY58FAF4fT5Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WA5GcYLs;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02909606A31C;
	Mon,  9 Nov 2026 23:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02909606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WA5GcYLs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794266269; x=1825802269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IYixSMqXWUtQF0nP2orfxiYyJRP1Caa+KvH552fQ4zw=;
  b=WA5GcYLsGYoPjKZz9ycl9/6fhgrpQg1ypTYP72D6qjoMgu4RTOvniRGi
   b2oH5rIDkttyjJGAt9Ezjmj31IR/H2Qc7+7yyMQayEJEfzZT1B+EI06ei
   NxrKPgDDLzRdWdwaq6SvRxHNR+LHH8MDGcnOM0DFR3hAY36YTsOZiIEQL
   jh8crt69DksPfPm4z5Jq47OkDnb1yDgbEY1RVn8rmnI6W/aD4ApoQ39TS
   YqGg2IISWOrMJ9F6AampNGk7otJQ3h5fGpqDotnO43OnIKVCUyjK31I8M
   5UPHAGjWgqPMnZTwhPxP8DgfFawQoNhZvzAKr0O/pepuKVfismRNuM3/J
   Q==;
X-CSE-ConnectionGUID: VOO9X9FxTPq2EHXVq6kYWw==
X-CSE-MsgGUID: qQCo0t+gTfe94c8wW44xaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2998899"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2998899"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:17:49 -0800
X-CSE-ConnectionGUID: P8vMSRmUSR+Tmy5ZSNRGNQ==
X-CSE-MsgGUID: P/Qvs8lBSa2nsewI9/JduQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8426841"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:17:46 -0800
Date: Tue, 10 Nov 2026 01:17:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: light: gp2ap020a00f: Add GP2AP030A00F support
Message-ID: <avJUl-vxNWr2RNKe@ashevche-desk.local>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
 <20261108-gp2ap030-v2-5-24eaa1b9fe59@kernel.org>
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
In-Reply-To: <20261108-gp2ap030-v2-5-24eaa1b9fe59@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 08, 2026 at 10:44:03PM +0100, Linus Walleij wrote:
> The GP2AP030A00F has the same register addresses and interrupt modes
> as the GP2AP020A00F, but does not implement its automatic
> illuminance calculation or selectable ambient-light cancellation.

...

>  config GP2AP020A00F
> -	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
> +	tristate "Sharp GP2AP020A00F and similar Proximity/ALS sensors"

Also make sure the text in MODULE_DESCRIPTION() and perhaps top comment in the
code matches the above (ideally be the same).

>  	depends on I2C
>  	select REGMAP_I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	select IRQ_WORK
>  	help
> -	  Say Y here if you have a Sharp GP2AP020A00F proximity/ALS combo-chip
> -	  hooked to an I2C bus.
> +	  Say Y here to enable support for the Sharp GP2AP020A00F and similar
> +	  proximity/ALS combo-chips hooked to an I2C bus.

Here we actually want more precise list of supported part numbers.

...

/* ...a comment to explain the delay... */

> +	if (!data->chip_info->has_als_auto)
> +		fsleep(1000);

1 * USEC_PER_MSEC

...

> +	{ .name = "gp2ap030a00f",
> +	  .driver_data = (kernel_ulong_t)&gp2ap030a00f_chip_info },

Same comment about the chosen style.

-- 
With Best Regards,
Andy Shevchenko


