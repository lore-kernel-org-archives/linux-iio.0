Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8C35675B;
	Mon, 29 Jun 2026 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742384; cv=none; b=YTla0rxTtkabfmNiSXyuhWx9wr0jiHhuhsuDwakCwvriK4ljNbU5gs6EKbHdp2d8g08nb2XzeGE0VYHoCQOmpn7NJ4d41QoARwDJcngebIdz/EK/KzqhmOn8OX/4NpISEBNwoZTSSw9yoFzPPXXJpPnkEx4Ezll7lVVp59RA65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742384; c=relaxed/simple;
	bh=tKHtzoYf+ONSIaUJBs5LTkbQeLS8Vw/N8hPM7z+LNrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5PNoJAbVcVi13Yo0VPntbVs1MQl/OG47u8UBT+E5d+8CKL+lWJR1VJEg/AtGoSowdOHsIn0lEZYSaAGycO+grHLm99yN2NghcTTlYaJ6i/qc8rZMQhJJAq7jgDAeQbpCbcmjKdnLWyPCt1oeVg6WcWiSnrXd6J+vzyrG4h5Vk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUJ1kk8t; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUJ1kk8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782742382; x=1814278382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tKHtzoYf+ONSIaUJBs5LTkbQeLS8Vw/N8hPM7z+LNrU=;
  b=IUJ1kk8tWIE1O5CP70MOak48GS0VVaiBx2skXhCBHk4YJKFH9+KOuQga
   AhIBGkaVISht7nf0ciKWGR68Oznv6sSfDzKSB7nob/pXeb4PLqnZlbFKx
   lyATNBUbRJw0jk66q6NUUMnPakVDJZyEyRB1bFG9DMKqa5z54n1+ooaPk
   Jx5If7xvY3IJtK7cMb6vauwX0Mn+9JCCwZN6PvRxNRmz5PqEK9PiK/sFw
   B5U2342r3rBJOKlPOOlVsytAFB5eQDQaLXWOALxt2xqk4nzEqUYRkVFN7
   encvr3e50CVjlNFxNxIwb0sAdmyd5yCNI3JMW7IPU2WXhmyYFb337fmwi
   w==;
X-CSE-ConnectionGUID: lkSszQRBQDChiMe6uaQUAw==
X-CSE-MsgGUID: MAjGVTpcRFKWQnMbx+seuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83438253"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83438253"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:13:01 -0700
X-CSE-ConnectionGUID: 0fjlTSkHS1Wmu1mSwb6SIg==
X-CSE-MsgGUID: t2VRGnY9THqgHT5uGXYA0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="252607197"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:12:58 -0700
Date: Mon, 29 Jun 2026 17:12:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v6 0/5] iio: add Open Sensor Fusion IIO driver
Message-ID: <akJ9Z6jHGP-fUPFz@ashevche-desk.local>
References: <20260628191337.937-1-kimjinseob88@gmail.com>
 <akJ8itlDBJfaYRj2@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akJ8itlDBJfaYRj2@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 05:09:21PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 29, 2026 at 04:13:32AM +0900, Jinseob Kim wrote:
> > Open Sensor Fusion (OSF) devices expose a UART/serdev host interface
> > for a sensor aggregation hub.  This RFC adds a Linux IIO driver that
> > parses OSF frames and creates IIO devices at runtime from capability
> > reports provided by the device firmware.
> > 
> > When the corresponding capabilities are reported, the driver exposes
> > accelerometer, gyroscope, magnetometer, and temperature data as IIO
> > devices named osf-accel, osf-gyro, osf-magn, and osf-temp.
> > 
> > This remains RFC while the binding, protocol subset, runtime discovery
> > model, and driver-facing ABI are reviewed.
> 
> Where are the lore links to the previous versions?

Besides that you utterly ignorant in replying to the comments of the reviewers.
v3 and v5 left unanswered, third time in this version I give the very same
comments. What the heck?!

-- 
With Best Regards,
Andy Shevchenko


