Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460051;
	b=mhUq7bLPEnS9uqp+peH9r1DcBh2odWy/V3GCCd4XNeOJAsLdgLrkDA/rrC03f6o1Vxi9
	 J4p6UKGonapeTipAPY0IvJBOfMKA0t/fAdbRz5D/74oRdIO5L4gjAzwaxf9yxpV/so3Qg
	 9ZDC9/lGEQjEZAfrlf65/zyWNC1013qH5JxseVcoAK6CuKJWuWIAJpnKG+WHD5/qIb10L
	 FcMj0y7QBcP5qbMKy6/wCJ4yyC5rJD/4C6CrrcMEi+ubD6TGYrdwIgGqzOFcaTA66MY4t
	 UbiyH1Bdt+R93HorclIYS3IQJv4zlVI6LSqXLjNIoO9KL2eJMqlEP+20BNipS1T+uig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460051;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=n8eQg2VWTFkHRh6nWKvn0g7mBpUZuTIVj5vM3Ba8/NA=;
	b=fJnaAmVeXY8P4MVFhgoiFlrAaPlFhmeiBRssm86gpBu8+kTPcEX49AdM8QAq6GwRR0Qp
	 QpNCkOq//EHhdqUyRjBK6CE/ByMGHpPnc8aBK8ROa1fyOM4NmB9X2JbQV1b9bIgLVPedZ
	 dG8Pomn0FsbhnZ0EKR8+FU0XIb225Hq5TNfNtcfOoZD0KYEgCz2XwvZ6yAsyU0NxF3BH1
	 MaVJ8uA+KdesT4w1S7Qs8nBNk1XK3jPf5AFmWTAPmyBwrbfcm18cvi21qTajFUsBPV0Lh
	 24tNes7fOE/V3spT6JmCAI3fMjqcpUkQqw6PxsCgn9eJRKNH+vx3JK9f0qeCYSkqUlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l4QQaynp;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B0606A327;
	Mon, 23 Nov 2026 18:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 961B0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l4QQaynp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795460051; x=1826996051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AqLoSY+uMHaQijDdZjXL3V2+Q61y+Y4AyaStKFNQjIQ=;
  b=l4QQaynpElxci8Q/JnGLIJN4bWIecfB0w7xfgyfqtBPI0JXitBEHFxUx
   zTWT6cNA6AHwhnrhYp1CNA94O0V/RK4XSM+2qdQ7sXtwOfQ0akpV95/yT
   uGWyIAakBPu0Q5YzmySH53D2XuckGTmeJstOrfua8Ya2inuMQcWh0F2ep
   PMHS2j4SFiUzIMhuUyFjN1tE3+YlqX2UEQIpxw4ZhW+tWZ7L52442XgrK
   UGMjGC1KmcDK20GeUPBJ76T4cYYdz5kJZs6NLXkAaCkmTIakviqsiHXQv
   pka9sJ9TmPq/fF6ntnfvz07/xODfE2tIosodyQ8Rv8ke2/kgV/SsfSwvN
   g==;
X-CSE-ConnectionGUID: ExtZO2x1QKCj2fKKJb5GzQ==
X-CSE-MsgGUID: KcpXUpboRkeY+w2Ly0sj7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4257310"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4257310"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:54:10 -0800
X-CSE-ConnectionGUID: XKzp2d0yTnKmegeO65Prmg==
X-CSE-MsgGUID: 5cslLiyvRKm5/g9Euq76bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11576350"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:54:06 -0800
Date: Mon, 23 Nov 2026 20:54:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v3 2/4] mfd: max8907: Add ADC client support
Message-ID: <awSLzG6IxXjKLBCx@ashevche-desk.local>
References: <20261123150725.212836-1-clamor95@gmail.com>
 <20261123150725.212836-3-clamor95@gmail.com>
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
In-Reply-To: <20261123150725.212836-3-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 05:07:23PM +0200, Svyatoslav Ryhel wrote:
> The Maxim MAX8907 has an 8-channel ADC at a fixed location. Add client
> support for it along with its regmap and interrupts.

...

> +static const struct regmap_irq max8907_adc_irqs[] = {
> +	{ .reg_offset = 0, .mask = BIT(0), },
> +	{ .reg_offset = 0, .mask = BIT(1), },

When {} on the same line, the inner trailing comma is not needed (if we ever
need to extend this we would need to change a line anyway, so there is no
benefit of having a trailing comma).

If it's just this, no need to resend. Just a hint for the future.

> +};

-- 
With Best Regards,
Andy Shevchenko


