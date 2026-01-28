Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE826A1CF;
	Wed, 28 Jan 2026 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593458; cv=none; b=eS/yY3EBTyIqjvpa9mqlyMFf4NGZSEyGSq+lpJqnbuIVoxJTmDItLofRZr7UcEtVM++OktYWhD4T5Q0f09cF56S1tC5ygo134OtzjkSVkIPSbtdDDye4QZhe8K8fzAGOsboSxRYJVxHHa6ze5eJfC2Wjok3BzJGgQHFvOnHOjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593458; c=relaxed/simple;
	bh=E+oGB0H8+GlYdjBre5NnU4PWu9lbJzJr1GttBqky8QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOoO+QNqfkD1KNDrK4nRRGNqMqCuapcujVFeWz14zNhnBiHKY+OQhesaHO9XAzXaN7pHEdRfsKNEiywFm1c+fLX0Z1KHRStHtY3iZCnuKRfJhnTjLLiLvWYcvZjFGZH2/5liYwbbs2IOjoqSw7I7xsYCG0vB5KyuKVrW0MdW23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DN7baP42; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DN7baP42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769593457; x=1801129457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E+oGB0H8+GlYdjBre5NnU4PWu9lbJzJr1GttBqky8QU=;
  b=DN7baP42adC/0zF+Cbn6CaJEkS2HA64+jHfUTrDvNc1PxhHmSTL0zf8/
   x1Uk7NJGELYH7LFizS8ePtz+lfLQjXzdfntHh2bjBzqVRF8HwlqmlZRT3
   tWb32frG/Fcud0YN4zMa1IwTf3KMPm2WEZ7l1eEAd+nyly1MtDMB+P+2G
   q9yUMKQdnNcKeZ84togv8XbufEIlk6R2tLNeOMul//l8UtGi0BZoD3E9N
   tCtei5vnYV8VsEguAbSRMBgG1p2CN0om6CsZBAuUmIj5ZHJgvVZWUVX/B
   IeN1j+9C5qAz7IHRSK54NHnbEjN7Pj8zFdlo/Pivv1KAYjVZQd/JlEUOC
   w==;
X-CSE-ConnectionGUID: +6LqGV3lQzq6S+EPD9an7A==
X-CSE-MsgGUID: ume2VE1lRZ+bUsopJPEX2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70890596"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70890596"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:44:16 -0800
X-CSE-ConnectionGUID: InxuI+YqQ1CMPAzZeJw+VQ==
X-CSE-MsgGUID: s/22m/LITleCQeO5Q9JqkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="245835694"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:44:14 -0800
Date: Wed, 28 Jan 2026 11:44:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: buffer_impl.h: fix kernel-doc warnings
Message-ID: <aXnaa-VfaL8ozVJb@smile.fi.intel.com>
References: <20260128062550.405473-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128062550.405473-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 10:25:49PM -0800, Randy Dunlap wrote:
> Resolve all kernel-doc warnings in buffer_impl.h:
> 
> Warning: include/linux/iio/buffer_impl.h:172 struct member 'direction' not described in 'iio_buffer'
> Warning: include/linux/iio/buffer_impl.h:184 No description found for return value of 'iio_update_buffers'
> 
> Also correct one typo (word order switch).

...

>  	/**  @bytes_per_datum: Size of individual datum including timestamp. */

Shouldn't we also delete here...

> -	/* @direction: Direction of the data stream (in/out). */
> +	/** @direction: Direction of the data stream (in/out). */

...or add here an extra space after asterisk?


-- 
With Best Regards,
Andy Shevchenko


