Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F41D47AC;
	Thu, 25 Jun 2026 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372241; cv=none; b=igjpsnsbrM0GrfZVYmGLSK3pqrzYVyR8II8EEuwGSUrUjqtuZsjlJBWux3Sd08vVLv0Zy0M2ZiDxrWgxZNBNbNApIborlL41WWIFfF60cdNTEI1gYm14M9UMtLdPDFy+18sIfaqbMlcaNnrcPSG356RgEL54FPB4rgHcJVQSXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372241; c=relaxed/simple;
	bh=1UZvmdf4Q5tnJFY7xUSRWz7uM0sTceNWud0IQD8vJU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhdryaALWqUf+IVwKaHfT65pqbsGpReQn46iINfqpWBPIi1oxaF+K0YzYGiUFkBvBaGQ/0Yi9h9ENzgSi9oflAGf0OJO5tFBEJSWOXJdQPl6y1W4yPnt6lM+5YW4Sdvzsu2GJA1prshAm4wNps67TuWfCp8Gg5wNN9wHW+KfTZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXK/SKHT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXK/SKHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782372241; x=1813908241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1UZvmdf4Q5tnJFY7xUSRWz7uM0sTceNWud0IQD8vJU8=;
  b=iXK/SKHTyj+9kBDv9AF3N+K2gbB1QRFAHwlWHJ44O5Tsy9FFkdYkxBm2
   5PuvaQnoMJO3418kZj/d/nK9YyypXl6v6cZNNptYrsf4MLafh+5AI5zeu
   Lg/6H00ARofwScriNoI9gjWrxODd4ltZSPlAUM+aR73DwZXZG5HXmao4r
   XG9QQK00Pi9xIRYMwiXyrZdKALo8+8TEh0ApDNHoUgzlHTS76BFII3rLt
   uJSMSsxWycOIGAMW/Xfj5xzzOl5vGb6A+ShSGzL95nlMjKd81VGxIZsIY
   S9nXglyKwwMbFGEk26Dh0TzyWdgt1hKIFbgPje7CG9zB875ND7S92d5OI
   A==;
X-CSE-ConnectionGUID: nhR7eYHHTbuG97dyQXswXA==
X-CSE-MsgGUID: IfZiO6AUTNSks3l82woRGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="87049969"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="87049969"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 00:24:00 -0700
X-CSE-ConnectionGUID: 4B3wNXkYTvCXf9SkCyOppQ==
X-CSE-MsgGUID: w3gGCdMqQL2K5wlStobBiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="254238373"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 00:23:56 -0700
Date: Thu, 25 Jun 2026 10:23:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 07/14] mfd: lm3533: Use dev_groups in struct
 device_driver
Message-ID: <ajzXidQCd8pe-L5b@ashevche-desk.local>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-8-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-8-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 17, 2026 at 11:00:24AM +0300, Svyatoslav Ryhel wrote:
> Instead of creating and removing the device sysfs attributes directly
> during probe and remove of the driver, respectively, use dev_groups in
> struct device_driver to point to the attribute definitions and let the
> core take care of creating and removing them.
> 
> No intentional functional impact.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
And thanks for doing that!

...

>  	.attrs		= lm3533_attributes
>  };
>  
> +static const struct attribute_group *lm3533_attribute_groups[] = {
> +	&lm3533_attribute_group,
> +	NULL,
> +};

We have ATTRIBUTE_GROUPS() macro.

...

> +++ b/drivers/video/backlight/lm3533_bl.c

Same as per above.


-- 
With Best Regards,
Andy Shevchenko


