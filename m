Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C202EB87F;
	Fri, 30 Jan 2026 05:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769750621; cv=none; b=cv9hFuzQgefgt79JwgZ/PsP2MshcY4qDkF/WYH76VXHStv1MUJtdxcovFeawgd9pr4mFpwQLeb6H7vyUAvQMrzTVhM+eDMvq8rykET1qeG49F8/KcFJSwjxcFTjS9GjG/X1cnyj64KMDycoc//TI159BY/AIyEvmIMPIfQqhqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769750621; c=relaxed/simple;
	bh=2zFFcJyyqUXrU57KZ9dtBYDpSUsFLZpjWytnD5sq9QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/ylvyfVJ1mhhJoDUFm8INtfuPBp2I/zajFKDk8vWCTOhmYGie7ObT1DR827bOsifIdZshxtNwOzXVmTSEkGftzd+6E/6+59pt1U/ohWCmxnuL1qozL4N9zoFaHTpTfGUmO3VqwBMfL8oBYrE3ZH99hDmjqN5EE/0PjhDS2GTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjShUlX6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjShUlX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769750619; x=1801286619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2zFFcJyyqUXrU57KZ9dtBYDpSUsFLZpjWytnD5sq9QU=;
  b=NjShUlX6QYXnwzreaPoc7gql7FtQ9h6MZMh2HHhTtYzuzk7VRxiLaadp
   Fm4fwiPfMJxeA4t/nl0yLpopqyCnxL1OCVNs1cYwmX5UL+C73hhv64AZA
   474/7U0k2U1hRFFBtQcbnd4qH+rFPcG0hDDRC6ucxx85L56gsaCd7P2b0
   yhHlOQD8bcSuWVtV+ogrjgvR/qUohuqZXUy7tI3z7VgmWu1sytIjg+aFH
   GEtGnvOlej8wG583tKPy1spf3q0/QCZso9NtWE7upshIM9GapCEE45nsF
   kCf0n6KdyB8D1GMq7lSnkIh/MZN+9CtP8GzTu0vI8yV9l99tjc87AsqC1
   A==;
X-CSE-ConnectionGUID: 7KJnYRPoTt+AizQdoDV+cQ==
X-CSE-MsgGUID: cpRpLnOjTViczZNY/rAOSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82426831"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="82426831"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:23:39 -0800
X-CSE-ConnectionGUID: qrtS6XShQ0SRXswNzssH+A==
X-CSE-MsgGUID: SdhemymgTfK5AeyXGcqkUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="212845679"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.227])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:23:36 -0800
Date: Fri, 30 Jan 2026 07:23:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Fabio Estevam <festevam@denx.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Chen-Yu Tsai <wens@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4080: remove unused dec_rate field
Message-ID: <aXxAVIM3iTXdQJE8@smile.fi.intel.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129172340.34216-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 07:21:58PM +0200, Antoniu Miclaus wrote:
> Remove unused dec_rate field from ad4080_state struct.
> The driver reads/writes decimation rate directly from
> hardware registers via ad4080_get_dec_rate() and
> ad4080_set_dec_rate() functions.

Jonathan, the changes look good to me, but the process wise it made badly.
Up to you, if you want to apply this, but it might be confusing as this is
definitely *not* a series.

Also some patches should probably have a v2, I haven't checked that.

-- 
With Best Regards,
Andy Shevchenko


