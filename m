Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080158;
	b=TyCdmvnK3N4ibP4u+bm4p4ALsyFLUHkLwH0bAN3HuL8Fg652xlHJQMRN6lED8mjz+pXV
	 isWz1QbQmWUz9S2vhRMSgzQgUsGDPIr9U8LBMBznT9Fk8uJ22Q0mPBGy2d8n30UZyxaZ/
	 DU+TEHjlUi1phzyvhooEz2rPwzs1MLdVhlIenKaqH3+vV4PdjPW5KhYjpFIrcQlWufdx3
	 lzW7WJCOFuqdtylHqnfOwUkqO3mbu+iOAii6lsV7Div6eb5CdvMciZR0qVcEOM0+fkVMI
	 DgVM0J06J29D/ztJMhfgNvPVeFzSYR635t2BL22HAJGq50zbeUN9P6iHP50Yn0UuCJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080158;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=PIbc9nua4UQ3nCZc5X1MLVQJdNQY3d2tUCjTbTWr54I=;
	b=k6ER9EFrwvmPZX7Y5TEnoyuRIPW4SMQw2+1Z+Rhze5jtshh3gw8lq7FUmDF3FnMHmsb0
	 kkC1UrA6F6N+3yBqKkGHEj0fnvOUHUKaAN8ALk2D0xBI6CQkluhNMIpbHnVY8+EyyomJZ
	 Rq9/9MsY+NZdHLkFCtRwHRlkfjF+FBHtSw9BzxYE25BOwS83NNvVMeEyE94nUB+0LM8+y
	 YSeGSaVmE/x7UIPTbrKLRyR/FcF22uZy8CS4eTLWlB2U2/O70xcDeTrG21ZZxwMVr41mJ
	 srS3mjW9vC6mPniL6FxP5EdrWG3IQAk+kImlES/DAs1Tg7M8MEYhrG6X5jZUmZuLbKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ui3sw50S;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B63606A330;
	Thu, 19 Nov 2026 09:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4B63606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ui3sw50S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795080158; x=1826616158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yRKTK5+jsUXRx/48CtGdISI2pY2UyjV5mlrYW4kkyuA=;
  b=Ui3sw50SWxF28KfNVIjcNuJwsTQk7yUOb4gR0n8joEJ76je43xDjYR6I
   rFrtSRvA8k/ZzQJjFYT/yZF9mFU5QFsfLOGST1Pe5loFJgUve0iedFI1L
   k5dOuKwvmyUZFWTUSY7K8ODNRJLeRrQBa++eX2XQrsosT3A2w3aL9nfZd
   TyTp9kjfQ9ueEbYKJmif+VW2PxOzHw+2UqU5yiXMNmf/hSgfQAjMeRJR5
   oCz7mybG08SX7zWv1uOiJj+xAMFE5U0KJQjuiaJakje3Xx7x7Mq8MA0KA
   zL7Ew3aYmDWCSUg4ehfb1fUnPQFBlkXK4dKKMhTYA/ue7KoQXe6PwE2dx
   Q==;
X-CSE-ConnectionGUID: MGFX0+2LTaW8xHPTNKzqiQ==
X-CSE-MsgGUID: iTQ6KyOjQ4+zhwMZj6m9Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3951867"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3951867"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:22:37 -0800
X-CSE-ConnectionGUID: 9RuU3NfxTWqF3oUiIhRu5A==
X-CSE-MsgGUID: KjJsZKtwTHm6PnyX5uUnsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10611252"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:22:34 -0800
Date: Thu, 19 Nov 2026 11:22:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: DelaySystem@tubot.lat
Cc: nuno.sa@analog.com, andy@kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, dlechner@baylibre.com,
	Michael.Hennerich@analog.com, linux-staging@lists.linux.dev,
	linux-iio@vger.kernel.org, linux@analog.com, krzk@kernel.org,
	linux-kernel@vger.kernel.org, crofts@kernel.org
Subject: Re: [PATCH v3] staging: iio: adc: ad7816: use dev_err_probe() for
 GPIO lookups
Message-ID: <av6_10q49dJE_s9i@ashevche-desk.local>
References: <20261118-batch1-s3-warn-v3-1-f622d212deeb@tubot.lat>
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
In-Reply-To: <20261118-batch1-s3-warn-v3-1-f622d212deeb@tubot.lat>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 10:22:17AM -0800, Maximo Manriquez Lizarraga via B4 Relay wrote:
> 
> GPIO lookups can return -EPROBE_DEFER.  Convert the rdwr, convert,
> and busy GPIO lookup failures in ad7816_probe() to dev_err_probe(),
> which suppresses the error message on deferral and records the deferral
> reason.
> 
> No functional change other than defer handling.

...

> static int ad7816_probe(struct spi_device *spi_dev)

While at it, add

	struct device *dev = &spi_dev->dev;

at the top of the function and use in the code you have touched.

>  	chip->id = spi_get_device_id(spi_dev)->driver_data;
>  	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
> -	if (IS_ERR(chip->rdwr_pin)) {
> -		ret = PTR_ERR(chip->rdwr_pin);
> -		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
> -			ret);
> -		return ret;
> -	}
> +	if (IS_ERR(chip->rdwr_pin))
> +		return dev_err_probe(&spi_dev->dev, PTR_ERR(chip->rdwr_pin),
> +				     "Failed to request rdwr GPIO\n");
>  	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
>  					   GPIOD_OUT_HIGH);
> -	if (IS_ERR(chip->convert_pin)) {
> -		ret = PTR_ERR(chip->convert_pin);
> -		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
> -			ret);
> -		return ret;
> -	}
> +	if (IS_ERR(chip->convert_pin))
> +		return dev_err_probe(&spi_dev->dev, PTR_ERR(chip->convert_pin),
> +				     "Failed to request convert GPIO\n");
>  	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
>  		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
>  						GPIOD_IN);
> -		if (IS_ERR(chip->busy_pin)) {
> -			ret = PTR_ERR(chip->busy_pin);
> -			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> -				ret);
> -			return ret;
> -		}
> +		if (IS_ERR(chip->busy_pin))
> +			return dev_err_probe(&spi_dev->dev, PTR_ERR(chip->busy_pin),
> +					     "Failed to request busy GPIO\n");
>  	}

-- 
With Best Regards,
Andy Shevchenko


