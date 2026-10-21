Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792563549;
	b=HnuRQdVbuOxDQFXAwHFw65AZd/OZAUTsDAx/0tq9Lg1HSZjG9WY2WH9mq1M12rMI4uGk
	 jzttl4DMB2ya2yVMRUUO1UFNj5Y5Vv1Jkvc2msKXM2tCawNhs3uhk8O95nudkVMvvR7dy
	 ovafgl9OpU+Xgn1+ewMgw7hxbJEHq6p5fHqTFnCbtvJN5FT436V997NSsu+uBHssbPQFx
	 VQ8O6r/w5Wr+jgY55tlhD1jV0ZHrhLxEjlyRHw7/FVvsi+pWctHnol4F54I6R1Fi0uwZj
	 Zok7namKl90EFnZxBxL/+xgNhaX5GE5jPqjVyWPmlRaEZrRNXeVmRK2OJz+0bZTnvgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563549;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=n2RVWOwtwVAdp5hN/dRfD4IYzXjvrWfHTyFtS6kDdI0=;
	b=4SuNh+xK1XjH2XZNhgfxWr2DnbaXgmpMQM0xGwVdSANffK1QismjKrlUogbOZIZtSgR3
	 /EtGr7Xj9Z8QdFoLv2sH/49ALlgwKhSZTqija/cW0LL9yNArKkV/fT4I6JERpJd2RkxxJ
	 pJRyMh3hXltvOtLJVknnr17GHIA1cTcr+YNa64FI+JuKTuHBdSOGouZAmxvy3B+S+8hmG
	 yRz5ULpQyuA3D/HIkhsJI+XM5821aUyQEA81opstRCveI5gbtHgsK3c6I5XRcP/jDi71u
	 FUMuwg5tPACQ3jwhkED6tFi1bMIJmFg6S+gzcBSId2fpicnwSAzISiOllXdqaCkhy0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TCCCxBkF;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919D606A319;
	Wed, 21 Oct 2026 06:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3919D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TCCCxBkF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792563548; x=1824099548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4hf/ZYCQEbLQdcQAHf2NLPCtHj3/Vk+yCaDqI6OH32Y=;
  b=TCCCxBkFQzN/XRtFS6Q0csnAfvspgRCGTZx9zbuQ8x47KO5hkFIEzlNw
   oHt9+0oKHKcv8W0wgRpzc8Ysbxh2S0OMERdtyMXOdzKb0eCa2bYX3Yh22
   jyoItYSm8T/lvtG8kTQWeMEU9QBhzCHlGx8dfmH7HH82nMqR71zHhpl+1
   TmHJQlzqUKdq7BKU13HaeRFBEEq/Zpy+rcWpiNXICpmxwQqp2ht0SpiCp
   PHh+ar6UzkJlNBCcULm/hHXSK+upPO9/x6iu02Z7ixOjp+KxPOsgFcdRs
   HujFKvU0jPq0r/uKKYBcx0LsNIDN4GDBqDLQQzL7Y5BD/Zs5dcsK35FlT
   w==;
X-CSE-ConnectionGUID: eazXc6fcTSKcKNzQFs8R1g==
X-CSE-MsgGUID: kbwFHsvWRJutKf0Dgafv3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1259885"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1259885"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:19:07 -0700
X-CSE-ConnectionGUID: GjxiM/qyQv2pNpRG6nwxfA==
X-CSE-MsgGUID: vRjgnCvmQNyA5vhvOjzqAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3406889"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:19:05 -0700
Date: Wed, 21 Oct 2026 09:19:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Tsao, Bruce" <bruce.tsao@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: dac: add support for AD5413
Message-ID: <athZVjaGYmCyuNrW@ashevche-desk.local>
References: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
 <atXY4kLEXxmG-tnk@ashevche-desk.local>
 <DS2PR03MB84188FD41F8847EEB34759D9FB672@DS2PR03MB8418.namprd03.prod.outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS2PR03MB84188FD41F8847EEB34759D9FB672@DS2PR03MB8418.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 11:53:53AM +0000, Tsao, Bruce wrote:
> On Mon, Oct 19, 2026 at 11:46:26AM +0300, Andy Shevchenko wrote:
> > Why in a brand new driver?
> 
> Thanks for taking a look.
> 
> The nearest existing driver is ad5758, and the two parts are closely
> related at the register level (the DAC_CONFIG RANGE field, DIGITAL_DIAG,
> the slew-rate block, the reset and calibration-refresh keys), so an
> ad5758 variant is certainly feasible -- that was the first option I
> considered.
> 
> The differences are a mix of hardware and current implementation:
> 
> - Hardware: the AD5758 integrates a DC-DC converter (adi,dc-dc-mode is
>   mandatory in its DT parse and currently drives channel selection) that
>   the AD5413 does not have; the AD5413 is also 14-bit rather than 16-bit
>   and supports a different set of ranges.
> 
> - Current implementation: ad5758 disables the SPI CRC at probe, whereas
>   the AD5413 driver keeps it on and computes a CRC-8 per outgoing frame
>   (CRC is optional on the AD5413 too); the two also use different reset
>   APIs.
> 
> None of this makes a shared driver impossible -- there's a genuine
> common layer (two-stage readback, read-modify-write, the
> reset/calibration/slew/output-enable sequences). I went with a
> self-contained driver mainly to keep the change off existing ad5758
> users and keep the blast radius small, at the cost of some duplication.
> That's a tradeoff rather than a hard line, so if you or Jonathan would
> prefer AD5413 as an ad5758 variant, I'm happy to prototype it; I'd just
> like to agree the direction before spinning a v2.

I also would let David to comment as he has an expertise in the combining
drivers (if I'm not mistaken). In any case he is also an official reviewer
of IIO and might have some good ideas.

From my perspective sounds like there is not enough justification for
a brand new driver. I remember seeing such a configurations (as per your
item 1) just be provided via driver data depending on the compatible line.
As for your item 2, I saw some development for CRC case in another driver
and IIRC David driven that activity and he might give a better view.

-- 
With Best Regards,
Andy Shevchenko


