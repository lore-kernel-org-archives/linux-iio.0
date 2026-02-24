Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773429AB05;
	Tue, 24 Feb 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927776; cv=none; b=QfLByskDSAYC6HM0D/x6One8kIljQFqoidqL2074+7JBTyKH1F+qrU49Ui2MUrgyOf15iUu5EXq3g6UOitQny/PppeNvb606X2VDnBD7/IDZNaaVs/SnrMR7z1y4gb/QweGDuxbe/4od2x5/cSDnk4+wd46Tu9PsW0wySg0JazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927776; c=relaxed/simple;
	bh=gS8VwVzmyz7jmytW59E61gtI9oiNDKK0TtkEFhwnRlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwxhGs0Md4RxtZW+ViL5Cv3dTOHKCO96uox5TqfW9KG0meGtPzh3NeNU+dZdFTEX6jPYiSkPmzfLERL1b4A6gFE3zKQROCAEcMx3V37DzJREXhuDd77naJ1csCQI68knz6dG9MBLPMb0FIlqqqkj2OPywe3fYpszlQuu7xVlpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVXPt++H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVXPt++H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771927775; x=1803463775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gS8VwVzmyz7jmytW59E61gtI9oiNDKK0TtkEFhwnRlU=;
  b=AVXPt++HFcOuYjqR6NfJXsLL4aoLKyUO/uDzp3DmAUJLWZqKNEOH0f/C
   C6HtDwfA4AozlTUeEIx+GevY+W+ZvOFtizEcVwR8Plxq29cPQXjjlTkUx
   SVTHUBQquIcdTPhlzy0TYG77kX5sZcqDHCvY7Rn1rrbe69rmHaEihXCbU
   8n25mWQG07xkA1do4136xX6aCHJR4c6Zb7uJILFSRKX/ToWk9cmdyMVZ8
   oEfBkAunMZNT0blNZ0z3FHtFf0n1RVxnHU3GI/A+e7FdzIFWoNxp4wYA7
   PbWXBYs6unkN7ui2kVK7tvwBxccZ87oE5EfvtgSKoQ4dasskkBT2qvVCc
   w==;
X-CSE-ConnectionGUID: qaAATscJThW11gc1VQWwQw==
X-CSE-MsgGUID: L3ftYlwiTQiysRF2DLcJKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72841435"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72841435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:09:34 -0800
X-CSE-ConnectionGUID: AmN5aikMTVqw7EJbLQ23aQ==
X-CSE-MsgGUID: JSM86ICQT86FJ17BHUdYZQ==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:09:30 -0800
Date: Tue, 24 Feb 2026 12:09:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 1/5] spi: allow ancillary devices to share parent's
 chip selects
Message-ID: <aZ142CVjMQ8Dypnb@smile.fi.intel.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
 <20260223162110.156746-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223162110.156746-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 06:21:00PM +0200, Antoniu Miclaus wrote:
> When registering an ancillary SPI device, the current code flags a chip
> select conflict with the parent device. This happens because the
> ancillary device intentionally uses one of the parent's chip selects,
> but __spi_add_device() checks against all existing devices including
> the parent.
> 
> Allow this by passing the parent device pointer to __spi_add_device()
> and skipping the conflict check when the existing device is the parent.

Isn't this already applied?

-- 
With Best Regards,
Andy Shevchenko


