Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670E37880B;
	Wed, 17 Jun 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688706; cv=none; b=IwVqIzBZ8jQ4EPp6JBOB1Vc8S+2AXctZA+aa7dcQ7JbIjZDAPz6a42h/IfsuEKC40MTxg1BMdhAyqkUiKUke719pUDM0dMZcBhrALKD8NZaqNn3pOs0GhHTySXPibSuo4lvEOIj8JHF68RTsKH60DtEtiJgI5btSdu8PhaK45z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688706; c=relaxed/simple;
	bh=d04o9Z94VpuhEZ52SAkH9ZLcQLVemN5/ad721qLmT2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/+TmmZCFxkUwYbwXOWkab0s4RVdUaBVowxN7qi46tsMpdpngyxyXWMDxSgon5rkUrXja1zMhKwcGe3vn81g4TiSODbYIid8AmGqYo6j+PJyKr7p4t9xmy+c6Kie2nV+MbPBRdR56C3l1apdWNzsGxeZRYMNd9k1n82/XLZrJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZSV3tlV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZSV3tlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781688704; x=1813224704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d04o9Z94VpuhEZ52SAkH9ZLcQLVemN5/ad721qLmT2I=;
  b=DZSV3tlV78AN0YUlYoL3Z5lJ97gUjsFtjA1kC9k7isPmruGISpLeTJZj
   m7ZawGvYrVB6RSkADemdNV48DzzCFb25D2GuoXmbVItqxsdTtqh8enYg5
   vnE6c0pybnUNdFuT8gn0Bk8oB5PjAufYtvKXNZM1fEGwCaX4EuDB3gevb
   piGceFV3z1LOlRefSHwq9JLrxq2BiT6v4Uc2EEunoxK8zmeKBXhc0ta+y
   ZJp+vUqfGNUBLFlVYOp7ug0x1/CnE+plOnaO1FGQnjsAOqGB1SkVA5iNY
   ajxmeZ4lkeztPYhS6hRu0+BKNtCpwiRoCE6FqvqRwEQQCA0k+OVnLvd7Z
   g==;
X-CSE-ConnectionGUID: wZCK9ykDRp6jNSO/FeKxpA==
X-CSE-MsgGUID: mw9ej7GhT/Cl7oXhnKg2Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93141943"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93141943"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:31:43 -0700
X-CSE-ConnectionGUID: 7sQftczmTB290X5GoDEGPg==
X-CSE-MsgGUID: deAacQA0Rr+SVGnQKg4vVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="252972881"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:31:41 -0700
Date: Wed, 17 Jun 2026 12:31:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: hexlabsecurity@proton.me
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: accel: bmc150: clamp the device-reported FIFO
 frame count
Message-ID: <ajJpekcHULrcCbU2@ashevche-desk.local>
References: <20260616-b4-disp-9546bfb4-v3-1-5acc59a06636@proton.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-b4-disp-9546bfb4-v3-1-5acc59a06636@proton.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 08:56:51PM -0500, Bryam Vargas via B4 Relay wrote:

> __bmc150_accel_fifo_flush() transfers the frame count the device reports
> in FIFO_STATUS into an on-stack buffer sized for BMC150_ACCEL_FIFO_LENGTH
> (32) samples, but the count is masked to 7 bits (0..127) and the optional
> caller budget does not bound the flush-all path. A device, or an attacker
> on the I2C/SPI bus, reporting up to 127 frames overflows the buffer by up
> to 570 bytes: a stack out-of-bounds write.
> 
> Clamp the count to BMC150_ACCEL_FIFO_LENGTH before the transfer, mirroring
> the clamp already applied in bmc150_accel_set_watermark(). Conforming
> hardware reports at most that many frames and is unaffected.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


