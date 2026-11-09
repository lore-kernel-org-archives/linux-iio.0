Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246261;
	b=UlgjsEJh+JasgoDwqvXblFYtlw3mnrfnptUNm80erVgLvNwvGhQWeiPVhLqd/qskvtBU
	 edzE8/tpq0XAGX30MG6qQ7aS5wcl+82I5zssIUReua0l3IZQcHIgSSFbg9/0lhpRPm6qa
	 36/qMUDnQtbaJE2rLD61Ei3Jm060qQQ2CdKkVfd8RRh/fG8AifVTkNB/+YTLN/sTyJa/s
	 t3Z++BZkW0NuDjtrWuicJXZijUn6HnLzKisWK1UfRqstIuRr3ZH4TcTNkpx2C2r7Ryk5C
	 RwTHmx43E4Z2QqhcRnssqEbuUHHNBO2pVPcfdvqI+n1IqvN01NPTxfqQmxUNVY76UPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246261;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=OjWZlamdfaT2Fsld90J6bx425flXrkvcRLjTjpBQ3dk=;
	b=ID0CWfhCmYa6IUGJPpViZVjkIrocNtWV9pbd6WfTeyb64Z6tL2DK2h1Po7mwxQmkRsdp
	 ccmu5NUvwvf3+/56tbTT3Jn98CYmiC6hjJ2b2IXufMlkapkUvRT+64oqaXgRamXusDo7c
	 yVg42W837yavwn3XIu/ejNIA+CqXlxNn+pEwWwhQmd7hAiLjO0JfBxvpw9CllqWEAplyg
	 PHQU8QNbViyNIAkvSpJh0hLVBw9MCyj5Y1mZ3MySh4BVdq7+w06zN3TrTBefp0cUjZJ8w
	 byhwiapFgY9Opo/UnQvJ+celd4TwoNczLabd6/l9xNSDs0xpmxnR8Q3fVXR/1FWR9zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PohMA5qV;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E2F606A31C;
	Mon,  9 Nov 2026 17:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91E2F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PohMA5qV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794246260; x=1825782260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NhxNjFEi6PnwzcWUVM17p+dTNJ9F3r9zX5QpBGi1PTE=;
  b=PohMA5qVn83zepr9Funvn6/7iku9TWysRynwELeDTyfL7qYHDdSiFi5w
   IRYVze212t18h4A6t5OALN0C2OyRsyOSG+f12S/Ver1lJqTFICCk8G1jq
   Ck3WS6gzUyycoWZZpgVsTZWUuFLZSxf5VlGN7vFFco5xZ8fDwLOjRom1m
   ZLAYNGyZYUf/y+/RYbdiyZWQBGSd1/b7BO99Ok5h6sM4DA8TJMZcL6bIC
   WN0x/yu7xofs7i94VGqBd/vFSAR4QQ7TzR64kmOnr3u860b+WQNhkCQh3
   T+UQh99Hj3ULfJLifJtgtPGSjKESGNM1WfovK4sx4qiEJj8g9PBtKtXiO
   g==;
X-CSE-ConnectionGUID: IaYKbD76Q3eLjg7bqWtUrw==
X-CSE-MsgGUID: vSDm1INAROCytBS4CecdFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2966527"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2966527"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:44:20 -0800
X-CSE-ConnectionGUID: JWaul6APRZuy2bfOcgRxjQ==
X-CSE-MsgGUID: CBMGhc3HQFK20IxsFhV6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8112629"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:44:14 -0800
Date: Mon, 9 Nov 2026 19:44:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz, herve.codina@bootlin.com,
	thomas.petazzoni@bootlin.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <avIGbBH88xZwndaC@ashevche-desk.local>
References: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
 <20261030164705.297354-3-maxime.chevallier@bootlin.com>
 <auyjgDddFs3OvnC3@monoceros>
 <20261108013218.0fe627e7@jic23-hlaptop>
 <avAy6cemm3MRHSQO@monoceros>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avAy6cemm3MRHSQO@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 08, 2026 at 09:32:10AM +0100, Uwe Kleine-König wrote:
> On Sun, Nov 08, 2026 at 01:32:18AM +0000, Jonathan Cameron wrote:
> > On Thu, 5 Nov 2026 16:42:42 +0100
> > Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
> > 
> > > On Fri, Oct 30, 2026 at 05:47:04PM +0100, Maxime Chevallier wrote:
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/mod_devicetable.h>  
> > > 
> > > Please don't include <linux/mod_devicetable.h>. <linux/i2c.h> already
> > > provides i2c_device_id and of_device_id. <linux/mod_devicetable.h>
> > > provides many more *_device_id and thus introduces a big list of
> > > unnecessary dependencies.
> > > 
> > > I recommend to just drop <linux/mod_devicetable.h> here. If you insist
> > > on full iwyu, there is <linux/device-id/i2c.h> and
> > > <linux/device-id/of.h>.

It must also imply acpi.h.

> > IWYU is always a bit of a 'roughly' case in the kernel.
> > There are standards assumed sets of this header will always
> > include this other one. I've just started assuming that is
> > always the case for these ones. 
> 
> Not sure I understand you correctly, but I think it's safe to assume
> that including <linux/i2c.h> will always enough to get a definition of
> the structs i2c_device_id and of_device_id. My preference is also to not
> add includes for <linux/device-id/*.h> in drivers, but opinions differ
> and so I typically point out this possibility.

-- 
With Best Regards,
Andy Shevchenko


