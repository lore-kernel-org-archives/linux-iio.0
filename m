Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461279;
	b=AOcIoA3x/yfKL6C+qgcmhI2ZfSukkMX8XtkGX1S4rTBWB+tLiN7ClPaydMLL65k1gBRY
	 nnjEns9fImc3C7jWDDOaYGVr+55b2M+DCRDzaZQ0474mBQ3mQPFKYeZOo4nrEsI6Vi4/J
	 9Cfi9j7Bzl+xkPnNxU0SNP/GH5Y0jnHfKB+O/JimLbRNjW0m24LQLhw3iH2tIbfFdzVBo
	 dHey88O8u2/ruJnbHUvKYuKsf8PC6rbIBtzM2vzPhNTQLNYIBeEhC8xwmBQko7hsROl/C
	 Ls6OngOmKRdTuotpeYZOmM5C8S2kQyv652yAvbZ28vhR6iusemOvwyFL7Oy7z+BP6ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461279;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=s978hanZLVpv0RWXocH12aEKpIm1bxVlYeeOLTZgo3s=;
	b=P/YA9VKyRBST/gVQzGR4f7KDVMI47xFicpDLhFFnXwfWfLEl+i9OcabZkQGO21j+yYEs
	 vvsNxRnXxSiE1TXg6CIgXkRnSbxQVLl11mB5vU8chizxOHCLNxohzm27VhyO/hZ/g+cjf
	 7pu39ikHEefCYb17/FSQaK5Z+DQ2PZoE/KJp7e5D6BEPSIrMdvSm7Dti4VNHk++N2TKIm
	 N6WYkpmryssJXUZGFtVbrzDvqa8W/A5DASZjNNQ5CPppbgHdZHzFm9emFkBTjoNiwR/jK
	 MrDtfDrZ5EqmQKJ4oGZ7OWrJRMAN+3Nyh4xN1TsuLRjih1eGT+wmBl/6xUiNNDJ0sOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j4C1EzC4;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FD606A31A;
	Mon, 23 Nov 2026 19:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 227FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j4C1EzC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795461279; x=1826997279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e+/1NxiLLSGddz3PUhRX/hgFu4BM5p/TKa5GvarfqgA=;
  b=j4C1EzC4M1YWxeV8/Cst97LrXgjhx5+11hl6Lln1UBVQtaing252cYoQ
   Q1kZB/bo2HRkg4UZz3QxvuTZkRnkF2496IfUkzTUFEc6Jad7nK/BFtB+/
   ++s1h6PfQFTZX/Imygkgl16ykauSHEGYKjqTPc6EvrprDFHhVaVsItDyK
   d480nKuggTVaovvh1F077ALsncYOp+Uq4TDjnzlURWuo1TzbDWSBt40d0
   4dCCPHrsHK7Kzb92/0mVMQ3xHHxPhTsvLB+PtG75zw6FHjFYuZz/iwH0O
   OV8LWil6px096qQLzSnkeqyOXusPwubU2t7sub8FvLQDJLvDKDFDwu+Xt
   w==;
X-CSE-ConnectionGUID: 3UOSt32pRmSmDjeik93CHw==
X-CSE-MsgGUID: yIGAf5GMRmOwxNaVg0vobQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4123606"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4123606"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:14:38 -0800
X-CSE-ConnectionGUID: r7iGBVpiTDKe4NiPBnxscw==
X-CSE-MsgGUID: Mq9WxcT0S0CS1hrxEd8tKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="13160534"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:14:36 -0800
Date: Mon, 23 Nov 2026 21:14:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: proximity: hx9023s: fix division by zero in
 set_samp_freq
Message-ID: <awSQmteht_FDRXpp@ashevche-desk.local>
References: <20261123165255.239490-1-kapoorarnav43@gmail.com>
 <20261123165255.239490-2-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261123165255.239490-2-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 10:22:47PM +0530, Arnav Kapoor wrote:
> hx9023s_set_samp_freq() passes val * MEGA + val2 to div_u64(), whose
> divisor is a u32, so the sum is truncated to 32 bits. MEGA is an
> unsigned long, so on 64-bit the product itself does not overflow, but
> the truncation does, and on 32-bit the product already wraps. Either
> way, any value for which val * MEGA + val2 is a multiple of 2^32 gives a
> zero divisor, e.g.
> 
>   echo 67108864 > sampling_frequency
> 
> (67108864 * 10^6 = 15625 * 2^32) triggers a divide error, on both 32-bit
> and 64-bit architectures. Negative values wrap the same way (-67108864
> also gives 0), which the check added by commit a318cfc08537 ("iio:
> proximity: hx9023s: Protect against division by zero in set_samp_freq")
> does not catch, as it only rejects val == 0 && val2 == 0.
> 
> Reject negative values and do the division in 64 bits with div64_u64().

...

> -	if (!val && !val2)
> +	if (val < 0 || val2 < 0 || (!val && !val2))

I think in this case the

	if (val < 0 || val2 < 0 || (val == 0 && val2 == 0))

is slightly better as the consistent style in the same expression is used.

>  		return -EINVAL;

...

> -	period_ms = div_u64(NANO, (val * MEGA + val2));
> +	period_ms = div64_u64(NANO, (u64)val * MEGA + val2);

LOL! Why is this 64-bit division?! Anything more than NANO will give 0, no?
And NANO is 32-bit value.

-- 
With Best Regards,
Andy Shevchenko


