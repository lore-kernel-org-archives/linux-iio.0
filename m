Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87883BD64A
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945406; cv=none; b=hc8/aoPpsEvefqarakwSYCDFDxShAo4vWiaRGCz415nv499rOgWpcjesWAjzTOaKFw0hiw24jpo03zmCffcUT2uTOFPmfdYpU3kFn8wKpoEMy/DRmd7aU1wXrH6Jy3eq2/iToM5zIa795mCCeocc42qrtwDBjTXBYeDFH8xWJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945406; c=relaxed/simple;
	bh=y0YOjnle9MxoEV0RDzy8JSTyGRWGl61deuUjChxjdO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9oNsfcIEBb1Kpg8an//bId6s4EuG5ejsCUWYa8GOiqJxTG+5YjDB5FwJoLrf5iYUgp4PYOCeSg4/vuoTSa7qLBzSJz53Dr1FZnvQkGqnhW8/aE2Poa9RWEzWviAQ38PCFaMow417Qd7VaAQ7ddsGtFHgHFi74++XNm4X9jRPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDnXH+Ni; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDnXH+Ni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776945405; x=1808481405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y0YOjnle9MxoEV0RDzy8JSTyGRWGl61deuUjChxjdO4=;
  b=XDnXH+Ni5OrmndSUdHnBE7ddQ3TEc9sUvGKJiUdnaem+jgNwhLVdV04C
   KrTITPuh9TuM/a26i8d5c7dWrXWFiNuYC4qKLA3cZWPgyVqRdXU9cdIFu
   GVpzmb0Z1JY/XQlhrUM2QT6Qx2p/YgKd18rgW8aXfwWOcRDiUxD56/Bxd
   Q4/1kiJwmEfztfLacMlkqIjkHYqpuKCu51hPXRK05hMSIFItfcUFOc3co
   JzI/f8jHyTo/O+Wefr3LwF3GUvFX2MDhsgkbFs3av1nVoN9nzLKkYN3sB
   Ew+x0zCuOZi/6l+xfsGu1qaymQdF+vWzXcKxuwFzZFwwR1rxfZ4wytTjV
   Q==;
X-CSE-ConnectionGUID: pr2JR5nkRembJ5dh7cIrmg==
X-CSE-MsgGUID: HAgy0AwLQ4Cwr6gXHj5gGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="78102605"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="78102605"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 04:56:45 -0700
X-CSE-ConnectionGUID: TlbcJidrSFKkHP0mmdtTrA==
X-CSE-MsgGUID: efXSj7QITyCwpz5iUPILtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="256122442"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 04:56:42 -0700
Date: Thu, 23 Apr 2026 14:56:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org,
	Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp320x: Use guard(mutex) for lock handling
Message-ID: <aeoI977TRD08FB32@ashevche-desk.local>
References: <20260422211105.48158-1-eduardoaugustoabc@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422211105.48158-1-eduardoaugustoabc@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 06:11:05PM -0300, Eduardo Augusto wrote:
> Replace the explicit mutex_lock() and mutex_unlock() calls in
> mcp320x_read_raw() with guard(mutex)().
> 
> This simplifies the error handling paths by removing the need for
> the explicit unlock label while keeping the locking semantics
> unchanged.

...

>  #include <linux/mod_devicetable.h>
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/cleanup.h>

Please, start reviewing others' contribution first before making your own.
Also learn from other reviews.

-- 
With Best Regards,
Andy Shevchenko


