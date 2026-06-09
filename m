Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410B3F8EC3;
	Tue,  9 Jun 2026 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016252; cv=none; b=WXEgZ1n0F3NEz5ok7nWzg3Lrhp+AK81+dtRmuAkW/WN/K5MSbV0AOTFOcfytIAQcIx4R53fM6vZlKt4ZAjAYnk9y872njT5JtWNZWW+hVAe51Hs0Rs24tnOiLI5Eu6qiGzU/zo6SmYShK5kWau3W6LoCJQYBFc+EO4inGEQQTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016252; c=relaxed/simple;
	bh=6aewrsssvf1mkQVDrHbPKFNCeju/bM3irBhi3mhB3R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLtrPdSlyF8GVF0yCiHi+VlvfOVzlH+neG3DhD8LvNMaI2uLGkWK8bSfnRU/Gk4UWRCGTXk/rf0Uzfw6gENw7tUHaVz4PYSfigl7d1schb9wUsESgHhqX2lOIml8hoqxzJo3b1Sxn5q4HEY7ZtG3KMjpW0Uje9qcKn8pw46A6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hI8kk2hf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hI8kk2hf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781016251; x=1812552251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6aewrsssvf1mkQVDrHbPKFNCeju/bM3irBhi3mhB3R4=;
  b=hI8kk2hfSNzJEL0tL8KzKEO99J8BxhOaKXTIRNKtDfg4/wjUgaf7RweQ
   SiO5mu4d9wUWExu02mzJ4hxBE791ploLsHHzz6o6goOBGqlXPFeEfjE8W
   mTf3gd26IMHWEC2SNj0Pj3uCbU4XUbHHHFp4JjIwcsbd2D6MVcE1jQM92
   v21YN28Rv2fOADaPdePQeSZq02UthFWwYSJd3GfezJ1iufCKS7G+czcin
   fw1A3Eprbr9jaGGPMQEEI5y3bPgN7ogbpUPT+QbI5Jg5nmiG5nBQ6Tthf
   YHzvzKisEpVcMwfdnU3tC4bZeAb3qO4iqscMqPejt4RFsLM6Dt/cN7O78
   Q==;
X-CSE-ConnectionGUID: Zl3eWXkxTwuKMRb1qeuBkw==
X-CSE-MsgGUID: uzUG5jhdT1i/4bsuGsi6aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81964593"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81964593"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:44:10 -0700
X-CSE-ConnectionGUID: VBJ+BPUcRtuIl5vuKTuqPg==
X-CSE-MsgGUID: MSxikcWpQYGvramnBsd8Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245723292"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:44:08 -0700
Date: Tue, 9 Jun 2026 17:44:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
Message-ID: <aigmtZixUUgv0Y0Q@ashevche-desk.local>
References: <20260609020116.88462-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609020116.88462-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 02:01:16AM +0000, Hungyu Lin wrote:
> Replace open-coded bitfield operations with FIELD_PREP() and
> FIELD_GET() helpers where appropriate.
> 
> Also simplify bmc150_magn_set_odr() by returning directly from
> the matching table entry.

...

> v3:
>  - Add missing include <linux/bitfield.h>

You need to slow down. The comment I gave from the previous round still
applies. Now even more, id est the location of new header is chosen in
suboptimal way. Always try to keep as much as possible headers sorted.

-- 
With Best Regards,
Andy Shevchenko


