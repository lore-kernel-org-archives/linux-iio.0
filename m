Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436704;
	b=tJYuNS8hcJAU9wpR6sAeEtLb4iMEhU5iWTmJOzjcUJDHCSIdE1yNHRH/RbOFyhsp9vNX
	 hXYtsIaFX3Wi8M0t64ul6828ImP45R3j28pmZpNpp4FFwEbJl+wY6yXIV54phrD5J7cLI
	 PM1nbn8unOJTrrMks12QXrm86RyISEdvRBym9p1iqp/aFmtcYbjAwiatlHtV2dLLKsEkV
	 hjK8AtVri7nAZBS3Wirp2uVw+CmPEtVIG52OIGNw8h1mYS3DgPeNpNPpMi/J2Z+VvEAvp
	 51q+PeVHaj3Bu3UfSvu3fX3Jw2crs2qQ0Qk/RzYq+5Q6Hs7v21gdvoWEmmYGTNVl+vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436704;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Oia3K4AHfSEsRzNJ8cTE47m0UQ5ty++Ukc5Cd7jXA8Q=;
	b=g0m8B4NYsG3sSvmjl22EC4LIyHSMrphCDgIpuqA5I7AS6PxXm+JU0KW7RyFLFqgBvBsX
	 vjsHeALoL1KbmpJsq7lmdhKXHKepSJeDFxvNiRfZFSEwxgzH3JVo/dRH1J0AfvWFb2dil
	 OZ0xqQSxbgNQrR8Hlfdq+/RoJQSoB+g3h7fBFKZfJ9IcyEWOBWPLhevs6goxqhQzyrbol
	 tOeB4eZBqkfIG/bmxkn5TDhmRTTpHKwAqNr77Nya1Cz60OMewJ+XjlpWc4pyo5DSNPC0+
	 Mqn789dWxhfqYoIzIFpFkOVAuZe75YS2497VBz/J9JS+xp0L7SbkdSeDvGKcQOOV7mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fRy4Tepd;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C6606A31A;
	Sat, 31 Oct 2026 08:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 790C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fRy4Tepd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793436702; x=1824972702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ks9bWYSJtuDY+8uGeFVP/3kU2BSZSz71I8dIOvJ1sZo=;
  b=fRy4TepdZ9LSZVNHhi1xRCpCmdV6xeSB6aDdGHZqMV0oBE8VJ+1FjR34
   Nw2lIsdxfhdGH5OYBOaAYttmSURJ4lPzZpXjY5VnfYVCQQm7covyu8nEB
   siH4sumUyfyO5C65CFtEyBWhHvPmZlT6himmqASf2ShpeVKV8i8Nsw0r1
   /+CFj6B0Ao3lxYrEmUF35vOh0RQqsqzUcoWdquQusxSjuWeMLfXcCQJGE
   2C7NgDcSOunbNsUkoa1nrtu3hjLwRY07LBE+PwR6NRjXDcQayUPc72hu9
   WP6vH969FG3aCUmH3pgxJvwdn+7MVdUxDM1vBsIInVabeJcN7iy/hVlF4
   A==;
X-CSE-ConnectionGUID: Xc15YvsATV+TBWqR1PozbQ==
X-CSE-MsgGUID: M8QoYODMSPmPj2M0c9pMfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2203882"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2203882"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 01:51:42 -0700
X-CSE-ConnectionGUID: ZH3TE4sMR3uPF3RQONTvpg==
X-CSE-MsgGUID: FZmIsDKQRxauXw6i7KvcFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5733511"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 01:51:39 -0700
Date: Sat, 31 Oct 2026 10:51:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nithishvelan M <mnithishvelan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH RESEND] staging: iio: frequency: ad9832: use
 devm_mutex_init()
Message-ID: <auWsGZtBMmLABsz_@ashevche-desk.local>
References: <20261031075814.34379-1-mnithishvelan@gmail.com>
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
In-Reply-To: <20261031075814.34379-1-mnithishvelan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 31, 2026 at 01:28:14PM +0530, Nithishvelan M wrote:
> Replace mutex_init() with devm_mutex_init() in ad9832_probe() and
> check its return value. The driver already uses devm_* helpers for
> its other resources and has no remove() callback, so this ensures
> the mutex is destroyed automatically on teardown when mutex
> debugging is enabled.
> 
> No functional change intended. Compile-tested only.
> 
> Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>
> ---
> Resending because the first mail carried the patch as an attachment
> instead of inline. No changes to the patch itself.

Same comment as per that variant.

-- 
With Best Regards,
Andy Shevchenko


