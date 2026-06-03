Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE975367B99;
	Wed,  3 Jun 2026 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465891; cv=none; b=BUZzToKdCL+L2rFdMMwRlL7hOQeBZDtpczGQw3hgFgmKFQvLpqgiXFUxQ+/iCqe+L1ryRDIr7BvDhBEBNidL/RXGIXX2mfhWAMZ9V9Dm0TV0JlURcyZNW0JqQTHPirfYbkT4LQdJyvucdWYP5FhN4/7N8tA9eVzCaTSxF+DD8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465891; c=relaxed/simple;
	bh=U/sFUr+evDyY5P6S9Fd2jS9cFVU/nDx264kKOJ8IN08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLcaAsbJB46FuRNjthp8KM8Hyk32kZsHmSTwSq8nRvVdT31X2qqx83Vc1EbPGyh8BWilwIDLTrOiE4qzg/cVqKtXBwCdvfVEeEXEOeZSUw+2/LnRieAbTSARajobrp4lYI0VA4ixNdc9cojgND/pbmWblO54mQNC+9S4b0dpqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiaGluYI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiaGluYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780465890; x=1812001890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U/sFUr+evDyY5P6S9Fd2jS9cFVU/nDx264kKOJ8IN08=;
  b=GiaGluYIjjwo2oWWLIY6GcgMB8AB8JxsKFvCOs038wOyO4XbREhvmKFi
   BPr53mFEDL2Jj38LHs02pibj6cDH/qfXIVXjigNnlweacOl6M/JH6eOgl
   z+4dX19GdXO0doWK7ZBHSTZSNfqBJY87JylQTbv9DClzFRyjjc45NQatl
   u4aruE0HBJugpu6DGEfNNeyS1btiyzp7HmAUAF+hkDGgxHB+n/sk1R8vq
   XTsRUr1XAjNCSKof7cup2VzK4ktFSJFqV5zGMCnx5d4UoPGFvk2TSBc2w
   FVou2wE0ALPIxObt9t1mRpsnlTmZoP9gu9GeGkYjXzx2LT4tuTvKyMqof
   A==;
X-CSE-ConnectionGUID: 3d7k4eDAQj+AgDfqPtyt+Q==
X-CSE-MsgGUID: mwv6LgkeTrWbJTS4/2u+IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81389795"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81389795"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:51:22 -0700
X-CSE-ConnectionGUID: WH3kdDGERByF5mzs+Oj+Mg==
X-CSE-MsgGUID: 6jqZ1pqTQt2aNAKf7ZYlLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241134290"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:51:17 -0700
Date: Wed, 3 Jun 2026 08:51:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: rva333@protonmail.com,
	Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
Message-ID: <ah_A0yDhmZnanzn5@ashevche-desk.local>
References: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com>
 <20260602-mt6323-adc-v1-2-68ec737508ee@protonmail.com>
 <1F6728A6-BD73-4159-AAC9-82370212EF04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1F6728A6-BD73-4159-AAC9-82370212EF04@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 06:41:43AM +0530, Sanjay Chitroda wrote:
> On 2 June 2026 6:16:55 pm IST, Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

...

> >+MEDIATEK MT6323 PMIC AUXADC DRIVER
> >+M:	Roman Vivchar <rva333@protonmail.com>
> >+L:	linux-iio@vger.kernel.org
> 
> No need to add explicit iio list for driver.
> Top level entry covers this driver.

While that's true, if person wants to commit to maintain the code, it is always
being appreciated.

> >+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)

This line might be questionable (or at least needs an Ack from MediaTek
maintainers / senior developers.

> >+S:	Maintained
> >+F:	drivers/iio/adc/mt6323-auxadc.c
> >+F:	include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h

-- 
With Best Regards,
Andy Shevchenko


