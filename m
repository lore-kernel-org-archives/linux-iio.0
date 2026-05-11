Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAAA244661;
	Mon, 11 May 2026 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496319; cv=none; b=Pbq278CN+yfDI+VWBupiFM+EO4oV6zF8WRsdPbo0aMq0MazRyq90mfqqSskWWQMl3O40+8Sx5k/l0r/XgHvJw/GE1ef6Em46+sT4eBljzwysFK6dZcDPxUFQkl7IAwlccjSXFGw/UFCZ8PelyibLQtDS5oa7xqD7Zonls6xP/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496319; c=relaxed/simple;
	bh=UfHcvU7XWllnf+MSFbfmrUZekHiYm/qaHHo2W/8RAc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2ZJ9V9k1LF0oWrOrA7N/DLUylkbPRKHNGyPjSV2Yvpq1J9a4df7c5LYBYVgtk5HI30dRGfCAeoSqFoAjqH0GFZziLOxuE4A/8o90osUaYhAhrZKhxSiXzdXEN4d6ETaPxkv0osljuGoTl3RhpQhhyGY/lX99obEBZqFHf+R8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khhO5pnq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khhO5pnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778496318; x=1810032318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UfHcvU7XWllnf+MSFbfmrUZekHiYm/qaHHo2W/8RAc8=;
  b=khhO5pnqwdZZY8VTS8mZYJ+5p4Xm83qHxdNHmX8y39WkdQVPxZBWrCw1
   DIe0nC2QEKirr5Wi37S6nqLsYjw395WPyPIhxr+ouj3Eoa5ifMR3VDERr
   5zu/gPo33PU9HWt5FvwPyEff4g8WIMK7yXlm3SRV5yjt2JWQtrvKKiWI9
   uIuBXfB+wEP2pt2/8+KSpgGPta0asUcEf3z632pvEDKM6xFJgdxFegKrl
   6GETrORHx1Uj1Xk+PwteNsSXPWRDV5qqsn+zX2Xw8efDMS/sQYuVlZei/
   pwjLz3DTA9PczAjnE69DV3NPakZr6vum7A1Y7JjtYy7YZpVps/iuw0jXS
   g==;
X-CSE-ConnectionGUID: 7yZMPgL9SpS+ZoJwm+j0Jg==
X-CSE-MsgGUID: P0AlxSchQ0qYgM9YMkN0BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79480648"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79480648"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:45:18 -0700
X-CSE-ConnectionGUID: Frobge2QRvaxxi4Vhk0bEg==
X-CSE-MsgGUID: yDYEGd7TThWcGegaaqE4BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="234755313"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:45:15 -0700
Date: Mon, 11 May 2026 13:45:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, tduszyns@gmail.com,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: chemical: sps30: Replace manual locking with
 RAII locking
Message-ID: <agGzOcXJD6uAOB-P@ashevche-desk.local>
References: <20260510212427.358756-2-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510212427.358756-2-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 04:24:28PM -0500, Maxwell Doose wrote:
> Replace manual mutex_lock() and mutex_unlock() calls with the much newer
> guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> modernize the driver, and to increase readability.

> Add new wrapper sps30_do_meas() for cleaner locking, and rename existing
> sps30_do_meas() to __sps30_do_meas() to denote locking requirements.

Ah, I was under impression that this is (unlocked version) is used somewhere
else. Since it's not the case, the wrapper is not needed, just use guard()()
in the original code.

-- 
With Best Regards,
Andy Shevchenko


