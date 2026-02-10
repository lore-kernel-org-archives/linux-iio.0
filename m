Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8032E724;
	Tue, 10 Feb 2026 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753539; cv=none; b=ItCzaMqze9FBjy26ja6NYRCK/Kv9UPQHjmYEXetmdK0Kqnq2TvcT65KP4iOdYWVkQI1T0XwtnGG5lX1ggA5M4ePkYixO82sznUV5qafh1kOwFjx2Jvrf94IrHy907Co+MOhGoRipm2K5KPXR7bj3/L+eN2blFw1XubqgSioG5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753539; c=relaxed/simple;
	bh=WPFq6SllYyOYsUcQYAJyxioaRfS4N1Z6Tao8akvXjYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5bfbK32QyP1uO8dwJI2KoV8aTubJbEHVJriuZM0ogreBGy5NlPt11FlVflx81yBF7G24DApYsvav42xQoxeznFuLeNjk4N9CuhEW+b90nq97esDZEcayEPTl9K6Yu8zir86WDCoxjIx5kwdnO2uqOcb7zHvB7qDXMSjiwVF5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=df3fItbS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="df3fItbS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770753538; x=1802289538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WPFq6SllYyOYsUcQYAJyxioaRfS4N1Z6Tao8akvXjYw=;
  b=df3fItbS/a3TZ2e9y0LmOAaYKYISITZZYT0qMsG5n58tviE6FieSGX6r
   CHy4tH51aOBtSnjhIUlpihWBDBMwxl70r0liVhGKOrPEwdOYKIaRRSh7H
   BIBKGxdp7i6SnZjnXMP/+uGTqHKJgfKyeHmPV/TqODyNmKHsJwy2u2V/Y
   7j8KLFAdqnPNQLkuO+ZfoSmur0wbOryA7Nlp1GPVIUkM7CSMLk8GIVICh
   czLRvnXFHasmE53LGSIhE66FiJobp77rGaCQpxfMs7QBog39V94HtaGPc
   vg2spFGzm8CEm/ERckVRVZiROBEHJSPyrg2SgNYWB2KLoq27ypz6AlLFo
   A==;
X-CSE-ConnectionGUID: kMVer5G2RRWeWhvUve47Sg==
X-CSE-MsgGUID: Ly8hJnU0SSSsPuUPPkdv9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89306286"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89306286"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:58:57 -0800
X-CSE-ConnectionGUID: vP7EMDIvQzWCU+R0caLgbg==
X-CSE-MsgGUID: vvhhQq/XTYePZcdcU9FgbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211482835"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.131])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:58:55 -0800
Date: Tue, 10 Feb 2026 21:58:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 04/11] iio: amplifiers: ad8366: add local dev pointer
 to the probe function
Message-ID: <aYuN_Myx3FhmyQf0@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
 <20260210-iio-ad8366-update-v4-4-15505f7b15b4@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210-iio-ad8366-update-v4-4-15505f7b15b4@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 07:42:04PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Create local device pointer in the probe function to shorten lines,
> making the code easier to read.

Only a single place to convert?

-- 
With Best Regards,
Andy Shevchenko


