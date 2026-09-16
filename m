Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99054078D3;
	Wed, 16 Sep 2026 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584056; cv=none; b=S/h6ajvt72AGmWf0e9j7xEgCC8tmqvaBNx5Fi2zmHxAilAjQ2k0uoLjjvGtNUnKa/NW6fFOWEq6MYtKa906w8H59SMiUYr9r3yjfdJOelz8sri8Th/PaBIlgS2Dl4r9MioAm9yc/lCFsfR17vVRJ0uZHxdlv6s4wN+OnHgBYFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584056; c=relaxed/simple;
	bh=PFPm2QV0RCMlEzaZl1zryUdPQtP2DlAh3dDgxGzt+Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRP58lPnST2GWJx1UKZGcQf4LAy2xokfqw3FYKSvoZEdKY3GS3S/wrkHfcEPU8U29+NWqYWk+BbO7uSSIX9EQeL+1gvU3flJcqUJM6Vp/j13jAswfsve4lKq6+La/oYkit9TaFFxvpmrGTsZRmL+hafCP5Jozbr3jFpdGkTNMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FWiUM2N2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FWiUM2N2"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id D4DAE20B7169; Wed, 16 Sep 2026 11:39:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4DAE20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789583985;
	bh=8lK+5oMYPj6NqJmz8Ck8rGQ6ji2Aa8RX6M1pRCw0k50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWiUM2N2gFXZJw07S+29h619H1s8PFSkSWlMg8+hGsUTHSD3M+KxJjpiqd8hEAL1r
	 mBi0K3Rfp1JrvGbZ2f/h85Rkbt+u91WCFxzPbscplgi3y6ZRbbTX8DhG/+z50fCjh8
	 YiBnIqduPbFabLtw8eRPpoL44+M2yHtsTKkpL7PE=
Date: Wed, 16 Sep 2026 11:39:45 -0700
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Meagan Lloyd <meaganlloyd@linux.microsoft.com>,
	linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
	vitor.soares@toradex.com, samagazaryan@google.com,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	boris.brezillon@collabora.com,
	oleksandr.shulzhenko.viktorovych@intel.com,
	tgopinath@linux.microsoft.com, corbet@lwn.net,
	skhan@linuxfoundation.org, linux@roeck-us.net, Frank.Li@nxp.com,
	jorge.marques@analog.com, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, lorenzo@kernel.org,
	enelsonmoore@gmail.com, rppt@kernel.org, pratyush@kernel.org,
	giovanni.cabiddu@intel.com, gabewhigham@gmail.com,
	haren@linux.ibm.com, pasha.tatashin@soleen.com,
	jirislaby@kernel.org, adrian.ho.yin.ng@altera.com,
	ustc.gu@gmail.com, jszhang@kernel.org, adrian.hunter@intel.com,
	akhilrajeev@nvidia.com, tze.yee.ng@altera.com,
	manikanta.guntupalli@amd.com, shubhrajyoti.datta@amd.com,
	jarkko.nikula@linux.intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] i3c: master: enable driver_override for I3C
Message-ID: <20260916-6e46fd06ccaca5d99fe1d30a@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-2-meaganlloyd@linux.microsoft.com>
 <aqVR-jBabQKcsfjL@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqVR-jBabQKcsfjL@ashevche-desk.local>

> > Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
> > Assisted-by: Claude:claude-opus-4.8 copilot
> 
> Assisted-by: LLM

Sure, I can update the tag accordingly. Thanks!

> 
> ...
> 
> >  drivers/hwmon/lm75.c                        |  7 ++++++-
> >  drivers/hwmon/tmp108.c                      |  2 ++
> >  drivers/i3c/master.c                        |  6 ++++++
> >  drivers/iio/adc/ad4062.c                    | 10 ++++++++--
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c |  3 +++
> 
> No, each IIO driver should have its own patch.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
Got it. Thanks for the feedback.

Sincerely,
Meagan
