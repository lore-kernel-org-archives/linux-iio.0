Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253537;
	b=Y0YB8SirCDtNalEXFBCCOK1YHOE3K1uiAs9Mc5EVsLdFo3lLWkhtUyYksEhrR2JCjGNu
	 O7loGR3UUrXT0oL9oYZBANB65WtNbMRnGZNV43n+HFs/+y4CpMOMbM3INKUNSBlDl45zX
	 ALLPZsCRfgx93v7JDwvkKG/lssn0D8ANG2OUFerg7rGiOamHtVTdqoMuCCxUh9PeYjg6N
	 +BVMdBG+pbO1YYJdOrQaWK3QcSzC6FsdZofpeysTYmxaF0wsaiI+TTr1qkgzDIhnozc7G
	 cS9FBbub+IlGzNF70KCvwmifOS9yeyBlkv2ueN1xNxwGeU0uCgtMaPv1E/X+uqGNU0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253537;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Q4lNPn/UK40kisCgS/o/tQFd2nFoymjIVtaW1cQeiCw=;
	b=rJq1WlclWWlYd7DVcTCb8HIniS2Ui5SKktVERwVIKcwHJtUxs/fPZL25MugNC9RF+07j
	 0tjLM/Fv5uBePz6hamijxWUsQLqF+vGlS5Duo3ytKFK4Ndmxfy+0nKM2Kyzy9D3yNKy23
	 CbP7IlUZnPssE5XnW96Atxm7iFiA+FLKGjCZ8edQ+qjh2ctvRHkMXSyTtNN2YbUwR9V2S
	 tph27iBwl0rqN7v+U8Lf1nNQaMHX4Y8QKOYZh3BcEMFOM/aZYjNv0nEPMLKPgW4xe7xRv
	 p5J8biRV/kL0aY7UUxEMQiaLVd7cmXEZo9G/1QeWzxDv+s+77sbe1Qdb0YV1j2XEDlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FsVMDLq+;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9306606A31C;
	Mon,  9 Nov 2026 19:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9306606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FsVMDLq+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794253537; x=1825789537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dmur0JcSjI2h2Sn4a6LIR095JVkgSSE5Iw2d6Hhzk9U=;
  b=FsVMDLq+Mdg+QVKbt+CSMo6Sq+5KSUyoTO4shsrZSlV1LkhqsQs69Prs
   cCj1NNM6n19THfymMJdgmTegwFmjfjsPcnDya9f6EJaomAjkqXPY+q9EV
   BMAIccnBzg/Y7aKGkw2ouRKFxdocxLTUdyRv5cKK3WjLn1SJNIh6zDkWh
   hSO/XSA/x22ZXQeVrD1JcPGMdlRqcarQHMQ+igrVRH+vnO3lIz63pFnsH
   JjdgptXz6sgtpUw4tnyhqEupeNmkt0fDqutcdKcLtMwZxjqPCinveQcEU
   q+eTPHcJWpuGKRaste5TFrsdoSfa9GUb37D5D2KQ/VclyaF0cqMO3T1qk
   A==;
X-CSE-ConnectionGUID: 9/HKqxbaTeW2/Fk7GwzrGg==
X-CSE-MsgGUID: sKPmDPxsTPysgk8aTRqTQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3015817"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3015817"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:45:37 -0800
X-CSE-ConnectionGUID: kViXZNE9R2ico6E4XGQLrA==
X-CSE-MsgGUID: ymLHrCHYTDuxbi0VO1H2QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8285756"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:45:33 -0800
Date: Mon, 9 Nov 2026 21:45:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: Re: [PATCH 2/6] iio: adc: versal-sysmon: validate temperature
 hysteresis
Message-ID: <avIi2pDCcaKDx3Ro@ashevche-desk.local>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
 <20261102122112.1723130-3-amit.kumar-mahapatra@amd.com>
 <aumyreagvU6zewKI@ashevche-desk.local>
 <DS7PR12MB9503E787CBD5E9292B5637CEDC762@DS7PR12MB9503.namprd12.prod.outlook.com>
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
In-Reply-To: <DS7PR12MB9503E787CBD5E9292B5637CEDC762@DS7PR12MB9503.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 06, 2026 at 11:35:00AM +0000, Mahapatra, Amit Kumar wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Tuesday, November 3, 2026 3:39 PM
> > On Mon, Nov 02, 2026 at 05:51:08PM +0530, Amit Kumar Mahapatra wrote:

...

> > >     sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
> > >     sysmon_q8p7_to_millicelsius(lower_reg, &lower_mc);
> > > -   *hysteresis = upper_mc - lower_mc;
> > > +   *hysteresis = max(upper_mc - lower_mc, 0);
> >
> > But you can use abs_diff() and let it make the problem of the supplier.
> 
> I went with max() because an inverted pair (lower above upper) doesn't
> really describe a hysteresis, so treating it as zero seemed the safest
> reading. With abs_diff(), an inverted 80/90 pair would be read as
> 10 degrees, and the next threshold write would then set the lower
> threshold to 70.

Bu where did it come from? HW or DT? If the latter, we may just reject
the wrong values at probe time, no?

-- 
With Best Regards,
Andy Shevchenko


