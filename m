Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603225;
	b=nHkcClF8LlFRwHi3zeGriTw3Qdve0W7YkqTWgvdMunMHDJgUjhMEJNx1Zwb50prrckIa
	 7Sk5hgpG0wLNReA0nhwuu5twZ7929mYJa3tC0u2CTbfcKk0WQxiVE/Inp2lDwcB6L9S3R
	 bQnt9jqAc4lUjAvmYKgf1hssNHhjGbcKKa7BuNMgmgjHBxI54AYEjZFi5sozQVQdsOtc+
	 oTGelM4IILb1xhbXRR756EMY+7AvoXaeywB4/KK8G416vGkjj32wiRPAgl4Cmx/K58/D3
	 uWWcmL2dpT3yivQJcpU3BPDtuevc1nTahFuPsDRl3EHDQflhu+vdQbyYUWpwwj5k9Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603225;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=0KVXe8Lkr/kGAMBYqLm7ET+oALgq+U+OX2EzfHpkcFc=;
	b=zFXgUt3jVwYcwt6N8cn47/Orq8EFMWPfayh0QwKbwnd0eHKaUd6baQ/7vRX7GtcXgYNf
	 n2k/5bWyycZvkh9px3NzQJXFILAeuLz1zXIMmlfshUP106Q79/JxI1bDEEGc/6ixfSl0V
	 tYUlYwEcjfA8PH6+BoOZaaXjhuL2j/xKFAYdSWZrngZLAbgqFI0aTcKBNCh21Nyu5MRJe
	 +qH81l2qR2iRfhhu9/XzB3hvMfgXSDZTtFRhfBwnxpRbOxofXOmSCiY2gG/RMY0JY7U21
	 Har4vjywgulFt56rGuPKFGKu1yHGcIxJAMApvY2ceYgoDdy5POfVND5cPBIXT/IXbMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="bcd/z861";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79DB606A332;
	Wed, 25 Nov 2026 10:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E79DB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bcd/z861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795603226; x=1827139226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lr7DVcLoOJoDi6HPqizu0PiuEetBut//Pv+Huh4+i4A=;
  b=bcd/z8616IfR64ixtIihvnOD7212wCPNooDafxYAiOB5g/WIlyyX85e8
   f5J/gMgvmy2eeXCAiLSThl4xmUGggPyxeVMgccMKDEAsSLUIz/5PA/xMl
   BhbbH3DjCjeJa+wIZdqcvNUJgXrbLXVGq4mRsSkDc1gGdWiuJ8bg2y7/a
   gZ15U7cU90c02fTHLxK3J8Hke9WWH3uDkLEDD1BtKfYI4yRMHU8+H2ppi
   JOUce6FePh32ryQ58p2xKU/nGuQ7AJ6xFpKEHqCyU8GSnEglWOxBxzjy6
   m+SVuueqXa455ge0/TykpHMO34C6XLjsy2H8+FxpQRvV0YC1B6VPmL/gi
   w==;
X-CSE-ConnectionGUID: TCYDTewHQluHq32T80mznw==
X-CSE-MsgGUID: tTOeFen0TbeI9YzhNQkkWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4537499"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4537499"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:40:24 -0800
X-CSE-ConnectionGUID: UrDy2hW4Q3e1PRZ32Z2dEw==
X-CSE-MsgGUID: rIarLVJ4RiGslCKzZhrVSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="13505894"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:40:20 -0800
Date: Wed, 25 Nov 2026 12:40:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@analog.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/6] iio: adc: ad7791: drop platform data support
Message-ID: <awa7ErQjuKbtV_RH@ashevche-desk.local>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-4-54e4c8830b57@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-4-54e4c8830b57@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 10:19:20AM +0000, Nuno Sá wrote:
> There are no in-tree users of struct ad7791_platform_data. Without it,
> the driver already keeps the power-on reset configuration: buffered
> mode (on parts that have a buffer), bipolar mode and no burnout
> current.
> 
> Drop the platform data header together with the code applying it. As a
> result, ad7791_setup() can no longer fail, so make it return void.

I would move 'a' to the next line.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


