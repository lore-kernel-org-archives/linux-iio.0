Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89EE347BD4;
	Wed,  6 May 2026 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050450; cv=none; b=A+8MFp9ct+33LIfqUSXbEZ7w2eMAcYNbkCtwx6CXSKYLhGIdvI6rjWyPL/7BnOoMyl4xwh96Myhfm3qyuugt3DtvHhTVudDVwne3Jo1N4w79D5+sAU104/2z23VRip43QW1MCKD1eSfkPP3sQuhTVBNfCcDwOkGy+PZvHQDVMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050450; c=relaxed/simple;
	bh=DDFPKwfw8VcktZ51Az3jqFY7gPf5r0Eva8XGQ4tdFzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaStbHDhlRevVKMEsdDUwukbxCRcwwGs9GvhVgzkLprmUpadiDfLCvijc5swzfmb74MoZ28qGY0ahe8qPseB8MXrU9KQh0fljtqmyJLbRB2DWlXh7igRr0qBNDehn8D0G9ZkXj4s6K3Z4/JJ7ddxw02IT1pxlR2q0Oz7Jq5Qh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHRoQPvQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHRoQPvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778050449; x=1809586449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DDFPKwfw8VcktZ51Az3jqFY7gPf5r0Eva8XGQ4tdFzY=;
  b=aHRoQPvQrrVx0DkEsk+EKrpKOEuGsZWtXYg7M8MQYRq9H8iERBzhmhfN
   hGZBFA2gs9ujDj0UL6/oXRaLdNjRR7my/cUJcXZpzQ9TcOFgyWDCmVETP
   IUuTjLwZoGHy/19gKo/5siTN4HxPnLV9C5caRP1CsVGhXqmbExKpVqwsE
   ZuWzgsrX+w41IYHufOW5y0e74TqC+QE11hh4/Pn6J6rqHuDj4hDzNzz7p
   f5MMItobrvytwDPRy7rQzIcA2J3HpM6JrUboj1Odjsxeu4qH8kr93+Jlc
   UGEV1321yZcTmPEllNng2g6bt7zISljHORNXG+JI918fLJoUI6I/BnJdF
   Q==;
X-CSE-ConnectionGUID: rfW2GD7PS32V8nmx5UbcxA==
X-CSE-MsgGUID: Lrzd4Nn6Qdmw7jUm5zKLOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78814132"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78814132"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:53:53 -0700
X-CSE-ConnectionGUID: CO2bLf2URVuLa0FjGAwOHw==
X-CSE-MsgGUID: cenRlgDIScW3BdTOrezCWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="240370903"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:53:50 -0700
Date: Wed, 6 May 2026 09:53:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
Message-ID: <afrlfIZFHVQeOZWr@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 01:46:04PM +0200, Joshua Crofts via B4 Relay wrote:

> Add a check that ensures that valid data has been read from GPIOD. If
> not, log an error and return the negative read value.

...

See the comment on the previous patch, applies to here as well
(to some extent).

-- 
With Best Regards,
Andy Shevchenko


