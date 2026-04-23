Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03BF351C22
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931800; cv=none; b=raPWouFuVdl1l26KKqrtSGF0ljIV6qh/Z9nphcuf2kATCi0VyQ92xrMPuDC6LtCuITaTdleG+qWH0D5QRuZpiMtCG/kvwm06xKbe3q4iOu9bQ5EMlh7q+gI9s3ousILCYt14KVkCb65TuteMwlaljhY0DxUF5KcmDHYSxCnwXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931800; c=relaxed/simple;
	bh=HBIsOoFkm0oYFKCnWs68+X8RUzZ6JdgtHqtmA6nWToQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3A0Rsp4LTwfdRw5My+DoftsI6/TmXzcMTls4sX4nh5LbA8ESN6UbS/6RNjO8t40lSNgQyLaGAHXvmFd5rNdsNeaJjdXRXKjdAcQJTyV+cdFn2wXO/d1sPnammcF+87oejgMXRF8GeTshmH24PgaO/uvEWCKz8bdJ0wSEJ0ei8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8qDw1mj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8qDw1mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776931797; x=1808467797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HBIsOoFkm0oYFKCnWs68+X8RUzZ6JdgtHqtmA6nWToQ=;
  b=S8qDw1mjr3dBdrkXdM223pxAJGND6w8fEZl/QmUXcrxK4PzfurBSZYfQ
   b5dPLmjKGw94UwcwCq3UTkYTBskXsHVfzynI3a939Uc+iFVOUsAAko/cv
   qyhKQQajhMxeMjpkuWPZJfy6FMtxjdq6FPWcfzDxucErRGw8RVJdeT/AS
   OfnKoiK0jU3T5VSmxhpC1l8Bi489yj4mMrulwO+xdQ6Y2nt4RVsBqEL6M
   1xb77WM6YcXRIzR7vPmIRGn8GEZ/0iIBWjUP+woz1Mrs69s8iaSRksMTJ
   qVaXEhDs8h5kOKd1jAXcZZ80MTJqthnZxfQXVVskZ2jU0GeBAQ5pu21lj
   g==;
X-CSE-ConnectionGUID: WhSp6pjoSNeG9e43K0/YiA==
X-CSE-MsgGUID: ht1ay7WJSsuNc3QhCDYLRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77912090"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77912090"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 01:09:56 -0700
X-CSE-ConnectionGUID: 4/JeBXjJQGuqxmiEUcDcmA==
X-CSE-MsgGUID: FJl7ormPTwuNBJwF6vj8jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="234379991"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 01:09:38 -0700
Date: Thu, 23 Apr 2026 11:09:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Jo=E3o?= Fernandes <joaovictor.fernandes@usp.br>
Cc: jean-baptiste.maneyrol@tdk.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org,
	Otavio Capobianco <gcotavio@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: refactor sensors config
Message-ID: <aenTwHN57ltcqcP9@ashevche-desk.local>
References: <20260423020922.4057-1-joaovictor.fernandes@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423020922.4057-1-joaovictor.fernandes@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:09:20PM -0300, João Fernandes wrote:
> gyro and accel configs were refactored to reduce code duplication

Please, use proper English grammar and punctuation.
Also Submitting Patches documentation (which is assumed that you have
studied before sending patches) points out on imperative mood.

...

> -	/* Sanitize missing values with current values */
> +	/* choose context for old configuration */

One has to be consistent with the existing style in the driver. Or, if you
disagree, convert the driver to a style you prefer and provide _a very good_
justification why it should be done.

...

> +	if (is_accel)
> +		oldconf = &st->conf.accel;
> +	else
> +		oldconf = &st->conf.gyro;

Here and below the function is completely uglified. Even kernel documentation
suggests to avoid bool parameters like this.

If you need a common code, make it agnostic first (using parameters), and then
use small wrappers for each of the cases (accel, gyro).

...

>  int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
>  			       struct inv_icm42600_sensor_conf *conf,
>  			       unsigned int *sleep_ms)
>  {
> -	struct inv_icm42600_sensor_conf *oldconf = &st->conf.gyro;

You see, this has to stay in the wrapper.

-- 
With Best Regards,
Andy Shevchenko


