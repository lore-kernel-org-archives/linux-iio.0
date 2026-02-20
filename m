Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A94C97;
	Fri, 20 Feb 2026 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771572161; cv=none; b=jQZ/dzMsQmlxvbhVRIgDzruzzJ57K1XpdXmWlG0HCMcxSdqiMXBXV6CFFl12N7BdRaN20hK70BlxnihlyVQlY1IWPAPtmqL/aw8RixzaWOdmd/0PiwHXt0NaH7K+baMQfL1B8nFvCSV3eH4GD2u/PzwnS73A50Q14+KY6a83kIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771572161; c=relaxed/simple;
	bh=8UzCEGHZ8iaHLF66WyyIG1Siu9lRz3cm2vCnVeVsuBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az3IDRRsAcn/t8OFe0Jlj4zlrgXbafvsKw7E2eXXuHxL7cLjouYfcjah4O772ADC8eK5c25ppmishzM77nYgUakTd6SmniA3dY2S/OwbqZnLmwc92s+xUrcSJkGAf7hamDv6UomRUtFUPQlFusyNKWXsInznjS3M8x9Hl8yA5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eu9uuB3F; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eu9uuB3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771572161; x=1803108161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8UzCEGHZ8iaHLF66WyyIG1Siu9lRz3cm2vCnVeVsuBw=;
  b=eu9uuB3F6xTnN/vAblU9taUSIyh+ZCL//6ye4MN/BW67h5WwxW2z+NBY
   E5SmYEjML7jfWnAdM88nr5pSpoJginl0ZcxMgC478B0XT+z/nKn94N8gA
   iTqjKulFZhYOs5u5Gk3EjbYOpJZcL63I5ovHhdk4SV3RT+l8qxvSnr8rW
   T4zXyzgDb0gq4iuZu4Xui6dmCHZXhLZJUN3NXzDirKGgMCMV1g7W1MpHO
   kKm+RiWsfr3quhKJOhMB1lqf2D6XlwW9EMXOIWkCiaIplb6VplSryGMEe
   qPOtkxhCaen+l9kbuuI40fMB/HdVxK1NpTIrrKqmw+IIfEg+p2iuVUs5g
   Q==;
X-CSE-ConnectionGUID: AhIpAecrTzKikBaU3z+RhQ==
X-CSE-MsgGUID: C3+HEOnvRxmVL2vwRix1qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="95286218"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="95286218"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:22:40 -0800
X-CSE-ConnectionGUID: ndZNxDucTei3/JWgyhsAJQ==
X-CSE-MsgGUID: oERVx9j0Toq1UxemNSrofQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="212926113"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:22:37 -0800
Date: Fri, 20 Feb 2026 09:22:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: bhargav <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: frequency: ad9523: fix checkpatch warnings
Message-ID: <aZgLutMih65WdesN@smile.fi.intel.com>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
 <20260219213549.59645-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219213549.59645-1-rougueprince47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 03:05:46AM +0530, bhargav wrote:
> Changes in v3:
> -Patch 1: updated macros to use '(x)' instead of 'x'.
> -Patch 2: collected reviewed-by (no code changes).
> -Patch 3: fixed vertical spacing and broken indentation.
> 
> These patches address several checkpatch warnings in the ad9523 driver.

Do a new email thread for each new version of the series.
Do not send a new version more often than a couple of days.
(The very bare minimum is 24h.)


-- 
With Best Regards,
Andy Shevchenko


