Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C731F2380;
	Tue,  2 Jun 2026 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392285; cv=none; b=oY44ZIa3qPmPE/U9QGCqySuIuXG8NTGQsQWMHah8xNmgU1yItHuJiX9wBo5MiiJQ08JyXfeE/ELnVU7qGimcvMIeAaw2CuhZNn6Hvj0NhHNNPJxJAGerpFbYustAtcZQyKm2CXt3skRd9KdypdbsShGYJen8naTL6F/XVa5GZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392285; c=relaxed/simple;
	bh=dmW9oDcU2mcbwI8dPNWwDJs8S3z5iYkuegCzVTuA9XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmlGOHWRHNfSDuyzkJkvNoz5/CPlYCfrFunFVDH2Dw+KfOgQa15qw4meBzxBr1gCRBj9SqMUlvH2vjUjgRsIotRwIqaiuqAZKo34YZILzHC+anOJIpXVX+9iAk7hC5N4veCzOd1LZkOgLMftC/TmKO5EWXN+fIbXdkjvdQUL9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAl4s+OV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAl4s+OV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780392283; x=1811928283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dmW9oDcU2mcbwI8dPNWwDJs8S3z5iYkuegCzVTuA9XQ=;
  b=PAl4s+OVLCBj4RZSoFY0+mKrBrvnoH6GLg1c4wKrNiUTel7BbLC2HT5X
   9Tx0Hky6Bm+ZJrhDnjUsuGZ+lI7beiaPMQoG6wHenQS5c8v0V9cYJKXhX
   Vj4iesIj6e1Qwk0zlIDeV0GHrywBtndGbVb5J1WQ0dmAXt9jXTx0hKp8s
   O+Ypq1Obnc2ul969wu6WriSxZiZBvQ7rzGeywLqhd/KVuA624kFBYmomO
   3o2DffZ9E3JNsc4SD6AHza1EZ3kE6tFqTZsrU0A/bG5YLZ8mwySvcxpUB
   bZwIrCm8AdxkwdWt0xGca9cfmibgyHJTnRUbAVCkT+PCXEm/l3INTGTvJ
   g==;
X-CSE-ConnectionGUID: 0HHDjnXjQn6P2QqLVvDvzw==
X-CSE-MsgGUID: qfj+q5HGSOOOeWzbznJUSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81072257"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81072257"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:24:42 -0700
X-CSE-ConnectionGUID: 77NfOhEcQD2SfDz3F9aTng==
X-CSE-MsgGUID: ngJI9wi+SQ6GlRwtWahacg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="248940582"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:24:38 -0700
Date: Tue, 2 Jun 2026 12:24:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 04/11] m68k: defconfig: update stmark2 defconfig
Message-ID: <ah6hVLn_OES-ql9j@ashevche-desk.local>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
 <20260531-wip-stmark2-dac-v4-4-7e65ab4215dd@baylibre.com>
 <20260531165155.13e586cd@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531165155.13e586cd@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 31, 2026 at 04:51:55PM +0100, Jonathan Cameron wrote:
> On Sun, 31 May 2026 17:25:57 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:

...

> > +CONFIG_MCF54415_DAC=y
> 
> Sashiko makes the reasonable point that this symbol doesn't exist yet.
> We don't care that much as they make different paths anyway but generally
> I'd make sure defconfig updates are after the symbols are added.
> 
> https://sashiko.dev/#/patchset/20260531-wip-stmark2-dac-v4-0-7e65ab4215dd%40baylibre.com

There is even Bugzilla report for dangling entries and the ongoing patch review
for adding this check to the `make` menu and some to checkpatch.pl.

TL;DR: This change has to be fixed accordingly.

-- 
With Best Regards,
Andy Shevchenko


