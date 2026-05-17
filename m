Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0E30C143;
	Sun, 17 May 2026 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003508; cv=none; b=MyImvlwFJPkiB80Icp0wroIhyslsXJlznmsTISd8fsrq1NwinyLSey0tqQpHGKCfrVtHK9ArT2YFKUESuBQrDFQtRPcyWnY0zU6W8IgJ2MojAb7p10rcKaOXLPaqV3NCWQs5+uey8U5JovmRSgTj71k8Urra7BvVgvp0+T7t/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003508; c=relaxed/simple;
	bh=ExrN1rLwulHBQxjQGc7Dmc1B5pSI74s5+OStwHX5SpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo3TruwWsqZYezO+uNzgxswY6MStVkz1jtncMBz4DPV8RfbawGbvvSNBw+vx79SogKj836F8P5ElhcrcWbwqZWlM2zIYDVrajE4v5t7R2PKuq0Zy+ybPoc0jIbnahnBU/0x56w8aBtrKhFp+kDHSXh1bdbf+kSzYdQidiUpXxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvphqvCi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvphqvCi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779003507; x=1810539507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ExrN1rLwulHBQxjQGc7Dmc1B5pSI74s5+OStwHX5SpM=;
  b=YvphqvCiy1agdtOrjVGT2d4Q0C2nSVpJuJu6u0D/Quy1WbEfreO/bsS/
   /SjNzkZsdArEmf4BpwXph2+LTJIXqJkwAaTt+rMizSGUSifhqA4/nYMwE
   yWN91sNyXyCg1HBT7LMOloelEkqjjjdPUqD+oxWmCjusOc5ml5BtMW40X
   8Ze1YiF8k3YnYdaTKuWn5YNOtdAcTjDtLDocdwV52g9AsbGeYXroTOBs3
   s6sxuLEcZQjCL11ENinKlZAqPgVZLu7HyuC816/+5M+FhUQGWspaBYwl1
   IUZ/BYu+eGBtpCNLTnvckwqPeqZeO3fco5cX5fTm9Uaz5vCouL2DD0Q3z
   A==;
X-CSE-ConnectionGUID: 9n7OQaGmR4yb/qKQ9bnGBw==
X-CSE-MsgGUID: mbpS8i4/SjuQCIhDutRDiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="83761328"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="83761328"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 00:38:21 -0700
X-CSE-ConnectionGUID: qqIRJzgZQyqBUxwDVznt0g==
X-CSE-MsgGUID: K7tRiMXBRSqmSebT9hIvFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="239360122"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 00:38:18 -0700
Date: Sun, 17 May 2026 10:38:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 4/5] iio: light: tcs3472: implement wait time and
 sampling frequency
Message-ID: <aglwZ3IyK70j4deo@ashevche-desk.local>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-5-aldocontelk@gmail.com>
 <agRdzneWb2RIidIp@ashevche-desk.local>
 <0a0d0931-f1a3-4ee0-99fc-91d379490838@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a0d0931-f1a3-4ee0-99fc-91d379490838@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 05:57:11PM +0200, Aldo Conte wrote:
> On 13/05/26 13:17, Andy Shevchenko wrote:
> > On Wed, May 13, 2026 at 12:32:14AM +0200, Aldo Conte wrote:

...

> > > +	cycle_us = div_u64((u64)PSEC_PER_SEC,
> > > +			   (u64)val * USEC_PER_SEC + val2);
> > 
> > First of all, it's one line. Second, the divisor for this function is 32-bit.
> > And at last the castings are not needed. I think I already told these...
> 
> In theory, val and val2 could have a value of INT_MAX. Therefore, the
> calculation INT_MAX * USEC_PER_SEC + INT_MAX results in a value of
> 2,147,483,861,748,364,700, which can only be stored in 64 bits. This is, of
> course, an extremely rare case in which userspace writes an impossible
> frequency that is simply too high.

> Therefore, div64_u64() should be used instead of div_u64().

Yes, exactly my point!

> Therefore, the following code would be required:
> 
> cycle_us = div64_u64(PSEC_PER_SEC, val * USEC_PER_SEC + val2);

You will need casting for val because of 32-bit compilation which will
overflow otherwise.

...

> > > +	wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 2400);
> > > +	if (wtime < 0) {
> > > +		wlong = true;
> > > +		wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 28800);
> > > +	}
> > 
> > Why 64-bit divisions? Do you expect the wait_us be outside INT_MIN/INT_MAX range?
> > This will need a comment and/or dropping the 64-bit arithmetics.
> 
> cycle_us_MIN is reached when (u64)val * USEC_PER_SEC + val2 is MAX and so is
> INT_MAX * USEC_PER_SEC + INT_MAX. Assuming this, the division would be 10⁶ /
> (INT_MAX * USEC_PER_SEC + INT_MAX) = 0.000465661, so 0.
> 
> Therefore, cycle_us_MIN would equal 0 and cycle_us_MAX would equal
> PSEC_PER_SEC/1, i.e. 10⁶; consequently, wait_us_MIN would equal −614400:
> 
> wait_us_min = 0−2400−612000= −614400
> 
> and wait_us_MAX would equal 999999995200:
> 
> wait_us_MAX = 1000000000000 −2400−2400 = 999999995200
> 
> This means that wait_us needs to be s64 if i am not wrong.

Please, add a respective comment.

> > > +	wtime = clamp(wtime, 0, 255);

...

> > > +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_WTIME, wtime);
> > > +	if (ret < 0)
> > 
> > What's the meaning of positive returned values? I think this function never
> > does that. If I'm right, drop ' < 0' parts in all similar cases.
> The i2c_smbus_write_byte_data() function returns a value of 0 on success and
> a value less than 0 in the event of an error. I do not understand this
> comment. Could you please explain it to me in more detail?

As you pointed out there is no meaning of positive returned value as there
should not be a such in the first place. Hence, why ' < 0'? This already being
explained just after the Q in the same paragraph above :-)

> > > +		return ret;

...

> > > +	cycle_us = tcs3472_cycle_time_us(data);
> > > +	data->target_freq_hz = USEC_PER_SEC / cycle_us;
> > > +	data->target_freq_uhz = div_u64((u64)(USEC_PER_SEC % cycle_us) *
> > > +					USEC_PER_SEC, cycle_us);
> > 
> > Okay, this might help with the above... Can you deduplicate this division to
> > a helper with a comment that explains the calculations behind?
> > 
> Something like this could be ok?
> 
> /*
>  * Convert cycle time in microseconds to frequency in Hz and microhertz.
>  *
>  * Given:
>  *   cycle_us = T, i.e. 1 cycle lasts T microseconds
>  *
>  * The frequency is:
>  *   f = 10^6 / T    [Hz]
>  *
>  * We split it as:
>  *   val = floor(10^6 / T)
>  *   val2 = (10^6 mod T) * 10^6 / T   [microhertz]
>  *
>  * I.E.:
>  *   val = 10^6 / T          (integer division)
>  *   val2 = (10^6 % T) * 10^6 / T   (fraction scaled to microhertz)
>  */
> static void
> us_cycle_to_freq_hz(int cycle_us, int *val, int *val2)
> {
>         *val = USEC_PER_SEC / cycle_us;
>         *val2 = div_u64((u64)(USEC_PER_SEC % cycle_us) * USEC_PER_SEC,
>                         cycle_us);
> }

Looks like yes.

-- 
With Best Regards,
Andy Shevchenko


