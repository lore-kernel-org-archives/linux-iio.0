Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7CD4A0EF6;
	Mon, 12 Oct 2026 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839229; cv=none; b=sFNWUxfjH/Gv4egeyBUW1P7knmE5Aimm4OjijH1G1NOUnWqs59Az1R+7sUTnqneCrUb+dZgpMOaTRMW9oj/VxqxcMPgjceXKFO1xnhoy53gpDu+cUSF53v9FkaTJPgXOMaAVaRMYbb3iYGXh6fRZ0/acvv4iveImMbkcxzQjq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839229; c=relaxed/simple;
	bh=bVVAEipiwUOMUcpLzlPT7Lmm5gYJXvHswnCcfXQFJLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szApy5mwjNgqXHybsWLDbQpxvxiN8Xt6Cd5keVthQsdF4MhI6PG7RMU0Bc4Y8ERAfOiLn03J8RV0BKCjY8o3aH3bnmSswnS3rMtFk5GVXInPxYBfaqxP8uM0Yw/Zyk4aANcbdUVCeIfCMUzYcCoW5cR8LYLmgJ1y4Bbi4A4sjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acNaFtXv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acNaFtXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791839228; x=1823375228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bVVAEipiwUOMUcpLzlPT7Lmm5gYJXvHswnCcfXQFJLI=;
  b=acNaFtXvnXcFxXIslHsF3gTztE5MhrgFhmXJ4RWBjaD+k3kikoLRsuQg
   TWw/+ZxHgkHWoOxd4I/PZ2rSuQb0N+Uo03SyL+4vzcRZejSZ3Ud1vXNc4
   JCdAZ3mU+UVBy/BweXuRaFfceOkDEU9ePtqvHGBCYZXx9hy7IBv6By1Rm
   qj9WA4VmTqZMAlqd1mlJtSOE6QoHabKzUgXMz8ElNGMm2skALHYK3qC4z
   6IbVV9ehdLQXA6o6+qV89uAXC5PE9zIoRy6N8wyggUAYZQOeTtryEcA8x
   chaoNvW3fz4zBFoq9R2tTJYxHbTzCL6KRVaBJnpx58/mXdkk7iWlH8i3M
   A==;
X-CSE-ConnectionGUID: S73KCWzrR7qqp+JDoHcHCw==
X-CSE-MsgGUID: bCJydj6lTUSW/LKfohL5xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="549325"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="549325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:07:07 -0700
X-CSE-ConnectionGUID: gOhEPTXDQS+gPAMbHWHqrw==
X-CSE-MsgGUID: /MtGaiJhTBudBOHiTtDmWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1096907"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:07:02 -0700
Date: Tue, 13 Oct 2026 00:07:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marek Vasut <marex@nabladev.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Cheick Traore <cheick.traore-ext@st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Cheick Traore <cheick.traore@foss.st.com>
Subject: Re: [PATCH v4 00/15] iio: adc: stm32: add support for stm32mp23 and
 stm32mp25
Message-ID: <as1L9F3ua4LKvj73@ashevche-desk.local>
References: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 06, 2026 at 09:57:31AM +0200, Fabrice Gasnier wrote:
> Add support for STM32MP23 and STM32MP25 Analog to Digital Converter.
> It's a variant of other supported STM32MP ADCs. Add the DT bindings,
> driver, SOC DTS and an example on stm32mp257f-ev1 board.

Looks good enough to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


