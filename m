Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4FD2C15AB;
	Wed, 19 Aug 2026 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148911; cv=none; b=F07R1Mc/QkEcCAX5v9rm/oTnO+TqYF1qyd30grWQ0iaTc17n7UXga5x2Et5oxb+hxh4Dx8DNdpf4zgTN3yiTrYIyXJmKDERjfxuL+Ug5ESwt/Ge9USSECdnqa0KFh2Jjv2aLwJU2G4TNY2gnvsi6N+hy0tts7f0Hfa5qvpaRZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148911; c=relaxed/simple;
	bh=DDIFyEaNr8xSRV3efzo+9XYwvZRuMCNaMJ9TJF05eWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u448kgzFAI5spu14YeDzpzf6M9nReYb8O7BbkgewSfTTdyeGB7pgKpquIlgROhgK3VxwNuu9enaOsVtx+svDU6H6ZxFU4UPOdUce9WmtT7XKa2f2h+w6hFAQrf0EAaaO5kInlwmNxiA0Uzv6/N3nuAVEjCqp902ktk+2LdpGCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6zfWbEy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6zfWbEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787148910; x=1818684910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DDIFyEaNr8xSRV3efzo+9XYwvZRuMCNaMJ9TJF05eWw=;
  b=U6zfWbEyXokxyXnM5HgMQuxAB0JWqvVUUhSC/LnPJTrGLYS/ilIh9cJc
   PiLXmog+ozTNoDC/3EpM7OFXRq731AMbGaDxZpo8Z2gPpKD4kfQG7+oUq
   06SJAA9Qdsq1Au940CQEuhQSk0hEa0uvzRfm0ysCTdHAmBtzDNsFuoXYX
   SqYzmEGUK6NBnuicLrZbnT7/1ZOLWJ5jS/eyHaqhZYFTWRxmre2NIXiij
   BiFM6vMIRM7F2/de5/M2w85c42Ydd3YAiAnryqVzBiXPzaJLANXfCjEOn
   Zepgvty+lsU9b0ckGsqR0ZFQrrsZa+wLYCP4OJ3/bG0AC0eCRlKIoNMM1
   A==;
X-CSE-ConnectionGUID: pvXdr3jPRRWM6ksWjIDjVg==
X-CSE-MsgGUID: Rmd7YvzUS5yU9eQM6mcpyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="99025088"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="99025088"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:15:09 -0700
X-CSE-ConnectionGUID: +Z3Nhwb3TXedBFaoDxqMeA==
X-CSE-MsgGUID: VTlkjpCgQU2Mp8todT6uNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="262934539"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:15:06 -0700
Date: Wed, 19 Aug 2026 17:15:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iio: dac: mcp47feb02: correct gain bitshift at
 probe
Message-ID: <aoW6aFDqYBr3rF0a@ashevche-desk.local>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
 <20260819-mcp47feb02_refactor-v4-2-beb2aa3bfd09@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-mcp47feb02_refactor-v4-2-beb2aa3bfd09@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 03:41:06PM +0300, Ariana Lazar wrote:
> Correct the formula for initializing gain struct field for each channel
> with the correct bits from Gain Register.

This needs more information, ideally with the reference to the datasheet.
For example, it's unclear what's wrong with the existing calculations.

-- 
With Best Regards,
Andy Shevchenko


