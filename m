Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165C3451CE;
	Thu, 12 Feb 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903566; cv=none; b=BnI82ZWSv30MQXe73iumRgSial2SuPfWP+pMFeBsqbA4/y3fKvBsjMKFk270Xw5RBzAr5TA6RK7Qhp+MB1wrSpTM17QKTO62v0ZfJAp9FxxeA+bHYvibRUO3Vh0ZJ+Rkq+aOCtMRLXePUMiZMPSGyo5dm0Isg5eR1Ohd3NE45IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903566; c=relaxed/simple;
	bh=utyaYBiIGi7UzJmfMxgD2vkdv+j61T4B/YtQfUgtvkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkmltovHW9SWlisLAL97Z2wvaVW9nulop0oPZi9tjAaGPTikOWBPhPzldWtSEP38JnEIux3Mc62zfYbrbWMoOvj3gxilfejFusqEYWNdc95BOHyLXpRjJe4L0UEMqcShU8Wgpq78CNxNucr9B0p+cQpY72oKnjmOa1Rgy2yLEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXGHMup/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXGHMup/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770903565; x=1802439565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=utyaYBiIGi7UzJmfMxgD2vkdv+j61T4B/YtQfUgtvkQ=;
  b=OXGHMup/8xuTUEK6AzqweQxAxNeIQaiJLWZjUuZ46JYDH1VDaVtv8At9
   1EjD3LSASPoDqIOxqFJMo661HTjmwrZT7tlp6OS+9ZDtsog1I9s+L6gUj
   +s7PGe/G/W6FBni2uN0YeGmmqK5B08uYapwK4ynR8ecIUrO0+NE8wpZ3c
   Ib4Dz+SXN2jplanDO/TfLRRUWZ2j7wBhvKcvyZ9VGoyC7avCzu/G8qEGs
   QtiZRE1cR4q9Skowi6U3cpDAqyjTikQ7UmK59OR6VwXm/35P0Lv9cH4P/
   xA+GZ276HroxczNxDlXOTxP4tg7V2dR+d9oIb8GS+xIwb4fi9oA5s8njY
   Q==;
X-CSE-ConnectionGUID: LTEklVKRRjSmrdVVwI0tjQ==
X-CSE-MsgGUID: Wkn/+j9WSauTw8l6GGwmlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71788646"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="71788646"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:39:24 -0800
X-CSE-ConnectionGUID: RUaq1lFlTImvcGnzmzdRLQ==
X-CSE-MsgGUID: yZDvEoNkTaqUNOQt2wM3bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="211419698"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:39:21 -0800
Date: Thu, 12 Feb 2026 15:39:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for Microchip MCP48FxBy1/2/4/8 DAC with
 an SPI Interface
Message-ID: <aY3YB1MyNnSUszJN@smile.fi.intel.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 02:48:33PM +0200, Ariana Lazar wrote:
> Add support for Microchip MCP48FxBy1/2/4/8 series of buffered voltage
> output Digital-to-Analog converters with an SPI Interface. This driver
> covers the following part numbers: 
> - With nonvolatile memory:
>    - MCP48FEB01, MCP48FEB02, MCP48FEB04, MCP48FEB08,
>      MCP48FEB11, MCP48FEB12, MCP48FEB14, MCP48FEB18,
>      MCP48FEB21, MCP48FEB22, MCP48FEB24, MCP48FEB28
>  - With volatile memory:
>    - MCP48FVB01, MCP48FVB02, MCP48FVB04, MCP48FVB08,
>      MCP48FVB11, MCP48FVB12, MCP48FVB14, MCP48FVB18,
>      MCP48FVB21, MCP48FVB22, MCP48FVB24, MCP48FVB28
> 
> The families support up to 8 output channels. The devices can be 8-bit,
> 10-bit and 12-bit resolution.

Is it really v1? I am under impression that I have seen this patch already
several times...

-- 
With Best Regards,
Andy Shevchenko


