Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614861;
	b=bUKU7Lk2IKjJMa3kQmRwt/3t5PhEUSsH2BLcDe09rJ6OfnJ6ngX8Ytdj3P1YPPzNZ5/D
	 IChPhyJ7RoCIcyELaRDrFuTg2V4KZPe0m9eXdk+0IEYbt50dtqK6U2Y/TYps3yzr2pL5Y
	 3kp/KQauVqCtQ5yI5ghNVVeNzpSb6P85+j1+Bm0SC4S4oDgtE+/kOYHPBcT8BI/DGulfb
	 YT1DTS42Oku8ChXKqYOxpTYlc5/Irh3Qpqh7yRkm+8QkMLFvEGfZUbzDSo+0BBR64l6M8
	 lgzWtHDO8hUBfQC6xyssfc8FIoUSmzSL4q8NHYQytmLMX1Rre+kEowQBXVBEbujwlAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aK8g5gPWYY5ZSiatoKUDyldSfIMdc1sHYx/BgeG2gvc=;
	b=T7Bhoqk5ZrV7tkpkBrkwnv60b77uQtYY0qlS8Jb928v3kz0rA/DoFeaADFC8oZfjNgEp
	 7CRlIZiUnh5Gzt0esKbRSC2RsgFrH8PH2hXT1a8kBFicxuQtEc8KTfvKLc2E2PViRR4ID
	 P5lY0zsojrHM5wMOnqqnnixrXQeknp2v9r7u4i06JQQEwQL+QqUTcFA3uSnBKagTO/1++
	 ZuOogtJIP0IrJUKLzoFhdAv2eKoWj88GyW0/mw169DgXkLActnWAM+8/hBOf8zQ+n7MYV
	 teoq3A07knP18K9TnonlmeYoaA5DAGnMo53J7r434ZzPAnfuQa4i4gAYTgn6a3Mwivw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoySFyXd;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3010606A327
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 10:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3010606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoySFyXd
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so886307a12.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 02:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793614860; x=1794219660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aK8g5gPWYY5ZSiatoKUDyldSfIMdc1sHYx/BgeG2gvc=;
        b=VoySFyXdwRG+tPuJ87m8IwYv32SSANj86gDRALvOsSbYwDK/ifgtnXoSMGBh1SSQkR
         RnyXRfCVux9yP7Yy3aa6aqkdbyRveIpxezwtLBVdEu8WRG9txUdsDMTYJCAu+3gGnL5L
         +0zBfOnsHSQZDHDRvcXapTgiGNHsFEcQ43/SX6eMO37dFTGD4eox5I9lSq73KN1sAQsq
         9QuWDeJxAxk1D7CLLMqrioZagP4g+RK9NNoF0yNJTkqaultLvMyUoXeinJ70fgP+bJfG
         JeB8RqaBegXLEw8QvE9jdRWN1GEW9O6Fk2beKUUVhlEsdRPAnCKOa5ux+ozyshkTCg+f
         PSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614860; x=1794219660;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aK8g5gPWYY5ZSiatoKUDyldSfIMdc1sHYx/BgeG2gvc=;
        b=EQ0EsI0IETMLkmTbOTRfZrs2TXvjLnoF5QHquvTXooFCoArpk4LiS1UCCzTEV8tIIF
         AHH+xCS/rcxa7YOHNaz5YSFEg2oaDxBGY2tVB0c4E3QUod2F+l10WErUCh1FPqD7RkTZ
         eV4S2IJJdEDvYnOFS/IKx3jEqG08zl0zk9TRzoOMMVYNKUGV9QqHwuoHqR21DVGZFOmo
         fEUJ+p5sEIGI6Cip9TTOuhEsL2wKs0xfXrxZm7QBpDfDTsNcyZki0bryep3h4Vu1D1t+
         NIADS5CMcUZbMIOHrq8jw1W++LjSHbiSh0F3ZijIgHWVGin6mCnnvMO2Q36dXycWeaYF
         Hx4w==
X-Forwarded-Encrypted: i=1; AKwUvBxdoI3LzhIQvRAfrIJQGvfcvcOevvIdD0vn3WNG0D+Y+0Jv9J+piEwopazovWgky9tlpzpaKHbZQe4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2aDjPg19XmtxT4L/5PLidlH8BEtlkmYLOxTE3dEqc53DIFZye
	P6yS38hId8Sn+tZSItBxALxGQXL+CXt21gfgeCz/LuhRc8LPfSy6zOv4
X-Gm-Gg: AYBFou1ZKu2iBnQOUje0i3e5Fafj68NmpkSVFLbcLWH47/29ZZD+HgEhC6yEZQKQ0TU
	wCxjsNTmog179i1VhvZZ40/dPHzTLplJGIpHkO7xtNdnUZWMItKS+JFBmsZbu1Swi6upitnOmtU
	5plhKKN0w/Q3zwgspoLJ9pSZvgk08VG07pyhwwkbbZMLxk+XM09WV2VLwwdEYOWwjewwtXErqdN
	gic3UFNJvlh9RKJj78S1ArNjrShbyojMNa2jglwz4luwag8Yb9DShIwTucvg+tW9Zs0Kdt5tuCy
	DUXU34TqB/B4NYFKhZxOapRyVCx2F1zA4ZY1k0rgsDDGxQ7ZhrdXbGIP9UbDUsbFVKkSnw3QVnN
	pv0H3NrsotdGmNm7cuqhg2UJQzFZ+BLxxRQ7U2/7d7a47+KepIs1osEzIYqFoDfzDusA84UjOcD
	UtOfNKmh4q+50fVgNNfEYSrS4gPExXk+vuzWHApcOny4MRr2sc+eoyAR6KwNRVonDWxvWsmdPEV
	rzHFIHwWJ2+DxnV0J7YGGdzdxMYxfvlEWEwedgQok6YWYvPZvBKSF6FM/HLoOAGUzsP/kHZX57R
	XlZfB2ou5KSJGttXb8O3f30dYIEh8agxPOMkGRxQHYtcwkf1wCg8aTdi131qrJ88yjGVKWH8Zce
	W/iiP
X-Received: by 2002:a17:90b:1b02:b0:3ae:3c0b:159b with SMTP id 98e67ed59e1d1-3ae8973603bmr6808844a91.24.1793614860072;
        Mon, 02 Nov 2026 02:21:00 -0800 (PST)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845df666sm13811378a91.14.2026.11.02.02.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:20:59 -0800 (PST)
Message-ID: <0f0324f4-48d8-471e-b35f-7f2d541a70ee@gmail.com>
Date: Mon, 2 Nov 2026 18:20:56 +0800
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20261030031501.130290-1-cwweng.linux@gmail.com>
 <20261030031501.130290-2-cwweng.linux@gmail.com>
 <20261102-bald-mysterious-alpaca-13b8fa@quoll>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20261102-bald-mysterious-alpaca-13b8fa@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Krzysztof Kozlowski 於 2026/11/2 下午 06:03 寫道:
> On Fri, Oct 30, 2026 at 11:15:00AM +0800, Chi-Wen Weng wrote:
>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>
>> Add a devicetree binding for the Enhanced Analog-to-Digital Converter
>> (EADC) found on Nuvoton MA35D1 SoCs.
>>
>> The controller provides eight external analog inputs which can be used
>> as single-ended channels or as four fixed differential pairs: 0-4,
>> 1-5, 2-6 and 3-7.
>>
>> Describe the four hardware interrupt outputs, ADINT0 through ADINT3.
>> ADINT0 through ADINT2 are associated with the corresponding conversion
>> interrupt flags, while ADINT3 is shared by the ADIF3 conversion
>> interrupt and the ADCMPF0 through ADCMPF3 result-compare interrupt
>> sources.
>>
>> Also describe the functional clock, optional reset, optional external
>> reference supply and optional DMA request.
> 
> Don't repeat the patch contents.
> 
>>
>> Expose the controller as an IIO channel provider through the
>> DT #io-channel-cells property. The cell identifies the logical EADC
>> channel selected by the reg value of the corresponding channel child
>> node.
>>
>> Restrict the channel binding to features supported by the MA35D1 EADC
>> hardware and use the common single-channel representation for
>> single-ended inputs.
> 
> And here even more.
> 
>>
>> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
>> ---
>>   .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 175 ++++++++++++++++++
>>   1 file changed, 175 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
>> new file mode 100644
>> index 000000000000..97144a8eeb5c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
>> @@ -0,0 +1,175 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Enhanced Analog-to-Digital Converter
>> +
>> +maintainers:
>> +  - Chi-Wen Weng <cwweng@nuvoton.com>
>> +
>> +description: |
>> +  The Nuvoton MA35D1 Enhanced Analog-to-Digital Converter (EADC) is a
>> +  12-bit successive approximation converter with eight external analog
>> +  inputs and one internally connected VBAT input.
>> +
>> +  The external inputs can be used as eight single-ended channels or as
>> +  four fixed differential pairs: 0-4, 1-5, 2-6 and 3-7. The internally
>> +  connected VBAT input is not described by a channel child node.
>> +
>> +  The controller provides four interrupt outputs, ADINT0 through ADINT3.
>> +  ADINT0, ADINT1 and ADINT2 are generated by the corresponding ADIF0,
>> +  ADIF1 and ADIF2 conversion interrupt flags. ADINT3 is shared by the
>> +  ADIF3 conversion interrupt flag and the ADCMPF0 through ADCMPF3 result
>> +  compare flags.
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-eadc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: ADINT0 conversion interrupt output generated by ADIF0
>> +      - description: ADINT1 conversion interrupt output generated by ADIF1
>> +      - description: ADINT2 conversion interrupt output generated by ADIF2
>> +      - description: >
> 
> Drop >
> 
>> +          ADINT3 shared interrupt output generated by ADIF3 or by the
>> +          ADCMPF0 through ADCMPF3 result compare flags
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: adint0
>> +      - const: adint1
>> +      - const: adint2
>> +      - const: adint3
> 
> "int" is redundant, so honestly names should rather go away completely.
> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Thank you for the review.

I will shorten the commit message in v4 and keep it focused on the
hardware aspects that are not obvious from the binding itself, rather
than repeating the properties added by the patch.

I will also simplify the interrupt description. The detailed ADINT3
source information can be kept in the controller description where
needed, rather than repeated in the interrupts property.

For interrupt-names, I agree that the current "adint0" through "adint3"
names do not add useful information. The interrupt outputs have a fixed
ordering, so I will remove interrupt-names from the binding and use the
first interrupt by position in the driver.

I will address these together with the other binding changes in v4.

Thanks,
Chi-Wen

