Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F643E07C;
	Mon, 31 Aug 2026 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184773; cv=none; b=rhZfodsMMYre0L+OGO1I3iCka3/8Ck1EKTIMMOQqPd4vPH7cCc+Iru9lLrlHLYP4oeA1NPdJpXHoG+7gz6vDDd7ynv6SaeNMAVXFnKoD8MRdPw9RMAi0Lwp9H8pDoL/VruV3T11TWfVTDiWffXDSNlLiUxBAsEF70lDoMmlmsHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184773; c=relaxed/simple;
	bh=4ZeoEaLYXOt8H4FePk8xYu09EWkMM3dNk9qLMnZYMYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWvDz+yhQtbnBPRb5eOYJ9hD7+EV4cgaYLTCxoe91XNZ3B/QOSBGuS6IIhRoBbX4bHarL2pnGGHDOrUN1N0r5YM0Wk0e0PGlwwE4pVHpvJWm04JTA+q9JcNRGEHQedqbsZ78mwILZm9HltimNp50fQYq+xhjei4lheccyXRBCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeofZwI+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeofZwI+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788184772; x=1819720772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ZeoEaLYXOt8H4FePk8xYu09EWkMM3dNk9qLMnZYMYE=;
  b=AeofZwI+rHCgQ4Lj/90UnZBTUomRRRVZr20ZHG1xppaqZmacFSVdZkeS
   WGICVEWsXHssc5KmFnlExsbbiYfcqvTeicqionQ1Bx/eCjPpbSx2RF5Yg
   lXL6Z9sEhRjqWyOeH+fJ7gvGfeZPXUBoRxTQ/EpsMId/ya19CS123wbGs
   znkTCTbm8mkrVdo+OAapnfo/tRu3e5PmmdyxHf0nNhARpOv/iyZ30iqu9
   HGNOat1HoHR11q9zCM21Rpz5j26qDnGXlrB3TSXjL0sK0+2XCSaSIIto1
   J6OBGi+eW7EuLkQdoO/bdHT41q36Ph2zIdkAguC+mh3Xb7yGSnXmXmDUk
   Q==;
X-CSE-ConnectionGUID: JVSzLXWmReOuruk7Rxu8Nw==
X-CSE-MsgGUID: zLX4RLS1QEqMj6E+EI9gVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88615000"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88615000"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:59:31 -0700
X-CSE-ConnectionGUID: BwH+RoHVS/SNMyIHZc+5VA==
X-CSE-MsgGUID: tVnihXd9Shm0sUl6pKCftw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="267473443"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:59:26 -0700
Date: Mon, 31 Aug 2026 16:59:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	Christoph Muellner <christoph.muellner@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v7 8/8] iio: accel: mma8452: Use proper error code when
 missing device model
Message-ID: <apWIvB21H4Rifm78@ashevche-desk.local>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
 <20260831-mma8452-open-drain-v7-8-22946812c928@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-mma8452-open-drain-v7-8-22946812c928@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 02:17:11PM +0200, Esben Haabendal wrote:
> Switch -ENODEV error on i2c_get_match_data() failure to -ENODATA to
> satisfy the IIO coding style.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


