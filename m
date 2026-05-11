Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36993D3D01;
	Mon, 11 May 2026 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496034; cv=none; b=nk2nvoRwzk6WK00a0dE2gHDrDItsNpr+5bz3eiZAeo3R7elnme3nl7qbYUXVdpIKEZaYClO9v71egtwmL2uhegwaFpEN3iFN1jTv14NEX2xkGMpmK5sKlyBcS53GzPbuPPdTCGF0EuUcqj0w0wl5ys5Grd8KQWq/Y2Kqdsrnzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496034; c=relaxed/simple;
	bh=juOoU1chQ/g5f1x/cZCFOXz3+SyCSJLK2T17/dvFYtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJJl0NSBaKBYw/5SQjSGJBGAre6bMoGWNTT3T159RaWXV3S0eQdi00AcatvVhIvRbku/bfUbzCoyEU9DcbgIPnhObuISoFHBMAAEksxxoEwM9kw73vYT6WMutBQqk81XmI4tuhL2E85KCqK2j1L2X7Cumv5U3Mudma1OjZkak0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4HUktnH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4HUktnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778496032; x=1810032032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=juOoU1chQ/g5f1x/cZCFOXz3+SyCSJLK2T17/dvFYtA=;
  b=W4HUktnHuN5SnKd80l0YGQV+ysRhCitXzpbxCWj8kZ0GZfGgBIL06l4C
   uXGclazbsMnNykdCE1gs4E5EWWMZCRM0Oed1XAmzonQ5vRmQ4dixEIEfo
   LgmplThVXPdbaEJ8RQd0mdbuv6fdGZtd471hsONvZJbZJaKzjHNNqYeno
   1GHwfwTl09cDbQ7aLap2RZreIJxdA2kx2LrlzBkk9t6nqu1lBZAakL98M
   eGj2hVWP6rcgH4SxcZI9HRMce3eRAu4Ef99dsGe6nnj/otgDzZEQZUwEf
   wYzgAHQC4/iQJjEuFbIk+sP7el42FMRvgvfGbz9aseUkWkT5ziyDXJs3p
   g==;
X-CSE-ConnectionGUID: 7ouLlmqgTG+k+1NKIPfdUg==
X-CSE-MsgGUID: GNVSuCapRoes3US8RplRTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81943339"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="81943339"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:40:31 -0700
X-CSE-ConnectionGUID: /LSQqKqYSluvRXxrnH7yxw==
X-CSE-MsgGUID: ld6ogDTkRvyeU7dJYSKTug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="241393634"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:40:29 -0700
Date: Mon, 11 May 2026 13:40:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7766: Update to use
 iio_push_to_buffers_with_ts()
Message-ID: <agGyGgI6vlINm-V8@ashevche-desk.local>
References: <20260510221404.22834-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510221404.22834-1-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 05:14:04PM -0500, Ethan Tidmore wrote:
> The old ABI function iio_push_to_buffers_with_timestamp() is no longer
> preferred due to it being inherently unsafe.
> 
> Update to the current standard iio_push_to_buffers_with_ts().

Nice, but there is nothing about correctness of the change. This is quite
sensitive area which is ABI. Any breakage is a big deal. Have you studied
the case deeper? What are the contents of the buffers with the old one and
new one versus channels enabled? Is timestamp located in the same offset
in both cases?

-- 
With Best Regards,
Andy Shevchenko


