Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1A3E314E;
	Wed, 10 Jun 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100654; cv=none; b=E93gXqvM5Z8O4OVHVksN+bab7vMlW9ikS9Iey+lsgd+zDA3PQOHgxhGKFt7DHHLnZKHYg0hi5cduN3vsuYTWkIIJ01giHjyDpgM84rEF2+x4TIYniUBrgf0KVfCoMa4z7wGeOT949xGFulTIF5Iufz5pkW1e4eyoGq4F2HuRlts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100654; c=relaxed/simple;
	bh=xn1LXUaxDVOnPGW1ZtD+bChDwMCc+ZU6DDXXbAl/XtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjcgmCiKxeo6e+fdBkfsZybeFVMm2rdEfVcWoPU+RqFjMhKLHVReXrW/EXhJGD6G+jMn8WdF4jgZOMw+oq3SUIBS+lW+PVeDzv+m/vApZfMtWhV9vXfLP+8sJY7qRoE7pNA91vYekO1vzouh/FW4+ZVBunT8whDERXzMmAT0ZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuIuMbWy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuIuMbWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781100654; x=1812636654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xn1LXUaxDVOnPGW1ZtD+bChDwMCc+ZU6DDXXbAl/XtY=;
  b=VuIuMbWyHtZC1UMbYAH+865myhawSJ+fP+CVKcGmOkWGS9Po9TNwrwUl
   /VWrMaXgXOiIJUIrrMNWLrWEcvBcWswU15aA0AIRVOix7gtWhDSNOYc28
   U7k0sF3QF8MglXnBSox/jCRZbaA1KZ3EyJG1h2dN47oNooRyxpxAkp+gB
   H7sq8tKuDqqso/rjByh/jZGj6Ntg9B7qPV8fLa4e4wYd/zPVHTUgCJRe0
   Ws47wO3IVHGH4KamSqDX/pku+ygwsK3bUVCky5J+MVIBrtDbjyXnhkpDy
   TDUkeApkCgcoAte+PdHDY8miySb0OUOkNEGKiAUfbXKDZcu3Y7ST2DBJz
   w==;
X-CSE-ConnectionGUID: 6XuJ/IThTnWXdUz/OO3ovw==
X-CSE-MsgGUID: QaSTAkSRSBunnBAxgoWbkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81740532"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81740532"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:10:53 -0700
X-CSE-ConnectionGUID: 0aUnaCiZTjSKM9NroArG2g==
X-CSE-MsgGUID: TD/XocS1TXO6fX7YenI/+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246204457"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:10:51 -0700
Date: Wed, 10 Jun 2026 17:10:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
Message-ID: <ailwaGpVa_SFTOx1@ashevche-desk.local>
References: <20260610135831.91739-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610135831.91739-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 01:58:29PM +0000, Hungyu Lin wrote:

Both now are fine to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


