Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724466;
	b=3aDmivbK9mMvW7JzphIfmy+f8/9JL1orz2HFQqPIIDNK+pHfXBFpxaRKsqwN131NN8Ed
	 hsS4NKbshiE6zgXr3FcP3s1ihFe57Cn64rOs56eVmCzkXk8e1sBGzJgBzZHZ2q5AjJbVt
	 YKHLK1G+p+/XbmaeDSobpLcZAgjTG9Ii+FMwjzTSQi/rF1/h7Ko281WnkGi2L+HHwjvpE
	 6bq2AnqupOmhRhpBcXRvDzztwaXBqBykCe1E2sbqfD5+oq5sKuFRl0cav8x2wE5MrZv1N
	 1dCB6ykcRox4cK9LauzCgFNjSwHt9G6u2e6xtlabV+IpVLvU116DyhJMO/3bsvTKgjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724466;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=soFe8FZSLjyPJHjFSdKiTxtQrK8J6hJHZTKQlP5gbhM=;
	b=t+JSulpCGeGrouVEa3LhTUrFmkXHTG2YeGrFBIbSM9ToJzF+hg80xzp3r9JbMzYYX8RA
	 jzRH78uxLB55/TYCJ9Zq0gF2Nd9TBSa1FzUgz9ryGJyKmQNJ5xx4KQccMB/zhTPyLCGxa
	 fR1v9U04pYSVEswwcRV0X4n9VvhEOy3I2BsBUSivFopqPZGqmcwx8KnA3bK3NoUHME5xT
	 s7M6tJI+JLPgLCj4zpuBPB5RJ/+SKUeq3BKIZSnADSlLlA8LKIHTrU4YFewXmKBgx8HSF
	 r3xqmSFl9tu2KjRl3putmf7x0u3Ho9p7i88ZK0fcH5LKkfkbh6622KbFj1MHScCG+4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ac5PQogX;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18B606A33A;
	Tue,  3 Nov 2026 16:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B18B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ac5PQogX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793724466; x=1825260466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J4Le7fbGRKNvDYCgjVXxQqxQ8he0Z7WaCBdBn5Kt3fE=;
  b=ac5PQogXx+QXLhDWtRpqdbg9vylJu5yPvfxAjrgetDhJyiudi9UpeE/I
   UWF2xvQZkWOPR+bAkMD5GQn9Pp7FtAhjrwgh7++HkBdc1iTN6mJusL3SC
   dBpJTeHoOjDz/QaaLR5LxO1uRVZI15uxpQzq+bTgcLRcezCD8qqnlfHZI
   u+mIA6wYQipVb3ZzCCHlK0ojWlDoRtR4icVLNu/TFd8OUaffyN1iVmP/e
   J27LdBr8faznZDbtghwnmp60ZZ8yYLV7N0Mw3DQFMANzJo3z6/Ay67n2l
   GE75s91ujAYwIsy93mm1VgdEtdHYeAsMZXuZaYI5t6SWdodhUV1gjfpzP
   g==;
X-CSE-ConnectionGUID: /tq1EQFXRWWE9nDlx95L1A==
X-CSE-MsgGUID: enjZCDYGQ2ephu233qxkdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2454189"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2454189"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:47:45 -0800
X-CSE-ConnectionGUID: pOlBIEX1QIOAWZ3y1gJypg==
X-CSE-MsgGUID: rAJO8y4YQ8+kLC3HQlRYMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6479484"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:47:40 -0800
Date: Tue, 3 Nov 2026 18:47:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 07/10] iio: frequency: ad9910: support drctl control
Message-ID: <auoQKX4CNb0sWkWH@ashevche-desk.local>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
 <20261103-ad9910-backend-support-v3-7-0e9224ddf7b7@analog.com>
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
In-Reply-To: <20261103-ad9910-backend-support-v3-7-0e9224ddf7b7@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 11:53:03AM -0300, Rodrigo Alencar via B4 Relay wrote:
> 
> The DRCTL pin controls the slope direction of the AD9910 digital ramp
> generator (DRG). When dwell is enabled at a ramp limit, the DRG holds
> that limit until the next DRCTL transition, so the sweep pattern is
> defined by the waveform applied to that pin, which can be generated by
> a PWM.
> 
> Get the optional "drctl" PWM and expose the integration_time attribute
> in the DRG ramp up and ramp down channels, which sets the time interval
> assigned to each ramp direction while the sweep parameter is accumulating.
> 
> The DRCTL waveform is described with the PWM waveform API, using the duty
> offset when DRCTL needs to start low. The PWM is disabled when the
> resulting period is zero. The waveform is rounded by the PWM provider
> before being applied, so that integration_time reports the intervals
> achieved by it. Writing to integration_time fails with -EOPNOTSUPP when
> no DRCTL PWM is available. As the waveform API has no stubs, the driver
> now depends on PWM.

...

> +	if (!ndh && ndl) {
> +		/* DRCTL low on the first half, so that it ramps down first */
> +		wf.period_length_ns = st->ramp_down_time_ns;
> +		wf.duty_offset_ns = st->ramp_down_time_ns / 2;
> +		wf.duty_length_ns = wf.period_length_ns - wf.duty_offset_ns;
> +	} else if (ndh && !ndl) {
> +		wf.period_length_ns = st->ramp_up_time_ns;
> +		wf.duty_length_ns = st->ramp_up_time_ns / 2;
> +	} else if (!ndh && !ndl) {
> +		wf.period_length_ns = st->ramp_up_time_ns + st->ramp_down_time_ns;
> +		wf.duty_length_ns = st->ramp_up_time_ns;
> +	} else {
> +		wf.period_length_ns = st->ramp_up_time_ns + st->ramp_down_time_ns;
> +	}
> +
> +	/* a zero period disables the PWM, nothing to round */
> +	if (wf.period_length_ns) {
> +		ret = pwm_round_waveform_might_sleep(st->drctl_pwm, &wf);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = pwm_set_waveform_might_sleep(st->drctl_pwm, &wf, false);
> +	if (ret)
> +		return ret;
> +
> +	if (!ndh && ndl) {
> +		st->ramp_down_time_ns = wf.period_length_ns;
> +	} else if (ndh && !ndl) {
> +		st->ramp_up_time_ns = wf.period_length_ns;
> +	} else if (!ndh && !ndl) {
> +		st->ramp_up_time_ns = wf.duty_length_ns;
> +		st->ramp_down_time_ns = wf.period_length_ns - wf.duty_length_ns;
> +	}

This and above if-else-if chain can be simplified

	if (!ndh && !ndl) {
		st->ramp_up_time_ns = wf.duty_length_ns;
		st->ramp_down_time_ns = wf.period_length_ns - wf.duty_length_ns;
	} else if (!ndh) {
		st->ramp_down_time_ns = wf.period_length_ns;
	} else if (!ndl) {
		st->ramp_up_time_ns = wf.period_length_ns;
	} else {		// for the above case
		...		//
	}

Or with inverted logic.

-- 
With Best Regards,
Andy Shevchenko


