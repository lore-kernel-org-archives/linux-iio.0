Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93859369980;
	Sat, 18 Jul 2026 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784357796; cv=none; b=hgNjXSagzs8NCm4y0mSiL5O+paj5bdrDkhoOwlUSO1Tw67OyDuweNqyTYGCzI4fEEU3B1p0cXSJpsu/Qk5AnxVJqkmXQNFEBNFrJDFxOZVtZb3irhRu7nKPHvqzFGgvChAsrTBlsgtBzF4NcFckZamrmCKjf7kXzzFzXk9+pT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784357796; c=relaxed/simple;
	bh=fpZKYx4t8aho1pYFI8QxHjvgDRauRrTRTzr1s5bxysI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ3vG5qUvq/3xXIepyV+7fOXBg3+m0/g2/TQek7ccejcE7QeadJaH9fXNu/9HaVmammFAuuStGJC53+OiagU7ePTLF1IUmHx8XaM7U3WTVYGkTrPsRanu56XaDKPMza6MsTN+UmvoxxMa95B11Dsu2qZ5qyqO1yhnVAx9D/o4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTl5Kq0W; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTl5Kq0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784357796; x=1815893796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fpZKYx4t8aho1pYFI8QxHjvgDRauRrTRTzr1s5bxysI=;
  b=HTl5Kq0Ww4ukp9r5XkyJ/IZUA+nstkPzJzmvDFk5NwlJ6kbIpdj+Zi3A
   7izOxyXubfqPZpAhKW3in3VmnVwqByi4qBW2b5zdk+xa80JGHTMq2MNVn
   h2sE99k6dHtggAQxWenkLMyme83YwelfSK1ttMwF7vA6tgXfnDbWTnsje
   02q2Xi0GsejCj9JJMtxDDI7TMFyUXbIEpfma79eLoMq+y1yg4koOykSnQ
   vdJM75etSZ0g5zVAiW88yh9i9xlESufO0x32uTDC1DE/rBnDWKIx06hR5
   qJu1lxi0kjDhcH2ttnojraK1GQCZFUiGqK5I8WW7Ty/17nzPHjNnFwYpT
   g==;
X-CSE-ConnectionGUID: 03WR6STxQCWICdCMpkpfUQ==
X-CSE-MsgGUID: 16zrn2czQRyigF2Pd3yA/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="102569156"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="102569156"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:56:35 -0700
X-CSE-ConnectionGUID: ZdLhnlPlQg6R9njqmlrb2Q==
X-CSE-MsgGUID: BVDzW+AVQkCOtxA6c0+vlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="295165354"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:56:31 -0700
Date: Sat, 18 Jul 2026 09:56:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, linux@analog.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <alsjndog518gToDA@ashevche-desk.local>
References: <20260717201138.1078019-1-shofiqtest@gmail.com>
 <20260717201138.1078019-3-shofiqtest@gmail.com>
 <alsjNBDgHm9fkp3c@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alsjNBDgHm9fkp3c@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 18, 2026 at 09:54:50AM +0300, Andy Shevchenko wrote:
> On Fri, Jul 17, 2026 at 11:11:37PM +0300, Md Shofiqul Islam wrote:

...

> > +static int max86150_read_one_sample(struct max86150_data *data,
> > +				    u32 *ppg_red, u32 *ppg_ir, s32 *ecg)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_noinc_read(data->regmap, MAX86150_REG_FIFO_DATA,
> > +				data->fifo_raw, MAX86150_SAMPLE_BYTES);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*ppg_red = (data->fifo_raw[0] & 0x07) << 16 |
> > +		    data->fifo_raw[1] << 8 | data->fifo_raw[2];
> 
> Use get_unaligned_be16()

Actually it should be get_unaligned_be24().

> > +	*ppg_ir  = (data->fifo_raw[3] & 0x07) << 16 |
> > +		    data->fifo_raw[4] << 8 | data->fifo_raw[5];
> 
> Ditto.
> 
> > +	*ecg = sign_extend32((data->fifo_raw[6] & 0x03) << 16 |
> > +			      data->fifo_raw[7] << 8 | data->fifo_raw[8], 17);
> 
> Ditto.
> 
> > +	return 0;
> > +}

-- 
With Best Regards,
Andy Shevchenko


