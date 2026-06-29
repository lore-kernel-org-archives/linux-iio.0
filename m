Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866903672B1;
	Mon, 29 Jun 2026 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741452; cv=none; b=EdeeMsw5Hv9m84ssL0WU4hkrxvu1eVza1mb5Tjpzu4VRh/Nrh6H8zh//swf0XkfVjoLG7j7b4IPSjMuLGfvZg1ngdnVPjGIRfHHKTxJJ3Yfg1twA22dzHYrMpkJ5g8wyDj4y62NhWdAaq2sNIHUYGAIBPP2TBlAaEm9qtLT+R4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741452; c=relaxed/simple;
	bh=fOdW9SM2wWei5y2Bc+75RM70N+G+c12PWI65vZfqgxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoSZGgRc46qxUsnzyLGY5M6Z48s0NHbvF6LNkN2GTeri6EEA2whsGWYTenEKnuZiFVsq2mV6T5n2bJx/Wh08rAIQQZ69ujHth5nxaD4CmjOA6jjs6i9rgY4AUJ/DPM+QnHuG5kfwQfrb31HuIuAKMmJXcDm64xHmfEJR2/vxjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZD6JdOn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZD6JdOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782741452; x=1814277452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fOdW9SM2wWei5y2Bc+75RM70N+G+c12PWI65vZfqgxI=;
  b=fZD6JdOnu23o/UqfPZDSS3ah8pJ1f/vo/SQk2JCY8/2PrRmqHTOnXver
   0Y4jJKwNBX5Bo6/B+wIe/KZYWzLrX/R4buLXCX+3s3zF6BxhlHzagiGn+
   zupiZpQDi473dvKZYt14xQsz+0k+M8kqDmdPZC7MIBWGsqGQeETgBWleL
   JI23k6E0bmP0bzJL3bMZsh1cFlwKM6W2bPIp/GN7Sp0kcz/CQ8yGXq763
   yQzYJd3RUs+X91qLD9GVenpMBzJHhLeToClh47gYySdVlelZgrm7J08Cb
   vQ4BbGpPFKViZsEykpGgbk6OowGIcCzNYpC0mnorBBRk+CP+gQJ0Zvrsd
   w==;
X-CSE-ConnectionGUID: +kvRnactT9WAcLhjw0giHA==
X-CSE-MsgGUID: UntSHUNDSjGFF/oc8E/98w==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83436452"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83436452"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 06:57:31 -0700
X-CSE-ConnectionGUID: 2DRfrGQRR8qZMIteRIMDhQ==
X-CSE-MsgGUID: mrAkRwJ2TMy6w+Y/NUcBeA==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 06:57:28 -0700
Date: Mon, 29 Jun 2026 16:57:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: dac: ad3530r: Refactor setup to table-driven
 register bank approach
Message-ID: <akJ5xoMvLWwNvpVN@ashevche-desk.local>
References: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
 <20260629-iio-ad3532r-support-v3-1-f6e4f4abebbe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-iio-ad3532r-support-v3-1-f6e4f4abebbe@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 04:31:04PM +0800, Kim Seer Paller wrote:
> Replace direct register calls in ad3530r_setup() with per-chip register
> address arrays and bank helpers (ad3530r_set_reg_bank_bits,
> ad3530r_write_reg_banks). Convert sw_ldac_trig_reg from a static
ad3530r_set_reg_bank_bits(),
ad3530r_write_reg_banks().

> Convert sw_ldac_trig_reg from a static
> register address to a function pointer for per-bank LDAC trigger
> register selection. Switch spi_device_id to named initializers.

Split this patch to do one thing per a change.

...

> +static int ad3530r_set_reg_bank_bits(const struct ad3530r_state *st,
> +				     const unsigned int *regs,
> +				     unsigned int num_regs,
> +				     unsigned int mask)
> +{
> +	int ret;
> +
> +	for (unsigned int i = 0; i < num_regs; i++) {
> +		ret = regmap_update_bits(st->regmap, regs[i], mask, mask);

_set_bits()

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


