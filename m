Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA63EAC90
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744980; cv=none; b=BFRjKZTJPvtz3GCCwCkOMHl+4bElV7wVBKVuiAdhHyrODpIwDITRlg4LPpZTwwgjAXVSoIOX9tgj1HvQHndT1R2oi3p+twE6eq/2978tf5DWkmNDmVoegd1fBl0IQybJQFHfVaSDhVPGbF+xhTTGeZ1+DEwYt7JKElv8M9MONKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744980; c=relaxed/simple;
	bh=p0yV+D++iZUs17dmFYRPjhoraGSQ/rneBGiE3X6EIYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq4t9KU2uOtE6DQ65W5Q5kiOWu3In0COq3ZMoQ6DvMe4wRxqYiabfi/ZGcf25AFFAhsraHX+NPBMtGGs5TKNsbl35n2WZLh5B5spPYBOhA9TCnRpjG1Ng/yimJpEN2/lO0EsiX17sphUi+UA0uVao9IvjcvkaNEElRqNdJmP4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL7tu+C+; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL7tu+C+"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13b24ddadedso575773c88.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782744978; x=1783349778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oDOWZLIN22YVy9Zj5Ay7+Ax+yfWAdEYj817p3w4+nyU=;
        b=SL7tu+C+jhN5mEcuUqOwx3eQTTSGE4TYAPNydRhf534TusN4ZnH7S/q6dn/dMdzRVh
         DIuAUmUrbsN1hWtLZZ3/7Zl8UVolVrS5eTCmwUNQt/jAYa1mEIxNnlF58wNBJqflsJXw
         wM/FWBsk4YamwoE//rGiDo2FULuPuPJv2eREIZr7hecBMJ3fOTwmBC44Bg2kB6Ot+l31
         JixAvmkSfDGyVVjTdMj9v5UWuybJsoJcQMhhN9ouc/BUf5R0spVi5wGqjfL4lZV6umzv
         9LqoRwkAb+0AzfrYSLmu+Ss9S5VmfWahKB6gjf7QzCEdhIs6Lzwr1f8FxNN+07FppMcM
         13bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782744978; x=1783349778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDOWZLIN22YVy9Zj5Ay7+Ax+yfWAdEYj817p3w4+nyU=;
        b=gwwDBLmRlCMtmWGU+UaDDXY401erLWw9I7+nMSWaU03zciowX0vEtwd9O50HE/EHtK
         9sHiMD4U06JJcLzbDnR1dmBnW7lSbZ6XyZ/ZbU7xNHLZOIZuPvkm5jzcvNlQMJ+cMKkF
         +13uOIpBBgcXr4Hpa/0dGuCe9D8YFzX9rXJ86YR7nbgsLzb0MARo7+47Z9aidrdYPwdg
         76vha1/bah75u2/3jxlDsPNq526+k5zgEAAsC+elH0D/0u2StHCL0BVr2INafpc7aUBv
         4osnfseeGdyq1g4PGur4r+rIYSQrtQcT0owmshSJnu4osF7V5yfxqn4wUUHPlCStkn2F
         dWgg==
X-Forwarded-Encrypted: i=1; AHgh+RoQDYhJAPg1xrvq3dURhAf2WGRxey25J75H7rGb73OB6NDPmDpXInvMCUd7C/9cBbfs883tD+GQ3DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCo4HaxAyzVKDBWmH6Pws224Iyw8hbytI083pXv3R7PTfkmJ55
	rfVB3fYAeAqtxyS/k3seflLT/lmyKWTSyhmlfKptyQHJIjwHDZQyzV6VWXRUs5zrclo=
X-Gm-Gg: AfdE7cnliP/zH/efIw8ldunZh6v6MQXLCrrBmMELXRi1D8HHc5IUExaHMXX5OBJ06P4
	/aW3svr+xqNYGqw5IILNYGNLCSe8jepjve6J3QfdwO9R7xmSkAB95GAHZKgp0wOrKNpmT6BjNtk
	Lr5Ye58IvH+BzsNpeuXVKwTACHW7F+2KjMLZ64jRurG8BnbQQhka0qEeMPbULDhV8cxdc5LzlMw
	aQeCyzf2A7PFDK5aSHDLYE42UkYjmT4M9zqXu+TVIN3P1CdkPbSSdtaCs8xQBotaj+6yJsI9VN+
	47sgK3ZO3h/7I6Vq7PAQeS3alIXX5jDMqR4rqnw4Yah5Rdam+gtfRzdqfthKbxg0BnBkC+6n9F1
	yNjeFzgSf4hQzMGQPJDoJ710c1ifg9WRMoqb2P+3YOcq6FaD+boNexoDPqvg/yd7I7/WMhQjQ5k
	P0gKZlaxS+MoUFg9BYPOF6Vw==
X-Received: by 2002:a05:7300:7241:b0:30b:9e57:1e6b with SMTP id 5a478bee46e88-30c84dad34amr18734872eec.17.1782744977805;
        Mon, 29 Jun 2026 07:56:17 -0700 (PDT)
Received: from localhost ([2804:30c:1618:8400:e838:86ad:21d4:de00])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52eed6sm44619124eec.9.2026.06.29.07.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:56:16 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:57:03 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, julianbraha@gmail.com
Subject: Re: [PATCH v4 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and
 similar ADCs
Message-ID: <akKHv7j22P6KczXb@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1782397418.git.marcelo.schmitt@analog.com>
 <0abf862eeb277ae82262d09b11b1446f04c47be7.1782397418.git.marcelo.schmitt@analog.com>
 <9c6e0a74-c9c5-43ee-8eca-ae1667c51c32@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c6e0a74-c9c5-43ee-8eca-ae1667c51c32@baylibre.com>

> > +{										\
> > +	.type = IIO_VOLTAGE,							\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> > +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> > +			      (_offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0),	\
> > +	.info_mask_separate_available = _offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0,\
> > +	.scan_index = 0,							\
> > +	.scan_type = {								\
> > +		.format = _sign ? IIO_SCAN_FORMAT_SIGNED_INT :			\
> > +				  IIO_SCAN_FORMAT_UNSIGNED_INT,			\
> > +		.realbits = _real_bits,						\
> > +		.storagebits = _storage_bits,					\
> > +		.shift = (_offl ? 0 : _storage_bits - _real_bits),		\
> > +		.endianness = _offl ? IIO_CPU : IIO_BE				\
> > +	},									\
> > +}
> > +
> > +#define LTC2378_BIPOLAR_DIFF_CHANNEL(_real_bits)				\
> > +	__LTC2378_DIFF_CHANNEL(1, _real_bits, (((_real_bits) > 16) ? 32 : 16), 0)
> > +
> > +#define LTC2378_UNIPOLAR_DIFF_CHANNEL(_real_bits)				\
> > +	__LTC2378_DIFF_CHANNEL(0, _real_bits, (((_real_bits) > 16) ? 32 : 16), 0)
> 
> Why not move the (((_real_bits) > 16) ? 32 : 16) into the __LTC2378_DIFF_CHANNEL()
> macro to avoid repeating it?
> 
Because that would go wrong for LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL() in patch 3.

> > +
> > +struct ltc2378_chip_info {
> > +	const char *name;
> > +	unsigned int internal_ref_uv;
...
> 
> > +static int ltc2378_regulator_setup(struct device *dev, struct ltc2378_state *st)
> > +{
> > +	int ret;
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> > +	if (ret < 0 && ret != -ENODEV) {
> > +		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> > +	} else if (ret > 0) {
> 
> Else is not needed here.
Why not? Intendend flow/logic is to get and use refin for devices that have it
(currently only one chip has). Except for that chip that has 'refin', other
chips have only 'ref' and no internal reference. Also, the chip that has 'refin'
doesn't have 'ref' so it uses an internal reference when 'refin' is not found.
Anyways, the driver can use 'refin' if there is one available, no?

P.S. Will separate regulator logic according to chip type.

> 
> > +		st->ref_uV = ret;
> > +		return 0;
> > +	}
> > +
> > +	if (st->info->internal_ref_uv) {
> > +		st->ref_uV = st->info->internal_ref_uv;
> > +		return 0;
> > +	}
> 
> I would be tempted to have two separate functions here and only call one depending
> on the chip. Otherwise, it allows incorrect devicetree.

Hmm, I see. Drat, I was hoping to avoid checking for specific chip parts to
handle regulators. dtbs_check should error if a chip other than ltc2338 has 'refin'.
Anyways, I see maintainers will probably prefer the chip specific init flow.

> 
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "failed to read ref regulator\n");
> > +
> > +	st->ref_uV = ret;
> > +
> > +	return 0;
> > +}
> > +

Will adjust according to other comments as well.

Thanks,
Marcelo
