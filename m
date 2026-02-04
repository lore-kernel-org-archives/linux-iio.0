Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026939C651;
	Wed,  4 Feb 2026 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195441; cv=none; b=K9ylvDjo6EJ26Gi5ddryvrAmjYLQV8+m6LJUqyHBZM/Mf+enbpG/FwybBG6nCQRfYA7Ek+Gzs/X+QCmYS/w6GoFNCh2zrZbuf/zd2JBBPgxtr7CzI0RYJl6Acr18kW7KGyFj/m5Wzz4lnKlExUVPfa+7eWUK4CXXh77uMBouJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195441; c=relaxed/simple;
	bh=R/18FKPIssFLZ7bGUvcCVbvXZ0peXafFPvYcY+7zXL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkKLKIcUIYnBr/HdCEMiQUw54OkvT/9ApB3J7T7cBF0w7wDcDG73J2MZjIZzJtJ04DZ4zIkjXo83KFpKvlsfu7LBV8NcTF15IUcuScikOClqvmFKeXWHdYMY4wyYtkRj1aWWKLOX/j6l2Tm71ovzH+MV1taVkTM0wTS5hQLE4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnI7om1A; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnI7om1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770195440; x=1801731440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R/18FKPIssFLZ7bGUvcCVbvXZ0peXafFPvYcY+7zXL8=;
  b=SnI7om1Ar+hKvmW9h3dxt9aHJCwkZ5WEBD370TTUmbkm2d7Q/A0lGLrB
   B90g2Rz9Abocx0WnIMGhxRqzGCf6gGlYNpbqyFO51DeawXpLEkCBw0Wxe
   Xo8+u2biJ2OyxaLRZEpfqnr9R8l3VqinN9rRuy+sM7r/QSA5Oonrr25F9
   zNSk6QLH7giCTkf3dwuk4vzAVQSmYyl6sCHOXs+R1/kPBS/oEyjTJF8uR
   P1peynkWgav2QL6ua45EzLnTrramFlhNrXjiZHGsRjAzp6KXxLbKVw6Ic
   Dh/r0awBay+zD/EG6f7VdlW4J41Q44P19nfW4smikM9DS6s3yrZF/Y+3P
   A==;
X-CSE-ConnectionGUID: qCk37X4DRMKiYDCtGPncWA==
X-CSE-MsgGUID: c2BvhoRrS4Wh21RKRaOBSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82746449"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82746449"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 00:57:19 -0800
X-CSE-ConnectionGUID: KVZrg1ykQWawfDG1F4QeiA==
X-CSE-MsgGUID: qqasq5x/QBSyCxzGwHp6MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209204650"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 00:57:16 -0800
Date: Wed, 4 Feb 2026 10:57:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gustavo Bastos <gustavobastos@usp.br>,
	Andrew Ijano <andrew.ijano@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v4 next 4/6] iio: sca3000: use guard(mutex) to simplify
 return paths
Message-ID: <aYMJ6h2DmfJOyQmY@smile.fi.intel.com>
References: <20260204061219.791037-1-harshit.m.mogalapalli@oracle.com>
 <20260204061219.791037-5-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204061219.791037-5-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 10:11:59PM -0800, Harshit Mogalapalli wrote:
> Switch sca3000_stop_all_interrupts() to use guard(mutex) to simplify the
> error paths without needing a goto.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


