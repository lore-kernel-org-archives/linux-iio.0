Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134D39FCC6;
	Thu, 26 Mar 2026 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549508; cv=none; b=oFL/YLUT0KAci/O0tE+6GxyaBGmNOS8kVsJBkYDcOW1OxYpzsv/oS1D02ALpiOD7eO27fxUHlAGB5Uu/zztaWA3KebQ+UTUBF9Pb4eq/hDp2Kvvmu4FFGADFffq8ZGuwwFp2LJFXXv7cfGAC+Z0FuXDaX3mbTaA7WJ9OqDnzaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549508; c=relaxed/simple;
	bh=Pbzsb8SVxCcw6tkDUDPIXM8P9aUDWuKvyk+NUid+ElU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbES4ybRvtT/BQOd708xtF5P/7XLkUGvH0LMhFx+kyYDsrcdZflvhSr3hY7PptZuDXWG0VNnG1qgejZY7lSuWcV/ytwct3F4Bz7qxyKeGMwG/LHxLaJSjZpE/1B3D+cW4RHNNm+hIw+2NxC5G29tjKtb5lk4it+TYtCEeeE7U2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muVRP6y7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muVRP6y7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774549507; x=1806085507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pbzsb8SVxCcw6tkDUDPIXM8P9aUDWuKvyk+NUid+ElU=;
  b=muVRP6y77ZaMnpQrc19Lwu5za+p99pwMYShivIA6dRMtqWfzldB1hKJS
   Z4omg6yI3qEu0j2fUmqYxG7OgAmUohrz1o6/drj0EOzVzknXQqo2TOt8/
   Tkw4LReIvOfhfXQ4/HtLmCL07HofklZc+HU0SF3VbOqjnReo28rn4BsaJ
   Lsgh5yZ9NMb3Orum5evyDq77VIXimQHRMmDFI3oHjmKSD+5tp6T1MuhQm
   VZw5EunU1/JE9tYQ7xOKapZ2wwRHwf1c9jgEI/uYziCd6s6Sn0GFQT4M7
   OPuII0erdi3gAAr5GtI4jtNlDDBj0H9rueygDQDkDTt10UCQnG9W9qDdE
   g==;
X-CSE-ConnectionGUID: 4fH/gkLxTNygWQIg6zgFSA==
X-CSE-MsgGUID: Fs7MPLDyS6ibrjIizWF/yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75816981"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75816981"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 11:25:06 -0700
X-CSE-ConnectionGUID: Hnc+D/PaRVyk70Nm9Vy33Q==
X-CSE-MsgGUID: fkOPNCqFTOif2rV1d4ncyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="224141338"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 11:25:04 -0700
Date: Thu, 26 Mar 2026 20:25:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina2xx) drop unused platform data
Message-ID: <acV5_YSGKtlTa4hP@ashevche-desk.local>
References: <20260326-drop-ina2xx-pdata-v1-1-c159437bb2df@oss.qualcomm.com>
 <acUJGHrJvWgqHxPw@ashevche-desk.local>
 <b692b3db-75f2-43d0-8b2e-c5a89b8ff5ca@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b692b3db-75f2-43d0-8b2e-c5a89b8ff5ca@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 07:12:16AM -0700, Guenter Roeck wrote:
> On Thu, Mar 26, 2026 at 12:23:20PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 26, 2026 at 10:30:00AM +0100, Bartosz Golaszewski wrote:
> > > Nobody defines struct ina2xx_platform_data. Remove platform data support
> > > from the drivers which still have it (it's effectively dead code) and
> > > remove the header.
> > 
> > Would be nice to see a follow up to convert to use device properties.
> > But again, I already asked this Q: why do we have two drivers for the
> > same part? (Probably not to you, Bart)
> 
> Because the person introducing the iio driver claimed that they needed
> the iio ABI and were unwilling to create a generic hwmon->iio bridge.

Okay, but why did we allow that? I fell uncomfortable to bear two drivers
of the same when the whole idea of the kernel is reduce duplication. Yes,
I know that there are more cross-subsystem examples that we have IIO vs.
other subsystem cases (usually in drivers/input), but I believe it was
historical and for new devices I would like to have a stricter rules. IIO
hwmon bridge is exactly for that and if it lacks something we rather should
discuss improving that instead of duplications.

-- 
With Best Regards,
Andy Shevchenko


