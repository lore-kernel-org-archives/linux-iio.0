Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3EF222590;
	Sat, 15 Aug 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786784159; cv=none; b=mmo44YowWbkV9QzKCY15f+DAv054xXXVPbBHkd/XC3OBPZFFzSYTnXb6ZpXLmdIRq7lVMyMywkLF2AjsDrL2FkrvIlej9dKOq7FePWieTD+6kBBb8YPv3tfkmmbCs8Ftr+C00FXCxqm/pQYzxXNVqHF3HtLu/rlx4B4Vldzj7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786784159; c=relaxed/simple;
	bh=vseME+ThQsuEha0ov4cyGgNz4WPdDDtNYFk1lbXsvO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmO9rDJn6ml5oAYLGW+84YpKDmyCWacnZqj2y4q3qWwR+XJNlizrDOrGfJUfLlsDfcJIlwnFRhZh1WMYePe/c+XNR6qLhrUGKt1bO/xnWlzp9imxaD/38tEMNCsvT1KTUMAWgn28oZ1ztmKS/jOWuSyMQe2kLn1lkix4Fvv58Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVfF5ivp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVfF5ivp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786784159; x=1818320159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vseME+ThQsuEha0ov4cyGgNz4WPdDDtNYFk1lbXsvO8=;
  b=BVfF5ivpAklt42Tkb+0TvquFSKa4bleaF5rauxRUr10W+nZIo3IhvLe5
   0jvJG2uvGhff+6WElSHVq52Aoux+zQMgjMlVpLNnqNhKCMQAmxaM6z0tp
   HPX3DsmQScKUh4sRVMWXlLUUt6dNQ4M569TPMehdjKWERTnCO5MVFNSff
   qCUVLnlO8gE3ys7V4lkminh+lDPjlksfim45SVwFxEqQLkJ4EOg76mfKg
   0XUbLkMe3acBC2havPIUn14t0eeG5gj44aoVPfNCl3mK6cJQKTKz5gusY
   KpHPohdrsMODhzVAf7PRR0Xo2a5NYRbBw1aj4acsYtBvKirvjnFVEovpF
   A==;
X-CSE-ConnectionGUID: Nu7yd1aCRsGGAKq8tL6SSA==
X-CSE-MsgGUID: gS+lhOM5SRe4+1trRt2Dsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="104727278"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="104727278"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:55:58 -0700
X-CSE-ConnectionGUID: VyZDSvuWSeaK3VJgMJInhg==
X-CSE-MsgGUID: aq7t0tj2R4atpmjcQVB8uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="287912042"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.12])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:55:54 -0700
Date: Sat, 15 Aug 2026 11:55:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, grondon@gmail.com, linusw@kernel.org,
	hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: bmc150: use DMA-safe buffers for regmap
 bulk reads
Message-ID: <aoApmFuVaErd93wj@ashevche-desk.local>
References: <20260814101845.301769-1-yashsuthar983@gmail.com>
 <20260814101845.301769-3-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814101845.301769-3-yashsuthar983@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 03:48:43PM +0530, Yash Suthar wrote:
> The FIFO and read_raw buffers are passed to regmap bulk/raw reads
> ,which is not DMA-safe.Moved them into struct bmc150_accel_data
> after scan, each aligned to IIO_DMA_MINALIGN.

...

> +	/* DMA-safe buffers for bulk/raw reads */
> +	__le16 fifo_buff[BMC150_ACCEL_FIFO_LENGTH * 3]
> +		__aligned(IIO_DMA_MINALIGN);

Keep it on a single (but slightly longer) line.

	__le16 fifo_buff[BMC150_ACCEL_FIFO_LENGTH * 3] __aligned(IIO_DMA_MINALIGN);

> +	__le16 regval __aligned(IIO_DMA_MINALIGN);

-- 
With Best Regards,
Andy Shevchenko


