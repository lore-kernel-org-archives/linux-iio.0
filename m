Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877407DA66;
	Wed, 10 Jun 2026 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117236; cv=none; b=gTa80XaivQCFGmwle2arvJvVeJQtU/hQktVHNwuKZ/c8ErNvw8geQs7ctU9CIQHMFW+aabLRyz6Ilo5/o1wZUXjioQMkWKIX6PClXnY8KIjAV+xhVPoqnUR90bg1gnrkMWe8f5r0Zd/A8GgQTfNywHBKg8kyA9KpT1HSSgYnWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117236; c=relaxed/simple;
	bh=XJn1nN80Mrs0zfneGaUZpf4iFT0ELWNA2OOHfHR7TjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWL7sImzRo8sJi48iAL4rTtRT0mMCKpNAudzm+Wxp5/nR7nVpwqcpCKaroN1ifq8g34Fhvzrubhzf/PVraJGUm4Ht4Y5Tul47AafwrEfAaVbgrqW6kBIeP0IiAbj3wcYZHzWz+p4SPVBPN7rME22nNh7Qp72wUc97V/6UE+8Y0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkZ9ibz1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkZ9ibz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781117235; x=1812653235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XJn1nN80Mrs0zfneGaUZpf4iFT0ELWNA2OOHfHR7TjI=;
  b=hkZ9ibz1WkwKpzctFQ6KyshrYOe9R1rib7fEuFQmd1IdMPru7ODYNrZ9
   7ukBbVsbOEiBnQhJjhJl47Ch0N3+5wOOL1nEX7bCkOkj3nMMe77zPK1/i
   +jQHMOyUfGD7urgqZom27yJDkTABJiK0/kJ3rhiw27H1d3zkz7kUubWoH
   K2cDGTeoPsQ1dCaeDs15Tce2SjKp36TAxGkkVAW03UBY5N9XJi7DgcMfs
   Fna3rXtsCrCfKdnXR6OcCRQiSYOseNuTJpUoU8mCA691QPFyo0Fd9/MoZ
   OKa72FcefpYcz69SFEuWb8Oinf/KIfCo2rGtflmV6gqEaSdNAm4AqDRHB
   g==;
X-CSE-ConnectionGUID: y5+KJpPfT7mZPfUw0mBFrg==
X-CSE-MsgGUID: t4b0h80tRR2jCQaLUQQuVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85761837"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="85761837"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 11:47:15 -0700
X-CSE-ConnectionGUID: ivWHGwvZSiytIpJqYiLNEQ==
X-CSE-MsgGUID: GJXOPYqCQs++8PYQ2zipPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246110154"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 11:47:09 -0700
Date: Wed, 10 Jun 2026 21:47:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to
 device_add_group()
Message-ID: <aimxK3asZjebYrNt@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-8-clamor95@gmail.com>
 <aihl9yIqN3adKWLr@ashevche-desk.local>
 <CAPVz0n2+27QVeWNgPm3PH6V2Ceuym6sbMtUrh7hSHe9PcRmfMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2+27QVeWNgPm3PH6V2Ceuym6sbMtUrh7hSHe9PcRmfMA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 05:38:38PM +0300, Svyatoslav Ryhel wrote:
> вт, 9 черв. 2026 р. о 22:14 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > On Sat, Jun 06, 2026 at 07:57:31AM +0300, Svyatoslav Ryhel wrote:
> > > Switch from sysfs_create_group() to device_add_group() including device
> > > managed where appropriate.
> >
> > This should use .dev_groups member of struct device_driver.
> 
> Specify pls, device_add_group literally uses dev_groups, I don't
> understand what is wrong.

dev_groups of the struct device_driver. It means that the data should be
static and be available before driver probe is called.

...

> > > +     ret = devm_device_add_group(&bd->dev, &lm3533_bl_attribute_group);
> >
> > This will make Greg KH very grumpy. (For the record, original code as well
> > but it already is in upstream. So, thanks for trying to address this, just
> > needs a bit more of work.)
> 
> In the prev iteration YOU asked to me to adjust this. I have adjusted
> and now you say that this is not appropriate. I will just drop this
> commit altogether.

Yes, and I still tell that this is the way to fix that issue.

You can even do it yourself in a few clicks (hint: `git log --grep` is the tool
of the day): 93afe8ba9b01 ("ACPI: TAD: Use dev_groups in struct device_driver").
This is an example of what I meant.

> > > +     if (ret < 0)
> > > +             return dev_err_probe(&pdev->dev, ret,
> > > +                                  "failed to create sysfs attributes\n");

-- 
With Best Regards,
Andy Shevchenko


