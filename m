Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943026;
	b=cPnd0l4dkBmBGWcTHYwQdIqD+kuA/cU/kWuNLW+GHzaeFbDEd09f+n7H8zJYMITa++33
	 HJrzEnBnGh8x47vPiOVMP79TWseVUpSTlTWREe2Fli2DDbYleFneXFJnxrc7hRVeIoxs8
	 AsS0KxQ2IQD+a6orrRkSE1zDUhn9SnOe2sq4fpCp+Ex/f/dmXri0mi5e47Sdzq+YGjpe7
	 +NsQ39TjGMaARQIDp2Bb5oqkO7Q71dVamqS4Kw9saadfbwQGQISztdEQLRT2HfgtXJcJd
	 clN5jG6jhavlJ7LnhTyTn1Ihwt+wnLoINyWzDDShH8wfbAO2wN8Ql2WgF/Wb7jNHGjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943026;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FYJEgbgWj1001DFbh2xaEfMnqumhuslKfSmLo2I8NaQ=;
	b=YyiqJIKGl/HeDGX/yr/QHvcNLO5W9Rz5VUTV6DxQB4ijEkwmLGDLTHYY8jjpqneZGw6Q
	 SYmYC/GMgbY4/9BoygB/F6KCFVa2zfzswguSck6ua5UyMav6nHR+q7r/GP/aDRNjKTPoe
	 D/aA55oe0WdCi7pqTmiMzsbIpf3iS7ldI0tIJABZnnZWGUmNtBeBGeR8mKvZJG8xfvHSV
	 0wZ7dxiJ2DZRfdPDOJyX7aab7tlBAfjV6xNyP+rMaH/2NueqzGCFS82w5UswwGGVoEC2s
	 RA5fk/IVRtCLmqCa3LP4il0g+6wmJRChKEPigF8WH3UjZS2XjKSypSJJWSQPNSggT/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SjYhkCMJ;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58395606A32A;
	Tue, 17 Nov 2026 19:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58395606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SjYhkCMJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794943026; x=1826479026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KOV0DBczU4q1DkAermQBydrpIkEwz8s9NSQiCDYutP4=;
  b=SjYhkCMJkGcW+iCNpMAr1fB5C0I/gqPu2xDcMNS3AjZzvpwmBpLmIuJk
   E2xVrsK7s/FswZbLdB/L0B8UPNJRug8vNpJKd3NCgeB2/QqZcHPUGFAUx
   FmfiG9zZLlbBeMOuUoZxWtzuUq8y5ZjkfS+ar98SbkjX1hn1pXZl6R/9D
   dGks0GqubFZ/N8EBzhEQLh4D88gZ4bGTbHeI/+APMgLV5hwLiFxwRxYia
   nYs7MKOyLaksSkyPeTJBs23ZdKuTQwRmPEIyrJununj83KUZd1zXmKfH7
   X6zQIW/mGwtfT/bBsqI40epr3tLS5SpjQCvui79eSLSUt1IlckV5iUs0W
   Q==;
X-CSE-ConnectionGUID: vQh0G24QSlKh6UVhn8JZPg==
X-CSE-MsgGUID: 5LyqOzCtTCKe0Y3ToHgmqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3763280"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3763280"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:17:06 -0800
X-CSE-ConnectionGUID: w7GccVdkREq1mQzn5e0yFg==
X-CSE-MsgGUID: 1bMSIU5TT3Cly5I4i3vbsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9887442"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:17:03 -0800
Date: Tue, 17 Nov 2026 21:17:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Daniel Campello <campello@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Semtech SX9xxx: add a reviewer entry and binding
 maintainer
Message-ID: <avyoLGkkCkxu11TA@ashevche-desk.local>
References: <20261117172612.25535-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261117172612.25535-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 10:56:07PM +0530, Arnav Kapoor wrote:
> Add a MAINTAINERS reviewer entry for the Semtech SX9310, SX9324, SX9360
> and SX9500 proximity drivers, and add myself to the maintainers of their
> DT bindings.
> 
> Jonathan agreed to a reviewer-only entry here:
> https://lore.kernel.org/all/20261117031830.69ac22f5@jic23-hlaptop/
> 
> Changes in v3:
> - Patch 2: replace the Link: tag and the reference to it with a
>   Suggested-by: tag (Andy)
> - Patch 2: drop the L: line, the IIO subsystem entry already provides
>   linux-iio for these files (Andy)

> - Patch 2: drop the DT binding F: lines, patch 1 already lists me in
>   the maintainers: field of the bindings (Andy)

I was expressing my opinion, it was not an AR, it was rather the start for
the discussion. I'm not DT maintainer, I don't know what the rules for the
maintainer records there, OTOH I don't know if DT parts belong to the
MAINTAINERS records that have only R: lines (and no M:).

You need to clarify all this before blindly doing something.
Also even for this patches, wait 24h hours before a respin.

-- 
With Best Regards,
Andy Shevchenko


