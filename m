Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B03CAA41;
	Mon, 12 Oct 2026 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837842; cv=none; b=Gb/tLJiHAx1FFN+6QmalAx4U/vIc/S/G1JMpgCJggMK0+3GJlXsrdWM9vlSUCyZsoYsxQJFCq4tdF4mpezb1/CaNMYdNQtk5GJwwR6X7KE9PLRHMPb2UJELtBAlySs6/S3Z/dWWHm7KG9ZfPsqiGqdXuQ3gaZAB09Q74RbS0zf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837842; c=relaxed/simple;
	bh=//1hkGnq/sPhhVTED8EEOmyyGnp/ggOtkn5bMmg9sAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8wTTb5KSwKao8dTtlXVcXQsQOyx4FSfJkMwBp18YjdgvioJ73Om/Sa3E2YIBA7HpEBCiG7pfQJ5LbxFxpsjNOnDZEcBO8VLeCEtMBeDGQBA4z5TboPKEXKA6Nsl763OTvqhxzoYqHfq+ikEF9irE9AEL1hG5vc2oXDqYLwu/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1zsXusu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1zsXusu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791837842; x=1823373842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=//1hkGnq/sPhhVTED8EEOmyyGnp/ggOtkn5bMmg9sAE=;
  b=S1zsXusuPLRaEZ0Tvz7yOsHku1qJIaBz1H6Q5Blw/Bh0BUcIfEqQrNLZ
   fQWujlvYirkXAqjCytMijdLCkuq8esCDkjqSvLi8zER5S+NwH6LqkTXTD
   a7zuInUEdlgBTzYWl2t9uljyjwSSoPcUsvUIidPUnUkXunflV6TCqdNEk
   4/wlsx/b4CcDl3u5UBGIczvju55W3P8c1dy/ohG+2+QrzFXIZTvf7kQn6
   iNpxzVUGp4hL6NBJ+Aed+UJ8CIwnVQ9LnP1PgRqVuTCRjFcAUxjkOPEFo
   qlfnLX0nm1cf6o9r1IqvIrs5IoCn6ZCUPc6Vd2t6yLrkOF3oxLX3COG/I
   g==;
X-CSE-ConnectionGUID: ivbmmR0YTlCpUBNofkv1rg==
X-CSE-MsgGUID: ce0SdaCmTp2OFyu74trdJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="439888"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="439888"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:44:01 -0700
X-CSE-ConnectionGUID: npQErEFwTKKmNOUtAHyDBw==
X-CSE-MsgGUID: yRt5FktjSwmf46ndY9ZKOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="2742842"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:43:59 -0700
Date: Mon, 12 Oct 2026 23:43:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [PATCH 0/1] iio: atlas-ezo: Fix humidity channel read support
Message-ID: <as1GjG12rXytVsNk@ashevche-desk.local>
References: <20261012114553.3327-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012114553.3327-1-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 05:15:52PM +0530, Nikhil Gautam wrote:
> The atlas_ezo_read_raw() function currently rejects channels whose
> type is not IIO_CONCENTRATION. As a result, the relative humidity channel
> cannot access the raw or scale values, even though the driver defines support
> for IIO_HUMIDITYRELATIVE.
> 
> Remove the early channel type check so that both concentration and
> relative humidity channels can be handled by the existing mask-specific logic.

Cover letter is not required for a single patch. Anything you want to say can
be added in the comment block (after '---' cutter line).

-- 
With Best Regards,
Andy Shevchenko


