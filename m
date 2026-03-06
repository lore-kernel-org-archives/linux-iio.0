Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EAF23D7FF;
	Fri,  6 Mar 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808101; cv=none; b=isaXhs3ewG2PSKsG2g62xXN906cbqyK5MZSEgPfiX9+cS14HKR4l5dyRUn5RBfktdJK6WCgrszObch0w97JGB5c28rVapx4odQ2+o1c/Jq8YtDRIRsYykwWvn8z6RgrKQvZfPFp71kNT/vgBrgExInChTPzNbR8yS68GEXCUtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808101; c=relaxed/simple;
	bh=ecp2vwk/eMK36+Ci1Z/sgAqjUWDXizZfmxjNPy8tqxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdhZwHkm6UTNNu1IKsAHDTus9RHjsI8I1W17kNkHtrBJqftsjgN8wkWIE0BL4IPknccNMlUJhnqs9ndw+Sqm2tIct317AskEakNXno72MSa2JXVbATautUgk8Q48PyeNA830uGmSs5QerSU9jI5hgZYyl9JbT9+tUvDvDW4/j0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7icaMom; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7icaMom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772808100; x=1804344100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ecp2vwk/eMK36+Ci1Z/sgAqjUWDXizZfmxjNPy8tqxg=;
  b=n7icaMomrGsZ63iuPyIebefgGjLJjdG+DRs8+9yM1yOqbhB5fRVn/5Rc
   yrY3m80SBSfOv4gYXRfn/MfZGYdouSTOhMkigRDGFeejJ57V75b/CPgY+
   5Xm4JoTKHTEoTm0QIFvu84yM7zP1NQPjqu3OLEiB8zWx15xjcbXqXmWo0
   Ih5d1ddY2GUyKT5n8QKT8lIpFYTl7crNJgr6em8+f5RVeYg+kclc0OxgR
   xeQFyOBu2RyLSGR202s+bgM6tKmD+aOU9o6ucqPa+U9M/kkHkVLTjNACW
   zksKGYmyAwkQbfb5P4HnRhG9VeKDHyO1TmWe1EwSL8MK0GjbmwagsI9y7
   g==;
X-CSE-ConnectionGUID: ce98nUIxQParfxGVUatzxg==
X-CSE-MsgGUID: ARCeIMf7QCyetmbLRnBm3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73829787"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73829787"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:41:39 -0800
X-CSE-ConnectionGUID: ibYn7lkPRbqygKSDSaNgWg==
X-CSE-MsgGUID: ieBILMtiTVuNGKOJT7/8mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="219013428"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:41:36 -0800
Date: Fri, 6 Mar 2026 16:41:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: frequency: admv4420: add dev variable
Message-ID: <aarnnqtg7e0sMGvS@ashevche-desk.local>
References: <20260306102504.42395-1-antoniu.miclaus@analog.com>
 <20260306102504.42395-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306102504.42395-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 06, 2026 at 12:24:45PM +0200, Antoniu Miclaus wrote:
> Introduce a local struct device variable in admv4420_probe() to
> simplify subsequent conversions and improve code readability.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


