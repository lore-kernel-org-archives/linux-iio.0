Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCE3C3F69
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964612; cv=none; b=ufjXE/eFtAgJ4uNuA4cua7t1da1AIZ0QqBw7eSmaRR+EcD2Gl/fcSj83sYeBIVe3I6HT+4Q1nOXgLKR8RO2+E5qkv8g9oXtRWM+Z/dHwJGtkfo8YljAgLqc5DRiN/exXmdmKYDZ/sz1WMfr5H5Av9dpU/TKZUA+gPEwClgWybRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964612; c=relaxed/simple;
	bh=suZfBo0+h+lEinP3UPlOlZXIwfGGYyAEiCu+0L3JEGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=eo//gcZhvG8zj1/X/RlXxIFuVXpeJodGO0d8rPAoOpmOToSVi0UClHLO6EfLAdG9PJKPDsvLCXgSP8aPYeYbP1rTb7yHioud0NGVHHPzn7S0VmRsv8E2sTD2st8MycAwuWdQAnQtcvhdOdURAOQ5S9Zbj7LxdT7s3doPKf9CARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZXn22bf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZXn22bf"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso4370168a12.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786964609; x=1787569409; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QMpSx30Kp01tyA9cA0s6xV9Jsh7jLN7uH1MhPtoZ3m4=;
        b=mZXn22bfLMwSzIf73G5OcXWdgg98bwBu+G6PzQO+TCcxQmDlNzGCJOf94V3xHHBaX3
         OyMVshlaZkaFwOpW5BjIkGCj80RcUjClPDXw1REjYyrzETABldXxKVrOoBGi0ht5T1Ec
         vcybk3c+AACGh77I7wuP3VNZx+2MLzi8mJ9pPSCPZc1tfyJBLegPSzeyHt/eBULBw/2s
         BTgfZPJExzQNuu6UEBe3mATlHTxs6GUXGsYb6/VZSLdYVVh2Yd42RF92jnydlhowmkn9
         Ytn0r5vdpZLUsE3iT75H/VZdQRiOGSIZhnhJQm45dyEL1aTrjxZhvXQk0fu6C327pTY1
         evnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786964609; x=1787569409;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMpSx30Kp01tyA9cA0s6xV9Jsh7jLN7uH1MhPtoZ3m4=;
        b=LmTwtTKIQOy1F7untkFVGHgP9pQx8i1NDDIKM9lowsliH3SCkC8KNN73CSqUF+Olr3
         Y/KVLLxeD9kmuw1vE3IN7FPCAueHuV9geo4aLINaHjgJmiheX4F0VJSvIqgxfOdfDFcS
         elPkuBmarQPTXHeA18UcmhrGLQ+sVdRbqkEoSYLaVx2PEQkyQKuAzITyqF2QVFeBsGh8
         OdFCLpvN3JqukDU1G3S+RsHRqdGJsNB93nMcW+//qWDH8YSiUXV4HG4jITKrRbc5Ntn1
         HBQDq2HFLFMnylQJKmcLUoLkKpvfmrkI7ZQYsgtdCvM5vylhwetNWxqsBeaAi9QXyAAO
         WHKg==
X-Forwarded-Encrypted: i=1; AHgh+RqYJ+f5ImOknwnGJTbpX7Mz+EmYbJguegtbbF0vsJHx6EWqRkD7wYeFFOdMh6sf9Y5AGrbUVknyqqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWAEgXiaqaJjPCL6zgrWb+F7GCuRsRddHd5xftVF9+Kt2MyUwd
	HyXR/VFDVHqv2Q9HIj/2i+nYXz+N0C876oyYAbot2To0kduuSmwaV9Rj
X-Gm-Gg: AR+sD11w3n1V0g/PLqMiDvrbgyt45bi8Xp9MF9hd8qigMDgb4eN+FH2nYCTDgCNP1o5
	vMsaZ37PLQYrkKRSyKSK6UfPG/uuyadwO9NicgXYAjyiO8BtiybcByDuxH/ZlAuWn5YG4BXR9zL
	U4A0rO0ukj2QIMqY1Lxe/Sd+VXk5j/gL1T0Dn557CLxyjjupe9+quofca2qnejRS9/y9x64Sd5q
	801Uy13BwIfqoaTZLCTAyfjUHUp4aexovohIfnvTgBHMQ70IdUQ65zSVpUGQm8ohRJaczbFFE9m
	5yTqpSWb+SCAf/xkkDSUC416amLZkBfjUMa2uJFgwJZYiCeCaYF7BfEgtM5kLfeWY6Uy2E5yd5J
	zoSs7RvqrC6bMuinYSYjUIurut1VxN2S+PUup642NOlmBMVtYqulk03i/Wt2xRkgylyzvpOZzeZ
	/rhTx1achQhl6WUfFotNsg4Fkm//IUHxwaeg2n8WRpRhv8JBPfF23Ir4yARI12ws1GvLQDx5KJU
	Xs=
X-Received: by 2002:a17:907:a4b:b0:c20:23f8:99a5 with SMTP id a640c23a62f3a-c212a0f32bcmr1095328266b.15.1786964608636;
        Mon, 17 Aug 2026 04:03:28 -0700 (PDT)
Received: from localhost ([2001:4bb8:17a:e1ae:4021:4903:88de:847e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185b977a3sm6849866b.45.2026.08.17.04.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 04:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 13:03:25 +0200
Message-Id: <DKR632XXE5OO.3BSQIKQFHHW8G@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v6 2/4] iio: light: add support for veml6031x00 ALS
 series
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
 <20260812-veml6031x00-v6-2-7eef6e4ce290@gmail.com>
 <20260813020429.54031688@jic23-huawei>
In-Reply-To: <20260813020429.54031688@jic23-huawei>

On Thu Aug 13, 2026 at 3:04 AM CEST, Jonathan Cameron wrote:
...
>
>> +static int veml6031x00_probe(struct i2c_client *i2c)
>> +{
>> +	struct device *dev =3D &i2c->dev;
>> +	struct veml6031x00_data *data;
>> +	struct iio_dev *iio;
>> +	int ret;
>> +
>> +	iio =3D devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!iio)
>> +		return -ENOMEM;
>> +
>> +	data =3D iio_priv(iio);
>> +	i2c_set_clientdata(i2c, iio);
>> +
>> +	data->chip =3D i2c_get_match_data(i2c);
>> +	if (!data->chip)
>> +		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");
>> +
>> +	data->regmap =3D devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config)=
;
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
>> +				     "Failed to set regmap\n");
>> +
>> +	iio->name =3D data->chip->name;
>> +	iio->channels =3D veml6031x00_channels;
>> +	iio->num_channels =3D ARRAY_SIZE(veml6031x00_channels);
>> +	iio->modes =3D INDIO_DIRECT_MODE;
>> +	iio->info =3D &veml6031x00_info;
>> +
>> +	ret =3D devm_mutex_init(dev, &data->scale_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D veml6031x00_regfield_init(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
>> +
>> +	ret =3D devm_regulator_get_enable(dev, "vdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
>> +
>> +	/* The device starts in power down mode by default */
>> +	ret =3D veml6031x00_set_power(data, true);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to power on the device\n");
>> +
>> +	ret =3D devm_add_action_or_reset(dev, veml6031x00_als_shutdown_action,=
 data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to add shutdown action\n");
>> +
>> +	pm_runtime_set_autosuspend_delay(dev, 2000);
>> +	pm_runtime_use_autosuspend(dev);
>> +	ret =3D devm_pm_runtime_set_active_enabled(dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
>> +
>> +	pm_runtime_get_noresume(dev);
>> +
>> +	ret =3D veml6031x00_validate_part_id(data);
>> +	if (ret)
>> +		goto err_pm_put;
>> +
>> +	ret =3D veml6031x00_hw_init(iio);
>> +	if (ret)
>> +		goto err_pm_put;
>> +
>> +	pm_runtime_put_autosuspend(dev);
>
> This and the get_noresume() above smell like they are probably here to en=
sure
> a 1->0 transition for the runtime pm reference count and hence kick off t=
he timer
> for autosuspend.   That shouldn't be necessary as there is code in the dr=
iver
> core to try a suspend. Look for pm_request_idle() calls in drivers/base/d=
d.c
>
> Note that we've had sashiko give what we have concluded in the past are f=
alse
> positives on this dance being required.
> Given you have device to hand, just probe it and check if it suspends.
>
> I haven't quite had the nerve to yet post a series removing this dance fr=
om
> drivers I can't test!
>

I tested that mechanism with several devices of this family, and it
worked consistently. I will remove the calls to pm_runtime_get_noresume()
and pm_runtime_put_autosuspend(), and with that all the goto jumps in the
probe function. I still believe that they are absolutely fine when
combined with devm_*() calls, but there is now a better reason to
remove them.

I may have some more IIO devices to validate it with different hardware,
but that's an experiment that will have to wait for a while... Anyway,
right now this dance is suboptimal but harmless, isn't it?

>> +
>> +	ret =3D devm_iio_device_register(dev, iio);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
>> +
>> +	return 0;
>> +
>> +err_pm_put:
>> +	pm_runtime_put_noidle(dev);
>> +	return ret;
>> +}

Best regards,
Javier
