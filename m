Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73EE3A425B;
	Tue,  2 Jun 2026 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427028; cv=none; b=JNa+a2XjrElONYjcwnsksAxM/n0ylSFuIltv1sY61GdvGo9qMBQ86pOnmE6gCPN37SQdlYJnBduTpZXQQveWGoD06xqB0Y4YG7fgkO9+ZlVERMKg/GDRLxk6E8jLfZeJ1mJ61oL6XRwoQCHvoVIiCJtwkgCoIYk6+h/ehZTbxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427028; c=relaxed/simple;
	bh=ZQk7u+4LyiXxFy+347YRPWQehz+VD/qLDklVKmmuPOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuMvPMau8oBkjkflQCxQ4KrAgZGPxzrkkv8ABz3AycYsON6ETSOKDrmxFHazQ8C2DIIhUtBCIeQkifSsU8enIZt11bMxeHashobkT6dyvnNKOt3Slu6jLUdUb+FNYFAy4ZsZxXJA33ZbtAjShZq0c1MAY60Ep5KyPhPQmJV5dTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8wRn+yb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8wRn+yb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780427027; x=1811963027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQk7u+4LyiXxFy+347YRPWQehz+VD/qLDklVKmmuPOY=;
  b=n8wRn+ybfOGjDKciIDYyJYjphFFOg0iYq8GXcKrm1Njnbi9JgC/M4GaV
   4Gu0tZvi4xxQBY1dEvUqEWmwjFYMFDpbNsxOqcHpkDnxIYHBkI5NR5F3E
   xJ5oqMcYwxnJG4ytjsoj8+scgOKrnt9TolkkUjSFLcZYHImaIG7bA8gW0
   OLzcv23sb/Ppu9CUxXADfCZONCN7owF9bTu7INygs0c1eNM7lwjcVZU4M
   eUUF1a8CA+b+pMGHtrkJxLqLXsBLH+bupmFDFnWFfZ3+SlbC0L41IV3av
   EomgGF7jtCHYzLM0vaoP1++T++C/qHwb4vV7SonGRBZG1U8GtKvHNwavg
   A==;
X-CSE-ConnectionGUID: jnwYDSU/RpuyfaiofnpCfg==
X-CSE-MsgGUID: X1YMvSvyQSSbuUHFziMB1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80364954"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80364954"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:03:44 -0700
X-CSE-ConnectionGUID: EeBx+c3tQEGGQ0yasj18AQ==
X-CSE-MsgGUID: LwFIYnL/TB+rxzsgl/B7VA==
X-ExtLoop1: 1
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:03:40 -0700
Date: Tue, 2 Jun 2026 22:03:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 06/12] iio: dac: ad5686: consume optional reset signal
Message-ID: <ah8pCvCXEN4bofU1@ashevche-desk.local>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-6-691e01883d27@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-ad5686-new-features-v1-6-691e01883d27@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 05:33:53PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add RESET pin GPIO support through an optional reset control, which is
> local to the probe function. Also, include delays for power-up time and
> reset pulse width.

...

> +	udelay(5); /* power-up time */
> +	reset_control_assert(rstc);
> +	udelay(1); /* reset pulse: comfortably bigger than the spec */
> +	reset_control_deassert(rstc);

This doesn't seem like an atomic context. Let fsleep() to decide what to do.

-- 
With Best Regards,
Andy Shevchenko


