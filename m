Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F4363C60;
	Mon, 24 Aug 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561537; cv=none; b=Oy6rH3fP+IZYf65rgpSaujUbDv/mNoKS6w9VOu18aX+OsqzEjlqOqwNW5wLCIXNt2As/i8hr5lRfHnqUfWkKbkII/tyqn2iTWVt5fkQrmAv6USvpd6vngW7jfKPd3rxcBK0wovcGCkKnBMgvUl4Jp0rV+tBdwKv/pMJrcU7o5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561537; c=relaxed/simple;
	bh=Iy+AUYgH7I/yc6KcT5TAsfE6qVn+hg82lZl9seShSVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enFkcaRrvw4p2qZXSpy/2yE1oSxRfPTULn00UrQE6EJYTWfFPe4xMOg938Vvjw8EZJPt4aLyIwt3umZxqiRHHnY5FY1JLGwQN36vfxmXcEBlRvov/qbafmFc1/CPV1ERniTrhaiNtKb/4ktbncGrvcV0XCoKifLVAJVsYscvbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Thq6wqsv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Thq6wqsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787561535; x=1819097535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iy+AUYgH7I/yc6KcT5TAsfE6qVn+hg82lZl9seShSVE=;
  b=Thq6wqsvM2KPIQmQprOXR8U2VLPGMGQBKoLB43lRZr8fLz2YzgQ8pikl
   HTmionhDni53x7UyNYtHoGoRfOh4CO1vAhvRGzOhJf0jawyJgjHhWrHE7
   TNzZnXUDvmjPVZxOzBkim+mAm1KUaDptdezTmcFkyqtEKBMPe2j9RWGIt
   MPSBl8PPYBh48Bb9Bll7cmXFChC+73Bw5MlddPfK3eMD11nz9WHGTKadp
   Q25/hSVdQcPN6Zdw3h5m1GMC0/nbJjwKjVCOB5jltyEY7MfnKl6p69cDN
   mvFG2Df0i3WHXVS7yNgzhn4o9JcDMiOXXA3l6PvTbJ0nnDXcUkiFRP2ya
   w==;
X-CSE-ConnectionGUID: +DCKLkfSSS216FPp9WyHTw==
X-CSE-MsgGUID: 4NuWBgycTT6IWV8cwzll9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87867829"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87867829"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:52:14 -0700
X-CSE-ConnectionGUID: CvyjZIybQ4uEs7JizgN90w==
X-CSE-MsgGUID: LvmDKid4SiyuAFDd1U5H7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="272156142"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:52:09 -0700
Date: Mon, 24 Aug 2026 11:52:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v5 2/3] iio: imu: inv_icm42600: log whoami mismatch
 instead of failing probe
Message-ID: <aowGN8Ln9QMN6k_D@ashevche-desk.local>
References: <20260823003320.62192-1-jorijnvdgraaf@catcrafts.net>
 <20260823003320.62192-3-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823003320.62192-3-jorijnvdgraaf@catcrafts.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 23, 2026 at 02:33:19AM +0200, Jorijn van der Graaf wrote:
> A WHOAMI value differing from the one the compatible implies aborts
> probe with -ENODEV, which prevents a register-compatible part described
> with a fallback compatible from probing at all.
> 
> The devicetree compatible is authoritative for which part is fitted:
> log the mismatch at info level and continue. The message keeps a
> breadcrumb for anyone seeing an unexpected part change on their device
> versus the devicetree; tmp117 takes the same trade at the same level
> for its fallback matches.
> 
> A whoami of 0x00 or 0xff still fails probe: SPI has no transfer-level
> ack, so those values mean nothing answered. Otherwise the probe outcome
> on mismatch changes for all parts the driver supports. The check sits
> before the mismatch comparison; it does not depend on hw->whoami, since
> no supported part uses either value (the WHOAMI values the driver
> defines span 0x40-0x5C). inv_icm45600 carries the same guard nested in
> its mismatch branch.
> 
> Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
> ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
> and matched as icm42631, probes with the one informational line, and
> accelerometer, gyroscope and temperature reads work.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +	/*
> +	 * SPI interface has no ack mechanism.
> +	 * 0xFF or 0x00 whoami means no response from the device.
> +	 */
> +	if (val == U8_MAX || val == 0)

Not sure if U8_MAX is better or worse than simple 0xff, but either work for me.

> +		return dev_err_probe(dev, -ENODEV,
> +				     "invalid whoami %#04x expected %#04x (%s)\n",
> +				     val, hw->whoami, hw->name);

-- 
With Best Regards,
Andy Shevchenko


