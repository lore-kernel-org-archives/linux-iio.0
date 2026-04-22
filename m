Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D317BA6;
	Wed, 22 Apr 2026 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841193; cv=none; b=OcGYwASJee2Bk0XATEYr5IilxKC0gTrsCktxGPZXcp7deNkUVCc9zY+kNi6T3QXUtwu0mWM4RkiTGx7R3S4xUDqyg3MmybYEHT4Z9ISvGozWX/41Uqt9wHV1TRd1eEPbyQV/qU8fWvyvoa8ToBy+Qf8zZU6NbMCBOnI4U4tN6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841193; c=relaxed/simple;
	bh=OE7ZHeJKKNbBXiTIYyqKSw6tRwwHddTcUCS4ialpg74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fb2DbLdnGUNRDnQipMev5ctF6xhghZRRWFQEAk1r5YAvHa0nDpctc6AjpVY5SdMf4ZwF/cPigA/SPYd2yaM5dgD/A+EdGL92zI6ApTnUcWUW7f7VqUyAJs9lM743sdg+Uh4ud5LOV7ar4vkSgna+MLuBm8l39xn86iv0h9ObOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bv9Fd/zb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bv9Fd/zb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776841193; x=1808377193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OE7ZHeJKKNbBXiTIYyqKSw6tRwwHddTcUCS4ialpg74=;
  b=Bv9Fd/zb1+6lfW+xvZRMTg/YZP+cY8sW8/Wk2uDrfUSf32IrmrqG29nn
   dO/1phkM9nQxGoa6zvAnC46DHJTRPO6xLDw9HUXetEpSmRcU1/SPAhOJK
   gfcZgCz06PEW3N+JMhUDTVqa5kQ2MLCxPLBKrPMHH1MM3+2ZCahojeM46
   Y+6zuxoBy+ugGEpKkrcU6HzuvMsFubqMwb/vSquiPaw0fqM8udBLm17iZ
   txQeyefixjTZwj/UAfNvNhNINd6oDiHB+Bj8mLaPPaBs7IDTxYDpwv+VU
   ayBAmTe8f9yn3CZ4us2wu0MYRTRajq+AMsmKyfMszB8865lusfiZoGZ7Z
   A==;
X-CSE-ConnectionGUID: n7EEnbEHR2Krg7blao5Xjw==
X-CSE-MsgGUID: Q2ZH8Ow7Sqq1bDLvftGWvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77907863"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77907863"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:59:52 -0700
X-CSE-ConnectionGUID: 8/FBucyISyult0tiZL11gg==
X-CSE-MsgGUID: 2hiG7hW9SpqknHF7cAB0kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232129080"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:59:50 -0700
Date: Wed, 22 Apr 2026 09:59:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: proximity: srf08: replace sprintf() with
 sysfs_emit()
Message-ID: <aehx448D3sA8vSbM@ashevche-desk.local>
References: <20260420230813.25985-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420230813.25985-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 06:08:13PM -0500, Maxwell Doose wrote:
> This patch replaces sprintf() function calls with sysfs_emit() and
> sysfs_emit_at(). While the current code is fine, sysfs_emit() is
> preferred over sprintf(), and will help modernize the driver.

...

> static ssize_t srf08_show_range_mm(struct device *dev,

>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct srf08_data *data = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d.%03d\n", data->range_mm / 1000,
> -						data->range_mm % 1000);
> +	return sysfs_emit(buf, "%d.%03d\n",
> +			data->range_mm / 1000, data->range_mm % 1000);

Wrong indentation.

>  }

...

>  	for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
>  		if (data->chip_info->sensitivity_avail[i])
> -			len += sprintf(buf + len, "%d ",
> +			len += sysfs_emit_at(buf, len, "%d ",
>  				data->chip_info->sensitivity_avail[i]);

Ditto.

...

The rest is okay.

-- 
With Best Regards,
Andy Shevchenko


