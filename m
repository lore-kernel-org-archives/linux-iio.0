Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700533;
	b=GrFOdSvBYLBLKZfzdhSCwecys3RQdt2eIxMSgYMDdzODIiQMnG8OnRobCS/3urCz+pOq
	 MTR6QbTFPAkefZagQuBQCoHDlgXKOyL5HXEerzCynYNJLNd8FSUNOQMj3RIYu/Rz9qME+
	 zcyavDE3jYoUsIR66xdC8fQtD7TfgfYrFDxJ8fxs8+tHRtnQCEjD/8gFZbvP8ezjehx3C
	 vHUvwuvEf21cFpcZryb31T26lCakhVhPP/CvEOXb33qsdo6gCIzqeiW43v64ZXPw8GzKL
	 EuAcQy/Xn7T+HqDkGYSwJbeFBRuqUF2yywLldrRZMU/vvCfEke2rzk70S9IFd1z2yYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700533;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=8KzZPmQWKpFfwedrWal3j0q/tss3h22tq9Xd8BFMIiM=;
	b=efoesbHx1W0CdZhVkG0f7a3eqCQQyLoEPInRcyyT6K9Howp6nQQVZ2s3Y1RFsrYxLGaY
	 VxaKsSrEkscgHH7dWPxuMWjwzRSrJVqxtT3bITWU+tPmfIloZnxKTeUmPCEDW627R4a9y
	 o8cZ8awk8jn9MrcHKEYSnAMBUFbZ60Bi1DWXN+M5pxyRCKEiej4GgoknKlp9b6fdzj4sQ
	 PPP+s2+ZiEH0b8SPMYDpU6nIvWE1NBUfTlC8vU51p9BomNCKIJQ3CbjTBGgn+4ToQrS8x
	 SclWPbd1hhon72Xd+QXHLZm5seAOsYAZUOyDqvGJHVZteoxW2hipPtsLcAKKUUjnMkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OPJUJHpc;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65702606A817;
	Tue,  3 Nov 2026 10:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65702606A817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OPJUJHpc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793700532; x=1825236532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kWj2t1Xhllg559lUzgTByeT5Aew6Be5zNCiU7VYPYLI=;
  b=OPJUJHpcIOY1zVhZgKvBAOrUFmNK7H2iAcY0XoyTLNqRLecdHesWg2aQ
   sHhflJGcQ6QOFrMvNgIVkaQGWXA4gaiCZOBvspiO0ipFXCBxEjE2t2YD8
   +ICixfcyOZi6Z5g3xbnPKh9v7itxvi8tOfHYOgQKmWNjC7XUC52BNGS17
   ZkL/uJ1IMP7gTTcWb3jiwmLOHXv/0LGVbrWl7JkD5n9uvh+UFnrT77Le3
   j6tRKkPpE0AMfvgnW5v7f3bG9vvsvU4B0Jc0/ojPlnXVqVrtxyrzW9BSn
   3akIjEQztithiocy/63KhwRP0zYPTtzVxrvXfxxRU4w7ny5VonQRpI9EN
   A==;
X-CSE-ConnectionGUID: 38Z3G1d7QjuUNtH6lxE9BQ==
X-CSE-MsgGUID: +pl1lDYJS9qz1XgAFXUrCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2309018"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2309018"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:08:51 -0800
X-CSE-ConnectionGUID: X8d6gXcVSNu49kSHU0duXQ==
X-CSE-MsgGUID: h1JahsWBQu6jcpYKNxKbtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6243167"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:08:48 -0800
Date: Tue, 3 Nov 2026 12:08:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, amitrkcian2002@gmail.com
Subject: Re: [PATCH 2/6] iio: adc: versal-sysmon: validate temperature
 hysteresis
Message-ID: <aumyreagvU6zewKI@ashevche-desk.local>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
 <20261102122112.1723130-3-amit.kumar-mahapatra@amd.com>
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
In-Reply-To: <20261102122112.1723130-3-amit.kumar-mahapatra@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 05:51:08PM +0530, Amit Kumar Mahapatra wrote:
> The hysteresis written through sysfs is only checked for being negative.
> A large value makes upper_mc - hysteresis in sysmon_update_temp_lower()
> overflow before it is clamped. Reject values above the full Q8.7 span of
> 511992 millicelsius, and name the Q8.7 temperature limits so that the
> span and the existing range checks share one definition.
> 
> The cached hysteresis is seeded at probe from the threshold registers
> without checking that the lower threshold is not above the upper one.
> Treat that case as zero hysteresis, as negative values are rejected on
> the write path.

...

>  	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
>  	sysmon_q8p7_to_millicelsius(lower_reg, &lower_mc);
> -	*hysteresis = upper_mc - lower_mc;
> +	*hysteresis = max(upper_mc - lower_mc, 0);

But you can use abs_diff() and let it make the problem of the supplier.

-- 
With Best Regards,
Andy Shevchenko


