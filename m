Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5E3E3D95;
	Wed,  6 May 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056339; cv=none; b=S27mq2RETLjCdR2a7q0Id29bai0XKPS7NQniEgzY5jWsQjXdTnp1aHi0pZU5/9BhnJND3b4lc74lWBBQr/QKNEtnozsOZwogd6jPs18GwfjmNNi/3Or6eP2MpEMBjB810/wNhIW/1joc00hvg/vPzXVXSkyUDhfN45qLxkXBL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056339; c=relaxed/simple;
	bh=mamU955At4km7lZGSE0lsdBfhOkFFlFD3VKOW/50Fog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmAfEZZ3uigX47JiQZkxScZJQm7i+SVRkV8TkkhJ+ngbvB7fVgv0s1QATn42oizY9t7+YpUXFOrTQaquon7uUqif8wHLIMppfL+G2J0fhbW5GfxA5DUmgb6KStTy6y+y34I5m3yqoj8qtWgZxnY0h0ahNrEAFGE6UBYdEWRTVoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6io2frW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6io2frW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778056337; x=1809592337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mamU955At4km7lZGSE0lsdBfhOkFFlFD3VKOW/50Fog=;
  b=c6io2frWsMY9set2Pw7Qigz+Jq2v+bMyotxhiqFZGFeWv2a+kKMDUbmH
   N9PO+39gtMRwoLtlIZ/reSrm4+luM2O3OxxORUp6hSjh36y9+vqtTCIhq
   xsVg4rGPhYyggLdgv7ioobiusgN9KdGGsG3jDdQVHVK0cR805qwYDKP3v
   coWYZt6as+lIL9HKxxjKWUGdOU9iQBCtGgKmXfbWKeaASShbbYLrpF617
   f67NhN/oQVyv1ysELdBUhVoYBvE7046hm9ZSc0T+8hXW0HXn70sMFozgO
   bH0EpiAYhCG932gsI1uBkfzXpnyaMQclxamPT5BkjQwz7lmWF1hd5uMij
   Q==;
X-CSE-ConnectionGUID: W+vyP2QQR3Gy2wQglYjUnw==
X-CSE-MsgGUID: VzGmbyfTRlO8lmKchj+zUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="96406773"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="96406773"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:32:14 -0700
X-CSE-ConnectionGUID: sLaD/dX+T1aTEP03+yKwuQ==
X-CSE-MsgGUID: BYONlszFRo2EvkzpUNd5Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="241058161"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:32:11 -0700
Date: Wed, 6 May 2026 11:32:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, joshua.crofts1@gmail.com,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: magnetometer: ak8975: Add missed
 pm_runtime_put_autosuspend() call
Message-ID: <afr8ibUy8lNywq-5@ashevche-desk.local>
References: <20260506082755.860523-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506082755.860523-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 10:27:55AM +0200, Andy Shevchenko wrote:
> On the failure in the ak8975_read_axis() the PM runtime gets unbalanced.
> Balance it by calling pm_runtime_put_autosuspend() on error path as well.

I hope Jonathan will take this soon, so you, Joshua, can base a new version on
this one (otherwise it will be a conflict with one change).

-- 
With Best Regards,
Andy Shevchenko


