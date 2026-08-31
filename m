Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BD92EEE76;
	Mon, 31 Aug 2026 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160566; cv=none; b=UB99powuRapZP/ej42auNaupbqtsiac6ak+ChPfrsX3bXyERuUI2S8vJZmY7LALMZdnj3pvcTchLF3EFGDWcmo8g9jqKX07L5Aoa3bh/bNxVob4eQDnP17qwM0/EPlm6J83PzUor637Q9TrIW4p0nKAgpxuHcetTjaaX1XdNrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160566; c=relaxed/simple;
	bh=FEEOhqT1jhBCGXUBQc12nCGYVYm14SMV7KmyjFkYVQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY6QnLxG1Wb5enQlAj3+rt5RzYEgoGzzkn0RfYaB2xiRRgNwGZw0uxnH++YiltHvbc8/Xu2RL3ZQayhrOzeSvfIWii2sD91H3JTweorR7XQyT1iJaGaeBr3+sruglBn3sda4Uc21nKjaH6YiTZnm5Uqs4KFo6oYxVvtq219M2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAUJ8I2w; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAUJ8I2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788160564; x=1819696564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEEOhqT1jhBCGXUBQc12nCGYVYm14SMV7KmyjFkYVQQ=;
  b=QAUJ8I2wKeeEFvZioBIK+jhvSQNJ7yFaZEdirRQODqP3Bav5x+xIUMvJ
   dckQrlmC27893Qe6ROc2PmYezeM8btoQwGM6Ic+3DHT/HEyAOCDyogOGF
   +WEaQL9wZcUC5AB9nX11ymMg+3fxGHU1EVdCXy0yJ9asxhRCaS7+E6JwV
   b7KtKBfv09Wo13qgu29DJThFUJSspaG0ZOvMAwELjNKhTgZB2MuDRk2AG
   PtNLP0sOND7IXdZblQDGkzwXAR2uz6+nfzb0ilBuxwusdc7J2xd/T02Q8
   lWCGgqG2BU4e8x/6K32GRC5zU1DHTS3/qZXAzOGeH4LNgPQi3rA/UGiJr
   Q==;
X-CSE-ConnectionGUID: yNEPvPbSTuex96f43allLw==
X-CSE-MsgGUID: ND/iqhxhQdWYsus3Pq81VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88683405"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88683405"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:16:00 -0700
X-CSE-ConnectionGUID: 6vVeQbW1RVOGXtXRXiJ6hg==
X-CSE-MsgGUID: x8KVMbJQTRuQncui4MLdSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="264433045"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:15:54 -0700
Date: Mon, 31 Aug 2026 10:15:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v5 18/20] gpio: regmap: Add optional runtime PM support
Message-ID: <apUqKHhrxDLcz5l8@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-18-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ad7768-driver-v5-18-e33ca6f841a2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:30:41PM +0200, Janani Sunil wrote:
> Some gpio-regmap consumers share their regmap with a parent device that
> may be runtime suspended. GPIO register accesses must resume that device
> first.
> 
> Add an optional pm_dev field and acquire it before register translation
> or access. Release it using runtime autosuspend after each operation.
> Keep the device active across the complete direction-output sequence and
> propagate failure when setting the initial output value.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

In case you need a new version, check a nit-pick below.

...

> struct gpio_regmap {

>  	struct device *parent;
>  	struct regmap *regmap;
>  	struct gpio_chip gpio_chip;
> +	struct device *pm_dev;

Perhaps move this one line up to be consistent with the below...

	struct device *parent;
	struct regmap *regmap;
	struct device *pm_dev;
// Also add a blank line here
	struct gpio_chip gpio_chip;

>  	int reg_stride;
>  	int ngpio_per_reg;

>  };

...

>  struct gpio_regmap_config {
>  	struct device *parent;
>  	struct regmap *regmap;
> +	struct device *pm_dev;

^^^

>  	struct fwnode_handle *fwnode;
>  
>  	const char *label;

-- 
With Best Regards,
Andy Shevchenko


