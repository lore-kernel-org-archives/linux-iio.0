Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224E175A95;
	Sat,  9 May 2026 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346925; cv=none; b=V51LZXJtlQpRG0p0VKhfVcWXJKEzOJacOWgSJBTw0YKLeMvuyLzeKC70/OouPo2m1mPGiHXaWMTe3g8HUcV5T1Uz1vcE4b4YQEbOvq4HFjgfKAGGFnSg7J+ZUH2Ejru8oo/Gzw38uXrgwUl2Hw5WP7deEgXBkUGYgmfxw3vrekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346925; c=relaxed/simple;
	bh=BuhtUO0pHAHaGxpAYxhwoB/+NL0WL4rlnXSUBolJMUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1S3rJLfRXXy30zPH3+XrNzl9bfb6S73DlrGX5jQjQx1UHZnQGe3p5D55ny4XjoWnjZHYlGhqwmyWvkjbCGRb5MypadtCL27TCQIF4fKYtMYqMmLg15HUbcwuhyMnhZ8GIWvx2nnp5FXgXbfQ72UDmADZXfMlHAIo0XktmaVzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSHCMn/q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSHCMn/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778346923; x=1809882923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BuhtUO0pHAHaGxpAYxhwoB/+NL0WL4rlnXSUBolJMUg=;
  b=jSHCMn/qlBeSk443Q7bYBXOtsW/Fqga0lQf2fTfgcTdBqGSo3aaGGXrx
   pgc/55YcWXnJS6njs+Qr/7zZrdvc2yWHKKWMz1FMC1+KA65Ir0CeYk3nL
   cPOFahA5PqxigeTIkfDgaPeDlHrMWHb6r8snaE7XJQABmNRXrbV8F6Sq9
   /B6Xk3B/zRySHW2WlSkrmm1fjIabpj3cSUjPU8Efu2vYfTN1mJC2vy5yB
   9JYErhmvGBjuA9AGGffWpmIFhCwhYfHiZHbKCdgeTzLnTnr3nTd2hJGNS
   CprBufcfLuVMcvzSUPr5vGa8OjXnt4EfQ3l8gcmIHEVpdMNG8EevWksOw
   w==;
X-CSE-ConnectionGUID: v6WAygO9Q+qUl11Xe6vf9w==
X-CSE-MsgGUID: T4d5h521SE6SoG3+2dxVYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="90402625"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90402625"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 10:15:23 -0700
X-CSE-ConnectionGUID: uEI7mJ1+RdyDz0j4UdY13A==
X-CSE-MsgGUID: zFfo3ycJSOCUhs8K2Seyig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="267420452"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 10:15:20 -0700
Date: Sat, 9 May 2026 20:15:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: joshua.crofts1@gmail.com, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed
 resources
Message-ID: <af9rpWwL-rdwmQYJ@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
 <0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 10:03:38AM +0100, Nuno Sá wrote:
> On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:

> > Switch the driver to use managed resources (devm_*) which simplifier
> > error handling and allows removing ak8975_remove() method from
> > the driver.
> > 
> > Note, on error path we now also set mode to POWER_DOWN state which is
> > fine. Even if the device is in that mode, there is no problem to set
> > that mode again, it should be no-op.
> > 
> > Additionally, remove any pm_runtime_get/put*() function calls that
> > dummy cycled the counter to autosuspend the device.

...

> Maybe it would make sense to move this before devm_iio_device_register(). At the
> point we register the device, userspace can start to interact with the device where
> we have pm calls? Not that it is a problem (I think) but makes sense to me to enable
> PM before exposing the device.

When you called devm_iio_device_register(), it's already user space interaction
there, so device has to be prepared for that. Do we guarantee that device is
power enabled at that point?

-- 
With Best Regards,
Andy Shevchenko


