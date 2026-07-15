Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925830C17B;
	Wed, 15 Jul 2026 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098009; cv=none; b=caD+V0i4iT+PgmczIQV5C8c5JB7CHl5PtKYf69MB0Ffmiufv5zyyVEMRUE+lKQ2Ms6BIRL19ezl8gF5zCFPSOVSCq4hSoySH+fC/yLWf8yftvxY1zkS1JThkYLn4igsPTDrTj0k8lY9HK0voAxM5+DBAf4+fQ9fDyHESRyDv0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098009; c=relaxed/simple;
	bh=xTb1P18qTS4x2GH0IW0oXDegvzQvgVfn8qsozOtrSPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSf/eZ+qKHsKbNBcSPbsvRlHLysNhN0IGcOxvWq89+vf5vlprhQqvmvzwyJzjfHasnRC3A4ry6W8mK8uNKIT8O2aPcTXGuwDhoT6mifmKCvXOwyYac5KUhEthCmLBMfVCCmIlRXqeo/jlcPT+ryXDrq5aP6mwGZrnQXpi4xPRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ka8zdmea; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ka8zdmea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784098007; x=1815634007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xTb1P18qTS4x2GH0IW0oXDegvzQvgVfn8qsozOtrSPg=;
  b=ka8zdmea8IFggr9YLdjJfE7GGJ+kYBCAIfu2BDACoZNhNgo98LFJ/BxI
   i/5sQanYMUJgVXoxAdshnZilH24wSwMAj4tPRaTLvq+6Z8MNQgqif2e7Q
   BJulZMdX458xX/CcC4pLV2gkaA2sI4/OmrO4akY9pkftjG58nnvKv14sp
   HnPzhiesZsmR3jYDY+ZOwx8XFIZp9sSSqNIJrTHXCL25fRkUdGqyNaS7C
   odhi63g55OHIALpbBC8wBv+3fSL3juh/s0uvFv16rwPm8sAyveR3DfluJ
   ESnF4xnlaxWpfEvd5z3jZVD/g8OuOkSAGEZmu18me2GAU5w0MVgQ7yTjL
   g==;
X-CSE-ConnectionGUID: zk7s8upoSviI3Wmb1Hg2gg==
X-CSE-MsgGUID: eh/fN7dmQDqrDTJzXNXlUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110273546"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="110273546"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:46:45 -0700
X-CSE-ConnectionGUID: 2Ffx0br5Tr64//QD3nI7jA==
X-CSE-MsgGUID: t4cR1dOeSZ2SCw4ZFSktfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="260380591"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:46:41 -0700
Date: Wed, 15 Jul 2026 09:46:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mike.looijmans@topic.nl,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jorge.marques@analog.com, antoniu.miclaus@analog.com,
	mazziesaccount@gmail.com, jishnu.prakash@oss.qualcomm.com,
	duje@dujemihanovic.xyz, wens@kernel.org,
	sakari.ailus@linux.intel.com, linusw@kernel.org
Subject: Re: [PATCH v7 0/3] iio: adc: ti-ads1100: Add support for TI ADS1110
 to ti-ads1100 driver
Message-ID: <alcszm5-9alInIo0@ashevche-desk.local>
References: <20260714195528.597753-1-jakubszczudlo40@gmail.com>
 <66b7b01f-0e79-4387-9b68-92858ccc1fe7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b7b01f-0e79-4387-9b68-92858ccc1fe7@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 03:20:18PM -0500, David Lechner wrote:
> On 7/14/26 2:55 PM, Jakub Szczudlo wrote:
> > Add support for the TI ADS1110 to the existing ADS1100 ADC IIO driver.
> > The ADS1110 is pin-to-pin compatible with the ADS1100 while providing
> > higher resolution and an internal voltage reference. This patch series
> > extends driver support for ADS1110, updates device tree bindings and
> > Kconfig text, and improves the overall hardware description for the
> > TI ADS1100 family.
> > 
> > Tested on: Raspberry pi 3b+ with 7.0 stable kernel
> 
> Hopefully this applies on the iio/testing branch? A lot could have changed
> since 7.0.

> > ---
> I made some suggestions for cosmetic improvements, but good enough for
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>

+1 here, but I think the chip_info naming and actually -ENODATA are good to be
in from day 1. Assuming that is going to be addressed in v8,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


