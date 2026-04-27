Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE93B3C07;
	Mon, 27 Apr 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297597; cv=none; b=LQaD30dAvw6jj96wZpGL+7T78WCmn7fh/gtBJp+qMaKFbcHPkJJsOYmgukWsvHaaNnzT69VRlHllzmAfTrCZqj5HmwCS3oN+xh9yYTAb97lq77fl0ot0b4a+5Mncg97WHoSgNXA3cswAdsPBYKNAijGPoxfO27IZLXw5GrKB8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297597; c=relaxed/simple;
	bh=1ipb/p9iLD9gJOjhfVD1WonzDTFlvZJr+EDMx6EGCeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzjKLirKxOSm4DYPFbUlHCYuzNJ4suDKFnSiK46r2UVrV1tnvP5czzS7oEb8QAraPxEUJBaH2vJMG+PkFR6Agb9dZVGvVeROnA6r0wFzUyfmXitIdGRtueTQYBdZ8hOgYUUZSQOQ3T6pOfXnpblWw2G3bIjoXkpFZIW31OV4NuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+4kMIUX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+4kMIUX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777297597; x=1808833597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ipb/p9iLD9gJOjhfVD1WonzDTFlvZJr+EDMx6EGCeQ=;
  b=K+4kMIUXmGB6gDCdLWH9vItrB+2gf0Br5LXD6XHk1Cno3qciYyKrJJXC
   E++Vbm10FJ17qgZQvojEPaZIK983bLUV9FbfHzgEYNxYKRut5nANkGFjv
   LeHL2A5H0ZKwnK3VssURLgm45KUGToNX79erhYgbjahxamV32RpvDHi1i
   QDB+RgYfkHcCxTAZ7CsniSnYlzfoQj5w3sbN45R9XflLEvjE9z9bqB2g+
   XMzZcdY1mJxPaIsJkuhfYWkbWHGqCF9APVPdrUY+44EWA0qMtXou+33oC
   LCNS19lrMUDTSklzduttDozpNAzq7HgOW4sbgKheA+EZ1M9N7hFYz/64s
   g==;
X-CSE-ConnectionGUID: 5Tdej0HgSS+CJ5ejia+rxA==
X-CSE-MsgGUID: QPVguWx5TYSsX4TFmxq/Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78372799"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78372799"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 06:46:36 -0700
X-CSE-ConnectionGUID: a4c9k3RjQJOZCXlam/oA4Q==
X-CSE-MsgGUID: i0G5xdLiQIeJcJwjpM0XhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="237607584"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 06:46:33 -0700
Date: Mon, 27 Apr 2026 16:46:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Piyush Patle <piyushpatle228@gmail.com>, ak@it-klinger.de,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iio: adc: hx711: update Kconfig, module
 description and file header
Message-ID: <ae9otn7HuPKVtzsk@ashevche-desk.local>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-4-piyushpatle228@gmail.com>
 <CALoEA-wAUpZ7_2_3kB33mNB_Y_DAc_p7QwPR9a5pxL1iET_cdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wAUpZ7_2_3kB33mNB_Y_DAc_p7QwPR9a5pxL1iET_cdw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 12:26:53PM +0200, Joshua Crofts wrote:
> On Mon, 27 Apr 2026 at 12:23, Piyush Patle <piyushpatle228@gmail.com> wrote:

...

> > +         which are used for bridge sensors such as weigh cells.
> 
> Typo here.

It's better if you point exactly what the typo is.
I think you meant "weigh" that should be "weight"?

-- 
With Best Regards,
Andy Shevchenko


