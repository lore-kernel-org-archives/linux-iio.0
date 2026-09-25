Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD041CB2E;
	Fri, 25 Sep 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345849; cv=none; b=jD+A9Hpgw1PQoSFu6G7qcoiMGYGwZjLWsJYuzUPVKt3/5HxDtIArVV01gkPaqTecdhumVf/p2XkoO35VijjkDhpu7m3+jQeaer4exKR2q841LWXD/UMDCaEvVD1Nsp0iIXh3yjCb4oV4PwfqQx0uNA1eyhzWHstKOhLxkb4BCQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345849; c=relaxed/simple;
	bh=3gjbXGMXwE90b1nySzsIkaTNf6M5jLT1dtocPiPyz0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9jh7Ghz28JngL87ZgiMxyF50/KiCFUwU+0yUahg6/DBOdLS4jo0SKcRegL62Ex0xamL8KOVDutoHH0f4BsKGYePHwj1sEuBV2MQ46/PNmCQZW2c8ecwjaTkVpuVzj9dI+XBgAOY1Pnie5zqTzS/SIDO8b+0LYsy2TdYFEYpUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Io2YXslZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Io2YXslZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790345847; x=1821881847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3gjbXGMXwE90b1nySzsIkaTNf6M5jLT1dtocPiPyz0g=;
  b=Io2YXslZjwppu/lp8GLF1JjTFXALCPO4R3jhM1DIW5cTXVkfEjupcmNN
   jVYFG4/S5tXu0qUQf+aMXqKS6mj4Z573aOUeNxvGeWa5LWdJEPo0xvH+f
   PSQ55VaQWk+AHQGcVN0yHn+Ibkem++ZuOoebYA/LxVB31ohTF0SjM9znX
   mGdAbp0t8Zz/zY4SdxNKdSrjxIywBWDWYI74ClGcdV8o9ny45MW5B4p+z
   R2Xq6ttW8OQiXWIndj7jO5U4ntvzJZ540StF3ui4CEUk188qKEUNx7ECi
   aJBbPb0rQ1jClsFF8BK54iCLAW1ZRS4Hue4TtiY/q06CysloiHyh89Kv0
   w==;
X-CSE-ConnectionGUID: lSAwW37PT0yw66GKblfgUA==
X-CSE-MsgGUID: BkKPooARSUuplHlmEH0KZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101657768"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="101657768"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 07:17:26 -0700
X-CSE-ConnectionGUID: JyYcFE34QuKrLcxZSdqybw==
X-CSE-MsgGUID: NV70zMnKRoKq3HqOwx4amA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="300620359"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 07:17:22 -0700
Date: Fri, 25 Sep 2026 17:17:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk-1013: reject duplicate event disable
Message-ID: <araCbz928KEnAamY@ashevche-desk.local>
References: <20260925140945.2254656-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925140945.2254656-1-yaojiale02@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 10:09:43PM +0800, Jiale Yao wrote:
> The IIO core does not filter duplicate writes to the event enable
> attribute. kxcjk1013_write_event_config() already ignores repeated
> enable requests, but a repeated disable request still calls
> kxcjk1013_set_power_state(data, false), dropping a runtime PM reference
> that was not acquired for this request. This can underflow the runtime
> PM usage count and trigger a "Runtime PM usage count underflow" warning.
> 
> Return early when the requested state already matches ev_enable_state.

Sounds like a bug that needs to be fixed and hence Fixes tag to be applied.

-- 
With Best Regards,
Andy Shevchenko


