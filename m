Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826109;
	b=G9VgE/QPNTfah1VDMgpRi6WEugrdvzA5Mcxm0i1vZeJJMDTV+Rs5oVQ7w5dlSwvrwxGG
	 /mlo8Mz1GMfk4OR6GS9CafoasBppRWATeA7zqnRKVj+lUXw+ivFe9pmV4cIFV89f6WmUY
	 nQAYqqEoNgRiuWfmUDdNdeu0fztCFtSRP9r27YDGrJ/i4BmwECZXJqFEXswMky4WWa0HH
	 ne49SnaZxEWnSqYTuqVzYnnA08qJYMDsnoKftZgpEwqSuzdm8ze1KLwc3LadV47uFTC/M
	 w8heB3tVxshGTWm5Zc9Zn+pQA1zIk7yPeRpYMxdUDlGmp1cVD05KpTH4Nd9KdGq7x3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826109;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=8RXywwsZ9AZmLU1zClqzYGdbInCCuXneMgvMDOLwy/M=;
	b=mAX1awtrxdOTESU9bH5gApQACMaxdQa3PYroEJGemHaGCj8RvvopOGzU5GmQDS/nOR7R
	 2hGWsUZPNW7b17mvc3Kzankynkhv4EK5PkPNR6iyNPHNZ626Vh4bFGLcBs+LhloM5Ywfn
	 y6+LwSH0iUWWOnQvGdxfEoYxxbPaig8loVi0VRlD1WT6Z5iDbLkOZobkKY8VJF7yX1ide
	 6QAYQ/5MeEhuf8d+6DbwhoGWskjSNnoj2HZqWkXEmFhV4mPIwiHxmOfx2SXd5ham/LNvW
	 IU92UMR5IUJm9p4bQGRLPdq8TUlycowJXnrcXOgDKDKoo4IofxVqSa+9QPEoaCwnfgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="L+Q/deRn";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D0606A32A;
	Mon, 16 Nov 2026 10:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32D0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+Q/deRn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794826108; x=1826362108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+qqV1FaPOgpA/CAWwvnFgJPa0wgo6U3qzrnbn+rslMI=;
  b=L+Q/deRn8Lx9cEuH7tIucRhA/OpFM1SgYOs6OP5spw1Dnq35S4oRtGCW
   q/tRLuaxFADtnlkVvzeZWyQYCzEXN+DM6my6OuuMPE/c7yrv8w6yS8xmD
   Ne0TF6YUg0JdSAdtofwa44Nb+XzvoJanN44xNV3llJtOtt0gty2GR7ir0
   oVxJUh8e0cAMUeY6AnIPpsbidh1sCGTL0SZXvZJzTHcBkqKdRzZ8hrnBX
   XFjf5phbgZVcUqDuuembLc+pClPePUI6S6g0zb5hLNLewAS2LPcgX+9OO
   XoqSNZjCf2ZG3nR/zPObtT8GcyAVUZit1+WgKAiU8t8hQu8QbLPqmF+eD
   g==;
X-CSE-ConnectionGUID: dd0wGUeWSl6M/HHhGo2Xdw==
X-CSE-MsgGUID: 7Iuq3/v7QSqDDB72nwZI2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3474479"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3474479"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 02:48:26 -0800
X-CSE-ConnectionGUID: aOaSJUSOT6euyHcLWqrl7A==
X-CSE-MsgGUID: 5LFiVV7hQ6ygTvGIAcj/KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="11228579"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 02:48:21 -0800
Date: Mon, 16 Nov 2026 12:48:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Adil =?iso-8859-1?Q?H=FCsrev?= Tepe <tadilhusrev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] iio: proximity: add Imagis ISG5320A (Samsung
 Galaxy XCover5)
Message-ID: <avrfcgqyASTtaVhu@ashevche-desk.local>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
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
In-Reply-To: <20261116074013.355363-1-tadilhusrev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 10:40:11AM +0300, Adil Hüsrev Tepe wrote:
> This series adds an IIO driver and its binding for the Imagis ISG5320A
> capacitive SAR/grip proximity sensor, as fitted on the Samsung Galaxy
> XCover5 (Exynos850).
> 
>   1  dt-bindings: add imagis,isg5320a
>   2  the IIO proximity driver
> 
> The driver exposes one IIO_PROXIMITY channel (the B-channel signal minus
> its baseline) and a rising/falling threshold event. Tested on an XCover5:
> it probes, registers the IIO device and reads a stable baseline value.
> 
> Based on v7.4-rc1.
> 
> Tool usage
> ----------
> Derived from the Samsung vendor driver during XCover5 mainline bring-up
> with an AI coding assistant (Claude Code, Anthropic), which drafted the
> mainline IIO driver and the binding. I reviewed every line and tested
> probe and read-back on hardware. Review comments are welcome and I will
> answer them myself.

Why a brand new driver?

-- 
With Best Regards,
Andy Shevchenko


