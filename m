Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0930D414
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994098; cv=none; b=chUw7ExT+tTG42bR/uwcAdI4ClC2ZL/Kb74DP5qjJ0MS1RgzdofncDKqbq4N2Qjrn2R6coV2zazax7b0579C3gmJ2EJoRXYqe0wiBNp731jM/6HAHpFRfhucYsslrgV53r6lA4FITsbGL7+kD52jyy8yh1OMgCWSR2u5uUaRJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994098; c=relaxed/simple;
	bh=C1OqDoF2Ic2qpjsbOvVsRdASzJE/FRUsaUk5PtJgNfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGywqMHA/H4VSDskVHkbdea8slbXwMtUYAwk75cX6iOLXrMvJOwinhZ+qLQwxvicKEipJcAyADAbNo79izf/Hm348PAjfETEx/qbphT88yU7+GbeA2vBfGz7eNiE7e38LvOK+CCwK659qoUDi8sgLVKRhUybdGrfbAxqYIq0/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fhtZD4pM; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fhtZD4pM"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aaea785032so664072eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784994094; x=1785598894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1g+FPjHBvtG+Vglz9EY02YKexSYio9rgEmBXTgUptHA=;
        b=fhtZD4pM+PWiKfygIT//0t1kQxdj3TkWEO4a/4blRk6SV4FRSM+1jMFDiIcKDXUFYC
         JLUGjBGadBwGTSK4zDIUigA1RiUrO0qXpz5GP2OCsjX6pOmG9KYTrUpRY/MLPOGXwPU5
         yBkTWsU1Vkt4X2CjBBwf6ekkIMmk2Ymf7cylJQQla6iQzHHfQkjW8gfwQSYdolRIDzfw
         bYakrkAWI9bLZinPQ4VxkTYDeWnvfzTfvXD2UWAroeeQu0hwsJ6msIqYWMajkmcZUg0X
         oG8exLWt/fTKNY5Mc8PNjCF9g8LodQQdGywO9gikjmAxGF2JlnmEKiIWCWqS0KwIZxFN
         EquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784994094; x=1785598894;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1g+FPjHBvtG+Vglz9EY02YKexSYio9rgEmBXTgUptHA=;
        b=KAe0lE8UuowKkdiWCckQc7ALu1tq49EyEgJFNvlrWFcb08rvntTnutL/nPWfdbR5NP
         AfdJDhGtnqztL6Lep9y/aTJyo4i2n9X+cX4vZUMD46qAB6xjIg+iEDldgwPHFdAQxgK8
         NzfGsEacpevcaGevLpJHIUHNUrIAKW/FXGrk15fTLIHyBsGp9IAdSSDaj4DmiEYfv2vi
         w21LqW+NqWq8oXciSICXqRxkGHX/1qiLMNLDKoIQz9BMIverEDIgFCg9bXBkLwT5IuzT
         Sd+iRK7T2Q2x5sMjouAAzO7NNDyUoY6B3/4dQRf3yfWj1NTvJ4C9Eb1t1APymymXnelJ
         PU+A==
X-Forwarded-Encrypted: i=1; AHgh+RrpmjvIK0bEaIIP+e706MyGlFyggxNax164jCfAgshVUBZ53vS4LYPl5J4QCVia7EwgMQNzofnGDks=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/rM+c1LhR+q9iy25ruHBIQTusENj5xPa/2qmSx3vJajFuxyV
	jn4bLuGYPCybkgHp6DBUeZNbB4BKwSf4HHbyWO4ep6UfbWqROQFhlxnoal9xhUfGz6g=
X-Gm-Gg: AR+sD101llnQkVPSRJff0n3VAf/GvroRolYSsFZ3Vg+0iZArm8o4B25ftT1TZ2nonQJ
	qDklaxfPcynQmNk7+nSR/NmFQxo4Zdpaxrk5yOpXpOJDb5ev1hdYXhiEpEWsNGQANcU72FWLaU0
	MhrGds2ijaBR8zEuPU4XExYyupjcWtm5KzzlD2MpM3QTm7zk3fhjRGveboYCx8ZVjFYW9yJghdM
	MODy30xNleKBg+esGKWHhCTwhON4rVVHvHEmx30QrAxOXzsXo+co2bPWEUGZmGm2ATTy70B7tBb
	yqj7W/VQSaA0wsMLEZK6OzZp9Y1HSs5b2WmUFmngGs+cT/tR3fgiZWBrWD/mpGAq5KzAFJd1xBY
	AIKuYv0q0otE9RWBmr3Xnl2LhIWpODeJbo2dRcm7LjJwHHo5wIojQuQM/Gqq5KDVjBBGX7ZNBEm
	9NIbjkrDHw6hw1kJpP+2/YuLmlpyS4SO+CxbgwOw+xVlOkfLsu4De4
X-Received: by 2002:a05:6820:2910:b0:6a6:8f31:5a50 with SMTP id 006d021491bc7-6aaff9382dbmr1997110eaf.5.1784994093892;
        Sat, 25 Jul 2026 08:41:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:677a:56dd:37eb:cf53? ([2600:8803:e7e4:500:677a:56dd:37eb:cf53])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766f16dfcsm10653282fac.7.2026.07.25.08.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 08:41:32 -0700 (PDT)
Message-ID: <023a4c95-4dd5-4405-bc73-2171a2292f29@baylibre.com>
Date: Sat, 25 Jul 2026 10:41:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for mcp47a1
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
 <20260721-mcp47a1-add-support-v1-1-da045a2567e3@gmail.com>
 <20260725000439.5ad6f4d1@jic23-huawei> <20260725101208.06f60b70@systembl0wer>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260725101208.06f60b70@systembl0wer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 3:12 AM, Joshua Crofts wrote:
> On Sat, 25 Jul 2026 00:04:51 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Tue, 21 Jul 2026 20:24:38 +0200
>> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>>
>>> The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converted
>>> which communicates via I2C.
>>>
>>> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
>>> ---
>>>  .../bindings/iio/dac/microchip,mcp47a1.yaml        | 56 ++++++++++++++++++++++
>>>  MAINTAINERS                                        |  6 +++
>>>  2 files changed, 62 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
>>> new file mode 100644
>>> index 000000000000..3322fca03b3a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml  
>>
>>> +
>>> +examples:
>>> +  - |
>>> +    i2c {
>>> +          #address-cells = <1>;
>>> +          #size-cells = <0>;
>>> +
>>> +          dac@2e {
>>> +              compatible = "microchip,mcp47a1";
>>> +              reg = <0x2e>;
>>> +              vref-supply = <&vref_regulator>;
>>> +              vdd-supply = <&vdd_regulator>;
>>> +          };
>>> +
>>> +          dac@3e {
>>> +              compatible = "microchip,mcp47a1";  
>> Hi Joshua,
>>
>> What is the advantage of the second example?  I'd drop it.
>>
> 
> Hi Jonathan,
> 
> Per the datasheet, the MCP47A1 can have two different I2C slave
> addresses (0x2e and 0x3e), which allows two DACs to share the
> same bus, something I thought would be good to illustrate in the
> example.
> 

I know we haven't done this much historically, but we could make
that more obvious with this instead:

  reg:
    items:
      - enum: [0x2e, 0x3e]

Then the bindings validator would actually check for a valid
address.
