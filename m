Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C93191C8;
	Thu, 16 Jul 2026 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224699; cv=none; b=rPQWuLdgcrc5g8BtWzZuSpnnfQnqi8Y3LFQuSg7uSpYpHqTeP79rJRmyqCjX5Q4jj+tje0Rl2yaaLySpRB75CFcDgvV5KsJ3imK+Pm627mLmzVqfGotjTsSC3IEtwQksKKAU21gAyS5RWOyw30eWZAvtLfCoKQJkFCAHEmhrQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224699; c=relaxed/simple;
	bh=vOti2kGn8V7MBQ8WvisPHtf9T5uCpdeegzia9w3+5pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZwrciNFKNtwZuxr6lgAm8n+WI8NAkG9x7fmKONeYHU1MUUjXqaIm6HIlJKQ+G0KRRLY+OpUmN5gb7Be18YGryQ7AK53IG8EO9omRF76elVCGvGYjpgITD4KaiawM/YdzBcvcpu+QrL5VXQOAzDEY97KT62PzwzCb7ehSGX+yZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAciUw0W; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAciUw0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784224699; x=1815760699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vOti2kGn8V7MBQ8WvisPHtf9T5uCpdeegzia9w3+5pk=;
  b=JAciUw0WzxySqB5c9El1nyCxDyjlvDtRObxha2UCvL0hfxRrW5+LdBHc
   ocFEhcZHmRkxuLUJ6nXVxqwOvHCwuO2oLArZCKP50gj0L/jrjV13rROI7
   XCU8kxhutCk/b+BnhWD5rXGBeQPeSkBnW0rw+QTma9DE/CXMPYHnBtE0r
   raqJgtU39ZArHXtTjj5U9uvd50Iq3FXPHQ9Q8QfsyHf0GavAhZ0ecTSVn
   ePM6KvdSKZ5Vb/Z9I9tF4c5adO+YSUCM53lfw0jOH/AxZgOxYGezZ1OHk
   Zr75lsaIJdvoWhy3r2d01ij5s5ITszAhTcauQvWoutoyCnYAhfvBcJq4s
   A==;
X-CSE-ConnectionGUID: 7D09lVHwRRyd3hpAhgpJhg==
X-CSE-MsgGUID: VwsQmoC4R3+kEGrSlYuXVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="88796996"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="88796996"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:58:18 -0700
X-CSE-ConnectionGUID: ET3h5tlZSaS5AMoOEaGeAw==
X-CSE-MsgGUID: oJKBpHc5Sm6L6TyJtjlmNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="250231813"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:58:14 -0700
Date: Thu, 16 Jul 2026 20:58:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Add AD5710R/AD5711R DAC
Message-ID: <alkbtNdOe__XP7ud@ashevche-desk.local>
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 03:59:24PM +0800, Kim Seer Paller wrote:
> The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> configurable current/voltage output DACs with an on-chip 2.5V reference.
> Each channel can be independently configured as a voltage output
> (0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).
> 
> This series adds support for these parts:
>  - ABI documentation for the high_z powerdown mode and the current-output
>    powerdown attributes
>  - device tree bindings for the AD5710R/AD5711R
>  - basic IIO DAC driver, supporting per-channel voltage/current output
>    selection, per-channel powerdown, software or hardware (LDAC) DAC
>    updates, optional output range doubling, internal or external
>    reference, and hardware reset (with a software-reset fallback).

Why a brand new driver?

> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad5711r-ad5710r.pdf

-- 
With Best Regards,
Andy Shevchenko


