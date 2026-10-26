Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005824;
	b=moGp2GbJJH0eydpi+ifzqpo9qrARuzzjCii9WPxS4KbH8HlshDTU4mRZkL6o8Gj+Qf6e
	 aa9/NsYxke6S3+Qwox60JzF4L7Jp1AbXLg1VuhD1jIpuxqb46UkuZyeuhZOGwb6VOw3Zw
	 SAQO2q0ODuGvS9kZ3C9Ak6F1LKkFK5GnLzy3IR2JOXa9N1FxuL4E/+/4QYmaW1ZYrolx+
	 UKtu0kz6vREdHe0efILbFcZAmjoCL03XKqhaDNDZ5Y++a/Dc1nUVZzatShZ7GmKgtEF3J
	 BzIBm6ehIMoxqSDSpaaXnVFN/Dgd1YUq0FmzrVZ8hi9eNcJ7Bq1pZX3CnmY4tX8aYYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005824;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=xG0N640vxGPzUyeTmMc61ay1nRJoduF4BE+pqSDhMpY=;
	b=FH3+E+d3MfRNzDC9055JkujPdYixSCe1sCicYJF7YnaK3h6+oy7OFYU6xGPdfPXPZ7/S
	 WqEH8kyJF8rmKrP5YxIyywDU9W6UbDCWIOSVoTeTyrlvFCK4vXQ6x/lRCuk5jxT4bvgZ/
	 n97yr472P5bRKBT8YkEaVMJ3zKCROigLJMlQ3vZl1pWtzpEmps5mca2kO2Wr8C/kG57uz
	 XHJnMAEiRkBS0cArru8oE6EU1I+mAkuxixHk7zlDDX+70uV9Yp0nrTu5AIcZKhH605R33
	 vYqcE4CoDELSl/nqq6XoESjeQcTYxdJUzHVZDHkGHSgP2UmNgjYsFTnHPIzdNeMk/mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gTZ87+9Z;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B365606A31F
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 09:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B365606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gTZ87+9Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793005824; x=1824541824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NngzgBjGTDtDcAZ2CO6XD6ZPcM6EyfRX4gBW1g3XdlI=;
  b=gTZ87+9ZCv01JpSpQYv5kaZDuJPa7ByNlFEBhIc+I9M4B/B4qDk82ApA
   BjCzQYefR4W+6dstRIiZxuAB79YkYKIao71zpPPf7TNCSGQdn3XzB/83S
   8rGx2D1SV1529TG0eeY4CsmLzYOF19tK9ZUm1jbmsTKUltTStzV+Q7O4m
   QNpGs0Uu0Mp7psvxz1oI6FLogH2oYjpRC3HBAxBoqnf4QFKY6WOH+/GtL
   3aU1qJSA3WJAMg56g8fn6+YHpUjkUDul8ANABuvxuUTghRaEkqG+DRDBL
   n+EjO4Ylqgd6JFYXmkQPhY6ZqIBPk6W3gFY6Hb+1hbwJNAyfNy35Ivces
   Q==;
X-CSE-ConnectionGUID: AYxmIt9PSm6xvEHD4aE+QQ==
X-CSE-MsgGUID: CmMj7JEKTvK977ggAdVZUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1686513"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1686513"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:10:23 -0700
X-CSE-ConnectionGUID: /7wcwm8JSPSaven5WN3gwQ==
X-CSE-MsgGUID: WY9vx6eqSBa7tTGj78PIXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4618023"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:10:21 -0700
Date: Mon, 26 Oct 2026 11:10:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH] iio: light: pa12203001: Use guard() to simplify lock
 handling.
Message-ID: <at8Y-5Cw6KpIoAHy@ashevche-desk.local>
References: <20261026010803.973666-1-jic23@kernel.org>
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
In-Reply-To: <20261026010803.973666-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 01:08:03AM +0000, Jonathan Cameron wrote:

> It became apparent in reviewing [1] that the use of guard() would
> remove some ugly error paths.

...

>  	if (mask & PA12203001_ALS_EN_MASK) {
> -		mutex_lock(&data->lock);
> +		guard(mutex)(&data->lock);

+ Blank line. Let's make guard()() to be standalone to increase the chances
to catch it on a glance.

Ditto for all similar cases.

>  		if (data->px_enabled) {
>  			ret = pa12203001_als_enable(data,
>  						    PA12203001_ALS_EN_MASK);
>  			if (ret < 0)
> -				goto err;
> +				return ret;
>  		} else {
>  			data->als_needs_enable = true;
>  		}
> -		mutex_unlock(&data->lock);
>  	}

-- 
With Best Regards,
Andy Shevchenko


