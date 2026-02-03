Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001A333451;
	Tue,  3 Feb 2026 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117679; cv=none; b=amjefPeAiMRylAD3H1y9RRWhro7HExxkGj3KxRkck5ZUhCz1pnjt3gkDR4L0J+Qj44gseF43e40AuRghqDzq7YrQe8hGbVQuAR14Q8qYjkvqrlww+koEkZRcef+ZJtbZk+khB0CTSrNRUwUJNY5D6nVZUf9lq3GANadiQaNK1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117679; c=relaxed/simple;
	bh=nS1vjatkjXL9TqGf+XtG5dcMRQZ89WeW4bm26FUB6iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxI1dTRj4gWSSoXp0l/CHxOhq0hwoSRwHXcs072VHHj/xc8cpKGcyQ6DAObgec4K9/TpcjZ0sajMhR/u8J7U4+5HzJzU4kOBKtqKN4P+wZ7TyoYbyGhyV9lhlPWHCJLgImgwUf8zg4MCQx0wcE6XSjYuT0GFWlzKXrHUDboGXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKqAbZ6O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKqAbZ6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770117679; x=1801653679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nS1vjatkjXL9TqGf+XtG5dcMRQZ89WeW4bm26FUB6iM=;
  b=SKqAbZ6Oplg+9W7juvKOJZETo4shTmhHuaer1YUFyvCyzzAgmagyIv2x
   T1aFwPT1kz4iJes8TUvixUXs5weu0hmNaEgyc7kCyFwGjnUYpb4lLqtJF
   uDL9gN30iRMWSWPSryN0NBV4/sCruZuYhXorL0/rmZUH5BZrAiHbk/z4X
   O7EOwODxH00msXRV1PeFK6qW1OuEM5U4KSoj6RH/pN3gz60at+Ltzy/re
   PjPYGZIddEpG39vH/fRGGX//S2nXxcK7Z7OFZnGYKfIBqO2SdnxgNGWUv
   B/eVTCoON9NF4aMrsALGnZu1kFLY8Xixiggs1Rf2RBzhq1Ung8Nf4IUS9
   g==;
X-CSE-ConnectionGUID: vZexTiAcTmqcf41MSnjDTw==
X-CSE-MsgGUID: fkgSz+sKSVWY1X/HFM75lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71325662"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71325662"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:21:18 -0800
X-CSE-ConnectionGUID: GcUuBPrbTuCJBJeJSoqA1w==
X-CSE-MsgGUID: j6aFqlI0SPCfj4gXcL/emw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="247429023"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:21:16 -0800
Date: Tue, 3 Feb 2026 13:21:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Message-ID: <aYHaKYWNbrZchDn-@smile.fi.intel.com>
References: <20251109192556.3163077-1-andriy.shevchenko@linux.intel.com>
 <20251115185001.01f2b148@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115185001.01f2b148@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 15, 2025 at 06:50:01PM +0000, Jonathan Cameron wrote:
> On Sun,  9 Nov 2025 20:24:36 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The driver code is full of intXX_t and uintXX_t types which is
> > not the pattern we use in the IIO subsystem. Switch the driver
> > to use kernel internal types for that. No functional changes.
> No problem with the change but this description made me think
> that this was going to be a huge patch touching lots of instances.
> 
> Probably needs a rewrite to not say 'full of' :)

Can you tweak that whilst applying, please?

-- 
With Best Regards,
Andy Shevchenko


