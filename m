Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C74315F;
	Tue, 18 Aug 2026 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068084; cv=none; b=HMLRSf9shoRVH5vQGAzF/h5Oiadx2FDa+3Yo8PrRJxjadWXQHBsUTfycXAgBFLGamGCLNZPY/1X01vVHYQfvJjm+Pm6l8E9z+i2ytt6hAcJIUSl53tOjIGTAKRZNRSetHVLzI2r9J0CxcjhOEJs3N4A8qEmsU3kd/PYd/YJq2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068084; c=relaxed/simple;
	bh=N/BQhKdqYf39MaSZn6fNscN6ZSryuzsGXDQcDvGIN0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVB7wx9fRCzLIjkZX6+e3VK9gjEsxDo1PmBJ1pE0PjoptodDzH+NrSd9jJePTxxpzspkr7q7kJZgjaOlNmgQSkpZz5Q7bT+RL7BBHM7XSITkCT4idVtRs0Nhij0E+ygcgPiAJY67RT2s/TqQ+XkneEQB3MxMNRRgHzJ2dBOMa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaUm4kKx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaUm4kKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787068082; x=1818604082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N/BQhKdqYf39MaSZn6fNscN6ZSryuzsGXDQcDvGIN0Q=;
  b=UaUm4kKx3Oa8/ldDxh6iP6+8FHs8n5tP5P+DLW2EDpL7OxAlCGAVsZcY
   RWgBJs+NZSr2IFvmMXRUCdRNPUEPndYc0incHhcwwA2f8YqgmnzzGa6gn
   QyJBa9o+Ua7S+ayAxiz/2uRdKPafvFxiS147xlZxDfjZiXQCZDVj2wTcC
   keFdxiCt+DtOLriw6rk81TaTAFjm2kpAgIKHguXg+RHFqbVPxiC6VbqGP
   Cdn1Wn9i+agpV5cjFPAxPuPjIYp+0UItVYQm1dNwNg7io6ydjx9TQ/GyH
   TLL9nXTDfe7a2nkLDvHXMaNntaHBJscEWLsftm0aB2s3hEPsR8vZUGf9D
   A==;
X-CSE-ConnectionGUID: DfC5E0XRSYmGf4V79mYY+w==
X-CSE-MsgGUID: DWyTttKMQ3WjRLTsCFRavQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="99087159"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="99087159"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 08:48:02 -0700
X-CSE-ConnectionGUID: DXXkCPGARmeoiZU5Gf4jfQ==
X-CSE-MsgGUID: 1OiWphrhRRymQdDx/BdDMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="265873854"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 08:47:58 -0700
Date: Tue, 18 Aug 2026 18:47:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, andy@kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Yash Suthar <yashsuthar983@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: accel: bmc150: use guard(mutex) for mutex
 handling
Message-ID: <aoR-rPWNMrqlFv2q@ashevche-desk.local>
References: <aoMrJvd4oSj0HgN4@ashevche-desk.local>
 <20260818154135.3324-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818154135.3324-1-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 04:41:35PM +0100, Gabriel Rondon wrote:
> On Mon, Aug 17, 2026 at 06:39:18PM +0300, Andy Shevchenko wrote:
> > Not directly related to this change, but even in the original code what is
> > protected here by the mutex? data->scan.channels?
> 
> Agreed it is out of scope for this cleanup, so I left the scope unchanged.
> 
> Honest answer: not much that is obvious. data->scan.channels does not need
> it, since the triggered handler is the only writer and the core serializes
> it. The accel one-shot read is already gated with -EBUSY while buffering, so
> bmc150_accel_get_axis cannot race the handler. What is left sharing
> data->mutex and still reachable during capture is the temperature read, the
> bandwidth get/set and scale set, and the event config. But since the handler
> is a single regmap_bulk_read and regmap already serializes the bus, it is not
> clear the driver mutex guards a real invariant here, and it may well be
> vestigial.

> Dropping it is a behavioral change worth its own patch and testing rather
> than something to fold into a lock-syntax cleanup.

Of course! Just made an observation.

> Happy to look into that separately.

If you have HW to test, I would like to see such a change.

-- 
With Best Regards,
Andy Shevchenko


