Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D8358D32
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725759; cv=none; b=A124l3zRjVgwg++YQdGr9u/6CcmtihTnn/Blifg9MlR9coSZZepN98IIpxmBnAiOeQCypboDMMs2OBueRv2cEI5q+4UuG4ZpgCc7BQH0jmBnbQzbEtp9Z1Ir1/brDfF7cJY3N1IwUkC2oJqvF1snWW1L6obHcg4e137WHBaXVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725759; c=relaxed/simple;
	bh=lVWirDgq9jhdWkcO+jSEW4AhtGfzyoSiUVzr4lC+M50=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:Mime-Version:
	 References:In-Reply-To; b=NcAMk7YuoygydLfz88dbAJp5Q50DAiSFEXh8FRshbSZVYXCvct2GxETaVa2hDijf/F7Opu0ZvmK19+hbSLrTLMxaWBZlcYYhoEQZ5g4qpwDFmY7vreE4XXQN2pc/rT4qHGd+8G/FwlxymZx4l/EAsC63pgeOSHdYYaye0bosrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0zrl+Sl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0zrl+Sl"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8664769db58so9150747b3.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788725756; x=1789330556; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ukMsWPPljTo6wl4qbug5zblOIdA8wRRZhHKCz6k6Od4=;
        b=M0zrl+Sluksgj4nocGa7aEaH1qOilQHH9T6LgLtTFck+MqnHAk6WR/m4VAq/feO86s
         xbv8F4Aop/0wK6ICM4hfXefm9j0mZve05S+476thzeH/DnmL5868DKkpvAmwf3nbKnP3
         WzNpW2p6Bx3vltIdj3hUUPy4HWsEjLcHeoSeiLpRd+M/F2IDOwpjkZBThfdiSJr0JX/D
         l33AUXM/xSN6AjM/lvVQiw9xnBCEykR54UzhbIjwW1Iuo7hHbHgnF13DElG2sKB1h4ld
         RqQJ+q5yByyYhHKYBr9SuGkD63YJscsLc6MV3yjg9S7Dv9fV16LrUDDaSKkkzVffMoXw
         dvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788725756; x=1789330556;
        h=in-reply-to:references:content-transfer-encoding:mime-version:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ukMsWPPljTo6wl4qbug5zblOIdA8wRRZhHKCz6k6Od4=;
        b=h9eYCVQJe2Ttj3YYHuL8tk1/VyhSlco4Pu9Mdcyj6RZDfQh9QeuKTZxx1MHZeTRF5x
         0sO34prIfElRbDRaqCaklw++9IEMVjottirCvjSDBiqbaCJNFfBK7YmcWLTwjRbcBjVz
         Vn+/YRQnEP8ZHX+5Gz+nZzOKUCfbUcJ9ZgX1RA9/0u8zF37h8XPK0EZm6YA6M0fKHj4O
         iuq7ePVpX9VSVYcl2AMyWsmy9q3ZkgmwyyadiTIGrPkXbMb2SIP64eFBMeGgdVS8SXIh
         O/PdWhTIGoAkFx7/R0ifQ1ofiojZDsBz/okvZMD0NwTy9T/kkQz6r6xSv8jdAQY/HyrY
         Pf2g==
X-Forwarded-Encrypted: i=1; AKwUvBzmsG0Qbnex0eO7isnZDv4p8OH4H1W2YE2AORilvjonTUB2feENKVZLF//JZhP6qP0mKxmcKwo3PZE=@vger.kernel.org
X-Gm-Message-State: AFuF++kK3CgdBRGSRhE/DoMOubhKG5YY5BeuSJQTjoPWs/KTOzuw3fg8
	N74Ovqxt9/8URLodFzK+ZnshhYwNMko+Wdb5UOeadoJf9eKq2gwcwq/C
X-Gm-Gg: AYBFou1GmBPAKtyEUdbjZXJM8Ac2o0GZ6DqCplo4y4VYN9Mw9tM02eh9vpYgpKH1whj
	BryqRraQMcPtIWGhkkQ3/8IF1AYBn+HJVLN1AgvRYUU4IWFoPl+lDyguVv6f1Q8Pb2s026Ro6C7
	dUdA96ne/mcXnoA7jiztCG/AEJp0JMyDeBDP1IMFedXZy0ccZrLafsVW/CVkSkDzniOCANfqXco
	lTJ0jQMu3T6sVzc6fpsdlsmQWbDkQvCj5dBowS7tiyTCbIfCRPwk8VBQhPKx+UR8eCYOx426Wsc
	s5FyhR8+UsDyNeq00ZKhiO7WgD8ohkrKdPOk1p9W3BvH6TfOPegH4rH7lWcKto8GwU9Mb6VcHfO
	91UQT68KhgsGenAqHVtTbHNCvuh+NqOQX8f+3xr+m7nczbLAAywPDR+TV/SdyEPaHMNM/BSHdka
	TV9BCPxTxZ5xL3c1NRaRGdf47Wk1YyhtAwClP3ZO5g4GIF+fnfp62Wm3HW7P+V0wwQK5omW7Nbd
	pNUj9yvRgTmzC72cmyOEQ==
X-Received: by 2002:a05:690c:4b84:b0:866:4769:d5d5 with SMTP id 00721157ae682-871221a80bemr70860997b3.4.1788725755822;
        Sun, 06 Sep 2026 13:15:55 -0700 (PDT)
Received: from localhost (host-190-210-193-251.iplanisp.com.ar. [190.210.193.251])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871439c4566sm60627987b3.4.2026.09.06.13.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 13:15:55 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 17:15:50 -0300
Message-Id: <DL8ICXL9YZ52.2N7SL1NG0LV5B@gmail.com>
Subject: Re: [PATCH v4 03/10] iio: adc: add the ti-ads1262 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Kurt Borja"
 <kuurtb@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-3-1dc27e9c0260@gmail.com>
 <apFCNNzhPfq0T6rn@ashevche-desk.local>
In-Reply-To: <apFCNNzhPfq0T6rn@ashevche-desk.local>

On Fri Aug 28, 2026 at 5:09 AM -03, Andy Shevchenko wrote:
> On Fri, Aug 28, 2026 at 01:38:18AM -0500, Kurt Borja wrote:
>> Add the ti-ads1262 driver with initial support for the primary ADC
>> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
>> and interoperability considerations were taken into account.
>>=20
>> Various features such as accurate timeout delays, per-channel reference
>> sources, scale, offset, settling latency, excitation currents and
>> diagnostics are intentionally left out for future support.
>
> ...
>

...

>> +static int ads1262_dev_send_cmd(struct ads1262 *st, u8 opcode)
>> +{
>> +	guard(mutex)(&st->xfer_lock);
>> +
>> +	return spi_write_then_read(st->spi, &opcode, sizeof(opcode), NULL, 0);
>> +}
>> +
>> +static int ads1262_dev_read_by_cmd(struct ads1262 *st, u8 cmd, __be32 *=
val)
>> +{
>> +	guard(mutex)(&st->xfer_lock);
>> +
>> +	return spi_write_then_read(st->spi, &cmd, sizeof(cmd), val, sizeof(*va=
l));
>> +}
>
> How do these do not conflict or race with regmap SPI communication?

No because the regmap interface only covers registers accesible by the
WREG (write) and RREG (read) commands. The data holding register is
accessed by a different command (OPCODE) RDATA1/RDATA2.

>
> ...
>
>> +static int ads1262_dev_reset(struct ads1262 *st)
>> +{
>> +	struct device *dev =3D &st->spi->dev;
>> +	struct gpio_desc *reset_gpiod;
>> +	int ret;
>> +
>> +	reset_gpiod =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(reset_gpiod))
>> +		return dev_err_probe(dev, PTR_ERR(reset_gpiod),
>> +				     "failed to get reset GPIO\n");
>
>> +
>
> Unneeded blank line. But can you use reset-gpio driver instead?

I'll look into reset-gpio. But I think it may not be worth to use it
because it may not change much here. We'd still need to manage these
timing constraints and we also only use this GPIO in the probe anyway.

...

>> +static int ads1262_parse_channel_node(struct ads1262 *st,
>> +				      struct iio_chan_spec *spec,
>> +				      struct fwnode_handle *node)
>> +{
>> +	struct device *dev =3D &st->spi->dev;
>> +	u32 pins[2];
>> +	int ret;
>
> Can this use the property names for 'single-channel' and 'diff-channels'?
> This will deduplicate the same in a few places and reduce potential typos=
.

You mean storing the property name in a variable? Sure.

...

>> +	st->clk_rate =3D rate ? rate : ADS1262_NOMINAL_CLK_RATE;
>
> Can use Elvis.

I'm not really sure what you meant here.

...

Thanks Andy! I'll address the rest of the comments too.

--=20
Thanks,
 ~ Kurt
