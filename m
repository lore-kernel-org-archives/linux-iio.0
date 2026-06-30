Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F93815D6
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793313; cv=none; b=skBueufNlHZDsfi+gEERagiV3o2GcYUczQzVeNmSbq5B1VrFYs9piHFJo/ndO+/eYjRnujfc8/RlxW2RCgh6zD9RNwCT6Hz6kypkV6KTqPAvLJCurXLnHfesqvOVIok2DV8pmq0T3ez8rE4G8bQ8Vlv/1T60kydB9WEty5RaxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793313; c=relaxed/simple;
	bh=lTFy5RM7kse8CAnreFw3LhsSXH2A6ONRbsuB1B52vAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bM30oNQTStKVZ+Bs4wZrWn0lIUYSj2m8T85JJv+Xl56w0axpgukzBmMS3CkTsZemh+z6kWemH5fWEhL/OC1knss/ZXlKgmBXAyMJu9SXFMH7xYz/xWNyMUR2kZ6zZFYhYj+FFYn9jJsnfRiXx202lwAwtPeQ42iOIGpOLnmkgcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5JC82Vl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5JC82Vl"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8478fe07f65so754969b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 21:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793312; x=1783398112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTFy5RM7kse8CAnreFw3LhsSXH2A6ONRbsuB1B52vAo=;
        b=q5JC82VltzjwKQhzmNMeUv9rd4F0TAMek22DsWyTIXuJdd4L0D5yhSXfXOuhsJY9oJ
         zyQ+/FJUYeuTIB4kRP/G1FGQnHJF4NvLbGcHxZA8Rn5uGdEyUk1CNCMRcQJESUzcenoa
         IbOG8QR+QeJhTvq8i8MuX53wi8xW36HS6KxpmaHBrxDkGtC0IiskxWvqJG5poXpsH2tF
         /VN6k5B5BKmO7ojNVAQ37at0mN02y41Fp4fT3sDw5+hvRQjn52xXIY/Q2V8TBBDbRGPu
         5BqJ95khlT75rJ9CjYPjmT83oRFs0KVdnji+AN5mowlLld8mSOB/LLkh8KZot9iHvf5B
         wy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793312; x=1783398112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTFy5RM7kse8CAnreFw3LhsSXH2A6ONRbsuB1B52vAo=;
        b=Vya9nV276tYNVZHCpCR6obmmtcbcdWIfr4zF+lvx5S0BBrT/fLMc64EyNhud2Ey2NC
         Sb4CKLgDf1RnIXjnRIkpC8yEuCDKEV8hyw9vjMO329DS5M/HmA4fTbqUSSfAMXWWqawz
         +PRbEil7jM15Sqt6lTYGqkMP9n3QB82FT9G4f30cJUjWcbegFLoxsJzwhf9oYFot+6AY
         M4kOzDnCF3OPe5896vmeTDDb40jOHX2wjHmf5XtFxGjLKVyC0tD7Mqurh/clhtc1CuSW
         I0gdR/V7Whk6+k0z+Tzwn+QQbPMqO5JZYQQnm1pgluhwDv4jQW5W+fw1rea0stmwjJuY
         Yp4w==
X-Forwarded-Encrypted: i=1; AHgh+RoJ1K8n5QnCGD+0JGpdt4EjvmjD8ztGwPBUyl3A1z91P5dV2dIFJNDKsnbeiPRXw5FncCq6V8Uu2ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwU+yXXoHXu3S/TraH2CFI23SDGZw06ea4A1ZhdpN1xgle6iyX
	yU0NRUMTSueGrib3175lhiWtMzWsD10Nt8K7RaMCK2oLpHmpKhzGW+cv
X-Gm-Gg: AfdE7clyH57vKULimDmquyJsYwh7ZZi/StGoKIueDvEL/Uk67J4BfSS43xpUqbsVvbS
	7qjaisdRJynA7vcmLD8/feXikIPxrHMqUzhW5ILz5lEPYQq5I16ctqaeINlQ7aytyC8Zx+FSGBn
	2J+hvfp8jUsT2gE+xQuiqJYx2mUhMaNr0LSinEWSUG3MYk+o4DYKPfWLqLDCXAIqB3u3IQr/GHa
	mwU2HhbPYCefhnHQw2jrj9tAR94Bug6ju6rbm/54VL3swsZGd1G+Llywsf7R8KzgwxKHDEEfOcp
	8Jh2b1z4nPRlf0sxBVXxfu7OFqVlluNJe7NhcQ6cspt/smVQP/q2lzodtamLvgPnYupCEffcjon
	hVVVqg4GOcUITpVoigvggjxyGmJo1dBs/T5MYtl5UQpU6Np4kxbpd7x9jHQkT5MWD8jehvPxZv2
	ykLHqUpsgzw/2EtgoB8y9+HSjNRh7DjKbQ+qPjljAPxzA2h/O7mxeCPQzS87U+L1+P
X-Received: by 2002:a05:6a00:b481:b0:845:e97d:447e with SMTP id d2e1a72fcca58-8479f109a34mr1696830b3a.26.1782793311792;
        Mon, 29 Jun 2026 21:21:51 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ff8c781sm950012b3a.9.2026.06.29.21.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 21:21:50 -0700 (PDT)
Message-ID: <5c788984-1bf7-422d-a808-e05112615966@gmail.com>
Date: Tue, 30 Jun 2026 12:21:48 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
 <20260625110638.38438-2-cwweng.linux@gmail.com>
 <40485b4e-6585-42a1-9b84-3019328574c5@baylibre.com>
 <7e96cc1a-eb60-4eeb-937d-64e83bc35279@gmail.com>
 <2f01a3a0-3698-41e6-8fee-1d2e1629726c@baylibre.com>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <2f01a3a0-3698-41e6-8fee-1d2e1629726c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

Thanks for the clarification.

 > We always want the devicetree to be as complete as possible even
 > if the drier doesn't use all of the information.
 >
 > So for trivial/well-known bindings like dmas, we should be able to
 > add it now.

Understood. I will add optional DMA properties in v2.

The hardware supports PDMA for EADC transfers, so I will describe it in
the binding even though the initial driver does not use DMA yet.

I plan to add:

   dmas:
     maxItems: 1

   dma-names:
     const: rx

These properties will not be required.

 > Same reasoning as above, we want the binding to be as complete as
 > possible, so we should not omit diff-channels since we know what
 > the bindings should look like already.

Understood. I will keep diff-channels in the binding.

I will still limit the DT child channel nodes to the external ADC input
channels 0 to 7, since channel 8 is the fixed internal VBAT input and
does not describe board wiring.

For differential inputs, I will keep diff-channels in the channel child
node schema and restrict it to valid external ADC input channels. I will
also check the hardware-supported differential pair constraints and
encode them in the schema if the hardware only supports fixed pairs.

For v2, I will update the binding to:
- allow up to four interrupt entries for ADINT0 to ADINT3,
- add optional vref-supply,
- add optional dmas and dma-names,
- keep diff-channels,
- limit DT child channel nodes to external channels 0 to 7,
- keep the internal VBAT channel out of the DT child nodes.

Thanks,
Chi-Wen

