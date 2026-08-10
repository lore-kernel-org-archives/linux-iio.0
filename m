Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2359434407;
	Mon, 10 Aug 2026 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392552; cv=none; b=Vnodr3OzH+/91S6En/+R1jhut+ZTsuhyQolmfRhy5Ca1X9UScB7ojQZR1hoQ3UWfblm0a9X19Ol51gPDHr3AimQTY/tDtv4KI4g6P98kAo27Ib1eCkcZkNpLPmuVos/qrTVSOy3NdoO2noN1C73ZVSjcAP7W/vg+LH5bGc1XiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392552; c=relaxed/simple;
	bh=YpngZ9Bfsdt3fMXJC57bZqYf4bniANnpg/maoX3eins=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miw9yUTuFGPNeIn4NKo1/InnqTArabXALYYxJrTQE/dSTdsFk/wOBEdTxs7dcwJNkK6iEZ9xVL23i0Jp9/Vdb1+oALcZd3m4+gAAZOXGF/7wX9vUllAMwyBxXL2Z/Ooz05lRc4DZT+uk5uHPac1Sxh7k5mo3/Mtt0iuYOW5gg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igPRiUtZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igPRiUtZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786392550; x=1817928550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YpngZ9Bfsdt3fMXJC57bZqYf4bniANnpg/maoX3eins=;
  b=igPRiUtZxjpBbMVKORGHbCiIo7qJ1/pnG+SDDs1fBUEgLQMoa6yi0IQ/
   nX5kL26QC6FdKq3XZcAE/F9wobBQo4/jSdRCNfWrjPAHgmQTMSa70oi31
   +HJ5mPwGyaagxyqzOl/MYu0ogslAFG/tpSLis/XqX8N0nR0mGVy3TVyle
   NwTu15oGAVTM+ntNHlKuOzqRMqfq5ihFX/k0WfAcde9U2pxTOBbFzI0x5
   cHBYN3tZbEO5WUV5X7/VL/rXek5BhWoIxa0vpQbV+buG2eImHILdf278U
   9pY5JbjC64vYWOQ1OpTwwR9ra1Yme7HYXkDVW9ey3nwVnrFpvj7ePo9ng
   w==;
X-CSE-ConnectionGUID: QdKuUM/+QlSg1BnAx4pMdw==
X-CSE-MsgGUID: 6qeDJQ29QEWBHtw703ClbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86943346"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86943346"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 13:09:09 -0700
X-CSE-ConnectionGUID: Lochv8MbRw2v8TFcrsnEoQ==
X-CSE-MsgGUID: ZlamzNP3QoCQvevOXZMdvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="262632333"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 13:09:06 -0700
Date: Mon, 10 Aug 2026 23:09:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 09/12] iio: light: rohm-bu27034: Fix infinite delay on
 error
Message-ID: <anov33hvjioArKpw@ashevche-desk.local>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <2601f407f145ea77733280fd1e2370dcdb4b69e2.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2601f407f145ea77733280fd1e2370dcdb4b69e2.1786347811.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 10:54:04AM +0300, Matti Vaittinen wrote:

> When reading an integration-time fails, the code will use error code to
> compute the sleep time.
> 
> Fix this by using the smallest integration time as a default if
> reading fails.

...

> +#define BU27034_INT_TIME_MIN 55000

#define BU27034_INT_TIME_US_MIN (55 * USEC_PER_MSEC)

?

-- 
With Best Regards,
Andy Shevchenko


