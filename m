Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79839658A;
	Wed, 29 Apr 2026 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446297; cv=none; b=mpoVH8xXRaEo7kAAdIIlsAlpQDD2dyQqVyCHzSWRNWlrlWHfd/BVYOs63Jj/FFqTbome2cqP9iPXML7rlsj5APThQpYdvMNLMC3TwMn9WcD3H64aoGJOWre39slz5EkGJsRodnU75Aq6iTgb6cfLUOqZ2O1YimG9JbjepUR1VNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446297; c=relaxed/simple;
	bh=joNOFZMGUyc2VC/2Op7s9fXjMC6ObUSRPIpG02ytPNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+fTuRddusStQustkC/Xp5ixw9eLD2TA7/8+2XnXSHxml9TzJNhSplyvp4Ka3ntFFjQJ9vn5dC6SJURaJcEh1df00bFTyG1UrVnQZZwU+7UFmkt1s6mak3Dl1pUWMcI5hyrP7OEGVBJIPk1xoXrntAsEfhygY+kDNrKPJ1tphSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QP0K1ijc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QP0K1ijc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777446294; x=1808982294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=joNOFZMGUyc2VC/2Op7s9fXjMC6ObUSRPIpG02ytPNY=;
  b=QP0K1ijceFDNo7u8zMQXIM8fRivb8NOyN6/y3BQADWwQMGCbYzGtaM/e
   Y81jU00SMbBlr3cSd1ejg87qZmaQ1MJK3FMSbazDKEvaq2j+qNWq4bumA
   KG5rDimNuQ0hVVNF9WYEYGpnFFgUJ4aX4IweIRR3iFgu5sWmOgRh6Skx2
   +DzE1y3VklglGAimHUPSjQZcDasHDyZUyH9pHpfFS7JIG6sMo5V9LGefI
   kOXuTuEUYI4xe0LBFl9Pvl7ggQR/1HpWt4UKDrOLiwzbWdXkSYQ++TA2I
   b46Z3e8FI96Xz7hcPeercgFumxdlNkRxBuMS8e1V5wQblGmODl/ApwW8A
   g==;
X-CSE-ConnectionGUID: oz5FlM6pRBec6CuMYQ1lZQ==
X-CSE-MsgGUID: Q+lvX8Z5QU6Xx2MK/csLSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="80941708"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="80941708"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:04:52 -0700
X-CSE-ConnectionGUID: LJIoM5GeSSKyzzjLwvAqvw==
X-CSE-MsgGUID: W99ZqTpFTwSi7/AVidOHNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="233325420"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:04:50 -0700
Date: Wed, 29 Apr 2026 10:04:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Felix Gu <ustc.gu@gmail.com>, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: free scan_mask on buffer
 release
Message-ID: <afGtkEBzGzpqB8cc@ashevche-desk.local>
References: <20260427-iio_buf-v1-1-2bbdac844647@gmail.com>
 <20260428182858.7d7e1034@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428182858.7d7e1034@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 06:28:58PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Apr 2026 19:11:39 +0800
> Felix Gu <ustc.gu@gmail.com> wrote:
> 
> > The scan_mask lifetime changed in commit 9a2e1233d38c ("iio: buffer:
> > hw-consumer: remove redundant scan_mask flexible array").
> > 
> > Before that change, the scan mask storage was embedded in struct
> > hw_consumer_buffer, so iio_hw_buf_release() could free the whole
> > allocation with a single kfree(hw_buf).
> 
> > That commit moved the scan mask to a separate bitmap_zalloc() allocation
> 
> > stored in buffer.scan_mask, but left iio_hw_buf_release() unchanged.
> 
> Hmm. This reuse of a pointer that is otherwise set via very different
> paths sent me down a wild goose chase.
> 
> Patch seems fine, but I'd like Nuno to take a quick look before I pick it up.

Yeah, more eyeballs is better here. I spent like an hour to understand
mysterious ways of scan_mask in IIO (we have a few of them and we have a few
objects based on struct iio_buffer), and we have constructors/destructors for
those objects which of that is responsible to handle scan_mask as appropriate.

May be all of this is documented somewhere?.. Dunno.

> > Free the scan mask in iio_hw_buf_release() before freeing the buffer
> > wrapper.

-- 
With Best Regards,
Andy Shevchenko


