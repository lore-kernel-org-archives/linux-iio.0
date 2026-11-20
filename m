Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185887;
	b=MlGxSLGsDGcfWOv9lI+egbtgVkI8hr+sxVCw3/u1iUMh8HVvRe5+DI12RVBbDJ77qdfE
	 MX9sBy1InhiJiA4DsS48Ynrg5e0rjCfq7NOG41/FPKTvQpn/DuRaDiTjak47f2tqY/5rQ
	 g6y/Kt0UdU1sfs5XET9/D9S7vBG1s+EfCGg78i+/hW/h1WJ4ktpIGmjnUdr+JPUun19j7
	 5gcYa3IAsZ1811EphlxvT/X9A8e8uFGmYKJZ/d46JO3QNTpcBMZejjH6hzkybnRGur26u
	 m9l21ycFU83aVF46HDC9wMk75CoAk1NBG/Ntphy0CNWORu38csFW0y0T8+w0/rD5sRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185887;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qrjAzrJhYf5vZy8hlxQ3Jg1AthP7/RFbyFylGoaLKws=;
	b=BC40Y54fn4EZ05+pccqqZH+ZDoiHmKdIoMrMaQmnpoCWdLIm57D9AK2ezhHHAzvAkbrZ
	 JlLps8abqaMugqFpeIHFL+qRvwBFK91vwb8WoZAI0Hd2fnd1BiA07tZDG61kU60PlY5RZ
	 oj6xL3EniC7Ns44+NRIIAEoKycxmnwGf3cDcn9E4abP2KhFxpa0EiLTvb2KngaSPawJOK
	 5ZwcCBiu1vFRpptrPhVDHcAHCSB/uVYhC/XYjm6GgMBC35j1j4Jws5hSMBrUvQ1E73BxG
	 FCGvfJTkgjoWsZUuUvhW5qm+jSO1yHVReEx4JX2hI5W9X9yySUFE+CrFZEyLenvBROQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kNSwSrMQ;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9C606A333;
	Fri, 20 Nov 2026 14:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6C9C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kNSwSrMQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795185887; x=1826721887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v8Hyluy4b5QjlOZwYbrn8VRWZYbKc/XDtN64J/0x8LQ=;
  b=kNSwSrMQLP53nHX9So5xg1rEFowgYECmTPTPDVtosSRz81YQ1LRNhEIm
   C99OHUMXxKUWqGcfyfj/64VUTV0WvWCOg9cMH+G/ZMd34rXTu2YVfs6Kt
   RJ37sQWpkEMgJGbxlaciaXKlnFIYYBJu5+vkr6qX5ImcGSiS+7VtSe1cg
   em08Y6M/7HqDkt1U6f2ET4LrDHVcq3CdrAtt8/26qPIrJ39iDHGbDXpWz
   h0mJF3M/kfq6OK7ShM60OG+pKXoxkrJHjSXiDTwcV5xcnQQmBG1b8QwzJ
   8mwaNcJCaudCLSRuXgxtznhjvIRgcX4oJBTdSYteflgCtqNI/1egAPRql
   g==;
X-CSE-ConnectionGUID: 5ZXkItcnRNCr2bGvUfYu9Q==
X-CSE-MsgGUID: 1ZaOiUslQ5aOGZbW1O/phQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4053642"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4053642"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:44:46 -0800
X-CSE-ConnectionGUID: qWW3kSylTN2dCXICmpoQKA==
X-CSE-MsgGUID: EpxpNGQLSAS1hUO5cWU2XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10598823"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:44:40 -0800
Date: Fri, 20 Nov 2026 16:44:38 +0200
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
Subject: Re: [PATCH v2 3/3] iio: adc: rohm-bd79112: Support ROHM BD79111
Message-ID: <awBc1qFMhydEXo69@ashevche-desk.local>
References: <cover.1795176984.git.mazziesaccount@gmail.com>
 <4be17e339f768da93db2f42abd3cc5a21fea01ad.1795176984.git.mazziesaccount@gmail.com>
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
In-Reply-To: <4be17e339f768da93db2f42abd3cc5a21fea01ad.1795176984.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 02:28:28PM +0200, Matti Vaittinen wrote:
> 
> ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
> where pins can be configured to be either used as GPIO or ADC inputs.
> ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
> sources.
> 
> The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
> for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
> promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
> the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
> clock.

...

>  - Return -ENODATA instead of -ENODEV when SPI match data is not
>    available.

I guess you were distracted by something, the error code is now introduced in
the very previous patch, fix it there.

...

> -	tristate "Rohm BD79112 ADC driver"
> +	tristate "ADC/GPIO Driver for ROHM BD79112 et al."

> - * ROHM ADC driver for BD79112 signal monitoring hub.
> + * ROHM ADC/GPIO driver for BD79112 and similar signal monitoring hubs.

Can this text be modified to be closer to the other two?
Something like:

 * ADC/GPIO Driver for ROHM BD79112 and similar signal monitoring hubs.

> -MODULE_DESCRIPTION("Driver for ROHM BD79112 ADC/GPIO");
> +MODULE_DESCRIPTION("ADC/GPIO Driver for ROHM BD79112 et al.");

...

Otherwise LGTM,
Reviewed-by; Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


