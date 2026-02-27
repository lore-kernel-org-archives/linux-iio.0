Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C133262E;
	Fri, 27 Feb 2026 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772175966; cv=none; b=mPTtwTjaCl/7VtTHsrJEJqcf8OdVJN/m8LXXb6kaMONO0sVvu94nYoYwZpALl9LwApo8tXem0GRKavMoKznyLxfnySUHDgcSlP9u7iV+fv1sAt8hDA4ZF9c/6vbsxblQlMBt3dE8fNX6wuvPDgqBljftS/4y+2YZ/a9IEwUOgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772175966; c=relaxed/simple;
	bh=VdZsa/IW8lLJ7aRAwgrRdRXs5+PwKCzRzymL5xkNWFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svtxWm2/4zubpAZliTGxPWKibSGDIUmMnj+AXbzeV1BXwY9veHQu4+ufTTb75AcFhDmQnSW3Gw7YeRHsVzopbsG89uzxlW2ClnC6XD46wlVUvOabK5tAWETQswz2ER13RiYBl/RNj0Z+AYy2RAyssBb9MEl1HO8Y14jxkxuC2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eiGbm9oH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eiGbm9oH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772175965; x=1803711965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VdZsa/IW8lLJ7aRAwgrRdRXs5+PwKCzRzymL5xkNWFQ=;
  b=eiGbm9oH55Z33RyQJhxL/vxRzQIgrcTMFAUIASGsXjhoTiOeZ1PRMngf
   xsDxjia3mifCl6WeTK17dYyK3JE9uzMftb+1GSauGRuDs+wZQZqBZfURJ
   XCLvYLl0xy3AXrbz3nRcvBJakWCknCPexXM3dgdhxw0bzffccNy1McPuz
   mWUcLz3yIZxty/imkBxs8YFDharsw2NdtsY+EuAlKnAb4vCO5kHocsGnk
   LpnAptnR6abd+trhArgL9whwTjKEfe4INNx0h6RAAjsxocjVt0cPDZP9U
   Hmv7c4+2jyX/ykJQqYZdY1PkEMM24qngBzaa9HtGFVILG0I3GJpeK/qWk
   Q==;
X-CSE-ConnectionGUID: 3I0cEKPXSpKj0iB+g+6NfA==
X-CSE-MsgGUID: qNd30txiRt6Ebh0TSclOLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73319554"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73319554"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:06:05 -0800
X-CSE-ConnectionGUID: teofrJtSQXePh0NzAwPJjg==
X-CSE-MsgGUID: RJ2X6/QcRv+1yKu+I7b00g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="247337557"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:06:03 -0800
Date: Fri, 27 Feb 2026 09:06:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: filter: admv8818: Add missing error code
Message-ID: <aaFCWLknDa9MSzXS@smile.fi.intel.com>
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
 <20260227061424.1135505-2-ethantidmore06@gmail.com>
 <DGPJFWN3WNIG.1DDAHDOZ7TTK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGPJFWN3WNIG.1DDAHDOZ7TTK@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 12:42:11AM -0600, Ethan Tidmore wrote:
> On Fri Feb 27, 2026 at 12:14 AM CST, Ethan Tidmore wrote:

...

> Just realized I should have used -EIO for the error code. Will wait
> however on reviews before v2.

Why -EIO? Is it used in the same situation in other cases in this driver?

-- 
With Best Regards,
Andy Shevchenko


