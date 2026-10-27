Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117655;
	b=K6pEYsqG95Xuyed5qFt+8FQphcMtkhPKBVGBwiLr1oED6Cx7J/mde9PB5ShtEkVW1/e2
	 RW9VOcVA1nZxWZ+l2SfwSzreHH9AYBAM3PveuvMVtQs9Yl7WRnEJQUzHX9i2PuCqpi4U8
	 52cz1fT7UxyePe4/5mdUikIPpBMuKxN004ymFBZo+tdu4D/qXig7U2WrM/qVl/+SAwlYg
	 Abx244RhZTp3kWFus1ObkC1X3WLWdNoBnXKIv0SHeH/WmMQFGSnBAQPb5k7ubA2oobGkV
	 knTrM5KtzrbXvnlZzZid1551jAHP8QFUThbpqPFev9Lr4YpO/4lXlvz7AV7KAbsOTaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117655;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Qu1OlUuaRDFlDngoDiRhq4xzHcO7QBQYm5qjE67JrgY=;
	b=Q2qVZSoKXLbdvzcwKJSAFYQeV4h9G4WE9G/joNcHZKiXS62gce3KUDpSDJL18FGHKY5z
	 jqZX/GMgFPntXscFNU47UB39rDLp5UpoNIVXOO6o6OY7yBpYlBH4Gvu0MUBxX2lY04amy
	 ESpV8O1FTcqq+hiAmOAhGmb+ciNjWclVfkcYjnDkukf1a+bqIhy/TDq45vsWG/CEqtQWa
	 L3wdNAZLN3nytd8/UelIHjP1aJk0FyeWdNjxZ8VL0cMzzRcUUxKOlhYfIk6TCm9+oW95Z
	 FJx3DH/GJ/TKzUL6AjxoJFzxIBK3DceHxy3DpVfLqrIa5dqa/0p93S7R+Wu8CPbnDhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WY4e46D7;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319ED606A31F;
	Tue, 27 Oct 2026 16:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 319ED606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WY4e46D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117655; x=1824653655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3/EeG6Un8Ew9yYVEz+bcUHgerwRj3Ogob05Pvjxv/B0=;
  b=WY4e46D79qkOCa3TMpxItc6joXI7RdecUNmCdA4PDoUtijwRZL87erfD
   tqjny3CR2Srr4M2nQPs3yUiWtqJmvFpnvCqbIOJ1ZMcWlYKS1YFmsqb9m
   3FYWAdt5vaaoEB3lqzbd7n/Vb6V0vfePlAds2n5tEE6XjwZ4wxxnqa9Na
   5xphWlnFYA/CW9Y/f+eRmb41pXoqVoF7wloIBvxHUJYUtEKpyZF0cp1zY
   W+74rfqDtwl04p7H8Gfx8q/R6UZ55DECAadaKFiEMe5mmAmJn8Pw0THVP
   w2pf3IgnKO1HOsoERnpdDJqXmh1lNuHnSDlkBEr5ey6S2bZSyZ6C+Fym1
   A==;
X-CSE-ConnectionGUID: DWjN7UjLTbyC00kkTwxYdA==
X-CSE-MsgGUID: 9juSnbZKSgOEfQxp/8yFRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1707016"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1707016"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:14:14 -0700
X-CSE-ConnectionGUID: TS+4d6eWTfqTWtJrLJF+jg==
X-CSE-MsgGUID: o5OAIKV8QymUal4vL+gcqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4545393"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:14:08 -0700
Date: Tue, 27 Oct 2026 18:14:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Guenter Roeck <groeck@chromium.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Remi Buisson <remi.buisson@tdk.com>,
	chrome-platform@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v4 9/9] iio: enable context analysis for all drivers
Message-ID: <auDNzWMPy0VQcazt@ashevche-desk.local>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
 <20261027124954.110697-10-zoone.rupert@gmail.com>
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
In-Reply-To: <20261027124954.110697-10-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 02:49:54PM +0200, Rupesh Majhi wrote:
> All of drivers/iio now builds without context analysis warnings, so
> enable it in every Makefile that builds objects, replacing the entry
> for dps310 alone.

...

> +++ b/drivers/iio/Makefile

> +CONTEXT_ANALYSIS := y

Can we reduce the churn to only adding it here and do some magic to propagate
this recursively, please? I truly believe it's feasible to achieve.

-- 
With Best Regards,
Andy Shevchenko


