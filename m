Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069731F98D;
	Tue, 16 Jun 2026 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605443; cv=none; b=l4HPNflwHEmgyaEccgf7DAuIrY8fe5pRlGSkMwlpI7AX3/Jqv5kVd8OnB95Inbbgxd7eQPq+GotOg7eD1GUiQBCmrmPExEWYWyBfESJXeXaOBbBRTqj5l8/Vk8fTIz6PLD/LxG8V7eGp6N8bjtLY6Oxf1qWcgiapIb0Fm0OAre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605443; c=relaxed/simple;
	bh=CEXNjaIlVsCIdMHVHjvrvDM1R2gS21qhhCMlHhiszZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtmMks5GtLkurPwizL3TcvWepxW4RPuGGSEy7vGpEaQ/9Gtd1hICA2ue3vM6Zoxs+3BaxxSPF4OIsMiavhvsSRxIFvKXZyQGmDFdO8CijD/Jf5fPiLqubWdkn+OQUWmG2MjNscuO13BrOv5ezIfjybcsXlfEc4dvo96/TWb5ryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I30+xcl7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I30+xcl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781605442; x=1813141442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CEXNjaIlVsCIdMHVHjvrvDM1R2gS21qhhCMlHhiszZg=;
  b=I30+xcl77jPmA6e4ccJ79bPRQu6XlDMNi1wt0e5KeKj5ziMx527AMOdM
   ZI44He2HVLt5zr5FrMKjlqofR/yQntVZqH1HHuNsDGP+dV0aPeUdjEoo6
   uI9u5rXlSTWFqsqhOR5w2NTpidIWgn6FjPyAH/Vf4rNQzCmsfleX/BZNX
   8oYIwK8XUtG/F5saMxs42nAtdGZ2k517GvEI4Rlt7/U/YU+NqOEUl+jKD
   J1yrnRecPWq1vapeDRb20+QLVRvhOIMTZ3xiCFwwhzZ+xF9Uwa4vITzyV
   JbVejAPxan+/Cqv6cgcQI+gX/LcRFOT4CoYhK0I3A59QzOysR2vRR3qE/
   w==;
X-CSE-ConnectionGUID: lyTeHCDpRXCOBaUyI543Cg==
X-CSE-MsgGUID: jO/guQlWQRisLb4ar+KQhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93038275"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="93038275"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:24:01 -0700
X-CSE-ConnectionGUID: K9R0zYVGTZqoBjPo+7qc7Q==
X-CSE-MsgGUID: 0YyydkiHR8OXAzhNi8YnbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="252037591"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:23:58 -0700
Date: Tue, 16 Jun 2026 13:23:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, salah.triki@gmail.com,
	sakari.ailus@linux.intel.com, Achim.Gratz@stromeko.de
Subject: Re: [PATCH] iio: pressure: bmp280: return on runtime PM resume
 failure
Message-ID: <ajEkPFyOJAI_TO-5@ashevche-desk.local>
References: <20260616093126.66312-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616093126.66312-1-yashsuthar983@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 03:01:26PM +0530, Yash Suthar wrote:
> Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() and
> propagate error.

...

> static int bmp280_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct bmp280_data *data = iio_priv(indio_dev);
>  	int ret;

No, here must be a blank line. And so on...

> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret < 0)
> +		return ret;
>  
> -	pm_runtime_get_sync(data->dev);
>  	ret = bmp280_read_raw_impl(indio_dev, chan, val, val2, mask);
>  	pm_runtime_put_autosuspend(data->dev);

...

>  static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct bmp280_data *data = iio_priv(indio_dev);
> +	int ret;
>  
> -	pm_runtime_get_sync(data->dev);
> -	data->chip_info->set_mode(data, BMP280_NORMAL);
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = data->chip_info->set_mode(data, BMP280_NORMAL);
> +	if (ret) {
> +		pm_runtime_put_autosuspend(data->dev);
> +		return ret;
> +	}
>  
>  	return 0;

Also possible

	ret = data->chip_info->set_mode(data, BMP280_NORMAL);
	if (ret)
		pm_runtime_put_autosuspend(data->dev);

	return ret;

>  }

...

> static void bmp280_pm_disable(void *data)
>  {
>  	struct device *dev = data;
>  
> -	pm_runtime_get_sync(dev);
> -	pm_runtime_put_noidle(dev);

> +	if (pm_runtime_resume_and_get(dev) >= 0)

Why this change?

> +		pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
>  }

-- 
With Best Regards,
Andy Shevchenko


