Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0717D6;
	Fri, 24 Apr 2026 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777025914; cv=none; b=oSGMyVWWGEX5EwHQezZWNdLH1GPHoONVcXQjjj0RlV2V0mK0p4rOh00mhSXbAC1gFGpjmVLB08loq6ps24yoqyXIIqjJhzjwP2k+95sKKgbe1r7dR+yns0AHSSlNwNcHobTEHNBY4s9wjgbhf1KuBlHZ8uROrF9hbO8GU/MmxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777025914; c=relaxed/simple;
	bh=9JUjUIfqAJbct2VjyC7CxvADQaNf4SQyWeJ05L2yB0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjXYxN/w7pDfCyxPNuWVapVwlVdrt7EVm2XG9bjHDYKgEoL5dTcUEldDBWOJmXClkylKJ0feZY+IRI/v8Yx4pfrlJ5aXvjklBa+yYK//DFEvSrZIjptoEzjaj7uJg3/hXQBxKoml3SGiSKwmTMNiiNr6p3iW5MKLmk7Ey1reTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyWGQVn+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyWGQVn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777025913; x=1808561913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9JUjUIfqAJbct2VjyC7CxvADQaNf4SQyWeJ05L2yB0w=;
  b=EyWGQVn+XQ+sb92UGBDPQZAYXi8cIseg1p6sAX82ilR7qz4WIXcIWTau
   AGAHRrvvDU4vj64HyyRQsavCPHSlk0undC2akguqWwRb2pzAe62FqlIK2
   y7GstJLl7JjiZnTlt2EYMIgS06C2sOsYQ3iuZL4pbf5kt1yY4XEpKI0o2
   LzuUuLwvqZr/IvDV8MLTljqAIeMUYmE+oyipLRQoNo9UHYmfO4GPNqraf
   IE/yTO55/XmLVssXU8OazWdHatagKXdHF6VmNv+X8b8sZxGKRRHCMsCuD
   yZuT8kSDtlaCUlQLOWJfVgNE1T0VvMqUIG/8ufND/3jfvoCYYEMSq0hX3
   A==;
X-CSE-ConnectionGUID: uOFHzYlFTTG/g3Gg9hsP5w==
X-CSE-MsgGUID: FyWUNLbUSEiBwYZEBV6scw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78119923"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="78119923"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 03:18:32 -0700
X-CSE-ConnectionGUID: P83RPMXAQke6EFqBCn378A==
X-CSE-MsgGUID: 53H/aHGjTFWjSX3exFjg8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="263316491"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 03:18:30 -0700
Date: Fri, 24 Apr 2026 13:18:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio: magnetometer: ak8975: modernize and cleanup
 driver
Message-ID: <aetDc7Cvb-_qkf3s@ashevche-desk.local>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
 <aejKKKD4JdxIzlk0@ashevche-desk.local>
 <CALoEA-w=N7ch67R+DgdqCrSy+5GtbuGkiAbJtnf-9c=Q2Mb6CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-w=N7ch67R+DgdqCrSy+5GtbuGkiAbJtnf-9c=Q2Mb6CQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 10:23:31AM +0200, Joshua Crofts wrote:
> On Wed, 22 Apr 2026 at 15:16, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > 5 out of 6 are good, one needs a bit more as it's a new patch in this version.
> > Also, wait a bit I'll send a couple more that you may incorporate in your
> > series. Btw, are you familiar with `b4` tool? If not, good time to start
> > playing with it.
> 
> Just checking in on this, since I haven't seen any changes on lore.

Sorry for the delay (if you want to help, start reviewing others' patches in
IIO mailing list, you also learn from that). Now when I got my email pipeline
clean, I am about to start doing what's been promised.

> Btw, b4 really does save *a lot* of time.

-- 
With Best Regards,
Andy Shevchenko


