Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3EE3B19D1;
	Fri, 21 Aug 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318527; cv=none; b=LixhAB8nZjQ8sjGIPN2I9PpkrvTRp6DlXAq8cI+vf1cNysJZhhkqFIjl0s7JGslNPC0tF++F/9I56mGACy5XKaiXxuhuYSjpifIP8g2WFfkM0UdSPB8MhHSypqIwpsfahMI2a98pAzMpRoeV7RteJ/X8MOaKIKDHsj4OM5eYfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318527; c=relaxed/simple;
	bh=qidaBUiduKoz1WMrkr6VtIj5DGvtQWsECTFcYpy0hj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkSlJbYdptPz9v3PNGR2mb7/rHX/fwXugEvAIrqsWfR6dPmZw7dibANfYV8b8WxiVCw61eJnSZk6qa2vcWGY0AeFmLo803Go1tSn9JTPVIvvoL3Nd5nPwTjyEzI+1c3LYv0K+PKpb5SyZA7YX/GO+qs0cW9hLgbhDywe1H/aweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkY8fObM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkY8fObM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787318521; x=1818854521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qidaBUiduKoz1WMrkr6VtIj5DGvtQWsECTFcYpy0hj0=;
  b=mkY8fObMjqzD6REcKRrEBCmVIcAA5CsqOnicvXWFm/UZ2TtiylBsSRcP
   7JlTShE6q3ud4bxsz6AVt88cnoQRTn3nclzBKt2R74OvgOSeoBlMQ9Q2y
   EC8Sg3O4khuwJ2UmQJZQ9IzS4g37cwhNrMNL5mU/tgFVk6aHnDZb+5MWb
   iZc/IzaIMrS4WxRSisLeQNud9ljfEQxlVK8V6MPfwobB5PcABTfhHbPW6
   nlYxIKZrWnodUAxIzVs6HD3tbuqkynzS4d7Rp+3dyTagZur4N7H7p4v47
   whrb0fDmleb767IXVO73nknp/zZTeSfF7MWd9yn7e2KjRaf/ntTCRKMQe
   A==;
X-CSE-ConnectionGUID: p1Th0BmkQUi8268yWgYdSw==
X-CSE-MsgGUID: ycrgGJcYQyCcqDBhW9UVsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="87886680"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="87886680"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 06:21:54 -0700
X-CSE-ConnectionGUID: NxGsBs4ESgecucMetCEf+A==
X-CSE-MsgGUID: NNW4+TuXQ7qPpXoLMoD4Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="262635625"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 06:21:52 -0700
Date: Fri, 21 Aug 2026 16:21:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: imu: inv_icm42600: sleep before enabling FIFO
 data
Message-ID: <aohQ7Y6m1j19vQWi@ashevche-desk.local>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
 <20260820-inv-icm42600-enhacements-v1-1-075a881db557@tdk.com>
 <aogzNOaeOHQ732oP@ashevche-desk.local>
 <BE1P281MB1426D50075F4223A98D870F7CEA32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE1P281MB1426D50075F4223A98D870F7CEA32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 12:50:37PM +0000, Jean-Baptiste Maneyrol wrote:
> >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >Sent: Friday, August 21, 2026 13:15
> >On Thu, Aug 20, 2026 at 09:02:37PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

...

> >> +     /* sleep maximum required time */
> >> +     sleep = max(sleep_accel, sleep_temp);
> >> +     if (sleep) {
> >> +             mutex_unlock(&st->lock);
> >> +             msleep(sleep);
> >> +             mutex_lock(&st->lock);
> >> +     }
> >
> >Doesn't sounds correct. Here it breaks the atomicity. Is it a problem?
> >(Imagine a few CPUs doing something with this driver, is any other thread may
> > intervene the flow here?)
> 
> there is no risk here because we are inside the buffer enable function, and
> there is an internal IIO mutex here preventing multiple calls. The driver mutex
> is used to serialize access to the chip, mainly because we have 2 independent
> sensors inside, accelerometer and gyroscope. We need to unlock it here to prevent
> stopping data from the other sensor if it is enabled. For example, when we enable
> gyroscope while accelerometer is running, we don't want to block the chip and
> prevent sending of accelerometer data during 30ms. This is even more important
> because the FIFO can easily overflow at high rates, and there would be data
> loss.
> 
> Hope I'm clear enough in my explanations.

Can we have some (short) comment in the code as well?

...

> >> +     /* sleep maximum required time */
> >> +     sleep = max(sleep_gyro, sleep_temp);
> >> +     if (sleep) {
> >> +             mutex_unlock(&st->lock);
> >> +             msleep(sleep);
> >> +             mutex_lock(&st->lock);
> >> +     }

Ditto.

-- 
With Best Regards,
Andy Shevchenko


