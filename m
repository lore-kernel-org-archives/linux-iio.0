Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887903B9DAF;
	Fri, 20 Mar 2026 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018223; cv=none; b=hjwTlCRXSj9/CedY1AgoXiXh4xH6f/QDgS5WwHZK+6xyHq52DI6GExUYSGIOpZvu1xOFO6OmXywyJ7kBHLs7C7PbF6TvchmOEXdT8VaUMDtn3faw/WX873T+nakK3lOvlqp6I3dGxh7gOpL50RbJq8V9fBx/HGt48vjlNhHO/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018223; c=relaxed/simple;
	bh=xK3qG/TLGU2GFNXvpT85sAxbQaQWkuukTLryj8aLIWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRq7F08M+gaIvT/+75ixMqL59pHKGxsz0KVDJXTbsWf4SGTrDrkv0ukB0fPLOPK2OlxvZgkv1k6eRLb297P6gB8T/uWEkxHNXVy3SdwJ0Q9ZJ5klXSnajGqU0uXHgt+nP/CllT1P7zK9FtOiPRHmz1LWu0Qc3BdasFLwzjrD/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yjh45Y1e; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yjh45Y1e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774018222; x=1805554222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xK3qG/TLGU2GFNXvpT85sAxbQaQWkuukTLryj8aLIWU=;
  b=Yjh45Y1eHrdoEG7iitHckx5Mhz+qaOmrHF8Sq5SjykzIEBqQ5HsuYO+x
   g/Iq+MaSJyXtoi3oTWfXDoqgbKxJPRxWyWOy49AyRV3BAigQibILslTMj
   CihQrroxVWSdKB0GJKfVlbkuvr63O1ML0JwSsWHv0hfq8ybhKQGM8MGWO
   0NgoBxVxVZD1sus9aa6IKy1bKF9QTt90O646aJ/jrwl4OCKhfe2wqJonJ
   KSvlEevYNIQvCS7pXkcuGBx5BzeXS3zqFD1xebi6Icn4AixEXdELwKNu+
   JWgRooDe5asqdj1w99a75JEzAWl9oCQPSgFo9HOW5KTAM4OzvpUd6gMKr
   A==;
X-CSE-ConnectionGUID: vSJaRCIYQHWdtWtJEJnEzg==
X-CSE-MsgGUID: RhJp+8y2RViqDvh8GhFU4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86578978"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86578978"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:50:22 -0700
X-CSE-ConnectionGUID: 5DxZA+XdRlSLDN4qW92YfQ==
X-CSE-MsgGUID: R6+ETSCJRWWp40eYmYWGog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222399229"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:50:19 -0700
Date: Fri, 20 Mar 2026 16:50:16 +0200
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
Subject: Re: [PATCH 0/3] Add support for LTC2305
Message-ID: <ab1eqIXaav4sVucJ@ashevche-desk.local>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320140819.191700-1-carlosjr.jones@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 10:08:16PM +0800, Carlos Jones Jr wrote:
> The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
> compatible with the LTC2309 (which has 8 channels).
> 
> This patch adds support for the LTC2305 by introducing a chip_info
> structure to handle the different channel configurations between the two
> variants. The LTC2305 exposes 2 single-ended channels and 2 differential
> combinations.
> 
> Also updates the device tree bindings to include the lltc,ltc2305
> compatible string and documents it in the Kconfig.

There is nothing bad with the series, but hey, ADI, again telling you, deploy
the internal Wiki and put there most of the typical problems with the code
submitted by ADI! This series could be done just in one round, if you do this
and prevent wasting reviewers' time!


-- 
With Best Regards,
Andy Shevchenko


