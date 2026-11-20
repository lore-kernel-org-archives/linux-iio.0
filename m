Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185407;
	b=BY3Fl/1qxRTCviRZxJwM7WffV7+Ff4cJF6bRz7jD/yzSoyWSfTb/ym/d3CYMtB2XQLbD
	 99Fj41FLnpa0YM81RGgTnt9k09rCCEVN6ODWNv/t0jE4VlT2zoUvjUvpWcHyqxUUB+hxF
	 fPiqZZo0dClWe90ktgTs/jsfRabrdk5Otv213qI9XeN+nVvHU9DlwyK/r6OilEQtH9Mms
	 KCh+u+RV8I1daDGfjKa0igkxHrgCJPoQ0WbI41Wu60jc/QKOXcumIDLGDRXhFcztmGAWL
	 oiwlP5cpyIgEcK7N2hRToy6llrK+etYILII2s7EAsSJVl3f2WMQq3hiThcV2ph9CTiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185407;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0MCAlK1vSDEUpH6KYq3lQT9MH1vaHUdj1vOQ6+cLaJ8=;
	b=QmpXJawOKP1yXtDUanOf6kdskDQTNpvS3M/XX3k4PJen42xleYCKBK+pLxh36aFNMXBm
	 5iFAwkQAXRteaxJVjIzLeJEpuAW1xt6OjMQOROcz9QkHG6F2LiWtk7cGAYNn9ycOaFKBh
	 vVIL2AD2bTEvE3cVLJDZSXFPdfR90S42MkwnwXQhpdF6KkBTRMSvyfhtvXVwk/ToSLXAu
	 oAIojcNuRCR3keg8JmI2htpngQu364+w1FBKcFSP3ZqQH4CqyDCkFPO2HS1p+7U7EUKG1
	 Y/3pcgQtdVBn+5QG0z8+hSxQy8Qidgs6cVCBMP5R+ejUSqGH9kylgOxhYuMnFZoO2WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ap/iHjEJ";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969D606A320;
	Fri, 20 Nov 2026 14:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6969D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ap/iHjEJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795185408; x=1826721408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cig8N2Zz9xbZB/SGA4aQF6o/ROAYS8EbqASX3ugaRTY=;
  b=ap/iHjEJ1Zo2NolmaYj2jifTxcx+3t5vA5tbt6WCOmUffhBUkbUEcEsk
   NKCI9A4/CK7UwQVtxgeuBTXqmURZGIa/5kdfwzgFLxV/gXSLT2qoLRFPx
   RMt/D1YqIV2l+oS7kOTVCa8O2IyAtLNGDbgei1Ak9QpJ/ufCv1r3JLI8O
   wmHjGTLK6vig8LqOnr+zFDlH8AMNWAX+Qy7orEh35orF2fH2c5YyoBzNK
   /FR1uvpVtiHnFmMznC0D5dF/4Cq87PsjiyeQk6bUUfeDxaiEKkZJ+RJ3F
   JJHa8c9lFVCeDWyb/lHdz/cd4tLpNko+4CZN+RgdF8ZyWcn8igeCI2Dlh
   g==;
X-CSE-ConnectionGUID: oVZ+ndlbTfeq7g/DniPfKg==
X-CSE-MsgGUID: pS1kG+wLReart25JAlWcLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4061436"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4061436"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:36:47 -0800
X-CSE-ConnectionGUID: kpvhJ1msQ5mhPKhZEX2IZQ==
X-CSE-MsgGUID: aFpybgINTWKITI6agTdBtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11046527"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:36:42 -0800
Date: Fri, 20 Nov 2026 16:36:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Salih Erim <salih.erim@amd.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: rohm-bd79112: Add chip info structure
Message-ID: <awBa-BjgoJ5aSKI-@ashevche-desk.local>
References: <cover.1795176984.git.mazziesaccount@gmail.com>
 <42cb719e8da3b07e3c5b9bc6347e95ea7a30511f.1795176984.git.mazziesaccount@gmail.com>
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
In-Reply-To: <42cb719e8da3b07e3c5b9bc6347e95ea7a30511f.1795176984.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 02:28:00PM +0200, Matti Vaittinen wrote:
> 
> A new ADC variant, ROHM BD79111 is going to be supported by this same
> driver. As a preparatory step, introduce chip-specific data and pick it
> at probe time based on the spi-match data. This allows describing the
> necessary hardware differencies in data structures, which tends to
> result cleaner solution than some CHIP_ID specific switch-case blocks.

...

> +	data->cd = spi_get_device_match_data(spi);
> +	if (!data->cd)
> +		return -ENODEV;

ENODATA

...

Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


