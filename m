Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400E262D0B
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782673940; cv=none; b=QSjDu3iO42zEsilCfdpHenX0+VYkResY7H7wnYrKhCNAgVa5jWUI6TROQhcFzqw8TqC/HNmzPhEtBxi2whEnNwcQX9DPNasqIIp3lZWHZAyjkJvkTtw73J+38x4VVYTshPjdEAijXUFVl5m9RAAdCY5D5xqlDubEl+tQE1lzT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782673940; c=relaxed/simple;
	bh=uzKxSs3wj1DDWn6PbTpyv8n4uSRPDLJ0qpblP5/KdJ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=qpOxhHLZ2utzFhzt7ZIfLkMRrptfkGtqX6d3Krl0yXNUURZiHbL2LTIDf0HI7qZQXOPKjifEOJPcVVeRI9NMqBQlmwJH25tldcmapXH7donn62uj5PMMgfBqrI4InHyyQ6O+xDdhYG8zKVSubnGEkSTWP5VPxFw8JO/Qv2nuZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0xEbb8S; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0xEbb8S"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59d4aa96ef2so2181933e0c.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782673936; x=1783278736; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei3Ybn1q5xfL7SskkyqusuhsxEuAlE8rA0GsK7EjwwY=;
        b=Y0xEbb8S4SyN32t7mmG3LfB2vBJScfnqn1nHLZ002zHdqwiabJ5h04EA9BDZhdvkzE
         xEidXP3VBDGnFO7JQkCk92tHEDuFYdvpQirB0+cexrlUtJtN7zZnrNeDHFXdkzNkCwco
         eJNH3IE2YQuptoGUXbXhD2mPLS8A1RrIO7wxfBhTXdeR+t+ng2sh7L9WTc6+iGq6xfZW
         9zeldUYNYGRl0VHDzBOm1HuwlvkWAJb/J/Qm5E92BmPXqHHXiriV5cfWwru8exCWmtah
         d27/Spf4RjELuefxtkKdvOmTRBd9N2BvjlkvOvNczFeIwkRMQXwUySCc8IBHB2NCRhRD
         o3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782673936; x=1783278736;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ei3Ybn1q5xfL7SskkyqusuhsxEuAlE8rA0GsK7EjwwY=;
        b=b0Xps/Gab6dn+gtgn5ClLum8VIZ94dEQ7N+Dgprm5Ub6Qz2P09539eLP0oyuYOQC1t
         YIgh3xSLyYIVdYT0ZOUFy3EqE5m9jEMDpDO7IZRnardzKuegJwX0JYKp5qiJAFpWsRjb
         OB4AJcaBPd60VQwRZrEm37LYjvckKZ42rKh6VcHl2SYkqb2iyFALmuL0zqf+mRLPo9PS
         kxwxNPgQI7o2t8Je7STvh7562i5vUKMuk3asXbiYT56e9c7umlH+wLjiT2dgPZvjTlSG
         zUJrJQd0Kt5/vu7GTTAO87kAmdAoU1ZWSnFZY8QWAf5NSo3fUHEbnmRhEWX34/LRMhCU
         tYCw==
X-Forwarded-Encrypted: i=1; AHgh+RqMt6Z8v1zYq3p47hQkvVdZueYhqgAZBIV7PqlUvUvnDdZUDNkThnMC9GL3/weOWlWnpnB91w8gKiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUE9KaYTVchMm0SL6NVp6R9IdGfRCxAlbqz5AvXlFwa2hYLW1
	pH1+cpBtgOsmdVGJMa2vOWWaySHT9HpaZF7jlFEtnp73uBNIEqw+4l38
X-Gm-Gg: AfdE7ckDcpEV0n9z18SpV1ZadA64QhM1fkFYPwRok5kyvcdYV5qkAcSosj87sjIcPNv
	Sl0b18ERgRk8vVfAULAjY+BLyqtds4aPEiEMNZz05mGYa9/OgY4wbTgfIcPxHpJcUe2NzgA9RFF
	huLDPYBqcNlGkQ/Zl7pYt3pwT/K11s6t2hUR2Whk7MTBijwREN+a/gOYoTmmraS+V5OZmQ5DLo9
	TgHrJsRNc2fQPAcRzLCaOBJpGlPnmwlCheH6S8uwy0N3y2CVEvtS7xzHgPmIjZRsl4womhzxOIr
	nIERprgFusHwgw7FaR+IlLWbjaXDIS7cvQJKQX0U65mRRD/5yzPgdgJd8nKfoXAz+BKl16KQPrW
	WlQcsNht8hv/mcnf4M1cn9dF6/NihDVUANM1wZDoQ9zZVLz0LTfx9RAdfPqqdA+mDpACkmOXzw4
	mSGFQ=
X-Received: by 2002:a05:6122:180c:b0:5bd:a810:b08e with SMTP id 71dfb90a1353d-5bda810b657mr579128e0c.4.1782673936489;
        Sun, 28 Jun 2026 12:12:16 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd917b6138sm2227258e0c.10.2026.06.28.12.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 12:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Jun 2026 14:12:06 -0500
Message-Id: <DJKX600ONL4O.1YUTCD1L9FU8F@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add TI ADS126x ADC family
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-1-4b1b231325ba@gmail.com>
 <946a30c9-01e9-42f1-bd2b-b7934fda85cf@baylibre.com>
In-Reply-To: <946a30c9-01e9-42f1-bd2b-b7934fda85cf@baylibre.com>

On Sun Jun 28, 2026 at 10:45 AM -05, David Lechner wrote:
> On 6/28/26 12:36 AM, Kurt Borja wrote:
>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
>> integrated PGA, internal reference, excitation and burn-out current
>> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
>> 24-bit delta-sigma ADC (ADC2) for background measurements.
>>=20
>> Each can configure it's own voltage reference source, the two excitation
>> current sources (IDAC), plus input and excitation channels rotation for
>> offset and IDAC mismatch cancellation. This lets the device drive and
>> ratiometrically measure RTDs and other resistive sensors.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  .../devicetree/bindings/iio/adc/ti,ads1262.yaml    | 309 ++++++++++++++=
+++++++
>>  MAINTAINERS                                        |   6 +
>>  2 files changed, 315 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b=
/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
>> new file mode 100644
>> index 0000000000000000..2f4e812ae2af135a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
>> @@ -0,0 +1,309 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1262.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI ADS1262/ADS1263 analog to digital converter
>> +
>> +maintainers:
>> +  - Kurt Borja <kuurtb@gmail.com>
>> +
>> +description: |
>> +  The ADS1262 and ADS1263 are 38.4-kSPS, delta-sigma (=CE=94=CE=A3) ADC=
s with an
>> +  integrated PGA, reference, and internal fault monitors. The ADS1263 i=
ntegrates
>> +  an auxiliary, 24-bit, =CE=94=CE=A3 ADC intended for background measur=
ements.
>> +
>> +  Datasheets:
>> +    - ADS126x: https://www.ti.com/lit/ds/symlink/ads1262.pdf
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: ti,ads1262
>> +      - items:
>> +          - const: ti,ads1263
>> +          - const: ti,ads1262
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  spi-max-frequency:
>> +    maximum: 8000000
>> +
>> +  spi-cpha: true
>> +
>> +  interrupts:
>> +    description: Data ready (DRDY) interrupt line.
>> +    maxItems: 1
>
> Technically, there are two pins with the DRDY signal, so we should have
> two interrupts in order to be able to tell which one is wired up.

Oh you're right. I'll describe both here. I may not add support for it
though, at least until I complete everything else.

>
>> +
>> +  start-gpios:
>> +    description: Start conversion control.
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  dvdd-supply:
>> +    description: Digital power supply.
>> +
>> +  avdd-supply:
>> +    description: Analog power supply.
>> +
>> +  refp-supply:
>> +    description: External positive voltage reference.
>> +
>> +  refn-supply:
>> +    description: External negative voltage reference.
>> +
>
> Which pins are these? I see 4 possible external reference sources,
> but all go through the AINx pins. So I would expect:
>
> 	refp1-supply, refn1-supply, refp2-supply, refn2-supply,
> 	refp3-supply, refn3-supply, refp4-supply, refn4-supply

I tried to go for a simpler route, but I agree with this.

>
> Also, similar to the chip I am working on, I expect that these pins
> could be connected to a resistor rather than a voltage source, so
> could use additional bindings for that.

Sure!

>
>
>> +  ti,vbias:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: Enables the level-shift voltage on the AINCOM pin.
>
> VBIAS is a voltage source, so I would expect that to be modeled
> as a regulator provider. (If we do that REFOUT should be included
> as well.)

I didn't think about that, I agree.

>
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  '#io-channel-cells':
>> +    minimum: 1
>> +    maximum: 2
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +
>> +  gpio-controller: true
>> +
>> +patternProperties:
>> +  "^channel@[0-9]+$":
>> +    $ref: /schemas/iio/adc/adc.yaml#
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        maxItems: 1
>> +
>
> If we want to allow single-ended/pseudo-differential inputs, then we shou=
ld
> also allow single-channel (positive pin) and common-mode-channel (negativ=
e
> pin) properties.
>
> This will also require additional common-mode-<N>-supply properties to al=
low
> for the negative pin connected to something other than GND.

Ah interesting. Why the N though? wouldn't a single supply connected to
AINCOM be enough here?

>
>> +      diff-channels:
>> +        description: |
>> +          Selects the analog input configuration for this channel. The =
first
>> +          value is the positive input and the second is the negative in=
put.
>> +          The following values are available:
>> +          0: AIN0 pin
>> +          1: AIN1 pin
>> +          2: AIN2 pin
>> +          3: AIN3 pin
>> +          4: AIN4 pin
>> +          5: AIN5 pin
>> +          6: AIN6 pin
>> +          7: AIN7 pin
>> +          8: AIN8 pin
>> +          9: AIN9 pin
>> +          10: AINCOM pin
>
>> +          11: Temperature sensor monitor
>> +          12: Analog power supply monitor
>> +          13: Digital power supply monitor
>> +          14: TDAC test signal
>
> These are all internal signals, so not sure it makes sense to have
> them in the devicetree. It would make more sense to have fixed
> channels defined in the driver for these since they are always there.

Similar to the approach you took.

>
> We probably also need a separate property (a bool/flag?) to say that
> this channel is a TDAC output rather than an analog input. Although
> that is for testing, so maybe something to omit for now until we
> actually have an application that uses it (to make sure we get it
> right)?

Yes, I will add the monitor channel for this too. The users can adjust
voltage from debugfs. IMO that should be enough.

>
>
>> +          15: Float (open connection)
>
> How could we have a differential input with one or both pins open?
> Likely this will just be the setting for pins not specified as something
> else in the devicetree.

I should remove this too. Leaving the pins floating is necessary when
calibrating. I will add full automatic calibration on probe right after
this series.

[...]

>> +      ti,idac-chopping:
>
> I would call this ti,excitation-channel-chopping to match the excitation-=
channel
> property. Or since this isn't a generic property, call it ti,idac-rotatio=
n to
> match the datasheet.

Both are fine by me. I went with chopping based on what you said about
the term in your series.

>
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +        description:
>> +          Automatically swap the IDAC1 and IDAC2 connections of alterna=
te
>> +          conversions. The ADC averages the alternate conversions to el=
iminate
>> +          IDAC mismatch.
>> +
>> +      ti,pga-bypass:
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +        description: Bypass the Programmable Gain Amplifier (PGA).
>
> Why would this need to be a DT property? I didn't read this datasheet
> too much, but in other chips I have seen there are usually rules that
> PGA has to be bypassed under certain conditions, but not others, so
> this seems like something for the driver to handle rather than the
> devicetree.

To be honest, I don't know what would be the application for this. AFAIK
when the PGA is bypassed the analog inputs are read unbuffered (?) In
that case shouldn't this belong DT?

[...]

--=20
Thanks,
 ~ Kurt
