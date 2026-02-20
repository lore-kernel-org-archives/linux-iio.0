Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60835979;
	Fri, 20 Feb 2026 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771573442; cv=none; b=JZhyaeI+EwH+SrwnyYyuKaSbMU0j96VvEeMWiCHfqo2WyRj3ngXgEXeVcVBf6lu/9NAfLqEJHI2EpHWDe5XaPnCzelg1cdTdZR6kaU2OBgx9BexEbFFPefyD1BRd87c2Nsk5+P06e1h4e37zuRZ1H7S3tFi9xwX+wRSIth8tbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771573442; c=relaxed/simple;
	bh=p2b+DTkl8bQWHQjSO42wwZuWDDHruO1BFV7gCeOUSkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAjfZxg9MfFi3WKFld+hwVdkiDObjwmCGnHlr9tKOMa4Ez0pM/oZcm+A8f1uB1mXNUa9zczXBlAAXonJEjMyK6MWSqZnb9zC+2vkB6kh0YaTtATGVWa+fif3sw+WnwCxu/PaQQqYUJLku/SscuYf9JGMYVeDw2JTJRL8tBV3NTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0rGuD12; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0rGuD12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771573441; x=1803109441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p2b+DTkl8bQWHQjSO42wwZuWDDHruO1BFV7gCeOUSkI=;
  b=G0rGuD12V3MgVu9LQ0vfdQ7hEchlnK5Q9hoqzFIjlJ8vf4vaSQ7WhySj
   qmpqJ9TlZVv56upWbEJ4saR6Nz5fbDueFrb1Bn6jAlH3ul89QCcchELin
   tgxI1armupdDc9s3VFApzG+pChvgB/VyZLbBUvaXgdf178F9ExZ9AdzsF
   NKVieBtV6Rt7gOBqMzflYpLiuIigVWelnV5gOmrELa6ZuCzzoT89CiaTF
   F6/VPANuQ7LjW9YNlc6LpTW27j96q9f1AwlVwhZJ3YjjTTzyglCdUFqID
   zUh2DZtiByJEZNirWHuOas0AIfbh7PVRUV8+P6ZrxyYLuXKL5IvDb1cwQ
   w==;
X-CSE-ConnectionGUID: MHJc2NDCTLG1zgxoIr1GwQ==
X-CSE-MsgGUID: baq04cWRRWqy04XkivVjmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76281289"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="76281289"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:44:00 -0800
X-CSE-ConnectionGUID: e0LmRaM7RVe1q2lrJcTOMw==
X-CSE-MsgGUID: U3O8IBSqQ3uHrF8vbOi54w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="237758230"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:43:58 -0800
Date: Fri, 20 Feb 2026 09:43:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] iio: light: gp2ap020a00f: simplify locking with
 guard()
Message-ID: <aZgQu59aISwK2Mj3@smile.fi.intel.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
 <20260218043728.609659-2-ethantidmore06@gmail.com>
 <aZVlU9SL9e1x8Vwu@smile.fi.intel.com>
 <DGJFVHM5C384.3J15UGDT3VGCX@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGJFVHM5C384.3J15UGDT3VGCX@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 19, 2026 at 08:38:28PM -0600, Ethan Tidmore wrote:
> On Wed Feb 18, 2026 at 1:08 AM CST, Andy Shevchenko wrote:
> > On Tue, Feb 17, 2026 at 10:37:20PM -0600, Ethan Tidmore wrote:

...

> > What I meant in the my cover letter is that you need to take some pieces
> > from my patches and incorporate them here, so this becomes
> >
> > 	return 0;
> 
> Understood, so with the first patch how should I credit you? With the
> patches I'm splitting up that you gave, I know to just put my SOB. Just
> unsure about the first.

No need for a special credits. It's already enough what you put in the cover
letter, that the series incorporates the changes I provided.

-- 
With Best Regards,
Andy Shevchenko


