Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB692C21EA;
	Tue,  3 Feb 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112564; cv=none; b=cKQ4LplJWuYG/aUead2sPOPWOqLTx16dhjo7THtBdWcNX+3yFQB5+s1seSsZk/s6s92JkYDNa8CDCVSJE2P/iOzXX4TMN67ynJtRQkxT3vI9qGpYKN78ktE51Uz8X/vt9RDrBQHW93ekcFESVDLehSNHxr/UMdoHKstOI+CiDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112564; c=relaxed/simple;
	bh=LoKJCNr9bQkE0PaWz3bXP6qu71p3NwwS3q1jbcRoInA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dN6bY7M8Dk1JphOYPLjzncB4jA1YRaMkhyu46vPj1OVIBJDzgmBTKY30KrrqzhR0L0iOAZDpUO7TdH3gy9El+44m3cfJKIWn9MUkXp9p2keJUN0uu5Q3kXeC11ZY6G0qOPEQYM3k+hWJtykqt/rkOWaJ7UyEUnAWMTLllb4aGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLrZwVMC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLrZwVMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770112563; x=1801648563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LoKJCNr9bQkE0PaWz3bXP6qu71p3NwwS3q1jbcRoInA=;
  b=ZLrZwVMCRM4ED950kebZQzjhsovhJSsQfgSNu73P2F5/m6EGML6vv2sl
   lExoAEi1ZH/XYAEKeeSHG7AYoytqxbmqp8OLD6vjGAclMZRraOSvpzLxL
   ZYHqNOTn0+JTrUwdGwlw0b0y87Ao0oMVu05sTRbs2VILzqG7UFnK77Q0O
   VDRrxaewrcnYdyf9DYGW+guF65smqb8gKmwjAHujcm8AXrbXPgOD6NYO+
   8AY4CQCTVMSqsRNl3HRv6l3j04O6SOQYsM1u5nX0erAmwGuAA3R6uzYGq
   uhjm9X460Te20IgInc6Upc+ixKCZvlv7qqQ+xdngyEy+9FeMOdcxERpdO
   w==;
X-CSE-ConnectionGUID: 9R98pduJQQywrmYjyOBjpQ==
X-CSE-MsgGUID: SAxCEqktR6uzuB1WDk9twg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71442271"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71442271"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:56:02 -0800
X-CSE-ConnectionGUID: FPy37RvSRSuBS3QAiYVkZQ==
X-CSE-MsgGUID: Y22YufrMSnOY0mwkZ8kn9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209587105"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:55:59 -0800
Date: Tue, 3 Feb 2026 11:55:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 05/13] iio: dac: ds4424: rename iio_info struct to
 avoid ambiguity
Message-ID: <aYHGLeHndgJiD8zV@smile.fi.intel.com>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203093434.2548978-6-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 10:34:25AM +0100, Oleksij Rempel wrote:
> Rename the static `ds4424_info` structure to `ds4424_iio_info`.
> 
> The previous name was generic and could be confused with chip-specific
> data structures (like the upcoming `ds4424_chip_info`). The new name
> explicitly indicates that this structure holds the IIO framework
> callbacks.

OK,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


