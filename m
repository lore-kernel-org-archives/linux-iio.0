Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605561;
	b=5qcUBh8ipsQEGjNyMzk7XbX+RYIzEd2N9CNRJIav5wxZYB4MFG6vmNdsWIvjs9Wn7EDh
	 ajRTc2jY8r6nkICnV+Ch7uv7I238f8RgAxmZqOrARK+740mR9HM/bjjHJL4uvqp0CEA5l
	 rZaFKqlhMRBDUKLqkP5yxOgploG/X4NRFnQBYBa7iSguuAJ6S2NEvXsBmiHJFC5I1V5Gr
	 3NnUSYFwEr2xjErrEJ8xQqfEdiiatSDduFcj0MhaL8WwfLbLT8ICM9jSDOj4BCYHOJGI2
	 ynoVegePiRb6ck9ouQXvBKFLE2cvQywL3WUYT1btJs5ALE6TYKaC9C34sQMnmfjcJqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605561;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=zuwArTIXOeerY6ZEsKaeabgGF34VA3gXqMaQydU/3xg=;
	b=M0mkG/qCujy8n+G2kagOg/sqGsJgat3LMMXsyGfd5wtDiKC9t+2Ywucw8VD/rUtjP8iV
	 TfqTf3XvpUoluH0o6TFqEK+ZB0v37BjNZ35yc/nObuXBHyBhA3vmt0L2ms8TWEkNZhFVN
	 Q1IqE6hMtTJRLX3Q1+MITZ7PfwZGeZl7wlithMZTK1erDIpivVAoI680j1opfSq9WX58Q
	 XduWSRsNGmPHeSfNEND+uxEPhhuVC6ayD+IgpZr4jJ8gusx7XXcLaGn0KWbqFT7SXlRa8
	 tuDk17Ge6wg3w4aaOQltRMafcGGMD9Za7W518B2JcYAAMoC0Yq2Av/zBxVhQlOBl94g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gmYrjQY7;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6E606A31E;
	Wed, 25 Nov 2026 11:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA6E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gmYrjQY7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795605560; x=1827141560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V8g/GOZVVfOotdBnNwGUmBWfGRAM3Wnv7Uxvic56ZSs=;
  b=gmYrjQY78M8Fvg1hjKD6TAAXVGwgKeIUZBm/2CCCocCgFfgudKOe5tmt
   YLC7nJcsIzdhPIBlo7OcghnNy+/4HwLny/JESrvf/Kt4bUODpTyUWrBuZ
   BsoDT7CV1My4pkibsXRNIT+96DYLvN+30dlwHE1JOKj8yQgg+YZFYCNbr
   3tv31Fm4VIcUWmZ3X2VmLoqudyHqSuONns/iUlDOReC5xwXQYcUuWHtUk
   Jz2hD+kb4SvPAcn582vkQfzECXDUsj2LF5VzoorNudNv/aMOjsiOWWIO6
   scVljsK+CoM5qFpTOXBugnlf4N6tVLlZSHQ1VYAAIKH1e/qrbkUrHA1vb
   w==;
X-CSE-ConnectionGUID: YnXe5cPLSe6+0eQfRGr96w==
X-CSE-MsgGUID: UqcxgmsmQKSRd9qtAJgskA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4397075"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4397075"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:38:43 -0800
X-CSE-ConnectionGUID: SVSECUOjQDGk+7f+44+6Gw==
X-CSE-MsgGUID: qM9l6YSTTjyIcAd72af3hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11730544"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:38:40 -0800
Date: Wed, 25 Nov 2026 12:38:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@analog.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/6] iio: adc: ad7266: drop platform data support
Message-ID: <awa6rrFP3-dCpIC6@ashevche-desk.local>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-3-54e4c8830b57@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-3-54e4c8830b57@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 10:19:19AM +0000, Nuno Sá wrote:
> There are no in-tree users of struct ad7266_platform_data. Without it,
> the driver already falls back to a fixed address, differential mode
> and the 0V - VREF input range.
> 
> Drop the platform data header and move the range and mode enums into
> the driver. The code for the address GPIOs, the pseudo differential and
> single-ended modes and the 0V - 2VREF range is kept so it can be
> enabled again should someone need it and add firmware properties for
> it.

...

> +	/*
> +	 * The address GPIOs, the other sample modes and the 0V - 2VREF range
> +	 * could only be selected through platform data, which had no users.
> +	 * Keep the support around in case someone needs it and adds firmware
> +	 * properties for it.
> +	 */

Same comment about the comment.

...

> +	if (!st->fixed_addr) {
> +		for (i = 0; i < ARRAY_SIZE(st->gpios); ++i) {
> +			st->gpios[i] = devm_gpiod_get(&spi->dev,
>  						      ad7266_gpio_labels[i],
>  						      GPIOD_OUT_LOW);
> +			if (IS_ERR(st->gpios[i]))
> +				return PTR_ERR(st->gpios[i]);
>  		}

Side note: Have you considered switching to GPIO array APIs?

-- 
With Best Regards,
Andy Shevchenko


