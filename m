Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1A37FF75
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725806; cv=none; b=gjNtXlcN4/rvb94vqFFSDFlBAzi1chRexXbhx2rU89nk17D0W796M8R8nRmEH3wHHi4vnfNMWQ3XqPxf1dfwirpWtacpvtiXw17Ifbo7dZ0rsf7F9/qWL9mtRsuXu2tTfkZhDK9IQ5kxqzLIdMuXSXysUcPu8jETkf1YNRxlKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725806; c=relaxed/simple;
	bh=gqUGNJDAb1yI8v9pL6RTCkYxnBV64avTbwEfdCG0eBM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=a9tbXd9kMdjynfsLMQPE9Tpm9nFrI8aE9BNz3ppt/JOmqHjrfd6KTyn4qhem+REiMP5NJMNiYsvBs2jA0hCVxApZXw065VlBWi36kdLEXFIGhvm8/IUlxvNQz6uYQkkdFglV0r4+oLV3+1Xh5hspsqOPYqEM0Hs75vIu+PYraIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky0/VdzK; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky0/VdzK"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so2729286e0c.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788725802; x=1789330602; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ad616E7Mfeiy4C3sRfgAcvBobdI1RZYsaLcBMh2jcP0=;
        b=ky0/VdzKFVPwwVm14Qx6hJZtE2km7es3Km8p8wGW2B3loEhpbryE5Wllf+Bo/QojBn
         8Rd4duZyzXS6s0mlJIc6eYCkxzh9b+xDM1zafMQ4xr22XHlx+7VPIOR0fM42mHKPhG6P
         X6BqcKWmzCufHTpb5rRCBor1g3ntoZPdQ/nD49Zb9d65GS6ClBFSgRksdr2+RLZvtx49
         bAlNuD1ZE/3Lgiam8WsI8Fe3krAUn1+P66eE6Sgk4aZAkI2U20HTE8hWsGDC/Y1+BCmj
         ftpFK+uXVDB5icXsP1eNPOu4OoijnG85vR5/63Z09Rjl9CAkaZWoi9MFyI89rBpqyRvx
         I2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788725802; x=1789330602;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ad616E7Mfeiy4C3sRfgAcvBobdI1RZYsaLcBMh2jcP0=;
        b=rcfasI1Ni/9YJsmCUq5aDvDWKMFTwK3n+IolaHxlMYKk4/xHA3q1wjssvJ8uCWZWTN
         zkgUSUXByRsykIdnzgdQG5/JGomETsqge1Wtlke3QnKOvjagf+xQBjZrBQuJ182hVR39
         ZzfQCCWHo8lCo1CTpQS7o8vFELzc1dnuwsWCqW8CLUt1PFbgQDP1rJNJZJYSMflfhJGB
         WJUcL6M4w0QJ4H86TIKFM02/tXUzmrSPi8y8VEebAL5982Svrxk8/A7CHqHBeOFxdCc3
         HGCqzKxcJevPc3UtxZfMeuGOXpyBIYZreUFvItc5Mw9AKNv5AO0SX9PT9w84eCthcol3
         QqWA==
X-Forwarded-Encrypted: i=1; AKwUvByE1NWA7bgfFbPs4G7IOIVLPDMPa3slCz6ZKv2ia0s6C/wCxaKbY5qHFzJiK1UUDwkz8U1zYeMwyzg=@vger.kernel.org
X-Gm-Message-State: AFuF++lzHKmTqpS5In2S91kK10jbZkPdfPKG2ePNvRT8KYQXmhRgt4yv
	PKQyqvtMYvUVjaegrDwo9QkW+bZ2TCDDfz6cBnUfS4P6l0CEyQlA72wF
X-Gm-Gg: AYBFou05ypiiBISptrQuwBg+UJATOpsfrILNd9A9Tou5l5hgyqnCkBipizMXAAkIKu2
	7EBkFxTtvg7WquPZWg0COvMx+wmXaylz8xKLONav9VEGrBuYdS8uglfpami5cQIg1+ejIaN6vu5
	0JaZZ8/36Wg2pNxKX0lUSN+oLjD900QOSGiU2gZDBVGD1T0T6wQ85X2Ql87rrj3M9PlxYHNZImw
	+KmAabBviE1piTnB+k/3EG2ueCkiJ9Blbxt6sp5O9Wu2E8Bto8H0TE/WgjHSBekHcLGDgGKLQM4
	0fvPxh9l2w5t7bPpNnK9t2rYcau+3EknmAtQSpgA/12eNXaGPuYnN7EC5/pCOpEA0oXWtvFjFce
	O8gkAhs9nxiuUlc3hZEVNqav2bEOpkIH2asQvTyD95TYYRzMR+My4BsqY5KXU8wx5mDcMO8XimU
	For4krWCxJQNzEOQ1QVw4a/RGhd50cDoSwTDxPb7oyggbflzEeFQ==
X-Received: by 2002:a05:6122:8f8b:b0:5c2:b01f:e503 with SMTP id 71dfb90a1353d-5c7ed81a4femr9514678e0c.7.1788725802270;
        Sun, 06 Sep 2026 13:16:42 -0700 (PDT)
Received: from localhost ([2800:40:44:f1f5:f400:4c49:91c1:9905])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec24254fsm6363883e0c.10.2026.09.06.13.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 13:16:41 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 17:16:37 -0300
Message-Id: <DL8IDJ54V16N.QE5U3SI9J87Y@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/10] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Conor Dooley" <conor@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>
 <20260828-cartel-willow-9592e4e8b912@spud>
In-Reply-To: <20260828-cartel-willow-9592e4e8b912@spud>

On Fri Aug 28, 2026 at 1:39 PM -03, Conor Dooley wrote:
> On Fri, Aug 28, 2026 at 01:38:17AM -0500, Kurt Borja wrote:
>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
>> integrated PGA, internal reference, excitation and burn-out current
>> sources for sensor biasing and diagnostics. The ADS1263 is compatible
>> with ADS1262, but includes a second auxiliary ADC (ADC2) to perform main
>> channel (ADC1) cross-checking measurements, system background
>> measurements, or temperature compensation of the primary sensor.
>>=20
>> Both parts can configure per-channel voltage reference source,
>> excitation current sources (IDAC), plus input and IDAC chopping for
>> offset and IDAC mismatch cancellation. This lets the device drive and
>> ratiometrically measure RTDs and other resistive sensors.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  .../devicetree/bindings/iio/adc/ti,ads1262.yaml    | 376 ++++++++++++++=
+++++++
>>  MAINTAINERS                                        |   6 +
>>  2 files changed, 382 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b=
/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
>> new file mode 100644
>> index 000000000000..7e26572388e4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
>> @@ -0,0 +1,376 @@
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
>> +    minItems: 1
>> +    maxItems: 2
>> +    description: Data ready (DRDY) interrupt lines.
>> +
>> +  interrupt-names:
>> +    description:
>> +      The data ready (DRDY) signal has two independent interrupt lines.=
 A
>> +      dedicated DRDY pin and a pin shared with the serial interface MIS=
O pin,
>> +      which is called DOUT/DRDY.
>> +    minItems: 1
>> +    maxItems: 2
>> +    items:
>> +      enum: [drdy, doutdrdy]
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
>> +    description:
>> +      Analog power supply. In bipolar supply configurations, the report=
ed
>> +      voltage should be in reference to DGND.
>> +
>> +  avss-supply:
>> +    description:
>> +      Negative analog power supply for bipolar configurations. AVSS can=
 only be
>> +      at or below the ground reference (DGND). If not described, AVSS i=
s assumed
>> +      to be connected to ground (0V).
>> +
>> +  clocks:
>> +    maxItems: 1
>
> clock doesn't appear mandatory, what does it do?

Its not mandatory because the chip has an internal clock too. If an
external clock is wired, the chip also has an autodetection mechanism
so we just describe it here so we can enable it.

>
>> +
>> +  '#io-channel-cells':
>> +    minimum: 1
>> +    maximum: 2
>
> What's the use case for actually setting this as a single cell? Kinda
> confused by it.

As Jonathan said this is part dependent but we can also just make it
'const: 2' and validate the second cell's value.

>
> Otherwise, quite frankly, the binding is too complicated for me! I'll
> have to leave it up to the IIO folks to cover whether what's being done
> is sane.
>
> Cheers,
> Conor.

...

--=20
Thanks,
 ~ Kurt
