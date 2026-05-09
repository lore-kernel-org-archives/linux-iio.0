Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801793803C6;
	Sat,  9 May 2026 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313409; cv=none; b=HEWY0ievspF3KvQVJ9lP2H3CVqbwBkAAao7iT2rniNLY6p9KEBml+7IidtSYcOO8dR4JPPk12u+Oz6uvKx05DgptyEJ9iKMmbrY7HNvjtIyE2Dw+qeNXOqSBwYco6+iZT9cU1/iUNCD9TwMqLp5ojmXBJAgLRrfPSkEcaKAxQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313409; c=relaxed/simple;
	bh=HXwaMbnselTHrPdCBRbV99HFwRliqfgrtdyjUpj1g48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgKCgs5e2G2K0yIlBq+cOD09WKNEGqPVfMxibGcu4/swb5aqTppBGEmjY9ibuFUBHmZkZG/hoNAT1UNQngZip87z4yKwzKTta5oLf1Rgje9ZiyU2cEmTjSQ8z/0tRh34m+PL2BSchuA7vrTJ26bmF5paEpM1jBGjPT/heIcdDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lb6vUtCC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lb6vUtCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778313406; x=1809849406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HXwaMbnselTHrPdCBRbV99HFwRliqfgrtdyjUpj1g48=;
  b=lb6vUtCCKcDJOWAuh3Tt5pgxtrcbgkXhXcH2Xk4oltm+txrw3lyL5WDg
   op7ipTrFwDs4hFXWd/kY1lpnjp7U77J7Aym3ZoImsROVNzF6L4Nka56cM
   L8YZJ+SRHo9kTDbw2NkG6XWXor++TsusPRzCzxSWkY0PADbXbkTm/Ljet
   bICqzksBHP7S0vkJM9+A+VcGJsbNfFcJavVnOxQolI/pGLk9CWJkSVs8l
   aGWOIWmKawuVVdawhox2bgfWqh9t9EC65Iv+AAiYsokjMEAyxYTIxHkBw
   zckEREp9ZuOD1XnKMmEAI/bMmCRxONW3jy6KHLTMgNhkjBiwyyRGxXYq2
   Q==;
X-CSE-ConnectionGUID: bLpL8kIzRaWCnAsFVXSpXQ==
X-CSE-MsgGUID: eB4Lg28TR0OApuOOVzAo2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79304876"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79304876"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 00:56:32 -0700
X-CSE-ConnectionGUID: JKQJB5xaQHiKlLtaM2h1jQ==
X-CSE-MsgGUID: yk8tGCEDTCuldKILjcYgUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="232466740"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 00:56:29 -0700
Date: Sat, 9 May 2026 10:56:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v2] iio: adc: viperboard: Fix error handling in
 vprbrd_iio_read_raw
Message-ID: <af7oqt-TDLympDIj@ashevche-desk.local>
References: <20260507190751.28352-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507190751.28352-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 08:07:51PM +0100, Salah Triki wrote:
> The driver proceeds to the reception phase even if the preceding
> transmission fails.
> 
> This uses a goto error label for an early bail out and ensures the mutex is
> properly unlocked in case of failure.

...

>  		if (ret != sizeof(struct vprbrd_adc_msg)) {
> -			dev_err(&iio_dev->dev, "usb send error on adc read\n");
>  			error = -EREMOTEIO;

This also a local variable that doesn't need to be in the critical section,
right?

> +			mutex_unlock(&vb->lock);
> +			dev_err(&iio_dev->dev, "usb send error on adc read\n");
> +			goto error;
>  		}

-- 
With Best Regards,
Andy Shevchenko


