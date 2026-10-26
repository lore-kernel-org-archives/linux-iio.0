Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007350;
	b=XVTnolq5pVIph6QNk0R2wEqObcdqnAFlEUxMSH4B4KQwMbkCGtSd7xUOEw5IUotZyEmT
	 g+AAO/7Q/oLH1m9RDln1r64sedV17NgCCUgv6eZ0o/7s9BZWaFl8Zqlh6EaZqhh/Vr5uU
	 JkEPOcRHhp0F4mHofDhEGwYuGrL0Qf+vBvPEzx9pa73TCA8VwSeQ/qTLhhg9YiG1Nbtrb
	 Y19sQdYmDTrxcXlCpeu2YJ7FYszbETERR8DK85WZZSICRPKevUM8aYLMSnhNvfYnc+2iE
	 xeeZ3fppKp2KdzY5RF7zcEBRzGZvZyAYp3oP6egG75znwF5P+Uf1z/VdAKSV7ktAmzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007350;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6YsBA4Ee5PSZdt8L0zDA3t2tXEnH24VTCBnneo576i8=;
	b=ChfKWOrAw6H7JLSt/uKd56KKm/KI4FPW7BnIM1zOMLSiQTVCP80TMKOJnFEYpPyDpdQ+
	 bcfBUOuYiEVUGor1uI5pL9CvJ+WSHg53EA/+sItZrNatNrqmEu2E2GcEqtsHgMMOeu6eM
	 /UxegWs/RzUj+LL/fX3V1XHiUFuV1u2IcCdni32nmALpQbBEzyFHV1hVFYTmxEGuT72Ks
	 yV4KXlLyI4QK1tlz8dVdpAnMW5NWHTeTMzIF692w7Kbyx0wDd3UQ9PZJDFJfw+obZMk98
	 4yERE4UDB0aI3MDBJ7eBZefDcMsjB2PJO/msJMUYqywF0uG5D/qbTFDsQv6o35YWQnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C1dqIIoR;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52D606A326;
	Mon, 26 Oct 2026 09:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F52D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C1dqIIoR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793007348; x=1824543348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b/SDW2mb7o05e/qgU2YoufIPTurlDbBkSRJ/WcAWOug=;
  b=C1dqIIoRKM+k+wJhMz/o5VBurVP4kHLxFWY2ibgwFtkHP3crlrFpYgJi
   lXOQ9vGOF1wrHe7dLu7zRaloPVJcAtkWdrxtgOZsYJRXXlCfED5LOmr+Y
   F0l5/ekIl1H9SPLo1z/8ZQyBumqqpzjPDeBGLlmtrVGQ39OYbuabd0Y7U
   QLFCwqp5rkDC7QzFKEAljHjkDJdTYCFapYn5Z3YaozCFKYDTYpycXE6HQ
   aQUjKaVenCV2gruboGw1KVoMZbjqNNdmN/mibaalqq4JfXiqbtenprZfS
   qVwXAaQguOwJyYaThD9N22a0oMRFst087wNwiTGqS1cfKgk5ZNGfe6fle
   w==;
X-CSE-ConnectionGUID: kV+ppmwUQs2J6wqeWFLh/A==
X-CSE-MsgGUID: 5B/ZhRfpT7Wqbuo2lOs4HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1563321"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1563321"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:35:47 -0700
X-CSE-ConnectionGUID: ksHphfCLSsGeV9UaGbAnMw==
X-CSE-MsgGUID: H7cIiJWKSXSZaGN2PCxsgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4166420"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:35:45 -0700
Date: Mon, 26 Oct 2026 11:35:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v2 0/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <at8e77xcrCAxDiWu@ashevche-desk.local>
References: <at5qzj89R8W4K5Zc@ashevche-desk.local>
 <SN1PR12MB2528B7C10FBE90A0B31BE375A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528B7C10FBE90A0B31BE375A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 04:35:36PM -0500, Victor Chernyakin wrote:
> > > Changes in v2:
> > > - Patch 1
> > >   - Added tests
> > 
> > >   - Added a fix in iio_format_value
> > 
> > If it's about abs(), it should go  in a separate patch.
> 
> This is about both abs() and working around overflow when
> computing 10^scale. To be clear, neither of these were problems before,
> they're directly caused by the new units. You're saying they should still
> go in a separate patch?

For a starter I'm saying that changelog should be more elaborative.
But conduct a small research and check if it's possible to split. One fix per
problem is what we want ideally. However, there are other aspects are being
involved (in all steps), such as code readability and additional churn made.

-- 
With Best Regards,
Andy Shevchenko


