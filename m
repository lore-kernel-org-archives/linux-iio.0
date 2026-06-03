Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8BD3FF881;
	Wed,  3 Jun 2026 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473577; cv=none; b=VrJoHgEYXWPJmPl7ipS0MUNzQiU35DinfVZrc9GQe+6w0QbaFy27JJ4Qd3yHD6sOw/mMqhJIaFxz/UtLMqACC8XRDyhRcCOqla6ghT28YAJ3XeHFtqYFy8SucDDbnb7lY+74iZcu103AtyLHffZa6le1Q3Ql8Qy5SNgaAdJaSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473577; c=relaxed/simple;
	bh=g9R6Pj7IedGiVjGt0NYiN3746tmR1kvMrqdl7k6vDVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEu0yfMZnzHXKHTp8WjACZjYIppvIJb1n3chiyQr01fXKYG2tWq5wSrwdHHRepje8tt1T3QMhX6t/mle68D46Y2toNAqPU2J2ncjFJUCAAtJWRezDa9fcv3CyE6NsE90c/8irbS757QamPpBmRi8HkYZnpRVOtjtqwbd/xsWG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngqUzRym; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngqUzRym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780473577; x=1812009577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g9R6Pj7IedGiVjGt0NYiN3746tmR1kvMrqdl7k6vDVY=;
  b=ngqUzRymW9x2jHSnbFoKcfyLsI3Xc7dPpnj4S6z4+yWIX7g1SLmBj4sG
   rt2cB0ygRdFxB7QQW2rEeVjSA3FIZW1oA8u9y+yRL+BfwPbDA9PHZGoDd
   4PUe6P3wdYKBmC7cq5Wu4MzdNGJtxv1ORt91rrp5FKVHZmb8jfyNMhuqU
   bpWQGpNoxQmEyjS5m+ywIH4OPMn9XYgKNPHLiZYt4kxOGaMucjZ1u+3u3
   8U6wASUPyGohyPWGwns3iTDuCfd+dLpJ27QmA9YQ7eSkKrDbSanBtgVRN
   SlSkdjjquqDI4ZrVmcOp43coMSL7ScmJPE58sCZ/w08jiDlnbhgHPTnCq
   g==;
X-CSE-ConnectionGUID: agSXjQD6RvqGhpqTZEtg0A==
X-CSE-MsgGUID: qp0O/t/vSt2bCmQc8BH3CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81454380"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81454380"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:59:37 -0700
X-CSE-ConnectionGUID: petaq8DTTq2v4Q4wLo954Q==
X-CSE-MsgGUID: 3vFwIrwwTXOZ009Dy6GzBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243296934"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:59:33 -0700
Date: Wed, 3 Jun 2026 10:59:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pop.ioan-daniel@analog.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 0/4] iio: adc: Add support for LTC2378 and similar ADCs
Message-ID: <ah_e4ovBsXQ-BVcw@ashevche-desk.local>
References: <cover.1779976379.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779976379.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 28, 2026 at 12:02:53PM -0300, Marcelo Schmitt wrote:
> This patch series adds support for LTC2378 and similar low noise, low power,
> high speed, successive approximation register (SAR) ADCs. These ADCs are similar
> among each other, varying mainly on the amount of precision bits, maximum sample
> rate, and input configuration (either fully differential or pseudo-differential).
> 
> The initial support patch enables single-shot sample read with a GPIO connected
> to the CNV pin.
> 
> The second support patch enables high-speed data captures with SPI offloading.
> The setup is similar to AD4030, with a specialized PWM generator being used both
> for SPI offload triggering and conversion start signaling.
> 
> The last support patch enables running buffered data captures without SPI offloading.
> 
> Some structures and variables are introduced earlier to reduce diff in latter patches.
> 
> The initial version of the LTC2378 driver was developed by Ioan-Daniel. Though,
> despite of the many changes I made to the code, I've kept him as module author
> to provide credit for his work.

No datasheet link, no explanation why the brand new driver is needed.
No need to resend, just answer the above questions.

> Link to v1: https://lore.kernel.org/linux-iio/cover.1779117444.git.marcelo.schmitt1@gmail.com/

-- 
With Best Regards,
Andy Shevchenko


