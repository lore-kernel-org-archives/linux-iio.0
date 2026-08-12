Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A03438A4
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541178; cv=none; b=JypJ3INct4j/drE4zkBZ7zsNIUMLXuOa6ZbVrUOJ+WnqkXvTZYGOkLDsnCaGwejd0azRBPqrn39L3fuKpqMMZp5rA4j+PVAkgZETlx37c70voMv09PzPFGfFJoi97MDlMa0nFYI796aqkKZZ7QdBcn+zgzSUql+7kUGsK7E1vRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541178; c=relaxed/simple;
	bh=wwHqZGeHOPOI7Rr1VYsYe3S2gNoSQoe2doFlwUqVW2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d87eOnMQzSegfXgI+kbEDJn4HZZl5abWb1uFrJ3uvC/376CTkzlZorKtCKblgFgMQuwejwKrejfVxQjfbI36PpW7SKD2W2etA3ydLhhEnynXouuVbQS8GKqsnBXgfob+qzw8+g0M6OBKkRA5S+CM/KGy8UhUv5zi0pGnF13M4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fUVNpy9e; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fUVNpy9e"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aea94f96c4so503796eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786541174; x=1787145974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOEYGPRzI2ZD3nc79VvdBiED/thm1a8LkgM+AWcNblg=;
        b=fUVNpy9e28zRME9FijDrFnRV04FeGUU+oZoPLbOWH8yMHzU0e+wd6ocQoorjajtOvG
         Xey2VoSO8oDTz4/nwvZCMXyspoCzEYy6bu4zypya9vnFNc+RAccl60jI8OG8+H1vfSz8
         qClg3mMpsVnL5ywE0BhiFrpv1ZxuofrQNk6PurA7EeYKB0crH1bbLSGcO4gSt4UbU9WS
         PEQ0v0imIGlaZfknTFuNQYQvatboswJQmHKIKW7MNC3jGnMAORfQ0l1Yxqs25yi1F783
         ez7+XOB73XzgUHX+s3BTbaEK7um6PTq62UjoUZze+Tkzp/zoLiXnoJr8rdbfJ9nfGlu9
         XyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541174; x=1787145974;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOEYGPRzI2ZD3nc79VvdBiED/thm1a8LkgM+AWcNblg=;
        b=CyQCUT8GOy94tDfyFtxLaEKDI0TBUsWTuTBcuUIDK80J8wVq5J1yYTJHCDIwHzVnIL
         oQVAEeyWVUMaOolDCKK2E/sn8IEiyiGjbfG3BCZ+j9tKIy518oicbK/G1715BMZGPrVc
         hyMyG3z4fTw2hyJw5F4rDwLcO7ENl43sCgKAu3BxFY+o4N6z9KWDia9cZu9gq6eHX3Rn
         s1b4b28qnGn5eY6hGOx9+GO10PE+xunylgdlmuydV9qEtlBYj3IY9fQFng63V5CDhDR5
         DRTgfDVmII/0VwPTAwjvzBKbe+n2/ws9pCnlcGi4CwCpO/9pGpZrOMaO7w5pA+FeAJZG
         LK3w==
X-Forwarded-Encrypted: i=1; AHgh+RrNfkauuhbfxSPwy6uxCYGUsNt8a2TqRo6VcEYH2ue5P8kDN79iqZq++TuKaALwxi0onp84ClnhMb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+f6AJBrzPJYK2gsnwSl8mkLtEBQdUt49g6add+XLATMEEhXWj
	+/rMRddDaZiDE6/ajbYEb2tzFg2nP33KXZ0JZ6iYUjdbuCHHnlFtor+fA08FjYoxGT8=
X-Gm-Gg: AR+sD11bctqY7n2GYtN1aRiHG/GwhP3LiqivCdpUIMYdzowd2mOkQHePc/riMzp8HjM
	1AHlYEiaI9tYgHxMu+9BWdlCUHP3hrLk5TCDdxUpUq1emJJOlfCTB0H9/aihvHbbAhyqcECD0bq
	8bnKxxdlLJjXsOsz5tLFUsum4ncVahgWhQGh1mCuBNh3HI/1dqkGbrE30KOhsIphedmGhFcn4me
	fBBrGgIKtcJn56P+THY17A5Oj/eWh1XqPFZzpZ/L+YuucZjreh/ly+QaqIHmY1iGHsAWh5Ihmro
	/zeHDQR195lo7GR4Wyr0GqnARXHzXCt9SsIQAGjGWXWAPNDVJ+sxFvx1u0aVtFGeDcPEQETAGWz
	XKIsvixjfjq5Z8vcCqZWU4tNnenIyOZLhNQgsrQtCTeKALthh016XEEYU31K07SbOq2UDksukLd
	0Wvfsa8HpE/HBl0PXBZ772OlTr3SAhdkbHbwDbsnjMpQktT9S0MXcqxqTmoFwV7M4y10uu0krDb
	UY2jOg0KySpLtLxvWXSvXVOHEpeIjSAl9BURIV5apg647uVFg==
X-Received: by 2002:a05:6820:f029:b0:6ae:6f38:dac with SMTP id 006d021491bc7-6b0b263aaa9mr4004867eaf.10.1786541174306;
        Wed, 12 Aug 2026 06:26:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:76d8:83ff:449f:8518? ([2600:8803:e7e4:500:76d8:83ff:449f:8518])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b3420373sm2853776a34.19.2026.08.12.06.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 06:26:13 -0700 (PDT)
Message-ID: <7156c902-2bcd-445d-a00c-a5085b63c95e@baylibre.com>
Date: Wed, 12 Aug 2026 08:26:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
 <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com>
 <cd020926-9daf-4493-b0c1-6399a77fcf9c@baylibre.com>
 <CAF7HswPcqzqMUtkLkfd3zmVHN6DX-Kz+tysG8t5x=+JAH8V2aQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAF7HswPcqzqMUtkLkfd3zmVHN6DX-Kz+tysG8t5x=+JAH8V2aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/26 10:38 PM, Kyle Hsieh wrote:
> On Tue, Aug 11, 2026 at 10:18 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 8/10/26 9:48 PM, Kyle Hsieh wrote:
>>> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
>>> delta-sigma ADCs.
>>>

...

>>> +
>>> +     /* Power-On Reset (POR) delay */
>>> +     fsleep(50 * USEC_PER_MSEC);
>>> +
>>> +     /* Requesting OUT_HIGH asserts the active-low reset pin immediately */
>>> +     reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>>> +     if (IS_ERR(reset_gpio))
>>> +             return PTR_ERR(reset_gpio);
>>> +
>>> +     if (reset_gpio) {
>>> +             fsleep(1000);
>>> +             gpiod_set_value_cansleep(reset_gpio, 0);
>>> +     } else {
>>> +             ret = ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +     }
>>> +
>>> +     fsleep(1000);
>>> +
>>> +     /* Bypass PGA for now to allow full-scale single-ended measurements */
>>> +     st->config0 = ADS112C04_CONFIG0_PGA_BYPASS;
>>> +     ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG0, st->config0);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     if (client->irq > 0) {
>>> +             ret = devm_request_irq(dev, client->irq,
>>> +                                    ads112c04_irq_handler,
>>> +                                    0,
>>
>> I think I've asked twice now to move this 0 on the previous line.
>> If you don't agree with that, it is fine, but we just ask that you
>> reply to the suggestion with an explanation to state your reasoning.
>> Otherwise, it comes across as carelessness that you continue to
>> ignore suggestions. This is not the only suggestoin that has been
>> silently ignored. You might want to go back to the previous revisions
>> and see if you missed anything else.
> Clarifications on my previous mail.
> 
> IRQ: I will use devm_request_threaded_irq() with a NULL primary handler and
> IRQF_ONESHOT. disable_irq_nosync() is gone and the handler only calls
> complete(). This also removes the bare `0` you asked about on v2 and v3,
> with the arguments packed rather than one per line:
> 
> ret = devm_request_threaded_irq(dev, client->irq, NULL,
> ads112c04_irq_handler,
> IRQF_ONESHOT, indio_dev->name,
> indio_dev);
> 
> I left out the DRDY status read for now, since conversions are
> single-shot under the mutex. Happy to add it if you prefer.
>>

Completing the completion is safe in a normal IRQ handler. So if
we aren't disabling the interrupt and we aren't reading the status
bit in the IRQ handler, then we don't need a threaded interrupt
yet.

>>> +                                    indio_dev->name, indio_dev);
>>> +             if (ret)
>>> +                     return ret;
>>> +     }
>>> +
>>> +     return devm_iio_device_register(dev, indio_dev);
>>> +}
>>> +

