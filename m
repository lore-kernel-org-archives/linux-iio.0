Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E42B9A4
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449302; cv=none; b=pMdPERd9IRynR15VwvZ2uetczjBAt9p3V5PZTwEcpt+XXLF76qTzifot9rByQoc65VWhMRiYG3KoPMuoqBOsUkoUrlcQypyuIt3WoD5zGJasrankrPAr4XURAKJ/PKFSSFf3UvazeiZz+zQMXwc3MA7YbGH9wyNwCaM2mCTXBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449302; c=relaxed/simple;
	bh=zNW814ZpEDH1RoseTfATN67Y4ouvDLloiR+Wr3r+tj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5zqPLH8KQJjAWFW3V+UVdNqQ7u2Ts55wMhUCBs7E7qyonKElHusNphoSrJj7bQnkCfp13kAHsX2bp6otsQ5wuLARdruEYLarIdOO+I+cvw2xro5MMtw1Znh+TecTF39T/JLEy4CDS0OnYCWUWaIggyRDqrJJUVtO7/XbumnLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yrm4+8hl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yrm4+8hl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780449302; x=1811985302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zNW814ZpEDH1RoseTfATN67Y4ouvDLloiR+Wr3r+tj8=;
  b=Yrm4+8hlWygJYM6X/HLXHESTaFx7SVxEUDb8tQVNI/LjgYG5H3AqlJcS
   /EClmpUSfZAwzaPKp5DPOvYWQnX82aMOuXDSc6IkON21URyy80wznnomb
   yEcRqRyvfRVJmd2G3BZqKbbopmBGdLMgqopngFnPSxGyZi1gu4XYoan9Q
   0SFQsw83dDW1QKhIsULtESb2v5fiaxLAZZcm5y5Tzq2xkCBBqQIbTLsq5
   MDE+00fQ5yNBYkG3DZRyuvLNvdq8lwbMfKx9PWKPhYdwwuIAUkWBXnniu
   LgyR/v43B1PNucRZz2pAM0DO3X6RuaubqwmqPpjYXwS6qfKF3fxcNP6Ww
   w==;
X-CSE-ConnectionGUID: S/ScMVk0RG2WwGHjotnpWg==
X-CSE-MsgGUID: IrvGtk3AT5Oi9UgsTXLdnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80277850"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="80277850"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:15:01 -0700
X-CSE-ConnectionGUID: MBvHpBjcSg+23H+3n8iT5g==
X-CSE-MsgGUID: FoTUDHKTQKmE0OyorasAlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="282180633"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:14:57 -0700
Date: Wed, 3 Jun 2026 04:14:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sam Moelius <sam.moelius@trailofbits.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Stefan Popa <stefan.popa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	Samuel Moelius <samuel.moelius@trailofbits.com>
Subject: Re: [PATCH v2] iio: adc: ad7380: select REGMAP
Message-ID: <ah-ADnSU_VhacXqI@ashevche-desk.local>
References: <20260602164539.1541685-1-sam.moelius@trailofbits.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602164539.1541685-1-sam.moelius@trailofbits.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 04:45:39PM +0000, Sam Moelius wrote:

> The AD7380 driver uses generic regmap types and APIs. However, its
> Kconfig entry does not select REGMAP.
> 
> As a result, AD7380 can be enabled from an allnoconfig-derived config
> with SPI_MASTER=y while REGMAP remains unset, causing ad7380.o to fail
> to build.

Okay,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


