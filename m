Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7932E751;
	Tue, 10 Feb 2026 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753611; cv=none; b=XH/IYLyXMa1LX/FV0rOVAgXrOA8ysHIKPidennO/hSbBBjp2IkvVbqB2AyGp+xQMKy7Fo/wRVls64ZHqrD2j+JUBEYzg0SfJk+7S41Xi1SvWpeEZwZJ3d0ExUvz3DLbVyxQp8oqvptQwtNUu5uOSrmRedNCi3JTEw2r5XydlkHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753611; c=relaxed/simple;
	bh=z+PutbAUh3ykS4neKuzP1pPv/kG7+PexxF5rDdykSV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSgd0SP/o5JiZ18yiCTlftK0pJbs/Mzf71BbesMDLFCuI+B6d0m1I4Z7EmC4t5gcMKceAbrtOSENa8f5uP9KvJtnbXqe6N18S5s0wkLOc1qZwQdy1UaBhlYLchJSEnZU6P2eDxnSR0dzeO4T0AZdxs4Epsazc90S6Ft3WNJ45Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDEam4Ri; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDEam4Ri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770753610; x=1802289610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+PutbAUh3ykS4neKuzP1pPv/kG7+PexxF5rDdykSV4=;
  b=SDEam4Ri7iwHadlOEXTUx7hEiNxnYiEDyf34LkWkRCMVN4ujOXpdOtok
   TR+8vtdWTLlph4gRfLj5v5gwDDKPm5UYRGLXEFxJuf6fQonh41Gcqf1jg
   KpOaCV5PtknFMrgsFcWH/lz26Wmlp401XcHaJdWuT3vdjvZlN9DQQdc1v
   5rcRWVazi8alOy9y2IZaWA1q9e6lK2Hxz35tL6LPAic0K8YSHctkYcj22
   /6hxUhpHfvcEqAFyvFHSOqD5M9YCvyvuQ27G/+8V2g58O4SbwhoF/f6vx
   9NnOkSSxQb44/X32tt5If51dshuavi8OfP9CN3hhVeJdx+3DR/dt5WL3O
   Q==;
X-CSE-ConnectionGUID: D8XX0Wm2TuqssFxSovoyAA==
X-CSE-MsgGUID: Vovr6/+lRf6IzfxhT1l9Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89306413"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89306413"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:00:10 -0800
X-CSE-ConnectionGUID: Bj8Wpi7cQnG5D8FtlHaCMg==
X-CSE-MsgGUID: vnGdley7RlGid+U4e90tEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211482970"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.131])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:00:07 -0800
Date: Tue, 10 Feb 2026 22:00:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 05/11] iio: amplifiers: ad8366: use devm_mutex_init()
 and drop mutex_init()
Message-ID: <aYuORAaFrifPMRvV@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
 <20260210-iio-ad8366-update-v4-5-15505f7b15b4@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210-iio-ad8366-update-v4-5-15505f7b15b4@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 07:42:05PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Adopt proper mutex lifecycle with devm_mutex_init(), replacing
> mutex_init(). Also, Include linux/mutex.h header.

mutex.h should be included before as it's not a new API added in this patch.

Otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko


