Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68362374726;
	Thu, 16 Jul 2026 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226156; cv=none; b=mJUzr7mXEhmEmQVcELvoAxLz2xD3DDdixQnCH2z/ZEb+0OaOPQSBsLaYZniaTTHjXpfqu6lTUZg83ZkMA/pkJf0+uX4jhtQIzaa2sTdqQwbAwvtiuXRRIw7PabYWHGdEjTwoy0inzWOwUe47lu2j9wUK4PxXWnaR6ddY6n9Y33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226156; c=relaxed/simple;
	bh=m4mRTF7pMM0o5LiCQnpe7UfdWa/CQrJbMjKY0C7+kJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avC/PHppKprcASQbWYDcmBN6XML5+zOG2+AOotSgNvXQtkGpOCZbNCepVILf9GVq89WSFcObwS+SxODCHuMdUSXZmK2heep3LSQ4jKRPyD0VW5cZLZ4um70jfY9d5g1Z242AN85fiBTk+wo4KuI03ouV1FODax2r9slLgWbwcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+SgVx/w; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+SgVx/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784226151; x=1815762151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m4mRTF7pMM0o5LiCQnpe7UfdWa/CQrJbMjKY0C7+kJs=;
  b=m+SgVx/wDMzRAjXjJ48tLj1TsvlMNpsAQB6LGU6HEV2C7TwfncisMHrY
   mUNZ+I+ZBbpWKLDdpzE9dNef8Ew0F1/bJHvI37TdxF2xkHa+FnbNjDG0f
   n2W/w6NdAAnZX6yXatWmySV1fc/ssMdBhG5836g3U7G2GQ4PQOxYesJyq
   YgnmuOId4Ch6Ow2hN39a/xvnhF1T053DuYlqH3ZEkhc2pCxLzABevoGlJ
   KoK53SbB+I9ThLIot8hRGHTM9hriI09EU6mY1cqMI9hZtK61HI31EAlU8
   0q8CRGGkwESadVz4LV3z3/iBDMNhDykOWz9khSpe54nECFuWP1fH4TlZM
   g==;
X-CSE-ConnectionGUID: bDMtCVqlT1CNhyDU/ib+TQ==
X-CSE-MsgGUID: iQT7imrES4aeRfU57/zYlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84776599"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84776599"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:22:28 -0700
X-CSE-ConnectionGUID: tz2933+LSQyeHKzsaBOXCA==
X-CSE-MsgGUID: oK+X3Ti0Te6od5jL9GHpbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="252170389"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:22:25 -0700
Date: Thu, 16 Jul 2026 21:22:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?utf-8?B?UGF3ZcWCIFdpxZtuaWV3c2tp?= <pawel.wis.me@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] iio: proximity: Add Cytron HC-SR04 support
Message-ID: <alkhXy8BIr0HH27S@ashevche-desk.local>
References: <cover.1784221074.git.pawel.wis.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1784221074.git.pawel.wis.me@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 07:35:53PM +0200, Paweł Wiśniewski wrote:
> Add Device Tree binding and driver match support for the Cytron
> HC-SR04 ultrasonic distance sensor.
> 
> The HC-SR04 uses separate trigger and echo GPIOs. A trigger pulse of
> at least 10 us starts a measurement, and the echo pulse width reports
> the ultrasonic round-trip time. This matches the protocol already
> implemented by the SRF04 IIO driver.
> 
> The series adds the Cytron vendor prefix, documents the
> cytron,hc-sr04 compatible, and uses the existing SRF04 configuration
> in the driver.
> 
> The Cytron vendor attribution is based on the HC-SR04 Product User's
> Manual V1.0 supplied by the retailer. The manual was prepared by
> Cytron Technologies Sdn. Bhd. and contains Cytron warranty and
> support information.

> This is sent as an RFC because the vendor attribution and compatible
> name should be reviewed.

But it's normal process, no? In any case the code in the driver is fine.

-- 
With Best Regards,
Andy Shevchenko


