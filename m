Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8434DCE3;
	Mon, 10 Aug 2026 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351397; cv=none; b=je8tDjJW4Wb2b3hl8A6cMxST7oqDa+DRPmOx4B9T+tlDy7Izfcunzl25JeCG6tR7VnBSxwVdpYotJe+/Ds5G9+0l0x2sCNrgweqTAz0zFZtd4BuNgmbB4NX0gvbcfgExNfTGH2UmwlF07apc1Q33aTA5dKSRZJ9h1tDzkk37dh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351397; c=relaxed/simple;
	bh=apZqNyayXBhkGINNjbVDqpVPkR5LwtgOvDfsXuVlBC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFVV8oMl2HyyuDfDiaLiISiXAEd/iyF5Pbamkl64C9BKAfhVkv9dswWFmpMOGHD3vawbzxbVch+Tn3z9JmumGnmk0SXF4zdVFBXqNj9X6e/O2rpHXALYE+EzzAvnDJfyFwaGALPW0RYZ8dpQs2hVnUQa5fRIIeSPAtyLWwmW4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8gTEwKV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8gTEwKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786351396; x=1817887396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=apZqNyayXBhkGINNjbVDqpVPkR5LwtgOvDfsXuVlBC4=;
  b=V8gTEwKVQBaJnagFcRaGgTkuPhjnsa3W3AATSXL883rGexAPkrigKz79
   SyT8zdgfQS6bb9UQYZOxqDU2d6iwuoTw5TP5VR5rQVkA27EAR3gm7MhjK
   9fSaD0+52i7XhpWIGkSIeXmJAMk11mGm9Pp2xaKPNZmFbbfu8Dk/Eweoq
   HoXCDhuLzqKGVKN1hhPOSI182i21eo0S5ZRwoDDIg3Qz+0AZ7B3AB3/aV
   0oPZ0PS8OMP0jjkivIYrHKt9uTTmAzMRLyDX1+TFA0o0XGbE7snpmrc3u
   reMJsQA5VAZUAWc5zKd+Qtf/WmwexfV7Jl8aXpY0VYTz3kRjRm9rLMiEf
   Q==;
X-CSE-ConnectionGUID: VlJp2sTFRJqSBbaEQXhb6w==
X-CSE-MsgGUID: tcUXO+hYTimkMOWVuGnHJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97207819"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97207819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:43:15 -0700
X-CSE-ConnectionGUID: 9bdOad7YTWWQAF/w5fEuoQ==
X-CSE-MsgGUID: m1lXpPCXSgKQUdah1wop3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="266471362"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:43:13 -0700
Date: Mon, 10 Aug 2026 11:43:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 3/5] iio: humidity: hts221: Allow unknown whoami for DT
 fallback
Message-ID: <anmPHm3eQb8vdGod@ashevche-desk.local>
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
 <20260808090026.34187-4-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808090026.34187-4-adinata.softwareengineer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 08, 2026 at 05:00:24PM +0800, Adi Nata wrote:
> The WHOAMI check currently returns -ENODEV when the chip ID is not
> 0xbc. That rejects Device Tree fallback compatibles.
> 
> Keep failing if the WHOAMI register cannot be read. On an unexpected
> ID, log it and continue so OF fallback matching can work.
> 
> Use dev_err_probe() for the read-failure path.

...

> static int hts221_check_whoami(struct hts221_hw *hw)

>  	int err, data;

With

	struct device *dev = hw->dev;

>  	err = regmap_read(hw->regmap, HTS221_REG_WHOAMI_ADDR, &data);
> -	if (err < 0) {
> -		dev_err(hw->dev, "failed to read whoami register\n");
> -		return err;
> -	}
> +	if (err < 0)
> +		return dev_err_probe(hw->dev, err,
> +				     "failed to read whoami register\n");

		return dev_err_probe(dev, err, "failed to read whoami register\n");

(a bit longer, but still fine to have on a single line).

> -	if (data != HTS221_REG_WHOAMI_VAL) {
> -		dev_err(hw->dev, "wrong whoami {%02x vs %02x}\n",
> -			data, HTS221_REG_WHOAMI_VAL);
> -		return -ENODEV;
> -	}
> +	if (data != HTS221_REG_WHOAMI_VAL)
> +		dev_info(hw->dev,
> +			 "unexpected whoami 0x%02x, continuing\n", data);

		dev_info(dev, "unexpected whoami 0x%02x, continuing\n", data);

-- 
With Best Regards,
Andy Shevchenko


