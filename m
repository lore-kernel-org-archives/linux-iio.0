Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AE40E8C1;
	Tue, 16 Jun 2026 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606830; cv=none; b=IrFb4HVfrIe2JD0CAQSOnZEcIbFdlifs+a6Gehh4At735Ne0hjmU4AWe2g++UFEUnyc8GCBy3ZOzNoDS7hbCrYmTwce5E+Ie/zzuo6KjxoxTmxg+/67kAeTCPJQo48kDX0jY2X32HcPRU6JCSwwSKlts+qMfg9VpJkaDHjr2Hqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606830; c=relaxed/simple;
	bh=fQm2nGhwI7XtrRnZn6n7a5+l1TKxFhwaPo4+cckCwtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJCrNbclvqb5FDfIozlEpQrv11ZmGZzewPwEaMtkdEpTD1MnH2Ey8XaAmRbxUlo7vRuX5pwCYEQPBBeomvLojYIsG/S/r3G/PT8ep/wlwyjIPBudV1XXNsu2xJMPjjsEC+a6xRdk7q/RNVMYupiHvd2oIoo4rkmidkHJ24IOVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO0Ihibu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO0Ihibu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781606829; x=1813142829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fQm2nGhwI7XtrRnZn6n7a5+l1TKxFhwaPo4+cckCwtk=;
  b=gO0Ihibu6NGHZZdYYei7heXuicscGfj+1+34EyVppKhExfxVEB4Ua2/t
   3DK1InyjEoRZsezunxVJOTe1YRHBX/q4RCIu6dk8aXC4AI7abDVOnw2s4
   ckD0GT2VmywLR+DCuW4Oqn41SAyTXq/NaA3X7T401+f+EN2xrdnkU6+U6
   qcOLnhWgyN4towdprWxlmJoCTAYHy51IQBjPjfIHFZkJNtfpdv9K7r2B/
   BkMUwX03FjmlGj81Wxg91q64LTKNBYMHZLxJ+ksIDa+ez01yVXF4NFRy0
   kObCCU3Httx8pMbsMjp+z6VOBvC5o7/DcYftOyMFpQ0XlmQ1yjx8ZCFhf
   Q==;
X-CSE-ConnectionGUID: 9lfh8LWdS9C8xWvqZWiabQ==
X-CSE-MsgGUID: d74uuqPyTee+5z7wE7LE9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93749947"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="93749947"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:47:09 -0700
X-CSE-ConnectionGUID: wytDQeg2QEKqmXtolZTukQ==
X-CSE-MsgGUID: RsxrbMx6R16/zrXEIut/9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="249632916"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:47:05 -0700
Date: Tue, 16 Jun 2026 13:47:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 12/12] iio: dac: ad5686: add gain control support
Message-ID: <ajEppnu-AWSbbihS@ashevche-desk.local>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-12-f829fb7e9262@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-ad5686-new-features-v3-12-f829fb7e9262@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 09:21:18AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Most of the supported devices rely on a GAIN pin to control a 2x
> multiplier applied to the output voltage. Other devices, e.g. the
> single-channel ones, provides a gain control through a bit field in
> the control register. Some designs might have the GAIN pin hardwired
> to VDD/VLOGIC or GND, which would have no "gain-gpios" device property,
> being able to set "adi,range-double" if it is hardwired to VDD. The
> vref_mv field is moved down in the struct ad5686_state, so that the
> overall size increase is reduced.

...

> +static void ad5686_init_scale_avail(struct ad5686_state *st)
> +{
> +	int realbits = st->chip_info->channels[0].scan_type.realbits;
> +	s64 tmp = 2ULL * st->vref_mv * NANO >> realbits;

As Nuno noticed in other patch review, this can probably use mul_u64_u32_shr().

> +	st->scale_avail[2] = div_s64_rem(tmp, NANO, &st->scale_avail[3]);
> +	st->scale_avail[0] = div_s64_rem(tmp >> 1, NANO, &st->scale_avail[1]);
> +}

-- 
With Best Regards,
Andy Shevchenko


