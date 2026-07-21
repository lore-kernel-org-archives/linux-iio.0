Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2EC33FE1F;
	Tue, 21 Jul 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631280; cv=none; b=ACckPYwn0X9SqeEeaw7qlbOEtCQrQhFEanE2KgZ6R1IBiSFD8g4gu4XK3OC8FgGBymv865mOhoYeGAE4RLTcFmWVzlCoLrG56hNfClEKZSNW4eRKe6tepPA8i3qpb6xqL50qC8RQDrUGALIozKz2a1Y+ZaKC9KsgDeB/xYWat58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631280; c=relaxed/simple;
	bh=MZynMZTfvxO8Uoj/jChzYOEbx7Ai7OIeRO+7A0pUC/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezzQtK/lDzY6UnpLxU4VC2ghzFxHF+FYeLKcnoSG8ckniWp4QPrcwtI6p1pIJj/tFJULB2qVk/A04ttKH4AegEpyXlFAtb8damw59I5a61yt9iVcLy+MVm4IsZ4fx4RGtE3SUietvXvyF7Tpf4CDOBE2vq9IqSQqMgTvOthql0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqWSnGWv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqWSnGWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784631279; x=1816167279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MZynMZTfvxO8Uoj/jChzYOEbx7Ai7OIeRO+7A0pUC/U=;
  b=kqWSnGWvcJbrCcazFgq1eZ0gl9E4JzYc8ac4vHaPiFd35x0DMgZuTZmh
   wdZfdDZl9qC5zUic8GTe+XzvUTyS3DHT55yQy3UduvNgC+Nr1JredFhS1
   CwuzHK/g+cpAUWerlRYbw0Dww0/PnFTZHW+AZVMRK+ihkJIVMlr0kJIwe
   n1xX34xK0DQTKx+vWQ6sEZR+JsdtFbZsDuWIq/OXcwwMwMiwRr1faDXFw
   9D7iCNsobdCLnohWFioREvqJxU6q9C7SL0Ioh5XSXhYAlI4jaGKsVX3R0
   0iruW5MKlqcJ0QUHM58Wc7WpL6GvFfXEd7o1soB59HivaRoRuK26IrYje
   w==;
X-CSE-ConnectionGUID: K0iZ4CKhSZq8FpoAcUEqQw==
X-CSE-MsgGUID: BZNEparOTR6g7HInmzAP4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85426804"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85426804"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:54:37 -0700
X-CSE-ConnectionGUID: kxlplzR3R9On6UgaXhOePg==
X-CSE-MsgGUID: Q3J6seuZTnmnJTNZxq1nUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="251404232"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:54:32 -0700
Date: Tue, 21 Jul 2026 13:54:30 +0300
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
Subject: Re: [PATCH v6 7/8] gpio: regmap: Add IRQ enable/disable helpers
Message-ID: <al9P5kNETuPCDKmM@ashevche-desk.local>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-8-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721065802.689530-8-eleanor.lin@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 02:58:01PM +0800, Yu-Chun Lin wrote:
> Add gpio_regmap_enable_irq() and gpio_regmap_disable_irq(). Since struct
> gpio_regmap is opaque, drivers cannot access the embedded gpio_chip directly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


