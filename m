Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B93624BC
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783873839; cv=none; b=CNWO1elo5OcdxYPCAhmcQJBa8QCWfrfhPk7YjoY4YkdAoheTC/xhUlTGGi3mkHUZea/wjFjrq84dSZOin88Nj9Rj7i7noulphIPbw8CsAn+ncBTPeC7P7Rj5wekyq59bHxEG4v9sHbBNzUwOYOneRbdSLtLA7euRj3P5Ce6Fn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783873839; c=relaxed/simple;
	bh=19uKDmkw4YGdHcf2I8C7kHZXoTPiCf831Ui6RmZ3XS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljf60xUuhjT7TuFc79gJ6spkutG6H5wYUTAENRNVdTmCmLVZtcb2b/48to7bBwgFF0guIDEda813DDzk2IxDuX+W+67pQmxjc3aXtu0sQJGp1tmPltdauEpku4ow4Duim3w2/eCmsHRYPA3DpQ08A1EVaK83gb9kphdtrq6ANJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TZYPmkbU; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TZYPmkbU"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso882930a34.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783873836; x=1784478636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5PY6MHPXgN1sMkki5f6TEVs8WC88f6zKUB5nh4DP3Y=;
        b=TZYPmkbUT+sIwiRP8HpTQdeZIJ3jilzE0UBnOCLrY5ZLanWjxzcYMX49GwJbQ6NFUP
         +2p/9ANRiBtslPsda2sxo3BD2jH7GuOPlXZ3Mpubi83110wcxxyULMlA9ypmPUAzUskd
         D1OT8Docc/dyZKOWG9oOIT65lpqTKdI3jyACGFvkghHAg75VJNLd5H7XVTJ459mubORU
         Fuwym3XBvGULn2yNiXr75jtZGoixQ/wawPsHrDQ/hX5OnWmI8i1Fy+uR/C92SjE9oQWz
         b+PV9wSij0F09ud8V4Qsk+Ayt2/v9mIBAi8gkJ8KmiPOabSIH/iZjNQvAsnnndkvx0zI
         wkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783873836; x=1784478636;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q5PY6MHPXgN1sMkki5f6TEVs8WC88f6zKUB5nh4DP3Y=;
        b=m8JcXDQbl+BJh8mHqAEk0k1D5m2u+umGVKH47dS8AR3+7W4Xv0uwVJIl2n3U4iTrWx
         9Z0iQ5CItJQHZLyAkpwssSXf6E0HdOXJ4eYu+XAzXA32aTRnD0DIK8284m/4Jt9JK2Xg
         vXga+RifXyL9XNQ0R0vIHRX3iP/iOx78yvYakz0BAJKryifLImgu94NU7KFDFibc0f67
         V/kS9SV6VMof4izMhFunMv2h7MEcFKd47ByhQ0N63KdWIZUY7ftrIe51VvyUCkfNp/br
         rrHFX0XY7QVyECi8vBxqXzfssJ1vOMrQJx///dDMVFF0tJmHENmBRu1+0yPCPUviGWC5
         if0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/K8Q/5R8KjcEP++5fbyfsYq6VJodAqqpYOXE5MqiS/A3dJOGVC27/u+QYEoFMYq9TyZ9jY0c2hblk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZu+HNZZVk1Dx0T402s/mxhmGYIBUWYE7OLk30GzuMbSYImp4c
	qOdynEJSSCPyX/VC+BxSg3PcHlllqLhSN6JAkrDkG0Xr5XKK7FXmXyTpv9F6fSs4eqs=
X-Gm-Gg: AfdE7cm+Y80d6ONhYs/ut6CgmviUfqwh+d4kBqBew5W0jxmeKurs9LCAfMYUvgFhOnZ
	Aqsge5FLc13j1i3l8YsqFcnPurMGPkL0xT5L6dg7WPq3jQPi22MuQtpoeEhGoJqicYQCwP2H2Qz
	iHEOJ7qgSNKv+Ia4d0+32RLWvdT0mA4a1jzIZN8YaRAxTadfofBEa2M05q9SAMsu999Nk5D8ErY
	fEhtSCzC+cUZ3VScC5ZnXRhg8lal9yAJxJcg6HcZ5t3i9yin9et6kdGhEfMK60+S9Tow0pp97YN
	qK2KQ+nR/+aJ9k7b71OIp8kBE8lF/pSgEWCGUEeVqrzWLmbM+qIQwsDR/RRZkHswN5kaSkHzAZf
	sXjquFvKY0tb48hdNNTnN/HaPs31VyLzpE0P0aXsbPBkMy62DX+MefB88NoSQ3z43zkl/wy6SUW
	jlxW32L0FSdHzxkB6lbIpre2BDS/XI1k+JhVGTkRS6wvUAYYsm87zZz2wT14LOfkk=
X-Received: by 2002:a05:6830:2b12:b0:7e9:ec31:bd5a with SMTP id 46e09a7af769-7ec09857d5cmr4086727a34.28.1783873835727;
        Sun, 12 Jul 2026 09:30:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3af7:75b0:bf02:8cf8? ([2600:8803:e7e4:500:3af7:75b0:bf02:8cf8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb262f50sm10964840a34.15.2026.07.12.09.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 09:30:35 -0700 (PDT)
Message-ID: <566ead65-4da1-492d-b556-25526cc63647@baylibre.com>
Date: Sun, 12 Jul 2026 11:30:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] iio: adc: add ti-ads112c14 driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
 <20260710-iio-adc-ti-ads122c14-v3-6-746d52cbf1d0@baylibre.com>
 <alNhom1_o1hZgEnz@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <alNhom1_o1hZgEnz@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/26 4:42 AM, Andy Shevchenko wrote:
> On Fri, Jul 10, 2026 at 05:50:39PM -0500, David Lechner (TI) wrote:
>> Add a new driver for the TI ADS112C14/ADS122C14 ADC chips.
>>
>> This first step is adding a very basic driver that only supports power
>> on/reset and reading the system monitor channels.
>>
>> ADS112C14_SYS_MON_CHANNEL_SHORT is the last channel rather than being in
>> logical order by address to keep the voltage channels together and in
>> case we find we need to add variants of this channel with different
>> voltage reference later.
> 
> ...
> 
>> +static int ads112c14_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	const struct ads112c14_chip_info *info;
>> +	struct iio_dev *indio_dev;
>> +	struct ads112c14_data *data;
>> +	u32 reg_val;
>> +	int ret;
>> +
>> +	info = i2c_get_match_data(client);
>> +	if (!info)
>> +		return dev_err_probe(dev, -EINVAL, "missing match data\n");
> 
> I think -ENODEV suits better here.

Sure. I went with EINVAL because I thought it was more common, but we
have about the same number of both ENODEV and EINVAL at this point.

I also saw one ENOSYS, which we really should not be using. And one
ENODATA which actually makes sense too.

> 
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->chip_info = info;
>> +
>> +	ret = devm_regulator_get_enable(dev, "dvdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
>> +
>> +	ret = devm_regulator_get_enable(dev, "avdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &ads112c14_regmap_config);
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
>> +				     "failed to init regmap\n");
> 
> Do we have a guarantee that device is powered on here?

I guess you mean did I miss a 10 ms power up delay?

