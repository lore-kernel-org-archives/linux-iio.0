Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA8381AFE;
	Tue, 14 Apr 2026 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160472; cv=none; b=svJmEEgPC+nrUrAXHHrR5yJRjMvvfzOUPTHXf5ECEYKm6W+O+jzTpb06TOaLvHTYoKyG5ZRyiKCoDBG9yvhB9CX+yxynjxXffvJjX4YjzKLdMhFfXJcPDDObntBfKnUWdd+KiikXdP16RohBKdJhdAqi3aHZvuAeddZneTYEIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160472; c=relaxed/simple;
	bh=39waVrRTtqMeYSz6KvKaWKBiwsMgoqAbG3WXrQml1qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz6K/sLBjtOgP1Cx7eOVQkNu3b8inhREMPcJAPRa1dZ8wu5mUHOWNqofDWHFzEN0/0uZxmISUeSgn91UokAdudb2pu7xvRwAHTfnhOtNMcjx4wSdxOZvybhOrzSg8nojcPlWTxzp5XKKtqHknvrX5thWOCSq6FhyhqHY3sLJ+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3bZqudU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3bZqudU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776160470; x=1807696470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=39waVrRTtqMeYSz6KvKaWKBiwsMgoqAbG3WXrQml1qY=;
  b=A3bZqudUQWGXoMiwrezCm/9JNxbsPTx6YVcWxXiPXflgghYUtTPZ5UHJ
   ykcNmydg3Y0le/oq6QVyweZslCeHP0xoLgppuju2W2BxSd8YthaDmMhB6
   9JK/ljP4viBAKFYUJnaU8mqcWLKmRI8N1A/Ru/KU3H5bJG9TvK3JgrJeD
   bDXqMZRM9szCOvlliW26+rMVEFa8v4YsKGvjL6zxGX8yydiMZJKqS8gO/
   E072GOoEjjz8E29IxuIaWjYAFfRH9+3I75X6q8sQwG2QKNXLW1QZ8Kp0W
   uI+N6bLZhsDasYsEILzUh7TvBfLTTI91GRKJdtX9DtIf00ystByTh7ATk
   A==;
X-CSE-ConnectionGUID: Rhxa+F9mQ4eoBGWt/C3x8w==
X-CSE-MsgGUID: UVbyuN4JSzWlUmDdCUsFFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87735302"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87735302"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:54:24 -0700
X-CSE-ConnectionGUID: QzHJxYbSSPyBDmDJiqXGog==
X-CSE-MsgGUID: UrsyleK0TPOPOuQoAdrFLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="260476872"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:54:22 -0700
Date: Tue, 14 Apr 2026 12:54:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: use spi_optimize_message()
Message-ID: <ad4OywqHDC7aYapD@ashevche-desk.local>
References: <20260411-iio-adc-ti-ads7950-spi-optimize-msg-v1-1-617766ef2e38@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411-iio-adc-ti-ads7950-spi-optimize-msg-v1-1-617766ef2e38@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 11, 2026 at 05:13:33PM -0500, David Lechner wrote:
> Use spi_optimize_message() to reduce CPU usage during buffered reads.
> 
> On hardware with support for SPI_CS_WORD, this reduced the CPU usage
> of the threaded interrupt by about 5%. On hardware without support, this
> should reduce CPU usage even more since it won't have to split the SPI
> transfers each time the interrupt handler is called.
> 
> The update_scan_mode callback hand to be moved to the buffer preenable
> callback since the SPI transfer mode can't be changed after
> spi_optimize_message() has been called. (The buffer postenable callback
> can't be used because it happens after the trigger is enabled, so the
> SPI message needs to be optimized before that.)
> 
> The indent of ti_ads7950_read_raw is changed since there is no longer
> anything else in the struct to align with since we removed
> ti_ads7950_update_scan_mode.

Some of the func() are mentioned w/o parentheses and I got lost which one is
which. Also callbacks usually mentioned as .callback() (with a leading dot).

The second paragraph doesn't tell me clearly if there is a behaviour change
from user perspective.

-- 
With Best Regards,
Andy Shevchenko


