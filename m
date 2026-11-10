Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331737;
	b=4S0AR/i1L07QhwFhJt790194Z1DHGkJl7udzwAVqDYK8AW6al/7tLs2vZP8oziKxCeMc
	 KmEarHIupgRdOyVqgX3uKs8VoWoivmz2fU0Uz9Wd817mcs9rdPJvj+F8Ou8jxbEQgeR56
	 wYZe4Lm9G9Ksk8185FTppDr3jd1RcLX3pqh1fW5T542eMtVYbn8dU5XXXsaq8gkCUMUx0
	 0S6Fes/Pv8aCjtCSsw2WQhOh/PoNUvc+8jle4y8VI6qm27BYlgTNypbq6E+h8vzb7bb58
	 kNnY2vCCAQse9Ix2AtOD2nSXnNniL+Q5iNsUhcwMCDmsv32ulTAi9lPCMQDYjr4Hvag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331737;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=v1t6k43bQ2Byw+/wZiY72CgKH2+WAb+CWOG9enjweYQ=;
	b=sBbyVfgy9iQ1p4h8zHAaoch7rDg4JOtOSthe7izi5zD/fCrBSXpm2WtD6rJ3H5WYyKnH
	 Ea/wEzFg2DB/owUTeLeOiwscB2yccwBqJfIPXiEBp8DXAr1GqaV6vMCcPSY7fyOb1eWmJ
	 FOFafpYGeco4zojaVJqUaHxJKP0s1+bguvykyJXV658WZNzenq9zozSYimTMEEV20S2fx
	 61evHc41r8qnL/9W3FyvXchi8qmerBy1qz6k7419W69oBBfO4GEnsCheaBeeFLmcq5CwA
	 53pGaYaQLbVSt5MdIfVjujAJvVgGCqSHG9KMMurQqxs2P/A6NEzjAhdFi7PabKyzaOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LvZkcw+e;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CC606A320;
	Tue, 10 Nov 2026 17:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE2CC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LvZkcw+e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794331736; x=1825867736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vivqdtdU9xup6JlsXUXQl4ZgoCQ1zw2yqZVDybSI0x4=;
  b=LvZkcw+eImgK66dy0cEKAIVXtCl41ytXaz0ONixY5gKfa0CjFxucKvNJ
   kMcG7awrBxFooZXLpjoHvlclKVCbjJxE1SviGyVIBlunUXOrBNAFrMJOn
   yiIuD/L8vzuhOHeDe+Na/fH3ilS15nMGNi66vtz/ZlBCEB0uOP9bcyo7F
   8DwcCofDPEsPgdmQo3QpmhVJp6KCCkg5f9DW59wEZnpScRWGmRgRDtGXU
   KxHfwhs3KrmfY/VDqqexNGI5HJ6xMn+gerVhHsdLv+3ORykBJUbnmXUUG
   4GNEliQJDZ+QwjmGh+9w4V393b9Kv+4/CCfGC82rTonh5Ypkx4FaxqQdd
   Q==;
X-CSE-ConnectionGUID: ji1jYhTFTF2G+gWtxRALYw==
X-CSE-MsgGUID: rAC4RvtwQ92LtjyBpzFfDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3120572"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3120572"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:28:55 -0800
X-CSE-ConnectionGUID: 7UgS1+E/Sz2HQDwj6SutOg==
X-CSE-MsgGUID: 3aWmuVZvTPmqbJ5JKRBLeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8791849"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:28:52 -0800
Date: Tue, 10 Nov 2026 19:28:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nithishvelan M <mnithishvelan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9832: use guard(mutex)
Message-ID: <avNUUuDNEiVOp_-e@ashevche-desk.local>
References: <20261110164711.552-1-mnithishvelan@gmail.com>
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
In-Reply-To: <20261110164711.552-1-mnithishvelan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 04:47:11PM +0000, Nithishvelan M wrote:
> Use guard(mutex) to automatically manage the state lock in
> ad9832_write(). This simplifies error handling by allowing direct
> returns from each switch case and error branch, eliminating the
> manual mutex_unlock() calls and the goto error label.

Patch is okay, below some ideas for further improvements.

...

>  	case AD9832_PINCTRL_EN:
>  		st->ctrl_ss &= ~AD9832_SELSRC;
>  		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);

This is basically FIELD_MODIFY() (and in many similar places in the driver).

...

>  	case AD9832_FREQ_SYM:
>  		if (val == 1 || val == 0) {
>  			st->ctrl_fp &= ~AD9832_FREQ;
>  			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);

Here ternary is unneeded, however might be still okay to have to be consistent
with the above case(s).

...

>  	case AD9832_PHASE_SYM:
> -		if (val > 3) {
> -			ret = -EINVAL;
> -			break;
> -		}
> +		if (val > 3)
> +			return -EINVAL;

In the above and here we might use FIELD_FIT(), but I haven't checked
the actual ranges.

-- 
With Best Regards,
Andy Shevchenko


