Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2652189A
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897548; cv=none; b=BCE05gWzVc99JyjeC1CA2A0YXe4xap4Td8EiLEqCm4PbLuubi6D1IwCP9YNPZHZGSxWsEgeVr9KLnKKo0BmLMTlHtgg8NzstOVfhXHPuerl/0doQf/C1C1wn1K9iFwOQiCaTKDLiRaWpcD4CWlVsvcCUer02e9Fm/92UB8sxKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897548; c=relaxed/simple;
	bh=OcXYfaM4bvqDkRwMq0SFfCSnGfN72ua9XR75avAUsBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcK5ZvTGUBSkknNZ7oZhrpfH4b4erDijoAGbZs35AblpWcHOARoVanuKGh0+xFD1dyfg+xORDrX64PjNgHE/F4wDRntz/DENf8Kce6YprJD9ij1jAqfU3adEFElBBeiXxWMD1DoZ5P/u1TjMThlbgDAWkPSp4xZirgw3yBdwXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTIeV8Mk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTIeV8Mk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897548; x=1823433548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OcXYfaM4bvqDkRwMq0SFfCSnGfN72ua9XR75avAUsBw=;
  b=fTIeV8Mk40bNTKaxL+t41/25BjSla7QvfeUIbMHswLC3L4M0wq3DyjCF
   NfWtYUAio5CibBzI64TGWFWFWqm+9AG13N9U+xHZ8Sw3sJ901DTmXQnmJ
   upZcr1HYnY/S+yvenEP11rAe3R1ct+vBIKdzeNUuCA8NFZ5bx5BtB6g8A
   swpIAj0b/kJgF/yQ0+Z+BUetp7adA4qpOuKxw1r80uvJO7LxHXomBBqXQ
   ztOLbkRr36+krPIUDgfPd1mhtbpQGHkXcrl/KY0Mk8RfEjxBfqf/yB/Wu
   9heaZGuQhE9Hwygr5CID5UUu2Uy4l7EuppW+JP9w4sfAOMYOQT27wZe4i
   g==;
X-CSE-ConnectionGUID: Zf3BjJZcRGuSFBCu0GBYYw==
X-CSE-MsgGUID: O2Ws+aS+TrS16gzUgGZ8Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="495509"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="495509"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:19:07 -0700
X-CSE-ConnectionGUID: MswdxSD/SJqSI3koeoac9w==
X-CSE-MsgGUID: ltq+UJQdR96y3y4kn/wUsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2935343"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:19:04 -0700
Date: Tue, 13 Oct 2026 16:19:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Zixin Wang <ywp1023456@foxmail.com>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: light: cm32181: add support for the CM32183
Message-ID: <as4vxhVdB5tXimSA@ashevche-desk.local>
References: <tencent_C2E579008244A394105247CCC4787391C209@qq.com>
 <20261011184839.4d62884e@systembl0wer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011184839.4d62884e@systembl0wer>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 11, 2026 at 06:48:39PM +0200, Joshua Crofts wrote:
> On Sun, 11 Oct 2026 08:48:56 +0000 (UTC)
> Zixin Wang <ywp1023456@foxmail.com> wrote:
> 
> > The CM32183 is another member of the Capella CM3218x ambient light
> > sensor family. Its device ID register (0x07) returns 0x83 in the low
> > byte, following the same scheme as the already supported parts:
> > 
> >     CM3218  -> 0x18
> >     CM32181 -> 0x81
> >     CM32182 -> 0x82
> >     CM32183 -> 0x83
> > 
> > The driver falls through to the default branch of the ID switch and
> > returns -ENODEV, so probe() fails even though the device is present and
> > functional:
> > 
> >     cm32181 i2c-CPLM3218:00: cm32181_probe: register init failed
> > 
> > This was observed on an H3C MegaBook 14 (Intel Core Ultra 5 226V, Lunar
> > Lake). Its DSDT declares the sensor as:
> > 
> >     Device (LSRD) {
> >         Name (_HID, "CPLM3218")
> >         Name (_CID, "CPLM3218")
> >         Name (_UID, 1)
> >     }
> > 
> > on I2C at address 0x29, and additionally provides the vendor
> > initialisation and calibration objects that this driver already parses.
> > CPM0[0] reports a device-id of 32183, and CPM1 provides lux_per_bit =
> > 2200 and calibscale = 265859.
> > 
> > Treat the CM32183 like the CM32181.
> > 
> > Measurements on the above machine confirm the register layout matches:
> > the power-on value of the CMD register (0x0001) has bit 0 set, which is
> > CM32181_CMD_ALS_DISABLE, and register 0x04 is the ALS data register.
> > With this change the driver binds, the ACPI-provided initialisation
> > values are written and the CPM1 calibration is taken into account
> > (in_illuminance_calibscale reads back 265859). The reported illuminance
> > tracks ambient light without saturating.
> 
> Code is good, but no need for the above to go into the commit message.
> I'd have a commit message like:
> 
> Add the device ID for the CM32183. The device has the same register
> layout as the CM32181.
> 
> What you wrote should IMO go under the ---.

Most of it, yes, I agree, but it would be nice to have a product name
in the commit message to have better pointer in the future (yes, the
comment will be collected on lore.kernel.org anyway, but it is harder
to get).

-- 
With Best Regards,
Andy Shevchenko


