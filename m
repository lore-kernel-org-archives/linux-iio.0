Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A443FD05;
	Fri,  2 Oct 2026 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927704; cv=none; b=Wiu8Q/uFdM6n3CxsRUqCrqz9rPyeb2k+dZ2QU8BAxpIp93hVv1bkeE1bnvkPLTN9XX5Jhwh1DzeEilmszQ/fSMIRUyelxZlN5pjIPtWbwWfSn0KrFfBzEtxZoDr+RjeH5wjb+27ZrnErSptx00wuIAH3c9lXclVohsP1pEy31kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927704; c=relaxed/simple;
	bh=5+qAtAiadMGzrxIPZBuJx9dkbkJ5sMwuUAACipveA6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsZwyBlXFSQ4rd1YTSoWp55GVtvL2imAh9NU8eb+kBW+9IeZHVQ3BYKfkxfUXhhrqJ543PoqIqT5PuWih1ebn+hAwRD4GqPKdwsFE5ygwiukF0usncOgDhN9Y2ZOKgsvkfaSNqtbNiOTXGj++21dX+Syz0qhKWmDrTQdOcAWgSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNK/tyMs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNK/tyMs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790927703; x=1822463703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5+qAtAiadMGzrxIPZBuJx9dkbkJ5sMwuUAACipveA6A=;
  b=hNK/tyMs5zmx0nLSDg1v4gdB1JRnIkKJFkaQ9p3I3vWVHNr3HeY5/Cj2
   60i19+yd3T7nikWUv3rpkc4SBI2tZ9vB/OOX9pIXnTF/Poskz82Zrr7hs
   s63PnD750Cz1DZYp3pzW+YVtiDSVU4lvfvepctU7bXyuHsmsVzmJt+FkO
   4up2rD/t5JIdfHkgl1gCeiBDfPLG8LbTBPxGWBbemgKklZKZhHkQXa/R2
   K1Kt+N8lI6j7eeiHNW33BMCt5UqtTdwqG2G0AdEued832pN9QZJr8i/98
   uMlsS+3fWAE6pFCOnKypQbmOXh/ZtKX2CTO/bkw+eboKjxlKVf+yZs7T1
   Q==;
X-CSE-ConnectionGUID: 5Jqil+ySR+OTwNDILsEtDQ==
X-CSE-MsgGUID: 2JoboF86Qme5VAvwjHbeaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90552044"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90552044"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:55:02 -0700
X-CSE-ConnectionGUID: xHy97j+zREKaAjawrfJM2g==
X-CSE-MsgGUID: y9lh1ngVRBm3+gatVEr4xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279482741"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:54:59 -0700
Date: Fri, 2 Oct 2026 10:54:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v11 3/5] iio: pressure: dps310: derive the drain interval
 from the watermark
Message-ID: <ar9jURXU7sW_46RW@ashevche-desk.local>
References: <20261002072526.250081-1-zoone.rupert@gmail.com>
 <20261002072526.250081-4-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002072526.250081-4-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 10:25:24AM +0300, Rupesh Majhi wrote:
> The drain interval only tracked how fast the FIFO fills, so a small
> watermark still waited half a FIFO for its samples. Take the watermark
> as the number of scans to wait for, but never drain slower than half a
> fill.

...

> -static unsigned int dps310_fifo_interval(int prs_rate, int tmp_rate)
> +static unsigned int dps310_fifo_interval(struct dps310_data *data, int prs_rate,
> +					 int tmp_rate)

Better to split on a logical boundary:

static unsigned int dps310_fifo_interval(struct dps310_data *data,
					 int prs_rate, int tmp_rate)

-- 
With Best Regards,
Andy Shevchenko


