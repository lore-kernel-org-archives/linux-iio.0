Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E63369D53;
	Thu, 25 Jun 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397579; cv=none; b=ZisTLpyXh6bt5Q+bOfnZlLKN1yiyHLE7wCBr9N4FZvKtrzTGU4XbpWUd6ibxodRaiDoR/oCX948FHN7GXIQXJck2dnguhLJ9uZSaxeaVNTkbNTfXV74LZ8d5OwUMaBrqhivJfBbOk1JCXyylRrIKJ3tDo2jVxs1QCDFz03/UFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397579; c=relaxed/simple;
	bh=MdJOUd9XRBk5gueeMm83zAfNtSk5cr4pwwC1evGgxrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGikFR0aXBq8cKjTnMUBVD9ecL822bnYktGHgFwLxK/cPCh4TOvFti198cHz6LAgXcvswcZ/eOSQdghK/X/zkdbLcfWeHzgpURA+3+ccIDMo5k3E8Ts0b7+5M0AXDrYIYtPv+yhEEM/kMCqrj67NreV5HoWn8vBFVg9A+Cl7/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0IFLQ2K; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0IFLQ2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782397577; x=1813933577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MdJOUd9XRBk5gueeMm83zAfNtSk5cr4pwwC1evGgxrU=;
  b=k0IFLQ2KcE1QSDxE8l7+0kD6Xct8M7yvsTHpHIFMqJ5aX/AseT9ZdfUl
   hiEeoTuQdizQ14PTjwaEMHgUyKkCvvECLNfQbHAj824SpzYmQC/MJnd5G
   GpbGPaR0H5WPEbXrlMe6EXHPrO1CmZHsMHg60/zR2Sj3N97MvAlYg0OSw
   s8fWODz4t8x4pZUHRCO6GncwiILAQXTxV/bINHNKWzI1fLgFk66xGlcBh
   qbqjQ/2mMNemUTfSp86kFBTzQmMR782hMr6y+bYehY9UlVaIYFfImzjcI
   v+LjqxZYEkoYMl7+rmyM+szL87qS+LSINchMdwxV1ToWBOGmwY9PZ8V4J
   g==;
X-CSE-ConnectionGUID: MgTwFXTsTsG2Qhh0wRtzbw==
X-CSE-MsgGUID: 4ITLQd7VRpazdfyyl+jJXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82159320"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="82159320"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:26:11 -0700
X-CSE-ConnectionGUID: e/rXnuqNT9W16gEz8wYKXg==
X-CSE-MsgGUID: iRloUdDXSDavvfy/dcv9CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="246374725"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:26:10 -0700
Date: Thu, 25 Jun 2026 17:26:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: reorder all driver headers
Message-ID: <aj06fxvDJ2Rc1mmG@ashevche-desk.local>
References: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-0-8b4c8bfa96d7@tdk.com>
 <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-1-8b4c8bfa96d7@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-1-8b4c8bfa96d7@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 02:24:52PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Reorder headers includes following linux rules.

Strictly speaking 'linux rules' should be 'the Linux kernel IIO subsystem
preferences'.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
(haven't I given this?)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


