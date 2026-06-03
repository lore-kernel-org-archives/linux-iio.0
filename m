Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D5A2882BE;
	Wed,  3 Jun 2026 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448416; cv=none; b=S4ByteNABvu50g7DTGKysjf/w/K2raYWJypxk5lDBBpJL748A7E9/FBonYJJhP2fIQ4wNk7BfiP63MK94ihhSyxqDNkev63T1VdYhu9outcB3B/pbrQiWytz7/xAZUUB/LP/Qx7SMRnDzprIh6hVuUuJTwfet/bCWSPvmcedj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448416; c=relaxed/simple;
	bh=Msl437fSqt3OGTNaGZE8eBCAXiJrTo2rub/RL61wiO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElJLHfJv4w2QDdEgw+juyns4vhEDJ3QACd5yUf+4wy36SwvivwxlfkVgyKbL+0pewIOXsu2/9ZvPJPTUBmrsOCC/CHItraxnO8z13Lapii4Au29tb4pVoFOefK1SWUK6GY1rq7/NUTLwgqKuhK7MGJJHBNy6v6shw68ILsX1fzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgkoyi7N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgkoyi7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780448414; x=1811984414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Msl437fSqt3OGTNaGZE8eBCAXiJrTo2rub/RL61wiO4=;
  b=hgkoyi7NBv4KB8Q7G5ZUk/mcWVeYbwOwHWfC0xfxIkHMXcFhmzHJZvC/
   tBb6JEOMAE2hjY0MMzN4PZgXeme3uctyhGA7mXKPTQ/3zEHaY54OnmPAL
   W0AdUrGoD86DIe+yRH/ENniHAMmzRUQ3p42sSBBDnXa6JlCV7fJZ/e0hn
   MxopidGIZ4GjbFDA0Znyo3XxNMtcdj0uWqkf7NB5ocM5KNhvQ8v7ThVfp
   6/+il5KQcFVqLLN7sglL650KV25KNLLrrYc/WvjpyacX6iHomHSvAWhSH
   TXsuxWXuBN5Gu7GX/qI0UQHaHpCC9f/li/Llj/jIxgamcUEf7qjSgwEph
   Q==;
X-CSE-ConnectionGUID: i4l879p4QCuqxUGfFcPlvA==
X-CSE-MsgGUID: FIrNWpzVScWVhVwTSVW+xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="98811066"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="98811066"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:00:13 -0700
X-CSE-ConnectionGUID: i21d7zVqRd6H0JHIfw7x/Q==
X-CSE-MsgGUID: 1YVXYm2AR06PqeL3fk0D+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="249003799"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:00:12 -0700
Date: Wed, 3 Jun 2026 04:00:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: accel: mma8452: use local struct device
Message-ID: <ah98me7nmsXZ6iKW@ashevche-desk.local>
References: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
 <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-2-26d6dff8fc55@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-2-26d6dff8fc55@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 06:59:23PM +0530, Sanjay Chitroda wrote:

> Introduce a local struct device pointer derived from &client->dev.
> This avoids repeated &client->dev usage and improves readability.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


