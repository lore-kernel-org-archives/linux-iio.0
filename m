Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD85341654;
	Fri, 20 Feb 2026 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585512; cv=none; b=EooBxhwb59Gmk9Yuv7e6lZyBhbdk/VLffI4PV+HzVUuWoKPnfcNcc3UvXjKwBPA7c+bP/GM6e39THQeS9/Is5QL1h8c2GvcP9Bkcl8A7ZGc7jplyhTy/iQS7FY/ydkt/2FjTpxv1xetpPPoWtR2ns6B6APwTayZOqpcofxWXHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585512; c=relaxed/simple;
	bh=CJvh3c65/vnvwWbY4d5rHHjRzVOL+joh43OL8JXb/OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqcqRDrP5VSPm9W9ZXsDtxLr62D3RNt/C3MJwEbsBxf31DKnljry7B2X/oVGprvlNCcOK/fILAXawlesfSC2glJR708HxY/g0WQw0i04ae27UqoRzwp0rRAybXQJ8wiZsy+1rqPiO3YJxkbBsgDaBpDeCnpAlwaGpmljWi6aDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSiAX+Bv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSiAX+Bv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771585510; x=1803121510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CJvh3c65/vnvwWbY4d5rHHjRzVOL+joh43OL8JXb/OY=;
  b=jSiAX+BvLVuZluuqzObnKDpqgxVTcIU68yjLR669Kkb31Aevj3H8R+TC
   EQmi3EIL5UZq9NgwJTgtK1a9QDHlsZ60plxqpz7xJ5Qm6D+OgEEjcQ9vX
   JG5v51VGb2tfXDIEHpEaFHKQTL0BDCrGllxH3TEDNnW3D5fwMbMq3yOX2
   vw7qzxKmZ+qeiiVYq9/dOn8MrDVbsH8bkbZhk9dpNUizd5AQyTIQlLQQ7
   n69WWDtXOGhoR9OmCkXEK+L/aPVF/0RZ/5gZ6J+x2Xhs0c2KUXim9RyzV
   fAwQ7K2RXu3vg/j9rE9fwNKYyIpa5DtouOmUz1ks+GH4YSayEvnYNuheP
   w==;
X-CSE-ConnectionGUID: q7QFQxU1Qs61F9qsFvwqmQ==
X-CSE-MsgGUID: D0fY6uEiR+Gj1tErSrbqvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72853509"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72853509"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 03:05:10 -0800
X-CSE-ConnectionGUID: tIMLGw3uSFu5q/5CMbs3Kg==
X-CSE-MsgGUID: dtt+2mBsQzSiR3QZPdsw/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="219369995"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 03:05:06 -0800
Date: Fri, 20 Feb 2026 13:05:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Revert "properly check
 spi_get_device_match_data()"
Message-ID: <aZg_4KQ6hDqBeSJw@smile.fi.intel.com>
References: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
 <aebc2f13040d97e6e3b9797d3fa580198125e3f5.camel@gmail.com>
 <aZSD-3WIVwT6XYWX@smile.fi.intel.com>
 <a823c9b72fcc3b1d88ff9dd93580be6241826153.camel@gmail.com>
 <aZWI-80-K7xfuEBY@smile.fi.intel.com>
 <20260218095820.00005750@huawei.com>
 <20260220105507.30a2f7ec@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220105507.30a2f7ec@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 10:55:07AM +0000, Jonathan Cameron wrote:
> On Wed, 18 Feb 2026 09:58:20 +0000
> Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

...

> Applied.  I also added a link tag to this thread, to say we had
> agreed to make it policy in IIO to not have these checks.

Thanks!

Do we still need a process/maintainer-iio.rst?

-- 
With Best Regards,
Andy Shevchenko


