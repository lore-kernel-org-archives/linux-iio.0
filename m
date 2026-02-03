Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D81E5205;
	Tue,  3 Feb 2026 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118362; cv=none; b=STs2TKB6qDCuFLJ3JOc+o/YaNuyy3Yp8Ur/AEIdKgNbkI3GtbcJOaRU+ePTsnjRYzn5Fr8p2WTMSgATG1iwzPqdGCkJOofIqyu7kMCDS/hGuI0wVBmmRtRvOIIOfcD3sxxzzJKyaQIomi8pP+rgpO9eGtt1OK+OIaZ6XiQDHj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118362; c=relaxed/simple;
	bh=e+bR2bbnlwI/OASTh/92bVB/YcTPkIMP8b5WDKpM8D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+NhVw6THOGSzAB/6xk4z2s0MICpK7E7sZM/wcyZAFqrza9E0668oYhbF6FcdMtCKMKaOV9Qb+M+tw6CmkhoXLpYDnGGqp3HblZuyo/CLl61ybmNii0YjfwUd1J2Fg/FGsOb+OQJFvGsJLPWyyB+J1m85X8rLBpN2X1T9OaMdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3CqiymE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3CqiymE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770118361; x=1801654361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e+bR2bbnlwI/OASTh/92bVB/YcTPkIMP8b5WDKpM8D0=;
  b=Y3CqiymERAkKXzLnTEwxSdZFmTazls/7fcySs48mzawUxeeevv47jAeU
   8a19g71+Hg7gIltayXQHOs3mVQZM2xQJeZ6u+qgIEi57wkG+MgeRa5ZQ0
   +qZKQLouiQYgNE738elWr2fRDowezqUCbpVhY0H92ijqAK8I0/PzUZKna
   FKjZkmjK/qFlYkuxjdxw/LVlhzYaFXiUUvjAAFqpvQILCCo1EuqKduIhY
   pOh4JlJbTONkjWFzQAJw+fq+m32jAllbKrcyuRGZWjcXOkEPpQtEA/HVp
   VLPP/7ViKbENrZg0QkYquBhKy6VMX93cwToZbr1XyoNzqpqEjeomp5MYA
   g==;
X-CSE-ConnectionGUID: juY2i0RUQY239xdjpQ9k/g==
X-CSE-MsgGUID: LFG2k5vLSJ6RYS46+hyphw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82659579"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="82659579"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:32:40 -0800
X-CSE-ConnectionGUID: m/yjBmuqQ2SKqUEffv2WAw==
X-CSE-MsgGUID: xJyKe79hTjaBu46CE6e/cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="208927854"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:32:38 -0800
Date: Tue, 3 Feb 2026 13:32:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: imu: lsm6dsx: Add alternative ACPI mount
 matrix retrieval
Message-ID: <aYHc08VZFQOlApIu@smile.fi.intel.com>
References: <20260201225450.1649001-2-samuel@dionne-riel.com>
 <20260201225450.1649001-4-samuel@dionne-riel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201225450.1649001-4-samuel@dionne-riel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 01, 2026 at 05:54:50PM -0500, Samuel Dionne-Riel wrote:
> This uses the SLA0 matrix, which is how the SMOCF05 configuration
> exposes the mounting information for the accelerometer.
> 
> On a limited sample size of one (1) unit, the SLG0 matrix is the
> identity matrix. It is unknown how the SLG0 mounting matrix would
> logically affect the data, if it differed from the identity matrix.
> After all, the IMU is mounted as one single unit, its mounting can't
> differ on the gyroscope compared to the accelerometer.
> 
> The new `st_lsm6dsx_read_acpi_mount_matrix` function currently only

st_lsm6dsx_read_acpi_mount_matrix()

> implements the *known* ACPI methods found in the wild, but the windows

Windows

> driver seems to indicate more integration-specific methods could exist.

...

> +static bool st_lsm6dsx_read_acpi_mount_matrix(struct device *dev,
> +				      struct iio_mount_matrix *orientation)
> +{
> +	return iio_read_acpi_mount_matrix(dev, orientation, "ROTM") ||
> +		iio_read_acpi_mount_matrix(dev, orientation, "SLA0");

Indentation is incorrect.

> +}

-- 
With Best Regards,
Andy Shevchenko


