Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C9271456;
	Mon, 27 Apr 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303162; cv=none; b=P8dtV5plVd8mGt2K0yD0uLxMs4FE6h0nZY330ME/f/1nKKmYu0JKhEF1BwKrJ+304CPvePbhPgAIq0Bo+8ADsdpe49ca/Aq6tjbT4y2+tNilLa6kcwGHxqryM0y7T7NvcLE8qz+eYKDI0iXKQY6N5WKM3AirQQhNei5Ab/M+rvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303162; c=relaxed/simple;
	bh=cLE65+QQjwPtWCb7XeUGBdqHXN/IjEZxph6W/ahHkng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1+0O0e4fTGPLxsX+d/DrTwjT6JULKpS4N7oM+ttU3QQWIYLptQvc3/aM037MJ1CLBheuXmHy1fwukHW+rNPWFAsspgtm0+UV4rcoYFii5qLG8qzizNec667pHJtcNfvp2zM2wL+6TgVcalzuMSbNOXuTgpnNPl1xkQG3o3zs+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1XOiBTU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1XOiBTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303161; x=1808839161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cLE65+QQjwPtWCb7XeUGBdqHXN/IjEZxph6W/ahHkng=;
  b=f1XOiBTU74GeWpElbxbNJ8CIgYVMJGi161rNpQK5BRDxDmrWo0aQPfEO
   FVmpvqzZ3UC0n9Mov8zyHG+A/i0+pEZpLc/yK8JW9WJ1HBby1yb/K8Duo
   iXnFS++oAsqAQac4UKaXf5rYUm3U9B9sdmGUNPBTrrs1nTn/DWXyYu5Qo
   jxP1ocyypXSzzRyIupbB09p5c57vMIDPIYfkJmN5jdKsfnketiEC9/LP7
   3+eoMkzUMSsAKgZIIdpUhkl8CmlW6dsjVixL3Gs1I2pC8xp/UBXcX3oPF
   sD0tOE9T3YOjTH9irmYQKb7O+mWRIjz4HK9OWQIT5txnqqfzjgJv+aVwH
   g==;
X-CSE-ConnectionGUID: A767cguzQU6YGFmICJ/sKg==
X-CSE-MsgGUID: c5NTZyY0Sv2350orcAAD+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89572928"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="89572928"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:19:21 -0700
X-CSE-ConnectionGUID: 2kgvHKFZR5iUXTMYtUEZWg==
X-CSE-MsgGUID: QcIvNGV5Tu+wVc1afIOVVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="233546202"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:19:19 -0700
Date: Mon, 27 Apr 2026 18:19:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: free scan_mask on buffer
 release
Message-ID: <ae9-dKwgpamQwSCq@ashevche-desk.local>
References: <20260427-iio_buf-v1-1-2bbdac844647@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-iio_buf-v1-1-2bbdac844647@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 07:11:39PM +0800, Felix Gu wrote:
> The scan_mask lifetime changed in commit 9a2e1233d38c ("iio: buffer:
> hw-consumer: remove redundant scan_mask flexible array").
> 
> Before that change, the scan mask storage was embedded in struct
> hw_consumer_buffer, so iio_hw_buf_release() could free the whole
> allocation with a single kfree(hw_buf).
> 
> That commit moved the scan mask to a separate bitmap_zalloc() allocation
> stored in buffer.scan_mask, but left iio_hw_buf_release() unchanged.
> 
> Free the scan mask in iio_hw_buf_release() before freeing the buffer
> wrapper.

Good catch!

Seems that struct iio_buffer is a foundation class that is used in several
objects and hence each of them is responsible to allocate/free scan_mask
(and others, if required). That's why it's easy to forget to clean up that
properly. I was thinking of a common ground to have that being done in one
place, but it seems unfeasible.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


