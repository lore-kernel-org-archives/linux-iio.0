Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C31476046;
	Wed, 30 Sep 2026 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760096; cv=none; b=nAWvzwVr7zDBG41n64oJUnzd8N9gsV+h5nKZ7DphghfNDiWanq/dqqq9tjvP1kudNmKVpuzHkpM8/5HiIkmwHh8QPkhvfDvL1sFn2BjepfPz+dI2wBVaNNKi30XPA8OzvVXDZ0S4uU1rKTmmoQEmbHEBs27z3A6lfWTWR+Omc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760096; c=relaxed/simple;
	bh=o4mzAhdtR3ZyMyeMHr9MsCfbRcoP52IE2QYJBsA2YaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uewzi+f4l80yZ5YKbQ182dd0IPJBlu5u9AIhUtoZsWtudsADpu9Qm9vjLGiC7AyewzeipGIRaodNMzQgOJYF40T+g83i8skTeAP/SrV1oBT/I8+Ko9thzCS03VlYCk0ybUNr000WXk2qdqtGu1NsUFpw0Mrap1DA2GZTsERKmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcwpzGTq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcwpzGTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790760096; x=1822296096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o4mzAhdtR3ZyMyeMHr9MsCfbRcoP52IE2QYJBsA2YaM=;
  b=CcwpzGTqObasAgGTmVxsNSbrLD3ahgE+vzoyCR5h6gWrYZ/Cds08oYPl
   fHYvTJeJNno/y3DHOEj6F2F9KZXbisA8q9yR+B4v+XAfEMEKpV6t/Uxw5
   FAD5SI3g65nTV836gcF298t4ceMuR+mnPwz1f37623VKuhMGB7CkirA+4
   McU1IqFehR0MbVocDM6M1EjTNuU8a0uB0d1ds+eExWxEo68B3rRLc7+b/
   5hFe3/emeWgdnizmB3tlxr9i/EXW/2TG8dP9bM40tn6/7TgtaNsfK7uYk
   j0wU1j1mc92i6kAtDejc1xNECv0UiAMoVrqRxs2yRkQP2B7R8ooBdGBOC
   g==;
X-CSE-ConnectionGUID: radu+FPOTSqq4Acqsb+1kA==
X-CSE-MsgGUID: 2kAje0+hTJ2WmT37KCQv5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="101657176"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="101657176"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:21:36 -0700
X-CSE-ConnectionGUID: 6n4MU58uS0qM1es9KTtW9A==
X-CSE-MsgGUID: zRk6/kJpRlyOuik0gf7fXw==
X-ExtLoop1: 1
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:21:32 -0700
Date: Wed, 30 Sep 2026 12:21:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, linux@analog.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com, error27@gmail.com,
	narcisaanamaria12@gmail.com
Subject: Re: [PATCH 1/3] staging: iio: accel: adis16203: fix inclination
 naming and remove unsupported Y-axis
Message-ID: <arzUmYfK6mbznNre@ashevche-desk.local>
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
 <20260929184900.39515-2-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929184900.39515-2-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 09:48:58PM +0300, Abdelnasser Hussein wrote:
> The ADIS16203 measures inclination around a single axis. As per the
> datasheet, register 0x0C gives a 360-degree output, and 0x0E gives a
> +/- 180-degree output of the exact same measurement.

> The current driver incorrectly maps 0x0E as a separate Y-axis. This patch
> removes the phantom Y-axis, updates the naming, and adjusts the timestamp
> channel index.

Read Submitting Patches about imperative mode (search for "This patch").

> Note: The ADIS_INCLI_CHAN(X, ...) modifier is intentionally kept to
> preserve the existing userspace ABI (incli_x_raw).

This is a staging driver, why do we care about ABI preservations?
Yes, ideally it would be good to have existing user space software
continue working as before, but if this adds a confusion, better to
rework an ABI as well.

> Furthermore, removing
> the phantom Y-axis inherently shifts the scan indexes of subsequent
> channels down by one, which is expected to correct the hardware
> representation.

-- 
With Best Regards,
Andy Shevchenko


