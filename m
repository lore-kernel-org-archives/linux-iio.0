Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219F3A7D60;
	Tue, 12 May 2026 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600451; cv=none; b=lmLLZnAkzuDR3EpUNq6DqkE9qDrij8zrQlyMb0Thrc/S6F8VDuhxMQGCjG0d7wZ8Xs/kldf3K8h0XI2gXZxxSrqYMOk+nOY6MBZHhCD36aI9MBO4NcgYPuj0ycQwkfQesNaozoLIqI7WfOEyGCyD2+EHQ/iPOdgY/1CqdNwh/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600451; c=relaxed/simple;
	bh=3GlVTcCmXfG89+IYN/RfXlrItpYrad4v5nTTBBvkQKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osreQyNaM1l1Egua12GKvuVmxBLPVmfxAJeqTFlTeyacxcpM7i5kwfqvv9ZBMwWq90qmxxXlceS6UoCsaTzjlKCeQEsqlOzBnS6MnVS1UKe3v20WDjDtKApQVlvl5ZX9Emm7cmUIzONSvhmEWHgamiKlGFTy0G7YKXdl4KZVCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJitXsRQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJitXsRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778600450; x=1810136450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3GlVTcCmXfG89+IYN/RfXlrItpYrad4v5nTTBBvkQKA=;
  b=aJitXsRQ9V4f0uNn9WIIC2l224/BwX3lNtDox0bFFO0x9gskbkDTq2jE
   nuQuaBVwVN+CWV0vBpQzTpEbCutABunCuNmnFwq4q69+3o5Ajqw1QS0qI
   Dwte+ftysoXu+fQoRFQDqRNMpuPQ/3EzRNGRQD95W5a7p69FYYADQrDi/
   gtG7tC8skgKz9huNQQX2DH/TZNoFlP5hJsTBa6SMyUWcfQP2NNwsxMvN4
   hjC4MAw52Y8/fdDmzY/j9lkDcqVfAluuZbtMt5KFrd1Rn9ifduHKAefgN
   TFqV5yKCkWpCgxl4C23sV9jsSwIzzO/nXh0ZWGCE6Lcdsfa67Hgeol7jx
   A==;
X-CSE-ConnectionGUID: e5zWkZ0uRH625MqigAsoSg==
X-CSE-MsgGUID: ateg/0YKTuWC92JwUaZcLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79369174"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79369174"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 08:40:49 -0700
X-CSE-ConnectionGUID: 1TWgixILS6SKT0PYw0Tg5A==
X-CSE-MsgGUID: 9m0JjufLQJiicXGAX0OuSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="236817048"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 08:40:47 -0700
Date: Tue, 12 May 2026 18:40:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexander Koch <mail@alexanderkoch.net>,
	Michael Hornung <mhornung.linux@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] iio: light: opt3001: localize for loop iterator
Message-ID: <agNJ_EZ2tzopyVnC@ashevche-desk.local>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
 <20260512-opt3001-cleanup-v2-6-8018cf3a8a0a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-opt3001-cleanup-v2-6-8018cf3a8a0a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 12:57:26PM +0200, Joshua Crofts via B4 Relay wrote:

> Localize loop iterator to tighten scope and improve code style
> per checkpatch.pl report.
> 
> No functional change.

...

>  		const struct opt3001_scale *scale = &(*opt->chip_info->scales)[i];


This is an interesting way of writing &opt->chip_info->scales[i] ?

-- 
With Best Regards,
Andy Shevchenko


