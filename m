Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFEA399D08;
	Mon, 22 Jun 2026 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133067; cv=none; b=OBB62skHhsUINdTtZrXBy9m7OHLMpcrdDDFbZwqefxxVcwoVcZtyuM5czcUYriAnMj/p64NdFj3F4ywdh0XleQ0Hdv+kH48t8Bd+wmEUKQFH1RBa0dot8D/kYGQ3Y4Q3Ld2wv6EpsgGD+m5jElaVHI2IRhrzK4/vSv1dRbmM6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133067; c=relaxed/simple;
	bh=Y6sI9XIougNi+F/T7Fj9buOIxniimqJ1dh8PVhIMIl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDfqXDAbYxPPpUu0F2JuKL78M5Z1vtaZ0SBqQZ/sdc/VpBtfndqapb3RfVLHmZ0VQ8C4jwOy1hCEegylHVr7peU6UZqVNh3xRwFbN5v9r7onzRCKfWEyNWNtuitXLYJjLHF39Ihpw9dsJP7Uvf9pEbY7Ogtjyr8c+PvadxFxDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EK7DfOK7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EK7DfOK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782133067; x=1813669067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y6sI9XIougNi+F/T7Fj9buOIxniimqJ1dh8PVhIMIl8=;
  b=EK7DfOK7Ht/ET7SZbJ8pgyQMtV8IvbsldD85gZdVOjRJftYpk9Zg0yDz
   MgRnvDZ7Y9DI1Wbv+/nTc9W8tkzXUuoaCxJOqttsVAj3wnQTf9TSgdYnh
   9nIrBKUi55fPJzqitng2duLyxtCOVWMn64VBaPN0MsW3nHUW9i+RBRHTN
   rgJgVqDW3V7xhw5slBZ9WsYqZsSzbcx39KjmzwG21fSop71+lAwsj1aLg
   Op2oKveuuVdxDnpRqkdJaF4sT0RiBjBNWZp6SvLuYyvFPn9HMrJTU18ZI
   4fjvcuTMS5Tefnc12fLyfrXHVoK9BnV0EUNNSeEc5ZB4Bw8k6QFOdrfCa
   Q==;
X-CSE-ConnectionGUID: yKhe4t/QS2ecvRZguVA1yg==
X-CSE-MsgGUID: gU+KjnYYSgSbtfhW6yJSFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="86545150"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="86545150"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 05:57:46 -0700
X-CSE-ConnectionGUID: w0C/rfAoQyOp4e71DQOYTA==
X-CSE-MsgGUID: d9b3WKqRRx6u2/mZBMBdNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="253554512"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.152])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 05:57:43 -0700
Date: Mon, 22 Jun 2026 15:57:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: accel: kxsd9: fix runtime PM leaks and unchecked
 returns
Message-ID: <ajkxRQniQRqmAe46@ashevche-desk.local>
References: <20260615200330.1234-1-birenpandya@gmail.com>
 <20260621193036.78549-2-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621193036.78549-2-birenpandya@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 22, 2026 at 01:00:31AM +0530, Biren Pandya wrote:
> The kxsd9 driver uses pm_runtime_get_sync() without checking its return
> value, which can lead to silent failures. It also relies on manual
> pm_runtime_put_autosuspend() calls, which is prone to leaks.
> 
> Specifically, kxsd9_write_raw() contains a bug where returning -EINVAL
> bypasses the pm_runtime_put_autosuspend() call, leaving the device
> powered on.

...

> void kxsd9_common_remove(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	iio_device_unregister(indio_dev);
> -	pm_runtime_get_sync(dev);
> -	pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
>  	pm_runtime_disable(dev);
> +	if (ret < 0)
> +		return;
> +
>  	kxsd9_power_down(st);
> +	pm_runtime_put_noidle(dev);
>  }

I am not sure this is correct change. Now, if the PM runtime fails, it leaves
the device to be on. Is this desired behaviour?

-- 
With Best Regards,
Andy Shevchenko


