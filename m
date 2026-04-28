Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9B44CF54;
	Tue, 28 Apr 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382816; cv=none; b=IlifeB4pc4F5i3cd7KeNPF+3a8878YWrV/GM2NdOe46ods72dCk1X91DP24vU4i2V9bcW65b34haO/qGoY8RdgaKOfep+UjS7h563sFY1JKtx+S/Oaze/Lf/cewV9C7IivXq8Ru/RreZmM3WYu8J9zX7OPMDV8Fhf0iZnBnHqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382816; c=relaxed/simple;
	bh=2VHrSUQRhjtOSP2qxKGjawI68Rg/03TkxpktF89H+QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyRaYKDguoA/Fy2STYOxr0uqx8W+pnU9kt8abVj0iVJPj4Da+QvLeWsF98zGp9shwUrVGnQyKW5EI6xphLZbZHtkFRmmLuyCxAX3x+5TufoAbnvu/wUW6FUO1G0CXq4L0z2ipTaKe3SfVq0X/iSWM/sQqsHv2588O1b8Jcg0BFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9fn0JBj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9fn0JBj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777382815; x=1808918815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2VHrSUQRhjtOSP2qxKGjawI68Rg/03TkxpktF89H+QU=;
  b=Y9fn0JBjXLBDgaEHSqp51NVVcZAA2BRBUWjrhqm9p8z6iRMzzbB9p8s2
   JtacEAjSBwe83sKi7FjKpNlsCK86YJx9dcZx+4w4eka90KeBR87CmLkx7
   cw32ZWlkJW7y5kekYAZFEYvuQeCHqYnz1ZUT0niQEq6Uj2/iumI1+7AU9
   4RF7fzk2IFnXy6Y1V2UVmgx00qglmhlszg9QMWslUgvb9Jd41fyKPIq52
   9jDxF3MX2AgswsUuW3DR2j7qEO2aRuaQ8JeBQwq540DMNvEfXAiVj/O4l
   xEyaD0uMoKLLxuwjc4Dylg4GCBsZi7IAj7Ajl8nmHJDHJ957GzXtqE4Qk
   A==;
X-CSE-ConnectionGUID: g2iM8GN0Tmqg9mO1Uo3OOQ==
X-CSE-MsgGUID: 7BhX67znTEKRDSuyrUg2UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88886899"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="88886899"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 06:26:54 -0700
X-CSE-ConnectionGUID: zL9H3tPjTcC6ePbhVdpbJA==
X-CSE-MsgGUID: YDglzb09R2Kek6ykLzhXPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="272088800"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 06:26:53 -0700
Date: Tue, 28 Apr 2026 16:26:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: magnetometer: rm3100: Use scoped_guard() in
 rm3100_get_samp_freq()
Message-ID: <afC1mdCZGZKHQx5V@ashevche-desk.local>
References: <20260428124644.49707-1-m32285159@gmail.com>
 <20260428124644.49707-3-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428124644.49707-3-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 07:46:42AM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and mutex_unlock() calls in rm3100_get_samp_freq()
> with the more modern scoped_guard(). This will help modernize the
> driver and bring it up-to-date with modern available macros/functions.

...

> -	mutex_lock(&data->lock);
> -	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> -	mutex_unlock(&data->lock);
> -	if (ret < 0)
> -		return ret;
> +	scoped_guard(mutex, &data->lock) {
> +		ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);

> +

Redundant blank line as ret is defined elsewhere.

> +		if (ret < 0)
> +			return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko


