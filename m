Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5D3D646B;
	Wed, 25 Feb 2026 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039629; cv=none; b=sLPNjs19JjPijCM10EXKNr0vJ+4cvIysG+IMK4riBJV9YA7R5rBnoseUAHA0R9+V7nyYlIhRP63alndyN4WwgcGZ6CTxd/KA0mQIzve7iEiyQOYwqVBhJasErMXsdmWBRsCKzKYxaTtyTIWLRe1b2BH8d2tu+XFK8tBnpeI9L1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039629; c=relaxed/simple;
	bh=/Gqyh0/nROjZdEErOmjcElyMoyoJM+EqiBL5hfjIf5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp/wWNaFntGSxRY/tIUMJfTWvK7pBYViqJD6MHOwNIiYosEkyBdByGVZSYQ5G3CVj/kFymm2YW5XXJMicns3wrQ6DW5OTw2WtVGeAvtE0KNCfsvu/ps4Ak2YQAExX4mUeqCznlTfgTtAGmH3DmDMvB3ACONXRwIqnEP23twMzj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5kVnyqZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5kVnyqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772039628; x=1803575628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/Gqyh0/nROjZdEErOmjcElyMoyoJM+EqiBL5hfjIf5U=;
  b=j5kVnyqZPi42yPRqzMVP3H2hnDPo8GhvDJM7W1TSNEQKpxVIKsEu1STE
   rIYQEY+hwN40FbYWREM+EBtH34ZGM+r8h4diFr60PgrSL+Dkf+AUN07KU
   10sMsMeFRwMLV8hTUtLpALLCrpXvLCJPzECycCucMAz/dS+GKA1/W9016
   347LWnwrGg4kknaKx466jFg9Vqkx7OUrQUedT7II4/op4KRNSC5afT7mb
   uQjWzWtJysaLkmI1yYmZDVh8sJU/w14S0IJYX+ay3QMD0ssvLcTFHYT3o
   pdaVe6Rp0NzoA681bxHuDsx/iTnI9r0E5LpR4Q8nWb58pffsn2tSIEWAu
   Q==;
X-CSE-ConnectionGUID: WAdBoCmqRSeMK83l7I4uLg==
X-CSE-MsgGUID: KPXeYgiNSpCrKjpGAJEfPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="75692635"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="75692635"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:13:48 -0800
X-CSE-ConnectionGUID: iaM9isGdRpGdTGSl0xuW4A==
X-CSE-MsgGUID: BApimQ8/Q5+X44MTu77xGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="221285069"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:13:45 -0800
Date: Wed, 25 Feb 2026 19:13:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH 0/3] Add Invensense ICM42607
Message-ID: <aZ8txsLe6GJcya8B@smile.fi.intel.com>
References: <20260224163109.370930-1-macroalpha82@gmail.com>
 <aZ3iz18O3UEDTDqm@smile.fi.intel.com>
 <SN6PR1901MB465422A4BAFD469CD6966E0BA575A@SN6PR1901MB4654.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR1901MB465422A4BAFD469CD6966E0BA575A@SN6PR1901MB4654.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 08:20:13AM -0600, Chris Morgan wrote:
> On Tue, Feb 24, 2026 at 07:41:35PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 24, 2026 at 10:31:02AM -0600, Chris Morgan wrote:
> > 
> > > Add support for the ICM42607 IMU. This sensor shares the same
> > > functionality but a different register layout with the existing
> > > ICM42600.
> > > 
> > > This driver should work with the ICM42607 and ICM42607P over both I2C
> > > and SPI, however only the ICM42607P over I2C could be tested.
> > 
> > Thanks for your contribution, but...
> > 
> > NAK.
> > 
> > It's unreviewable bulk out of 4kLoC! I even won't bother looking at any other
> > messages in this (too mini) series.
> > 
> > TL;DR: reviewable code is limited at ~750 (or less) ± 150 LoC per patch.
> 
> Please disregard this series then, I will do my best to split it apart
> into smaller pieces and resubmit.

Please do!

Also keep in mind that from the beginning the driver should work, so the split
mustn't be by-file, it should be by-feature / documentation.

-- 
With Best Regards,
Andy Shevchenko


