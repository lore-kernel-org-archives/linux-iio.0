Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA83D647C;
	Tue, 31 Mar 2026 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943863; cv=none; b=c4d1aVVMEoBgtSBS6cVQxs2UqLQ3PFVHKkrNwfb2/yVuophwzpjnUSzUrG7UlmFWLGOcwtgkjJeePZQaM1E9EGqeh8108eDLJcQ4YGs6cl8uw1IlKJPoVHS2UGPvc4UKvbhPHA6VgBkeRbKsGO74leALZVE3jzOm/TTeeyG63Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943863; c=relaxed/simple;
	bh=0ZXISeCfv+r08wPmcC8TSiPpL7ItPrgeIUd0PWuZ+/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM8NZKLFU4NAsMILBUjEY7Rj3Ry13C1EFO3Krvrt9Dg6IZhCnO2mCmE84/Wjw5z9Iyzw1WT8Xarf1FINzfTXhtl00QF7D0ZVdw6FYUn5i2346jfrvuVbdxXynVzQ7HxFHt3jZDC+ELABPLd60sFSkpslVtzcvbRT8IA9QrteAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPKy3wrp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPKy3wrp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774943861; x=1806479861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ZXISeCfv+r08wPmcC8TSiPpL7ItPrgeIUd0PWuZ+/c=;
  b=bPKy3wrpw+W/EErDfyTXiz1d4RdUIJZyFZeb5BrdY69+z/wdKWX5jAXh
   JWyw6lmcbu5ZTBGvnQaN+MfZYzWOy6LteVHeo4F5jyShYq3399mq1zPMl
   4ahd8uPgYE8AK76AR/aJwwubxM2u2/K5wNk8aJbAY2CXFgZDW/BPwH/ev
   3oQVM5PPAcdabKioLX3+aRB977EhhEQxbH1imHEHmyy/kiKgpLRTH56NV
   HFw0UKCsiKpZzgkyy9hthYexXvApZAzBiDluD8AZ5zXKuBlJsMiYRsD9f
   GxaTeKq6mlh+4Lx8iwqAmemBbeYvVW5k95hLKOOd+Kk5hPMAETR34lNWk
   Q==;
X-CSE-ConnectionGUID: q5BtLb66SVqrtEBkdC/tAQ==
X-CSE-MsgGUID: 6YUC1OeIRfKhBdgJVMM6kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75831694"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75831694"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:57:40 -0700
X-CSE-ConnectionGUID: /4RdLnLQTp29jqrenkIlFA==
X-CSE-MsgGUID: dh1IU7YeT/em6Q5n40x6lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="226172104"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:57:38 -0700
Date: Tue, 31 Mar 2026 10:57:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] staging: iio: adc: ad7816: code cleanups and
 modernization
Message-ID: <act-b6cm8JnXr9FG@ashevche-desk.local>
References: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 12:17:06AM +0600, Md. Mahmudul Hasan Mabud wrote:

Please, also put a small description of what is done in the series as a whole.
Nevertheless, this version is much better now, but some small tweaks are
required. I believe the next one will be good enough.

> Changes in v3:
> - Added missing Signed-off-by tags and detailed patch descriptions to
>   all commits as requested by the automated patch-bot.
> - No functional changes since v2.

-- 
With Best Regards,
Andy Shevchenko


