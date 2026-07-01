Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A82D399358
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931708; cv=none; b=Grsgw6OLC2Y2gwjyupDacav7E7QcUia05FFr3wpcwcTrETppkFPiZpvH6+XNrx1m7OkRZmdTjgC2G2Zexqt/GFuIhxtqPxtYVLY7m7khKdxCgoBUK9p8KMcfF4YuLVRbopbX0visvL/GHYwsT7KTFf1iT8z2dMyDbcoQAhasO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931708; c=relaxed/simple;
	bh=LnkCdH2rMub+8Ev/aOXfC79aCCrMwEvlNrm835YI6yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REtHO8R1/rjSAdpg/z2iLpw6Da3bUaFht0q1++Zrtxxru/nd80ZlfLY2F9Xzehl/+spc7rL8jKCrzfO+CQOMu7W3pcUXchJcmeK5CEglPHSgxuAutspgB080LIvVBoTr/AKWVHejjQDeuIW9KUCvPFGvvd/w1TMfM1zbTPDbpRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AKuzG8IN; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AKuzG8IN"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9d7464b71so354345a34.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782931705; x=1783536505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBSe02IJYN/TMgS7bk4uMJRY3rWTVEa0aWjrt+rH1dg=;
        b=AKuzG8IN7WIejScqYHN3/zLuFUilZDbw1BSHqTO0SRwOcKWf+Ry6H2SlMAPpZreA8I
         ojkK5kcfCrNE75SHnx9jP7OwScoEE/TalruftQKiCHIX+7KmbodNLd2m2e/P9CRma3El
         HTnYwKUp9j7Y42qFkLfQz6CKbXK6e8NLxtEjbc0SCrUgDMS+8meQmgLtmdp/xGUJwH4u
         zehk4OCXROzqSgSBI44IXUWM3qHTWu4YDHHloMSHbS5BvRBMzkpWe6mn1ceqRWjNILaz
         q94YOa926lABbu6/IldZqp2JEk2Atxt2Iu2yFWjR6Tej2xy1QUgc9Ks7k3hF0uHt0nle
         MkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931705; x=1783536505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBSe02IJYN/TMgS7bk4uMJRY3rWTVEa0aWjrt+rH1dg=;
        b=aqfKyI418vXjxkg2+mJ8Fds3RlQfn+1SxMyONq1HmxeoHE0cR6c7yZdfAP7GtftSwA
         Lkd3m/U0MgxobcPpih5OSw+xEp/BHPCvpWomZTZsqzGkdXv6rGf6v8xwiRWz6ddflUgi
         QUt/KDi3dilqsndqWU+sxCgOSvoNQRR3PunJojEa+25L+NyY5RTu97r1l++7aH5dMvlZ
         811Av+LF9bMOPYRSUBcfiDR3bnT7YuvQDKmIp3HvTTW4p6tQ4ReczUo6pYbipqjaU9hH
         g9aow9dhVwJNKhO5Uj2NehwzqHAP2h1XIwAEWqiUr8D6qm8nwgovmlwYZV7IqKOw42wu
         hWGA==
X-Forwarded-Encrypted: i=1; AFNElJ/N3nSaZ93/Bo+9FTupY+bemOFTeHjMdmN6Y6WbXbHnWzKgk5EZsh29Pbg9QV1F3Vaag95oCJ++SAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10N8xumatHlmPBEKX0s46nNk7Q6lfqTHg4Usuui8MBJe5/dkS
	rxoROJeAQAuNhU4lEpuTrpQiZhSCPkkQ6NM3u17RV9KoTqHIpw+5ma422p0WMVo3sAw=
X-Gm-Gg: AfdE7clxISGHT8fn9CJKIq3Cd5c32NCnxoVjhLoJXX/MTVFjLGwlhtIIOgUGaAySyge
	b7mjMdUj69ufOdiuSbDDeYgH4pDpl1n7ZDEyRxXPURL5p97fy8MeO52sGa315Q3uqoABx84h3SQ
	gXPXp7zEzjNbgaduDuFJFUJrqOHSd9Lb2phhglbN218vY+Sz07VRdF6R1Rs0HWGfreWqf6od9Hu
	5FjwOJ/J5BdlyQyDxciV4jYv56Xb6LVwczf+ByejMaj+dURm9JlbSGSpcV2d1i/02cNP0FN+FPw
	/3KlyiJTfP4MDdKaUKPjIjI/n7OyjHovgkWQeMw6xNadBwrQLbK/X7A/uCYrjL+9TFNtKA040rv
	uraxZEVVDiNgYuIReS/odDm9bDD6ui5/PZkN7LbJ8hQUhj4hL5/zJATEjCkelH4gfQtPzUNLd7K
	5wN/iiMgSXwKnROLGwOYq/abklzUPe9HvAY/b8Kd9+UoRfH0f+C+QW/MfLClhO
X-Received: by 2002:a05:6830:380f:b0:7dc:dd58:50b8 with SMTP id 46e09a7af769-7eb48b1b007mr1592458a34.13.1782931705380;
        Wed, 01 Jul 2026 11:48:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d4c1:7681:5df:9500? ([2600:8803:e7e4:500:d4c1:7681:5df:9500])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542f07basm728183a34.10.2026.07.01.11.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:48:25 -0700 (PDT)
Message-ID: <0bb77749-4aef-47dc-9107-a93b961a0187@baylibre.com>
Date: Wed, 1 Jul 2026 13:48:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: spi: Add spi,device-addr peripheral
 property
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
 linux-spi@vger.kernel.org
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
 <20260701-ad5529r-driver-v5-1-ed087900e642@analog.com>
 <20260701-immodest-carrot-611d255656b5@spud>
 <20260701192915.2fca6b06@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260701192915.2fca6b06@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Note that a few subsystems, including spi want the subject
to be `spi: dt-bindings:` rather than the other way around.

See https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html


On 7/1/26 1:29 PM, Jonathan Cameron wrote:
> On Wed, 1 Jul 2026 12:04:37 +0100
> Conor Dooley <conor@kernel.org> wrote:
> 
>> On Wed, Jul 01, 2026 at 08:40:39AM +0200, Janani Sunil wrote:
>>> Some SPI devices support sharing a single chip select across multiple
>>> physical chips by encoding a device address in the SPI frame itself.
>>> Add a generic spi,device-addr property to document this per-peripheral
>>> address. This property belongs in channel or sub-device nodes of
>>> peripherals that use this addressing scheme.
>>>
>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>>> ---
>>>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> index 880a9f624566..3774e8018355 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> @@ -142,6 +142,11 @@ properties:
>>>      minItems: 2
>>>      maxItems: 4
>>>  
>>> +  spi,device-addr:  
>>
>> To match other generic spi properties, s/,/-/.
>>
>> However, you don't actually use this as a spi peripheral's property in
>> your device binding, so you've got your wires crossed here somewhere.
> 
> If we are going to make this generic (which I'm not against) I think
> it should also work for the case of multiple independent devices.
> So it can also be a top level device node spi property.
> 
> That kind of makes me wonder if we are better off having it always
> in the top level node, but allowing multiple values to represent
> sub devices under this.  That would leave figuring out mappings of which
> channels are on which device to the driver. The driver must know the
> mapping afterall.  For the example something like
> 
> 
> #include <dt-bindings/gpio/gpio.h>
> spi {
>     #address-cells = <1>;
>     #size-cells = <0>;
>     dac@0 {
>         compatible = "adi,ad5529r-16";
>         reg = <0>;
>         spi-max-frequency = <25000000>;
> 
>         spi-device-addreses = <0 3>
> ...
> 
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         channel@0 {
>             reg = <0>;
>             adi,output-range-microvolt = <0 5000000>;
>         };
> 
>         channel@16 { #on second device using dev addr 3
>             reg = <16>;
>             adi,output-range-microvolt = <(-10000000) 10000000>;
>         };
>         channel@18 { #3rd channel on device using dev addr 3
>             reg = <18>;
>             adi,output-range-microvolt = <0 40000000>;
>         };
>     };
> };
> 
> Where devices are truely independent then you would have separate device
> nodes each with one entry in spi-device-addresses
> 
> I'm a bit dubious about putting this in the spi namespace though given
> it is not part of any standard specification.  Do we have any precedence
> for that sort of thing?

It seems like most SPI controllers/devices don't really follow any
standards, so I think there is plenty of precedence for a property
like this. It would be nice to see one or two more examples of SPI
peripherals with this feature though other than the one chip in
this series. Otherwise, I wouldn't try to make it a standard property.

I'm also in favor of making it an array and letting the device-specific
bindings decide what multiple devices with different addresses on the
same CS line means.

But... if we are leaving it up to devices to deal with the property rather
than the core SPI code, maybe it shouldn't be a standard SPI property.
Although, I suppose the core SPI code could parse the property and just
pass that information in the struct spi_device to let the device driver
do what it wants with it.

> 
> Jonathan
> 
>>
>> If it's a generic dac channel property (as you use it) it should be in
>> dac.yaml (or adc.yaml for the other device that I asked you to add it
>> for as proof of being generic), or it is a spi peripheral property and
>> needs to go into the dac node itself.
>>
>> pw-bot: changes-requested
>>
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Device address used when multiple peripherals share a single chip select.
>>> +
>>>    st,spi-midi-ns:
>>>      deprecated: true
>>>      description: |
>>>
>>> -- 
>>> 2.43.0
>>>   
> 

