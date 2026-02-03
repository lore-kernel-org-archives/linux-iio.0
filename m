Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D0274B3A;
	Tue,  3 Feb 2026 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118511; cv=none; b=uv+Gsn2Igje5uZHgBpmDjgN73ns1+ECrG70ChhQGDr9Agw2quGW6j3Teo8P8QBUwPXGovnmyp4IwXp5uDMLxeUqCdnupV/L5h2e+xA2hf5Eyc1MiJIqXp9wM7oFDBXtxXTbDdn4VJ2TMmZZg+AVLobLufgGjqn71GuZBjVB05J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118511; c=relaxed/simple;
	bh=HdS8MKiI/H6cdIbsiLDOrxYKXx4OOe7XJIey6bZk1Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1AN6q4+i9atAoXX5azOupkj8B1jUhayfDHAPHyrHlcnWzfW9drXknl+BPGCvye4HVVgIYXAwbERImvWG+QGskk5bdqLPNy58h51agLRlEzMyzxHYaWJRSTwoc1xGJLvo7/MZI6URmUovtz0Bi4ebmRwtECni8ye989PyBZHJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLJ/6/uI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLJ/6/uI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770118511; x=1801654511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HdS8MKiI/H6cdIbsiLDOrxYKXx4OOe7XJIey6bZk1Ys=;
  b=GLJ/6/uIzznctOEdS2wn5LEmkOI7sLljbr/D8ad4HiApJWMc4p2cw0k6
   JzR1dcLbzpvGKAih/euD3dKzZmhdxOF3RTouiUIeKhLJ0mtkReEH2QYlu
   XKFX8eplaVrPgdzurUTvETCW0g1w7XccL8FSmzdbDfXBoFjcHwqStAz54
   BDfwRVzQ6vAEqrelXxqvyGkiKo920rjuAJIHSiu4LgEglkX39WOGRdE7H
   oNYXaM99cWM9GJ17kIlZPEzaG/BJfwbT3iC9TbN1QP+CrWXNR+aedFLw7
   j8YzSE9GIRDcKbb/gR96wAZI1FCDmPz6HL8VqP5ZkHEPWsTrrIojwGScX
   g==;
X-CSE-ConnectionGUID: LLYjAiMHRzaMq1moGws6pA==
X-CSE-MsgGUID: aGU15MpkTR2EP3VdiV37kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71268674"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71268674"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:35:10 -0800
X-CSE-ConnectionGUID: IBIIlJkaQbqWayuqaS5nWw==
X-CSE-MsgGUID: ZcmB29DTTBCjjJAfQXjQ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209989588"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:35:07 -0800
Date: Tue, 3 Feb 2026 13:35:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: imu: lsm6dsx: Support SMOCF05 ACPI ID for
 LSM6DS3TR-C
Message-ID: <aYHdaU3BE40l_4a5@smile.fi.intel.com>
References: <20260201225450.1649001-2-samuel@dionne-riel.com>
 <20260201225450.1649001-3-samuel@dionne-riel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201225450.1649001-3-samuel@dionne-riel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 01, 2026 at 05:54:49PM -0500, Samuel Dionne-Riel wrote:
> Same device (LSM6DS3TR-C), different integration with the firmware.
> 
> The integration differs in that the firmware provides the SLA0 and SLG0
> mounting matrices. They are assumed to be Accelerometer and Gyroscope.
> 
> Observations were made against the Windows driver, version
> `12/06/2023,1.0.4.3`. This driver supports both identifiers, but expose
> the device in different ways.

Does it imply mount matrix method? Then patches should be in reversed order to
avoid adding not properly working device.

...

Also this needs an ACPI excerpt from DSDT of the machine in a wild along with
its model. (The ACPI ID looks fine, IIRC SMO is registered PNP ID).

-- 
With Best Regards,
Andy Shevchenko


