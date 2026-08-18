Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5053B8407;
	Tue, 18 Aug 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041990; cv=none; b=sgtXqEJym3z8oDnZuoRgh2s0tBx1rBlTFe4v3X3JsBaeo9fMbUTrNNDOcoz26gfWiFbkC4ce/t4lyYKkVJc1FjnTIA61jhD6LmElnuPq4ILyVHpvYFLPkP9+yVSlaqIR9PnZzh4oLha0NNkP7XSISI3L6Gy2zJ/AIlXtVT5Gn6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041990; c=relaxed/simple;
	bh=XPEbWap0oVR7Y4vc6jobs3LnzyNKVduFtizSUnop1k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0n4CH8G2EkkGuAUYcfrJYTMxz358UK8Uca+SE/S7PmDFPlSZO5P75InMOd2TwmcbrhuQMrhQkhUX1h2K8Tg3M3fIunbjauegYcnoH5F67K9tm+8eY9Vz4cotzuEoax+8lCSrcN4mkgj/11F3d5j/LL76/7I6zQFxyyHwUx33/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHMXph4j; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHMXph4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787041989; x=1818577989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XPEbWap0oVR7Y4vc6jobs3LnzyNKVduFtizSUnop1k0=;
  b=fHMXph4j52RX8nB7UOT7nxtBGjqpnwKEhYojntdLYDAbh3ooeYcdKgsG
   tvaSAyVwecxjqEKJkfizvdNI54Gj18wZrkKXZ5Pa4g0EY4w9FQMXhOuNu
   6NQtSviI8ppys93v8KBGwDeCFkvRwdza9II/ehnK3RuQE4QZdowZcG/Rw
   F6LUq5NjEOU4rwAhY245Bh8a7jwvYIbWy2vLNu4a3+UiPIAWzXqgZ8wwP
   szTHRIEi7i77gEA/yv/33nmZC3VC9QT6T9HY3NNWhToo0TbHGSEU28ZXX
   5apw9cuY+V80xYGP89aV8Jsb74hF7arJvyBL8SAC7b9arpprtCO9QRSBg
   Q==;
X-CSE-ConnectionGUID: y+RP4d2gS3KY/IaZlDSvaQ==
X-CSE-MsgGUID: dyj2PbmLRBmgMKxVN0Cy9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91397728"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91397728"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:33:08 -0700
X-CSE-ConnectionGUID: PiXHqqYyT3GIuZqOvEnxcg==
X-CSE-MsgGUID: rlID4nelQlKAJ1CABWxnag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261877057"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:33:04 -0700
Date: Tue, 18 Aug 2026 11:33:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, nuno.sa@analog.com,
	robh@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v4 6/6] iio: dac: ad5504: support scale via
 output-range-microvolt property
Message-ID: <aoQYvbzXtp7FEPNo@ashevche-desk.local>
References: <aoP8DQitMiLOSOor@ashevche-desk.local>
 <20260818082347.13382-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818082347.13382-1-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 04:23:47AM -0400, Taha Ed-Dafili wrote:
> On Mon, Aug 18, 2026 at 06:30:00AM +0300, Andy Shevchenko wrote:

...

> > So, the change from 1000 to MILLI is in the line that is changed
> > again in this patch. So, no need to change it earlier. And again, it
> > should be (MICRO / MILLI).
> 
> I started the code with a bare / 1000, then replaced it with MILLI
> thinking it was the more readable form. I wasn't aware of the
> (MICRO / MILLI) idiom for expressing unit conversions explicitly.
> Will fix in v5 and drop the intermediate change from patch 5.

Since you want to get a millivolts from microvolts the 1000 is semantically
(MICRO / MILLI).

-- 
With Best Regards,
Andy Shevchenko


