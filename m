Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086413;
	b=Id5sTJ54GHQROOvFp3abd+dsdOqrFdEx9H+ngu0kz+B4ZsTGs3TLtwJCqF6nlLYVCGwM
	 xxIHhmbOJJCpuO2IG8bJG32rLIVou0pyp9zTv5D8R4b+iVWnwnpdK/JKnr4fAsq6d2njq
	 xouRLK8qv81ZdbQhKVJwXsh9OGf09SXdYjJHquuw85GGWw1ZOVxlfPvUvi0KZTdYetXyc
	 uVI3ox/TFbwZM0vjGg9xqs2U8LKfW0BDXdR15tjq9YdF3spPz8egtsphktVzxW8yms9M+
	 EtNDmRxdcpsP3ParzpQCD59OLNaNMVC5EceStCTS68EhRrpIvnJXK8ZrBvYfs1FPx8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086413;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=c4asv2oLk9Lr3sJYos/ifsYQ9GPfjFMZTnHiWhziWyg=;
	b=GaPJ4/HYkWb8HWWMHpCr7DF76QQ8gGfN6fquPmwNClEL0LO2whHqabLnoz5JGaSom5Bq
	 beXs2Qlcrkw211z5rZIo0ceP0O98PgeCxRSLVusr5SyQccTP0YT+df7yZcrZXcluDF0kc
	 p+TVgCZTDhcvsrKU7qbNfM6LJh4ad6PQLLCqTxPF41LdD7XNq0GaSTsf7BgdUkXrYg5le
	 3olenHogGblLmNgKuiPLdZejUOfzKpWi6qB9/R9qRpArpFsoOZsOXj5ZVmJzzDujyhlI0
	 KtM6J6EwEU2CPnmOdlWMMEQe8HKQ1jmFOuCSVuumHRZ5Od6mQGy6Kv9Kzcs+kMxBVuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="W4/QDgCK";
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F956606A31B;
	Tue, 27 Oct 2026 07:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F956606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W4/QDgCK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793086412; x=1824622412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6jciHiMHy1GGQ8JHzB5fQMjbZGta+3V23LC6ekMKTgM=;
  b=W4/QDgCKgDOvqlxUSEqyfQc1+M06Qr8m9K1ZmyqlEQb7MZQhPkZ/G8/v
   PTv0CO3358VgON7hHbVljOx+kfacOqEi0fSgvoqKjfH8ayRPaxpXAcE4F
   tUvO8alvXEaN8gEElgyzbbOexH5PF/oWYhn4a1Vfmkv7IpHkc/OjrgXBx
   JR4qnIVLEZxvw22gWst/UImYPEjJmYImnMgSUfE0UAc0QAYZZnFs5m01Z
   QELSogg+I4I2C27LfZb1gqR3rUfKSQz0nqLU15xaIE0QFrjG4JD+0azP6
   +9cNCmaquVDxuqrqQE9odvSbEfLs+3CT532d4TkEO7eHTiWzw/mjzYkES
   g==;
X-CSE-ConnectionGUID: h8wXG5i/RWiE7eoFlhUHxQ==
X-CSE-MsgGUID: PMxiTs4rTjO84nmE1vXgVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1801366"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1801366"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 00:33:31 -0700
X-CSE-ConnectionGUID: T09RbCoZSwGarkr+NdcJKg==
X-CSE-MsgGUID: 2AveHeL8S6+7dzuDmtOdFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4428777"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 00:33:29 -0700
Date: Tue, 27 Oct 2026 09:33:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <auBTxjakiTKn1LL_@ashevche-desk.local>
References: <at-0cXiBV0RM-Att@ashevche-desk.local>
 <SN1PR12MB2528986412BA8C9716B3F87FA5602@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528986412BA8C9716B3F87FA5602@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 09:13:25PM -0500, Victor Chernyakin wrote:

...

> > > +		/*
> > > +		 * Now read the two registers making up the measurement.
> > > +		 * The datasheet says to read MSB first, LSB second.
> > > +		 */
> > > +		ret = regmap_bulk_read(map, FDC1004_REG_MEASn_MSB(0),
> > > +				       reg_vals, ARRAY_SIZE(reg_vals));
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		*val = (sign_extend32(reg_vals[0], 15) << 8) | (reg_vals[1] >> 8);
> > 
> > We still have two shift operators, so it might be not a bad idea after all to
> > have a combined variable with wordswap done in case of LITTLE_ENDIAN
> > architecture. Jonathan, what do you think about this? Reading the whole set as
> > 32-bit value and convert it if required
> > 
> > 		// also note in this case we don't need to have _MSB in the name
> > 		ret = regmap_bulk_read(map, FDC1004_REG_MEASn(0), reg_val, sizeof(reg_val));
> 
> I agree we could drop the _MSB if this was the only use
> of FDC1004_REG_MEASn_MSB, but we use both _MSB and _LSB macros in the
> volatile register table definition, and it would be weird to have one
> macro with _LSB but the other without _MSB.

You can have three!

> > 		if (ret)
> > 			return ret;
> > 
> > #ifdef __LITTLE_ENDIAN
> > 		reg_val = swahw32(reg_val);
> > #endif
> > 
> > 		*val = sign_extend32(reg_val >> 8, 23);
> > 
> > 		// I assume the following is also possible in this case
> > 		// *val = (int)reg_val >> 8;
> > 		// but usually we use sign_extend32() in IIO even when simple
> > 		// casting is okay
> >
> > This also reduces stack usage.
> 
> AFAIK a good optimizer should be able to see that reg_val and reg_vals are
> never live at the same time and reuse the same stack slot for both (whether
> GCC or Clang actually do that for this function, I can't be bothered to check).
> 
> If you and Jonathan prefer that version for other reasons though, I can
> switch to it.

I gave an idea, I would wait for Jonathan to judge on it.

...

> > > +static const int fdc1004_calibbias_decomposed[] = {
> > > +	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
> > > +	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
> > > +	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
> > > +};
> > > +
> > > +static const int fdc1004_calibscale_decomposed[] = {
> > > +	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
> > > +	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
> > > +	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
> > > +};
> > 
> > We still haven't decided on this one. I think the 2D array is better for these.
> > And with the above we effectively have a duplication of the tables.
> 
> I don't like the duplication either, but I think the real problem here is
> that read_avail is just a somewhat awkward interface that doesn't allow me
> to return s64 values directly. To me, having this separate decomposed table
> just for read_avail and otherwise working with s64 values is the least bad
> approach.

What about adding .read_avail64() (in a separate change)? Problem solved!

-- 
With Best Regards,
Andy Shevchenko


