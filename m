Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA235201F;
	Tue,  9 Jun 2026 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007322; cv=none; b=aLjHJxSe8RpXOAxZiTIbc5ZmsUQiIbDfgTufJSE3w9s+0t7leCpHRdwWTbBxF2BxDXSY+4VGBLFHVuC51lCrL6MqOTcqsvHOOugE4f6S9a4nSaUkL5f3es85tQQ138SVTnGLr9OfhGitUIvAZDoYmYFlTVlTFlbUEx5auxQjCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007322; c=relaxed/simple;
	bh=DbGBS2N+jXxo7BBnSBYwVuG+yWHmMnyQ7krsNFxlcEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf6OwamsgLnJVDW3aIguihh40bEqre3AWdLQooXizX04zT5/ec6osOcpove4l3/dZ7hwwgt4u6gtmb7YUX1yDuG8aBKaZnRkG3uStLi7EZY9K1ROHUyE4c/zQGXAkJHitHl9Iqr7reyIYjsQjqvKS8e2+HsC3MXiCzlLawvaFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idwloY7K; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idwloY7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781007321; x=1812543321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DbGBS2N+jXxo7BBnSBYwVuG+yWHmMnyQ7krsNFxlcEI=;
  b=idwloY7KQvmgszWQXQthqnFCWNF+aEDGPZwPccpkEAOqfIjnb/M54QI+
   8I5rwtRQQomWv2hJ4lBr77db+mmYtHhuDBm3Wub5Ui7oDlwQkh1A06zpI
   LhB5e2565vIwLgR4vwRmtIJ9BUGOkf5m94HaKqsH7RzTUVypp3RLMhch0
   NzhENng3C4Zm0jbKdAz1fDruy+FHYXnY49Z5JtGYXpaRvCwqRkV6jK6qG
   wVlK6aM83e0em3g68Wul8c3ObH0hKI8wY/YWNzlRDzn+wfFMTaFuW9n8o
   NXpKLb5Q/gnUSLGwKdkxamubYiF1tgmif3IO9EO31JlSPXNXqKmbREqJV
   g==;
X-CSE-ConnectionGUID: gpLYC84eR/yNjghsFuxcrg==
X-CSE-MsgGUID: jRd0CcuTT8OYsazUnD6h0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92328854"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="92328854"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 05:15:20 -0700
X-CSE-ConnectionGUID: jhTUxICnQXCBRcOnDBSd4Q==
X-CSE-MsgGUID: khWg4OPkTYWjzydYwgngtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="244696599"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 05:15:17 -0700
Date: Tue, 9 Jun 2026 15:15:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4] iio: tcs3472: implement wait time and sampling
 frequency
Message-ID: <aigD0vmVJvKbtONg@ashevche-desk.local>
References: <20260607112713.299968-1-aldocontelk@gmail.com>
 <aie2Y96Oylb5EEtM@ashevche-desk.local>
 <55020e69-ffe2-4d40-bdac-e6649693ebb7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55020e69-ffe2-4d40-bdac-e6649693ebb7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 12:27:52PM +0200, Aldo Conte wrote:

...

> > > +	cycle_us = div64_u64(PSEC_PER_SEC,
> > > +			     (u64)val * USEC_PER_SEC + val2);
> > 
> > I'm a bit puzzled why cycle has "us" suffix. We divide seconds by seconds...
> Could it be ok if i place a comment here like:
> 
> 	/*
> 	 * cycle_us = 1 / freq, expressed in microseconds.
> 	 * Numerator: 1 [s] = PSEC_PER_SEC [ps]
> 	 * Denominator: freq [Hz] * USEC_PER_SEC + val2 [µHz] = freq in [µHz]
> 	 * Result: ps / µHz = µs
> 	 */

Yes, and replacing the USEC_PER_SEC by MICROHZ_PER_HZ.

...

> 	/*
> 	 * If the requested wait is so long that even WLONG cannot
> 	 * cover it, wtime may still be negative. Saturate to 0,
> 	 * which is the largest possible wait (256 * 28.8 ms = 7.37 s).
> 	 */

This and other comments make total sense, with them it's much easier to read
the code, thanks!

...

> Moreover, I would like to take this opportunity to address the comments
> raised on Sashiko:
> 
> https://sashiko.dev/#/patchset/20260607112713.299968-1-aldocontelk%40gmail.com
> 
> I propose the following changes.
> 
> For the read and write event functions:
> 
> The read path would become:
> 
> case IIO_EV_INFO_PERIOD:
> 		period = tcs3472_cycle_time_us(data) *
> 			tcs3472_intr_pers[data->apers];
> 		*val = period / USEC_PER_SEC;
> 		*val2 = period % USEC_PER_SEC;

Again, use HZ-based multiplier, see above.

> 		return IIO_VAL_INT_PLUS_MICRO;
> 
> write becomes:
> 
> case IIO_EV_INFO_PERIOD:{
> 		unsigned int cycle_us;
> 
> 		period = val * USEC_PER_SEC + val2;

And again, use HZ-based multiplier, see above.

> 		cycle_us = tcs3472_cycle_time_us(data);

> 		for (i = 1; i < ARRAY_SIZE(tcs3472_intr_pers) - 1; i++) {
> 			if (period <= cycle_us * tcs3472_intr_pers[i])
> 				break;
> 		}

do {} while () seems better choice here (and do it in reverse order?).

> 		ret = i2c_smbus_write_byte_data(data->client, TCS3472_PERS, i);
> 		if (ret)
> 			return ret;
> 
> 		data->apers = i;
> 
> 		return 0;
> 	}
> 
> Regarding the oscillator tolerance, I suggest using:
> 
> tries = 500
> 
> Currently, it is set to 400, based on an 8-second interval divided into 20
> ms steps. Considering a 20% margin, the total duration becomes approximately
> 9.8 seconds, which corresponds to about 480 steps. Therefore, setting it to
> 500 appears to be a reasonable and safe trade-off.

Agree.

-- 
With Best Regards,
Andy Shevchenko


