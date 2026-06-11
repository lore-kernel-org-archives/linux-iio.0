Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726748AE39;
	Thu, 11 Jun 2026 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203687; cv=none; b=Ot99benypKhVdAInYaXIJelvhfB8UO46GujCPzYNwOBukofGtGLo5Eku0e095ZzR8Dx3YdXBMI4rDUFph9ykY6ooJD44ykiIYVpFO7fqg6kGeFHFDxNNnNHLCOlxkvb4L9BoBrCcktyYHF2Z+l4vmh2QqqT7j2RHVKCbss2WDFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203687; c=relaxed/simple;
	bh=32MIdeJT2if7MJC55WNlZXYlWCRoK7ftzOyCG5zd8Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIDUVbn/qJTs9672iyMhX9lPhZONyq7T3/GRpYPWegyz8/ykmx/2dDYbEMVd0pqmPnK8CRHJ1F/sAt7x8ZPpJyaNkvZ/pwyrKvJ+RH/YVBhHUgzRfHmdzKttqDqp9eH8hq09IAIFIh9J9Vqvt2EVyh2O9L2hhUH5u3zICvhMl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQeKTb1O; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQeKTb1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781203687; x=1812739687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=32MIdeJT2if7MJC55WNlZXYlWCRoK7ftzOyCG5zd8Gw=;
  b=OQeKTb1O1DQZD2tH8NuV2RggMw5NeSKj4gK1RlQtl0kmTj4Ym/Z4lCBH
   kD05HrCB8ERpZ2IhjpNx8ocMguVPSGoG0jkEj53oQSmxZMtW1VaKa7PMx
   p7ebfO2k7QPbk69XGmXoQXsRpLUKvwfkhwCQb0DiwDItV2Iyvji8zsCho
   YEJbJ5EPv9fZ2lb/gaMS3UBfUzYyl2hQafN/gHCTylGr3uCPunw7Kujoh
   NrTlTz8g9nxd4jPCnRRuSHE/pqM+Kdj39Dm9tbmuGnpy4WZB6oEkfygJM
   3SFptEJVzKnsKe/e6HcnQ7EU1E4kKqff6wsh/sm0l0+3XOZPmBz/Z4OHC
   Q==;
X-CSE-ConnectionGUID: MZ/vI1zXQjCXbCX5uaV7YA==
X-CSE-MsgGUID: k5uT9aUyRPufz/9dGDsQ/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82033526"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82033526"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:48:06 -0700
X-CSE-ConnectionGUID: /uXOAhMmQiioUXxQzmeyYg==
X-CSE-MsgGUID: RTU7sIMKSlSWOmerR9AjXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="250511815"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:48:03 -0700
Date: Thu, 11 Jun 2026 21:48:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux <linux@analog.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: dac: ad3530r: Add support for AD3532R/AD3532
Message-ID: <aisC4JKPwCNgawFR@ashevche-desk.local>
References: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
 <20260604-iio-ad3532r-support-v1-3-c3552f9031de@analog.com>
 <20260605142428.5cd21b26@jic23-huawei>
 <SJ2PR03MB71394BC5D4E680A96F950732F91B2@SJ2PR03MB7139.namprd03.prod.outlook.com>
 <aiqqIz8wiVjauCai@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiqqIz8wiVjauCai@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 01:29:53PM +0100, Nuno Sá wrote:
> On Thu, Jun 11, 2026 at 07:04:37AM +0000, Paller, Kim Seer wrote:

...

> > > > static const struct regmap_config ad3530r_regmap_config = {
> > > >  	.reg_bits = 16,
> > > >  	.val_bits = 8,
> > > > -	.max_register = AD3530R_MAX_REG_ADDR,
> > > > +	.max_register = AD3532R_MAX_REG_ADDR,
> > > 
> > > What happens if we read off the end (via debugfs) for the smaller parts?
> > 
> > I tested reading registers at 0x1000 and above on AD3531R it just
> > returns 0xFF and no crash. Should I add a per-chip regmap_config to limit
> > the exposed register space?
> 
> Personally, that would make sense to me.

And strictly speaking it's better in case of extending the driver with some
other features.

-- 
With Best Regards,
Andy Shevchenko


