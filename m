Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E673CB55E;
	Mon, 12 Oct 2026 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840448; cv=none; b=EULBXxCU+EqferwibbuMCvh2ri0pf0HImLr3smAZA2YuMR68eIOQisd3eZfvUkNJYEazYlCKjgvGp48RLnbfcsr0yMmnl2fGBGeixWqEkQJaVhRAZNvkBufQziw25M2van7tDPHvrSCK4CITf66oJYvFoMpngOy98MtO5QaOhy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840448; c=relaxed/simple;
	bh=oeSC2qlhQvedVTlGtVaXxMIyAYpEvR3Z38T+wufwsno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/YZPtRbdRD1ZucW/OS5G9mqvC7C1Ia4xWuWlyjjOZsQ0lcyAnIqM1xfsT3JH6hSXoc/VVakdG/fwQoRxrwijx77iWjjXf2BjaqHeAFP7ER/UQWW65qLfsZiAAty5ivCogadNib9hKk0BmgtS/JV0hU3vQjOPx0v2Pp3HOn3bLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwzOYhwh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwzOYhwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791840447; x=1823376447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oeSC2qlhQvedVTlGtVaXxMIyAYpEvR3Z38T+wufwsno=;
  b=PwzOYhwh+R+k2e78QTxy6CSmKgVclsnSitCqyemMYe0ZETqqJn3CExIy
   RCYqyAURmCBZUWM6sCPZrcWJDAsYhzOMZrodfjKmN1Gsy4XBztrKYbSMJ
   HGL9M+fJRpZPeZX7wUym9zQLoLOM8G2zp2685vvhi0i5u/a/aoAt4enB0
   A4TzevmyNpMuK6tK4JmMaTM5pmIuFmALkOjwd8yXDVjOsVip/f53ILARP
   RCAUWj7enqLP6AhkyJiT1g9SIhJlW/CtosCkcMFpLXqZxbVHG+6MGM8sq
   3aTUFgqYd8biQf7WuoyB7TaV/4pgDw2CIvAXzblCKys5rarXOYfILv20v
   A==;
X-CSE-ConnectionGUID: X12oABbaTLOVpHulteHZgg==
X-CSE-MsgGUID: 7g+NzS88SPSouNEF60ehHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="441380"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="441380"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:27:21 -0700
X-CSE-ConnectionGUID: Ih2SfVXsRVq+Tk7DXmiFOQ==
X-CSE-MsgGUID: 740QfzMHTjeoi21wm1gxlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1108316"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:27:18 -0700
Date: Tue, 13 Oct 2026 00:27:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: raffaele.tranfaglia@gmail.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: addac: adt7316: use dev_err_probe() for
 ldac GPIO
Message-ID: <as1Qs5H5-SG3gik4@ashevche-desk.local>
References: <20261011-adt7316-dev-err-probe-v1-1-27a4a8ac74f3@gmail.com>
 <aszvaazebS2NISxS@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aszvaazebS2NISxS@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 03:35:30PM +0100, Nuno Sá wrote:
> On Sun, Oct 11, 2026 at 07:56:22PM +0100, Raffaele Tranfaglia via B4 Relay wrote:

> > Use dev_err_probe() when requesting the ldac GPIO fails. This
> > avoids logging an error when the GPIO controller is not ready yet
> > and the request returns -EPROBE_DEFER, and records the deferral
> > reason. It also simplifies the error path.

> Not sure what's Jonathan policy in here (or don't remember :)).
> Personally, I don't see much benefit on this kind of patches. I'm aware
> you might be eager to have something upstream but for staging I guess
> the real value is in having someone willing to really cleanup the driver
> so that we can take it out of staging (naturally that also means having
> HW or someone willing to test it).

This is a real fix for a (rare enough) problem. Without this it's possible
to get your dmesg flooded with the messages instead of the useful logs, so
I'm definitely in favour of taking it.

-- 
With Best Regards,
Andy Shevchenko


