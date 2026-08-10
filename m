Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEBC439328;
	Mon, 10 Aug 2026 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388034; cv=none; b=VdjEkEZ10lAGlBkz0bzYOlCSAW6g5R5qKR4oKT036KsDAn49R+0gUSEYGBapSwMSpQNon9gNpdlPxURjyORUmZvc60R94V1UIAmpW4Dt43nBMZ4YQMGr2Xjj+KsX7UyohI0XqeCTHDikxFXRDdv3acq56ZGcelZPFa+BiZdKlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388034; c=relaxed/simple;
	bh=0d8xSuy9EtCCct3oI8YtxPkmwyuYR3NZC/CFMAEvOMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXKYU3vLwNd7bOkmBUFeSMitgseMgOajOwDZXeCtPTzQn/vwyjNQaRoBO6vkLu2fI1jazPRQRyOfWq4u2IP1xVCPPrg7wxLmUkTbtU9rcQpoqw4TQNItpmuE/pnBcltB8roACGil+63TLO1HRydfNhGzfn2ILk4sBQClrkaKrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icdv1cKk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icdv1cKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786388033; x=1817924033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0d8xSuy9EtCCct3oI8YtxPkmwyuYR3NZC/CFMAEvOMQ=;
  b=icdv1cKkunjfBF8BdDJUkNAUIQYmB7wKCAdSL3I0VsODbn8MPaE5tffL
   jd0Wj8SO2tisQ/JCWFrxBKsZGw5xeKIVRyFdQH8cJjGw5EATUVS+Yd9zV
   iJ5PAEmUSiOcQMqAr9uRxtXv8Zif8t9Pnu0J4IZf8mmyVP3nOgHzVbvqS
   TC1citr4Xn6xFElWRY1lr/Q2jjyKbMroegMsX0NTgpWy5SVZtpNhDyN27
   ZxqJ1RdUkspnUDyjVXzLEV7dJzYXd5r40AtCTxKUCmOhMaqAKii71eEOC
   PuEIYLZvjcRFawxEj0El5HsKbIqPmQ/KzjKF1hgqP56VnuKIYh3VxFCc0
   g==;
X-CSE-ConnectionGUID: BTVy14sZS2yX/hyTjcV5iQ==
X-CSE-MsgGUID: KnzFUgigT6+k8aq5Bc4//Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="89438274"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="89438274"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:53:46 -0700
X-CSE-ConnectionGUID: c2a2dG9VSguK2ZpH5+96ug==
X-CSE-MsgGUID: 1+Sv9iAvS8ei27IIsyhWPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="259813342"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:53:44 -0700
Date: Mon, 10 Aug 2026 21:53:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Nicol=E1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id
 table
Message-ID: <anoeNZE05ozR62pv@ashevche-desk.local>
References: <20260810183337.451812-1-nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810183337.451812-1-nico.antinori.7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 03:32:31PM -0300, Nicolás Antinori wrote:
> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
> communication protocol and measurement conversions.
> 
> Add the "am2320" entry to the i2c_device_id table.

I haven't checked the datasheet, but code wise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


