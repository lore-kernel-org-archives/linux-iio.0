Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172013A1A31;
	Tue, 24 Feb 2026 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945436; cv=none; b=iQ3uyRSUhDiy/TvCcYWTsyj4ZO0NlWCRnnA0WXEtqdKcf67RcSMRUp4RF8wgC/LJ4NP3b3RQmuA9Ltmvtl0X7I0ll5AklqNvjXefn1chAI90K/iOVFxwbsyBB3ypRP5nIjtyUhfQsU/LPSH0UdYC7CeI5SDIcfzRTmQCVX5s0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945436; c=relaxed/simple;
	bh=1E5rSUe435DvIDppa0Hj+M3PuK1u2lKAS9K/7pBZr0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhg6OgCQUTBlMyh2X0aleLzrMAZYwNFCGS8HBif7jsM6hQQYRmo/oAX+xiFJvADt9S9LnPoTTCyBHFg3IedPhjjf7HaxP/q0DAf0WW8GV3RhTghS7vd7EAKw9aEV+7ws++9z4uZ+tdUAXRLdH+IdcnlI5YKY9ON2q7Jlwspdxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUlMZEYs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUlMZEYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771945435; x=1803481435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1E5rSUe435DvIDppa0Hj+M3PuK1u2lKAS9K/7pBZr0c=;
  b=GUlMZEYs4TYE6oYtmP+lOr2k4IxytnoZJY2hJS2R0W9vu44C4aXw3112
   Baqtthx+Em0atV8mtGDHNsJQMP7H/n6uryaJa/RTXyMcL2FehPeKJLQEH
   3fooJOMxKolpKsrTACClDZfeJlKPapVqltxF435yTC8aOFqa9sHyFqiom
   rfcFIt0KtRaEBRSZvtQR5n6dVZAtimSwYko6o1VOXZyz/ui076UhDPOOx
   J8DLNvuXva9s649DXWjBBR9abOiYQrsFGK6lAhyU0ONMw8bZBwLnWotfk
   uqsWRT2KQ4ey7izIbciu4bOgAbPGJ5OanKmpDllf9tZTUi6jofLRwIn+5
   w==;
X-CSE-ConnectionGUID: XkZAz6qvTbO8Aeb7zhh6VQ==
X-CSE-MsgGUID: m5K1eilpT9GY52VaVWIbxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73027200"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="73027200"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:03:32 -0800
X-CSE-ConnectionGUID: B6UxMaV+SwCGvMhIwV6UUg==
X-CSE-MsgGUID: y7FGh8TWRMiq9iUosU9CaQ==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:03:28 -0800
Date: Tue, 24 Feb 2026 17:03:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	rdunlap@infradead.org, skhan@linuxfoundation.org,
	nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: accel: adxl345: Expose IIO_EV_INFO_VALUE for
 double tap
Message-ID: <aZ29vjil1d7NF5su@smile.fi.intel.com>
References: <20260224140351.27288-1-0rayn.dev@gmail.com>
 <20260224140351.27288-4-0rayn.dev@gmail.com>
 <aZ277iG58m-KGbI3@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ277iG58m-KGbI3@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 04:55:42PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 24, 2026 at 02:03:46PM +0000, Taha Ed-Dafili wrote:

Side note, in all your emails the Cc list has

	linux-kernel-mentees-archive@lists.linuxfoundation.org

whatever it means. This address is bouncing and should not be used.
(I removed from my reply as it reminded me again with tons of bounces.)

-- 
With Best Regards,
Andy Shevchenko


