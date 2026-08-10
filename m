Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007D1DE4E0;
	Mon, 10 Aug 2026 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392396; cv=none; b=CjRc4QgKneaNCcqf/tcftP9wFwm3qoCxwBv1N09YACn2z+N646zfsisu/wuAS9K5ViFy6pg/RMvh433lrJU6eYCirCXRwW8y1nbxz1hcLEg8S7M2HwW/jrfoGdLzjJJluhXf5LVQrDaZR5yks/IzGFaFA6kjrDyz6Om3ejlwviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392396; c=relaxed/simple;
	bh=EDg8+d/Wgrz2vd4bXMUEEOsm44AwfcqYT6C1OYwENNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtHlW/KGSLIr7gj5lqDbx4dDRdxg9HpwTTxyHZOmygnXZUtfqgZlyeFQ65jDCi1lbcv0+cf3rEK3s+wZLNRkLgD19upkr3UaU5vFOTMa3g4QqJCFohz53yvH87U6LrtNOtq09HHWddeicq2F1URzqGg6MVxccsr4+ov3k20XLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDeqaQgU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDeqaQgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786392394; x=1817928394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EDg8+d/Wgrz2vd4bXMUEEOsm44AwfcqYT6C1OYwENNg=;
  b=cDeqaQgUdVMu/DWlBtWf/dgfoLT2gQpjog+SBXRV+Uas7jE99AFLR/ZI
   jP1zS86GNlyeaFsqd7iw9yGatYSYEUM0USdDVJJ3ZWwLIJ+IXFevWfDUF
   jnQrKMuuVa2WOGfetk/RxWLs4wgSNSHNUDDqLw4mTKhmU/kdZDV3zAmU8
   dqk2EbrzvHmIHjgjRW17F4fX4BdT2aUlx9gGDfyzCsvHT0Yvj7cTNxz3x
   a8keLxgbmH8Bzq2LsaEqIJ5arkOIN54PzMWvMaXQWauS6bL8ZNn7HA6Y2
   cNG3iynyfR7s1bZip1JrkEO01tQLMhzFRHCgjpV3Ucb4vSWR5ZOqfPzwL
   g==;
X-CSE-ConnectionGUID: 0V664pPAQx+fkOi2jZmdQA==
X-CSE-MsgGUID: DxusBbsFTNaT1meJcasodw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86795945"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86795945"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 13:06:33 -0700
X-CSE-ConnectionGUID: i3/0IzfZRIqQQa7Pj0240A==
X-CSE-MsgGUID: ZaLqvLY8RYqDToKULZHnbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="287830215"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 13:06:30 -0700
Date: Mon, 10 Aug 2026 23:06:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
Message-ID: <anovRGxtsyJZ8cO9@ashevche-desk.local>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 10:53:07AM +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The BM1390 tries to initialize the AVE_NUM to 110b at the start-up. The
> field location is not taken into account, and value is written unsifted.
> This causes the AVE_NUM to be initialized to zero.
> 
> Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.

Can it be FIELD_PREP_CONST()?

-- 
With Best Regards,
Andy Shevchenko


