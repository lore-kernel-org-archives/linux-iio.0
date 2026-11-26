Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702234;
	b=n2VO0Wa123aBwj+1kelksx4UCCISloO9slg0/oKqJWp56Kt3rVitM+HKm+rVHk/QuLFB
	 CozGORtg0133OrD7DYRY/Xh/S0gk50soosN7pQNlQYpb1HGzIbe0IuAoWWbdOg0jgQwlk
	 9xwSboOtSJMOxx8bXAjoseKi5uDAruM0xHU3ZXFntvBkY/x0LvmQ137ExJK53TzuPCEZx
	 /9mP/L1yRL1GYcNWvCgedXWwY6mH8CC4kJ8TiW+Mi3OGU8tbqjF9+9oRSobj6I2rsC0/o
	 9PiAroT/G9JIVuwj+OY9ZImyw/YTjB3tx2edHQX3t4GQ+d8WhZEg+dUfJOHITPfSkwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702234;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=kuQQnzehbKD3n7lGa4bVON+mvIVi2hA/as2EAef6sqM=;
	b=nz3S1nPiYQ/3lHiKZiziK04s2jfTa4w+4qjg+TS0ZfbcYDKPEf8tSIPR+NlVk4uJf0t/
	 qF7inhwQULMkMFNO+2AGRbWujhOjSVsza4bPTfQAVNuZw+dn1jUAjpiyoZTEBMkwXEiOH
	 4b4+Ciq91WbFj3fpGT+zPnBx8P/YDaAJjoJ44T29StIZG0NPAQ0ijS2T/W3kIckIlyuPe
	 oP6+6joaqVCWw25O3RRuuXndqFjyEOQ194AQdE1OWTrmbOiViWiBgbdZq6shyidIGeGRe
	 KHSyL7rYDMcf4rx7GmM5f5rcuLGXiFUQ2HEl3n8cp28DrQam/sPAlLV87WP+pqMqjBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hOJaWzmj;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE8606A32E;
	Thu, 26 Nov 2026 14:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0CE8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hOJaWzmj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795702234; x=1827238234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kgtB+l4EZTdNwkV7MWsWZYIewc7cT9kvWiX9nQy2AkE=;
  b=hOJaWzmjlAI4lHxZfIbizBIbdwib4c1ijDLiYumGfd+RATg3rxdQmOdX
   e5A9n/qZ7mEOzYMpBvcspFUk0iX69wmPeat7ivMoYB7nB4o201rjrrguh
   TG1TMN0Vs+eWa28RSOyr8XVHIMbzzZZdOEFaSqs3crspXFqoIUU29VSb7
   gC3OJCQKcXFOggfiQmZtbXc7HA9lD3DRvgxFURat3kUYvD0Lv++ALxdqk
   XfBSTZFBgAHnnJunS/ZuROaSlqqDNSaPBf+R9L2r0h72oywmAHvou+3CO
   12IXXT8eNCIcwjzHIG48zcGescznx9QxKrPHXzTUg7hIC8kPwK8YIqJsq
   w==;
X-CSE-ConnectionGUID: 44f7UI0qSBO2dujr6yUF6g==
X-CSE-MsgGUID: 5x/7iZlmQLmGYFB8/++iiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4605780"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4605780"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:10:34 -0800
X-CSE-ConnectionGUID: W31SH9gLQiCF2IzC6X2k6A==
X-CSE-MsgGUID: RUvMuKCeTO6s8IR0kr1jig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12440987"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:10:30 -0800
Date: Thu, 26 Nov 2026 16:10:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: robertijtsma@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] iio: light: add support for ams OSRAM TCS3430
Message-ID: <awg91DruXE0fZ8l-@ashevche-desk.local>
References: <20261126-iio-tcs3430-v2-0-6c5329d20919@gmail.com>
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
In-Reply-To: <20261126-iio-tcs3430-v2-0-6c5329d20919@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 09:11:46AM +0100, Robert Ijtsma via B4 Relay wrote:
> Add Devicetree binding documentation and an IIO driver for the ams OSRAM
> TCS3430 ambient light and CIE 1931 XYZ tristimulus color sensor.
> 
> Tested on Microsoft Surface Pro X SQ2 (SC8180X), where the sensor is
> connected on I2C at 0x39 and used for ambient light sensing.

It's still unclear why a branch new driver. Can you elaborate on this?

-- 
With Best Regards,
Andy Shevchenko


