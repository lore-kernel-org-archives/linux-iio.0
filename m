Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F923C2E;
	Tue, 31 Mar 2026 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956364; cv=none; b=ZfCQEk/BBtAl1gKqqPGa11KvD3eVXjH7RULZh0n0sqHMuLht40Bzl2UMZgV0XAbALAgJMNTGNPPDzy/MzJeS0gw88F3CW8/w6xHKqRGrYUC5QRnDOIKiE02Q9IzLjB44dcoQEqOJ6h3KZI66Xk4RDFYmluZga8oecX3+4vCYuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956364; c=relaxed/simple;
	bh=NOTrhUUVowhwGx0t0rPG4rtZ1Nb6tAXMXdZrcPv++EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggnH7m7j0AwtuIPOWQP5rIKMvj5mR0VqsTcKgUDk5uQYaroUgeMwy4OnG3Fn6eOS2r5G1zp6i825HpdcB03IoTduB+OifukcFZGjsL9MXFl7jKj7RUI5Qt9C0KSirgZzrMoexp+9L/TNAONTFCuhRJw8NtzryJMR/9px6/JXvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKjbtmdr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKjbtmdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774956362; x=1806492362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NOTrhUUVowhwGx0t0rPG4rtZ1Nb6tAXMXdZrcPv++EE=;
  b=iKjbtmdrVrEPaZoWBlgLi/8BMGCssY5fQGYIq1chaIx8A4XYDoVt//Jd
   bLiS8TqdWU99flLvWFrw/KVHbLNUXIjiUKqgdGZ+FYsCpHSOZPTIejhol
   UfFlUZmsC//KWOnxnqTfCyXccO3ia35AGKZ/0z1rUeVLIWTJvb965cL8b
   wBLHyKk2INgaBQlx/cA+mzrxj4zDa/RmWBkAX1nXVY3BcoBO7U/mOHDsy
   9kgCfk9wGyV7YkPLZqf79jBBgc3HIotV0KjAK1qPOl4KSfiE90PygwKCC
   75z88+0WXBdvvXHnfbHW15DQ7YboLzRniE+c/G/2K5hmNIm69pdS5UAY8
   g==;
X-CSE-ConnectionGUID: BF8MhGQhT1SnKqIE0Qq/bg==
X-CSE-MsgGUID: jNu5rpLtSraN6G/1ecKTYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76157924"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76157924"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 04:26:00 -0700
X-CSE-ConnectionGUID: uDPvsGmPQi2c20CLpwjzrw==
X-CSE-MsgGUID: Cd0Rxs2LQDe1SfgUw835JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="225333852"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 04:25:57 -0700
Date: Tue, 31 Mar 2026 14:25:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 0/9] Add Invensense ICM42607
Message-ID: <acuvQr0UVyGIQ7fo@ashevche-desk.local>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330195853.392877-1-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 30, 2026 at 02:58:44PM -0500, Chris Morgan wrote:

> Add support for the ICM42607 IMU. This sensor shares the same
> functionality but a different register layout with the existing
> ICM42600.
> 
> This driver should work with the ICM42607 and ICM42607P over both I2C
> and SPI, however only the ICM42607P over I2C could be tested.
> 
> Changes Since V1:
>  - Instead of creating a new driver, merged with the existing inv_icm42600
>    driver. This necessitated adding some code to the existing driver to
>    permit using a different register layout for the same functionality.
>  - Split changes up a bit more to decrease the size of the individual
>    patches. Note that patch 0004 is still pretty hefty; if I need to split
>    further I may need to create some temporary stub functions.
>  - Used guard() and PM_RUNTIME_ACQUIRE_AUTOSUSPEND() on the new functions
>    per Jonathan's recommendations.
> 
> Changes Since V2:
>  - Went back to using a new driver on advice from Invensense engineer.

Okay, but this should be elaborated in the cover letter. If I followed
previous discussion correctly, the problem is the indirect subset of
registers that are absent on the 42600 series. But would be nice to have
the summary of what vendor engineers told you.

>  - Further split changes up into smaller chunks of functionality. Note
>    still that the largest patch is approximately 900 lines, and that while
>    the driver compiles cleanly at each commit it is not able to drive the
>    hardware until the commit that adds the Interrupt (as it also adds the
>    Makefile).
>  - Change the error to a warning when the devicetree binding does not match
>    the hardware ID.
>  - Dropped the ack on the devicetree bindings, as I am creating a new file
>    (for a new driver) instead of modifying the existing one.

-- 
With Best Regards,
Andy Shevchenko


