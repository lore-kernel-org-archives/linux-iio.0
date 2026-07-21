Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83948164C;
	Tue, 21 Jul 2026 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630611; cv=none; b=Kg1toC8eljG/6ws5j6bMPT5B/ExWHlgLfBVH6+RN7NLajkhlCemR+H+AvaywP3eH98kz8MtQSL2djApwgYVE2FPQTV7K0wjNTQv6MThFWMsuC4jzF0+Q/soLaxTlh1K7kS2dlVSmdEee0AWDV3A0vZU76PLQU6SrnJjKI5CGFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630611; c=relaxed/simple;
	bh=+pfLxMTfSupryZCGoxneUhjC/Ef3RLWm1x7q4UTU5rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsB6nqGEOK7Wcpg8gTY0OGGbAqi9wIDHeiUsFFgC0YuBHqCDPYKJMUI/OjyHwrCEphockhNyCZYVhF0C3viimZkPHsCcK1zKLOwHIdVZkThzRzYaOWjzAVL7OGQOqt//bRMS4fAWpoI6vtF8bmUKqayQLEfNOmDKdaCG7LoGtWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Waha2YLG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Waha2YLG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784630609; x=1816166609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+pfLxMTfSupryZCGoxneUhjC/Ef3RLWm1x7q4UTU5rc=;
  b=Waha2YLGw5r8jRrS/WakbOSH+CbbYoYAAFjlJEAmlnPm0XsXDx6s30CV
   OKuCfBWR9vie9CPiebZgIIPfH/rYCRUHdSeXi2IBx3Iaeqp+oC6ZZzLFX
   ZrBrOgZKv8+77lDDLl2/p9r41J5U+AZIo9nwvFKuviXz1dvgZDQUdOpQB
   NuFXbEBRfk98gjMWCOKNlN8NTpLU3g0VHagT30NPLZIv3gLTe2CRNyuPg
   7Z+IQpYQR67vpP1ESrmhsTc1qMyzW4PKNBbxBRSogzgmlx0WvtP9jhLv1
   ltHoOFrRLF7UZiKZOZJq2iHyaaDGrtxsOKde73D6xqRE29nV2IxCPTKX9
   Q==;
X-CSE-ConnectionGUID: c8py9VCQQm26+dLaKl9Pig==
X-CSE-MsgGUID: C784cRIYTiSyIyz47l0O1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95877973"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95877973"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:43:22 -0700
X-CSE-ConnectionGUID: bHPIIxLaRCaq20dytr226A==
X-CSE-MsgGUID: c+MU+j//TKmqUaS4kzJTAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="258371118"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:43:16 -0700
Date: Tue, 21 Jul 2026 13:43:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: linusw@kernel.org, mwalle@kernel.org, brgl@kernel.org,
	tychang@realtek.com, wbg@kernel.org,
	mathieu.dubois-briand@bootlin.com, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, jic23@kernel.org, andy@kernel.org,
	u.kleine-koenig@baylibre.com, dakr@kernel.org, bhelgaas@google.com,
	o-takashi@sakamocchi.jp, dlechner@baylibre.com,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org, cy.huang@realtek.com,
	james.tai@realtek.com
Subject: Re: [PATCH v6 4/8] gpio: regmap: Order kernel-doc descriptions with
 the actual appearance
Message-ID: <al9NQAR9ieKkBFIq@ashevche-desk.local>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-5-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721065802.689530-5-eleanor.lin@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 02:57:58PM +0800, Yu-Chun Lin wrote:

> Order kernel-doc descriptions with the actual appearance.

...

> + * @reg_mask_xlate:     (Optional) Translates base address and GPIO

This thous be tab (no need to resend just for this, perhaps Bart can tweak it).

> + *			offset to a register/bitmask pair. If not
> + *			given the default gpio_regmap_simple_xlate()
> + *			is used.

-- 
With Best Regards,
Andy Shevchenko


