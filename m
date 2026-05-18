Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37942FD1DA
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116713; cv=none; b=BfkS/bV2qBlH+EDPtFQ01gS9xfgKsUPQzjfy0eFJJm543isDsu8JdUCUkWv/vP1BPRWnw1Gg8TNmhbgiI2evtCMVL8cxUoEX6bUW4/qGgDgpAxV9Qy8Gjmz61+AtRCCIj7m9dGPeq1m1D3IX1AIJoPQmIs30dHogoBZL0q0xAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116713; c=relaxed/simple;
	bh=DrQFqVK7ClQwUsYNDfngLJu8LH50pdn60WsQM9mVJjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vl2AbEbli0+MVU0ht+H/8lGu1tSWyyk4PrZGdEyHfb2ESpFY5e+WRXGHlLNvKWdhVZkdSEaNfE7hf42dxK6smDf3drclUzGMj6EMJMQN0MZ75qbGdjo16QhSn4cvpdVeose5Pl0MZkUX0YKinXHQvuCEtd0q/KpvNJ4E4b8sI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ewYfBRk3; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ewYfBRk3"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbec19732eso2958640a34.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779116711; x=1779721511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzeCgn9mFtApC0ztEgdeNOw9BPgUS/EnSmz8TCLSDFQ=;
        b=ewYfBRk3g81dHYnO16Ez41aN6rGoZpbIREqK1Vz66bGFuC87V98aZpv4kzpfFyLQC8
         ihv6/d1Ji5Xpx55PVndkVaRPrAbqTIk1tFYuXSGd6sLUzB07YRhVT/UNoTVmef+rpaTm
         x44atynP9lTgnWFixWOjLDvsMOiYjHmXrLSyMrBig3glDAfdl8mBwbRYMWiotL3ZjPR7
         rKtP+g6Nu/1YlfD0AISW/xEefihRpXMqHwC3uhb/fLht3AZU0KLdWpflf74uZNGSDD6d
         UmA9/PXY3GJxeW+pGDqselprahwvRMx4Jfg4gvJekqMuKxViDcIE00LvCWWQYHFU6VJ6
         dmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779116711; x=1779721511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzeCgn9mFtApC0ztEgdeNOw9BPgUS/EnSmz8TCLSDFQ=;
        b=dChgowpXbpczYm08cTHsCBitVWgjgNLg+Hg3wTk/2HML5GOzRanseZ2M/85RPeX2/S
         LL7E6+z3DMzFZYT36GylSm7MYlJws7zRF8Rrab3iqgN5i+XCjhQFXpKF8u+zo98mw2J7
         Rp5yBGH1MaDhDw6sRoIFKhyiFxKeYuB1vo+SB6jrkTNqwyOOE+4AQHfqrG8fczgIfc/W
         Izj79U6zEelc5+EZei2dxO9er1XmOZaur6MaFi5CQhmrMhX+UXYuGm9fIe1JKEhJVWBl
         S6M8f7LWepqpfABEn91TIyoU4nSmtkLMXv/RcUw5e+QlKUGvccPTp4oNIgMTc5LuwsEx
         lukg==
X-Gm-Message-State: AOJu0YygShNe+oBzdegGg4Mc5EvOx5licHj4e/cZWs64/xieF8ESaoje
	bZCAzuSuQ+H4ZreCHrliQtIaCmdG4Vo6aYcP13d0uflHR2Q9f6oq5A5Kw8GWakNQL/XXiA83uAE
	EZlIJiLw=
X-Gm-Gg: Acq92OFgVUXbagckIqsdS12i40XfEG2uh/fzZKYv1Y9mW71ODpJmd3zZIsRRUX+4kJe
	8hL6GkDeDcDHmPtXoCh9xFS6msBcn8BIyataGXhcCphuVG6bPd/Hg+iml588KaikhftSYqp/Um3
	/zTSxT9qnBgc9aoxU1NI5bDOQpgeFSqGA6eNJIQRZuPVJM4rxrAPNKS1oISx6H5b+Ak4lMEl7VA
	4ZaVXWJDVPq0UwRR7iqBpxRsgKuScJkTpJOUdMs04oU1AmrUk40BpHKC6Lrt0gKnWgN9NDa6f2K
	NXG5c7HUb8FM20VG2Hwun5kmDZAusfYySpaVINGMneEw/JT6AVItRsoVxeSu7AKyefNSN98Ldj3
	BFJwcmDm2C52fM0bQog1j95z+KtRs7yBo8AsZh1tYVLQo4UWfcrUGChWtaxGwCcB1nfc4aTaz5W
	QFZIBENTP7WM9LpACKST77DxDMTS6gw0SPHQXelam22NePOPgIklX0CGJnSS9dw3+swObHckUHH
	A==
X-Received: by 2002:a05:6830:3903:b0:7d7:ef0a:1ce5 with SMTP id 46e09a7af769-7e4ea07e9demr10482946a34.9.1779116710621;
        Mon, 18 May 2026 08:05:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3be6:1187:fed4:378b? ([2600:8803:e7e4:500:3be6:1187:fed4:378b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b81c8a0sm7696080a34.10.2026.05.18.08.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 08:05:10 -0700 (PDT)
Message-ID: <7d338351-5f1f-4eb8-a266-b8756d0e60f5@baylibre.com>
Date: Mon, 18 May 2026 10:05:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
 <20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
 <0696b662-f478-4d1a-95e0-0338bbdb719e@baylibre.com>
 <LV9PR03MB841445D5BD1087FB3204EBD9F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB841445D5BD1087FB3204EBD9F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/26 9:59 AM, Sabau, Radu bogdan wrote:
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, May 16, 2026 8:11 PM
> 
> ...
> 
>>> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int
>> *val)
>>> +{
>>> +	struct spi_device *spi = context;
>>> +	u8 tx[2], rx[4];
>>> +	int ret;
>>> +
>>> +	/* Set bit 15 to mark the operation as READ. */
>>
>> Can't we just set read_flag_mask in the regmap config?
>>
> 
> As far as I can tell read_flag_mask is applied by the standard SPI regmap bus
> backend, which constructs and sends the address byte itself before reading
> the response. When using devm_regmap_init() with custom reg_read/reg_write
> callbacks, the regmap core calls those callbacks directly with the raw register
> address - it never touches read_flag_mask.
> 
>>> +	put_unaligned_be16(0x8000 | reg, tx);
>>> +
>>> +	switch (reg) {
>>> +	case 0 ... AD4691_OSC_FREQ_REG:
>>> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_MASK_REG - 1:
> 
> ...
> 
>>> +static int ad4691_write_raw(struct iio_dev *indio_dev,
>>> +			    struct iio_chan_spec const *chan,
>>> +			    int val, int val2, long mask)
>>> +{
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>>
>> Should we aquire direct mode so that we can't change the rate during
>> buffered read?
>>
> 
> It is in set_sampling_freq already. Do you think it would make more sense
> to move it here in order to help readability?
> 

IIRC, I think it was resolved in a later patch in the series. So
could just be a problem of it not getting added in the right patch.

In general though, yes it would make it easier review if the
direct mode claim was made here.
