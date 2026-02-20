Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2172D7384;
	Fri, 20 Feb 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574448; cv=none; b=JuozfD+qxYs8lyc0oSx8d4dGwXGam2VEO9UIu+i70bQQnkVxo/A9Y8gAv2Grssp3EEROjMbWw4WYDBROgUwQs8hVMtab7zksj2vRFIuLHyxcID1N+/s8usTVXT/M9AtiV+GSW3U3gejdJ2FigRMFzWCy5ZGo5/pq/eh94a8/FBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574448; c=relaxed/simple;
	bh=u2j53cj3ue7x7sCrL+F4jVz1giBzQrJ6XhcElglrgx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKIMMZH0uJRXZHQNzjZwl6wyjfw+de/+/cy/HX0ku7NXNK2okxTyUubQwL1ygQY3Pj3IIbLcBawKngdqgmf2uvEFI9gEds/QZECi+G07vlyfUBCcMzu+LxAD136DTBpCwGE+v+dk8uCHx/tyju9YjthY5hC3Bhk+YHNpJdNMdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=na63x2nz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="na63x2nz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771574447; x=1803110447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=u2j53cj3ue7x7sCrL+F4jVz1giBzQrJ6XhcElglrgx8=;
  b=na63x2nzgCTp5bqAqSjtA3mDvHNlY3A0wMJp1ETk1OnF7p9UooyfwsFm
   NPh5QYDBRYh/D+yOv4gWLK24Xr6aa1OtiWhZEAO831uIHFZvrbmlEjJl8
   dY0NlFMLePW6XGIacIaQ010RALf8/P5CiE6JtvrkQPOV1iqbY7Z+IhZ90
   E8xvzlEw4BbzL+yviT5A0p95hUi9HC7Gegaz/ULp4DYhr9BkoDB9OOVhO
   +mnvJSaxdTVh/ElSvVdy9HpMDW5oXDyVwF3u0xo3Cyy+NuEnOO1fw9S0W
   jy9PiaXkLWOaCH1squdlA3JPbMV4g5E7z1g1szdJk9P9DwGm9mYxkiDHW
   g==;
X-CSE-ConnectionGUID: B98wQQWRS1WJgjeAEvUZcA==
X-CSE-MsgGUID: hObDWfNCTfiW0dzTW703qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72368861"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72368861"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 00:00:47 -0800
X-CSE-ConnectionGUID: oT17aMYHSkGNjv9BNnMgFA==
X-CSE-MsgGUID: IYFnq7SARIaMZ23/QCe5Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="218922082"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 00:00:43 -0800
Date: Fri, 20 Feb 2026 10:00:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
	git@amd.com
Subject: Re: [PATCH 0/5] iio: adc: xilinx-xadc: Add I2C interface support for
 System Management Wizard
Message-ID: <aZgUqLwuy8xJ4OZ3@smile.fi.intel.com>
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 11:09:36AM +0530, Sai Krishna Potthuri wrote:
> The existing driver only supported AXI memory-mapped access to the System
> Management Wizard IP. This series extends the driver to support I2C-based
> access, which is particularly useful for System Controller usecases.
> 
> Key Changes:
> - Extract common probe logic into xadc_device_setup() and
> xadc_device_configure().
> - Add setup_channels function pointer to ops structure to support
> different ways to configure the channels.
> - Replace module_platform_driver() macro with custom init and exit
> functions to support multiple bus interfaces.
> - I2C interface support.
> - Convert binding file to YAML format.
> 
> Note: We are working on x86 platform support where fixed channel
> configuration is used(no DT support). The setup_channels function
> pointer introduced in patch 2/3 enables different channel configuration
> approaches for various platforms.

Thanks, but this series (and driver) has to be refactored differently.
Please, go back to the drawing board and redesign the approach.
We have examples of the drivers in the kernel that are using platform
and I²C approaches.

-- 
With Best Regards,
Andy Shevchenko


