Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63637C0F2
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684085; cv=none; b=Q9J+Ifd0uiSa+0MwPV3gGE9N3A2s0MPcvjX7bhKqVTtrMaoUVP39hQnWY5szKq67ise6mppiFYo/DwiPDPV5Kxs/OnJW8AbyJtzzxT8jO0XCRT4Op0FjKoC9Sx6bOjqcsrWSzrDcpMXQlYDGZyw0NQwV9Tbn4VU5YQfCJu95qik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684085; c=relaxed/simple;
	bh=vw7kdg5SkX2F7Aq3YCY5pGBSPZHYz48mjmCS6Qlj9TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMS7dUMBp/fxdNuFCEKxUisS804HNSbpL+gHR7ipYNEksm4zGDa+Z2BnkxYx/EHzn1blxKQZQqC+8B5OM5PKBgnsVHukzb6NSNx4RL9Ar/depz1wOzj/B/SAd0YBKH5eLD7U9SyF9A3zuS1IV6diqsFL/orkUNK7rmr3oSDsELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMfiBisH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMfiBisH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769684083; x=1801220083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vw7kdg5SkX2F7Aq3YCY5pGBSPZHYz48mjmCS6Qlj9TM=;
  b=QMfiBisH/pZHE+OeZHKmcKBL5vqEbuQ+hNfDtXoWc9ZsChPc9cn6TKqv
   jW/67EUv9XCZhzAA25DiJ20eSeJto+/zQnt+9JvsSnJTVRML7wuWmxKmN
   pZLhaVUkPwS94Qml3tjtMTndOJAt29zjqzp5neNIj1qBFGU/k6LqHG3CQ
   1KVpY+P0/qGfyUxDuWO+4jLwVMhAEk2YzXY6ICuFXTnFp1jOAt4kBC46X
   exrLCJblg3ntd2tkVL4Ze5aRvuLRMZzCLg6F0O2CrHNpkAvdm8jrW8gCH
   CFKXrBZUvGOrLm/0yNVaBsEfmvCXFTwvzMxrRVjT9KdzvK2RKfbLst1GX
   g==;
X-CSE-ConnectionGUID: edI40GyGRAy8Gft9s/OqdQ==
X-CSE-MsgGUID: eCc8xP7fSZiskckZ/GK7TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70956891"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="70956891"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:54:43 -0800
X-CSE-ConnectionGUID: rm6JtvJ0StO9/LwhYnodzg==
X-CSE-MsgGUID: uUUBbOz0Rkqs5m/nmVnjDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="239799040"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.155])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:54:40 -0800
Date: Thu, 29 Jan 2026 12:54:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Menderes Sabaz <sabazmenderes@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: dac: ad5360: converting to guard(mutex)
Message-ID: <aXs8brEx7EAcmpEQ@smile.fi.intel.com>
References: <20260128153221.327987-1-sabazmenderes@gmail.com>
 <20260128231419.415390-1-sabazmenderes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128231419.415390-1-sabazmenderes@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 02:14:19AM +0300, Menderes Sabaz wrote:
> Converting mutex_lock and mutex_unlock to guard(mutex)

Refer to the functions as func() and don't forget period at the end.

  Converting mutex_lock() and mutex_unlock() to guard(mutex)().

  ...

> +	return ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
> +		AD5360_REG_SF_CTRL, st->ctrl, 0);

Wrong indentation.

-- 
With Best Regards,
Andy Shevchenko


