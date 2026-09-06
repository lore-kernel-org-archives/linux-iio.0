Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411C3630AD
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725840; cv=none; b=CDjpNAjKGcznMppa0Jt7Bn2JwTlo+nYEccu1ZmF0MyXg9o/RLJ9iRHSO/EVyhkIuu7equPKsSqvwyUFwBTXHy2Sr1qZjDkp0RapsM2m09s3rCfrLh44qj2DzXSZZ9mV1AHdcnzG/VDg4SjsELqhatpZWWySFQ87IGx0KwNQnx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725840; c=relaxed/simple;
	bh=TUt4IgCxtrSPH172R2/R8p3roroqSOduOa+0501w83A=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=q1MUMrF4JL16IMngqVCRTrqv7/avb8R2w+CjQENSJgEcj0ynYJGhX6db1y475TTFVMaY2LJXdizYdYsemoAIgs6+QMa5GM37Ev454XCohef7RsjacElBKxvhpI9z+KYO/qsj+CIMRf8oOVFHkAr0043rQvLsZDotcAJ32zkI3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNBTDmmn; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNBTDmmn"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5c65093556aso2333280e0c.2
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788725838; x=1789330638; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FPcJdKOhEGIyKqoQExd+dXzrnHFFn879UVtG9q8zpck=;
        b=rNBTDmmn0gWyg8hXGmA9c0qKadTeXlz46B+np9BjS9WYNX8nWz448l9OYnxkyKR7FW
         lsRI3lAvE7IYSwCw6lrscRaDjg5HIhP18uOZBhC9ue6s7xN70HxkY96RDrhuf9ItrTdn
         g4XshRZIsltf0vNKng4e58VHY2wCZloQ7IqH3Ig3mREQSgGdEcMp2YnqRlCZg8G3K41g
         StVHCV1+04JKbt+EmtRM30iwoxMKShJyucXEHr9zo1HRY0CtfyoubdDzg82SegZxR3PZ
         6QM8wWZvM2vm2La28fQXATLQORw1ODcO+X07FE5dKs5vCwUJQ4oliP2G2kZbUL/wIrOh
         LzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788725838; x=1789330638;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPcJdKOhEGIyKqoQExd+dXzrnHFFn879UVtG9q8zpck=;
        b=qAWwNwfQpWDEJaoRx0JlqP6jzTmAwmbPDNVnWAdcXeIYsHJNpWX/CUjpithkvPc0Hj
         N6KYKnuDLsZcitLAk5fS+VjLtcwxXS7WacxUN8QlJ2IexzfO4ZVC4DB2Z2z7FPf09YVZ
         XLpmAkMRGfDdLsRIVUfCc6fm4/c3lS0fowa2K5VxmsmmYnbYC0GrX7fJ7fCtzughjH1E
         YdHczpa0WkjTHElO8ch89L9/xO8/cU0xI3zXLp0nw2uXEoHsQBPRxRX5/Eq0mx7dig3K
         lYeqIoRqOBCbD4qniHtWV/aZqox+Cop+BPQUGYANWiS40K+aZVbjSC0vx77BoL2shQre
         ofUw==
X-Forwarded-Encrypted: i=1; AKwUvBw1OExpiTZq8sDvlviq8GsC48Anx8/RnGgChVRRuigKBuu3oZ7oyq7KQX/MfONF/Uk0qzXgj8pwszQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mUWybggxUw9JaJmqqDmJVEfX1l1cxv7O3Vkh3nLFR4HFFtNRdK
	hkbgemyOr6rnGncX+EWBJhdCT+mZLxSbxYeB2QDTRrfeg2a7hNESF4Ze
X-Gm-Gg: AYBFou38Mzd49GF8ls3hJEhXPNnjpuLcGaZr5Wk0lz1Wtp/cLzwQzvyEO0xpLl8DQkJ
	RWP8nPGkjnUUKdBaIAiWWuYRR3x1mXX/o3YA6TcGADy1KPCamKscF/6x2cVdYH4F1qxED9cr1j0
	Y6w6/fJRTbp1ZIYoTELYlEZdr3FFm2zoSLtCm08NO+DtsUmAEZxWZUjaX86mG38URbmOExfygKu
	fodJLdBnL0IxwgjBdSrpt8Pb+n72WEE9O3RtZ1XQaAG2OKlhDo2tvfP1nKaD6lCAE29OcdXxItD
	m0YYNDbHsaU4rXY5AUQEtk46Zvz/d9yZLvU3u+fkYgvBi9RdOLhkV7ThYQHbRxAUeJvLdGSCQ5t
	Bhhf3G0TOWaC+7msq7lLTBcVDz2TYykUEgDmv2H4a6qi6KxBDNqG45xed+h+iZASmrozfkrfDkK
	5lvnZnC845sBhCwQ4xcoVLXYdQmCRScspKTsZ7R2bCnF5lNhEByQ==
X-Received: by 2002:a05:6102:f8a:b0:786:c86c:8fe4 with SMTP id ada2fe7eead31-78a4ab73095mr7872878137.13.1788725838086;
        Sun, 06 Sep 2026 13:17:18 -0700 (PDT)
Received: from localhost ([2800:40:44:f1f5:f400:4c49:91c1:9905])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47a76512sm5832057137.4.2026.09.06.13.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 13:17:17 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 17:17:13 -0300
Message-Id: <DL8IDZLLS2KT.31M9BO759E5H0@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/10] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
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
 <aae42329-f531-41fc-80df-2cb5e445f1db@baylibre.com>
In-Reply-To: <aae42329-f531-41fc-80df-2cb5e445f1db@baylibre.com>

On Mon Aug 31, 2026 at 4:44 PM -03, David Lechner wrote:
> On 8/28/26 1:38 AM, Kurt Borja wrote:
>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
>> integrated PGA, internal reference, excitation and burn-out current
>> sources for sensor biasing and diagnostics. The ADS1263 is compatible
>> with ADS1262, but includes a second auxiliary ADC (ADC2) to perform main
>> channel (ADC1) cross-checking measurements, system background
>> measurements, or temperature compensation of the primary sensor.
>>=20
>
> ...
>
>> +  '#io-channel-cells':
>> +    minimum: 1
>> +    maximum: 2
>> +    description: |
>> +      The first cell selects the channel by its reg. The second cell se=
lects
>> +      between the main ADC (ADC1) and the auxiliary ADC (ADC2) as follo=
ws:
>> +        0: ADC1
>> +        1: ADC2
>> +
>
> I like the suggestion to make this always 2 cells. Makes it simpler. And
> to put ADC first.
>
> And maybe make the first cell take 1, 2 so we don't have to make the
> translation?

Sure!

>
>
>
>> +  "^channel@[0-9a-f]+$":
>> +    $ref: /schemas/iio/adc/adc.yaml#
>> +    unevaluatedProperties: false
>> +
>
> ...
>
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: ti,ads1263
>> +    then:
>> +      properties:
>> +        '#io-channel-cells':
>> +          minimum: 1
>> +          maximum: 2
>> +      patternProperties:
>> +        "^channel@[0-9]+$":
>
> These don't match the pattern above (missing a-f).
>
>> +          properties:
>> +            reference-sources:
>> +              minItems: 3
>> +              maxItems: 3
>> +              default: [internal-p, internal-n, internal]
>> +    else:
>> +      properties:
>> +        '#io-channel-cells':
>> +          const: 1
>> +      patternProperties:
>> +        "^channel@[0-9]+$":
>> +          properties:
>> +            reference-sources:
>> +              minItems: 2
>> +              maxItems: 2
>> +              default: [internal-p, internal-n]
>> +
> With those fixed...
>
> Reviewed-by: David Lechner <dlechner@baylibre.com>

Thanks David!

--=20
Thanks,
 ~ Kurt
