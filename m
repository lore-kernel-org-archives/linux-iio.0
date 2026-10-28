Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195708;
	b=bEIV0Zep131c53xd/X6J7iW6EyQ98PITdcRR6p2/whfkpvxlhq0m2xLh0yZcLvrhcex2
	 uRf7+iUCqrn1A97b9DceC7KHPw1VRB0p8RSO5BexzYDMSAaa2bCdoCvcR+hoUKxjOH+MC
	 WEIBkTqWyFDFzmhcZn1AEDgjwuzK/dSVwWqLm/c6ng5YWujZnAPP8pYZAjI3CFu/Qql1J
	 TQa9h98AXfvf+8Wo9ImIHHWdPUlZPrwAa7JSLmD+ZZ39kvAuLSZ1/t/58R2FofELXP/Da
	 TNu3wKt319l6UISjHx/x5/bWy85hfuV5wnxQ9EGmFdrRR9LOr0obeJeZr5pcDUigSgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195708;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ppjHqUVsglS3sP4IvrCeWYBNEAaFHo0dcAQS3txioPw=;
	b=2wGXsOUgNDgybb3N3eu4mXE8FLXd1gANWM1Sjqb6PNfkqDjOdAdfeoG9NDW6gf+hnk2i
	 RrmolB+7i/6hf4wxy/n544/Lli/rxAjPx6MbXasFlnGbIOLyM9QM5nj9M90NvsCvVaGTl
	 NHLRQpckYO+dkLUWF/A4ZmTmgg5gC7M71Lw4ogzL2PcQNc4O9rSL0jMEJHvY4Zyd/SVjF
	 ryCANKQ41MblKOWWqF7a5KYsIJo9ARE9sA3ygQbOl7eavt4OW1WTuZx5wyDK6vZzM+/oa
	 VntIBSOFUZfs/65srxlgWO8p1TJF3cAK6AB188xvxZlGKXSR1icnjcR5CreSyOpU+Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QeMMikUA;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FFF606A31C;
	Wed, 28 Oct 2026 13:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6FFF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QeMMikUA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793195707; x=1824731707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WOn6xYyEphAdy77ddUIYxqei8Cv3mh2qBW9TTARgsLY=;
  b=QeMMikUA4I9fvLT1iJtCpwKeR6iz6CG1jv+IY+SI/3IeMUJ5irq4Tvy1
   /ZfPJqVeG0Et1Wp+rLmu2hrzCeunMyXZix6y+WX2rDJwdbHx3GBRG8uRN
   m/oxcpsTftAxqDdI3G2FPPtVdyad2hgw1l2z4Y4Q4wLQDqLqUgO0U+Sba
   37bTMFf/5UvpaoMTdRuLL4ml3f7yafKwTotGFS/duZsnWW5zAgx9EivG+
   sb6k0Fj2t3xNr11V+H+F/01PdVzZQHI3mgR6YWglh9o9Q/b+kDuM6cVXx
   XFdjC/o7jLsakDi6zkXytOFFwdY1+3n7l6VG6GKnYQook03NiQanOM+1Z
   w==;
X-CSE-ConnectionGUID: I4x+rTziQICluj8Hutp3lw==
X-CSE-MsgGUID: spsPJNBiQhaNwpQe/nVn2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1812952"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1812952"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:55:06 -0700
X-CSE-ConnectionGUID: VMU1DyMOQlOXkwpRTX1z0Q==
X-CSE-MsgGUID: XjlXhUujQRGWC6CQKWnFlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5361534"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:55:03 -0700
Date: Wed, 28 Oct 2026 15:54:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com, Marius Cristea <marius.cristea@microchip.com>
Subject: Re: [PATCH v4 2/3] unaligned: introduce be56 unaligned accessors
Message-ID: <auH-swoZ1mWwgWU9@ashevche-desk.local>
References: <20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org>
 <20261028-topic-sm8x50-iio-max34417-adc-v4-2-d4baaf3ee903@linaro.org>
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
In-Reply-To: <20261028-topic-sm8x50-iio-max34417-adc-v4-2-d4baaf3ee903@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 02:19:05PM +0100, Neil Armstrong wrote:

> The MAX34417, IIO driver, is using some unaligned 56 bit registers.

56-bit

(When you refer to the size as adjective, use '-' dash, otherwise space.)

> Provide some helper accessors in preparation for the new driver.

...

I think I gave a tag to something similar in the past. Anyways,
with the above being fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


