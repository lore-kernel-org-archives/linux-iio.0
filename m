Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16735374E6D;
	Mon, 11 May 2026 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484702; cv=none; b=pPnDHykTuRQuV6ztV2RdTjYrsL5OLqsVUSDwkgikuDYsQTMoQ49G0QqUpYzIXR849HpNcYLPBwQZbDpCzqm0ENHq0HgcUo7aveSyi1BksYFwdJeFe6VWxfpk7lw14pPWpYRc2esYj/UQQJmOAZqh87xs86c5CZOsnjsPivT7hoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484702; c=relaxed/simple;
	bh=mctZhXIq11nSQBRLq9WyWvPVvAR2BW6Hm6aqq7YmF9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfvUn+ovdlt/LLH/LUipPXOzD5bsV8Zvd1A4YI5/iiUWAoxJckgPrVxvMRXooOzZpxQ7zyqhRjF8UQRcNcDGsuoTOe/XQA+YSMU06jd4p51cliq+XqrCTpogibetp1nKVOjVuoL1qHH9drPIrej8J8DQJ7wfrePmkQ1I2ww+Hqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzwwT7J0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzwwT7J0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778484701; x=1810020701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mctZhXIq11nSQBRLq9WyWvPVvAR2BW6Hm6aqq7YmF9Y=;
  b=YzwwT7J0/jIVM8+Ddv1ekvR4CVcR7T7Cpk9yB7/Wig9AQvhkVfWEyBZr
   syMyWQtjTrGTeo/glWmBJ+7WXeyuieq/0/W3T2Moy9g2k6ZDVkJwC+8++
   NboBSjJH8fyDIAUle6rizLd/R/LIQC7PM9Mx3xvWfhwBktONWvYI1ffJG
   HT5Mdi/hzpqVtZ8UthfFXhSFzZCpoYpr2EZKmY5XPUR+LJguXYY3kBobK
   wv4P2yhdgR9d6nE3wBHFNpp0nfWho/xhSwtUgreFa0Vh7JpLFYMcOx81Q
   Zd5HODQcbdc5Kfm2uLE3P63nF7Dlfg74tIPg9xSEMI9Ks0+ql9q0yxub0
   w==;
X-CSE-ConnectionGUID: am5JJjaORdGaGoUksa1ebg==
X-CSE-MsgGUID: r8S7nzKMTye1ZyrdCll35w==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="104823884"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="104823884"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 00:31:41 -0700
X-CSE-ConnectionGUID: zwTGv2AdTGuWaKX95EPldA==
X-CSE-MsgGUID: h3X7tQhAT22ZD/IPIoJs3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="242344522"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 00:31:37 -0700
Date: Mon, 11 May 2026 10:31:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexandre Hamamdjian <azkali.limited@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1730: Add bh1730 light sensor driver
Message-ID: <agGF18FCMGmsE14r@ashevche-desk.local>
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
 <20260511-bh1730-v1-2-e0df1f499135@gmail.com>
 <agDMAiBUtXLamFHY@ashevche-desk.local>
 <agDMWcCYLCvX8vy_@ashevche-desk.local>
 <CAL5cOWuXAD7+rJEKB9FjnwdCjoUJK+WNKXZXt8tfnq1WLmv5eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL5cOWuXAD7+rJEKB9FjnwdCjoUJK+WNKXZXt8tfnq1WLmv5eg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 02:11:10AM +0700, Alexandre Hamamdjian wrote:

Please, do not top-post!

> Thank you Andy I will talk with Mr. CTCaer if he agrees to use his real
> name for this driver, as well as the others he wrote that I already
> submitted.

If not, you can use Originally-by tag.

> I am also taking note of your review and will soon test if using the common
> BH17 light sensor driver is better for our devices, I will follow up
> whenever possible.
> 
> Also awaiting for Mr. Vaittinen's review.

Yes, would be really nice to see Matti's review for this.

> On Mon, May 11, 2026, 1:20 AM Andy Shevchenko <andriy.shevchenko@intel.com>
> wrote:
> > On Sun, May 10, 2026 at 09:18:48PM +0300, Andy Shevchenko wrote:
> > > On Mon, May 11, 2026 at 01:09:50AM +0700, Alexandre Hamamdjian via B4
> > Relay wrote:

...

> > > Here I stop my review and recommend you first to review others' patches
> > and
> > > learn from other reviews. This will help you a lot with avoiding typical
> > > mistakes.
> > >
> > > Also Matti would be the best reviewer for this as he worked (still
> > works?)
> > > for ROHM and knows the HW a bit more than average kernel developer.
> >
> > Forgot to Cc Matti since I mentioned him. Now done.

-- 
With Best Regards,
Andy Shevchenko


