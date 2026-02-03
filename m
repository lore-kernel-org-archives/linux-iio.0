Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF22853EE;
	Tue,  3 Feb 2026 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132218; cv=none; b=rTbkKJ/EKc0J3d8OjSjav5W73BcvfhMn2pl2rj7XJw8y9tEJZFFo9Axrg5+uTWImULtieFVuKz/L/6h3E31jPOC+1DsfEIAtSZQMLrQh6qJWrQB+zloZI7jOkjmB5HcEBD96VTBW3yeTKO83x06Jkcj1LxLALTTkdFC1jZShVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132218; c=relaxed/simple;
	bh=yheFF2zcPeHF3xBsWsypbyfcaFIjy9D37ra/eO9nUZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj1tsjuO6peAkzbU/v6Q2iqlQpPpJgrQWHjtBlU5y/y7t64q4xt4C3WR3Xp63HXj6eqaZh96sLGo44L7mqINmgaTW0IHAO4y5fX+++xF52WyfaUpCFMv0Zop5ocL6xJ4J0BsGsbha1XhTRBjDa7KjiOjyUrjwS4oZiRe1DMcnvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOBSHkmr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOBSHkmr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770132218; x=1801668218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yheFF2zcPeHF3xBsWsypbyfcaFIjy9D37ra/eO9nUZ4=;
  b=SOBSHkmrrK6xyEaFD1ZzwTssenQ8YDNgHDdWTX4rYUjZL9D3fiVZcaLW
   ujMoMtz54hArjU6He9mnyCJplKWL1p0/xw6bFDD2ajr7X8KMWuZMHiZH6
   SWdpyGRrcLuVa8siw0VEbAh3+dG200boUMv/FKtg5QVJZSlrV0ehy7oha
   z5OoDOWSo2yTtVmy03Lv+yYRKrC5uu4CEkyCpIda0lZedxDQrJRdjK8tY
   vyWw9YIjTsaSvBL/TDJo5irau/ljGa5GL0Lk/nBjQKDjSXlEC4oBgOGt6
   17sjYQWUz2q83Ukr7yiO+bpOg2BvlauXxCZrKh7xQtcwl04BJwD+pvvIC
   Q==;
X-CSE-ConnectionGUID: U3hSuwVfQsOI3KM2sOPC/A==
X-CSE-MsgGUID: 5MTtLHUQSKGSCSzceiQLFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82677067"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="82677067"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:23:37 -0800
X-CSE-ConnectionGUID: 1Xr36rZzQ0G4DosLqW/Xbw==
X-CSE-MsgGUID: iMETOh0ISgaLc30VyvRdKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209994056"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:23:34 -0800
Date: Tue, 3 Feb 2026 17:23:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com, David Lechner <dlechner@baylibe.com>
Subject: Re: [PATCH v3 next 5/6] iio: sca3000: manage device registration
 with devm helper
Message-ID: <aYIS9E8vI_xeIst0@smile.fi.intel.com>
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
 <20260203122109.689669-6-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203122109.689669-6-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 04:20:49AM -0800, Harshit Mogalapalli wrote:
> Convert the iio registration to use devm_* helpers so the probe no
> longer needs a separate cleanup path and remove callback can also drop
> the unregister. After this there is no need for having a remove
> callback, so remote it.
> 
> No functional change intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


