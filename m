Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B34A2931FC
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122914; cv=none; b=rpZhCok9Zss4T0GGUGpeKaiTDM/XgUbisaDt4FK4RqYpqS9NIxQ3g02yEqogYG8k0qvADKT08wrXM6ZAwVyBiD5QjDfo8UgHRUxt3gUeqBaPK/hQQcWg517lG6JCUwHUPltH5PH42JuMHc13htos5UyhqYkxvoZjBfv3s2wkEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122914; c=relaxed/simple;
	bh=NWsisj395JP+1z4yufoJVTcURp+jN+QB/hFD5KExXIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCrU13cvxddV71wNf69BkvPyxoe3EbXvfgX9hwljjfLjTi3i7Pkcen3+dP6w6sSnM5zi50ZmJaLUd0OYd/f1/ayDiEW1Y8T4kbyObDkDnYDdjSWbU5b+zLOgKB8R7n8/8Mww+FfMR16pjGxM11ZB89A4hPOrCCJQThUGGDp8TZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzbxXzFT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzbxXzFT"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b015532f7bso6061966e87.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 06:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122911; x=1784727711; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v3DE9hVd+ZvJ983AY+/WnUOAa2+5necEnKwML6c0SnM=;
        b=EzbxXzFTtO9AoCYDmClew70hsa52iVe/+HLY0eZRSJf1tsl4c7r0HFgjIWrZPZMSpP
         OWIcgHSl/s3zL9YB2ZByGuk/avv2sd23qk7Msl24UOoLG0LNLmhmPMJArqQc9Ap3nX9P
         yW7EAz1XZPeBnzcZff0Vu3hSEji7Mnz1Xlc6nDmRlhw/XnFzKSmVhi9DUPKmxO+3ooiK
         Tylxabkl4sMyH4YDPtgY5PeQEalejwpKPjtzgRP4lnLhHlVGMrhkdus6h9WLAjaRPAHC
         oD9tAbIUyRcCb5r5i9Kb5Qc+NoKaYuM+Dzf9xXuEj8c5EqAxRJWEMlAF1X54sGfbq92T
         /7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122911; x=1784727711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v3DE9hVd+ZvJ983AY+/WnUOAa2+5necEnKwML6c0SnM=;
        b=Gh+5o5oIPG6KGkl0MLL+T9SpF5OEp8XhVG9o10UpVoSbI+32f05WyKIRveG/XnXvrq
         f/yFLpkI22d3od49Ju/uO0gFysns//BPTirPxCUaFdTNtlW0LAA8f+p/DFh3F/JKY4f9
         TsFCayzj6z/I30DTekSns/YhrvPZ3/g5EgSJWtC9Wc9XRCFX21+qBxOfSWlEhdGs+bwz
         MVofh85pne4+ZmV6o705tdMH2RDiJKFpl1E0Gi5BfygK2hL17XIiek+3w3wvmrJldEvH
         lkMEipHKvFjSBTXX1cWNZWT2g6Iv8I+xHoxPoTDEStPvGTYhYN/ycAwkvFSkQzfWK6uk
         Wk/w==
X-Forwarded-Encrypted: i=1; AHgh+RqvqCf8BTR+P362T6NPAH/sDhEgiAIapx0x2YZhEz3s9mmVGFfLqxusudqe7/HxxsZZoTLptm3sUDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GoR/Ady2lIqEaowa3TH557satW76XKTdcixJtsFhibbCQREw
	keGQeXs4nAW/4AY/c23Aqu6ujr/Xfh0DyP+a//QoWTOwwUbBNkKdXZLr
X-Gm-Gg: AfdE7ckrARZEDjlRPmc/QIgvo47YyXtveMHUddRHavNPy8ThV/8n6zVZbQIXR6TAHNM
	JpEndNoRcYzubS89xQy/ADjWi+mlh+Dy3me55Fk2mNbNcSb3t3y0kGDYiZPIuUnJiYLI4IQjnGq
	yPkQp+pvejf5Q04EmbmMLvF5mk19rMXo0I2TFwRi2GeqGcAAx4JUBnEwpkUnVYSkNDTm9epoe7y
	Ubq/4e/Ag71KX541I2KbdC7IYzbb3kXiAH3kf6HFurIAnVVXJW1sDTVwNI+ZpeNWplEWYSoCVxO
	4SaIhKAVif4aqce1TcCD8LOlNySezERBs57HnGdcQq2PcQYikVjxB9GvlpPecSYEQ5AAlsqI9CA
	XbnaEduH4W3lVso8p8dfeHkTMOVKNo8jG7F2hgh9qb1WZ8KklxDCGiMPk7Oejqm/pcaWFLURCRC
	KQnhLYG82yC6H8s3Xa4pgiQrR6gEo=
X-Received: by 2002:ac2:5689:0:b0:5ae:b486:2ef5 with SMTP id 2adb3069b0e04-5b15d7c4ad3mr682247e87.65.1784122909353;
        Wed, 15 Jul 2026 06:41:49 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b023b5931bsm3489996e87.42.2026.07.15.06.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:41:49 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:41:45 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Siratul Islam <siratul.islam@linux.dev>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <4r6grtnbddwtaflsak37y4hlofgiudksd3orxamry6eyhnueky@mg75uai5aeu2>
References: <20260715063652.368501-1-stefan.popa@analog.com>
 <20260715063652.368501-3-stefan.popa@analog.com>
 <aldGAbF4AN8X5CRY@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aldGAbF4AN8X5CRY@ashevche-desk.local>

On Wed, Jul 15, 2026 at 11:34:09AM +0300, Andy Shevchenko wrote:
> On Wed, Jul 15, 2026 at 09:36:17AM +0300, Stefan Popa wrote:
> > The MAX40080 is a bidirectional current-sense amplifier with an
> > integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> > voltage across an external shunt resistor and the input bus voltage,
> > storing the results in an internal FIFO.
> > 
> > No existing IIO driver covers this device or a register-compatible part.
> > The closest relatives target different silicon with incompatible register
> > maps and feature sets: max9611 is a unidirectional high-side sensor with a
> > die-temperature channel and MUX-selected gain and no FIFO/PEC, while
> > max34408 is an 8-bit multi-channel current monitor. The MAX40080 has a
> > device-specific register map with bidirectional 13-bit current, a 64-entry
> > FIFO, PEC, a single-measurement mode triggered by an SMBus Quick Command,
> > and two selectable input ranges, so it warrants its own driver.
> > 
> > Add a direct-mode IIO driver exposing the current and voltage channels
> > with raw and scale attributes, a configurable oversampling (digital
> > averaging) ratio, and PEC-protected register access. The two selectable
> > current-sense ranges are exposed through scale/scale_available; the
> > current scale is derived from the shunt-resistor-micro-ohms device-tree
> > property.
> 
> ...
> 
> > Link: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX40080.pdf
> > 
> 
> No blank line here, in a tag block. Also you can use Datasheet: tag
> (but it's up to you).
> 
> > Co-developed-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> 
> ...
> 
> > +MAXIM MAX40080 CURRENT SENSE AMPLIFIER DRIVER
> > +M:	Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > +M:	Stefan Popa <stefan.popa@analog.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> > +F:	drivers/iio/adc/max40080.c
> 
> David usually asks this to be split between patches to avoid "orphaned" files
> from the MAINTAINERS perspective.

I think checkpatch also complains if you do it like the above.

- Nuno Sá

> 
> ...
> 
> > +/* Current is a 13-bit two's-complement value (magnitude + sign bit). */
> 
> Please, choose a single style for _one-line_ comments, id est
> period in all or no period, capital first letter in all or small letter.
> 
> > +#define MAX40080_CFG_MODE_SINGLE	0x02	/* one conversion per Quick Command */
> > +
> > +/* CFG.range field values */
> 
> (Three comments on one page of code and three different styles.)
> 
> ...
> 
> > +	u32 shunt_resistor_uohm;
> 
> I think this also would be good as uOhm.
> 
> https://web.archive.org/web/20250629194735/http://poynton.ca/notes/units/
> mentions this:
> 
> "... except that its initial letter is capitalized if the unit is named after a person."
> 
> ...
> 
> > +static int max40080_trigger_measurement(struct max40080_state *st)
> > +{
> > +	struct i2c_client *client = st->client;
> 
> > +	return i2c_smbus_xfer(client->adapter, client->addr,
> > +			      client->flags, I2C_SMBUS_WRITE, 0,
> > +			      I2C_SMBUS_QUICK, NULL);
> 
> Perhaps even
> 
> 	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> 			      I2C_SMBUS_WRITE, 0, I2C_SMBUS_QUICK, NULL);
> 
> > +}
> 
> ...
> 
> > +static int max40080_read_iv(struct max40080_state *st, u32 *iv)
> > +{
> > +	int ret, io_ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	ret = max40080_trigger_measurement(st);
> > +	if (ret < 0)
> > +		return ret;
> 
> What I meant is this
> 
> 	u32 tmp = *iv;
> 
> 
> > +	/*
> > +	 * Wait for the conversion to complete by polling the FIFO valid bit
> > +	 * (or bail out on an I2C error). Polling the device's own status makes
> > +	 * this independent of the actual conversion time, which varies with the
> > +	 * oversampling ratio and the bus speed. The timeout is only a safety
> > +	 * ceiling: the worst case is the maximum 128x averaging on both the
> > +	 * current and voltage channels at the slowest 15 ksps base rate plus the
> > +	 * inter-channel switching time, i.e. roughly 20 ms; 50 ms leaves ample
> > +	 * margin.
> > +	 */
> > +	ret = read_poll_timeout(max40080_read_iv_once, io_ret,
> > +				io_ret || (*iv & MAX40080_IV_VALID_MSK),
> > +				1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
> > +				false, st, iv);
> 
> 	ret = read_poll_timeout(max40080_read_iv_once, io_ret,
> 				io_ret || (tmp & MAX40080_IV_VALID_MSK),
> 				1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
> 				false, st, &tmp);
> 
> 	/* ...the comment why we need to update iv even in error case... */
> 	*iv = tmp;
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	return io_ret;
> > +}
> 
> ...
> 
> > +static void max40080_calc_current_scale(struct max40080_state *st)
> > +{
> > +	unsigned int i;
> > +	u32 rem;
> > +	u64 tmp;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(max40080_csa_gain); i++) {
> 
> 	for (unsigned int i = 0; i < ARRAY_SIZE(max40080_csa_gain); i++) {
> 
> > +		tmp = (u64)MAX40080_INTER_VREF_mV * NANO * MICRO;
> 
> I would even make another temporary for the numerator and denominator.
> 
> 		u64 numerator, denominator;
> 
> 		numerator = (u64)MAX40080_INTER_VREF_mV * NANO * MICRO;
> 		denominator = (u64)MAX40080_ADC_RES * max40080_csa_gain[i];
> 
> // Also possible to use a trick "1ULL * " instead of castings.
> 
> 		numerator = 1ULL * MAX40080_INTER_VREF_mV * NANO * MICRO;
> 		denominator = 1ULL * MAX40080_ADC_RES * max40080_csa_gain[i];
> 
> > +		tmp = div64_u64(tmp, (u64)MAX40080_ADC_RES * max40080_csa_gain[i] *
> > +				st->shunt_resistor_uohm);
> 
> 		tmp = div64_u64(numerator, denominator * st->shunt_resistor_uOhm);
> 
> > +		st->current_scale[i][0] = div_u64_rem(tmp, NANO, &rem);
> > +		st->current_scale[i][1] = rem;
> > +	}
> > +}
> 
> ...
> 
> > +static int max40080_oversampling_to_filter(int val)
> > +{
> > +	for (int i = 0; i < ARRAY_SIZE(max40080_oversampling_avail); i++) {
> 
> unsigned int ?
> 
> > +		if (max40080_oversampling_avail[i] == val)
> > +			return i;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> 
> ...
> 
> > +	if (device_property_present(dev, "shunt-resistor-micro-ohms")) {
> > +		ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> > +					       &st->shunt_resistor_uohm);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "can't read shunt-resistor-micro-ohms\n");
> > +		if (!st->shunt_resistor_uohm)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "shunt-resistor-micro-ohms must be non-zero\n");
> 
> You can reduce data footprint by string literal deduplication. That's why in my example I used
> 
> 	const char *propname;
> 
> and respective assignment. Currently you have three copies of the property
> name: two in different error messages and one as a parameter to property APIs.
> 
> > +	} else {
> > +		st->shunt_resistor_uohm = 1 * MICRO;
> > +	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
