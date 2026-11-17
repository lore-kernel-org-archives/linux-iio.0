Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912480;
	b=Wc/cLFdOw0MhaRoIDAJnLj53xDlzwhlgIqA36LkJYpah1NOGpdW+pNxvB0Zpu6d/cLmN
	 0gTJ6EDer1Uk/yDpo7B/XJudyIcOh4NdGPJSlRz43ZyVF/femE0jSCx2Y9iV3O7kNKpI/
	 amfZZl4R7THGDfeI/XU8k8aoPD/lm2ZSv9aHP7GxO2n+OiQXJgAji6Gvrz3yxY1+/PqxJ
	 TTXMHwgPjQg/Mok12jC39KLGvQ2cr8Q/vg00C1p/ubdzImtZjuZJalkhqwafiR1XeQsZp
	 oDn33EnWHndY0W4jbUqK0Cm1CkZMMGqccrTBDyCiIGW4NvuHzdzg4KV4Eiitpa2AihA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912480;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=JIxCmE/jn2GPb4zKjgDed23TAonlzb2lFWRnVD2IiAQ=;
	b=QsW1r2d7aGpj+XhuBjPz4Qn0PUnoHA4H9KE++ErKA4qSmhHmwFujcv8TPNm2qbRC0PnD
	 WcN1lJQo4pXU6g31/ePiEHUBWtYDGU06AjF15W8uYv86YaRbATO2fpbDDArVOSk/9UA1g
	 EL2OeU65yuETE5gHXH6YlGO1sjBDThXtyBsxw9qetcolnpzuVh8mWmTVlr06xV4NxFqXr
	 dPHB4iSOypV9tKZyIQ6RjRWOVmg2/u0xWnzsIm+n10jaL+JY7HtLNsyf6wD2BDQxwXhLa
	 5LaRId5XA5VikF1B13emYybjEf/7fw+01oEFuGfgz8+oZMrcxLTOGmq6/GVxwXVRj2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RmnUNSlS;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F8606A331;
	Tue, 17 Nov 2026 10:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B82F8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RmnUNSlS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794912480; x=1826448480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xz22oPpsqmWIXwAra7whKiWI16mTZm7bN2zqd/8pMCQ=;
  b=RmnUNSlSlu/8TNtwEG9W/B7Mu1f1FsBkUjr4y26H3jgFFwod/AuJz+Bw
   Awaa28VtQ7EtDh7ib2oWx4P9M7o2I1gN0YjiPe9ILnMWaJ/vkF4AeFGJj
   A8SQW+Tmr+9RLKko+xLAUN9YpkpMwX/s9DYYLlv11opvK0CucygncGLkk
   i73yI/OeALh0qb+9thvio1sWr+RkK9M/RFbuKpua3YR2md3J7QygeNRsN
   jqfwCOZKfPiPU7XWEsal61o2lGhWC7mWrUxr5CR6iBvlfAimxFJEOCpad
   wXcZuz5FXe/gRO2FRatVBv0pK45h69+3du/HWZbEmmWjns9U6bu9DNbf9
   g==;
X-CSE-ConnectionGUID: 4zwIxiIDS3Wjwm5bkAN59g==
X-CSE-MsgGUID: /+zjZ4WLRa+egNtK5yCZ3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3760362"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3760362"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:48:00 -0800
X-CSE-ConnectionGUID: 8V5XDOljRDWjxd83tWvriA==
X-CSE-MsgGUID: N/6wuTEfS5ODpe9KyL7V5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9888454"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:47:57 -0800
Date: Tue, 17 Nov 2026 12:47:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add a reviewer entry for the Semtech SX9xxx
 proximity drivers
Message-ID: <avww2kChMteEjGnV@ashevche-desk.local>
References: <20261117094737.15253-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117094737.15253-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 03:17:35PM +0530, Arnav Kapoor wrote:
> The Semtech SX9310, SX9324, SX9360 and SX9500 proximity sensor drivers
> and the shared sx_common code have no MAINTAINERS entry, so
> get_maintainer.pl only lists the IIO maintainers and reviewers for them.
> 
> Add an entry with me as reviewer. There is no M: line, so maintenance
> falls back to the IIO subsystem entry, as Jonathan suggested.

> Link: https://lore.kernel.org/all/20261117031830.69ac22f5@jic23-hlaptop/

This is unreferred in the text above, so orphaned Link tag.
Make it Link: $URL [1] and refer in the text, so we will understand why it's
here.

...

> +F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> +F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> +F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> +F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml

These have maintainer field inside each of the file (it's a requirement
by DT AFAIR). So, if you want, you probably need to add yourself inside
each of that as maintainer.

...

> +F:	drivers/iio/proximity/sx_common.c
> +F:	drivers/iio/proximity/sx_common.h

.* ?

-- 
With Best Regards,
Andy Shevchenko


