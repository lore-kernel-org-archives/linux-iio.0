Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E986A344036;
	Mon, 28 Sep 2026 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631967; cv=none; b=sHCAaZFd3Rzn7LAgwwLywInn++msJ2HzxYglsj05yekRU33zNPcabpUy3pb+AFrEoCrxwRw3IUNxrGNe+oE81xxmpxKYb0M1qUqqG9G9HyyS82xCXd2ocLBDYvLrO11sYaPvmqVLigNsnV9PY4vWGJwqUT+bmwzAeVA+enXGNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631967; c=relaxed/simple;
	bh=iq1jtUh9AKIA1obvKqeYhJxw1JmAn6ltKhBnhtN+Z7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtGtNiQl8N/R0IvbOoKncjH00NyvxeLlIe9pusumqaMqb6zUxCinvbZ572DVlDas+1X6oJLn5pfw6KpqITO16LvuDGX5yoBKJGfeAT5nfMgo4U+ED32KqFh06us0bzTB1niCDden/fIt1LLuRO92mQWiCf1/zc7goObiDFkuXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwiQL+po; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwiQL+po"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790631964; x=1822167964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iq1jtUh9AKIA1obvKqeYhJxw1JmAn6ltKhBnhtN+Z7Q=;
  b=ZwiQL+poc/bJInbFaKK0iPLFYQxunnLgVouuB6eXfLgPXd8PJlIDzyO2
   g2QchPUtkhrzcSU2I2z5BsAyvXTTKNA+9yPjpWv74Cn9H7cgGG5TuzoA+
   zV+7JOuPZdSJoKe/1kHc1lUgbgwq42XSVgJ4gRPToT0BjlMfg9Z6hqbo8
   3+xMdW8Trw4rBj3xHEdNqJQ87t9p8kFAs6N8I+fMejX9YXdJmbax7AfyY
   z2GBn/hkaozgHNPD6sPSmDsDKY/k9128vnwnjUP/s37vXJo8NJE0sMKKB
   LmywNX/BOv9f9B7PFHvkF0goBnJJ9Y72kL57osMTJ4VgDNBfpGJF6usyW
   w==;
X-CSE-ConnectionGUID: tgMhKCI3QBefls/nnRKv7g==
X-CSE-MsgGUID: Bj2VsiBATyC+50ni2Eh10Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101866253"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101866253"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:45:58 -0700
X-CSE-ConnectionGUID: bWhTW8d9TMu71IgU7qFt3w==
X-CSE-MsgGUID: 5KMtuM5nRKilhPJ9hJmU+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273788386"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:45:55 -0700
Date: Tue, 29 Sep 2026 00:45:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Siratul Islam <email@sirat.me>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] iio: humidity: am2315: fix negative temperature decoding
Message-ID: <arrgEPs779q9ck8q@ashevche-desk.local>
References: <20260928142450.103799-1-vidhu.linux@gmail.com>
 <CAHp75VcW3ADQdf68Whmo7yhqu9rdi54YVYgyh5PRLPccH6aUBg@mail.gmail.com>
 <CAFqz8LL0bgOu3TKfxz0Ri=qw09wVHC68CbVS2yZZjv7oKTGwVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqz8LL0bgOu3TKfxz0Ri=qw09wVHC68CbVS2yZZjv7oKTGwVw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 02:37:41AM +0530, Vidhu Sarwal wrote:
> On Mon, Sep 28, 2026 at 9:01 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> > Can you use sign_extend32()?

> I checked whether sign_extend32() can be used here, but I don't
> think itcan be applied since as per datasheet [1], The temperature value
> is sign-magnitude such that bit 15 is the sign and bits 14 to 0
> contain the magnitude. For eg., 0x8065 represents -101.
> sign_extend32(temp_raw, 15) would instead interpret 0x8065 as a
> two's-complement value, giving us -32667.
> 
> So I think the sign bit needs to be decoded explicitly by masking
> bit 15 and negating the magnitude when set.

Oh, okay, we (IIO community) already discussed the possibility to have a helper
like sign_extend32() for this type of cases, but it appears not so worth it,
IIRC.

> [1] https://cdn-shop.adafruit.com/datasheets/AM2315.pdf

-- 
With Best Regards,
Andy Shevchenko


