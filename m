Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818B2459EA;
	Sun,  8 Feb 2026 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770556790; cv=none; b=joeQ3Dy5Rm0v2NdbQXYNWcnt441aNyobzSAo7B2WobRLi2luXPUWnTBGh4kl1gM3pUyGGAyu9Sm0O5Uu5We3yIoLslaeVfLIChx6UE03fh+qM6GphJef3kbXit69E7TaqbnXJD2aceNDwy/PrcieMdde0Wn/Pt5VEteLQl4pDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770556790; c=relaxed/simple;
	bh=Tj371pu4cAH4gGgRjV1HIlVR0BYUPrvBRS8IOHX+Wbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrPWpYkqnvSD7l6KXvL4WlEiH/VaRys5O54XU/vU7bvfjll+aA/DAptfEWKLVlkgsdAF4xL39y/jorJ1JiW/N3ZYjkb309KjE3mntV6S2MHjTG6u/8CJQTMTWUMIM71iUULGlKn44seqLtkCs9rds9zuZKZJ0ZjauMrjP6Fa98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOfE6Z0U; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOfE6Z0U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770556790; x=1802092790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tj371pu4cAH4gGgRjV1HIlVR0BYUPrvBRS8IOHX+Wbw=;
  b=IOfE6Z0UWdO/SgRExbRCs+xjEBQoyFs2IKNDl5TF9dHYz2rc8uYSYOjF
   6A5uOXE3OCvKNzQARSthGZ9Xx3XLVJz4UMRMEAaBpwD2+Ir5n5sfb6nPq
   UN026aYtl2dGtuY46AP65O7Kx8C7LPY9RTLKRbKiCL+vhsOMn/itvXYMs
   bLOd7c6d1dD5a8REnoa1IxzhV9mECaCIt49+3dklYdLrtp777QN3uFFek
   vYMThDht/Uw2s6WdNqssbioJKf82dzbvbiiGMC34DfDpV41Z43875aXHo
   ui4pXaW2YDklnVtodeTBcVR3NWangnMBw4I0JLAH2HLQ956QlujVpH9wA
   w==;
X-CSE-ConnectionGUID: skQzvR7PSUuE2RkyLUEFDA==
X-CSE-MsgGUID: lxBBZKqESNOJTcWND5G7EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="97148636"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="97148636"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:19:49 -0800
X-CSE-ConnectionGUID: oboy5xueT66BB9yzolEhHw==
X-CSE-MsgGUID: QIhlzshsQH+wpoyUhHF49Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="210771553"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:19:47 -0800
Date: Sun, 8 Feb 2026 15:19:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: magnetometer: bmc150_magn: cleanup mutex usage
 and coding style
Message-ID: <aYiNcWJyCl71FyEa@smile.fi.intel.com>
References: <20260206171814.91064-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206171814.91064-1-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 12:18:14PM -0500, Neel Bullywon wrote:
> Replace manual mutex lock/unlock calls with guard() to simplify error
> 
> handling and reduce goto usage. This ensures RAII-style cleanup where
> 
> the mutex is always released automatically.
> 
> Replace msleep(5) with usleep_range(5000, 6000) to avoid checkpatch
> 
> warnings about short msleep delays.
> 
> Also fix several indentation and line wrapping style issues to verify
> 
> cleanly with checkpatch.

You commit message is interleaved with unneeded blank lines. Something is wrong
on your side.

> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> ---
> Changes in v4:
> - Replace scoped_guard() with guard() to avoid lexical scope issues with goto
>   and return values which caused logic errors in previous versions.
> - Replace msleep(5) with usleep_range(5000, 6000) to avoid checkpatch
>   warning.

No, please, fix checkpatch first, it should suggest fsleep() and that is
what you should use.

> - Fix indentation and line wrapping to cleanliness.
> - Extend guard() usage to all mutex_lock() instances in the driver.

-- 
With Best Regards,
Andy Shevchenko


