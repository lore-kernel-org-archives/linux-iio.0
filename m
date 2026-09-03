Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BAD39E194;
	Thu,  3 Sep 2026 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422871; cv=none; b=rPz+FaosQQkLvL6PqemHZ3wr/97zmNM7ox/OdCd5CJuFZU6v4m43mg1Vp9szXEPDirHVL0eH7XuS9CzANvZubfHebHMAyTGwfmxVsXKk86hrqY6I4t2GSzb3hppbzQkRkYaFQKvW1/CvPq6Czh0XTY22DS/2Cz5SP9Hzyg0v1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422871; c=relaxed/simple;
	bh=tl94v/kxShdZK3zvG9vIF0WMAdOmxrv+DzQXDc0ZyT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsYFPH6DSiIFkokBcOXz1t28/iqt4lQ5i2Aui790fr+3nDgI7BIWkumSgdPrwS7r94DDlixuf4u2/a7y2KzK5guRfq5gskthUkoLeMC+MKNUS0zkzYdVT9i1PCtc8e2ecUgZDzCHnFoXpFbggY8SNKOosjK4wLHSu5aAe/zOGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/FMOBem; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/FMOBem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788422869; x=1819958869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tl94v/kxShdZK3zvG9vIF0WMAdOmxrv+DzQXDc0ZyT8=;
  b=J/FMOBemktB83OSIoWvmNpm8UJPajz5wV4PJlEgLo3slS0+qLaqKoyBS
   zDSUN7S6T0VgdOCWfg5m+CTVFs8Sl6NYDC5ovYkFr2l7h9gfJAqqrD1w8
   Fd/0gUH0mOLthN5wOjuTiZ5h2PxP6oXRuA4jINZQ8T4h2qNBG1VjepILj
   CAGwCnNDu4JvrzQSmwwIzhwZMD4lvw33YpW7SRIhWYHyqidg/VHaDyTDb
   6bXAbcIDAUvVheVKwkaSpyAupc4lagnixi5kBCoyRKy6U9e9RbPffctRO
   B59eetRFHrNYPV0zhG+bLgEM9vV9ymGfX19B1JU5LUqpi+UsWYqI/nxC7
   Q==;
X-CSE-ConnectionGUID: w9WmhHesRgKnl+Dnw3nJkg==
X-CSE-MsgGUID: FL5tVZ9PRpOyXAmzELjoHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88772833"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88772833"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:07:48 -0700
X-CSE-ConnectionGUID: IKxNo846QyehnPh49HBZqA==
X-CSE-MsgGUID: 0cccgDR9Q3Wp3cBo5uPgMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273149027"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:07:45 -0700
Date: Thu, 3 Sep 2026 11:07:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v3 5/5] iio: light: vcnl4000: add shared IRQ support
Message-ID: <apkqz3LJcfSy9Ak2@ashevche-desk.local>
References: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
 <20260903-vcnl4000-v3-5-5e69c2e715a8@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-vcnl4000-v3-5-5e69c2e715a8@jacques.com.au>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 02:53:50PM +1000, Tsz Shan Chan wrote:
> Change the interrupt trigger to IRQF_TRIGGER_LOW and add IRQF_SHARED to
> allow the sensor to share an interrupt line.
> 
> Return IRQ_NONE from the irq handler when read fails or when none of the
> interrupt source bits handled by the driver are set. This prevents
> claiming interrupts from other devices on a shared line.
> 
> The datasheets confirm that the INT pin is open drain active low, and
> the interrupts are latched:
> - vcnl4010/4020: The INT pin is open drain. It is pulled low
>   while a status bit is 1, and it stays low until the driver writes
>   a 1 to clear it.
> - vcnl4040/4200: The INT pin is pulled low when a flag triggers. It
>   resets to high only after the driver reads the INT_Flag register.

...

>  		ret = devm_request_threaded_irq(dev, client->irq, NULL,
>  						data->chip_spec->irq_thread,
> -						IRQF_TRIGGER_FALLING |
> -						IRQF_ONESHOT,
> +						IRQF_TRIGGER_LOW |
> +						IRQF_ONESHOT | IRQF_SHARED,
>  						"vcnl4000_irq",
>  						indio_dev);

This will require to have other drivers be in the same settings to share this
interrupt line. Which means that the cases when we have active-high setting
in one device in DT and 'fake' one in another (assuming a NOT gate is added
on the PCB), this won't work. In another driver this was split to issue a warning
and use default trigger if and only if it's not provided by the firmware.


-- 
With Best Regards,
Andy Shevchenko


