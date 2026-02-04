Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E8257423;
	Wed,  4 Feb 2026 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195674; cv=none; b=Kpj9Wyjf6z4yPonk73WXRN7mMRtGKRC1jSR7UP2schUx0qCm4Xj3wucwGg8XCVrzWcecmygCDkLWmf4S8dvsIgxTTuyUhoUlp/pch/KAp9Bb2TAYDEcXPAw/bx0T3sIAJQZL7+GVaWu+R2R4qbsU7E0sM10AL6TTIrpG6uhtnMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195674; c=relaxed/simple;
	bh=5lSum2et6iIKwNBhoCtMoXUr71AJxzGfibwW57ZG5Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRgBRlrjBqH/wkBSwZrPcd8p6ZvDGiD8n+D99pKzVbJmaNS7NDHkdQaKdse5A2RQFoGXfNbjTxvD+8Tns77d8hBXclOK74QZPZZ0Bubv7NtbvtfnYb9i9Ex4L5nyv+WKZwgOwwC9jS5LG6yEQDm5bbN8YokpEQlDFVdURq/EyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYDyv4wR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYDyv4wR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770195673; x=1801731673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5lSum2et6iIKwNBhoCtMoXUr71AJxzGfibwW57ZG5Nw=;
  b=IYDyv4wROWhSIboF3BgZFmdah2ttDUPyMxflD1WAcW79sJCsodzXdPzv
   Be5B7NajoyW/9Cgu44G8coGvhQPluMoFEtATpEeI1IGGsnQzPJpftXT9C
   M/53hRQn/nuhgnpw69AZxc1ST80Cpmk1bp905gmbtaey6I1T4vZchM9YV
   y8fGFCn/ZK9TVmoRun+AUu6TYNzH8ppfLDm5B4kn5ZXkZbIcnsNbBpV72
   /TnJlBOEdlvrGBj1uaMc7N5I0+qPM+yNv8vZRS0clMLzpLrHHDiWpQ6lg
   nVfUkqd5a/pFijytGWXdRTouDvH7i1kBXiCea07jiyWEeY3bpGNGaPmRQ
   Q==;
X-CSE-ConnectionGUID: uxecHlURQnSP8gUcCDkanw==
X-CSE-MsgGUID: n7Zi63ONT4G3UIHkvG++FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71437491"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71437491"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:01:12 -0800
X-CSE-ConnectionGUID: PmQEKuWzSYKvLbPcZ3jbMg==
X-CSE-MsgGUID: Azt2EjDTRDGgLV1KkAaGKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="233034233"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:01:09 -0800
Date: Wed, 4 Feb 2026 11:01:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH v4 next 5/6] iio: sca3000: stop interrupts via
 devm_add_action_or_reset()
Message-ID: <aYMK06VJUrXCnNiX@smile.fi.intel.com>
References: <20260204061219.791037-1-harshit.m.mogalapalli@oracle.com>
 <20260204061219.791037-6-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204061219.791037-6-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 10:12:00PM -0800, Harshit Mogalapalli wrote:
> sca3000_stop_all_interrupts() is moved above the probe routine so the
> new function sca3000_disable_interrupts() used in probe can directly
> call it without additional declaration.
> 
> Used devm_add_action_or_reset() for shutting down the interrupts.
> Make sca3000_stop_all_interrupts() return void now that it always hooks
> into devm cleanup.
> 
> No functional change intended.

This patch overloaded by extra thing. What you should do is just move code
upper without _any_ modifications being done _before_ even patching it for
guard()(). With that additional patch the rest will look much easier to
review.

-- 
With Best Regards,
Andy Shevchenko


