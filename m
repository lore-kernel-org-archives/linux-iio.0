Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40B35F612;
	Thu, 26 Mar 2026 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515312; cv=none; b=K/zE5VqU1vqpbj3hNePfPqjM1BNAzo+kca4fPUoTR4wD/Ks2bLIKah1nU3F9EQi29G3zjUC2eWcR8M0ZN/caK1d/X3TeZ9/SnT+zvFiX3u90Sp74DZuAVCbPUR8sBS6Km9xVaKZ0n/wdX/v6WD9F0GYlBr59swxbEU3LB8ZZssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515312; c=relaxed/simple;
	bh=gNpB1qalrIQwQr/4R257cfDeB5MWhRyaZPkJ80n2UKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz83NLj1ZS/Ao64A2its6zLTyCyTam14G+g5T4DyCkwty0OQ2Wx/ZhNOEU2mdRmvmpPOWsDwKNH5QZY+ZhSBa8G+6egW+qxna0SQsQWwkx1VxZFnXvKcJr7HQflQw+zcaAowPCEFO4LEszfimYb9J/zDtikh12fFm+iMr1NdKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nq0YrvUC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nq0YrvUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774515311; x=1806051311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gNpB1qalrIQwQr/4R257cfDeB5MWhRyaZPkJ80n2UKg=;
  b=Nq0YrvUCM+P3SUfBMEjX4QCUkcRHDKdOUO6D4s8qfXcZE2isuF7cXpRP
   0+kHXA3asGvATwkeAmIp6c5jYFjG8dyT7Ice8UNQ41ls9VOLngrS8nB4p
   2u/sg0cHWTbrgwovVVpao1On0LogZYa15jVpmuCxckNkKLLoph0u8sZ1r
   dLPIFp0TRvcq+R+YsttwIR5yISxNzw8Tzt1zo2ICAb7g1S4CF1dpmBEHX
   ZXcoVWHzPfiREhVAvvPBO8M7WIYFbRpUMyFybv8HiPwsKBi4mB2XZN5ro
   Ju9hy7aeKhcmPpDpQpjWntu6udLvwgs4eGStYzyod0lOfvXjP3O8Z4hhr
   Q==;
X-CSE-ConnectionGUID: JidGgjtMQu+ltyaCRgeHCA==
X-CSE-MsgGUID: WpGjqwC1R5KKtJS7DGwrtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75588424"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75588424"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:55:11 -0700
X-CSE-ConnectionGUID: UmTPCnzWRRWJELky0r/I0w==
X-CSE-MsgGUID: M6lMwG65RhaMeMw0pZdAPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="229713355"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:55:09 -0700
Date: Thu, 26 Mar 2026 10:55:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads8688: use read_avail for available
 attributes
Message-ID: <acT0avRL4AZxgjg-@ashevche-desk.local>
References: <20260325110942.65337-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325110942.65337-1-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 11:09:42AM +0000, Gabriel Rondon wrote:
> Convert the in_voltage_scale_available and in_voltage_offset_available
> attributes from legacy IIO_DEVICE_ATTR with custom show functions to the

IIO_DEVICE_ATTR()

> IIO framework's read_avail callback. This uses the framework's built-in

.read_avail()

> support for _available attributes, removing the need for manual sysfs
> formatting.
> 
> Precompute the available scale values at probe time since they depend on
> the reference voltage which does not change after initialization.

...

> Changes in v2:
> - Use -BIT() macro instead of -(1 << ...) to avoid potential UB and
>   improve readability (Andy Shevchenko)

Not really (and LKP showed that), I suggested to use GENMASK().

-- 
With Best Regards,
Andy Shevchenko


