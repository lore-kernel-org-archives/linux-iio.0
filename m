Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC1449EB1;
	Tue, 28 Apr 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392142; cv=none; b=ikowohlPu3neZePi5lGQiVy/5YvIxsHQKAcprt6cmOL43L3Z9p3sIDiZetiE5GBQxoi7/HtJDu2vxoiteh3AhYzmiJws4gzA3elDi6VPwkAv/Kh4CkcbyX8sakNARNF5N0Y6IP+Tj+u8EV14MzX1jqcvY+ikVx+cWSlk8oAExwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392142; c=relaxed/simple;
	bh=sCGtYgIARAf0t4VMcpC67dyZgTOofijFuU32BwJVSaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sl9pkhu9cztv80IP7optiwzCUM6xH9emxTwSAoZG4dpIrd0wukq3FjHEtFgt3PpzwIRw2W8fRsYutwh1lE4AtY1Jka4kuJK19IQtmcSSTnSKpVOSql8FO/P8ogiQ27zPJwg2bNHVw9Vf/MQ4F6gHDPE1ckbKGT+FGHWSNQc/Bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFTzuepq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFTzuepq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777392141; x=1808928141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sCGtYgIARAf0t4VMcpC67dyZgTOofijFuU32BwJVSaA=;
  b=IFTzuepqpOrR6gGorZVcJsxcdT5pzcVLJpoKKeZFgyh3mtRvzcoWXBbf
   DwQfnmXNpXHCaBvatLw1jLqJKQcoSA4qcYdIGPt1zRmCS2tynk5pu4g0F
   k0AU6Zcm+vN3nL6gu6u1odbC0dkSTUy4XkOz3CSJ5/ghVmeuk3S+g/xPO
   3vTBBIuIY+Hhemi2RaCa3mut4w1VJBV1dKCp8KXzdo88zFEJsACoJc04d
   p2le3lKvN7oj0+yrldYvf7dMksPvcq9AYVDg3OB0Hcmrsoe+j7MXStpWS
   zRmHPkSVZigNQ9NyMn15MFjlokilicLgj1HcnjuGT41oLWBkVoZvpHEVS
   A==;
X-CSE-ConnectionGUID: c78EuMFLRTu3SNJLcn4jng==
X-CSE-MsgGUID: yftNdNARQha1D/AGM8B4GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78011958"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78011958"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 09:02:21 -0700
X-CSE-ConnectionGUID: Gxacr9ZQT2WVXi57nqzAJw==
X-CSE-MsgGUID: i454uou2QvyZdALrZ0RD4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="232968016"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 09:02:19 -0700
Date: Tue, 28 Apr 2026 19:02:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: max30208: fix wrong scale value
Message-ID: <afDaCLfAH2RHtqQw@ashevche-desk.local>
References: <20260428155349.68019-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428155349.68019-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 04:53:49PM +0100, Salah Triki wrote:
> The driver currently returns a scale of 5 for IIO_CHAN_INFO_SCALE, which
> leads to incorrect temperature readings.
> 
> According to the MAX30208 datasheet, the temperature resolution is 0.005°C
> per LSB. Using IIO_VAL_FRACTIONAL with 5/1000 correctly represents this
> 16-bit resolution.
> 
> Although this is a change in the ABI, the current scale is objectively
> incorrect. A raw reading of 5000 (25°C) is currently reported as 25000°C,
> making the driver unusable with standard IIO tools. Given the magnitude
> of the error (factor of 1000) and the fact that the driver is relatively
> recent, fixing it to match the hardware specification is necessary.

Seems the analysis is wrong (as per Jonathan's comment in v1). What are the
user space tools you referring to?

-- 
With Best Regards,
Andy Shevchenko


