Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9E466B7C
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785263966; cv=none; b=jBw99jb7zN6gw897dcsxiniOg6Y9vQ04pQ5D6jUrB3ErNT3+pG3IeFThvx3aOEbVoSJXqM3Qc3OSbIlRQFkekcDC8zSlRcqFrX5pvmGtpKca3A0zm2f6z4byfvF0NxQQ041Ew3vVP9HCkNm9wXzFR8jDj9MxDLLFESp/goj6AYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785263966; c=relaxed/simple;
	bh=RKr4sPw7yY59cnecNrMMRCBGIPohNGrdz5d9epxLmFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rf8orBhiqL8vlAozIfv9/yj2qBD5Z+mVaSX6cV62iRe4O41KNAbzV0TxvS0wTITehH6DnVB+lJnCNEXEsbye2rN2sdAwU6lxnOE05+YhX/C1m77zQTYcIfZ/UYXrKGBwHLhWKXLuhxna+DU2/KAxaO3yvLUh8PL/FECElr2Z0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LfB8KLug; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LfB8KLug"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4560d6f82edso42951fac.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785263963; x=1785868763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZ6KjfVMquoraO1Ezx1ttR0tE2SHYdbVoIEX1Kyjbc0=;
        b=LfB8KLugj2YxSi5Tcqp+57pn5TicfayF9BCYrbMPzlZfNYQSfdqgybl5hoIpKoYQ9s
         8+PB6pHbsa8v1kUeExycdGYz2u7FDbsyRLT0gNSG2A3UMac9/1EwrWCLIrWdg+EXHdZu
         c1h4jIjFA7cnfR3yG4XZ8/GGywvHOSGwd9agpuEGXUw7kJpUaMV7axQ52zRBW8cOy4Jt
         Bkyhe401J89xER3pErUa7hr5jDBhXHKHMhKHHAr7ZtmBqTVF+Uyur4iJ0NukKtHL26SX
         MbjyX2P+I2Ul6DuVtL774rTlomP8WzmY7evjNc7NtN9o5sNGaWphiVUFCO5Nk9TAOCVW
         n4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785263963; x=1785868763;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZ6KjfVMquoraO1Ezx1ttR0tE2SHYdbVoIEX1Kyjbc0=;
        b=k6mI/EZJ/7JVrqjQockhOiGsnMPXFXW64a0Yn/AjdpxsGrx2tDcld8PgD0XYaA2EMh
         q5/hlO0vjAK0T6nHfv/pALM8+Sz/cGXFWA4zLariAigFdMzVNf2pg20lDp88DFIacSWV
         QjUFN9Hj5Rre0Z7BtNbOazcVyA6F/5TQL6GvM2sQRDWsirkqn73kBtctRmXzkrm/SKxv
         fIOEhCHhmHGCzzJrdn/sZxg+EJb/97woK7azGuP2rMN7yJLIEhRjT4rccVSr1SgZLDyK
         Mvvo5EuLICU24Gp+JyUE62AIciu9LJMbE6/9s407hixqllk8wGjzFi5bB98e6N8DGlCC
         o4Cw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9y3SmyG3eWkau5NfdztEhINSz2/THAPjsf5++UToOK62+H3Hveo1ihFdlv4EgKsMDMWVgNYp0Gq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5humtgg5gj4mgNauQ3eNx1E3Nay15QvWBOk0c/IoTuUdnQLy
	SXBhsH7or44jwUkGRa/y5tjs3U0/VB5UE7E907I4s/Aqf+jkNrGUs67nF0djG/bYixY=
X-Gm-Gg: AR+sD12NTT0omUddOCY+XU5Dbx4maaaaNolrnWLo6iRayPsIuFba2FECCa19mYh5nSz
	xNDXaCUqHlCwAQZwe6nqeLiichWAcOsw1iiQrWfXmUY1gxkni/fad5Ll5Mpz/r0IP1faaq7GgZA
	Kiz6TTNYB9Wj2BrzETwNLSzPnT2IUOAFPw4Q/wPHcTG2U2IAOZ6GhrxBZrWJisoqHMIv14TnkVZ
	OUCZR1LS7zORSacDqyqqbeoQzDT8hy0nw2sGGeKFtElGCmMrPTd2afXAT64UabWbyrjl5BXMtet
	9ZrvDZc+SFlcHQvzCe9RENwnq2D3zaHXQovvmcoMGhCI1AwA7VdyV04kPvtLP1rYBQ09aJmzUP2
	QQsd2e0iAUiuIFn7Pl7D+jxif2pcReHUdMDaHegaQPu0osnNbNFDHM45Z0KAYeBQ4n2MbdnBVR0
	vWkc8+frf8MpgCbGU5inSrCBBRVDUByEEwTYOGf82KlJnu7qbbj0TJ
X-Received: by 2002:a05:6808:2221:b0:497:da7f:179a with SMTP id 5614622812f47-4ad5bb442cemr2111452b6e.21.1785263962996;
        Tue, 28 Jul 2026 11:39:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3026:75d1:db9d:8984? ([2600:8803:e7e4:500:3026:75d1:db9d:8984])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6b3f025dsm409931b6e.3.2026.07.28.11.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 11:39:22 -0700 (PDT)
Message-ID: <e1f977a8-ab38-4dc6-a82b-b955545550a0@baylibre.com>
Date: Tue, 28 Jul 2026 13:39:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
To: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
 linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
 <e2118cfc-feef-4843-917f-844834ef4e60@baylibre.com>
 <20260725230445.60a445a0@jic23-huawei>
 <20260728-barrette-rickety-788b47da503c@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-barrette-rickety-788b47da503c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 11:10 AM, Conor Dooley wrote:
> On Sat, Jul 25, 2026 at 11:04:45PM +0100, Jonathan Cameron wrote:
>> On Sat, 25 Jul 2026 15:55:01 -0500
>> David Lechner <dlechner@baylibre.com> wrote:
>>
>>> On 7/22/26 2:54 AM, Janani Sunil wrote:
>>>> Some SPI devices support sharing a single chip select across multiple
>>>> physical chips by encoding a device address in the SPI frame itself.
>>>> Add the generic spi-device-addr property for describing these hardware
>>>> addresses. The property is placed on the SPI peripheral node and may
>>>> contain multiple addresses.
>>>>
>>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>> index 880a9f624566..b59d047cf117 100644
>>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>> @@ -142,6 +142,13 @@ properties:
>>>>      minItems: 2
>>>>      maxItems: 4
>>>>  
>>>> +  spi-device-addr:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    description:
>>>> +      Device addresses used when multiple peripherals share a single chip
>>>> +      select. The array allows one logical peripheral to comprise multiple
>>>> +      physical devices, with one address per device.  
>>>
>>> "per physical device" for clarity.
>>>
>>
>> We may end up relaxing that again if multichip packages start doing this.
>> Fine to add that clarification for now. We can revisit when / if it ever
>> needs that relaxing.
>>
>>>> +
>>>>    st,spi-midi-ns:
>>>>      deprecated: true
>>>>      description: |
>>>>   
>>>
>>> If there is nothing useful the SPI core code can do with this information,
>>> I'm not entirely convinced that this needs to be a common property.
>>
>> I think being common does make some sense from a standarization point of
>> view and it isn't obvious where to put it other than under spi.
>>
>>>
>>> And this only allows for one logical device. If we wanted to treat each
>>> address as a logical device (all with same CS), we would need #address-cells = <2>;
>>> instead where the DT "address" is two values, the CS and the device address.
>>
>> Ah.  Good point for the adc@address or similar needing to match a combination
>> of CS and spi-device-addr.  Conor any thoughts on how this would be done?
> 
> I'm sorry, I don't quite understand. Why do you want to support both of
> these representations? Hardware wise both of these things would be
> describing the same setup, so allowing this alternate "multiple logical
> device" typically is not permitted. What even is the use case of it?
> Does it matter at all if you have one or more logical devices from a
> consumer perspective?
> 
> I do have an idea of how to solve the adc@address problem (you can do
> adc@address,spi-device-address like some other devices) but as I said I
> don't get why it would be needed.

I would expect that if such a device was intended to be used as individual
logical devices that they would just be wired up each with their own chip
select rather than sharing one.

The only reason I can think of actually needing adc@address,spi-device-address
would be on a system that was really short on pins on the MCU.

So not saying that we need it right now. Just wanted to make sure we were
intentional about saying we don't need it if we don't.

