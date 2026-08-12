Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FD2434407;
	Wed, 12 Aug 2026 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535651; cv=none; b=h6MJSIbtPMbP+jJdo18fZ2jzCbtu+GtJ8lvxYTXX1BhaOFOidES5OxEIhHSd/57r0TaXGTDv0O07ems4mHWao/VcV2LzukluBTrG0KyDQfTN6oYHnly4aHPv3hcJCIyaQ8/Y2Bl4SUXu9qZL7DIsvQC1t6nP+6uBpVQyljRxj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535651; c=relaxed/simple;
	bh=VnlXWytHJvaHaIglKqHXsYUWpml+jz+Y91ZBqxPajpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9FJAtaS2hKkLYvS6eRrQOepse09MKeQFP/FIu0LHy3qWrqDKY5wQTyB8Vx4AQmIlFyZvZWSYadpw+TjsMd4oiqlAKcrS8S/IfYrVY+y3f91apy+RwjCIc/7SoVRfllKah+Ve7yUQtYWvJOCoskzvNU+7f5z0oBDMNKG2bt9g+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHgm8uon; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHgm8uon"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786535649; x=1818071649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VnlXWytHJvaHaIglKqHXsYUWpml+jz+Y91ZBqxPajpU=;
  b=NHgm8uonBFPkxojLfXl7pZ1mG8RzlRu0aYAYHTKpZoaCaGxrEIJR36Ql
   TrxK/nyFek2sgcKAzK3tXJ9HZjCib561ygWh9AyxP45nchQQD6vlEWabA
   SfGT7ZXAxKjWOO8vjCXWKtmd88S9EtftLtOtIp95KKmQXgMYeUtJVM6Wi
   9MsIoepBUX1Bhf0XXWmGQfBwB0VEmpYRrR8E4kNTEhTqeYWuwsmA5w4X7
   cIgagGY7lxzILGfy5WwkheCXEx7kECGDugSlKrVXe4wBDbk3/x7bI5EAd
   hRyjNYXtIQQFsRz8c2gHtrNjsqJsUV1Zs1xnJ6i2CbIpS2hYG1FJTgwYH
   A==;
X-CSE-ConnectionGUID: +gHQz1CRRDCNE/UBD3gOmw==
X-CSE-MsgGUID: wnS23e5HR9OeQt+GdCOHoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97748591"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97748591"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 04:54:09 -0700
X-CSE-ConnectionGUID: aKSn5v3ST7e6JoOZ8gocKg==
X-CSE-MsgGUID: B1zHGKVrSSmWaVXRgEUxoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="288378934"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.245.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 04:54:05 -0700
Date: Wed, 12 Aug 2026 13:53:58 +0200
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Matti Vaittinen <matti.vaittinen@linux.dev>, 0012-iio-accel-kx022a-Fix-IPOL-macro-name.patch@mva-rohm, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, 
	Topi =?utf-8?Q?Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 12/12] iio: accel: kionix-kx022a: Fix IPOL macro name
Message-ID: <anxdf0ee_-CpDU1S@mdjait-mobl>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <c26c2741ca11adf7a089c094d8648f4ec6cbab54.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26c2741ca11adf7a089c094d8648f4ec6cbab54.1786347811.git.mazziesaccount@gmail.com>

Hi Matti,

Thank you for the patch!

On Mon, Aug 10, 2026 at 10:55:25AM +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The "interrupt polarity high" -macro for KX022A variant is defined as:

-macro ?

defined as what ?

> However, the KX022A_MASK_IPOL1 is not defined anywhere, so actually
> using the KX022A_IPOL_HIGH would produce a compile error.
> 
> Fix the define by using correct mask.

Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
> 
> ---
> It appears the KX022A_IPOL_HIGH is unused as the IRQ is currently,
> unconditionally set level low in kx022a_prepare_irq_pin(). The KX022A
> hardware would support other configurations though. So, another
> potential fix would be removing the define altogether. I decided to
> leave the define there, as having it will allow users who need different
> configuration to simply change the KX022A_IPOL_LOW to KX022A_IPOL_HIGH,
> which is kind of a "easy to try" thing.
> 
> I don't have a strong preference here though.

This is up to Jonathan. Removing this also makes sense (and if you
decide to do then probably do it for KX132 also)

--
Kind Regards
Mehdi Djait
