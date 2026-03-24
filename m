Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4C3EF659;
	Tue, 24 Mar 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355722; cv=none; b=MGhZp70m/jsI5DOR7yKZiFZJRJOWELUtUsRES+OX3eYECG9vWbJYLTc8kGYzAMHznKN8Uorj7V4Q2yzb6g1cjo3NmLmqLNNNLc0AOr20GRkmn3QIRFe9WCQYo+wV7R75kNMV3t0zVQfoomGZ2ogoVxTzJDb6vsSP/aflSfGm1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355722; c=relaxed/simple;
	bh=Orqq225dtHVhqXDTQxvE61lH+wwHZHBDW3+trgitFWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmYvEJ5ZVG7w9+uP0AwV8gTRyVGrlETp2Y/j6zl9X9sao9EHsgoHVb9t2imcZVQ7GeMuNvCFW0DlHkMZuq18CdQLfwyOLSGSxfgmgZTdwtY9/YqSwpdaKYCSWeLmQSkVfJi5nj0Mr6FwCcxjgiKQEaxl/hOooEkhNeKK+zoipIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ns1d0H3d; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ns1d0H3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774355720; x=1805891720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Orqq225dtHVhqXDTQxvE61lH+wwHZHBDW3+trgitFWI=;
  b=Ns1d0H3dQxO0t9SdITRUSseIw5P1BAbbWGIZxxfAvMqOQVklB4h43c8s
   7UEXpS+irWo0mcXpbmLWpRo73rgmgerUD7l4/rqe+Izh2qrC2BekrA3Q2
   GbOilBWxy3p43KOuOyt5G8Sg1OIiHa5Rm08BPsXRCrYOnrkJlDRLrwacF
   WQ4ZHocWj6kQUf66eH753XdS/cO5Orjzm+oChZ14gmjhx46hmaUTVolp9
   b4CwdI/c7UFM4O0Wze/q7zGJoyVGUnxTyfpB32mHS2DXhePuKByzTyboe
   yxumzTfEAV+DVYMHBd1/G0nRGwjlUFkFX4+63GLpuN69rqR4rZ1pMjIue
   A==;
X-CSE-ConnectionGUID: uaKixMJXRsSa8FCYhGbBZw==
X-CSE-MsgGUID: yO9z8NnpQLqhHKvYJiCQlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86739481"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86739481"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:35:20 -0700
X-CSE-ConnectionGUID: SH/VMskHQJ2vKGifA4UeiA==
X-CSE-MsgGUID: RJgKBZ/oTw6AOIMVggWkRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="225984335"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:35:16 -0700
Date: Tue, 24 Mar 2026 14:35:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Carlos Jones Jr <carlosjr.jones@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Beguin <liambeguin@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Jorge Marques <jorge.marques@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: adc: ltc2309: Use i2c_get_match_data() helper
Message-ID: <acKFAmarBKnOpevv@ashevche-desk.local>
References: <20260324071331.842-1-carlosjr.jones@analog.com>
 <20260324071331.842-3-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324071331.842-3-carlosjr.jones@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 03:13:29PM +0800, Carlos Jones Jr wrote:
> Convert the driver to use the i2c_get_match_data() helper function
> for retrieving chip-specific information. This simplifies device
> identification and aligns with modern kernel practices.
> 
> Update both of_device_id and i2c_device_id tables to include
> chip_info data pointers. The device name is now sourced from
> chip_info to ensure proper identification in sysfs.
> 
> No functional changes to existing LTC2309 behavior.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


