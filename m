Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44021357D06;
	Wed, 13 May 2026 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677823; cv=none; b=fssVysibtcsoOdzfRmYY5WauayLBI2nBIW4a+4YGgm+JB6El0u/Zj2l2gzIl8dCki3ZNczRAoupx+GWK9pTA7qKlpIVK60GjEoAWWox9c3S0zyoN9mwRSX/SFYXZrZmFpXrtmKgBdbzDy2a4OKNCu13OkNgKuuqaTueP/BrY1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677823; c=relaxed/simple;
	bh=elgcsr0kSQ/qc8O4yy96lZ4EUvbhrxaKAo9VcZlCUAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDNeybMt4H1JbXoWcB+XGG2YXycm/n6aIJ/qeC8m5gOPx/eQvp2BEFviHd8Moxj9SXsnXeirPIiWj3spH0NqUiSNqAorWo3VgRuQWWOJO3twSg+d8kvKRV436BAizHTi9JSnR2gnoghDNJwsgTxQPlcXw9htyvwdADtcA6H+B5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULyxo831; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULyxo831"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778677821; x=1810213821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=elgcsr0kSQ/qc8O4yy96lZ4EUvbhrxaKAo9VcZlCUAE=;
  b=ULyxo8312yNYXO3aIHO1VkKnsJeAQG85MsaUxLDjvaUaPf59k+kBzfN2
   SmkczkwtIWNIH1VkDe2RLhryXguvCI3gDyv8o9M4YzrunSIeklRmSH3WK
   apfsYmebRCf74m2479fxD793Dre3GZWVhaGcecXXj+zXo9Prfc3DaRvPu
   EF9PXLo5J+6IfhdbaYtomDTh5GVJwOFYKew/pLyBORyH0Kxb0ZOM4wJp2
   BCsHtjqRKxjKg+21LG1P5nsQUUZH2wI8JyzGut95GJ6y49xS9cK2z4QkR
   T9CmIbh+kLpMxXev5rxtlUghai5/I/u1KUmXEJlf8kIJmcyF/6Qadt1a+
   w==;
X-CSE-ConnectionGUID: 0mYJ4AtRTv283PRsosjxjg==
X-CSE-MsgGUID: /026d3I6RFuubFoOMd6X+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105063606"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="105063606"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 06:10:21 -0700
X-CSE-ConnectionGUID: 8TIf2J16Q728FR1OyNT/dg==
X-CSE-MsgGUID: R1k4akFtR0+RPTjBKLWwFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="261585941"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 06:10:19 -0700
Date: Wed, 13 May 2026 16:10:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] iio: imu: kmx61: Use guard(mutex)() over manual
 locking
Message-ID: <agR4OExvzbhCNsjk@ashevche-desk.local>
References: <20260513020654.168071-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513020654.168071-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 09:06:54PM -0500, Maxwell Doose wrote:
> Include linux/cleanup.h to take advantage of new macros.
> 
> Replace manual mutex_lock() and mutex_unlock() calls across the file
> with guard(mutex)() and scoped_guard() where appropriate to simplify
> error paths and eliminate manual locking calls.
> 
> Add new helper function kmx61_read_for_each_active_channel() to mitigate
> certain style issues and to prevent notifying that the IRQ is finished
> whilst holding the lock.
> 
> Update certain returns, and add default case to return -EINVAL in
> kmx61_read_raw().
> 
> Remove now-redundant gotos and ret variables, as the new RAII macros
> make them unneeded.

Have you used --histogram algo when prepared patch? Please, do it, if
not yet. It might improve the diff itself and hence makes reviewers a bit
more happier.

-- 
With Best Regards,
Andy Shevchenko


