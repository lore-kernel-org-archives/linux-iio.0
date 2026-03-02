Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00437702A;
	Mon,  2 Mar 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439315; cv=none; b=tUcMek1kBVbwyVdmyk4y7Oair80JnQqCmac89P3bav2Jnh9DVk42DnqNrK4juAW9KHOtqI+d+5I9A6ZbnVea6VcKDUPWtiH1EGAqaoCMoe4OhbqySDfRpvukf+fBAWYMDFR0nak1svLf0/BkQ11fdxcli8+ZTx9SFNvpyhDK45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439315; c=relaxed/simple;
	bh=ogf+dW0jgzU/ujSUsfgwYUpCCFyWfFNawVSWe/prOzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEf2rZowHI/UTyjxsERUkCRvYfNFxESDHvzM6yZKv0SLh+u5CKwDtgyrVuZXGe8OitrzkL2OCav4mA4KYSOlZlD1vJ1xGNdFkLPQ4dr1yero3M9sCqypCSvYK0ADBH3ysuAWmXu2WSq6qGh3Z9feqPGQ7ZU6VV2Vlo494RVK2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPAbS4j+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPAbS4j+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772439312; x=1803975312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogf+dW0jgzU/ujSUsfgwYUpCCFyWfFNawVSWe/prOzk=;
  b=XPAbS4j+tZUSF7qVfDW5IO9UppWeXCgN8lc26n+t8LsBwD1UyKj37zzl
   IgkZkgv2NVoE3J0Y/4EL/UnIyFyMco+I4pzwguRAhOq0fp5xOrV3dYPDw
   6rbkrP57i7SeCcVpL8Qf3PIAyWWrHgd6uX8SNX9nNmTgVZtVeqhXNVv6G
   Igj/zJ8SKki3MvQrSf9mp4LCDQWM1nJ/68Oh3wROHkAlp8Lck45NOTaaN
   dpKql4cbOS5bHEuk0BCwH5q7BSH7oAn0cS1+nFcrOvMFwfD2ejGeT+4Nm
   zXNI2LBSdPU6GU/hmjJBHcfN7BSjxz5Ht+JoJpVXdEfpacU3edC9dX/PK
   Q==;
X-CSE-ConnectionGUID: oepsYyDyS8+nHbBs2AvyCg==
X-CSE-MsgGUID: SFR066rgQMWh/vBVjekopg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="77280434"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="77280434"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:15:11 -0800
X-CSE-ConnectionGUID: 2sQLAYcKQFuyseDtrMXaBA==
X-CSE-MsgGUID: yjOca1ToSoSg3LLNgWelaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="248080058"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:15:09 -0800
Date: Mon, 2 Mar 2026 10:15:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: st_sensors: fix trigger allocation
Message-ID: <aaVHCueMg4fBtypt@ashevche-desk.local>
References: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 28, 2026 at 06:11:02PM +0100, Aleksandrs Vinarskis wrote:
> Current hardcoded name prevents adding multiple st-sensors devices
> on the same platform. Fix by aligning trigger name with other drivers.

...

> -	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
> -					     indio_dev->name);
> +	sdata->trig = devm_iio_trigger_alloc(parent, "%s-dev%d",
> +					     indio_dev->name,
> +					     iio_device_id(indio_dev));

I think you need to split this to more complex approach, id est:
- register the first one as with the current name
- use indexed variant for the rest

It will give something like %s-trigger, %s-trigger1 (if start from 0),
and so on. This way you won't break user space when it was defined for
a single trigger.

(Yes, I have read all emails in this thread as of time of replying to it.)

-- 
With Best Regards,
Andy Shevchenko


