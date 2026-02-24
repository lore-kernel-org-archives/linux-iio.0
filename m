Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021637D114;
	Tue, 24 Feb 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932413; cv=none; b=ignVnFb+Ot9jCxq/U4u6sGB2AIxz+zZtaiuJfFIM3vtcvnmmo1xTGTQQ0O1NZCWJdMezFTuknrVUB1ulwyprz3DDaJpkSMKEoGABvbnk6gMj9SZZFbGJVQzXhcVG3WDzCokDw7jvuuuu31YqSdFQA9FgcVB2cLGu2lIBy0P57sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932413; c=relaxed/simple;
	bh=pKAMBBZL9i2q+1cgcFiJO7JzqliAh+voOviPIxzKa48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebCZ7yyJ/0ZU7/2KYRjNX7dn956vVbKmSlzfK4hMb+ptCRDt8oKyDX4LeRMfXLI8Dx3QLBMYwsg+11FaB8DZYe2IlVT/3o2/r66om/GR99cBo98tOf8fe3Gl9d1FHzJkria/UOJZihIa7YozfDKqo9pQAqdjmDdYzv4gQ9ofdtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWIy0X29; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWIy0X29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771932412; x=1803468412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pKAMBBZL9i2q+1cgcFiJO7JzqliAh+voOviPIxzKa48=;
  b=eWIy0X29WYksBAvhFb6AYODIn8TFUVD7ULTdE4BQtlGzIWBLp1/mOQmj
   JFv70HMdSPF/zfct2W8C7ddvrXNyyd77xvMo1sGAW6Zl46hs8Q8tD5nKu
   Q4lMJGD7DoYjY5a6Qrf3R93AC2/AaxQ8p7rhpPNhPjV+/5MyALO877Xxs
   7AMDzIgofFnzGynZC6ebCGAFaQuGR0VXCoSKVkITDt2t6MsmEPxLW+mcZ
   Sgq8oRgsdJsrG5mLIE3co4hEz1wzdPvhObplTcfjAF/BGPmCKvkEhzP6T
   dMFrHFy6R1wYStd6JP3yQqNIcaBXKeUm+ufBNSCmmk/TmrPg0imYw4TwW
   g==;
X-CSE-ConnectionGUID: RgP+QcsJT2eMd4L6idfsyg==
X-CSE-MsgGUID: VxN5QFHmTgmZNJOSugs3iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83655183"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="83655183"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 03:26:51 -0800
X-CSE-ConnectionGUID: p+eappA2Q3iHVB0M8ou11g==
X-CSE-MsgGUID: OAgAIbWxRFy/qbOn9BrqUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="214120488"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 03:26:48 -0800
Date: Tue, 24 Feb 2026 13:26:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: fix typo in error message
Message-ID: <aZ2K9gbeS0jffkx8@smile.fi.intel.com>
References: <20260224111744.55378-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224111744.55378-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 03:17:45PM +0400, Giorgi Tchankvetadze wrote:
> Fix a typo in a dev_err() message: "maks0" -> "mask0".

Hmm... Can you run codespell against the whole subfolder and see what you get?

*drivers/iio/adc/

> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>

Fixing these small things separately might be not so efficient, and if there
are only few like this, it might be better to combine in a single change.

-- 
With Best Regards,
Andy Shevchenko


