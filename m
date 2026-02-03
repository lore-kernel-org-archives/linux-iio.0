Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7683081DF;
	Tue,  3 Feb 2026 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118762; cv=none; b=mfR7Oa+bvCHWtt7HimhaiPyUY2VkRqYUMJfRvklgag8xzDHtSwBsqc1u1JKa1tEMF0AdXa07htpyw2A/UbWqsGbiPqrpfczBFhkM0i0Vrocbse+5aj079T1IbhZpAZDrSXIw5YTb6x+DbUuKb7vCNTq7498E4dwUJ32ZF4yUmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118762; c=relaxed/simple;
	bh=kYkZDtFWseFUYLDT0PVkq7osWeIPZWysyP0Ym67x4+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZzjptuntJFmQV6kC9kuVJiSOG62HrtjPpaIM8NMYS3xRiZZ3j7sv+CZo5NG3ktVKdOGaIfrATPD8KwIJwhsf4qaSBj9dBNeli3IWsOsr+U2jcfz/sIj3we1gDW0poKrB18iE+EZZtDsfs37M2R1kYxyGwMn1r7f9roD+6v8smA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PV4wZ2p4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PV4wZ2p4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770118761; x=1801654761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kYkZDtFWseFUYLDT0PVkq7osWeIPZWysyP0Ym67x4+s=;
  b=PV4wZ2p47iSf2+1dcpXY8rD8Ypp7eh1sUmzLPQdNGApbPX2v+BL/kkWr
   BTgmLE7k7ac6IyOhsvyHurzjVtrJnz/ADDxznriIO60rNwVjIKFstd/bW
   OTphDs6FTE+50fdgIw7Dz/cXj99JaiAWqvQOrpxYt1ti+rsfgVYnxd5+E
   UgtJR6Xr2CaM9dAPUqYL/c1vJilIxD7WM4V+lFxYRgFuan8w+imrWKe/S
   yLItiYfmfAuvr5rRmEj9pNz0B1tsl7xOkYzeI/a29ByC7jRY91q7Ig9wC
   Sb1BUBhFVeaDE1HJoh+muV/HiKPYjuxgB4ygj/CQH3UjAXhPpq7LHF0rB
   w==;
X-CSE-ConnectionGUID: dRpcbgusS3equOrv9ANg1g==
X-CSE-MsgGUID: rB4feGS0Q52CiF2zQiGK8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88709299"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="88709299"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:39:20 -0800
X-CSE-ConnectionGUID: MKMNFpznQUWjJyV7zYhSJg==
X-CSE-MsgGUID: 9sftFxEKRE6N6iajhmFzRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="240495758"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:39:17 -0800
Date: Tue, 3 Feb 2026 13:39:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: imu: lsm6dsx: Support SMOCF05 ACPI ID
Message-ID: <aYHeY7efMRwSnPtL@smile.fi.intel.com>
References: <20260201225450.1649001-2-samuel@dionne-riel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201225450.1649001-2-samuel@dionne-riel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 01, 2026 at 05:54:48PM -0500, Samuel Dionne-Riel wrote:
> This patch set adds the alternative identifier for the LSM6DS3TR-C,
> just like the windows driver allows.

> (For brevity, the methodology and DSDT fragment are not repeated from
> the first version's cover letter of these changes.)

...which is needed for further discussions and in the formal commit message of
the respective patch (in some short form).

> I have not made any change related to Andy Shevchenko's comments, other
> than the cleanup, as I am lacking the context to understand what would
> need to be done.

The worry is about having SLA0 and SLG0 methods for mounting. Even if it's
the same device (like here) it might be better still to map the proper method
to the respective device. Id est if device is Gyroscope, use SLG0, if an
Accelerometer, use SLA0. Or did I misread the DSDT and this can't be achieved?

> I am still sending this v2, not ignoring the request, but to at least
> progress getting the device in a working state.

-- 
With Best Regards,
Andy Shevchenko


