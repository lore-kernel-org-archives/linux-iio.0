Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5304B481DD;
	Fri, 18 Sep 2026 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725081; cv=none; b=uGuz1eQEkRlb6/xku70ty8CMjn1QQpPzDxs/pAfaWxJwmg8LT6/lQdykbo7dOxy/MKdTGfr6qLv9OUi5gEv7FF+YDXmRXaR6wZKh/V7VcH0kw1+nexmSyMG3UAfII3lc35xlKmwYhYUX8tk3Uk1Otxqu6HJnsqRpF0KKZcOB9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725081; c=relaxed/simple;
	bh=PdWkHkW35zc7qU8JTJwU2GtagOwiOFCR7+J7q0Xyd70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9gFzA8f3BpXIAKQfe37LsMLBOF3u15o4uMQd5A1HJ9duJbwBIjMXxRnK2W5uzSweqyLFyi5LumRhPpIpkK3GrTa+ftC/l2m+CzPw/o8HW0lfeOqnGSbA85fAO3cQbeRpd71R89u0b2M1KVTapFPbwLOGU22M7Q3X1uWhEEc38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAZ3rKoU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAZ3rKoU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725079; x=1821261079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PdWkHkW35zc7qU8JTJwU2GtagOwiOFCR7+J7q0Xyd70=;
  b=TAZ3rKoUO6zA8J+bJva3FTVzU46mjlnKho/3MKr/an8+QE2MeUdHIZ+b
   Ov1DSNbxw/bpdxE0cqLnY7crgpdf32r9c9+kNq+MEIshMvzcaH0AJXh7F
   Y5pvQxOGhkSAe5tTUyYa7wkE+Xe8j2oDO2755C3gfbtxA2jYsQHKfdAJz
   yryKYfXGlW5I7iWfC6/t7pPu9Eu++EogHqcPU3KG1vvCWCW+iQVUuMB85
   gqE94A9dOGZpYum3bsVrf4Lgj2gTXUDO5I2asDRaO8wOG/lp3Gpr8ei9S
   g3EceXxzMBHT24ja1yN5yFddpM2AQJx2tTPsVW5TiKKDhDSenHxpINWsv
   g==;
X-CSE-ConnectionGUID: KvLppnxPQ/GDTCw7QU9ArA==
X-CSE-MsgGUID: RLsdvOW4SimIgVo2w2QaQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90351049"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90351049"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:51:18 -0700
X-CSE-ConnectionGUID: rUm6hvV8RuOZ6vtHz/G6fw==
X-CSE-MsgGUID: HEKQbwOmQKCBY68UPzNvQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276289736"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:51:16 -0700
Date: Fri, 18 Sep 2026 12:51:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v7 07/11] iio: dac: mcp47feb02: correct typo from a
 comment
Message-ID: <aq0JkYeYnWIO--1D@ashevche-desk.local>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
 <20260918-mcp47feb02_refactor-v7-7-82ca794eafe2@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-mcp47feb02_refactor-v7-7-82ca794eafe2@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 12:06:33PM +0300, Ariana Lazar wrote:
> Typo corrected to 'Register' in the comment regarding defined masks for the
> gain register.
> 
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Link: https://lore.kernel.org/all/20260723231859.03f92ce6@systembl0wer/

No Link for non-controversial / pretty much obvious suggestions.

> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

-- 
With Best Regards,
Andy Shevchenko


