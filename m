Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FCD374A01;
	Tue,  9 Jun 2026 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032449; cv=none; b=R6hM7RTlGnLLApwk4xEje7FW1gRXk/YQQavBUxQk78Opp7k7Ze7otvhGkLQ+Yz8aJzB0aswE/28fdkGJkDUVxrNZldm50zPYa3uXXLwtbVnNmOnNnMQfwxHvbQGjdsnHIT/2lUuV+r49aN4gwVxFUy7NMADg8joCBEngi2yOwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032449; c=relaxed/simple;
	bh=kHAFo30QUtXvLKXA/8ylRwSsXrZr+2hcR1czMiLOh1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZbPrEM15rVjQEofoZJbzHAzpAYJs3OUF2+taYikiQ+g5ukwlfUfG2t4xgULD79xDtO5ciN7KWUKvPr1Jod2t1WCKvldt3tQUj/4MAXP6w+uvWJrf7UiCR4OEErnuiP4UiIeoIhBLs3T9ygUAO6tNMo2KsL2wJrAOqm0YlIZIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbF7LTy8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbF7LTy8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781032448; x=1812568448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kHAFo30QUtXvLKXA/8ylRwSsXrZr+2hcR1czMiLOh1Y=;
  b=UbF7LTy8m7WW/LvlhvAXZ9AObY8JTPfJ+Xvn8ky4LbJtZJRlHVnQt5A0
   QM1mlXA85wc0O6hnbyvN0m54SaHhZmapG8l9zs08aSjVaHbRcKLtZA9yR
   xM94TT8dKVnRsK1tPAnSkhXq5wAmNqKDoSzfJp2sNVs1cmTFczh8op4gz
   30f9DxrKHUxBbnNzeA0yjh118XaazogzEuGB1jqLYfqZllP1J6hJfu8pf
   f3S06tnipflz/PySyX/cs24ZHQEM0t0jDQurd5YpzDhJ6ZkuKJFVg5Ima
   reLl9IdMd0oAEMwpe+8SLI21mUPJPtfoqUlke2rJ0sVFnef+O/kG+6q0M
   Q==;
X-CSE-ConnectionGUID: zyJKSvvwT9mE176WYT8AeQ==
X-CSE-MsgGUID: KNjmyvbmSZa/tMqZhSRrTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81554897"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81554897"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 12:14:06 -0700
X-CSE-ConnectionGUID: X0qVWR8NQgqGxTo5R+G26A==
X-CSE-MsgGUID: drwEeY1KSoSQ1tXR0KjPlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="243485062"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 12:14:02 -0700
Date: Tue, 9 Jun 2026 22:13:59 +0300
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
Subject: Re: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to
 device_add_group()
Message-ID: <aihl9yIqN3adKWLr@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-8-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-8-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 06, 2026 at 07:57:31AM +0300, Svyatoslav Ryhel wrote:
> Switch from sysfs_create_group() to device_add_group() including device
> managed where appropriate.

This should use .dev_groups member of struct device_driver.

...

> +	ret = devm_device_add_group(&bd->dev, &lm3533_bl_attribute_group);

This will make Greg KH very grumpy. (For the record, original code as well
but it already is in upstream. So, thanks for trying to address this, just
needs a bit more of work.)

> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to create sysfs attributes\n");

-- 
With Best Regards,
Andy Shevchenko


