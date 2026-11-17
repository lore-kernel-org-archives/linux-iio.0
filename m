Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924649;
	b=lOhjjwgU0n1hwHwv0P0NppIZZrFIDriSs43WPy8VqkmQ/IfTuG/J6QsEmYhJ/Oh63HSa
	 PxI4FIExcJyEaNxRkfnNR9LK+OvswtPlLnPOjtocTBE/Ws9tbWmaN8pEUEURHw1QxnCmZ
	 JrSDHOGrduszJczEvmFYA7XRvMLfacGOwQDpAvpEQWnXZ2cd6lhDgBlNDMrMOR1ipqTiR
	 JlDbrzyAqfJpud2fyJpe9zxxRxElEZZkDbT4p3vCVJoa9DnXsgEZ/sFXefem8SUekIBpH
	 ngmgOFlCraLqchHjA3vr+WxihV52BLFK8fqVsSL28dXE6vBtDc+LbYNoPACBZr0atJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924649;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=bhkBJVV/V+DBHT1yIijq1czdpbPTri8L52Bz1PJ+2gE=;
	b=HQE+2SR9iiJs4F1mcTUiEVKe2I3+PXRwpp3TkJVNUAw3HvjwQRVTRC78gmRtalJwPP7v
	 YkACi4mG1H4PgvwPElbR/2xCaoHfBv2XElagDji+YLt4sSVXnqdSW5GrqTLoJX1kCwmvY
	 L+tmAxAy9VFqeTApVTE0WyAx20fJncEtihj3yrrwFS6wWxXTcT65LLP9g2P8eyi99/Tj7
	 3nj81goquR+pzW2e9nrc0yXVZAljK4c0B5Tmc1GnDQSnOWCGQZ11Y4Z1ZyzNkEnQtPQO4
	 oIB8+ulgV1nNNDDHrd6uNl5b2PARXFoNKV8XlLuRh5H9pmwIFSob1Xmd94exCmBOLcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="O0l/fWBX";
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C242606A335;
	Tue, 17 Nov 2026 14:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C242606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O0l/fWBX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794924649; x=1826460649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FXGK11SIYFfOo1yONwc92MaXuLcG7KkvTsiZAw9rAQQ=;
  b=O0l/fWBXuBjgoEHPNfbYir91ckaNlmLOoVhXDVaMZvYa9HuQH4oimMWp
   iRG90Qs8Ty02CF03+OaCGCG3OmINnjm+eRwZJ8+0yjWb++1ocxC+HpSfq
   FZViCxXw35+Q3HWkzFylZMqRuVLMzWaU4eCDAc8Ayno8EmBUj+aTMF8mC
   LXLAQVxhM45KW4OZmfffTHYYOxDqXXnv2xYksikOP7LAf44WmNkZKyngV
   xpL4owEoeGDezcTsn2g+efuZ59UDVT0ViOT7UehsX+E9ly13zSpYOsDCP
   umk4l8nfs98KclGfZdJkpOYATPwfB421vA8j/qdmnzCwqikisVG/mtWtp
   g==;
X-CSE-ConnectionGUID: sLyK120PRoiLubX46F5vig==
X-CSE-MsgGUID: ZTgIDolAQc+3IQmHh4JnVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3712546"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3712546"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:10:48 -0800
X-CSE-ConnectionGUID: /LACLHe9RpuYhWLHYPCOUw==
X-CSE-MsgGUID: wIWOBnrhTV2W6va3YGSndA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9986272"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:10:44 -0800
Date: Tue, 17 Nov 2026 16:10:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Daniel Campello <campello@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MAINTAINERS: add a reviewer entry for the Semtech
 SX9xxx proximity drivers
Message-ID: <avxgYjixZ2eB5bt_@ashevche-desk.local>
References: <20261117110939.214932-1-kapoorarnav43@gmail.com>
 <20261117110939.214932-3-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117110939.214932-3-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 04:39:35PM +0530, Arnav Kapoor wrote:
> The Semtech SX9310, SX9324, SX9360 and SX9500 proximity sensor drivers
> and the shared sx_common code have no MAINTAINERS entry, so
> get_maintainer.pl only lists the IIO maintainers and reviewers for them.
> 
> Add an entry with me as reviewer. There is no M: line, so maintenance
> falls back to the IIO subsystem entry, as Jonathan suggested [1].
> 
> Link: https://lore.kernel.org/all/20261117031830.69ac22f5@jic23-hlaptop/ [1]

So, the Link here and part ', as Jonathan suggested' are custom replacement of
the Suggested-by: tag, right?

...

> +L:	linux-iio@vger.kernel.org

Isn't this a default for the whole IIO?

...

> +F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> +F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> +F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> +F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml

I'm still in doubt you need them here, but it's not a big deal either.

-- 
With Best Regards,
Andy Shevchenko


