Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707A3BFAEE
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887355; cv=none; b=REtP6gDOdLqBRCkKReETmWZ9kSzj67oaeBp1M1haM9D5FUM5ZFVE+jc8M2sPuLCjQDfDoANhS/oQg5Gicxs7wRJxeaUWN2sg8R6Z3ZbGv/lnpgYIPZP9H3BqxE2xuKqYRpwnrEQt2F9OoB4tlU5ZVrphTxHovSHOI8d8U6ylbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887355; c=relaxed/simple;
	bh=lGqfVqHp7IgOCm986NUub13iFYVxwSczQ/I5pqbghkw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=YPpUBwJIpfBjxqSa00ipO2u4sSVJ5wKWOBSeMHqzIXo1huELsGEPZFWFxTAZuYNIMmde8A0+8jAB5vd+jkdyIMv/3KgZVW0zhSCgSBUeotKp3hWdZm+XBnQgE7xAH8aZoz5LGfRmyNu7ftJXLp55BLErgaUltQFfugMgzOso0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCreRhUP; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCreRhUP"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59d07df448bso1646430e0c.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781887353; x=1782492153; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELZL/C7i8kxA2LaFSzCmmxgMq2wx5Z7M2LGJVxqtl+c=;
        b=lCreRhUPzagKcqEsaOttBoKjADYn1NVL5Mtd5MI52uBy9J8zp19/YlcXq1iBxqrk8/
         FwkaCjlB4Q0n9EVXt9IoojBNI4/V9gnqmVC43dEU/dN9HAI3Nzc07OMAL3VHbdwaSZNu
         PtjPDzGk05XuozAerzp3s5xfp9pPmtDk+my+uIGECbPS8sd/BMolIAMwOI8qjyf1vxsw
         +uT9bVj+4sBOY6X2RU0mh1Gq1mx3FCqt6H+8CU21UTow35/BZ3NschMZggB7UeVBat+g
         tsn0gtBPCir6fs2tX1+7BZszXTuCFtLmyv9ZX30jvQkYoXIM7C3s8sZZLi66VDjZWlcK
         K91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781887353; x=1782492153;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELZL/C7i8kxA2LaFSzCmmxgMq2wx5Z7M2LGJVxqtl+c=;
        b=K7ZAu3MErypnVU4f8StE0ZoWLy6ffa43qIVHlFu/yHeTHM3baPUUTssxBDB9evFUkV
         o6OjnnVml7v4/Y4Iwwp1A5skpZrpCli8aqgb519fvCMclIj/jslc9rIh7Ob/AYeK41Uh
         yev0jUj0iy1E26Y4nkI1PnL0X4wZiujUSawcq4yAc3uHNIjnG1WVOmvzyGw+5lKaI22q
         aubwqikzDratZ3snCS+i0OsSCqmvj4nOb+M7YZc6n2OaD9pdQZ+wo6W+D7t1jhQcTJqv
         wfTxiCiG62C7Hsh5pi1Vdo06DQfDEXcmDHtGjTnuDE5FIZr3zXlMFNNcoN/qeLCl7QF8
         sapA==
X-Forwarded-Encrypted: i=1; AFNElJ9IeQ7h9sXkoVDWfd1lFhGTTFLfCVYQm9vl587/fk9U35fQUr9VpjCYoBiL23V7TZiHjyQKfRyXrp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAAz1Z4Dp+c2i9It3+UmZ7WoqjiAvRRC3fVZl1GsiR65Y+nHu
	sHp4QRF9rwuQCMMygWj9CYlMmxFWCOLC8L/MWuT213xJBSu23DGRtf/i
X-Gm-Gg: AfdE7cnIRIYKRD1FR2V+8KsFRsnLzN6ZVv7dSvfuJE3xa9xw4urNdn/J8w5DLPBqXXS
	uUNFtQE6j5KJ1m8JvDs8TMW9TwbBwTZYM+atDcIg9o8mvi34OHCDoXTW5gvXUJfq7igJ7VuOHSg
	UEtETot4B++P4XwESJMD6rS0t3yGNj1LIFXMYkESFM3z3xw7W90jdg5UJ64K7ymkqiWGhNEjtlT
	vJguCJW0piRpeNF/mkqVc3e7CFsz/5jjWYIsAQ8u2hiK2DrXoNCm7giS0DYcKyF+pba3GLvO5wF
	d1cNkw9vgIvFFUsI4a+bnwA+l1dM64Li1P33I0ohDW1c+4Q6DaCd3ImSrCXoH2ZsF6Pu0WHr2Ph
	/lywdC3M68sKd7lt9OMywzv1vr8PxJcuCVez8E1QgxJJyNTpT5iH3Opwwag+t2O6u6Id77YjLxT
	7pWuc=
X-Received: by 2002:a05:6122:7cf:b0:5a0:3d17:f939 with SMTP id 71dfb90a1353d-5bbebbd1400mr2477614e0c.9.1781887352797;
        Fri, 19 Jun 2026 09:42:32 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfb7d30besm151445e0c.2.2026.06.19.09.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 09:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 11:42:25 -0500
Message-Id: <DJD6CHX9XQT1.2WS9V7TOWJUIT@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] dt-bindings: iio: adc: Add reference-source
 property
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
 <20260618-new-channel-props-v1-1-963c1b5cf40a@gmail.com>
 <736962f9-50b9-4884-88b1-94bfd7cd8abf@baylibre.com>
In-Reply-To: <736962f9-50b9-4884-88b1-94bfd7cd8abf@baylibre.com>

On Fri Jun 19, 2026 at 9:24 AM -05, David Lechner wrote:
> On 6/18/26 7:33 PM, Kurt Borja wrote:
>> Some ADCs have configurable voltage reference sources for each channel.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Docume=
ntation/devicetree/bindings/iio/adc/adc.yaml
>> index b9bc02b5b07a4c..c74c2084fdb68c 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> @@ -73,6 +73,16 @@ properties:
>>        device design and can interact with other characteristics such as
>>        settling time.
>> =20
>> +  reference-source:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    maxItems: 2
>> +    minItems: 1
>> +    description:
>> +      Indicates the voltage reference source or sources for this channe=
l.
>> +
>> +      This array describes either a single reference source or a positi=
ve and
>> +      negative reference sources.
>
> Do you actually know of any devices that allow independently selecting
> the positive and negative sources? I don't think I've ever seen anything
> like that.

The ADS1262 allows it, check the REFMUX register. Only ADC1 allows it
though, ADC2 has a single reference select.

Maybe I can get away with only one for both ADCs without restricting too
much.

> Also, this should be string, not uint32.

Sure!

>
>> +
>>  anyOf:
>>    - oneOf:
>>        - required:
>>=20

--=20
Thanks,
 ~ Kurt
