Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6B3B5F5D;
	Tue, 12 May 2026 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604477; cv=none; b=mWeRO9/Wn6pgl5hwGKU1D7Ca8uXpouF2CQV7mDrDlQe2hrr/dk+x166T0gy4ODBcorMuNB+yfP+I7RSniuY1aabp2Lj1BXacdiVo4ZypDl+yWGuOaEc7mfJ//RoEitOqL0BA9aWD771Ghdnrjw/EWMoU4K7cFMff4ty6/PmMZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604477; c=relaxed/simple;
	bh=Cjny3jK9t582i7n7dIZmi41zNTg92BOqNFFH2gtN0rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRZQb4oDp5H3jq3d3THwOhy57XuJFFE/HGJp6rnreQ47qw8W3N8jXpSZiyZx2LX+6Smu8gib1x0uvKjROb9YVpS3/7R5jcnXA9/Fxj82ssuI9A6CQ73Gr5YrORy8q3PNv4RiVIeF2f+11Nk9fIf5a27m6pOmg22Csi2ZQ3PY5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUBiS2Hq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUBiS2Hq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778604474; x=1810140474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cjny3jK9t582i7n7dIZmi41zNTg92BOqNFFH2gtN0rY=;
  b=WUBiS2HqM5H87IetJ+T08ul41HErYDYZGTDvP+mdcAZYslO5Ce4OdvJ0
   R/bDTUHaEey32FI1lIAwDa2D4Dojxb+16F/qYrbOvQjCFKnlToa1YNgWd
   vr0AG2D0ngKeHK9jzm9e0QoFyJN//Gzx0osY5mma29GYEfvCfpLbxH3WY
   XmE5rDMKxp14HSMX1Tb9JyJUrZpA1wRexKrFEXwGBDF1hEqO2SEuKVmo7
   7Rw2HtyzGC30SONCH5QK+qFdlEiczBbBZ3IaM0LGoN4L6JuR7USP0CypH
   3oL5NZ367tCdB6c9bq+eFjyFZ+Eze2oUlH8B6Befmpz49qcufFW7/CyAn
   Q==;
X-CSE-ConnectionGUID: QBCFqzxtR46PcuJEUmqJiA==
X-CSE-MsgGUID: HHrdIGVvSIK/uAyCi1tK0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79414466"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79414466"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:47:53 -0700
X-CSE-ConnectionGUID: 1gvq97oJQTmhnWNOARBQQw==
X-CSE-MsgGUID: bWX998q5Q5qDoDjnCVL4GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237739734"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:47:51 -0700
Date: Tue, 12 May 2026 19:47:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1] iio: light: acpi-als: Check ACPI_COMPANION() against
 NULL
Message-ID: <agNZtFQ8XP3MTO4i@ashevche-desk.local>
References: <2366919.iZASKD2KPV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2366919.iZASKD2KPV@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 06:28:26PM +0200, Rafael J. Wysocki wrote:

> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> acpi-als IIO driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


