Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FAF3563E8
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480133; cv=none; b=Kv0Vm4j82DvtDU7BliVdKyPBSwTtuDsORZmD5Y73pw/QAhkldKl2vuyeXZd+8BzCJ77foJOSOxw1/pKBmmGA2ijiWxItYqpOzv7l76VLKUuHC5LemoFUbBSBuPyjYX1FUDPQ35+EdI23qwL4UqTerAEcb6eL4DbjdgACkFC4SUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480133; c=relaxed/simple;
	bh=lI2QGJvbe3CjRmuPMTU8qeofdrk0TWrINJP2FGbyrLw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WlMoyNqe0sYA0mC5naOURwD5NV0CbgQM+S6V1kM7tAzOWbgkA2j8m4ReXFH7W+ki5Dp5JS25G8KNE9GQNkN7fXuLV0lxAnkBUN+cA3GLYOm8XGuUnwvbr4dEQcO13GnUca5CG1x/lYYzkhRvmYX6Urt/zOHiR3dcfDUAldRW554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxx6G3L8; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxx6G3L8"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-976ea28c65fso49769241.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786480130; x=1787084930; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TMimpYcHZOGUhj+cUm9F57rlFMmPijLi6RHPAwT1cVs=;
        b=mxx6G3L8jbZOTpMoLcQEuiD6D/TxC7AWlFnsVjWgeIYXQlmyPkm0+Wze8E4e14y+U5
         ISUhpbjN4CTtLiM/FA3rC0GkdKcPtZnGoGeHn1z1kBDiZWeif9pwWqtoZFIDpoZWa9kb
         Qgrq1F2rU9IvMZvYhjxpLA7eB46X0Zy79uq/g1ESpKkG/OUWt0M66IPsw4zYc/dO4vdz
         zL6NZPEXcRGHxRUf2+dCIO2kuI3TxIGdzgy1jqTZsSJWerATYf5sZiEqR5GjqLARkhHB
         mRdtyAmYbmDFP1hfcSctDCLyL8FUKMK4FQgSCOdvzXSbO0hBN1vQoRT+h3zXZFcAPyof
         radA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786480130; x=1787084930;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMimpYcHZOGUhj+cUm9F57rlFMmPijLi6RHPAwT1cVs=;
        b=Rk3JMIBy7YfYebCHDm2/e4M+Yjox5XChZYO4wVfGgmq0DiqC8rPXEEpSl2evUMD8Ao
         EELd4gbj5c+or+3D5X143gNR3ct/wsn82knO46YndWWkOFumrDS2ICt7qbxhE8r5Z/sn
         Q+7p/+Mxm8rzxIqHjpquFxjI5PCmQkvn/TlA5PXNTkhX4Se6inCYLkEsz4bFVumE1ZJi
         IcPTNkzdPZ+5RBZ5+vZXkQzF5QKF9oqtQei9xE3se4MkhrvS0aEiRdTr8HxHD2MeoMI6
         cueF9ZUSl7LKjRClGuC5pRyrethWZqzonZjU5XViFukbtMeoBY5MtdxCAtxErleSIMrk
         ya8g==
X-Forwarded-Encrypted: i=1; AHgh+Rplcn7qbtEiIqVGDpwFVc4DpSu7GEnNgu5fAHmNjPVz75hg6wWq3T7MTmB4jLMD+svsQB6PF4HoKKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gE/bF1fppZPE5KbTXrcj3tHcycMmmAHTQL1GDAZpa+EAupXI
	+KurPg0VwW3qXaMp2Svd7su/SbDze8d1n8K1byxNXsCgX9e02xXPl9G6
X-Gm-Gg: AR+sD13HH3PjnNv+wnjDPqJ56nifVGBhK8img7PERy+bRA7BVsGYz21d08JTDyy/UNn
	ZIIVD+0FA6hd35mm+4k0OOTtvCjh/YlEVPPpTQ+BkG7a143Mbtx69kzI1WC8R3tOeHdBOhQf/Om
	RXuo38LSD44ctHQ9UCDMGKPGOcDg34fPdN4BNKsEXtq9eR42SRCe7svAtIcUXg3wjlVztf1E11E
	6/3nLgsetw0tEMHMwqfhaN2Z5JTZLelV8tRQW/wlvtiQwON5nWVlaTPprtWt9k48SUOPPXFcU2+
	DNo5cAaZbQv8f7+2jMpIr4onSkNhnjJaWQf2g0l2WKgyOLn/lwUG2poO9cw0FuLXIIwUdj/SbHX
	NlZqFay0ECFtHhcqW5JW/rmle2XAP4BG8wkZHFP5FrBRl5zv+BHxOXKitFrDztsD7f4uG6kxy1+
	jacbcwdZFxocVB+dwbvqHIywgrd4q4vKHmTYHd+0DfrGS2QApX0wYL
X-Received: by 2002:a05:6102:4426:b0:726:8813:2085 with SMTP id ada2fe7eead31-76c0c4ec337mr934146137.13.1786480130595;
        Tue, 11 Aug 2026 13:28:50 -0700 (PDT)
Received: from localhost ([2800:bf0:177:563:8f3c:3421:b12:7a09])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97a3c16f5bbsm593975241.5.2026.08.11.13.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 13:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 15:28:47 -0500
Message-Id: <DKMECOTJYOZE.3AEGK7RWPH7FW@gmail.com>
Subject: Re: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-2-f89925d72792@gmail.com>
 <ad95afb4-e667-4290-8878-fdd7067f20fe@baylibre.com>
 <DKK9QWYHOBOT.2VD8XMZTE65H4@gmail.com>
 <7a42a318-780d-4bd0-baf1-55d030b39233@baylibre.com>
In-Reply-To: <7a42a318-780d-4bd0-baf1-55d030b39233@baylibre.com>

On Mon Aug 10, 2026 at 11:42 AM -05, David Lechner wrote:
> On 8/9/26 3:26 AM, Kurt Borja wrote:
>> On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:
>>> On 8/7/26 10:58 PM, Kurt Borja wrote:
>>>> Add the ti-ads1262 driver with initial support for the primary ADC
>>>> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driv=
er
>>>> and interoperability considerations were taken into account.
>>>
>
> ...
>
>>>> +static int ads1262_dev_reset(struct ads1262 *st)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	if (st->reset_gpiod) {
>>>> +		ret =3D gpiod_set_value_cansleep(st->reset_gpiod, 1);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		/*
>>>> +		 * The RESET pulse timing requirement is 4 clock cycles, at the
>>>> +		 * minimum clock rate this is 4 microseconds.
>>>> +		 */
>>>> +		fsleep(4);
>>>
>>> How long do we have to hold reset before the chip powers down?
>>=20
>> For power down 65536 clk cycles. Less than that is simple reset.
>
> How long is 65536 clk cycles in microseconds at the fasted clock rate?
> Hopefully won't accidentally shut down the chip here even if fsleep()
> goes significantly longer than requested.

That would be 8192 microseconds. Do you think there is a risk we end up
turning off the device?

>
>>=20
>> [...]
>>=20
>>>> +static int ads1262_wait_for_conversion(struct ads1262 *st)
>>>> +{
>>>> +	u64 max_lat_ms;
>>>> +	long ret;
>>>> +
>>>> +	/*
>>>> +	 * The first conversion latency is affected by the channel's data ra=
te,
>>>> +	 * filter, the configurable conversion delay and whether chop mode
>>>> +	 * and/or IDAC rotation mode are enabled.
>>>> +	 *
>>>> +	 * The worst possible latency is calculated by taking the lowest dat=
a
>>>> +	 * rate (2.5 SPS) and the sinc4 filter. This gives a latency of 1600=
 ms
>>>> +	 * (Table 9-13). Then we scale it by the actual clock rate and multi=
ply
>>>> +	 * by 4 to account for chop and IDAC rotation modes (Equation 20).
>>>> +	 */
>>>> +	max_lat_ms =3D 4 * div_u64(mul_u32_u32(1600, 7372800), st->clk_rate)=
;
>>>
>>> These are constant values, so don't need mul_u32_u32(). Also, given the=
 wide
>>> range of possible sampling rates, I would include the current sampling =
rate
>>> in the calculation. No need to wate 1.6 seconds for something that shou=
ld
>>> take a few 10s of microseconds.
>>=20
>> Can we leave it like this until I implement the settlingtime? That way I
>> can calculate the actual first conversion latency.
>>=20
> Sure. Just maybe mention it below the --- in the comment message on the
> next revision to remind us.

Sure!

--=20
Thanks,
 ~ Kurt
