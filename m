Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2935DA69;
	Sat, 15 Aug 2026 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786783359; cv=none; b=taqhU331ohu+8nCHSOPPkjjJT94Xo5sHmEjAbLuoqeYKi2zTAfr1fyavFH0cpV5Jv8azjF2za/ZmPN1zz5vWaPqd/nmLqsTX51qUHNFwkj93+Q20O+jNSje7y55cYCLCuiUMlDdMNPapUVGp96klM4T+rjNMvxG8N9kCDjWU6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786783359; c=relaxed/simple;
	bh=3/3yfMmWd32j3JSL++ZWe0Dhu153GJtuWaM824HdKXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVafcfGJuZuTllgFN9OxqJUUTV23+gTA//Fv0LhXCUFZZUkqOqkZLg/w8/pv9e7PFyvRuhNdcbIBihojPzQ39PRiFF2L9fWCr31oyrAllX95v3DuqfiO2MclnDb+fybuziTNVNswau84G3oRZxGjf8N4f1RjN31hGwmwCEV3RT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+uWniNf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+uWniNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786783357; x=1818319357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3/3yfMmWd32j3JSL++ZWe0Dhu153GJtuWaM824HdKXU=;
  b=j+uWniNfS3GjAo1VGbkJ1qR9MBMcoNZ3UEFzq3lO/AZMFAO5egqZOAED
   h10kYP9KjSsS8nqF3nUdcxmC1d1oHSldlZEL5mAujMZtjrBUL014WD9sh
   JibYEZRxxayfujHrB1etJ3zGLYrhuRNcXtEpsWkhDbSYwUai2cd4sFqeK
   mNe3eoqocJCT0DwbWPHC77Vn+s7Z1DHtP44rDComoJpXK+ivNEXjxrY0X
   lB6yC0kI2ipKK9JVpV5r24SV5WVPU+l/1sqU6yLWv+JVo8gFLNwrP2d3J
   CAQL1532N3cQWdeQvzP4FoCvGg7Z1vwQVZhyHIUHJdmPCUbEhDeB5CYep
   A==;
X-CSE-ConnectionGUID: N12XXH/ASXGNhDXu5F448g==
X-CSE-MsgGUID: k9JPMoi5R767ohpHKxU9Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="74879741"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="74879741"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:42:36 -0700
X-CSE-ConnectionGUID: 1E/vcbiERterRFn3jjcu3Q==
X-CSE-MsgGUID: nve7dWBGQ4Cy1EkFMKFwrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="287910236"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.12])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:42:33 -0700
Date: Sat, 15 Aug 2026 11:42:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arka Mondal <arkamondalofficial@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org,
	venkat.prashanth2498@gmail.com, rohitsarkar5398@gmail.com,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: adis16400: fix unprotected debugfs reads
Message-ID: <aoAmduhNrHoJdmn7@ashevche-desk.local>
References: <20260814090728.965922-1-arkamondalofficial@gmail.com>
 <20260814090728.965922-2-arkamondalofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814090728.965922-2-arkamondalofficial@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 06:07:27PM +0900, Arka Mondal wrote:
> The serial_number file operations are open coded and never call
> debugfs_file_get(), which debugfs_create_file_unsafe() requires.
> debugfs_remove_recursive() therefore does not wait for a read in
> progress, and unbind frees the iio_dev underneath it.
> 
> Use debugfs_create_file() instead.

Have you read the code? Have you read the commit message of the "culprit"
commit?

NAK. Please, revisit all your patches and be careful next time.

-- 
With Best Regards,
Andy Shevchenko


