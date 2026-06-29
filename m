Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9FE426ECA;
	Mon, 29 Jun 2026 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745649; cv=none; b=AdqrHkFrAOyDvkaxC7DnIpdO58tX/9CwnE9hfoh9kZoc6WejNQ1Z8CmXo2iUwQtccBHLqk2i9dGLI56Dbi9W3G7ItFunMQpMwp7IGsFMHq+zDqP7cPG9rIga1fSjOYT0ho9g6vE5jwibNE/2oq10ZQQTcYrjqija4k9hvUibyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745649; c=relaxed/simple;
	bh=ql0M0w+CscFTV+YxYSpNeRlsFza4Hf0je2juqgar7iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMjezd7V6ScpOPiV8ARmnQjrvQw+FKBxKSxdmGOw5Uk/Eap/QIQ69MF6EGrdjc4NdnkG55PgSZ/fgJ4NWVoElJIbd36U7TWYsgFq0XwbM8uR37k5Y1YPcGoadf3BKGyS4huL/Za3+fr3+bjzJUSqjNhjYDrguVxc1MX5V8TPW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iS0m+baW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iS0m+baW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782745648; x=1814281648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ql0M0w+CscFTV+YxYSpNeRlsFza4Hf0je2juqgar7iw=;
  b=iS0m+baWKT0FXxncZIX5VHpDB20btQBEzdonNImyNVdQXxppnT0wmBY+
   8kG8XvIuvUpB9IG1j53/r718OfXyKoQ0mM/SRlqA0gcB6KbijtVK8xMIF
   3DMmsloLUFglVYvl7mavjovsqTm1COeJGFbH1s0lpdAkbiiT7kPwSwoUi
   Xzj6uAut5EpNv5rywXWvoJzj60/gN7zQUINZi2kuNMJ5OMnwCVbY86zlL
   PXXcJyjKlvm5VE3E/zj83F56xpy8O67vRCTLS1BKLchcl2yhyO+MPdVze
   iAabVYD8dcVhxGU7+VDyW1pEkXDfYCgV/yc6ovQ3RqlkflN2odxspsE5S
   A==;
X-CSE-ConnectionGUID: QdrbZZ+RRJukmrui5o4l/g==
X-CSE-MsgGUID: tE05RjviSgiXDfd4azDyYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94589985"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="94589985"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:05:07 -0700
X-CSE-ConnectionGUID: BBPCFxVpTWKSq7aBv+84uA==
X-CSE-MsgGUID: mn4rLmXtRXCNIgSR9BxEQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="282053809"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:04:58 -0700
Date: Mon, 29 Jun 2026 18:04:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, duje@dujemihanovic.xyz, jic23@kernel.org,
	jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
	joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
	linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com, mike.looijmans@topic.nl,
	nuno.sa@analog.com, robh@kernel.org, sakari.ailus@linux.intel.com,
	wens@kernel.org
Subject: Re: [PATCH v5 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100
 driver
Message-ID: <akKJmHlE5CEQu17g@ashevche-desk.local>
References: <20260628194341.66752-1-jakubszczudlo40@gmail.com>
 <20260628194341.66752-4-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628194341.66752-4-jakubszczudlo40@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 28, 2026 at 09:43:41PM +0200, Jakub Szczudlo wrote:
> Add ADS1110 support that have faster datarate than ADS1100, it also uses
> internal voltage reference of 2.048V for measurement.

Now LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


