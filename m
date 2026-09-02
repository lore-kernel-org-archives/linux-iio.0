Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3121A459;
	Wed,  2 Sep 2026 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327019; cv=none; b=npveS7nVuwKg0CT49Ob6lgu5SQtRcXeoc2euVJRLWAOrUtb/WukIhAdgtV7x44YYJydqicbchLJOYOy2CQ1YyX0n40001OZiqZbN2UXXC6yqvg3EvVPADgCNX7K7jOgljTj7W95lTbJq59HhY62aJLomQMUr4Ob0tl5277VHJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327019; c=relaxed/simple;
	bh=JSkY3eQadif/o72cZzgDCEQNnFDAI1mHcuDmxdU2d00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0ElqdzsueezWuIy91hE7LNEsEBLx6SD4KHgSRtrqM1RpgXFtv76zvJthyN4HlrPNlhHqD9U2oUEN1ZKi5vBX6I3lYEIJarXUOEHu3rqSyDc0VVYMBlA6BaIG0Z2bO3uzztX524Vi0t3W8qJkNz6gpNGTuUwTqsA7dWc89+FCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5yPL/lW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5yPL/lW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788327016; x=1819863016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JSkY3eQadif/o72cZzgDCEQNnFDAI1mHcuDmxdU2d00=;
  b=C5yPL/lWhe1LpQ5/Ygi0wMqCLkUOnwN0Sd2XTPPJ/Ehk2T14wtwcoS2w
   rgLRP1HPpxUKvdXhfmPmwlx9pkqdBHI/OpABhDrAeecq+T7eYJUY/0HMe
   uvTpUFA6YF0qSQU4W3Vo2PEw+2ksoZJXiEMwFINrk5XiqQtUotCZRJIeA
   nbEXask+wqtqlF681bF2W7StEjqp5OYBYAv6USqtOgSh4XAKAOhnX8xIy
   OEg9bR9+yHtzoky/SN210nTZpt2nKZxXig6J1LzT/7zWu4G/rg9u/V/gp
   jMgnNt2q+ZkG5SxHDrnxvYNc/XUSHOx+NOgxLqF/+69VTsx1UmeexYfgA
   A==;
X-CSE-ConnectionGUID: KoEZtmNbQmucr7jvfYDHrw==
X-CSE-MsgGUID: G2+PZvEPSkaeAUj24SrN3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="111543640"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="111543640"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 22:30:14 -0700
X-CSE-ConnectionGUID: YEmw4gMkRJOKmwzxUmslsQ==
X-CSE-MsgGUID: 5hrL4eFGSkOj5dtjnjAeYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="267997236"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.118])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 22:30:10 -0700
Date: Wed, 2 Sep 2026 08:30:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] Add support for InvenSense ICM-42370-P
 accelerometer
Message-ID: <ape0FNy38B_0RyN4@ashevche-desk.local>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 01, 2026 at 04:35:53PM +0200, Kanak Shilledar wrote:
> InvenSense ICM42370P is a high performance MEMS MotionTracking 3-axis
> accelerometer. It supports I2C, I3C and SPI protocols. It has a 2.25kB
> FIFO and two programmable interrupts with support for ultra-low-power
> wake-on-motion support. It has a built-in temperature sensor. This
> patch series adds basic support for the sensor with functionality of
> performing raw reads and writes via the I2C interface.
> 
> This device contains 4 register banks for configuring the device called
> MREG0, MREG1, MREG2 and MREG3. Unlike other devices from the same
> vendor, this contains a very different way of accessing the register
> banks apart from the default user bank 0 (MREG0). The register bank access
> procedure is mentioned in the datasheet Section 13. This is very
> similar to the existing InvenSense, ICM-42607-P driver. Thus, it
> improves the existing driver support and adds the ICM-42370-P device to
> it.
> 
> While adding the support for new device, I tried to perform some fixes
> to the existing driver which were pointed out in the v2 of this patch
> series.
> 
> The buffer support will be added in another patch series.
> 
> Note: The datasheet for InvenSense, ICM-42607-P could not be found on the 
> official https://www.invensense.tdk.com/en-us website. Thus, I am 
> using the datasheet available at https://www.lcsc.com.
> 
> Question to the reviewers:
> * There is no entry for drivers/iio/imu/inv_icm42607 in the MAINTAINERS
>   file, should a new MAINTAINERS entry be created for the inv_icm42607
>   driver with the original author as the maintainer? Currently
>   `get_maintainers.pl` is able to add the original author to the
>   recipients list, but `b4 prep --auto-to-cc` is not able to add.

Only if you have (or will have for sure) the confirmation from them.
Otherwise it's you most likely...

> * As per the comments in v2 from @Jonathan regarding splitting the
>   driver into multiple files, should we still have the driver as
>   multiple files or should it be merged into a single file?

It depends on the factors like busses to support.

> * As per the comments in v2 regarding the formatting of
>   headerfile with the positioning of macros, enums and function
>   prototypes, as well as indentation of in the register values, also the
>   all the enum values are numbered which seems unnecessary, should these
>   be implemented here as well?

-- 
With Best Regards,
Andy Shevchenko


