Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506CF36E497;
	Thu, 12 Mar 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326001; cv=none; b=s0PO9FatkYRpq2yoXjvLDI6dOMsCkJpfKgN3yTkn0ejlk0QsGlfJCNJ1bNPDdadwfpcVwkw5hliELObUhaQUdiBPr5uOKnXr3NKMxduijygqLu9IezPabngQNdXoDuIDRnzmrApn+YV0arKDkWzszgk+48lxWVG32mTk7g2LVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326001; c=relaxed/simple;
	bh=fhlPBbs4jJTobU8nQyTuiy6+oSyhjV0Tppox2lNl0gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGyjo99P+9rXCL2gKonvQJ9+MvuF0M+A1/QnB2dReEQu83nfjJMYCMu9OUsEIwOWvpjNvc+kEeJUQKjY7dbx4nEZNvGxmN7lHKiQuK3fq0LVSKcLPNWo9GfDUD7LFdkvSPyqP5kHX9lDHYsgXhoDNUwYpGxsRwS0BxoM9fx5snw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftwlmJE/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftwlmJE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773326001; x=1804862001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fhlPBbs4jJTobU8nQyTuiy6+oSyhjV0Tppox2lNl0gs=;
  b=ftwlmJE/ViGICB7jcv4ZL6ylLhzpcGsHPEYDUSIOoL0GSTvE3CU0X5w5
   iEToopu3ZhmgKwO7YqBRfAhJGOyCZ+4jsLwjH3iOqDFhVyMLynmeVR2uA
   98tbQRGmkewraHjJwOVBmE0qbOnGE5o1ulpQFz5aqXXekcZKYK3DJytYD
   UN/7IbG5m1ibAElzsZSRBttR5tpetp3pio0GKjXZZ12pjcOvsEQFYRQBW
   akIx8LRUdo99VC9elndwD9QWW57ole2dXTA0gH5zvfwLQPjzjzOho55+I
   3HGpM4Ptn+ZcLN6HcfW7nmk1T3f8OSY+LzM4r/r6fsICKxjX8+BRGwNAf
   Q==;
X-CSE-ConnectionGUID: 5vATxfbITIy4qt0ADq28vQ==
X-CSE-MsgGUID: r0dEWAJhSV6+w0W4q7ahDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74119696"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74119696"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:33:20 -0700
X-CSE-ConnectionGUID: m0gqWl34Sda/5v6fT6h3+w==
X-CSE-MsgGUID: +SeNNHWMSKeNJ9PoUg1y9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="215891351"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:33:17 -0700
Date: Thu, 12 Mar 2026 16:33:14 +0200
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
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: light: vcnl4000: move client->dev in probe
 into a variable
Message-ID: <abLOqkVVeGiUkF8I@ashevche-desk.local>
References: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
 <20260312-vcnl4000-regulators-v2-3-2bdebbcbb58a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-vcnl4000-regulators-v2-3-2bdebbcbb58a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 01:53:14PM +0200, Erikas Bitovtas wrote:
> Move client->dev into a variable of its own and replace all instances of
> client->dev being used by it.

...

> +	struct device *dev = &client->dev;

This should be done in the previous patch to reduce churn...


> -	ret = devm_regulator_bulk_get_enable(&client->dev,
> +	ret = devm_regulator_bulk_get_enable(dev,

...like this one.

>  				      ARRAY_SIZE(regulator_names),
>  				      regulator_names);

...

> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +						data->chip_spec->irq_thread,
>  						IRQF_TRIGGER_FALLING |
>  						IRQF_ONESHOT,
>  						"vcnl4000_irq",
>  						indio_dev);

>  		if (ret < 0) {
> -			dev_err(&client->dev, "irq request failed\n");
> +			dev_err(dev, "irq request failed\n");
>  			return ret;
>  		}

This should be another patch to remove the dup message completely before doing
struct device conversion.

-- 
With Best Regards,
Andy Shevchenko


