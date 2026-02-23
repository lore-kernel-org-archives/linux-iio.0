Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93203612F4
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859305; cv=none; b=OugWhL3fYvQKDzLNxks0fUFI9GVfuakP9SNJHq5kf92m67Rl8uw335uXGWayf7wE/8/wrtwBgg7vfNRFp3Bv7LPf2Ek/ivmBX4QDF6dYpmNHLZbsBojCJKIOAVNMXGDF77TSOqVDzDf+ypDPS1F3ameddVkBkyrnmVcqeN+dNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859305; c=relaxed/simple;
	bh=JTIUPgwETZRXvFjrA1P5pCHV9Og5U7zf3qDfiYw2YXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieSaZTxiYvEDi4kBS0faG5ikLNr9WJBwwRa3ghdzyI3NHowuz85V2XIKwg2f21lmkikeNT2W4Kh0uLj7rqYpXlfoaQUDFdP59q4UrCpPz3T9X7KvhiR2G2HsLCgHKrwt3UgctcS+/29MvH3d2b/gSx7nwlQJHnRfnpPeO8ygqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQY6Zf1V; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQY6Zf1V"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-566fe6a4ceeso2145907e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 07:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771859303; x=1772464103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JDkTFfTBFUmp0tr3dEyVOuaf9ziHidjokc5/wP5SDcE=;
        b=eQY6Zf1VOXe0lhWB8oL5PbUAytRuIZ2HuHZPxWrHA4uJEldUS6OhbwyKtFXSMYACxB
         H2SGhGJUU0VoxWG1Y9MhQQZHYKSDpI5GP5YVs1yZjEx7JdibyHEbKVRy3Tgo7m5HUfVx
         8ajR2eA+SlQ0R8YtjO74bg9o+GJI910fZwiu5C+/1TSdN0WoSySaI+1JIY9GShUZ33kO
         0oW1g9RAKKp8X0WQ5fZNT0oHrJfJkTdYOL4wgG1BFDgmGbItlmQ+Zikiq52oKBDnzBas
         fI2nYpUxwtiisSdsKPg7AlLiIVHkDnORm/phx2H7+tdX0UCn5DliQvyPclqokhFtuF37
         LdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771859303; x=1772464103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDkTFfTBFUmp0tr3dEyVOuaf9ziHidjokc5/wP5SDcE=;
        b=ODKMGjOipS/s8Rlza9AtcHOjYg8EEQTJkRj0TKCK7gC5T70mFSIicql+GSFvvzhNNw
         1k1CSYIMI8dl6n02ELkLcH0IVlQmL6lSp17SSeRZBMaecMjqnku2NrxRyahVh2jMOxrB
         MWfjDtG5voKQslLV0ZtTvq6N1ZswpET/051BzLeubiVZ5E4Zi0XdWyHlhDf3NxZ1dEV4
         JniGb26Ei8mtSh9YgncsI54x1PeA1ZC/hyr0lNw0oe8Wt8T0grqkRh/BzUwf29aK8I7R
         3fDiODrTVAXiCCqSnvr5yVJYIgdrCHHJA+UaagmRQddpwIpjSDAFRg/Ff9FpNCVEx2UW
         /ipA==
X-Forwarded-Encrypted: i=1; AJvYcCXfdyjZhnk9726Sy2OjcJ/J8lbC7uwky94K+GXgbicjwHuWrrEg7Gqp6pvXX7ryuIeWC8LIGEQW5EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySuPuI0J6wVvFcKje2nw8BUOnsVy7sASkRwis8G5O8c5l+OnPh
	VEMOr6V7Eio7nlhOM5ThkUU9k6P9vO2YNF5IRngKitEWMNm4F3+37coK
X-Gm-Gg: AZuq6aJ2KG1L08YC9Tm+d/1bPKLkqcYRyT0/Cgd/SikKuapjiNi8I1BZMifj6mx9rJh
	QC3oV+yML06wIYmOdClgK+cLxrJEhRoAi3axLsC39aT7rkUxGdrV3AOA5MetehMKEwOvtAIUeOi
	gEtK4Ssqc4/m4s2MFtV8YFQ7J3rccEUb70jrQ42EU73rUj1iHYFPSRRDPLk+RoMU6H1JqJvijXe
	rsuCoeLMS7lwIHErc3MWNaID03s1co8tn5uZ/Sj0PrjA++aFM1liE96/iztnlhkKFEhFFfbIY+h
	ejIYtoxi9tXWqp03Vake2cmpWKwMl8LPid9mcZwKKiRWCYeXSAfP2LEiIIVmpFbKQlwe9+739+x
	qNZ9/8Ww+LIYUImlaPeKHCCZs2b7V5myLgWBTGt5/UY9SeopfpNMOH0giJ4f+uQ3d6/zaX9y/gL
	RL5bi5Jrq9OJpV8betjhgRozxJ8fjmgN0=
X-Received: by 2002:a05:6122:e448:b0:567:4aec:a27c with SMTP id 71dfb90a1353d-568e48f3255mr3176975e0c.17.1771859302694;
        Mon, 23 Feb 2026 07:08:22 -0800 (PST)
Received: from localhost ([2804:30c:b55:d700:d4af:2146:3fd9:d3fd])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568e579c2ccsm9083635e0c.2.2026.02.23.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:08:21 -0800 (PST)
Date: Mon, 23 Feb 2026 12:08:52 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v9 5/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <aZxthMvaSR3zhZD8@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1771253601.git.marcelo.schmitt@analog.com>
 <20f1dc8eb6bb692eb6eb814a49e54309d973a9e4.1771253601.git.marcelo.schmitt@analog.com>
 <20260222125703.00e3152a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222125703.00e3152a@jic23-huawei>

Hi Jonathan

On 02/22, Jonathan Cameron wrote:
> On Mon, 16 Feb 2026 12:00:39 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> > samples per second (MSPS). Not all SPI controllers are able to achieve such
> > high throughputs and even when the controller is fast enough to run
> > transfers at the required speed, it may be costly to the CPU to handle
> > transfer data at such high sample rates. Add SPI offload support for AD4030
> > and similar ADCs to enable data capture at maximum sample rates.
> > 
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
...

> > +static int ad4030_pwm_get(struct ad4030_state *st)
> > +{
> > +	struct device *dev = &st->spi->dev;
> > +
> > +	st->cnv_trigger = devm_pwm_get(dev, NULL);
> > +	if (IS_ERR(st->cnv_trigger))
> > +		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
> > +				     "Failed to get CNV PWM\n");
> > +
> > +	/*
> > +	 * Preemptively disable the PWM, since we only want to enable it with
> > +	 * the buffer.
> > +	 */
> > +	pwm_disable(st->cnv_trigger);
> 
> Feels like there should really be a way to get a pwm disabled in one call
> so there isn't an edge case of it being on briefly.
> I'm a bit surprised it defaults to on.  I guess this is because DT can provide
> the parameters?
> 
Not really. DT doesn't specify any initial state for the PWM. It might, though,
be left enabled if another device was using it previously. Not a thing I've
ever seen during tests, but it may in theory happen.

We may have devm_pwm_get_disabled(). In IIO, ad7625 and this ad4030 would be
the users of such interface. Would you like me to propose that one?

Thanks,
Marcelo
