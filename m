Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177458;
	b=Rk/OZXY5afFKhC3Pko7n/JrHnM6UIy9lHtViIZsvh0r+YnEHGXpHJmCPj9w3IefJh3uT
	 LAX68vnGEhyL6DhUy3KTsPtRJ6N+ZdqQ4PHrNMlG2A+qhn1kHW3Kh8LiDMgPkLf2EEjiX
	 Gi3+VRhJUiSVR9Qng7n4+0AIYYEFDPmwtOHAcXPMZJeKuQIDylM6V5XKFpzi2icfwF2Y2
	 hxPRNhU7D0f9A9puoCl/E5czuNBDAYcwtqEzQdlv78m3b5mvcj1OEIORoyC4s/mS39A7w
	 8XdCqkOLKjbg6g8tCBPMSDJSR+Xz+2CZKvAQBYbwmpC+ohyNmLSTarxG0qL2hllFejQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177458;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=iArxjah8BFnZACzLodgJSchhceFdvxYdpa8zA0U+KLw=;
	b=UdC7OR0Y+Hicj7khDfNo7ViqdDnaQKWE/QjujPQT+vyopM60P4CV+NzCKTPDvLzZKWV8
	 OLW/43mHKxq8E/uJZrMPCxDpIPGA/3OTmFp3tl+vILbqcP1giZhZ7zTh4d7LekOx3JYIw
	 PGO/qVxRRzJ2UGvByscaxcgN44DP6qQ6zhqelQ75bKdamWV6z8/ph5qn9EOaxM2qv0DMr
	 hrSjTE+N2iSPOP/IkYoQWQuvSM643D3/+aLBx/aLsOg+d751T1lRmYAWn3xzQLMXhRBN6
	 El0B5XELqzRB4XMqykBk22GlGRL8rKDTZoEniokaREGJZev9PH521AaiA42RRsePJEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SnBGl+CD;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A76606A325;
	Fri, 20 Nov 2026 12:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53A76606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SnBGl+CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795177457; x=1826713457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lo4oVRvFHhJNmM0EEDjnu0jX17cKFv3RNlnMBHfalcI=;
  b=SnBGl+CDWgKIDv0syLrBM36Z4R22eje+LN64qXCHn6jYqNI4FNBr+B5k
   71qYcYR6eaZcjJFjKc3Aa2SzwfbrhgReFrzFb5miUybz1hG7tOYKAC0xV
   KDaTWruJyZ1fqllHLGTXsXF/nWJV4z/JmRXIgv0VxG2i+kqvyog+KYyVa
   ihmCJB7VjyUIqeNRtudjpEU4OAjt0YH2xKH/Z0Ai92jRrSAFRK1z0vBam
   HmSOKfBSLugfq78sltmO1fv5w0eTFZVXWOFxmzxFUCiAoK3jETYFdAXsd
   drferzBigmJ+BxqmtiK5+e+2l48ArGAdMia/+17ezpNmapDGbqsXFvdL/
   Q==;
X-CSE-ConnectionGUID: pJZSktksS+uMFudLRS2i9A==
X-CSE-MsgGUID: ZTAo2lJKRRmK7XXdtGvrJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4085900"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4085900"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:24:17 -0800
X-CSE-ConnectionGUID: d1BVu9q0SBOQizr0crftUA==
X-CSE-MsgGUID: PArVB72lR1KRB6yyaxpAgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="11027029"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:24:14 -0800
Date: Fri, 20 Nov 2026 14:24:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: ilyas.nhasse@skf.com
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad_sigma_delta: support devices without
 RDY interrupt
Message-ID: <awA769JyWRvSG8PY@ashevche-desk.local>
References: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
 <20261120-ad7124-no-irq-v1-2-7826c5c3fd25@skf.com>
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
In-Reply-To: <20261120-ad7124-no-irq-v1-2-7826c5c3fd25@skf.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 12:26:48PM +0100, ILYAS NHASSE via B4 Relay wrote:
> 
> The end of a conversion or of a calibration is detected with the DOUT/RDY
> interrupt, so a device whose DOUT/RDY pin is only wired to the SPI MISO
> line can't be used, although its status register reports the same event
> in its RDY bit.
> 
> For devices with registers but without interrupt, wait for RDY in
> ad_sigma_delta_single_conversion() and ad_sd_calibrate() by polling the
> status register, with the same timeouts as the interrupt-driven waits.
> As with the interrupt, the bus stays locked and CS asserted during the
> wait, and ad_sigma_delta_clear_pending_event() has drained any older
> result beforehand, so the RDY bit seen by the poll belongs to the
> operation just started. A timeout is reported as -ETIMEDOUT.
> 
> The RDY interrupt is the only trigger source of the triggered buffer, so
> devm_ad_sd_setup_buffer_and_trigger() sets nothing up for these devices
> and they only support direct mode. Registerless devices still require
> the interrupt.
> 
> Each poll is a SPI transfer, so poll every 20 ms: this delays the
> detection of the end of a conversion by at most one period, a fifth of
> a conversion at the AD7124 default output data rate of 10 SPS, while
> keeping the bus traffic, and the CPU time of PIO SPI transfers, low.

...

> +#define AD_SD_POLL_PERIOD_US	(20 * USEC_PER_MSEC)

The multiplier is defined beneath time.h. Is it included?

...

> +static int ad_sd_poll_rdy(struct ad_sigma_delta *sigma_delta,
> +			  unsigned int timeout_us)
> +{
> +	unsigned int status;
> +	int ret, ret_read;

ret_read --> err
It's visible in the code what it's for.

> +	ret = read_poll_timeout(ad_sd_read_reg, ret_read,
> +				ret_read || !(status & AD_SD_REG_STATUS_RDY),
> +				AD_SD_POLL_PERIOD_US, timeout_us, false,
> +				sigma_delta, AD_SD_REG_STATUS, 1, &status);

With that, wrap on a logical boundary.

	ret = read_poll_timeout(ad_sd_read_reg,
				err, err || !(status & AD_SD_REG_STATUS_RDY),
				AD_SD_POLL_PERIOD_US, timeout_us, false,
				sigma_delta, AD_SD_REG_STATUS, 1, &status);

> +	if (ret)
> +		return ret;
> +
> +	return ret_read;
> +}

-- 
With Best Regards,
Andy Shevchenko


