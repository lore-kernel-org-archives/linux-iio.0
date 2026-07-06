Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544713AFB13;
	Mon,  6 Jul 2026 06:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317707; cv=none; b=ARNULh2a3eYRVP2CTE/NiXiRLXYyoGqc65yp2/FMPdu1hdDeJjittYhNLgz5Whzbvo6Jl2t8wVOLrYZcvKX/MwXvXhfxNFHwxxlR9Uzi0ILICcQMjAvBACU9oQ0yMgSJGQVcFruxFnc1Mi3RXxoPdxZZYVn4ervuxiWFoJLT+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317707; c=relaxed/simple;
	bh=oI7hTTwYzoAzds0+eG0Li11uFlA9qv9t8y5igd5LHu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jvre0GqFFHzxhkOb9UnJnIRF9Fj0APRu57MK76GOLEmMPw+P7SJyoXZH71mXJpg9BFMz8Itr6p+mZmZD1G90SKJRu/obqdcaDO/8SQm7SkKSX67xmXmgKQJsc/2Z4RJl3r/QvDL/3ya4igocigrqtx+Nf+0pSxTfbzMs8ig7Gns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFnk0YW+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFnk0YW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783317706; x=1814853706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oI7hTTwYzoAzds0+eG0Li11uFlA9qv9t8y5igd5LHu4=;
  b=HFnk0YW+5yhoh3bgr61AutDr2lFfDwxI/jC1DItV8DaEspSaqe+vsBIl
   3+pE+ezCA1CSofehWyr7GUpAskk+7MaPQ/FBIEpNFQrfTxlCuSOXxQkcR
   GUNcwtN4rvWslgnUBJpyB47giVkUiuXch59js2s0Sas4MZh3wzaSoS7Nw
   x5Vy45+WV1za2tSXyXLFVqFVrXY56Pb9CaE/rdvVQuYnIG3Vow9iA7ZOk
   UzzW8UOW3L+6yUbSi5EveisGXFUfQXxKog2SUHASgnDILdsTPfIO9L/4I
   nymJdKpSUBT0hu+we505IkidX8NO+boETuNiJGMLDo5c8qo0m4qLANszQ
   g==;
X-CSE-ConnectionGUID: kYiuRKHyTMSsXjKZ/BmtKg==
X-CSE-MsgGUID: gIIIWfBGSdmV5Zs/fpLsoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87855370"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="87855370"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 23:01:39 -0700
X-CSE-ConnectionGUID: nlxTu3NOS4Gc+8sast37GA==
X-CSE-MsgGUID: b5j9BS/FTXG0tBCtVkxzbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="250262648"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 23:01:36 -0700
Date: Mon, 6 Jul 2026 09:01:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-ads131m02: Drop redundant NULL check on
 devm_clk_get_enabled()
Message-ID: <aktEvSMFLSmutkF7@ashevche-desk.local>
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 05, 2026 at 07:24:39PM +0200, Krzysztof Kozlowski wrote:
> devm_clk_get_enabled() does not return NULL (only valid clock or ERR
> pointer), so simplify the code to drop redundant IS_ERR_OR_NULL().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


