Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8963B38AB
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886618; cv=none; b=vEyyPcD1c96DYAdaD+e8g0Eos16xUg1R3RQsPkq790aTsyoHxiVX8i787tlnCH1h5SRiH/E6kIQTgnTPWLhnupWn3R0aZqaMnkj8Ps4J/CdqpU3lYf7KpU+nZ6wL3VEcwRvQ6d13bVUTANErc2PwY+RXbLR2Uj035NPvYODxrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886618; c=relaxed/simple;
	bh=yLny9Oo5ygSGxXMDCqqJ84ZrkVTKGlCSpmfbiKfOxSI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=s/exKP2KzQeZuWR5PmuQUA/4Sj1slo8mOGbXQdEzzwlkTbuNzlhApttyx6iWAzYPvsHGnmqmsGdLaL78RIuoWh0+zuqCXntQb+qnWm+g0PujxRPf8eneLiQASRZdUHIBfbtvn8OUuy+Oz4SlAdm2KvccIcwR8pJm+ESQUhDL+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mie9dauJ; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mie9dauJ"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6f0a59f3f2dso703809137.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781886616; x=1782491416; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI9N8WhKWNuQ+iNu2XOLZ6LLsDb3M+ticUkoUHtAqY4=;
        b=Mie9dauJLIFhxhLchQ+3vnr7/m/kp16v9EnnuuqEhFeF4lUkMJVlmcfNVFYJfyiOoc
         34jjZNiBQ5ivNhtS0VFnbOjhwHcjaglTB9FWsHS76iKTNHUVd3WKyf6tXcmI4Ooz7wTT
         OEOAe+fXTuNSqmh9FDGjP8JkZCUJAnBswP3/Jz1e2mWVWq7FaeWjBHD5M51wzriL/6CO
         GQWVysmR/JgSTxHInEnHNg1aOSTl8n4GTZO4QpLXTJzfephM40ngAVEXljAxD2gdmlsx
         roTD9D+HzXk4cs8AmHaAcZAcNPpVJaxwalHVU5uD1z7+FF70RSaWdVkNP1VlIM2l2qLi
         w8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781886616; x=1782491416;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SI9N8WhKWNuQ+iNu2XOLZ6LLsDb3M+ticUkoUHtAqY4=;
        b=fowz5mnNOTVZ7Q93g1OHqvPLRtbQiqhctrUCJ/CE8lzlx+gzn7NNA2LwBCGXxXtaFR
         Ofks+F/dJDTmhArBTV8eHx0HkIOzlaD5ysW5vYWdhxw32qPSwYNnFx9VTlwazeeuVRPl
         4eAgEykZKLJ4LEqc71QKzas6hCB+qRMuLzGbvn/A96dvQyPyPnmG8vXmzARamR3ieYs9
         JjwNOT2Da8z9hJHnKZM+c1I9OYa/PoH/M48WZJ5DsUdMCyULzGM/CMJBiOp7uByEXVqi
         7JdSLxgz3k2w+unJppcrUR6z2Lq6jqrR2OyTDvf1Pbmn+wT2sCTdwqCtCxSxCbys5Pfq
         lMVQ==
X-Forwarded-Encrypted: i=1; AFNElJ90gwWOkSt9FvMC6bsMc8mjW4QFbXHjbgrgK2oBn6Ts2C8k6k7nrIgjk70/30oqIRlxL8H1O++w4yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhz7iiMEDNbMHkSBT480JNhTpYA7XFgOSLeUJWlZlOdpVVVQu
	o/J0leNRJtO3/ekxm60jLqCBZUa6ECZ7S9nyoIpEB7xG1yKNhJ9S3SU1
X-Gm-Gg: AfdE7cm3IiIw7mz0QpMvpV1Vz/d3q6LNCJHqGOkUOLgHuzEvS2KvEbus32i2UOcG43X
	2WMYiy/aDmgYfNiSAcjDbWnNLZN0+WAjazDRecnbf/9gdGbPgrHyOHJ1pZL6or762PGNejvcTlm
	P3W14TMBb4u+Zu4NUWesI0PAbKH+cQkoAd19GHS0lfVqiQ3FUgjvd/UYtisO1c9wjPvEL08w+D5
	6y4TwgauTS/UvGj0NgavY3sPyQvxs2ebQ8sSXgEMDWQTOTAtJIyByGH3Mpyb6znrCDBQgFH1+VY
	Rh0Cz7Y6lNE0+yAF0nzOW0A67dN43LKg+rDjO+UMDlYka7j+yJHSeipcIzo3OLpZXxAGEs/Fslk
	h/qqcJGMBX76NyZeTak3BxuI7MLjrV12vwhhIuoTphz8Lg88Vz+bAwlTStMGR0IF8Q6PKDOkP5M
	8/l30=
X-Received: by 2002:a05:6102:418d:b0:631:3b92:9dcc with SMTP id ada2fe7eead31-72a046d7006mr3098192137.27.1781886615888;
        Fri, 19 Jun 2026 09:30:15 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-72a34811039sm2060855137.6.2026.06.19.09.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 09:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 11:30:08 -0500
Message-Id: <DJD633458PP7.204THMW74YY30@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] dt-bindings: iio: adc: Add reference-source
 property
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Conor Dooley" <conor@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
 <20260618-new-channel-props-v1-1-963c1b5cf40a@gmail.com>
 <20260619-proton-distract-de92d6b9b600@spud>
In-Reply-To: <20260619-proton-distract-de92d6b9b600@spud>

Hi Conor,

On Fri Jun 19, 2026 at 9:14 AM -05, Conor Dooley wrote:
> On Thu, Jun 18, 2026 at 07:33:01PM -0500, Kurt Borja wrote:
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
> I have no idea from this description what this actually refers to. Is it
> a pin? A supply? A channel?

It can be pins but also can be internal vref sources. Not always a
supply though, in some applications a resistor is connected to the
reference source pins.

If there is a next version I'll clarify it.

>
>> +
>>  anyOf:
>>    - oneOf:
>>        - required:
>>=20
>> --=20
>> 2.54.0
>>=20

--=20
Thanks,
 ~ Kurt
