Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8131E854;
	Wed,  4 Mar 2026 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625139; cv=none; b=P2RmTokMf3a44nqst/IVjGiG8PrptbCgShKtE78Ar9CcY0dD0EAMeMT5AZeYDHyPGZFVey8Ezh6Cpcp3bbGgeEonmPtQtVOMRv9+vNQNZl+MPYdsoEJ9k8gYjNVU77t4g/oPAe0VSKJzTvh62Gtzy3LJzjdry3IRhz92l2WPCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625139; c=relaxed/simple;
	bh=1cbNHjS3Jwr1X06Tb+6bXSS1cl+vAw/B+P8pT+WbDeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLyW/fWSHIQscMA81eF1BATjhQs23I6+9euvdbZ93VleuqIEx9vV9wGqpR8qTXGlpRK/G5LmpVJDGwScBhLuIj8MsfKsEKD/BG1J9u/7YHfvrAAVBe/zPsAy8bsLdxXCpEa2qbjDEpr/KXwTfs8bY5NbygcN5yOElDB1cVna2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhTZBllA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhTZBllA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772625120; x=1804161120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1cbNHjS3Jwr1X06Tb+6bXSS1cl+vAw/B+P8pT+WbDeE=;
  b=bhTZBllAanQ9KH2CiT23/nxt1E29N1jMrRApm2kS+jRmWg5r6WfQV7+Q
   8kV+H7UEBMUjnAVxlRGM4wSXo2N10gARy10mVVDrfx4jCiWXMXYbQa+E3
   74wiF5abgp2YbHSan8d0Ca8cqZ47ykW3IM8WwQX+0eK6Q/6A7JdTDEV7y
   1pCIvT0o/WvsiMJmaiBRVpExQ69iKGwAwqmZFsDH2HAD0VwVqyniLA1Hf
   IKH3GYvz1+SD63+yIRwKQdZmJJ0p5WlclwDsCI9Hvvu/s3DYGCtzDUK0e
   XCw5kefOaKrcEMO5v975Nm72QctKNSKbK3/r6zvfvn1CBNG3xlTrxOrpw
   A==;
X-CSE-ConnectionGUID: NdzJmUfYTB6d+gorbSb2Cg==
X-CSE-MsgGUID: tdrYEFTgQx6xBmspYhKFYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="61257210"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="61257210"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 03:51:56 -0800
X-CSE-ConnectionGUID: eDtDSgfsQbi4u9QQ+mFcRw==
X-CSE-MsgGUID: Iss5/j+2Sku/SvffDzin0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="218431822"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 03:51:54 -0800
Date: Wed, 4 Mar 2026 13:51:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
Message-ID: <aagc1_EkH3cqh41O@ashevche-desk.local>
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080706.2844472-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304080706.2844472-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 04, 2026 at 09:07:05AM +0100, Francesco Lavra wrote:
> This modifier applies to the IIO_ROT channel type, and indicates a data
> representation that specifies the {x, y, z} components of the normalized
> quaternion vector.

...

> +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_partial_quaternion_raw

> +		Raw value of {x, y, z} components of the quaternion vector. These
> +		components represent the axis about which a rotation occurs, and are
> +		subject to the following costraints:
> +		- the quaternion vector is normalized, i.e. x^2 + y^2 + z^2 + w^2 = 1
> +		- the rotation angle is within the [-180, 180] range, i.e. the w
> +		  component (which represents the amount of rotation) is non-negative
> +		These constraints allow the w value to be calculated from the other
> +		components: w = sqrt(1 - (x^2 + y^2 + z^2)).

Just to double check if we really do not have a special mathematical term for
that already. If we do, I prefer to have that over odd "partial quaternion".

-- 
With Best Regards,
Andy Shevchenko


