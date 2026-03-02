Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E3423A72;
	Mon,  2 Mar 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469733; cv=none; b=i3q7YaDSBpk4ATaUEObm7CS6mFzqJuiEZ/iqeCZlpYgKNq3TJvsgS4emZCArPtn1OzXPnEm5cJnCERJGGaFxLjCsRLoGxt/wL8ZcN+PwABR4c/z8oWT/rAP5dWcEMTv3N7UqN4qX5mIq2a9yr9FHU/UnokVDJACf1SGUW/jHxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469733; c=relaxed/simple;
	bh=9XDEDYBd4F11QAVarC2gZ/JmAtTPbLL/oW2R+Gtb/Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXDht7cafCQAt6EUiUzJP1ua4QcUKp9BZeFjzTQ21y3l1Rw9M4lCjyUooWaqLBbQe/+YuRArKyzQCltktstm+0ApBnEnHfw6yXDL140xtHtZw2dlPC+19bV5QB/4MHum5YQN9UCJ8J0d8KmGcT+XsSzoITNZWupaxhrNCeixmPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBonQ0Jb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBonQ0Jb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772469732; x=1804005732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9XDEDYBd4F11QAVarC2gZ/JmAtTPbLL/oW2R+Gtb/Y4=;
  b=nBonQ0JbccMX2uE6UO98vZRk/Xg+L6OPQP6hWYukXVINtJq9FWVikcYR
   t88mll8m32S/qDbuxRRJaZMLohAESarTFAqUhWvr8HPl242pj/5cyaY2+
   2uzm3Z2/ghkf+Vf2qG43K8Sq2OUi5JeIFpjReKwyUah1kqEl7gzYF1Bwh
   O/LdGm1y1+QR/Bm4fJlzBuWkgMe/ykXc9RH83lNu52JKyWSQFzpp2BGpJ
   AksI7bYRJoLDsd4z7VHm5h5W5rydZICD6dsfYiK21aOs5Y75z+ukSZatP
   B19733QpOmE39kSsa6pQsBf7QpFRa2xnI2PPB8yxHv/7pEzWDhKSm4wO9
   Q==;
X-CSE-ConnectionGUID: FANhV4obQwaoGvGvnIFaog==
X-CSE-MsgGUID: rLrp5xDtR9KsDBqHqy4aUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73547944"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73547944"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 08:42:11 -0800
X-CSE-ConnectionGUID: ga7Y+cpcRi+Off284R9pVA==
X-CSE-MsgGUID: T9EJ/fp4TkyAfnCdbreE/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217816908"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 08:42:08 -0800
Date: Mon, 2 Mar 2026 18:42:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Message-ID: <aaW93QGdN25mqFUA@ashevche-desk.local>
References: <20260303-ti-ads1119-v1-1-71b54880edf3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-ti-ads1119-v1-1-71b54880edf3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 03, 2026 at 12:00:04AM +0800, Felix Gu wrote:
> Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
> without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> in IRQ request and gives a warning if there is no threaded handler.
> 
> Since there is no threaded handler, replace devm_request_threaded_irq
> with devm_request_irq, and replace IRQF_ONESHOT with IRQF_NO_THREAD.

...

>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  					     "Failed to allocate irq\n");

Also consider dropping this duplicate message as the callee does it already.

-- 
With Best Regards,
Andy Shevchenko


