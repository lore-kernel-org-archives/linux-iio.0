Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391D34FF76;
	Wed, 29 Apr 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490922; cv=none; b=tETZlVgBEHckafQqLANMHhd4F+eHVmb/fk7ixcao2kxjk+VsxiJeYm4HbWi9Sp7yPtb5LEOB5MtPjVi7a0YEyJ5tr0rCL6UH0sxFvI1ZQxl4Lr97qUKcDE59/KeKVTJsZCWd9JdOVnvb8aK8Y5+1afTsK5/Wu9O5HX4KsifMh7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490922; c=relaxed/simple;
	bh=0Sb+c5ChEg30SjEk6FX6LfOL5dQTrF4e7u83nRe1Oyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz8w9BglahqWpuRmEug7qjs/omtL7f+n2Y4JGR1VwaNIgOSvblIwoXAkwI8FY7/NIbPBu4v5uH+dFGvLTTl6FSvF+bwR/4mFS0j8H6yfoyFPR48neVdttQ+r9zOBqPhcH4BW2ScvaYHkF52H/+Vty7XSCQdUrf8S9k+yT/OBJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5cZjZPf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5cZjZPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777490921; x=1809026921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Sb+c5ChEg30SjEk6FX6LfOL5dQTrF4e7u83nRe1Oyw=;
  b=S5cZjZPfW9Es1uzcxjYIKyvuVwJZCdspSgAfQaXDlFm+HzUxEdMULdcK
   yHnYkKbLWqlVqgl2OAMhwUFaxDVpImcdnz+U9gJB+c7wGgtjKymGwtF0g
   +t/pggrx32/oP0oJVmxrxcabehx7N6u8rrhStjM2C3ecr3A4sVGpfhUMC
   k0eysT6/g1bIdd5JoBUWgl56HRSU0CIOt/vM9pE867idS6BNX0tGxoXAq
   3eLg2vH/f2lEsJPSag3rOj3gaPPXWu/gj4MD/opoVZkkFzZvRSbLvVjRL
   TEl1/9LrV0bnFmGRrDxguECu4XDzmNviJ4HYISn41dUad57U9ApgbgNPC
   w==;
X-CSE-ConnectionGUID: vsXLk7hZQQqGD4gmpRMYwA==
X-CSE-MsgGUID: nM3tXjLFTqKBgP8HJuP9iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="101094900"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="101094900"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:28:41 -0700
X-CSE-ConnectionGUID: BPM4te11RUqcm0yYqKGoXw==
X-CSE-MsgGUID: U+Z6Ir3KQ1aMCOwSS/3EgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="236134304"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:28:39 -0700
Date: Wed, 29 Apr 2026 22:28:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] iio: light: si1133: driver cleanup
Message-ID: <afJb5P5njuUkUPwS@ashevche-desk.local>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 05:04:48PM +0200, Joshua Crofts via B4 Relay wrote:
> This series deals with the cleanup and modernization of the Silicon
> Labs SI1133 UV/Ambient light sensor.
> 
> What seemed like a simple checkpatch cleanup turned out to be more
> complex, therefore I've ended up doing a patch series instead.

In general LGTM, but there are several nit-picks that needs to be addressed,
I hope the v4 will be final.

-- 
With Best Regards,
Andy Shevchenko


