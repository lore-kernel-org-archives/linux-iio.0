Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF9C375F69;
	Thu, 13 Aug 2026 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610078; cv=none; b=qk40jn9vjIqwbWT0K1e3bcEAANKBoVb0ltmoP+YamOmvnI3+xKGLCqKMXIW/54cUCT0Vqh1K0wXlMFiSNWSrrDZEgcJmdiDNP02ycmQJq/SRknVyrM5o2FbpdHb98ocFWfuRUPnyhu67HKjJKdv/tzErsO2MDwuaa++04hacwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610078; c=relaxed/simple;
	bh=rCRNjIuldz0xhhG8g60oFPeTCdiYi/d8FgZDAFJT6vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG7rnPsAtPLmtl3thHSUdONf1plff3ycJL7u3/6FBRiq76tUwLp1yPb8dj2X5mIYTYS3bNCHKG+2lyCH526okpf6fmQr24yAJrnTc5zR+gI2AqpPhxGCD9mUmbz2lGpH2FHIjhJ+EeyozRz/J++oo5kRjHqYopwvBsn7vLI8ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ui2ZQIXb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ui2ZQIXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786610077; x=1818146077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rCRNjIuldz0xhhG8g60oFPeTCdiYi/d8FgZDAFJT6vI=;
  b=Ui2ZQIXbkHQisd6NtO0uBF+QxKu86VxrrdaM5eX42cGe7axPvXJwuDyb
   N9XWU7t4aiCFSaXV+F763FXltcdxxlGTdmMQHgFscbpnGahA15aSteFMt
   yzBDkBInUuCMHsHgt/L5TkSn6Dcn7x6BfbP1Jyez2DRuXextg2b+pW4nc
   emqv+/SHRH24qIApptoyJb2Q2RFH+f71DJhylVHkiKKRILvoPAxj4S5KH
   TVe8Q3M+9UpedNMwWxslIDtknp9KRLWiSrbmDd1xi9YyHdcIqVAOlT0UW
   cB+03zchUop2qWlBIHvesOUqfZdFY7be2GgToGF/AKJhtDEvSib4WYXjN
   Q==;
X-CSE-ConnectionGUID: gmCnH/XxS6aGVtQQvcqxXg==
X-CSE-MsgGUID: eOyEm/bbTvChnkz90JnIkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87395150"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87395150"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:34:37 -0700
X-CSE-ConnectionGUID: d6UBiZVARGiKc3EzKFPmWA==
X-CSE-MsgGUID: W+/IXHegSPWkT4rYOk4Xcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="267728343"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:34:31 -0700
Date: Thu, 13 Aug 2026 11:34:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] iio: light: veml6031x00: add support for
 triggered buffers
Message-ID: <an2BlFKOpmxb4TqD@ashevche-desk.local>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
 <20260812-veml6031x00-v6-3-7eef6e4ce290@gmail.com>
 <20260813020958.5fc3f0da@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813020958.5fc3f0da@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 02:09:58AM +0100, Jonathan Cameron wrote:
> On Wed, 12 Aug 2026 22:27:42 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

...

> > +static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *iio = pf->indio_dev;
> > +	struct veml6031x00_data *data = iio_priv(iio);
> > +	IIO_DECLARE_BUFFER_WITH_TS(__le16, scan, 2) = { };
> > +	unsigned int i = 0;
> > +	int ch, ret;
> > +
> > +	if (test_bit(VEML6031X00_SCAN_ALS, iio->active_scan_mask) &&
> > +	    test_bit(VEML6031X00_SCAN_IR, iio->active_scan_mask)) {
> > +		ret = regmap_bulk_read(data->regmap,
> > +				       VEML6031X00_REG_ALS_L,
> > +				       scan,
> > +				       2 * sizeof(*scan));
> I don't care that much, but you could combine parameters on one line in
> a few more places to reduced the code length a little.
> e.g.
> I'd be tempted to put the two lines above on one line or even
> 
> 		ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_ALS_L,
> 				       scan, 2 * sizeof(*scan));

I usually suggest to combine that with

	struct regmap *map = data->regmap;

so it will become

		ret = regmap_bulk_read(map, VEML6031X00_REG_ALS_L,
				       scan, 2 * sizeof(*scan));

> > +		if (ret)
> > +			goto done;
> > +	} else {
> > +		iio_for_each_active_channel(iio, ch) {
> > +			ret = regmap_bulk_read(data->regmap,
> > +					       iio->channels[ch].address,
> > +					       &scan[i++],
> > +					       sizeof(*scan));

And here it will help

			ret = regmap_bulk_read(map, iio->channels[ch].address,
					       &scan[i++], sizeof(*scan));


> > +			if (ret)
> > +				goto done;
> > +		}

But I would even go with

			ret = regmap_bulk_read(map, iio->channels[ch].address,
					       &scan[i], sizeof(scan[i]));
			if (ret)
				goto done;

			i++;

> > +	}
> > +
> > +	iio_push_to_buffers_with_ts(iio, scan, sizeof(scan), pf->timestamp);
> > +
> > +done:
> > +	iio_trigger_notify_done(iio->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}

-- 
With Best Regards,
Andy Shevchenko


