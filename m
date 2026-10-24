Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792837162;
	b=KyiVFGf7EkoYeOxw4h6KP5ibDNqHxws1K8DK6mfDNAJf32iGZKFZbf6y013tJG5BFxkm
	 CjLONhCxa5XORwXlVgSjwXk9H+IoO9W3gLDj15n5gmR78vD+KFMz4GTz3fZVQOgVgIhtc
	 41KQBNf/vsp/nfUdVwJnz62T+JZEU7SHnRvLO3BMfZX7VhN9nXk8Fek7TKUwXel1zkpZN
	 qsLD1L3gtES6sSLCfGtxUyBd9wBvbQur/TK3qvmEa5tkfMfb6hYPeGbYkipo84BF0Xgd8
	 LPIQ40m2znaDkHwuonKTUb1lUn/C2rsOWRAUW096jQ5QpHz/UUqUy7M5NavoCniUL/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792837162;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=2RqYQbiVXaLqevGAiQkYMGaiRL+FuWRkjF4rLiMSOX8=;
	b=wZQdpriiRHgZ6ZasdzwaNOH27LjtEy08bD4KnHO+Vbz+9PUGAqx/7J65LEWZCFE1ak3B
	 2Xxsh18ny/8QpkGDjzqmWxIKHEt10pLHVFAMmw09n70K59pdMdz6yI0kHugvxSchxgEU2
	 ABn/usDlO6I2Av3xqba0sraC2R+xMG+iEKjde8UmlH8lX7dr0oQBLPW7d//AaI5wSHrUN
	 jtnJVgL20jeRJVwWeDpCCsm2DpK/lackXJNtG0f/bZgOvqDxdpXTyDZXEFHwrocRUllZ9
	 klnJKeaV9i+cy05LLVUaKVEp/HX+aqdr5oIexl/dhmBuBIWcvFGypbgeLEwDwR1qGlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FEm5pI8J;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D9606A31E;
	Sat, 24 Oct 2026 10:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B5D9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FEm5pI8J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792837161; x=1824373161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i7LaPFFFZGfnWqlBHlzl2Ego247wZQim5a3/1TmWPzQ=;
  b=FEm5pI8JyNmqsbcSUn8ZqU3JGF85mbQxgFHswIJPt823VJtHVhfrx0LK
   ZU7orkRM0zlBc0RoWAhJPStIxmbxtqX4Be7DF7BJXNsyyaoGpirOKYFRo
   RbamXRITUoCVJ8TthifTpA8kQsTVThI2ahXLtHVr9dhHWvGmtRUcYDbWM
   8HZ5OMsSkckkRXlwjtxkhYxfvAhsmoxmwdx2Lsah2d0oZ8DqwdPOCpyvs
   7D87+E9lIgMsr4Z95XnhKN+YSIH8QSwmd8m5O/M8zGqVhf3kLYbn1KenM
   nYITaI30m9YbpSxbCGn5ZK/FwU+r5yMuv1btihKs/c+qfM3KUY9OgjSdh
   Q==;
X-CSE-ConnectionGUID: 0N4ZX62MRSqeZVJzulauOQ==
X-CSE-MsgGUID: jwM4KO47SrWwND9vmHjJUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1475355"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1475355"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:19:21 -0700
X-CSE-ConnectionGUID: ajIG8aHzSy2yqEJSQGvVew==
X-CSE-MsgGUID: KR6SwqXTSRaOVrnx54AaDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="3726531"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:19:19 -0700
Date: Sat, 24 Oct 2026 13:19:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <atyGJD4ebU6Sq8MW@ashevche-desk.local>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB25288BF227D6555AEE60DF73A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <20261023040143.2e7043bc@jic23-hlaptop>
 <SN1PR12MB25283EB260FD897BFE29C603A5632@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB25283EB260FD897BFE29C603A5632@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 12:13:08AM +0000, Victor Chernyakin wrote:

> > I'd look at using regmap even though you only have a single bus. It provides
> > a rich set of helpers and the caching functionality that will save a bunch
> > of bus traffic.
> 
> Ah... is that a strong preference in new drivers? That would be quite
> a bit of rewrite work...

Yes, usually drivers start being looked cleaner. On top you got a few benefits
of regmap for free (cache, debugfs, tracing, maybe even more).

-- 
With Best Regards,
Andy Shevchenko


