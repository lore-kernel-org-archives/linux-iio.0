Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089344;
	b=ExIpR0msrVWshYyPfqKeT8XVdCab00T30JaRNAZlbOR01sQvaAHDAQxf/I2iYoT/dJ4h
	 zROl2vrH6Bziwee41hYXrpF4E9g6cfmYDXvmS+5a9LTLTu1GahBdsEBEutH3SSo0T7G7h
	 RpqBQgXQnAZ+aDOyS1Sr4FrpfsoADZRN+40SUC9iVANe6oW08c5prYGOoOb/9AX0AOuf5
	 UcpAJL2xSiLaCcwLiBkPy9JLHIbnrQnpEumqEq21kvG8KF8ueFyO4FRG7c/d6CoPyEtzA
	 aU4scQIfllzbnBZcAXE1rPBt6joRDTrZFycjjsxwWKNx0NftznUB1pqAtcn32JlJnpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089344;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ty47ssA85KqK30ALyeUvqQyKxXAvo08RIl1Q47l5mfw=;
	b=eTj2Hu3X4FUyeoVLgwVd12jps7h8HsDDz+29tHa1rGKAFMUPLixIUUljJucmbMRGmciy
	 px55nhbqRyXWORXOfLIiIomIeXUIKZB2wIyd1YnSUgYc9ZWLLjREpp00Q3ay6l/Jm5hIC
	 dSsk+QxeVEpDdOSvqdY8AMvFrXgG81JS3lFGx1UPKk715AoIPFCDzxieTPR1bClr0Wvjd
	 YW8m6MwYe6ldnu/z3xs6+ovs2/5kTazynBcm+x2dWfXWDyy2ft7FZEQa4PyBaUtmgstMc
	 0EBZaXl3csY/b7xDcY1Jos58Oym2IYEEENXfTC5NP+sFGFTQ22VUNIAXLHDD2zAHUlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WBHCMoPj;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA96606A31B
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 08:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA96606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WBHCMoPj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793089342; x=1824625342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nWvVOlHKqjyAgVSrbqPTdWQKUrCRHe1YxrOq9W+0HQI=;
  b=WBHCMoPjKhFfo8aQPJ0//Xr6IIUktzToECXOGzkP8zGaS1k6ZedaBu85
   IoDk6RObbmGA5bq1m9b7+iD/biHw7rWvk61pcTw00yNcJGk2yoQ5mU8r3
   yyFh8VZHe5DiJNGytrR9qzXTJnkOua2pxPp3zkzyMcS7Daq2oVG7shzSj
   OzTNiDBYEE0372iRv21PlUsKD8ugLaMxn5CxRgg/CnkNkaic0hpwVqK5Y
   GDy9kLFoQlyrlHqwrgTugZewvH7BGTClfaDy+CJt8QYaQ2xEVKyaZGVTO
   QpuMoCAA43s31BlOpQtLIhYUv1WAivBzdyNChMPDv57nqqMoufReoqE3r
   Q==;
X-CSE-ConnectionGUID: TeGRBkhuQwi54yRnzZnzWw==
X-CSE-MsgGUID: mzFzf556TMe9V0LLQh/iLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1686486"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1686486"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:22:13 -0700
X-CSE-ConnectionGUID: ntXmVlcQRGiFbxDKy+/bOA==
X-CSE-MsgGUID: ce/Qks4bS0Wd+gPJlwpqjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4824607"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:22:12 -0700
Date: Tue, 27 Oct 2026 10:22:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 12/39] iio: proximity: isl29501: use
 iio_push_to_buffers_with_ts()
Message-ID: <auBfMhYTESe62Ejv@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-12-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-12-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:30PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

...

> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				    pf->timestamp);

I would leave it on a single line (83 characters only).

-- 
With Best Regards,
Andy Shevchenko


