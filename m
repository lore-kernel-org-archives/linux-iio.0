Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8B3E95A4;
	Wed, 17 Jun 2026 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691486; cv=none; b=BVk/HQp+kWMqad1tIPmwsOEe0G9oYC6RQTUtawH+kwlbQzUavlENjaB/jpHVnnOEK4stse6saP3cc36+NKIc8aHp7BF/cjFp0jwcf1g80WBECvZf+4QknybUn9k2u/K34iaFRLqK7KKPbcUuaHDo3KXWDGssmBR9cj/xcfOqblY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691486; c=relaxed/simple;
	bh=wEXUdAM0i+d67WlNYLTgHN4Ff/l3zrbR7arGEJe1OVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOFDg6z6GUpii/n316F233qwFX3WPlb4MSDneTWZghlyyZWN/r5tK/1FLFOrlSS08MuQSHGTTgqodnofRu3X5anRRCO/l/FdT7ZQYcSYx58SJ2ye/I8mw6MPnuAes8RDkgA4RBuplQvnEOx7ouUOk5G6fF58XWmKdcWgW+sOzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfy9zGTA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfy9zGTA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781691486; x=1813227486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wEXUdAM0i+d67WlNYLTgHN4Ff/l3zrbR7arGEJe1OVg=;
  b=lfy9zGTA8fCkc8ZD9zawwJ8dwTsN3mllEFDhUBWBRqgb/Sp6qcSIDyOn
   qTMyKO0s5BVpBwzsp+es/gE+MDYnF6GU30dqM3IewC61pzhPgKC19wJUi
   iK+NxBhrNuLgyCKEJrO8FXySQhOxX7G3MTNejApnTOpkK3LWelHGW9Ofg
   MTvlR/DO0U89xW1TsSyZW8psQH7zDw8EegxGQg8AWd+p6ZH/FloHwWDs8
   2D77WuCjKC62jJFWOF4V2kKRdTZEQ4EupGupJ3MIM39VyB3nsd8GWFJch
   LAUhF3Gy9xXVuRX7xgUMWUVCg7RHF4KwcHtfrDnIGLX5kcBRe7XjL8oPF
   Q==;
X-CSE-ConnectionGUID: HvIXEAc9Ri6HTT3xeGRy3g==
X-CSE-MsgGUID: T/UWsh4CQx6SUfbubtvuyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82358523"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82358523"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:18:05 -0700
X-CSE-ConnectionGUID: Fmi+y+VoQgGfhgD5C2DmZQ==
X-CSE-MsgGUID: H6sGZf7NQoS19rZCkgIT7A==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:18:02 -0700
Date: Wed, 17 Jun 2026 13:18:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: hexlabsecurity@proton.me
Cc: Remi Buisson <remi.buisson@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3] iio: imu: inv_icm45600: clamp the device-reported
 FIFO sample count
Message-ID: <ajJ0WNBPyd_ui5ie@ashevche-desk.local>
References: <20260616-b4-disp-76e3f743-v3-1-c20930aaf1cb@proton.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-b4-disp-76e3f743-v3-1-c20930aaf1cb@proton.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 08:57:28PM -0500, Bryam Vargas via B4 Relay wrote:

> inv_icm45600_buffer_fifo_read() uses the FIFO_COUNT the device reports,
> unclamped, as the length of a regmap_noinc_read() into the fixed 8 KiB
> st->fifo.data buffer. The only bound is the caller's "max", which the
> interrupt path skips (it passes 0). A device, or an attacker on the bus,
> reporting up to 65535 makes the read as large as ~1 MiB: a heap
> out-of-bounds write of device-controlled data.
> 
> Clamp fifo_nb to the buffer capacity (INV_ICM45600_FIFO_SIZE_MAX /
> packet_size) before the read, mirroring the watermark cap in
> inv_icm45600_wm_truncate() and the sibling inv_icm42600 driver. The clamp
> is a no-op for conforming hardware.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


