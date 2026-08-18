Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B947CC99
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069463; cv=none; b=kvMfMG71IndyAg6a2AbFGbtR2PaaybcAZjPn93ZakTJ3hDxI4TC6tq81JxBzQYubAYKvndmtkN2OBcvdekIeglbkNYRDDTcDoW8zNobO/8ZSWPQtK01i4gxpb6NcZmrPRvrxgtiFYSx+kPnb+W5RPot2XE6PHFz2dM0GS+4bNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069463; c=relaxed/simple;
	bh=c7PwQWkFv8QtOYPTSaqekUb0jNSO2JmAouy9pX/I/QA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=GO14B3dTcRjGXavrAzz8M+kDwImDI5GGOj5DoOdqHwvCwTDd5urag90LLl9Ras7VxDYOa69SBtQMhwRkb4NyQBMmHvaDoKPsgcKIQjI6yqg+kRoHli/9kcb7Ze+J9Z7ny2go9AfnOYHBjsOS4oSD5COUhCfHTDj02kr18CWAUiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRFIGYPV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRFIGYPV"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1712a04ddaso812151966b.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787069454; x=1787674254; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nvxB0TwdTME8MC6Z1iZNTwpBhONAfbWSssxaqP+j/pw=;
        b=NRFIGYPVka858bu0JECWLXkbS08vJ+HDFGMwIqngB22IAIOhtsDnv4CFPGml8JWIvU
         ErlDfiMn8dqiLj2+qYC1f1z/RQjX1aCtmOwUMP0DPVqjBqv6OGaOIGNcc4EzauYOKKgj
         rtOtkvXTcuYp7KQHoPM1FDZm0ECUGjEK9XLGTKK9TEZyI16ykUGA1biF5o1QIzNE151W
         lC/nTSd+VXlpRkdIIQnEOk7FfrdE3jOpYhyHiYrQ4voeD3AZPPZGCBgu+lHFZoQud/c6
         HZuuuV7695LwEyBy3bbFdrIvZqUhgYvsw2ZBw62xWdnGu6FSTG65XTw6xzSz10mBkXX+
         NQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787069454; x=1787674254;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvxB0TwdTME8MC6Z1iZNTwpBhONAfbWSssxaqP+j/pw=;
        b=o/1okqGxGG1BbNmE8RyG0mYfbE7/f8tCLnmyyRfqeEY220HsL75fIAnWRrSKatNLby
         zWnoEIMFi4xRKHNTw6ebyj4T+7rnrk+e54VtbpdWwZoRLtQ1xm5AeWp9qxmIE2tEgcwX
         NAXnWvS830qm9BF2CjBdCIkTx6CEzfGtRJgjYi7/NUO83s6+vQhs1YjOmtZuJhDIn2WS
         bFa+j/eGnMpbHW3VirEnYlyX4t46Qk8dXV+WRRJRn9ilIg27nC1FjuGD8N4vz9qvienA
         m0UB0JNOIXDuX4NBHFL65Q7vTHP4s0hW6LX1+Nc197bCUdA5KGGa4+lm74i0zh7na5pG
         y8zQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhJsjzO0RK/QiZYv57LEqwaTXirh8r0SNyd+qiMwdEUYKrEY0FB5D9MR4c6BHPQO3US+fcDTzMfF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIRI8xnPwe0vf4Wjx5sdFQLaYU/rqpts1iv9ZTFcGJr9fUE47
	I1Vl65khuv95wvVhnGJHF5p6Zs374uvBzg6XfefKld3fYxT7TZhrIjgl
X-Gm-Gg: AR+sD13lBIpUO+oZnbkmEHhIPPmqL7JkuZBJCL5gRcde7srq96nSWIJaDCWS5fsfxaW
	WNeKwldvc07Q/F05owXZvbwayVNsqUPYsr/U8ZfrFQhUw9AL0T5KyDOUY/+roevKZDlmOt9GTNY
	VeUjBdNvp3iu1cgjhvcKbOEbl6zaUco0BzL6tc6LWWyntqfs409gDDi29A0Py3KpZfMZsS/AV57
	O0lodFkH1HFtZeAvM2DbCahzO1kdM8S6HxMsSmAHt0vqpmgTnNlCAb8puyUmflRRUcU40RfmwzQ
	zBqMIGN+2RZ+kIY3tcfcEpYdXCxmxoNIuA3xpd63Kh2qVzqexcMNSgMu2al5TiHGbVBorYjYDfM
	pPTf2eSUIj0YRAjkluNUDvHL2Q5twVVvWKmQP2rWA+CefmhhFVOLcEbs+smzPIRwxeLboDrmIg0
	YtEr2BQO+YAFJSgjQOpMJxXi6VtPI1pfrXXg1OiWf2qo9Zj55PnAf4q7mKPLsUaeFGPLfaT0+5K
	uA=
X-Received: by 2002:a17:907:928c:b0:bf0:b39:dcc8 with SMTP id a640c23a62f3a-c212a1da2bamr1897122066b.26.1787069454161;
        Tue, 18 Aug 2026 09:10:54 -0700 (PDT)
Received: from localhost ([2001:4bb8:17a:e1ae:aa1d:6b4e:97a6:f7ad])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185b99f78sm189896466b.50.2026.08.18.09.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 09:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 18:10:51 +0200
Message-Id: <DKS790BEXVON.1FP9LQUPNTYDE@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v7 4/4] iio: light: veml6031x00: add support for events
 and trigger
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
 <20260818-veml6031x00-v7-4-2b0de0f20edf@gmail.com>
 <aoRltgy0AYZ_Vcum@ashevche-desk.local>
In-Reply-To: <aoRltgy0AYZ_Vcum@ashevche-desk.local>

Hi Andy, thank you for your review. Even if no more stuff comes, I would
like to update the code in v8 with your suggestions before applying it
if nothing speaks against it.

A couple of comments to the feedback I'd like to discuss.

On Tue Aug 18, 2026 at 4:01 PM CEST, Andy Shevchenko wrote:

...

>> +static irqreturn_t veml6031x00_irq(int irq, void *private)
>> +{
>> +	struct iio_dev *iio =3D private;
>> +	struct veml6031x00_data *data =3D iio_priv(iio);
>> +	struct device *dev =3D regmap_get_device(data->regmap);
>> +	s64 timestamp;
>> +	unsigned int regval;
>> +	int ret;
>> +	bool trigger_poll;
>> +
>> +	ret =3D pm_runtime_get_if_active(dev);
>> +	if (ret <=3D 0)
>
> < 0 seems too much to me. If there is disabled runtime PM (and supposedly
> device is always on) this prevents from getting events.
>

I am not sure if I get this. A reference is unconditionally acquired
when events are enabled as well as in buffer_preenable, and also in the
probe before interrupts are enabled. Runtime PM should be active at this
point. If not, the interrupt should not come from the device, even if it
was on (e.g. before autosuspend kicks in). But maybe I am missing
something?

>
...

>> +static int veml6031x00_hw_init(struct veml6031x00_data *data)
>> +{
>> +	struct regmap *map =3D data->regmap;
>> +	struct device *dev =3D regmap_get_device(map);
>
>> +	__le16 regval =3D 0;
>
> Redundant assignment.
>

regval is assigned here to write that value in the first instruction
(regmap_bulk_write()) after the variable declaration.

>> +	int ret, val;
>
> Why is 'val' signed?
>
>> +	ret =3D regmap_bulk_write(map, VEML6031X00_REG_WL_L, &regval, sizeof(r=
egval));

Here.

>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
>> +
>> +	regval =3D cpu_to_le16(U16_MAX);
>> +	ret =3D regmap_bulk_write(map, VEML6031X00_REG_WH_L, &regval, sizeof(r=
egval));
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
>> +
>> +	ret =3D regmap_field_write(data->rf.int_en, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D regmap_read(map, VEML6031X00_REG_INT, &val);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
>> +
>> +	return 0;
>> +}

Best regards,
Javier
