Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2F3B8D78;
	Wed, 13 May 2026 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703133; cv=none; b=mbzKIhvCNQZmoncWVofCndWGZDT9zjENGi/EkL5UU9OZYv7EynU8awM/x4REJRpHGBe73H6GvOrKSEb3XxRS0xyn9E8JzdAG+96P6tJNQN+QeGnao5Kq7EnXhyn1zNq91M9gYGsTs+WDxNT0fDF1pDr9SJxqm0HxMKc9/QfO/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703133; c=relaxed/simple;
	bh=5Epym90fKAuiJjd27QA6X5Qm4j4TMj5bRrbqdLkIIBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agh3XOlzJuSPjRVGlGxjVSBBbBZi5dTOYdakAaiedOGWWF91gp6N8hNErKrkeLW++Zf5maeN6LzQEkLXI20FBhMB2qglzc4uzbl3mqJenIL1TCAd1S4NJwbCnDvtbLN9X9JbpV+E3jRi/MGoVRzrVdJUrTYHiG33YqtQEmcxfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lj4ol9oe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lj4ol9oe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778703132; x=1810239132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5Epym90fKAuiJjd27QA6X5Qm4j4TMj5bRrbqdLkIIBE=;
  b=Lj4ol9oern5OmGeF9isj5NF8U+5PNySaOoY9+idku+SM6AzfyUKBZWvP
   ANN9UrAPZo3Jro/LFFTXnb2KAlbXky67hOIHlo4x9OPR4zh11v0ICeiO8
   OZANpDc4weLlr0BOgaUMb3tbNq8B8ot5hromvOt5u9un4S49GWM0tTq3l
   nbJRWwgkal+8fq2s6zDTDi33wFjn3pLk4GUFOTzIzUww8gQUcG2WKw50d
   idiwCxbXd9JGwTf8/eZMGZn4zaZd6ZJ1hafsadRTUl2AX45H5akUir0vw
   ZDvLaOwCywA3k72Yiq41TGLgnAyVaCvd/XauSSO63qg4JN1DrBM4fGdtr
   A==;
X-CSE-ConnectionGUID: HnGTgtI8TAmOh6GhK/N8ow==
X-CSE-MsgGUID: mvdMROqqT1mCaPWvq7dfdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83512259"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="83512259"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:12:12 -0700
X-CSE-ConnectionGUID: mlJKbVbsRei8/iMm01ob6Q==
X-CSE-MsgGUID: Ge71FgiOR/KxCahTfu36SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="261690012"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:12:07 -0700
Date: Wed, 13 May 2026 23:12:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>,
	Michal Piekos <michal.piekos@mmpsystems.pl>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maksim Kiselev <bigunclemax@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: sun20i-gpadc: add A523 gpadc support
Message-ID: <agTbFbicv9yzTQb9@ashevche-desk.local>
References: <20260513-sunxi-a523-gpadc-v2-0-d5efde151dac@mmpsystems.pl>
 <20260513-sunxi-a523-gpadc-v2-2-d5efde151dac@mmpsystems.pl>
 <A7772824-E704-4BFD-A796-BCD81197E5A2@gmail.com>
 <4248ac7e-3cce-4db8-a2c1-710f2c903490@arm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4248ac7e-3cce-4db8-a2c1-710f2c903490@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 01:53:49PM +0200, Andre Przywara wrote:
> On 5/13/26 13:44, Sanjay Chitroda wrote:
> > On 13 May 2026 10:29:43 am IST, Michal Piekos <michal.piekos@mmpsystems.pl> wrote:

> > > +	if (ret <= 0)
> > 
> > Thank you Michal for the change.
> > 
> > Have you validated the changes ?
> > It looks while success ret would be 0 and it would give return error.

Good catch!

> But devm_clk_bulk_get_all_enabled() returns the number of clocks found and
> enabled. And since we need at least one, I think this is correct, and the
> error message below reflects that.
> 
> To me that change looks good:
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

== 0 ???
Doesn't look like correct code.

-- 
With Best Regards,
Andy Shevchenko


