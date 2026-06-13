Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD8821CFEF
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781368935; cv=none; b=WbZNzO0CzW66aYnt2bYgpdx53ZL4IFCI3KwAYGJBu0tbecuDMnisIaqhA3BNUZlb5JyQC3YEo9i6j/IuT+oTjYJXrvPWU1uBza7wkxT7RkamO1/SCoQiSjg83W+k99IzKFNBYXn2WKKC8GXIiHmm7WjB+Tg9u1V8HBz4P5f7pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781368935; c=relaxed/simple;
	bh=IhIQz5jSiL3XNOL1jTbo5CXGeRcji9WKa7mNaIAFqXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzL8y6PpgrLq3JAzLku+lNA3eximM8Wwqd6V1/FQUEENrTcA7KuDqd+ijM7BizP0H/pDWLXkrp1I2DvtZLN2Cd4FXMMEwgXgiJ1JBfm056mWs2pX+U3HveeEqokAXhpcWuCfE97yoOoD5d3SFGJSM2ngklH9SKsgXKngbXhkbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=U0Fd+nbn; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="U0Fd+nbn"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e6c047c6bfso1634374a34.3
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781368933; x=1781973733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YClLX0yEzKDd8bl1cK6HeZnm+stLvAtsb923iZjql8k=;
        b=U0Fd+nbnCSmC5+faS7b43X/SuLhkZAldJ/LX/f23IU+F8qE2V3O5vP/O+8K96DOxzU
         Si0xITrDw9XU818gebvaxsqmhDC6RvAikv6YWpT9jxhfqQ3gCS6mQbJqUth85WPc/sqk
         j9Ed91t4NevmC70K2jlVghOS0O2vueuMyMe/zkPmiztwYIEGF6TIolLXfS1tvuzToNdU
         Y11aOQHQDziQUqYYxxZeLMcH3rpJfwhjRrHxj+Hf2sQ+kRLXHUyr7NeGdBNvpHnPE8bl
         0PQW2JiY1qV9a7gY5Uq0PCjqe+FcWZHoY1uNQqw593T/8pqqN6os8Z4sg0r2gnHkDWRz
         uDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781368933; x=1781973733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YClLX0yEzKDd8bl1cK6HeZnm+stLvAtsb923iZjql8k=;
        b=NcDyv5S3I4876zNDG6oerxGdB8LeX/PnJ+4WL9o0GlUi84Sob+rz1tOuoWLIxZumFA
         OHqzWq0n5QPFAzNkHu/c/1SwJbnw1rA5b8QbCMyZNoAwWddkTZqjmm+U/mZp8WzU9XMs
         SNgMTEx8F9QrJ4SnyGmk/DdhXxUREXufTG8ePh7mPV14ppwYvuiku/5KjTzh41RdCAb5
         UCMrqSxO1MGjI7Ru7DqtP+82dVs1pBVc29iD8bywMSOAmoxHWeRtARHslhe7xbQ6RfXP
         IiV6UQzz6pScQeanBksTN88qfBvBzL7MqwDVm7C7XQUy8M7ABPj+NZU+MGQcUtuXfupB
         FIvw==
X-Forwarded-Encrypted: i=1; AFNElJ+7DzqddJk/Tg4HbQXeQsU0A6eOQ+oOmZADTj5yWOw1MSe+cgZMPedCv/sTsqDJKhijQmFwL6ZQ8EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwzRXBPO2fW5RYwgjxD5eAGvUT49voJ/L2bs7HvviXB4B5WR87
	ig77SGbDFtIapI3NfrlIRY0mrkKXCVteip1MargTacpmo7sX6dGbvvwCOyQhQDjWH54=
X-Gm-Gg: Acq92OFv1TVoUvdP+vWOAejb3V+qbzhSgL4/zzmgDn2bHOpPoG4lxA4aubuB7365345
	ndsfJgnbCwl3k2kuM/L633QhLZguMn5cIFR12Fi53eJKYIQ9/V5V3YnMsQtVjBS2EVxI8fO1Ek+
	t96HdA3SrxWnkeCUNLy3YQ8VZcp3+ODEfiUmR0rRt1mLuN5b1Sb55sKNVd5QHaa8XLzVR2Eu/ol
	8kyjiX0uSpwiIZoRDOEOZsNColIhzy5O2eurk0wxjadtg4oD6J9ZF9X19/PLjM9sbu0me35O2UE
	OwFcyS8snzQMkk9xVmfh8PaoUGfLTxJ5eUvHNRAHlHFhXKUYPufxmNxZEbHXV8x6EXyte2TkZcd
	3+HYsHErQiZMeO6oPWxUQ57W9BQMEOnINERsdIKXF1MN1S/cWfXpAPIo3if4ysa9DoULmsHu6b/
	UTF20ULeMFrZa4s9Q91GqwIgjHMjI6kQuVW8yqsAZYYPfm765PtrbaCLxxTnL6xtfbU1lpHsos3
	g==
X-Received: by 2002:a05:6830:6e1f:b0:7e7:9493:dc3e with SMTP id 46e09a7af769-7e794a32092mr1230912a34.3.1781368932957;
        Sat, 13 Jun 2026 09:42:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:cb9a:87cc:1314:fef5? ([2600:8803:e7e4:500:cb9a:87cc:1314:fef5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e78125d3e3sm4346652a34.0.2026.06.13.09.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 09:42:12 -0700 (PDT)
Message-ID: <8ddb4c1e-d105-49be-a6e0-30c220af98c3@baylibre.com>
Date: Sat, 13 Jun 2026 11:42:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
To: Roman Vivchar <rva333@protonmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ben Grisdale <bengris32@protonmail.ch>
References: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com>
 <20260602-mt6323-adc-v1-2-68ec737508ee@protonmail.com>
 <2df4cad5e29fbcb4c5c5f59ea0bf322c7a301bdc.camel@gmail.com>
 <RRvh9UBBrqdfKoCLaqgfcQ06UY-BSM2hQ0F6F1YkdB2k2RXYMQmlCG4phXk72oGY03t1g1kDI4z-SDeKlYkUv84-AjNLaWK7tDQlpEFQVKk=@protonmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <RRvh9UBBrqdfKoCLaqgfcQ06UY-BSM2hQ0F6F1YkdB2k2RXYMQmlCG4phXk72oGY03t1g1kDI4z-SDeKlYkUv84-AjNLaWK7tDQlpEFQVKk=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/26 6:24 AM, Roman Vivchar wrote:
> Hi Nuno,
> 
> On Tuesday, June 2nd, 2026 at 7:42 PM, Nuno Sá <noname.nuno@gmail.com> wrote:
> 
>> On Tue, 2026-06-02 at 15:46 +0300, Roman Vivchar via B4 Relay wrote:
> 
> ...
> 
>>>
>>> +MEDIATEK MT6323 PMIC AUXADC DRIVER
>>> +M:	Roman Vivchar <rva333@protonmail.com>
>>> +L:	linux-iio@vger.kernel.org
>>> +L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>>> +S:	Maintained
>>> +F:	drivers/iio/adc/mt6323-auxadc.c
>>> +F:	include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
>>
>> The above file was not added in this patch
> 
> The header file is added in patch 1 (dt-bindings). Following Krzysztof's
> feedback on the previous version, I squashed the MAINTAINERS into this patch.
> Please let me know if I misunderstood anything.

Usually, we want the MAINTAINERS entry in the same patch that
the file was added. It is fine to include MAINTAINERS changes
in the dt-bindings patch.

>>> +	case IIO_CHAN_INFO_RAW:
>>> +		scoped_guard(mutex, &auxadc->lock) {

We can avoid extra indent by making this:

	case IIO_CHAN_INFO_RAW: {
		guard(mutex)(&auxadc->lock);

		...
		
		return IIO_VAL_INT;
	}

>>> +			ret = mt6323_auxadc_prepare_channel(auxadc);
>>> +			if (ret)
>>> +				return ret;
>>> +
>>> +			ret = mt6323_auxadc_request(auxadc, chan->channel);
>>> +			if (ret)
>>> +				return ret;
>>> +
>>> +			/* Hardware limitation: the AUXADC needs a delay to become
>>> ready. */
>>> +			fsleep(300);
>>> +
>>> +			ret = mt6323_auxadc_read(auxadc, chan, val);
>>> +			if (ret)
>>> +				return ret;
>>
>> Could be return mt6323_auxadc_read(...)
> 
> The mt6323_auxadc_read returns 0, while IIO expects IIO_VAL_INT (defined as 1).
> Should the mt6323_auxadc_read function return 1 for success?

mt6323_auxadc_read() would need to return IIO_VAL_INT.

