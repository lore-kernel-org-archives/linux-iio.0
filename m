Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2E3B19B5;
	Mon, 14 Sep 2026 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373927; cv=none; b=S5/enQOdM8fzGrpLdiKx60019LtBJ+VZkuDEpxnEpcWo4Wdlkub2/gQslUwOMkgsFgYkv1B1jR8QMEeqKZ0Kgk/zpPsLEJ5uBt4VGORTp3Phlb3+Ujld4VJT8MLgBChEQecELlxdlI7dYWCt1gdIxFpZVXfWVQ/xIB0EWXgj4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373927; c=relaxed/simple;
	bh=HSTVGACL4y92fxENAWrSotM1ZWJTJr8vPVzH7e3JESo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsFAYuHBvvvq+aZH4V4VmJaMVCl0xQVV/RK3DOsZM679pAVcitZH6Wl/mCeC5Alt7/XZxv9l2nC+nTzjp1Kpx1KPrjKNzoxHNveBOEgt504yqD3NKQviZWL30KcfbHppDwsTqZVzMaqUGvaUQ8u8ckziI1oUoZ6vqqMpHwGWqBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGcBEmuW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGcBEmuW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789373926; x=1820909926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HSTVGACL4y92fxENAWrSotM1ZWJTJr8vPVzH7e3JESo=;
  b=bGcBEmuW9U+hyCDFnZsLPf/lrisM8lpoWJ8UFmQwJKBSWaGkemi4XP3Z
   aky5F3CtIUaWiJgbQKZUrJohHboNTuiTWvMmywd1c7tjzAcO4H6XAsetN
   hx3ERHlGsrZ4Bz7iCCBjwSYYXg980MinXd9frS6aeiYHYKxPfgqq60bhQ
   m/92z4XmA7Gqmu1iwmcPwaP2rUeztNnxyAQhA6mxGYSI53AtV5Qy8M8nm
   DPz4BixLxTOmTqNfiGyHi/mOTY40JWqGHLWTusN7Txi5igZOqprqSzh0T
   XL04qpuewqeYeoVj7zerg4hPufBKgUYSyBRZNirfIWWixRnfK5jPjr1sC
   Q==;
X-CSE-ConnectionGUID: PoaGpGLkS721Jtb9dcA5VA==
X-CSE-MsgGUID: 5QQiMC4USsqnTVOfj9YG1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="112493230"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="112493230"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:18:45 -0700
X-CSE-ConnectionGUID: wCTH24emS0O2A597s3NrpQ==
X-CSE-MsgGUID: ZE2lm9ESRRC4sNw3twiUqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276734201"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:18:41 -0700
Date: Mon, 14 Sep 2026 11:18:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: accel: adis16201: add SPI device ID table
Message-ID: <aqet3xwqe1jfhXpW@ashevche-desk.local>
References: <20260913085307.13846-1-shehryar.amd@gmail.com>
 <20260913085307.13846-2-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913085307.13846-2-shehryar.amd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 13, 2026 at 01:53:02PM +0500, Shehryar Ahmad wrote:
> Add spi_device_id table for ADIS16201. Replace MODULE_ALIAS()
> with MODULE_DEVICE_TABLE() which automatically generates the same
> module alias.

> +static const struct spi_device_id adis16201_ids[] = {
> +	{ .name = "adis16201", 0 },
> +	{ },

Learn the style what we use (hint: check last max half a year old new code
in IIO).

> +};
> +

This blank line is also the subject of the common style.

> +MODULE_DEVICE_TABLE(spi, adis16201_ids);

-- 
With Best Regards,
Andy Shevchenko


