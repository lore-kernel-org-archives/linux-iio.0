Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517842;
	b=3WvuJIEzeeM0t5WzCU9P0dzuAsZBru1sbmkchJtLl3fvUDIssEcOiH/6fGVLcuz6+yAv
	 wNaZoIvKK6hTN537BpaCicrMitt5vV1qACMBJqF3PhVFbxT9RZE/YkhAE5dbKSWho/N/w
	 oABCwFc9em17+3tHEy80rISTNFBX+F0jskLvVBoObwy6l1gpJWStU4ZAbiSa5dg8o1bVA
	 MOqw0xRMQzv/xNG78ZgG0gcvF0p2BBaLZvWPqnHpnGBVG8wxgyVzjhWizmRyvhR2NeoWT
	 DxH2xHSQvQaxjhuhBVPmzdYTJkxHW/s3Eg6yyhYqRWE71zJuJGCvIJGMQEiScrFoq0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517842;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=P+PcCsm4vdxJHSzNKZZLeBWvXuD+SwiVLNGAujPZtS8=;
	b=ze+EhDQIsWxL4QL9LCKVkW6ExnCovGmY9YJLXRFUWYZZ+PY7AVAKN8SDRLaUmAh7QbDY
	 HbzkSgsvDF4LJObkNmJH8FG4U8UcXQupjFPHy8oj7++Z0hL+crx2NFSIZdqfe0iYt1GD3
	 GNBGIclfbfWL8CGlbxJxo/hGPWhOuELzZYCCbvUVH6u/lh4uagjOgMKHNhWbqVy6zKcDe
	 p+7Ed/vPuV71sZIkNJVHSRJV9i86PNYOHsZc9Nh/JydDuWsVWjuSOGdvaHq7+5W4U+piU
	 HjJ7CKv4QdnGa85xUdhxU9Db9XWo0vTbJkFWrWEpnqJggYFcfJMRiXaLMaks3qshHvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CNElQOQg;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4BD606A331;
	Tue, 24 Nov 2026 10:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA4BD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CNElQOQg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795517841; x=1827053841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IWUdh6wlCG1cIm2uLZBl4Op6usA9RcU9a8mRfnfZlxc=;
  b=CNElQOQg1S5JKpgqozx6LR1SgoXBrcrUvBnmcwUEu8kFjUtuI3w9paHY
   RLYCF6KjGQhyAb8+pCsdZOkRZiBy/CexacomLtW3erjqE3Ogl3n2HWUPd
   Fp5Oem2dB1Wmy2oBKrVum2LeVJ9GiHfl7Gyxrkn5ONLcXkU/HGeb5WjuZ
   DdqzgP/3MrQYLNU/BXiNtxUKPsBfWXyYDUMguNS3xg6Rb+Xgn8csUiEKy
   Eyb0qnyD4L1oS2J8ejynVxkiv3sR4zecDiA0EaU3E+mbnGN0ZEWBpG5Ho
   cWcHpMWEzFdjwAAPlr27PcfUUt2j9Hlq7JJJQWTFFCQFLrNdEtjXQe91x
   g==;
X-CSE-ConnectionGUID: /B51pEUVSZOVx0VUiNhq/w==
X-CSE-MsgGUID: ekzgqh8uQSWW/Av+Tt2Aaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4243746"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4243746"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:45:41 -0800
X-CSE-ConnectionGUID: L3TgT/dfRTOWYVaaU1eO1A==
X-CSE-MsgGUID: fZTIEnI4R86sg3+P4xOS2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="13525408"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:45:38 -0800
Date: Tue, 24 Nov 2026 11:45:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: debugfs register access through regmap in the
 core
Message-ID: <awVcvw3gtg3jNEgY@ashevche-desk.local>
References: <20261124065016.185124-1-zoone.rupert@gmail.com>
 <awVPu-reXnQHbr9y@ashevche-desk.local>
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
In-Reply-To: <awVPu-reXnQHbr9y@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 10:50:03AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 24, 2026 at 08:50:10AM +0200, Rupesh Majhi wrote:
> > More than 25 IIO drivers have a debugfs_reg_access callback that is
> > only a regmap_read() or regmap_write() on the regmap of the parent
> > device. Patch 1 adds a core helper for that, patches 2 to 5 use it in
> > four drivers and patch 6 adds register access to dps310 with it. The
> > other drivers can follow in batches if the helper is wanted.
> > 
> > The helper finds the regmap with dev_get_regmap() on the parent, so it
> > only fits drivers with one regmap there. Existing callbacks that take a
> > lock or claim direct mode around the access are left alone.
> 
> Nice! But I think we want a bit more to do to prepare for this change.
> I was triggered by regmap.h include in IIO core.
> 
> I can see the first patch in the series to split debugfs bits into
> industrialio-debugfs.c first, and then your first patch builds on
> top of that.

I just sent one separately, feel free to include into your v2.
20261124094502.557175-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko


