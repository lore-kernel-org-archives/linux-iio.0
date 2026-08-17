Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA0427FB2;
	Mon, 17 Aug 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979968; cv=none; b=RFUM19P7DdLEaahjEoa7dMVljI9AzkhXRvIXuCxdAsUI2SPLaw3OwYttyIgRswu/jCz2KHqu7gXx5yF2OpdplCRxYoF/SWYGeaJUZwqr2e+NewXBg6oyrmaBaW1nBwJRlcNnP2xgu9bx+IwVPPp2oVbSlItNBEitpluo72JEc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979968; c=relaxed/simple;
	bh=VR4GAbvS2jfQk/i/Pv4y8xYGhLutQ87KrACcE/Af4SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU86z9cs4dejWZhjy4jjjUPxysWO3FTHszO1JgNizifJl4qmoumMYCAEjg6E6lkDVDfPIdWy+X+Qe84YT0WX82rfTzhv4li6vSMnp9VmPrqRQ0Uog6WGE9plfym/Kv+TlIhhINSHFNMAHivplpvw832NMDlR0P5Hh4OV7OJ+sf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZSFdVSs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZSFdVSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786979962; x=1818515962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VR4GAbvS2jfQk/i/Pv4y8xYGhLutQ87KrACcE/Af4SA=;
  b=ZZSFdVSs0wt9ihUBfnnlqcQT+slUkq0saPONf81pbTxQAXV2VE3FIfvf
   PU0zU/AGxYi4/9F3eHsr+YvFirNfRVM0jaQvea3y44oo7vPhUl0QZNXHs
   AsEucSjAjC2A5eJT2Uppa27Wr3e0XMnKCV621i/6/1wyNNjkNn4MpbiR/
   KKBDYAAFsJjv5zok7gR2SC9s3nl4gTe6SjGurwRcxJB9PPBZdWLsVNkLH
   y5uoz7H2uo2KfLIjIhQPGlcnZ6WG9utrMctFn3zXKAb0SM1ZYJ1E/iaWk
   RGMBtJK8Rxcsv8icyy9V5sb1BA3Nj/3S7v1P0YkB+f4AOT/9jgdSPbPC5
   g==;
X-CSE-ConnectionGUID: i8fOV5IxT5m7pKUolFjYww==
X-CSE-MsgGUID: kZWAC50kSIu3OPUAt8iHEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98120365"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="98120365"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 08:19:15 -0700
X-CSE-ConnectionGUID: BtqkrbU7S6iIVig9iQq1rQ==
X-CSE-MsgGUID: J1rkBJVRQGiTUbsJvqfWAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="265562409"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 08:19:14 -0700
Date: Mon, 17 Aug 2026 18:19:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add patchwork link to iio entry
Message-ID: <aoMmbxDElUZ0oj2M@ashevche-desk.local>
References: <20260817113738.1324-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817113738.1324-1-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 11:37:23AM +0000, Joshua Crofts wrote:
> The IIO subsystem entry in MAINTAINERS is missing the link to the IIO
> patchwork system, making its existence lesser known.
> 
> Add the missing link.

TIL, that we have special entry type in MAINTAINERS for that.
(TBH, never thought about it)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


