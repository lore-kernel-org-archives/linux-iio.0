Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608553016F1;
	Thu, 19 Mar 2026 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904041; cv=none; b=lZy2g8Y4sDhcwjzP8Z4KNDmhKdne+rs2ZiyHivpUoS3WbCfVqSUmkY7ZBV/eHIDVVLvQrWqrU65u5+mN0oC6Ahd7CEHE/+zojQrAJ6bAPGagthPG4SaFWv0cZJiM1Cgh7YxWnixcwyCnZaptxeK+R1v5lJ5VEA1rsv6h4gyq6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904041; c=relaxed/simple;
	bh=HqZvxv5M3Uc//u5TR+0IiGxebSg1L8EwiNhZt0Tr8Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUCqul4V1zMDyR587y10mYQA4qeu3Y0zxg7c4/LHQ5iTWUJdpcU/XoCUCsKqo9ndcfIH2SVas0Y6mPEvBEnylxMvWtwItJ1xmE6ErpB3D1VYDe/VnZRpojeLdAz6o4XxsCKiS1vuzQmiojUw0a9vC4jeNYdpSH6Fj1KO24MQe5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8vuUbf7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8vuUbf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773904039; x=1805440039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HqZvxv5M3Uc//u5TR+0IiGxebSg1L8EwiNhZt0Tr8Cg=;
  b=S8vuUbf79tQFqHgjfE+3v0v3PRDVNhvffaZtCL2xKXHMcS+5x4NTT1dm
   AJh2FysnSQX2JpRus2CPs6b+NFj7pnj+vxtRNirmFFJ3L+k8ug9FZNwfA
   GPpFoi7qiGPJzTkznWVXYCoq3tbMVkqnadPl60diAEF8E7UXPZUi3sa7p
   cELa6FSVHviOr6+Tp42tp8W4jYucQy18covuejwtoxNFVB8Ja+5NN7B34
   XGTq2LuJd4zWWCM7sGgmkZmPOUP//SqhjOS8qie2a3BlW+pV2VpuyxfTM
   Xv8SA1h818e8DWFW97NRaXcjk/AEweR7Mu76n4IxYe9k1Hu+JTMwayJLp
   A==;
X-CSE-ConnectionGUID: fbqmEUm5RturZtpvrUKCUQ==
X-CSE-MsgGUID: da4YM3/BQgGKnTrW64+k/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74666116"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="74666116"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:07:19 -0700
X-CSE-ConnectionGUID: TisbXhG1RlqXgYBlscCYDQ==
X-CSE-MsgGUID: pLxhv4gWRk2RBqMUIujc2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="260772059"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:07:16 -0700
Date: Thu, 19 Mar 2026 09:07:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <abugoaMtEV75Fyk8@ashevche-desk.local>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
 <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
 <abpfdELI33a0Ncl3@ashevche-desk.local>
 <PH0PR03MB6351A1A32896F5CFF05A4C10F14FA@PH0PR03MB6351.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB6351A1A32896F5CFF05A4C10F14FA@PH0PR03MB6351.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 19, 2026 at 05:23:07AM +0000, Torreno, Alexis Czezar wrote:
> > On Wed, Mar 18, 2026 at 01:13:36PM +0800, Alexis Czezar Torreno wrote:

...

> > > Changes since v1:
> > >   - Removed PWM, GPIO, clock generator, debugfs, regmap, IIO_BUFFER
> > 
> > Why was regmap removed?! Was it not used?
> 
> As far as I understand it, regmap also gives access to debugfs. When I removed
> debugfs I also added regmap as removed.

Not only debugfs, and it's unrelated to the any custom debugfs interfaces in
the driver, it's just a feature out-of-the-box of regmap.

> For the spi write/read I am not using regmap as the device has some features
> that I think regmap_read/write couldn't support. Namely the variable data width,
> as the device only accepts exact amount of clock cycles. Future patches will also add
> variable SPI speed.

We have a lot of flexibility in regmap core. Do you think it can be improved /
extended to cover the cases like yours?

> > >   - Removed all custom ext_info sysfs attributes
> > >   - Simplified to basic raw read/write and read-only scale
> > >   - SPI read/write can handle multibyte registers

...

> > > +#include <linux/array_size.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/cleanup.h>
> > 
> > + errno.h
> > 
> > > +#include <linux/iio/iio.h>
> > 
> > + mod_devicetable.h
> > 
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/spi/spi.h>
> > 
> > + types.h
> > 
> > > +#include <linux/unaligned.h>
> > 
> > Follow IWYU principle.
> 
> I did miss errno.h

You missed more as I showed above.

> but it seems the IWYU is stricter than pragmatic.

No, it's not true. The required headers is exactly very pragmatic in order to
untangle the dependency hell we have in the kernel. You can browse the lore
archive for that keyword and find tons of problems people reported in the past
10+ years with that.

> Will adhere to it better.

Please, do.

-- 
With Best Regards,
Andy Shevchenko


