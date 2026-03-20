Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E934DB54;
	Fri, 20 Mar 2026 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035309; cv=none; b=YYPp5C4auH2jnOkxcvy6FDdt75ZvQh123p7JD+TdfrUQa8GvHanoj6ItjuP1F7dqRVg+tjqbc+d6VeEh9vsoEd5fo6ML56PJU3PPCE7fFDyFszUMha4ekkhIfNtW9v9UfWSL89KlLz8dWKOnmHcnKOhtLovLByha1Idvn8IxLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035309; c=relaxed/simple;
	bh=8YBTIlU5Zz2RAIVhWK5asqXzaMSXnEP+4TOZRUxC4zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMh6JnS4IXU4q1noEaN+rp+DlZYU8oeyQDcuP+2gY7y07cr6QjU+f0jJ6bXFhXv6MQoZ+er+rHEVdya5ddHbjTAz5JsQCe2NShaB9dUxFtAJVqglUpHHKGJW7LVNAbmi6huYYsohCFwmcyPhhxGCWwx81nc6cZJmq60HjTvhFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZF5O3BL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZF5O3BL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774035307; x=1805571307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8YBTIlU5Zz2RAIVhWK5asqXzaMSXnEP+4TOZRUxC4zk=;
  b=fZF5O3BLjhWX/DcDT1tVesj/A00FBHsgsu2CLG4G4MWRasqeff+Ux8x/
   Y2EiMqycOa6/HKnnBYxujpTP2boXbJ3ZpJzjdzUm5O/zRZC20D5VBdw3s
   OsIpEUAj+vKfZ/CxVcudKEbKUC0PL5vaZc2plBAZ2hYk9xcX+2P8Ni7ky
   DXfOJgMMYs2osysvogqLZusJRCwqm2iZjN9iC/XEZS7n5neFmMVAfXEsO
   4Q818YCsAIhyFUGgPo0TbMXJ1HwtIUQ+ZleUwZBSacwR/HBCF8POrWoB+
   iYFL9i5YvEygEZQ2+Aqycg2ejtyMMco1h0zGXw+GvO8v4yPJk9JSe/FUY
   w==;
X-CSE-ConnectionGUID: YTAXr3wPR/yrmAFKFJOMMQ==
X-CSE-MsgGUID: ZAC2dScFShy7juh/KQwRBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75320759"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75320759"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:35:07 -0700
X-CSE-ConnectionGUID: GW8SQ+YIQLOah75gIq0tEA==
X-CSE-MsgGUID: TT79nw/oQ3qZY/4NM5azfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223408773"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:35:03 -0700
Date: Fri, 20 Mar 2026 21:35:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Raymond Hackley <raymondhackley@protonmail.com>
Subject: Re: [PATCH v6 0/8] iio: light: vcnl4000: add regulator support
Message-ID: <ab2hZXdinHWNYB9S@ashevche-desk.local>
References: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 06:45:35PM +0200, Erikas Bitovtas wrote:
> This patch series introduces support for voltage supply, I2C and cathode
> regulators. This fixes an issue where if a regulator is shared between
> the proximity sensor and some other device, and the other device is
> powered off, the proximity sensor would be powered off as well.
> 
> One of the commits includes a Reported-by: tag without a Closes: tag -
> the report was done outside in a Matrix channel. A link to access the
> report requires sign-in, therefore it was left out.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

For the series, except the DT binding, I haven't even opened that mail.
Also you can add Suggested-by to the selected patches.

-- 
With Best Regards,
Andy Shevchenko


