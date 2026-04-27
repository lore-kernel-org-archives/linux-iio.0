Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BC39A7E9;
	Mon, 27 Apr 2026 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278034; cv=none; b=PxSQFAvadG+lqGLWv5EGTZiOivH6/RkgVfY+49twAcjz7yR/Iw/WxYgMZ94XmVEIOa26kzEGxwhgzf+1jbyJgg/ZelvXnDdF9w4nHY2l2q2Yr3zB9MG5/B4GM+stnFMfc1r6nU6rSxaVD/41CjhIzSuA9lE5HD7P72ZvcgyGoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278034; c=relaxed/simple;
	bh=/oAFqwf/HAg51TUdzsCqlLKn7Z09U8+kjiXSBQiDZBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILfHQjnyNJko5Jc1bWxIOifp4yUY1eo57Z2QIhYBgiyFDolJg7Z0Zadio1VVRkWnjRu5wVW+TZ0m5KaSF0a8w8qH7VtvaOeQVBM7zbM6i+hiT/aG8QV0SCqoq1pdz+7bNMG5L07Yxkt4BI65MCddizGtmZN1sk39KzkaDEffmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VolhC2Pq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VolhC2Pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777278034; x=1808814034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/oAFqwf/HAg51TUdzsCqlLKn7Z09U8+kjiXSBQiDZBM=;
  b=VolhC2Pqc2h6fu8Q3vyLyWowI/W6PfjUCuJXeel/qh+DOHxBYbcZed2A
   A7fjQzpnJkLJtT0QEKzI0PbR8HYPhvA5RB3TxO2b2sCotzMm94F24bJBf
   4DwfaMlZbLV4xk+i/cc7ck3ZzpyOrzp8CtlGdhKbWrklN8XF+cLVma4jQ
   pq+cIp/fNCN7XBhHWT+4PbOdMBsZPPO7g0zWemPRxCBsYy3mBDED2gevD
   qlGoKPpiTLBzBdnFjC53+iUSz47iyTNFu6sD0khBZm3eBYdwxX0euwCNy
   l7BAwbP41y+rCweVFnbnQC6QV6qG8rPNePvDs7ShdBfHAc6iw0zdUf69e
   A==;
X-CSE-ConnectionGUID: 4hvYJBZZRcKjTkJnKgj3+w==
X-CSE-MsgGUID: iFm3egAnTUG7nk1hhFmE8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78075893"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78075893"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:20:30 -0700
X-CSE-ConnectionGUID: QQsyEszxTC6kTb+nhqYQrg==
X-CSE-MsgGUID: FFHYqZDlRvSUyX9p18Bm2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="233844294"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:20:28 -0700
Date: Mon, 27 Apr 2026 11:20:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
	christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/9] iio: ssp_sensors: Use dev_err_probe
Message-ID: <ae8cSEia_x7sZ-P5@ashevche-desk.local>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
 <20260426091710.3722035-9-sanjayembedded@gmail.com>
 <20260426152451.7163c0d4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426152451.7163c0d4@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 03:24:51PM +0100, Jonathan Cameron wrote:
> On Sun, 26 Apr 2026 14:47:09 +0530
> Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

...

> > -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> > -				   sensorhub_sensor_devs,
> > +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, sensorhub_sensor_devs,
> 
> Unrelated change. Should not be in this patch.
> 
> >  				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
> > -	if (ret < 0) {
> > -		dev_err(dev, "mfd add devices fail\n");
> > -		return ret;
> > -	}
> > +
> 
> Normal to not have a blank line between call and error check, so why one here?
> 
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "mfd add devices fail\n");
> >  

Ah, just replied with very same comments!

-- 
With Best Regards,
Andy Shevchenko


