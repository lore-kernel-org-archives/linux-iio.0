Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B823C6A4B
	for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419970; cv=none; b=QANec++mG8BoZzygDV99CUnuhHWxtS2b58KHyFpOI19S6uiJghtcv1fJM4ATGPwAwkO7L4okQ4l7szhXGGmTsWir/tseVDnePqPbQsK8QW6kgT7N9nCkBBLWNMYkLuKQITThXjsSWN0sRzWIkG5F+dRvLVTDYJc6ZPpWp0pS+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419970; c=relaxed/simple;
	bh=Qj7u7fKzT27EaALLTcCusFhJ7ATg3tivF3VhphoT12w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdEId/NhgV/9ymzgXjNcNzwofsxoo6mQjKEy0CsV/Qixk8PXqF5BO9JXkYoy09/A4pXlTlIZBNiyUcNlPYSqVS9b/vIwckeMCaDjmfdW2Adh8GK04li/63lJ9VAjBdqsykaWEKYh+hp76jIUVxlp+dE4+GqISO+x5iWDLioXh00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaOVbzC/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaOVbzC/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b94a19fdso2225775f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773419967; x=1774024767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpEPoHYvhvWkjpmYEpEt8jyUUg5KMMUdOdkwivHgCi4=;
        b=DaOVbzC/MQfQZvuTtUCqVq+ekt2HGjagyRzoDSez1ksKifQOvRzQStVjVt9jt6Tk1U
         bdBBx7iFu+Thpx2NA5bGj5w4oU2nSMWaMhs1e+yzddQ40wbImoyTSxT9YNWXqz2nGXF1
         fJGv6Wi+pBDosr6/RJ9WsaUHYrTNFxPEZrf0Vyoj3BecjhBXDFdJB6EKonccmftX+p2G
         ytwkEaYR5PhUrH6LqGqaGr21cdzhSJLjy+PUBsBL3PvHrLTEdYVg/CDKmEWhF5A5u/pI
         kIRZzLDTXyWvezW8Hb9o6r1Xn5WhFR3iOukr3yBTel4EZjUG7QA2ttSMYBW/QT6+II0/
         Tq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773419967; x=1774024767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpEPoHYvhvWkjpmYEpEt8jyUUg5KMMUdOdkwivHgCi4=;
        b=A9jgk753bRlrMRzVkqAkZIJKHmPOwqpBVPQUpopa26slIbXPPVdiTrXgssxMxTINU+
         WKJCNG7nEpaFmd04RAHlzEhMtaCj4kJQ4+UgJjo8hpftc4WKpUpypkXPf8zBkQywRorg
         AuGVQN/4Pnl50vNkOmgz+T7QLAY7PINlN1rAayyOZ3OYKXk0WiAj9wp0UJIRIUekLqCm
         nFYQm67EcOypTg2miP7ZN0eRTSfeVS0Ds46znDrieqhkyBsBoHLtQ8FbrczJ7RVC1Z7L
         kB3loz2Y94SiR0hjdOSiXL6iVF7kdPNVWCcK5RzmgQoIym7d3EA2T8UFa7vPMxG9o4m1
         9aAA==
X-Forwarded-Encrypted: i=1; AJvYcCUTNoD/MRe9V7acQqq1RYb3/ahg1Fv5ajp6We6Fm6CMnGOIMZ5on7Qxpz4HZ0+mdFe/03zhnBrN29M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyye+d3lP3f3qRz/XrxHktbDZ6YxoyxTpYoGAvy7/hsv5Fd9iCO
	sUVTigVIGdeoCSjgQQZwYDZcVnaXyJRmxXSV5ZEtog536ITakfV1zRWx
X-Gm-Gg: ATEYQzyP7NasV4JJv+2et4uRudhlIg7VmXfLvUx1d8bdjgrqQqIkkq9yInVilrZYSNY
	9TwkZjS7kdUtHbJDKI/pzM1W17ktcKdP+B8KE8PAMb/Uwkj4jQZRcz7Ljqapp5K7n+bsA2p9JNS
	mZc1PqfaxAgfP3zsGMdx03vr9VBunQEeH7CeizI431I5o6rO4A74MmnF2G/NbG9GGY+70l0Vpnf
	AsDUtyi+FvftlFkXkDVzDJfObjgP18uSvbnfFgMnMEhWcLJnSNqB5p2W+PMH4qsbzauhZS9D3UX
	S6E4erAhtFAT0J3xM3UkuyH9AWDS+MbgCqCEAvCvKRhb5yTOXSfpit64YQDg5xgirHpmkXWCAiV
	spHccUFkeO4QqqanoWKk4STvcopGlx6grYQIh7oXMOQcwal0s3SmVaq7cK5KCW9HX/yovpv6FE8
	Rl6k9HHadXjFQc8H2/pXRiRfIkDCnv4J02sBKJ
X-Received: by 2002:a05:6000:2283:b0:439:cb79:ab05 with SMTP id ffacd0b85a97d-43a04db5ff4mr7600661f8f.36.1773419967340;
        Fri, 13 Mar 2026 09:39:27 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22e9ddsm16346345f8f.37.2026.03.13.09.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 09:39:27 -0700 (PDT)
Message-ID: <3d27945a-639d-4c3d-969f-2ec23bdd9900@gmail.com>
Date: Fri, 13 Mar 2026 18:39:25 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: light: vcnl4000: add regulators
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
 <20260312-vcnl4000-regulators-v2-1-2bdebbcbb58a@gmail.com>
 <20260312-slouching-shelf-c8f64433881d@spud>
Content-Language: en-US
From: Erikas Bitovtas <xerikasxx@gmail.com>
In-Reply-To: <20260312-slouching-shelf-c8f64433881d@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/12/26 7:39 PM, Conor Dooley wrote:
> On Thu, Mar 12, 2026 at 01:53:12PM +0200, Erikas Bitovtas wrote:
>> This commit adds regulator properties for vcnl4000 ambient light and
>> proximity sensors.
> 
> This we can see. Your commit message should say why.
> 
> Do all devices in the binding have all of these supplies?
> 

If we look at the datasheet for vcnl4040,
https://www.vishay.com/docs/84274/vcnl4040.pdf, in figure 11 we can see
that there can be 3 supplies: sensor supply Vdd (vdd), I2C supply for
the bus Vpull_up (vddio) and IR LED anode Vdd_led (vled).
The other datasheets refer to three supplies as well - one for the
sensor, one for anode and one for the bus:
https://www.vishay.com/docs/83372/vcnl4000.pdf
https://www.vishay.com/docs/84138/designingvcnl4010.pdf
https://www.vishay.com/docs/84327/designingvcnl4200.pdf

>>
>> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>> index 2ba4d5de4ec4..a1b4c02db246 100644
>> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>> @@ -33,6 +33,10 @@ properties:
>>    interrupts:
>>      maxItems: 1
>>  
>> +  vdd-supply: true
>> +  vddio-supply: true
>> +  vled-supply: true
>> +
>>    reg:
>>      maxItems: 1
>>  
>> @@ -54,6 +58,9 @@ examples:
>>              compatible = "vishay,vcnl4200";
>>              reg = <0x51>;
>>              proximity-near-level = <220>;
>> +            vdd-supply = <&reg_vdd>;
>> +            vddio-supply = <&reg_vddio>;
>> +            vled-supply = <&reg_vled>;
>>          };
>>      };
>>  ...
>>
>> -- 
>> 2.53.0
>>

