Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4C372697;
	Thu, 12 Mar 2026 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325848; cv=none; b=Hcdw6V14+Y6yBn8Lg7eaiF8UkZX0c/upZlWvVDyv6iSoqtgVm9R1s8l3xu4+XT/4l6KL3WWXHr+0J4VVLbnGXTM50oTKaSibmeoHqFXehJ4ljR+4UkSPTVAl1L/UOfj2MqpHPIonYcsaXr94GG2zZNiNontywNwJCJGs8Awyaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325848; c=relaxed/simple;
	bh=P24lQmSTcI3W8E9myWdW+R/WmVpXzldjusZ3FhL9Svo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKMAVEsyITkiK1GfR9OsdZxzMy/b/qVNtZ81KIW8mE5SmMmxG9eRc0DnlZT+cvV6D0rmFuNNYeBEB6qxOFDzDMLJ7bjulqWvQgu5y6MP+KbXDAFaP3r5BhY9gMTdrMLACyPRxTqx57rbZ60m+YMxy7h85tGImON+zmEQtFvYOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hrd9WuNR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hrd9WuNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773325845; x=1804861845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P24lQmSTcI3W8E9myWdW+R/WmVpXzldjusZ3FhL9Svo=;
  b=Hrd9WuNRBsnYnlRvUIgZUed2EYGjjkpwo4UiQjfIpJPlwEQEqJ3k89ea
   wAbyGhZmaKO5gX4p89qcNzVQ6ZQjj77PJuKlSQNH2LQe/O4FW6kFHOoGs
   mkCX15xrXJf/dtslHmOrOTU15o+OMpkHjr4pArl7RUEkmGBWDk1wsAXec
   7G/+AMSbhQYjkqsQwRq+vk0cdMw9XHjLqQxTmM+74h5s2j5zpVw8S9nPI
   Hw3yXdgkuMqFHc0gOULYHIqL69gcXS+wd/zOeCL/e4YB306tEsIsIaGqc
   qRTPd7lTPE19EttNv1EtpuOfk59riDoU7nBgiePaVdO2hFc5sO2dUXtlg
   g==;
X-CSE-ConnectionGUID: iFvqkgjwS7WBwgfW/QD39Q==
X-CSE-MsgGUID: hY4Q26CARM2Jm7SUO14zgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85049004"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85049004"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:30:44 -0700
X-CSE-ConnectionGUID: dSML+OIZTVCOse7D6KxVZw==
X-CSE-MsgGUID: cxuEAnvHTKuUP28K8baUzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="225814468"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:30:40 -0700
Date: Thu, 12 Mar 2026 16:30:38 +0200
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
Subject: Re: [PATCH v2 2/3] iio: light: vcnl4000: add support for regulators
Message-ID: <abLODjst86xFupcO@ashevche-desk.local>
References: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
 <20260312-vcnl4000-regulators-v2-2-2bdebbcbb58a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-vcnl4000-regulators-v2-2-2bdebbcbb58a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 01:53:13PM +0200, Erikas Bitovtas wrote:
> Add supply, I2C and cathode voltage regulators to the sensor and enable
> them. This keeps the sensor powered on even after its only supply shared
> by another device shuts down.

> This bug was reported outside of LKML, so no Closes: tag can be
> attached.

This paragraph should not be part of the commit message. There is a
comment/changelog block for that.

...

>  #include <linux/bitfield.h>
> -#include <linux/module.h>
> -#include <linux/i2c.h>
> -#include <linux/err.h>
>  #include <linux/delay.h>
> -#include <linux/pm_runtime.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/units.h>

Sorting headers should be a separate prerequisite change.

...

> +	ret = devm_regulator_bulk_get_enable(&client->dev,
> +				      ARRAY_SIZE(regulator_names),
> +				      regulator_names);
> +	if (ret < 0)
> +		return ret;

>  	mutex_init(&data->vcnl4000_lock);

I would rather expect another prerequisite patch that moves to
devm_mutex_init().

-- 
With Best Regards,
Andy Shevchenko


