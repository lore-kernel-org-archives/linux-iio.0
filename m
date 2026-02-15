Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EBC23909C;
	Sun, 15 Feb 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771141866; cv=none; b=eoBBRB6LKpz9VrYpO47j5JC+EoUjCL+ebuGP/y7IE+HJ7/GDNeUqz594cY9mjjBRFaBOPTJ4sF31BgdiZt+U3FVtvP0XqyZ3GKQn+CnI9T/H9pimEegCoT57URFrLnfNknIDCCUznUv55FzK9D/nnefa+U48+zkYAETpd4snuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771141866; c=relaxed/simple;
	bh=h47AjjEMPuqdAX7HdRBvsNK93jDDK5Z1ffRD8cj1/9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKMycxBJo7p63ZUrNE5DcN2t9Cf9TWGKnzUlnSxVF0iltJh5hRt+EcXPYRndfK5H4GOhVJz1QXSf8By2JmgDF6j/ChN0+So7VRpmDknOrjEbLeavLEEBMrunsjKzQXGk8keMRbsYM50ipEtQMkb3vWfYoJt94NlAvZYXDuZN0aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RlAgJEgc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlAgJEgc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771141864; x=1802677864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h47AjjEMPuqdAX7HdRBvsNK93jDDK5Z1ffRD8cj1/9Y=;
  b=RlAgJEgcJCufogwFCA8Jrea+nPIlwB9Okxseu8s2SlH2nDmNVRhsmV0T
   o8gImSYfUyAONxds/wkFMi85pHMg7p/9+9ImdXkJuBNXeMrWV9d+11Adk
   9Nbjx9lzKU2zejKC07r4+uj+zVozvo3PV2518EJDSzADttdj4DlxRpxAs
   FTBDqWaRF7U4Y9yPqNafZFsD+3igwFB6bYOXHgdQqdKqzCXmFCckcc5Yo
   rJuYaw2WhuGrudv0pFZnKPUQjgEVxRD3K+RJh9tzlNVvdfsbJFWbjupWH
   Hi12E2431hjULrOImgRO78YXN7kOcKgn2bNWHmaocn8Q+ZCMIRFNSLN3e
   Q==;
X-CSE-ConnectionGUID: tjg8VFc0SZaHjHGz6dgeQw==
X-CSE-MsgGUID: vRcLmsU8Snangg+FmcWANg==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="94896125"
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="94896125"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 23:51:03 -0800
X-CSE-ConnectionGUID: nR2LqsqTT5WTBip9E4CXgg==
X-CSE-MsgGUID: Lp8HFp2VQRK7d+ZTHJWXAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="243904317"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.136])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 23:51:00 -0800
Date: Sun, 15 Feb 2026 09:50:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 05/11] iio: amplifiers: ad8366: use devm_mutex_init()
 and drop mutex_init()
Message-ID: <aZF64mqQ-SDjzbe5@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
 <20260210-iio-ad8366-update-v4-5-15505f7b15b4@analog.com>
 <20260214183616.14f790bc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214183616.14f790bc@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 06:36:16PM +0000, Jonathan Cameron wrote:
> On Tue, 10 Feb 2026 19:42:05 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> > Adopt proper mutex lifecycle with devm_mutex_init(), replacing
> > mutex_init(). Also, Include linux/mutex.h header.
> 
> Why move the *mutex_init()?  Even if it is just because it looks better there,
> not breaking up spi related stuff, then say that.

Yes, this needs to be recorded. But actually initialising mutex (and lock
in general) earlier is usually a good thing and in some cases might even
fix a hidden bug.

-- 
With Best Regards,
Andy Shevchenko


