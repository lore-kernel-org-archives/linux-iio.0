Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554A35DA55;
	Fri,  3 Jul 2026 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058109; cv=none; b=WuxO6HotBRaR24M7UevKPaN/eVDvYxZAE6bOIKCvPpXfJuJmK+0JRDTpsPpO00ijdsHy1s//XdQ5dg2XgH8FdXSa5BWF+Maa3AIsRb1XH+TdYR7n3MMex3zvE306Nj7AcJ5jvnxfLDoeBvGM60QSE5PJZyGhwiAM9U69JaiXJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058109; c=relaxed/simple;
	bh=fRiV9g7Wi1wkBsabhECdHrRroBlKcfM5QWtdnX3TaNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuBu8pgNb1al1RQPEHYGKb9EenmOOJ6Nkk8KyXvdVvzGM5bJo3BlPgfwR6z7PCrPpj88CtkdMx9XTn6xACyFsEvLrlJTHJwFJ+SrRpl7Fti8bVD5NHE8OY8ec7X9Mbn0zxfNekNX9Rtwx7Xe0XvTfH04B6EOGgqFoY4f4TmkRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8uHvxBv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8uHvxBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783058108; x=1814594108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fRiV9g7Wi1wkBsabhECdHrRroBlKcfM5QWtdnX3TaNs=;
  b=e8uHvxBv9xpl1ZhDqanS9lly4GeE2hTYLiX2TxpTbaIygVD8mKsOR/IM
   hDPOgoqKSaycRH5NApMhqDOCgLk3hcshEhtBPJ+107UBhzMNjBqDhfITt
   wrWpD3UWbyxZxznBtPRBPIExaypNcFvlfWQxrTNkSujKZVqZS4Qt2pT9r
   aIjaUZ1mFefCQ8D9GX1L2aZ6o3fwNFLUtMujkC37avzUii9Usmv57diOd
   UqbFa4lG7LoihIHANG7+qxel2eTMRSIvIjBM2dqj8aC3gehLt3nMPQ/pe
   W+NEuaNvSO/Jk5ObGlZzsQBsiWrei/7sLxvefhuuzSfwknOyZEkrWnl4v
   w==;
X-CSE-ConnectionGUID: I55tgFz6QrauHcdv76piPg==
X-CSE-MsgGUID: DeP7BGWUTV+9nY/58mVVvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="87632437"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="87632437"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 22:55:07 -0700
X-CSE-ConnectionGUID: bBmb7M91RlKCfykwALqhTA==
X-CSE-MsgGUID: q/zvx/JRSOqyg9jPFEpY7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="249679991"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 22:55:04 -0700
Date: Fri, 3 Jul 2026 08:55:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
Message-ID: <akdOtUXMRuYhakxM@ashevche-desk.local>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-8-ceb9b0b561cb@baylibre.com>
 <20260701212019.12757df3@jic23-huawei>
 <akYs-QgyjN-nmjq-@ashevche-desk.local>
 <544fbdef-268d-49cc-ae9e-b18907d9382b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544fbdef-268d-49cc-ae9e-b18907d9382b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 02, 2026 at 09:18:41AM -0500, David Lechner wrote:
> On 7/2/26 4:18 AM, Andy Shevchenko wrote:
> > On Wed, Jul 01, 2026 at 09:20:19PM +0100, Jonathan Cameron wrote:
> >> On Thu, 25 Jun 2026 16:55:10 -0500
> >> "David Lechner (TI)" <dlechner@baylibre.com> wrote:

...

> >>> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> >>> +		struct ads112c14_measurement *measurement = &data->measurements[i];
> >>> +		struct iio_chan_spec *spec = &channels[i];
> > 
> >>> +		if (!fwnode_device_is_available(child))
> >>> +			continue;
> > 
> > Also drop this dup check.
> 
> How is this duplicate? device_for_each_named_child_node_scoped()
> doesn't check this.

It's checked by the respective implementations.
https://elixir.bootlin.com/linux/v7.1.2/source/drivers/of/property.c#L1129

-- 
With Best Regards,
Andy Shevchenko


