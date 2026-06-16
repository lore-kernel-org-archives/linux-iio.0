Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7888E35A384;
	Tue, 16 Jun 2026 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596734; cv=none; b=qGiZ/7DsqaXvtcuba74ogHGHFVu/9KHEMynDs3VYk0nGCJ8ARah4nWB197goaNm2wC9myzlqi7oyt52xzNZots5rgzXXviDb1iwaHiR7svn/7fynI59vU8sdxa2rAqVPGlbUg7YG0+nxh6WD5wKiIF4YmUrejFtRkWt+WeMc0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596734; c=relaxed/simple;
	bh=6qAEEh+Ijcrf4TP+oWKYZYR4HXBhZIOPbloZtqMYjPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhL51dIIadkakNpndw3Y5tnjNeYbcm1Blt2Z5Fmh4Y9Gz7vNlr9ZUibo2PU5012aLh+vGqCLWZO2ufBobgUoJltcuYK8Nk0ro065RVzQaEvwD9MNuwtzKFGWV8F9zdEzvmqenvDfL3j/FK/2UAL/nu9gtY6F/U0ARn9y52wekuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agB/LCCv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agB/LCCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781596733; x=1813132733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6qAEEh+Ijcrf4TP+oWKYZYR4HXBhZIOPbloZtqMYjPM=;
  b=agB/LCCvcVthKlo5vg+H0TLIIQ4JVKPTywxeGbUzO7a5A5iHXD0XlMa8
   H78sCYjoznOOjB9oM3UdoxYl22PRhGnbKytRb2GEO+3aUdVBwAW/NdvoH
   EJlPYCe+kVgEnAcaxMd2GKiVTPSpxYC5wNaoO3/ULBASZ3jzqJNsdgnX4
   BUzqlCS9Uh/1RTWoUjNGzsun8xqYYI2HTuGIzH1sDUvzX2SsYYm2EbJs8
   Fb2Avl9A2vSQG+fGl/IdrXBqlGeFG6H7MKN4muU4zXCzVccwqJf0uq+JC
   936ErdnAjjlDM9ipyATq2G2Ecbw8OShI5D2hueWh8Ax3v4OC/lY5P+aIt
   g==;
X-CSE-ConnectionGUID: IT/2W51mQIKeVWSAWZ+1Kg==
X-CSE-MsgGUID: qiWbljdVRPGt8p7Q8I5XAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82339675"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82339675"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:58:52 -0700
X-CSE-ConnectionGUID: P+O7mjbFSw2SjqCr3dLZkQ==
X-CSE-MsgGUID: hfLzOcoBT0moFV73XKPHYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="245314128"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:58:48 -0700
Date: Tue, 16 Jun 2026 10:58:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: adc: ti-ads112c14: implement gain on internal
 short SYS_MON channel
Message-ID: <ajECNvjntVg_GjwR@ashevche-desk.local>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-3-e6bdadf7cb2b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-3-e6bdadf7cb2b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 05:00:01PM -0500, David Lechner (TI) wrote:
> Implement support for the programmable gain amplifier on the internal
> short SYS_MON channel. This channel is used for calibration, so it is
> useful to be able to set the PGA to the same gain as the external
> channels. The gain setting is implemented via the `_scale` attribute.
> 
> In the future, we may want to support different reference voltages for
> this channel, so the scale_available table is populated during probe
> rather than being a static table.

...

> +	switch (chan->channel) {
> +	case ADS112C14_SYS_MON_CHANNEL_SHORT: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		for (u32 i = 0; i < ARRAY_SIZE(data->sys_mon_chan_short_scale_available); i++) {

u32 here looks confusing. the entire loop can be made readable with a temporary
for the array item I believe.


> +			if (val == data->sys_mon_chan_short_scale_available[i][0] &&
> +			    val2 == data->sys_mon_chan_short_scale_available[i][1]) {
> +				data->sys_mon_chan_short_gain_val = i;
> +				return 0;
> +			}
> +		}

		for (size_t i = 0; i < ARRAY_SIZE(data->sys_mon_chan_short_scale_available); i++) {
			const int *sa = data->sys_mon_chan_short_scale_available[i];

			if (val == sa[0] && val2 == sa[1]) {
				data->sys_mon_chan_short_gain_val = i;
				return 0;
			}
		}

> +		return -EINVAL;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static void ads112c14_populate_tables(struct ads112c14_data *data)
> +{
> +	u32 vref_uV, fsr_bits;
> +	int i;

size_t? unsigned int?

> +	/* For now, assuming we are using 2.5V reference. */
> +	vref_uV = ads112c14_internal_ref_uV[ADS112C14_REFERENCE_CFG_REF_VAL_2_5V];
> +	fsr_bits = data->chip_info->resolution_bits - 1;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
> +		int *scale_avail = &data->sys_mon_chan_short_scale_available[i][0];
> +		u32 gain_x10 = ads112c14_pga_gains_x10[i];
> +
> +		/* NB: slightly odd arrangement to avoid overflow. */
> +		scale_avail[0] = div_u64_rem(div_u64((u64)NANO * 10 /
> +						     (MICRO / MILLI) * vref_uV /
> +						     gain_x10,
> +						     BIT(fsr_bits)),
> +					     NANO, &scale_avail[1]);

Oh, what about temporary variable for the inner division? Also note one trick
to avoid casting (and making it shorter).

		u64 foo;

		foo = div_u64(10ULL * NANO / (MICRO / MILLI) * vref_uV / gain_x10, BIT(fsr_bits));

		/* NB: slightly odd arrangement to avoid overflow. */
		scale_avail[0] = div_u64_rem(foo, NANO, &scale_avail[1]);

Now, with much more readability, it's visible that the first division is just a right shift.

		u64 foo;

		/* ...a comment to explain voodoo calculations... */
		foo = (10ULL * NANO / (MICRO / MILLI) * vref_uV / gain_x10) >> fsr_bits;

		scale_avail[0] = div_u64_rem(foo, NANO, &scale_avail[1]);

> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


