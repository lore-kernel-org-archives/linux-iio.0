Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD14DF4B5;
	Tue, 13 Oct 2026 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921335; cv=none; b=k8rkAv48kwb0kd1K66m9B3ewatu5ZkCq42988809ZQCzcHHLkVHgHcgm9ZEsHMQl91tr5f5SBG0H4fjC51JhpBdwevgRtGE2+MlGFybY2oP94L5gAqcIq8fhZWjU0eqJSshU6jkXdTG1zjMTr/kXZW5BEFLFagz9jlsIjZDkvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921335; c=relaxed/simple;
	bh=AFu3kmZg6UCAO1SeqDGNz5eHNjjt8p6tQo13dqQuVco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTCBvAnROMA9w7O7rFGo4+NDSqJ3NRe580CxuloxAxBVfafcX0uUit6zpr17oq7r2hGuXm17KL8qY7AZy06BI8lqfBpAPs5OCm6E/vO4XAB0BGCS1eKnO6mOmYUZqyyBI89kWu0/6O3dxZgQBdJFtdJh0LL0s1DS9IbNdhUBaXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLG4QJTe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLG4QJTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791921333; x=1823457333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AFu3kmZg6UCAO1SeqDGNz5eHNjjt8p6tQo13dqQuVco=;
  b=VLG4QJTeg/CQBMCef6P+X4M6OtPnUfc2jpfweTxlZYnWcwZ2r3qmeqSL
   T0CoPun2WHjvnldxffIykF6+vlceyvbVXYmJCKCaDLqSfChM+mLlhJ/Od
   yeCAiUXt7OixiaHDC/rnHOljl7TLfmIWUMA41Siz7gjujjFPo56ZE5/ml
   BWSMDp2X3YAX9tu7TSHawWccSMw5eUj/ilyY63sQ54aWXQ0GmZlr97Kkn
   8pDii5Ons4h8B75zUBjxV+fn19BUm5NwS/EP3y1bYOwQK8+dtMQhW883I
   V8AbhsuZ2Jat+aDtUCRxI4+mHHIP3oLuyaU1nM1foPcQsvRQNVMRRWSL0
   A==;
X-CSE-ConnectionGUID: v5D3E7UKQBWrtHf5oOfIvw==
X-CSE-MsgGUID: xL9yJCx8QaSkC7z5xOXapA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="555339"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="555339"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:55:33 -0700
X-CSE-ConnectionGUID: 6+5gckZbTwaENTaTOG1p1A==
X-CSE-MsgGUID: Za4DN0zvRG63LuHy0DbE9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1277307"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:55:29 -0700
Date: Tue, 13 Oct 2026 22:55:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: common: cros_ec_sensors: use sensor_scale union
 member for CALIBSCALE
Message-ID: <as6Mr7BSbJeJRlBq@ashevche-desk.local>
References: <20261011045410.356156-1-kapoorarnav43@gmail.com>
 <20261011191641.4e9e2ac4@systembl0wer>
 <20261012211733.575305-1-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012211733.575305-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 02:47:30AM +0530, Arnav Kapoor wrote:
> On Sun, 11 Oct 2026 19:16:41 +0200, Joshua Crofts wrote:
> > Please add a Fixes tag. Otherwise looks good to me!
> >
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Thanks for the review. The mismatch was introduced when CALIBSCALE
> support was added:
> 
> Fixes: ed1f2e85da79 ("iio: cros_ec: Add calibscale for 3d MEMS")
> 
> Jonathan, could you pick this up when applying, or would you prefer a v2?

No need to resend, `b4` will scan the whole email thread for the tags.

-- 
With Best Regards,
Andy Shevchenko


