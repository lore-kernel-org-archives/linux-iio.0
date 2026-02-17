Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82AB36BCEA;
	Tue, 17 Feb 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340893; cv=none; b=EwynItdoSTiwHeM/WJPTKKK1nanE6OLEPrTf8mo/XVPLpJW6L0DoNHRajBONyMTRGOdOrZ5HvfTLX0vgc1PLr7UcAbHRK9YxG3U07XpA6qkgdLFdrqY8EK7qrStzvUSOObE9h1hNpX2OHt5YV65Lu+GjnNoLI8DLYxmskdBFjVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340893; c=relaxed/simple;
	bh=RZqe5b/ptCTm7RzAzezDI+/inMjSJfv1WO6b/ULnWsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK96o/2/NNr6XFySlWA5ya41dg7Jcx9/iHUmQPfWnvhJJc+WZ6wXarF7Q6N+M+wzdb7AhfraQp/WnaTWoDRZLjIZVAdNlR8Z2ltskdcKh3GJ2Bg1K69832oGbXvNR9cSf9/d+b0dRKvhxmnCPHOh6F9N/JXYSJIu4ItIqxJaz6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrPwv6os; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrPwv6os"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771340892; x=1802876892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RZqe5b/ptCTm7RzAzezDI+/inMjSJfv1WO6b/ULnWsA=;
  b=GrPwv6osqlizU5TX0Lc3YoRS8GEhSSkQid/rf4aI+4divfWf9swtcE86
   2EWRQb3RsJyX7lER+eGx7HEAJBqM0QApoRI6ItxXvGJSjA3ZIRlr+mVEU
   ReNitVQfFc7NSxDTHURfHGd4klq/ZYrqcLQRDw3MIGyoT6EaSHF4O/UUT
   vluNdIAG8F9LM+glSyyWzbBxh5m50Dj04dT9A9QEa6xkKe2iYtpWp0Vnt
   Lw3fSUTWzmOLLV1GLbRxdmbMwuGflVP0zP9SRqhQ24frw9qgvB9e5oRjg
   iXvm5CfKSBXR35jjA8yDfovCzp1bY8Ckp5zWNKWW8Xcs7VHZkJxlOmTXB
   g==;
X-CSE-ConnectionGUID: 7KAfhH60Sxqr5HfXfAVIEA==
X-CSE-MsgGUID: ppcH3mLiTaiZF/CxDkW/DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="95040885"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="95040885"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 07:08:11 -0800
X-CSE-ConnectionGUID: 7kuU45rmQZ2G7JIK/VP2LQ==
X-CSE-MsgGUID: lxPRligcSlaAJSqmipABMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="236912658"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.123])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 07:08:09 -0800
Date: Tue, 17 Feb 2026 17:08:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: trigger: use put_device() in
 viio_trigger_alloc() error path
Message-ID: <aZSEVpQBgHlRHbeW@smile.fi.intel.com>
References: <20260215222348.186806-1-salah.triki@gmail.com>
 <aZLNX6Ifw68k-zu5@smile.fi.intel.com>
 <aZLZN6sD9H9dF8Np@pc>
 <96b05a514d229b23ea0917447607dd7390ec0e2e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96b05a514d229b23ea0917447607dd7390ec0e2e.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 17, 2026 at 01:51:08PM +0000, Nuno Sá wrote:
> On Mon, 2026-02-16 at 09:45 +0100, Salah Triki wrote:
> > 
> > You are absolutely right. My previous version (v3) was logically flawed as
> > it could trigger the release callback before the necessary fields were
> > initialized, leading to an unsafe irq_free_descs() call.
> > 
> > Since I don't have the physical hardware to perform runtime injection
> > tests,I relied on manual code path analysis and clearly failed to account
> > for the side effects of put_device().
> > 
> > I'm sending a v4 which takes the safer approach: moving
> > device_initialize() after all potential failure points. This way, we can
> > safely use kfree() and irq_free_descs() in the error path without
> > involving the device lifecycle prematurely.
> > 
> > Thank you for the catch.
> 
> Please just use the same approach Andy did for iio_device_alloc(). I posted
> links (in one of your versions) to that and for the discussion we already had
> on this same function some time ago.

I believe this is the approach mentioned above, id est move device_initialize()
further in the code. But I might misread something...

-- 
With Best Regards,
Andy Shevchenko


