Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF032741A0;
	Tue,  3 Feb 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132299; cv=none; b=QlEUjheK9UoL/0lvVwcZTtOjB9/TOqBDJAl4FvlgaBdgOo1gtOK1LR7ibWHHyy9411tLKSjzPaQlwpJ5LqaAdhG7Hk4Hsa1DpQCE7wFttl9i47oj8EP3rpCcgbZFqvS0yVYhh8mg7i9E4TJsB4z58A5RFF67d02+OM/ARH12qf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132299; c=relaxed/simple;
	bh=rHosglRelEy3BJW2PR4KZp3/Lc98RditfRLWqURCJwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfxivlqDhZAo0QWTBm0sCAXf6IpJNEbkoX56E39+L5SCYzg/N9AoqlKdXdMmf5lYGdZ0iBSo67/aoyHwIc4vPSW7FQYk+Va6NnUqbeGvbgimiamTU0/z6oBmYJmPUYDctO8c9GToDPQwQKiNqWPKLWtg9pfseUAFzk6Uu5RPuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajg9p0+z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajg9p0+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770132299; x=1801668299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rHosglRelEy3BJW2PR4KZp3/Lc98RditfRLWqURCJwM=;
  b=ajg9p0+zl44qSu6vHRznXIILQcsx0dM2aIRSiJnMDjnwklRUy22wkyAx
   wFTIWgcMUJYHG8Dja63OaVduVtHN0d9GzpbreIiX6SasizGkKwEEUZgbv
   kfNDokXj58x8daB8MwTAG1BA0VsqTeGPMbfzDKD6jUseEbFCqtrezgLbE
   Fn7OV39JjV1vk5r8Ziq+PdoTKdRSlsbRJbFCjDPTrwoTxqnWCN29BaZaA
   GLSKV2WgFLGKgwn9BiNqpCngQVvjMfQa/prOHbSBx3cqZTAP6jHrZDmkR
   xT7cJN+soV8gnPFW7DYUj7YS//bT1BVL58ph5qQlczQy4QAIAmHxN7Jcc
   A==;
X-CSE-ConnectionGUID: dH1s3deRQneV8BPPqv+Ayw==
X-CSE-MsgGUID: /fHFNv0BR82F5DO5OPL3tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71285722"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71285722"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:24:59 -0800
X-CSE-ConnectionGUID: v7DghfIcQGqLYRjbP4IMHQ==
X-CSE-MsgGUID: 4rYT4n82QYKFPzjAumlSew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="210025691"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:24:55 -0800
Date: Tue, 3 Feb 2026 17:24:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com, David Lechner <dlechner@baylibe.com>
Subject: Re: [PATCH v3 next 4/6] iio: sca3000: stop interrupts via
 devm_add_action_or_reset()
Message-ID: <aYITRNfRgK475ck-@smile.fi.intel.com>
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
 <20260203122109.689669-5-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203122109.689669-5-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 04:20:48AM -0800, Harshit Mogalapalli wrote:
> sca3000_stop_all_interrupts() is moved above the probe routine so the
> new function sca3000_disable_interrupts() used in probe can directly
> call it without additional declaration.
> 
> Used devm_add_action_or_reset() for shutting down the interrupts.
> Make sca3000_stop_all_interrupts() return void now that it always hooks
> into devm cleanup.
> 
> No functional change intended.

...

> +	mutex_lock(&st->lock);

> +out_unlock:
> +	mutex_unlock(&st->lock);

You copy the code that is going to be removed. It means the conversion to
guard()() should be done before this patch.

-- 
With Best Regards,
Andy Shevchenko


