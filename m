Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795304919;
	b=pZ60lk4/OA1TqliZioMdy38t6RTlehRUVqTpVBU8o6mKZ4UtUL+pwmtL1Kotq2GvmbV+
	 9mbZbMp0olGYFRToejk+8lPaYsvFC8KE3+P/0fq9rHYe0PICB/pvdzlFKFYOoBqH+u3KR
	 t0ulx4YjawHnFaVL1QkgXSdwY/luS6dyE95FiaNV3ovqGWbpVwk+FOvjw/x3qfxyQSD3W
	 +Ue1cfWgORaJHAUdkLapOtQ29U3yzfehykLU5HDkRlrBrCQ0pd+N6ctbgG2h0D9vNE5Ha
	 g23IPz4ewDeGAethxH6xuzgIZ8l0nqbWfXdVUD9CXjNBKLyoBMR7egkvtVkhOX9eUnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795304919;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=P2+gMfqO0KssqpNjQGC0vCpucpH4dNEAtZrSlgFvnt4=;
	b=ZZH4uyYdcD+mNAY7GnsZjjwR8puZ2gDHU6KegLcE4OQfYxyPWonZUzFeufQ8xOfHtJqb
	 XlbwwjR8ZbaCNTqJ4lPHau43Onloj96OTK1ysqyQfVy7CjA70/EKOz/L5srsNEN2DPCcy
	 y37Pg+T1W+X+aVSpTLK7dUaAx3iWDsclK+h5v4u9kFq0w1vIjR+rwQhTnwS8y609xFFtK
	 Rcrkb0HZoTqaVBRcUFMScXuOeq8kiW00mdTwkZFuADj9xW8agAzp6dDOtuol2YIoH0VDV
	 MUdmPC4e2C3usa1z5I9yVW4SnQ2KUBbe8KZ0t7NxYMREYNRkWoyBS1pkGw2fOmW/E1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knMw2ljz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834D606A320;
	Sat, 21 Nov 2026 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knMw2ljz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FDC1F000C0;
	Sat, 21 Nov 2026 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795304918;
	bh=P2+gMfqO0KssqpNjQGC0vCpucpH4dNEAtZrSlgFvnt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=knMw2ljzEPoxTgT12+zM4j0dFwPHs5T8TFwVaUzsOGDnoHxviHVRURu/K2Lfvbmqr
	 q5GYnkB7bux2e2WFC3rJxZSyz3qhW6ai75yHknHbO2xrRiE1+jNf0I7Rau5kcNrEXm
	 fLGERKL1XQnssG5ogoygccZRG82QuAeT4K7FpLoHXD7UaPiWBq2LCMyzW8jbpuKInp
	 jeCSfe+h834bCjDXWlTskiiCDmbQOMTBKykajNkhrGbzHDfCq0BE4lGOOauZD4Hnix
	 MwXuoMRij/lwA9m+l3tWWDoN2yngTziqoJheWjWSXhtsNoZe7AXGkdwjxmPlJzkuSI
	 Jhp0T2boszZrQ==
Date: Sat, 21 Nov 2026 23:48:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, "Trevor Gamblin"
 <tgamblin@baylibre.com>, Joshua Crofts <crofts@kernel.org>, "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] iio: adc: ad7625: add LTC2387 and ADAQ2387x
 support
Message-ID: <20261121234834.2f6cc9bf@jic23-hlaptop>
In-Reply-To: <20261119112437.197306-7-Nicolae-daniel.Deaconescu@analog.com>
References: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
	<20261119112437.197306-7-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 13:24:20 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> Add the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 as chip
> data of this driver. The same two PWMs and IIO backend are used to read
> from them. See the binding patch for how they differ from the existing
> parts.
> 
> The CLK burst of a conversion starts at least t_FIRSTCLK after its CNV and
> ends at most t_LASTCLK after the next CNV, so the sampling period is raised
> until the burst fits, instead of being clamped to 10 MSPS. Waveforms are
> built in whole PWM steps, read with pwm_get_waveform_step_might_sleep().
> 
> The scale is divided by the gain of the ADAQ front end.
> 
> Add new maintainer entries.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>


> diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
> index 127441050687..8ddd18e45c8a 100644
> --- a/drivers/iio/adc/ad7625.c
> +++ b/drivers/iio/adc/ad7625.c
One minor thing inline. Looks to be a good shape. Thanks

Jonathan


> @@ -498,8 +822,40 @@ static int devm_ad7625_pwm_get(struct device *dev,
>  	return 0;
>  }
>  
> +static int devm_ad7625_listed_regulator_setup(struct device *dev,
> +					      struct ad7625_state *st)
> +{
> +	int ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, st->info->num_supplies,
> +					     st->info->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable supplies\n");
> +
> +	/* VS- of the ADAQ modules is left out if it is tied to ground. */
> +	ret = devm_regulator_get_enable_optional(dev, "vs-n");
Does it hurt to just a non optional call here?
You'll get a stub regulator that will do nothing. That seems to make
little difference vs carefully handling the not present case.

The optional stuff only really comes into its own when we want
to do something else instead. It doesn't matter if we are ignoring
the lack of presence.

> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable VS-\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (ret == -ENODEV) {
> +		/* Without ref-supply the internal reference is used. */
> +		st->vref_mv = AD7625_INTERNAL_REF_MV;
> +		return 0;
> +	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
> +
> +	st->vref_mv = ret / (MICRO / MILLI);
> +
> +	return 0;
> +}


