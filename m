Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942681;
	b=upEO7sMpM+Zvt47wCT/XbfQOoiwUOlJMpzOR/ZM2nF40fx5irqFmPaSxZ4V4dLhnMetO
	 BiSuZ7EzRHlhA8cBtbGNgi2FV2jXUyvkL2tQYqrnbIKpJesSvsnBWptzuoQgzLOUgrgwx
	 unniu56Xkb+3hED3mgsmlxAub3iUcIQuJ1e8uZxgD8wCWEq6w9orjzkZD4fm6C1gmwIwt
	 0qxGkvTdUQrDdLaghCLtPH2EsxziwlpO3NcsOjibyqlBRS2d0zbEL/eGzItmA3ORCwc2D
	 /YpIY37J9NcX0hro2oW8t22O8mc7iA3wjZ1BHbgVpkd8BKYSIdvRYTXXiCQPcbze87A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942681;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=650tdgsptHAzjyRc/GlqttIJaxnXGcm/beJZm4uMOIw=;
	b=giRQSeTVNRhord4IYot2AHG28ycJRArCuWSp3GFNKMi0BT7vlWKNFYE5SvTxy3t9rtzF
	 OJ8a+JYVQlvolbqj4tZQvn8IW5omKboVryOYD5UPWmUbG7A9l4XxASCTYrZzR7bt2/C8k
	 xfxRqXXtNPcWJZ6Bk+Eyv3DxHTEFlFY0rTQZsZyNxEGYYsAANPkxVzj9qjE/OOnIOXW5C
	 Z/YYXTCRS87BXhxUKT+QTfNk6Ys3KXDXetQ72S0YJgGi7hvsX4FXjjUYLAQq+lztdiQUV
	 CrppwWjtwHNl/CrRccIaZxDvWeZfGTQ0Cf255H7TyEBDrB6DhkoByEkyFNLND1uc2OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OrKxQvB2;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E29606A31C;
	Tue, 17 Nov 2026 19:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80E29606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OrKxQvB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794942682; x=1826478682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mj+kkoTBoY2jJTI2lPTxEm/3LuhmOKWAq9J/SWCzwsA=;
  b=OrKxQvB2rkzjwFdvJTTcLcVYwohHxQr0javK7VH+VVyEHWvbnNcOUrXg
   bmUcGqY+hxBlmgrZffrR9rDIzpWrQZJvnSaiqKFYbpzJ0c3+ymA+D+Bdj
   y0Lp7fCL7GN4j+La02BW7cESNYSaLpMsj6ROu0qykNQa6ulhB8uu4P+Q0
   rTI8naQEipvvCx9j9FSdmsmi+xPC3RbdQ1oMhApszzPZ+j6JFXaFTQwD4
   xbkVOMxbGWp0ROfE/mzHYS3arpAOcosKHi3A8JJk1yGNT9J0Cpl91YJUs
   MoSqetz3YviHAiKoJ5x+cf1DuSTc0sfSrWVMfWmOa2vO3k6CI6vLmKcgy
   g==;
X-CSE-ConnectionGUID: Fhsmn3CZQrCE/qPKK05GXA==
X-CSE-MsgGUID: +7HeMSCbQSiAAJXeBkDKqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3630025"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3630025"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:11:22 -0800
X-CSE-ConnectionGUID: Gc3c0v/JSbujtj9GOxjUMg==
X-CSE-MsgGUID: mfnzUkDyRQ+GnD4U7mTujQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9854889"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:11:19 -0800
Date: Tue, 17 Nov 2026 21:11:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: proximity: sx9360: fix proximity threshold
 writes
Message-ID: <avym1B5701JzNk9S@ashevche-desk.local>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
 <20261116205320.26070-6-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261116205320.26070-6-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 02:23:13AM +0530, Arnav Kapoor wrote:
> sx9360_read_thresh() reports a PROX_THRESH code r as r for r <= 1 and as
> r * r / 2 otherwise, but sx9360_write_thresh() converts back with
> int_sqrt(2 * val). For odd r the read value is (r * r - 1) / 2, so
> writing back the value that was just read programs r - 1: setting the
> threshold to the value it already has lowers it, for 127 of the 256
> codes (3, 5, 7, ...).
> 
> The int to unsigned int conversion also lets some negative values
> through: 2 * val wraps, so e.g. INT_MIN is written as 0 and values just
> above INT_MIN as small thresholds instead of being rejected.
> 
> Reject negative values and use int_sqrt(2 * val + 1), which picks the
> largest code whose reported threshold does not exceed the requested
> value and makes read_thresh() and write_thresh() inverses of each
> other for all 256 codes.

All the same issues with this patch as the other one with sqrt() operation.

-- 
With Best Regards,
Andy Shevchenko


