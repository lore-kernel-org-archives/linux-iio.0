Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122F2C158D
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368961; cv=none; b=F4BZMPw0x0NNVc5eLZJqTB6UzLRei7Vq0O0k/VeiUrSpLl8MRd7774xUG2FNjsz6kjMfADjLf2Pu0AiH9Asplz8wC7ija/7d/afeIbJV9/Ey+POMaclDTWmAu/TqauhwHpVIusRgdOQcZlDwJGPflfuyXwm+RFkbgzTbGpKNoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368961; c=relaxed/simple;
	bh=bvssL15XbSOxdAicqWiYiUk8ct54+EWZ0TdCukvko44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mwqm3XwJvRsHLJCm6Xft6OCxsQlsaobv13+R6ASXWKox8VK9JKwx2x8HL/jibh7x2h5YO1rCh3lVgRfmt4mc7169M9G3WMV3+XOFFo27jFQ3Kd+gaCwL7Z0Q0zk++5vXvLPH0OdW8GO3Ys3k+b7GQAyz8j9mJScqO+ixtlEyJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YLfKeH+I; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YLfKeH+I"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c65d744cso2639907a34.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 14:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771368958; x=1771973758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdYxc/QZBQVS0ui5sfFiWK7cBCBspR4q9y+sv+w894M=;
        b=YLfKeH+IvRqrBVujSqg1fdtFhA+0enzYxjspS/ApFZLxg4d7D0eyDR2riW8pWCoQWY
         jLqNKtpb2MEctnkfpPkB8GnOtMVOKse3dY+C/L1HWTfmYmjDNjh7c1wIqghFNICYOa6M
         FvtBb+nVRjZM/LXIRhLjPCVy75BpqRx5MrdWAEnW7rVCxAsTPrPiQgk2tzyaYs1DTPCn
         +0H6uLL4Xzg9xvloGJOKMEqatN945/w9DhlDmVOHKUJLzjay9GyqLWfpZ5h7sEKhWeB9
         SpQP7AGo8VLontMe+l5v4xIE+tUUjJd9luOrCPV0pG2n3iShAm8ED/JZ0V5TVaT/+uWM
         r5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771368958; x=1771973758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdYxc/QZBQVS0ui5sfFiWK7cBCBspR4q9y+sv+w894M=;
        b=mGghOsAI5MfDTEDj9GDYOixxevWCFyLTA6hnma4pPKL4yDZmFKmEKzoa9TQH5IbOv1
         6Px+Bu1ncvxmUv/wIjmF7GkZ68Pcm6QV+jfIRaAxPCyNMOBvsRv6mHDWsN0iLZEgqwC2
         Wa6JE3v8BR50IkLSnUULZpFu891LQo8HOIHaTSYvJ/iOpTPd3d+M9Bx/2iLrUXCnjmfs
         5RrZQD0Z15xbP9wrtVd5UsKz8HeJ2cZozwqM9oOujtnPMdvIb93fKNXI/UVvBV+n2OYG
         Xx/r7MzgjpKnVndixkG7hJXvyGLSSVNVqzsQnpZG85cOY8zrCxGWoZnauJpY/UKGBIG2
         6oZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFVoDCBLOKZ3lzTWgsCxiELTK5x50TncyaH+7dUSTdgrlSXMdIhQzEUj9mdUTDBD8S26mt1oN9orU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9VV2gTcDWFu5ADw3pFi5kIocmmORx18NcMs5S5pWZdO2089q
	CC32KynmK40bLNua3Y75Ogpm4xJeU6yqL2Kp/wyDFO5VpVWuLYTgM1HHc7HTspL7cgo=
X-Gm-Gg: AZuq6aIis6r120oh5CBRWg5P0i9LEKuYSygKEQtPkH0ZfysGRYFXhVXyAIvuSBJFWHT
	UzW5vnKYkiBB+cFszqcWyCWYGqrKs0Wak/q/RJ91s343DBZDYXec1U9lvtmAp+ezGn+BjKgF3B3
	Ykoa7HqR/fdS2E2trY9WKoWhIOv8UWxQ/rYUgjr/SR2b4WHlVfxXcR74wylicsTQAQdu+LTfoFp
	totNu54AekPAnUWedUFWbenpM2DwtzwfBUkHwdU8EUbBOu9Z6GAInctHk8V6tOLCOe3OGGPH1SI
	l3az9/3ONoLua+gq0aacPTesG6xtgORvNvpv2U84zJHIWQfjv9ikTRCrlUKjVYZ+zP5wLSgW4nA
	QOSOnZcZQDsFj3I5haQUvRq2Vv5vKFPNoh6P4IdWFkDniEvZH5eGO7cQeGOU8P5EHAuN2Xt18EN
	TG0Kohj+hF9qUFUpRnkI3mumRmbmT1sNtZsfLdXFViNHVQ6vWTB7/ScnWQWoeyUluRUw+/5w==
X-Received: by 2002:a05:6830:61c3:b0:7d1:9832:4796 with SMTP id 46e09a7af769-7d505dc0720mr134079a34.16.1771368958017;
        Tue, 17 Feb 2026 14:55:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:b8c6:5b3:8109:1f08? ([2600:8803:e7e4:500:b8c6:5b3:8109:1f08])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a771c495sm15983215a34.26.2026.02.17.14.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 14:55:57 -0800 (PST)
Message-ID: <d22c8fa8-1e8b-4f0a-80a1-3f13d75cd52c@baylibre.com>
Date: Tue, 17 Feb 2026 16:55:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <aYiGj_TYelvJdVaR@smile.fi.intel.com> <20260214160852.6862b58d@jic23-huawei>
 <aZC6wIWDdS8J_1eJ@smile.fi.intel.com>
 <897bd4d4-bbdf-4cbf-84f6-05c110d75d03@baylibre.com>
 <aZF9zoWHL9iHSK3q@smile.fi.intel.com>
 <dce24f01-2a8e-4b36-9685-6ff4293e2d5a@baylibre.com>
 <aZLDyWICGB_j0Z1Y@smile.fi.intel.com>
 <2f9fc7fa-dd55-44f2-9b78-c9902b8b1bbf@baylibre.com>
 <aZQmkm9Xt3PivqmX@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZQmkm9Xt3PivqmX@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/26 2:28 AM, Andy Shevchenko wrote:
> On Mon, Feb 16, 2026 at 12:53:10PM -0600, David Lechner wrote:
>> On 2/16/26 1:14 AM, Andy Shevchenko wrote:
>>> On Sun, Feb 15, 2026 at 05:16:47PM -0600, David Lechner wrote:
>>>> On 2/15/26 2:03 AM, Andy Shevchenko wrote:
>>>>> On Sat, Feb 14, 2026 at 12:31:12PM -0600, David Lechner wrote:
>>>>>> On 2/14/26 12:11 PM, Andy Shevchenko wrote:
>>>>>>> On Sat, Feb 14, 2026 at 04:08:52PM +0000, Jonathan Cameron wrote:
>>>>>>>> On Sun, 8 Feb 2026 14:50:23 +0200
>>>>>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>>>>>>> On Fri, Feb 06, 2026 at 06:07:12PM +0200, Antoniu Miclaus wrote:
> 
> ...
> 
>>>>>>>>> I believe there is a better approach, what you need is rather a flag
>>>>>>>>> to SPI core to tell that this is the device with shared CS.
>>>>>>>>
>>>>>>>> Antoniu, this comment from Andy needs addressing before we move
>>>>>>>> on. It seems fairly fundamental and I'm not seeing a reply to it on list.
>>>>>>>>
>>>>>>>> I'm not entirely sure what Andy is suggesting will work but this
>>>>>>>> is perhaps a mismatch in really understanding what is going on here.
>>>>>>>> Andy, how would a flag work given they seem to be separately addressable
>>>>>>>> SPI buses. I think this isn't a shared SPI CS, but rather a device
>>>>>>>> with two entirely separate SPI buses. I think the only reason
>>>>>>>> we are bothering to implement it as a single device at all is the
>>>>>>>> shared backend.
>>>>>>>
>>>>>>> My understanding that there are two devices that for whatever reason share
>>>>>>
>>>>>> It is the opposite. It is a _single_ device with _two_ CS lines.
>>>>>
>>>>> Don't we have already support for that? This changes the picture even more towards
>>>>> NAKing this. See below why.
>>>>
>>>> Yes, spi_new_ancillary_device() was introduced exactly for this sort
>>>> of thing, which is why I think it makes sense to use it.
>>>>
>>>>>> adc@0 {
>>>>>> 	reg = <0>, <1>;
>>>>>> 	...
>>>>>> };
>>>>>>
>>>>>>> the same CS line. Yes, I probably misread the idea behind, but I meant
>>>>>>> some flag for SPI device that tells SPI core that the CS it wants is shared
>>>>>>> (maybe a high bit in the cs field or so), then CS core won't complain on
>>>>>>> validation about using the same cs number which is "already in use".
>>>>>>
>>>>>> There was one existing user in the kernel of spi_new_ancillary_device()
>>>>>> that looked like this, so it seemed the right way to approach it. However,
>>>>>> code was added later that caused the primary SPI device to "claim" both
>>>>>> CS lines for itself and probably broke the one existing user of
>>>>>> spi_new_ancillary_device() (hard to tell without hardware to test).
>>>>>>
>>>>>> The idea here was to unbreak that so we could use spi_new_ancillary_device()
>>>>>> just as in the existing use case.
>>>>>>
>>>>>> The patch for that could have been a bit more strict to only allow the
>>>>>> spi_new_ancillary_device() to take CS 1 and fail otherwise, but users
>>>>>> are going to notice if it isn't working right anyway, so I didn't ask
>>>>>> for more checking.
>>>>>
>>>>>>>> There is an argument that maybe we should be looking at how
>>>>>>>> to do data muxing backends to support the more general case of two
>>>>>>>> separate chips feeding into a single buffer, but that's a complex
>>>>>>>> beast and I'm not sure if it is something we actually need.
>>>>>>
>>>>>> I think it would actually be quite similar to what is done in this
>>>>>> series.
>>>>>
>>>>> TBH, the change sounds to me like a hack. It doesn't cover other potential ways
>>>>> of the multi-cs devices come into play. Given that SPI core supports multi-cs
>>>>> I don't see a good justification for this patch.
>>>>>
>>>>> What did I miss?
>>>>
>>>> As far as I can tell, other than the one existing user of
>>>> spi_new_ancillary_device(), other SPI multi-CS stuff is only used
>>>> by SPI flash memory devices, not general SPI devices. There code
>>>> that is being modified here was introduced to support the SPI
>>>> flash memory devices, so that use case is already covered by
>>>> existing code.
>>>
>>> Right. And obvious question why can't we apply the same approach
>>> to any SPI device? Like extending existing code to cover generic
>>> cases.
>>
>> spi_new_ancillary_device() was already accepted in the kernel as the
>> solution for this sort of use case, so isn't it already the generic
>> approach?
> 
> I don't think the single user functionality is considered generic.
> 
>> I can see that it could possibly be nice if the SPI core saw that
>> there was more than one CS and called spi_new_ancillary_device()
>> automatically and somehow passed that along with the main SPI device
>> to the driver probe function. But since this is only the second user
>> of spi_new_ancillary_device(), I don't think we have enough data
>> points to be able to say if this is really what all peripheral drivers
>> would want.
> 
> Also, if that one designed for the case, why is needed patching?

Because the multi-CS stuff for SPI flash memory was added later
and broke it. There is only one obscure user, so it is not entirely
surprising if no one noticed yet.

> 
> ...
> 
> The  mentioned approach predates the SPI memory chip support being
> integrated into SPI core. I think we should consider to kill
> spi_new_ancillary_device() in favour of using the same mechanism
> as being used for SPI mem chips.
> 

I'm not sure the SPI mem work ever actually got finished. In the code, see:

	if ((of_property_present(nc, "parallel-memories")) &&
	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
		return -EINVAL;
	}

But there is no SPI controller that has that flag. So I'm not sure if
anyone is actually using this yet. And anyway I think the aim there was
to be able to assert two CS at the same time, which is not what we are
aiming to do here.

And the other potential user of multi-cs is stacked-memories, but this
is only mentioned in dt-bindings docs and nowhere else.

There doesn't seem to be any other code besides the validation that is
done when the SPI device is added that makes use of more than one CS line.

I would like to agree with you that there should be a better way, but I
still don't see an obvious way to do it if there is one (other than the
suggestion I already gave that probe should somehow give you two spi
devices instead of one).


